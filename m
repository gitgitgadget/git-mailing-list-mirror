From: Jon Loeliger <jdl@jdl.com>
Subject: [PATCH] Rewrite synopsis to clarify the two primary uses of git-checkout.
Date: Fri, 17 Mar 2006 18:26:01 -0600
Message-ID: <E1FKPGb-00062a-QC@jdl.com>
X-From: git-owner@vger.kernel.org Sat Mar 18 01:26:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKPHB-0006qF-1V
	for gcvg-git@gmane.org; Sat, 18 Mar 2006 01:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWCRA0V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Mar 2006 19:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWCRA0V
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Mar 2006 19:26:21 -0500
Received: from www.jdl.com ([66.118.10.122]:17037 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S932281AbWCRA0U (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Mar 2006 19:26:20 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1FKPGb-00062a-QC
	for git@vger.kernel.org; Fri, 17 Mar 2006 18:26:02 -0600
To: git@vger.kernel.org
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17680>


Fix a few typo/grammar problems.

Signed-off-by: Jon Loeliger <jdl@jdl.com>


---

 Documentation/git-checkout.txt |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

3a8c8dc1832fcffe58cdc4894959f67d91c6a924
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 556e733..dc821bb 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -7,15 +7,18 @@ git-checkout - Checkout and switch to a 
 
 SYNOPSIS
 --------
-'git-checkout' [-f] [-b <new_branch>] [-m] [<branch>] [<paths>...]
+[verse]
+'git-checkout' [-f] [-b <new_branch>] [-m] [<branch>]
+'git-checkout' [-m] [<branch>] <paths>...
 
 DESCRIPTION
 -----------
 
-When <paths> are not given, this command switches branches, by
+When <paths> are not given, this command switches branches by
 updating the index and working tree to reflect the specified
 branch, <branch>, and updating HEAD to be <branch> or, if
-specified, <new_branch>.
+specified, <new_branch>.  Using -b will cause <new_branch> to
+be created.
 
 When <paths> are given, this command does *not* switch
 branches.  It updates the named paths in the working tree from
@@ -29,17 +32,17 @@ given paths before updating the working 
 OPTIONS
 -------
 -f::
-	Force an re-read of everything.
+	Force a re-read of everything.
 
 -b::
 	Create a new branch and start it at <branch>.
 
 -m::
-	If you have local modifications to a file that is
-	different between the current branch and the branch you
-	are switching to, the command refuses to switch
-	branches, to preserve your modifications in context.
-	With this option, a three-way merge between the current
+	If you have local modifications to one or more files that 
+	are different between the current branch and the branch to
+	which you are switching, the command refuses to switch
+	branches in order to preserve your modifications in context.
+	However, with this option, a three-way merge between the current
 	branch, your working tree contents, and the new branch
 	is done, and you will be on the new branch.
 +
@@ -82,7 +85,7 @@ $ git checkout -- hello.c
 ------------
 
 . After working in a wrong branch, switching to the correct
-branch you would want to is done with:
+branch would be done using:
 +
 ------------
 $ git checkout mytopic
-- 
1.2.4.gdd7be
