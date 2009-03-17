From: "David J. Mellor" <dmellor@whistlingcat.com>
Subject: [PATCH 4/4] Documentation: minor grammatical fixes in git-branch.txt.
Date: Mon, 16 Mar 2009 23:16:17 -0700
Message-ID: <1237270577-17261-4-git-send-email-dmellor@whistlingcat.com>
References: <1237270577-17261-1-git-send-email-dmellor@whistlingcat.com>
 <1237270577-17261-2-git-send-email-dmellor@whistlingcat.com>
 <1237270577-17261-3-git-send-email-dmellor@whistlingcat.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 17 07:21:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjSfE-0004Lb-Ut
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 07:20:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762570AbZCQGS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 02:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758357AbZCQGSz
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 02:18:55 -0400
Received: from quartz.whistlingcat.com ([67.223.228.111]:40002 "EHLO
	quartz.whistlingcat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756208AbZCQGSt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 02:18:49 -0400
Received: from whistlingcat.com (whistlingcat.com [99.12.234.57])
	by quartz.whistlingcat.com (Postfix) with ESMTP id 488B248800C;
	Mon, 16 Mar 2009 23:18:47 -0700 (PDT)
Received: from sandstone.whistlingcat.com (sandstone.whistlingcat.com [192.168.0.2])
	by whistlingcat.com (Postfix) with ESMTP id 68F7C38E7574;
	Mon, 16 Mar 2009 23:18:45 -0700 (PDT)
Received: by sandstone.whistlingcat.com (Postfix, from userid 500)
	id 1C50B17A63; Mon, 16 Mar 2009 23:16:18 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <1237270577-17261-3-git-send-email-dmellor@whistlingcat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113423>


Signed-off-by: David J. Mellor <dmellor@whistlingcat.com>
---
 Documentation/git-branch.txt |   50 +++++++++++++++++++++---------------------
 1 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 6103d62..7f7b781 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -18,19 +18,19 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-With no arguments, existing branches are listed, the current branch will
+With no arguments, existing branches are listed and the current branch will
 be highlighted with an asterisk.  Option `-r` causes the remote-tracking
 branches to be listed, and option `-a` shows both.
 
-With `--contains`, shows only the branches that contains the named commit
-(in other words, the branches whose tip commits are descendant of the
+With `--contains`, shows only the branches that contain the named commit
+(in other words, the branches whose tip commits are descendants of the
 named commit).  With `--merged`, only branches merged into the named
 commit (i.e. the branches whose tip commits are reachable from the named
 commit) will be listed.  With `--no-merged` only branches not merged into
-the named commit will be listed.  Missing <commit> argument defaults to
-'HEAD' (i.e. the tip of the current branch).
+the named commit will be listed.  If the <commit> argument is missing it
+defaults to 'HEAD' (i.e. the tip of the current branch).
 
-In its second form, a new branch named <branchname> will be created.
+In the command's second form, a new branch named <branchname> will be created.
 It will start out with a head equal to the one given as <start-point>.
 If no <start-point> is given, the branch will be created with a head
 equal to that of the currently checked out branch.
@@ -57,9 +57,9 @@ has a reflog then the reflog will also be deleted.
 
 Use -r together with -d to delete remote-tracking branches. Note, that it
 only makes sense to delete remote-tracking branches if they no longer exist
-in remote repository or if 'git-fetch' was configured not to fetch
-them again. See also 'prune' subcommand of linkgit:git-remote[1] for way to
-clean up all obsolete remote-tracking branches.
+in the remote repository or if 'git-fetch' was configured not to fetch
+them again. See also the 'prune' subcommand of linkgit:git-remote[1] for a
+way to clean up all obsolete remote-tracking branches.
 
 
 OPTIONS
@@ -83,7 +83,7 @@ OPTIONS
 	Move/rename a branch and the corresponding reflog.
 
 -M::
-	Move/rename a branch even if the new branchname already exists.
+	Move/rename a branch even if the new branch name already exists.
 
 --color::
 	Color branches to highlight current, local, and remote branches.
@@ -103,17 +103,17 @@ OPTIONS
 	Show sha1 and commit subject line for each head.
 
 --abbrev=<length>::
-	Alter minimum display length for sha1 in output listing,
-	default value is 7.
+	Alter the sha1's minimum display length in the output listing.
+	The default value is 7.
 
 --no-abbrev::
-	Display the full sha1s in output listing rather than abbreviating them.
+	Display the full sha1s in the output listing rather than abbreviating them.
 
 --track::
-	When creating a new branch, set up configuration so that 'git-pull'
+	When creating a new branch, set up the configuration so that 'git-pull'
 	will automatically retrieve data from the start point, which must be
 	a branch. Use this if you always pull from the same upstream branch
-	into the new branch, and if you don't want to use "git pull
+	into the new branch, and if you do not want to use "git pull
 	<repository> <refspec>" explicitly. This behavior is the default
 	when the start point is a remote branch. Set the
 	branch.autosetupmerge configuration variable to `false` if you want
@@ -149,13 +149,13 @@ OPTIONS
 
 <newbranch>::
 	The new name for an existing branch. The same restrictions as for
-	<branchname> applies.
+	<branchname> apply.
 
 
 Examples
 --------
 
-Start development off of a known tag::
+Start development from a known tag::
 +
 ------------
 $ git clone git://git.kernel.org/pub/scm/.../linux-2.6 my2.6
@@ -167,7 +167,7 @@ $ git checkout my2.6.14
 <1> This step and the next one could be combined into a single step with
 "checkout -b my2.6.14 v2.6.14".
 
-Delete unneeded branch::
+Delete an unneeded branch::
 +
 ------------
 $ git clone git://git.kernel.org/.../git.git my.git
@@ -176,21 +176,21 @@ $ git branch -d -r origin/todo origin/html origin/man   <1>
 $ git branch -D test                                    <2>
 ------------
 +
-<1> Delete remote-tracking branches "todo", "html", "man". Next 'fetch' or
-'pull' will create them again unless you configure them not to. See
-linkgit:git-fetch[1].
-<2> Delete "test" branch even if the "master" branch (or whichever branch is
-currently checked out) does not have all commits from test branch.
+<1> Delete the remote-tracking branches "todo", "html" and "man". The next
+'fetch' or 'pull' will create them again unless you configure them not to.
+See linkgit:git-fetch[1].
+<2> Delete the "test" branch even if the "master" branch (or whichever branch
+is currently checked out) does not have all commits from the test branch.
 
 
 Notes
 -----
 
-If you are creating a branch that you want to immediately checkout, it's
+If you are creating a branch that you want to checkout immediately, it is
 easier to use the git checkout command with its `-b` option to create
 a branch and check it out with a single command.
 
-The options `--contains`, `--merged` and `--no-merged` serves three related
+The options `--contains`, `--merged` and `--no-merged` serve three related
 but different purposes:
 
 - `--contains <commit>` is used to find all branches which will need
-- 
1.6.2.1
