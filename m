From: Jon Loeliger <jdl@jdl.com>
Subject: [PATCH] Call out the two different uses of git-branch and fix a typo.
Date: Fri, 17 Mar 2006 18:24:37 -0600
Message-ID: <E1FKPFF-00061q-4Y@jdl.com>
X-From: git-owner@vger.kernel.org Sat Mar 18 01:25:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKPFr-0006gf-U1
	for gcvg-git@gmane.org; Sat, 18 Mar 2006 01:25:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWCRAY4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Mar 2006 19:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWCRAY4
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Mar 2006 19:24:56 -0500
Received: from colo.jdl.com ([66.118.10.122]:15501 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S932152AbWCRAYz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Mar 2006 19:24:55 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1FKPFF-00061q-4Y
	for git@vger.kernel.org; Fri, 17 Mar 2006 18:24:37 -0600
To: git@vger.kernel.org
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17675>


Signed-off-by: Jon Loeliger <jdl@jdl.com>


---

 Documentation/git-branch.txt |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

1a4336ee2a807d4ccc23d97c7b5c2dce2d4ef116
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 4cd0cb9..71ecd85 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -7,16 +7,20 @@ git-branch - Create a new branch, or rem
 
 SYNOPSIS
 --------
-'git-branch' [(-d | -D) <branchname>] | [[-f] <branchname> [<start-point>]]
+[verse]
+'git-branch' [[-f] <branchname> [<start-point>]]
+'git-branch' (-d | -D) <branchname>
 
 DESCRIPTION
 -----------
 If no argument is provided, show available branches and mark current
 branch with star. Otherwise, create a new branch of name <branchname>.
-
 If a starting point is also specified, that will be where the branch is
 created, otherwise it will be created at the current HEAD.
 
+With a `-d` or `-D` option, `<branchname>` will be deleted.
+
+
 OPTIONS
 -------
 -d::
@@ -39,7 +43,7 @@ OPTIONS
 Examples
 ~~~~~~~~
 
-Start development off of a know tag::
+Start development off of a known tag::
 +
 ------------
 $ git clone git://git.kernel.org/pub/scm/.../linux-2.6 my2.6
-- 
1.2.4.gdd7be
