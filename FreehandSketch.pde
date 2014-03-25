import geomerative.*;

RPoint mousePos = new RPoint();

RPath p;
RGroup g = new RGroup();
RStyle s = new RStyle();

int gridSize = 25;
int snappingThreshold = 10;

void setup() {
	size(500, 500, P2D);
	RG.init(this);
	
	background(255);

	s.setFill(false);
	s.setStroke(color(255, 0, 0));
	s.setStrokeWeight(3);

	g.setStyle(s);
}

void draw() {
	background(255);
	mousePos = new RPoint(mouseX, mouseY);
	RPoint sp = getSnappingPoint(mousePos);

	drawGrid();

	strokeWeight(3);
	stroke(255, 0, 0, 50);
	point(mousePos.x, mousePos.y);
	stroke(255, 0, 0);
	point(sp.x, sp.y);

	// sketch
	if (mousePressed) {
		
		if (p == null) p = new RPath(sp);
		else p.addLineTo(sp);

		// RPoint sp = getSnappingPoint(mousePos);
		// println(mousePos.x, mousePos.y);
		// println(sp.x, sp.y);
	}

	if(p != null) {
		//RG.ignoreStyles(false);
		//p.draw();
		if(g.countElements() > 0) g.removeElement(0);
		g.addElement(p.toShape());
		g.draw();
	}
}

void drawGrid() {
	strokeWeight(1);
	stroke(0, 20);
	for (int i = gridSize; i < width; i += gridSize) {
		line(i, 0, i, height);
	}
	for (int i = gridSize; i < height; i += gridSize) {
		line(0, i, width, i);
	}
}

RPoint getSnappingPoint(RPoint p) {
	for (int i = gridSize; i < width; i += gridSize) {
		for (int j = gridSize; j < height; j += gridSize) {
			if (p.x > i - snappingThreshold && p.x < i + snappingThreshold
				&& p.y > j - snappingThreshold && p.y < j + snappingThreshold) {
				return new RPoint(i, j);				
			}
		}
	}
	return p;
}

void keyPressed() {
	if (key == 's' && p != null) {
		
		RSVG svg = new RSVG();
		svg.saveGroup("p.svg", g);
		println("saved");

	}
}