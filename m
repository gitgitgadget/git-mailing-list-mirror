From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: [EGIT PATCH] Remove unnecessary semicolon.
Date: Sat,  2 Feb 2008 00:24:07 -0200
Message-ID: <1201919047-10822-1-git-send-email-rogersoares@intelinet.com.br>
Cc: robin.rosenberg@dewire.com,
	"Roger C. Soares" <rogersoares@intelinet.com.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 03:18:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL7xo-0000VA-ST
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 03:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757333AbYBBCR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 21:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756872AbYBBCR5
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 21:17:57 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1413 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755827AbYBBCR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 21:17:56 -0500
Received: (qmail 6748 invoked by uid 0); 2 Feb 2008 00:20:23 -0200
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.604066 secs); 02 Feb 2008 02:20:23 -0000
Received: from unknown (HELO localhost.localdomain) (189.5.222.172)
  by cvxbsd.convex.com.br with SMTP; 2 Feb 2008 02:20:22 -0000
X-Mailer: git-send-email 1.5.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72208>

Signed-off-by: Roger C. Soares <rogersoares@intelinet.com.br>
---
 .../egit/core/internal/mapping/GitFileHistory.java |    1 -
 .../src/org/spearce/jgit/lib/GitIndex.java         |    2 +-
 .../org/spearce/jgit/lib/TopologicalWalker.java    |    2 +-
 .../src/org/spearce/jgit/lib/WorkDirCheckout.java  |    2 +-
 4 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
index 9e683a5..adf422d 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
@@ -232,7 +232,6 @@ public class GitFileHistory extends FileHistory implements IAdaptable {
 					}
 				else
 					activeDiffLeafId = ObjectId.zeroId();
-					;
 			}
 
 			Collection<IFileRevision> githistory;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
index bdcb71a..1fbd7f7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
@@ -653,7 +653,7 @@ public class GitIndex {
 			if (updateNeeded)
 				flags |= 0x4000;
 			else
-				flags &= ~0x4000;;
+				flags &= ~0x4000;
 		}
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/TopologicalWalker.java b/org.spearce.jgit/src/org/spearce/jgit/lib/TopologicalWalker.java
index 16af0c6..0e937cb 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/TopologicalWalker.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/TopologicalWalker.java
@@ -54,7 +54,7 @@ public class TopologicalWalker extends Walker {
 			super(repostory, starts, relativeResourceName, leafIsBlob,
 					followMainOnly, merges, activeDiffLeafId);
 			this.returnAll = returnAll;
-			topoSorter = new TopologicalSorter<ObjectId>() {;
+			topoSorter = new TopologicalSorter<ObjectId>() {
 				@Override
 				protected boolean filter(ObjectId element) {
 					return returnAll ? true : collected.containsKey(element);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WorkDirCheckout.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WorkDirCheckout.java
index 6159469..3dde864 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WorkDirCheckout.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WorkDirCheckout.java
@@ -124,7 +124,7 @@ public class WorkDirCheckout {
 		}
 	}
 
-	ArrayList<String> conflicts  = new ArrayList<String>();;
+	ArrayList<String> conflicts  = new ArrayList<String>();
 	ArrayList<String> removed = new ArrayList<String>();
 
 	protected Tree head = null;
-- 
1.5.3.7
