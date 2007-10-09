From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH 1/6] Fix some typos, punctuation, missing words, minor markup.
Date: Tue, 9 Oct 2007 23:00:03 +0200
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071009210003.GC31317@ins.uni-bonn.de>
References: <20071009205755.GB31317@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 23:34:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfMiG-0001Kc-Hw
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 23:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755159AbXJIVdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 17:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755179AbXJIVdx
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 17:33:53 -0400
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:60277 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755001AbXJIVds (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 17:33:48 -0400
Received: from localhost.localdomain (xdsl-87-78-163-242.netcologne.de [87.78.163.242])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 8B02140000E05
	for <git@vger.kernel.org>; Tue,  9 Oct 2007 23:00:41 +0200 (CEST)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1IfMBP-0000mE-TF
	for git@vger.kernel.org; Tue, 09 Oct 2007 23:00:03 +0200
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071009205755.GB31317@ins.uni-bonn.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60447>

---
 Documentation/config.txt          |    4 ++--
 Documentation/git-diff.txt        |    2 +-
 Documentation/git-index-pack.txt  |    2 +-
 Documentation/git-merge-index.txt |    2 +-
 Documentation/git-stash.txt       |    2 +-
 Documentation/git-svn.txt         |    2 +-
 Documentation/git-tag.txt         |    2 +-
 Documentation/git.txt             |    4 ++--
 Documentation/glossary.txt        |    6 +++---
 Documentation/user-manual.txt     |   27 ++++++++++++++-------------
 10 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 015910f..6afc1dc 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -188,7 +188,7 @@ core.worktree::
 	Set the path to the working tree.  The value will not be
 	used in combination with repositories found automatically in
 	a .git directory (i.e. $GIT_DIR is not set).
-	This can be overriden by the GIT_WORK_TREE environment
+	This can be overridden by the GIT_WORK_TREE environment
 	variable and the '--work-tree' command line option.
 
 core.logAllRefUpdates::
@@ -588,7 +588,7 @@ merge.verbosity::
 	message if conflicts were detected. Level 1 outputs only
 	conflicts, 2 outputs conflicts and file changes.  Level 5 and
 	above outputs debugging information.  The default is level 2.
-	Can be overriden by 'GIT_MERGE_VERBOSITY' environment variable.
+	Can be overridden by 'GIT_MERGE_VERBOSITY' environment variable.
 
 merge.<driver>.name::
 	Defines a human readable name for a custom low-level
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index db2eb46..ce0f502 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -125,7 +125,7 @@ $ git diff topic...master  <3>
 +
 <1> Changes between the tips of the topic and the master branches.
 <2> Same as above.
-<3> Changes that occured on the master branch since when the topic
+<3> Changes that occurred on the master branch since when the topic
 branch was started off it.
 
 Limiting the diff output::
diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index a8a7f6f..bf5c2bd 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -43,7 +43,7 @@ OPTIONS
 	a default name determined from the pack content.  If
 	<pack-file> is not specified consider using --keep to
 	prevent a race condition between this process and
-	gitlink::git-repack[1] .
+	gitlink::git-repack[1].
 
 --fix-thin::
 	It is possible for gitlink:git-pack-objects[1] to build
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index 17e9f10..b726ddf 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -40,7 +40,7 @@ If "git-merge-index" is called with multiple <file>s (or -a) then it
 processes them in turn only stopping if merge returns a non-zero exit
 code.
 
-Typically this is run with the a script calling git's imitation of
+Typically this is run with a script calling git's imitation of
 the merge command from the RCS package.
 
 A sample script called "git-merge-one-file" is included in the
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 5723bb0..c0147b9 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -57,7 +57,7 @@ stash@{1}: On master: 9cc0589... Add git-stash
 
 show [<stash>]::
 
-	Show the changes recorded in the stash as a diff between the the
+	Show the changes recorded in the stash as a diff between the
 	stashed state and its original parent. When no `<stash>` is given,
 	shows the latest one. By default, the command shows the diffstat, but
 	it will accept any format known to `git-diff` (e.g., `git-stash show
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index e157c6a..488e4b1 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -404,7 +404,7 @@ section because they affect the 'git-svn-id:' metadata line.
 BASIC EXAMPLES
 --------------
 
-Tracking and contributing to a the trunk of a Subversion-managed project:
+Tracking and contributing to the trunk of a Subversion-managed project:
 
 ------------------------------------------------------------------------
 # Clone a repo (like git clone):
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 990ae4f..22a23bf 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -112,7 +112,7 @@ You really want to call the new version "X" too, 'even though'
 others have already seen the old one. So just use "git tag -f"
 again, as if you hadn't already published the old one.
 
-However, Git does *not* (and it should not)change tags behind
+However, Git does *not* (and it should not) change tags behind
 users back. So if somebody already got the old tag, doing a "git
 pull" on your tree shouldn't just make them overwrite the old
 one.
diff --git a/Documentation/git.txt b/Documentation/git.txt
index abce801..bba8d54 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -325,7 +325,7 @@ For a more complete list of ways to spell object names, see
 File/Directory Structure
 ------------------------
 
-Please see link:repository-layout.html[repository layout] document.
+Please see the link:repository-layout.html[repository layout] document.
 
 Read link:hooks.html[hooks] for more details about each hook.
 
@@ -335,7 +335,7 @@ Higher level SCMs may provide and manage additional information in the
 
 Terminology
 -----------
-Please see link:glossary.html[glossary] document.
+Please see the link:glossary.html[glossary] document.
 
 
 Environment Variables
diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
index 3f7b1e4..d99fa19 100644
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -52,8 +52,8 @@ GIT Glossary
 [[def_cherry-picking]]cherry-picking::
 	In <<def_SCM,SCM>> jargon, "cherry pick" means to choose a subset of
 	changes out of a series of changes (typically commits) and record them
-	as a new series of changes on top of different codebase. In GIT, this is
-	performed by "git cherry-pick" command to extract the change introduced
+	as a new series of changes on top of a different codebase. In GIT, this is
+	performed by the "git cherry-pick" command to extract the change introduced
 	by an existing <<def_commit,commit>> and to record it based on the tip
 	of the current <<def_branch,branch>> as a new commit.
 
@@ -347,7 +347,7 @@ This commit is referred to as a "merge commit", or sometimes just a
 	it as my origin branch head". And `git push
 	$URL refs/heads/master:refs/heads/to-upstream` means "publish my
 	master branch head as to-upstream branch at $URL". See also
-	gitlink:git-push[1]
+	gitlink:git-push[1].
 
 [[def_repository]]repository::
 	A collection of <<def_ref,refs>> together with an
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index c7fdf25..6adeca7 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1495,7 +1495,7 @@ Ensuring good performance
 -------------------------
 
 On large repositories, git depends on compression to keep the history
-information from taking up to much space on disk or in memory.
+information from taking up too much space on disk or in memory.
 
 This compression is not performed automatically.  Therefore you
 should occasionally run gitlink:git-gc[1]:
@@ -1920,7 +1920,7 @@ As with git-fetch, git-push will complain if this does not result in
 a <<fast-forwards,fast forward>>.  Normally this is a sign of
 something wrong.  However, if you are sure you know what you're
 doing, you may force git-push to perform the update anyway by
-proceeding the branch name by a plus sign:
+preceding the branch name by a plus sign:
 
 -------------------------------------------------
 $ git push ssh://yourserver.com/~you/proj.git +master
@@ -2040,7 +2040,7 @@ $ git branch --track test origin/master
 $ git branch --track release origin/master
 -------------------------------------------------
 
-These can be easily kept up to date using gitlink:git-pull[1]
+These can be easily kept up to date using gitlink:git-pull[1].
 
 -------------------------------------------------
 $ git checkout test && git pull
@@ -2132,7 +2132,7 @@ changes are in a specific branch, use:
 $ git log linux..branchname | git-shortlog
 -------------------------------------------------
 
-To see whether it has already been merged into the test or release branches
+To see whether it has already been merged into the test or release branches,
 use:
 
 -------------------------------------------------
@@ -2145,12 +2145,12 @@ or
 $ git log release..branchname
 -------------------------------------------------
 
-(If this branch has not yet been merged you will see some log entries.
+(If this branch has not yet been merged, you will see some log entries.
 If it has been merged, then there will be no output.)
 
 Once a patch completes the great cycle (moving from test to release,
 then pulled by Linus, and finally coming back into your local
-"origin/master" branch) the branch for this change is no longer needed.
+"origin/master" branch), the branch for this change is no longer needed.
 You detect this when the output from:
 
 -------------------------------------------------
@@ -2479,7 +2479,7 @@ $ git checkout -b mywork-new origin
 $ gitk origin..mywork &
 -------------------------------------------------
 
-And browse through the list of patches in the mywork branch using gitk,
+and browse through the list of patches in the mywork branch using gitk,
 applying them (possibly in a different order) to mywork-new using
 cherry-pick, and possibly modifying them as you go using commit --amend.
 The gitlink:git-gui[1] command may also help as it allows you to
@@ -2739,7 +2739,7 @@ others:
 
 - Git can quickly determine whether two objects are identical or not,
   just by comparing names.
-- Since object names are computed the same way in ever repository, the
+- Since object names are computed the same way in every repository, the
   same content stored in two repositories will always be stored under
   the same name.
 - Git can detect errors when it reads an object, by checking that the
@@ -3425,9 +3425,10 @@ The Workflow
 ------------
 
 High-level operations such as gitlink:git-commit[1],
-gitlink:git-checkout[1] and git-reset[1] work by moving data between the
-working tree, the index, and the object database.  Git provides
-low-level operations which perform each of these steps individually.
+gitlink:git-checkout[1] and gitlink:git-reset[1] work by moving data
+between the working tree, the index, and the object database.  Git
+provides low-level operations which perform each of these steps
+individually.
 
 Generally, all "git" operations work on the index file. Some operations
 work *purely* on the index file (showing the current state of the
@@ -3704,7 +3705,7 @@ Merging multiple trees, continued
 ---------------------------------
 
 Sadly, many merges aren't trivial. If there are files that have
-been added.moved or removed, or if both branches have modified the
+been added, moved or removed, or if both branches have modified the
 same file, you will be left with an index tree that contains "merge
 entries" in it. Such an index tree can 'NOT' be written out to a tree
 object, and you will have to resolve any such merge clashes using
@@ -4061,7 +4062,7 @@ $ git branch new     # create branch "new" starting at current HEAD
 $ git branch -d new  # delete branch "new"
 -----------------------------------------------
 
-Instead of basing new branch on current HEAD (the default), use:
+Instead of basing a new branch on current HEAD (the default), use:
 
 -----------------------------------------------
 $ git branch new test    # branch named "test"
-- 
1.5.3.3.g34c6d
