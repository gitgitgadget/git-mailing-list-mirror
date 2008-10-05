From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 6/6] Comment the getId method and hint for copy to actually get an ObjectId
Date: Mon,  6 Oct 2008 01:36:42 +0200
Message-ID: <1223249802-9959-7-git-send-email-robin.rosenberg@dewire.com>
References: <1223249802-9959-1-git-send-email-robin.rosenberg@dewire.com>
 <1223249802-9959-2-git-send-email-robin.rosenberg@dewire.com>
 <1223249802-9959-3-git-send-email-robin.rosenberg@dewire.com>
 <1223249802-9959-4-git-send-email-robin.rosenberg@dewire.com>
 <1223249802-9959-5-git-send-email-robin.rosenberg@dewire.com>
 <1223249802-9959-6-git-send-email-robin.rosenberg@dewire.com>
Cc: spearce@spearce.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 06 01:39:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmdCC-0003Jr-UM
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 01:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbYJEXh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 19:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbYJEXhz
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 19:37:55 -0400
Received: from av6-2-sn3.vrr.skanova.net ([81.228.9.180]:36646 "EHLO
	av6-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbYJEXhy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 19:37:54 -0400
Received: by av6-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id E84C438594; Mon,  6 Oct 2008 01:37:52 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av6-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 7DBF5385B0; Mon,  6 Oct 2008 01:37:52 +0200 (CEST)
Received: from localhost.localdomain (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id 6217137E44;
	Mon,  6 Oct 2008 01:37:52 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1.310.gf789d0.dirty
In-Reply-To: <1223249802-9959-6-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97552>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/revwalk/RevObject.java    |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java
index 451205c..2209c04 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java
@@ -67,6 +67,7 @@ abstract void parse(RevWalk walk) throws MissingObjectException,
 
 	/**
 	 * Get the name of this object.
+	 * See {@link #copy()} to really get a copy
 	 * 
 	 * @return unique hash of this object.
 	 */
-- 
1.6.0.1.310.gf789d0.dirty
