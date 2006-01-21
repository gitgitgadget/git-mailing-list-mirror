From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH] minor git-reset and git-commit documentation fixes
Date: Sat, 21 Jan 2006 18:54:11 -0500
Message-ID: <E1F0SYd-0005iu-UY@puzzle.fieldses.org>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 22 00:55:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0SZP-0000Zt-8Q
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 00:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWAUXyR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 18:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWAUXyR
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 18:54:17 -0500
Received: from mail.fieldses.org ([66.93.2.214]:46011 "EHLO
	puzzle.fieldses.org") by vger.kernel.org with ESMTP
	id S1751227AbWAUXyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 18:54:16 -0500
Received: from bfields by puzzle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1F0SYd-0005iu-UY; Sat, 21 Jan 2006 18:54:11 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15029>

Minor copyediting of recent additions to git-commit and git-reset documentation

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

---

 Documentation/git-commit.txt |    2 +-
 Documentation/git-reset.txt  |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

18d55bf231ae7116e0f0c4da144de46fe0cb2cbf
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index e35984d..72f96fc 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -27,7 +27,7 @@ OPTIONS
 -a|--all::
 	Update all paths in the index file.  This flag notices
 	files that have been modified and deleted, but new files
-	you have not told about git are not affected.
+	you have not told git about are not affected.
 
 -c or -C <commit>::
 	Take existing commit object, and reuse the log message
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 315683a..b4e737e 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -147,8 +147,8 @@ and resets the tip of the branch to that
 
 Interrupted workflow::
 +
-You can get interrupted by an ungent fix request while you are
-still in the middle of a large change.  The files in your
+Suppose you are interrupted by an urgent fix request while you
+are in the middle of a large change.  The files in your
 working tree are not in any shape to be committed yet, but you
 need to get to the other branch for a quick bugfix.
 +
@@ -164,8 +164,8 @@ $ git reset --soft HEAD^ ;# go back to W
 $ git reset <3>
 
 <1> This commit will get blown away so a throw-away log message is OK.
-<2> This removes the 'WIP' commit from the commit history, and makes
-    your working tree in the state just before you made that snapshot.
+<2> This removes the 'WIP' commit from the commit history, and sets
+    your working tree to the state just before you made that snapshot.
 <3> After <2>, the index file still has all the WIP changes you
     committed in <1>.  This sets it to the last commit you were
     basing the WIP changes on.
-- 
0.99.8b-g58e3
