From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 4/4] Switch usage of AnyObjectId.toString() to new AnyObjectId.name()
Date: Wed,  3 Sep 2008 23:28:14 +0200
Message-ID: <1220477294-23268-2-git-send-email-robin.rosenberg@dewire.com>
References: <20080903170438.GA28315@spearce.org>
 <1220477294-23268-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org, Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Thu Sep 04 00:00:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb0P4-0002iS-Fh
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 00:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbYICV7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 17:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbYICV7g
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 17:59:36 -0400
Received: from av12-1-sn2.hy.skanova.net ([81.228.8.185]:52235 "EHLO
	av12-1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbYICV7f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 17:59:35 -0400
X-Greylist: delayed 1728 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Sep 2008 17:59:35 EDT
Received: by av12-1-sn2.hy.skanova.net (Postfix, from userid 502)
	id 9652437F7D; Wed,  3 Sep 2008 23:30:46 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av12-1-sn2.hy.skanova.net (Postfix) with ESMTP
	id 79FC637EDE; Wed,  3 Sep 2008 23:30:46 +0200 (CEST)
Received: from localhost.localdomain (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id 61C3537E4D;
	Wed,  3 Sep 2008 23:30:46 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1.161.g7f314
In-Reply-To: <1220477294-23268-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94860>

Two more places

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../spearce/jgit/lib/T0005_ShallowSpeedTest.java   |    2 +-
 .../org/spearce/jgit/lib/T0006_DeepSpeedTest.java  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit.test/exttst/org/spearce/jgit/lib/T0005_ShallowSpeedTest.java b/org.spearce.jgit.test/exttst/org/spearce/jgit/lib/T0005_ShallowSpeedTest.java
index 3b8c60a..736e363 100644
--- a/org.spearce.jgit.test/exttst/org/spearce/jgit/lib/T0005_ShallowSpeedTest.java
+++ b/org.spearce.jgit.test/exttst/org/spearce/jgit/lib/T0005_ShallowSpeedTest.java
@@ -60,7 +60,7 @@ public void testShallowHistoryScan() throws IOException {
 				break;
 			ObjectId parentId = parents[0];
 			commit = db.mapCommit(parentId);
-			commit.getCommitId().toString();
+			commit.getCommitId().name();
 			++n;
 		}
 		assertEquals(12275, n);
diff --git a/org.spearce.jgit.test/exttst/org/spearce/jgit/lib/T0006_DeepSpeedTest.java b/org.spearce.jgit.test/exttst/org/spearce/jgit/lib/T0006_DeepSpeedTest.java
index 684bfba..f480b99 100644
--- a/org.spearce.jgit.test/exttst/org/spearce/jgit/lib/T0006_DeepSpeedTest.java
+++ b/org.spearce.jgit.test/exttst/org/spearce/jgit/lib/T0006_DeepSpeedTest.java
@@ -62,7 +62,7 @@ public void testDeepHistoryScan() throws IOException {
 			commit = db.mapCommit(parentId);
 			TreeEntry m = commit.getTree().findBlobMember("net/netfilter/nf_queue.c");
 			if (m != null)
-				commit.getCommitId().toString();
+				commit.getCommitId().name();
 			++n;
 		}
 
-- 
1.6.0.1.161.g7f314
