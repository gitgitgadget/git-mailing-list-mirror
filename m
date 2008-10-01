From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 3/3] Align commit text properly in jgit glog
Date: Wed,  1 Oct 2008 21:31:33 +0200
Message-ID: <1222889493-12736-4-git-send-email-robin.rosenberg@dewire.com>
References: <20081001143815.GV21310@spearce.org>
 <1222889493-12736-1-git-send-email-robin.rosenberg@dewire.com>
 <1222889493-12736-2-git-send-email-robin.rosenberg@dewire.com>
 <1222889493-12736-3-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Oct 01 21:34:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl7Sh-0007Lh-ES
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 21:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753792AbYJATcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 15:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753808AbYJATcm
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 15:32:42 -0400
Received: from av9-1-sn3.vrr.skanova.net ([81.228.9.185]:48645 "EHLO
	av9-1-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198AbYJATcl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 15:32:41 -0400
Received: by av9-1-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 4964238535; Wed,  1 Oct 2008 21:32:39 +0200 (CEST)
Received: from smtp3-2-sn3.vrr.skanova.net (smtp3-2-sn3.vrr.skanova.net [81.228.9.102])
	by av9-1-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 1601F38522; Wed,  1 Oct 2008 21:32:39 +0200 (CEST)
Received: from localhost.localdomain (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-2-sn3.vrr.skanova.net (Postfix) with ESMTP id E9A1937E47;
	Wed,  1 Oct 2008 21:32:38 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1.310.gf789d0.dirty
In-Reply-To: <1222889493-12736-3-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97258>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../org/spearce/jgit/awtui/AWTPlotRenderer.java    |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/awtui/AWTPlotRenderer.java b/org.spearce.jgit/src/org/spearce/jgit/awtui/AWTPlotRenderer.java
index dc785ec..b6b715c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/awtui/AWTPlotRenderer.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/awtui/AWTPlotRenderer.java
@@ -109,10 +109,10 @@ protected void drawBoundaryDot(final int x, final int y, final int w,
 
 	@Override
 	protected void drawText(final String msg, final int x, final int y) {
-		final int texty = g.getFontMetrics().getHeight()
-				- g.getFontMetrics().getDescent();
+		final int texth = g.getFontMetrics().getHeight();
+		final int y0 = y - texth/2 + (cell.getHeight() - texth)/2;
 		g.setColor(cell.getForeground());
-		g.drawString(msg, x, texty - (cell.getHeight() - y * 2));
+		g.drawString(msg, x, y0 + texth - g.getFontMetrics().getDescent());
 	}
 
 	@Override
-- 
1.6.0.1.310.gf789d0.dirty
