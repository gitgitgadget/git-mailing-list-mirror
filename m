From: alex@bandlem.com (Alex Blewitt)
Subject: [EGIT PATCH] Removal of dead code
Date: Sun, 26 Apr 2009 21:55:06 +0100 (BST)
Message-ID: <20090426205506.BC46ADBF31@apple.int.bandlem.com>
To: alex.blewitt@gmail.com, git@vger.kernel.org,
	robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Apr 27 10:59:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyBPf-0007HP-1S
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 22:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbZDZUzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 16:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752994AbZDZUzM
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 16:55:12 -0400
Received: from server.bandlem.com ([217.155.97.60]:34688 "EHLO
	apple.int.bandlem.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752191AbZDZUzL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 16:55:11 -0400
Received: by apple.int.bandlem.com (Postfix, from userid 1000)
	id BC46ADBF31; Sun, 26 Apr 2009 21:55:06 +0100 (BST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117615>

>From ee933d31d2ca4a4270aa9f4be6e60beec388e8af Mon Sep 17 00:00:00 2001
From: Alex Blewitt <alex.blewitt@gmail.com>
Date: Sun, 26 Apr 2009 21:51:17 +0100
Subject: [PATCH] Removed dead code

---
 .../preferences/GitDecoratorPreferencePage.java    |   32 --------------------
 1 files changed, 0 insertions(+), 32 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/GitDecoratorPreferencePage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/GitDecoratorPreferencePage.java
index eca2277..185f242 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/GitDecoratorPreferencePage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/GitDecoratorPreferencePage.java
@@ -727,18 +727,6 @@ public void inputChanged(Viewer viewer, Object oldInput, Object newInput) {
 			// No-op
 		}
 
-		public Color getBackground(Object element) {
-			return getDecoration(element).getBackgroundColor();
-		}
-
-		public Color getForeground(Object element) {
-			return getDecoration(element).getForegroundColor();
-		}
-
-		public Font getFont(Object element) {
-			return getDecoration(element).getFont();
-		}
-
 		public String getText(Object element) {
 			final PreviewDecoration decoration = getDecoration(element);
 			final StringBuffer buffer = new StringBuffer();
@@ -869,12 +857,6 @@ public boolean isAssumeValid() {
 
 		private ImageDescriptor overlay = null;
 
-		private Font font;
-
-		private Color backgroundColor;
-
-		private Color foregroundColor;
-
 		/**
 		 * Adds an icon overlay to the decoration
 		 * <p>
@@ -903,15 +885,12 @@ public IDecorationContext getDecorationContext() {
 		}
 
 		public void setBackgroundColor(Color color) {
-			backgroundColor = color;
 		}
 
 		public void setForegroundColor(Color color) {
-			foregroundColor = color;
 		}
 
 		public void setFont(Font font) {
-			this.font = font;
 		}
 
 		public ImageDescriptor getOverlay() {
@@ -934,16 +913,5 @@ public String getSuffix() {
 			return sb.toString();
 		}
 
-		public Font getFont() {
-			return font;
-		}
-
-		public Color getBackgroundColor() {
-			return backgroundColor;
-		}
-
-		public Color getForegroundColor() {
-			return foregroundColor;
-		}
 	}
 }
-- 
1.6.2.2
