From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 02/28] Use die utility method in glog
Date: Thu, 17 Jul 2008 21:43:55 -0400
Message-ID: <1216345461-59382-3-git-send-email-spearce@spearce.org>
References: <1216345461-59382-1-git-send-email-spearce@spearce.org>
 <1216345461-59382-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 03:45:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJf2H-0005th-Ox
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 03:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757486AbYGRBo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 21:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757655AbYGRBo2
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 21:44:28 -0400
Received: from george.spearce.org ([209.20.77.23]:46938 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757017AbYGRBoY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 21:44:24 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 8BF2E383A5; Fri, 18 Jul 2008 01:44:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id B851F38351;
	Fri, 18 Jul 2008 01:44:22 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.3.569.ga9185
In-Reply-To: <1216345461-59382-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88951>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/pgm/Glog.java             |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/Glog.java b/org.spearce.jgit/src/org/spearce/jgit/pgm/Glog.java
index 984b6d8..fbc5218 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/pgm/Glog.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/Glog.java
@@ -110,7 +110,7 @@ class Glog extends RevWalkTextBuiltin {
 	@Override
 	protected RevWalk createWalk() {
 		if (objects)
-			throw new Die("Cannot use --objects with glog");
+			throw die("Cannot use --objects with glog");
 		final PlotWalk w = new PlotWalk(db);
 		w.sort(RevSort.BOUNDARY, true);
 		return w;
-- 
1.5.6.3.569.ga9185
