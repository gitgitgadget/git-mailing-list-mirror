From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: [JGIT PATCH] Drop obsolete MyIndexTreeVisitor from test code
Date: Fri, 22 Aug 2008 22:51:50 +0200
Message-ID: <200808222251.50869.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 22:54:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWdeV-0000MT-7P
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 22:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388AbYHVUxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 16:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752362AbYHVUxb
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 16:53:31 -0400
Received: from av9-2-sn2.hy.skanova.net ([81.228.8.180]:53896 "EHLO
	av9-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109AbYHVUxb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 16:53:31 -0400
Received: by av9-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id 3890938158; Fri, 22 Aug 2008 22:53:29 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av9-2-sn2.hy.skanova.net (Postfix) with ESMTP
	id 1C47538013; Fri, 22 Aug 2008 22:53:29 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id 0E18B37E42;
	Fri, 22 Aug 2008 22:53:29 +0200 (CEST)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93363>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../org/spearce/jgit/lib/IndexTreeWalkerTest.java  |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/IndexTreeWalkerTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/IndexTreeWalkerTest.java
index d0c6581..c7c283e 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/IndexTreeWalkerTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/IndexTreeWalkerTest.java
@@ -120,19 +120,6 @@ public void testIndexOnlySubDirs() throws IOException {
 		assertEquals("foo/bar/baz", indexOnlyEntriesVisited.get(1));
 	}
 	
-	public class MyIndexTreeVisitor extends AbstractIndexTreeVisitor {
-		public ArrayList<String> visits = new ArrayList<String>();
-		public void visitEntry(TreeEntry treeEntry, TreeEntry auxEntry,
-				Entry indexEntry, File file) throws IOException {
-			visits.add(file.getPath());
-		}
-	
-		public void visitEntry(TreeEntry treeEntry, Entry indexEntry, File file)
-				throws IOException {
-			visits.add(file.getPath());
-		}
-	}
-	
 	public void testLeavingTree() throws IOException {
 		GitIndex index = new GitIndex(db);
 		index.add(trash, writeTrashFile("foo/bar", "foo/bar"));
-- 
1.6.0.rc2.35.g04c6e9
