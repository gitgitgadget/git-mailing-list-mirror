From: Peter Harris <git@peter.is-a-geek.org>
Subject: [PATCH 1/2] Documentation/git-svn.txt: Remove the hyphen from git-foo
 when quoted
Date: Wed, 6 Feb 2008 18:43:37 -0500 (EST)
Message-ID: <alpine.OSX.1.00.0802061835050.27901@mac.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 07 00:44:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMtwH-0008Gw-G3
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 00:44:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762967AbYBFXnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 18:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757343AbYBFXnr
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 18:43:47 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:46089 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762856AbYBFXno (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 18:43:44 -0500
Received: by py-out-1112.google.com with SMTP id u52so4621415pyb.10
        for <git@vger.kernel.org>; Wed, 06 Feb 2008 15:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject:message-id:user-agent:mime-version:content-type:sender;
        bh=crAozlsz1U4/A91QebP6G/w1E7tpehsnpgJ4z21lI80=;
        b=x9Ws4RU0RLgki+WHnXgJM67jYrISUmmg0iGH0gHnmh9Jzn0f6/SQxjNrs1LUaNydWwZgW0SDwayIACqdKYNNJudITTfci3Kk7/DuxerrGBS05dli5bzPkPV4KYa6Wj2ImGbgjSaL4XAaUGwy8afZcJCO1MmG/y00oyHXYzB5CoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:user-agent:mime-version:content-type:sender;
        b=PgZKyhQBF+uU8Ag42MtTMAOqBVvTYqbIjJazIXESRfd396BhfGxYBazcy5Vk7jdiLR5wlM53msJiA9QP/absuKuzn0q5lLTmuo1tzGieN22Jgma1a+jzE+i4fyJfU56aQ4TubzVEYETBM1qubDB9kWjdOy/2ZqKIUdZOFTMzaXQ=
Received: by 10.65.81.10 with SMTP id i10mr20003368qbl.75.1202341421730;
        Wed, 06 Feb 2008 15:43:41 -0800 (PST)
Received: from mac.local ( [76.10.147.56])
        by mx.google.com with ESMTPS id e15sm8905357qba.9.2008.02.06.15.43.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Feb 2008 15:43:40 -0800 (PST)
User-Agent: Alpine 1.00 (OSX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72874>


The git-foo forms are deprecated in favour of "git foo"

Signed-off-by: Peter <git@peter.is-a-geek.org>
---
 Documentation/git-svn.txt |   50 ++++++++++++++++++++++----------------------
 1 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index b1d527f..f94d0f9 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -97,20 +97,20 @@ COMMANDS
 	This fetches revisions from the SVN parent of the current HEAD
 	and rebases the current (uncommitted to SVN) work against it.
 
-This works similarly to 'svn update' or 'git-pull' except that
-it preserves linear history with 'git-rebase' instead of
-'git-merge' for ease of dcommiting with git-svn.
+This works similarly to 'svn update' or 'git pull' except that
+it preserves linear history with 'git rebase' instead of
+'git merge' for ease of dcommiting with git-svn.
 
-This accepts all options that 'git-svn fetch' and 'git-rebase'
+This accepts all options that 'git svn fetch' and 'git rebase'
 accepts.  However '--fetch-all' only fetches from the current
 [svn-remote], and not all [svn-remote] definitions.
 
-Like 'git-rebase'; this requires that the working tree be clean
+Like 'git rebase'; this requires that the working tree be clean
 and have no uncommitted changes.
 
 -l;;
 --local;;
-	Do not fetch remotely; only run 'git-rebase' against the
+	Do not fetch remotely; only run 'git rebase' against the
 	last fetched commit from the upstream SVN.
 
 'dcommit'::
@@ -313,7 +313,7 @@ config key: svn.repackflags
 These are only used with the 'dcommit' and 'rebase' commands.
 
 Passed directly to git-rebase when using 'dcommit' if a
-'git-reset' cannot be used (see dcommit).
+'git reset' cannot be used (see dcommit).
 
 -n::
 --dry-run::
@@ -366,7 +366,7 @@ If you lose your .git/svn/git-svn/.rev_db file, git-svn will not
 be able to rebuild it and you won't be able to fetch again,
 either.  This is fine for one-shot imports.
 
-The 'git-svn log' command will not work on repositories using
+The 'git svn log' command will not work on repositories using
 this, either.  Using this conflicts with the 'useSvmProps'
 option for (hopefully) obvious reasons.
 
@@ -414,7 +414,7 @@ Tracking and contributing to the trunk of a Subversion-managed project:
 
 ------------------------------------------------------------------------
 # Clone a repo (like git clone):
-	git-svn clone http://svn.foo.org/project/trunk
+	git svn clone http://svn.foo.org/project/trunk
 # Enter the newly cloned directory:
 	cd trunk
 # You should be on master branch, double-check with git-branch
@@ -423,12 +423,12 @@ Tracking and contributing to the trunk of a Subversion-managed project:
 	git commit ...
 # Something is committed to SVN, rebase your local changes against the
 # latest changes in SVN:
-	git-svn rebase
+	git svn rebase
 # Now commit your changes (that were committed previously using git) to SVN,
 # as well as automatically updating your working HEAD:
-	git-svn dcommit
+	git svn dcommit
 # Append svn:ignore settings to the default git exclude file:
-	git-svn show-ignore >> .git/info/exclude
+	git svn show-ignore >> .git/info/exclude
 ------------------------------------------------------------------------
 
 Tracking and contributing to an entire Subversion-managed project
@@ -436,7 +436,7 @@ Tracking and contributing to an entire Subversion-managed project
 
 ------------------------------------------------------------------------
 # Clone a repo (like git clone):
-	git-svn clone http://svn.foo.org/project -T trunk -b branches -t tags
+	git svn clone http://svn.foo.org/project -T trunk -b branches -t tags
 # View all branches and tags you have cloned:
 	git branch -r
 # Reset your master to trunk (or any other branch, replacing 'trunk'
@@ -446,27 +446,27 @@ Tracking and contributing to an entire Subversion-managed project
 # of dcommit/rebase/show-ignore should be the same as above.
 ------------------------------------------------------------------------
 
-The initial 'git-svn clone' can be quite time-consuming
+The initial 'git svn clone' can be quite time-consuming
 (especially for large Subversion repositories). If multiple
 people (or one person with multiple machines) want to use
 git-svn to interact with the same Subversion repository, you can
-do the initial 'git-svn clone' to a repository on a server and
+do the initial 'git svn clone' to a repository on a server and
 have each person clone that repository with 'git clone':
 
 ------------------------------------------------------------------------
 # Do the initial import on a server
-	ssh server "cd /pub && git-svn clone http://svn.foo.org/project
+	ssh server "cd /pub && git svn clone http://svn.foo.org/project
 # Clone locally - make sure the refs/remotes/ space matches the server
 	mkdir project
 	cd project
-	git-init
+	git init
 	git remote add origin server:/pub/project
 	git config --add remote.origin.fetch=+refs/remotes/*:refs/remotes/*
 	git fetch
 # Initialize git-svn locally (be sure to use the same URL and -T/-b/-t options as were used on server)
-	git-svn init http://svn.foo.org/project
+	git svn init http://svn.foo.org/project
 # Pull the latest changes from Subversion
-	git-svn rebase
+	git svn rebase
 ------------------------------------------------------------------------
 
 REBASE VS. PULL/MERGE
@@ -474,12 +474,12 @@ REBASE VS. PULL/MERGE
 
 Originally, git-svn recommended that the remotes/git-svn branch be
 pulled or merged from.  This is because the author favored
-'git-svn set-tree B' to commit a single head rather than the
-'git-svn set-tree A..B' notation to commit multiple commits.
+'git svn set-tree B' to commit a single head rather than the
+'git svn set-tree A..B' notation to commit multiple commits.
 
-If you use 'git-svn set-tree A..B' to commit several diffs and you do
+If you use 'git svn set-tree A..B' to commit several diffs and you do
 not have the latest remotes/git-svn merged into my-branch, you should
-use 'git-svn rebase' to update your work branch instead of 'git pull' or
+use 'git svn rebase' to update your work branch instead of 'git pull' or
 'git merge'.  'pull/merge' can cause non-linear history to be flattened
 when committing into SVN, which can lead to merge commits reversing
 previous commits in SVN.
@@ -504,14 +504,14 @@ operations between git repositories and branches.  The recommended
 method of exchanging code between git branches and users is
 git-format-patch and git-am, or just dcommiting to the SVN repository.
 
-Running 'git-merge' or 'git-pull' is NOT recommended on a branch you
+Running 'git merge' or 'git pull' is NOT recommended on a branch you
 plan to dcommit from.  Subversion does not represent merges in any
 reasonable or useful fashion; so users using Subversion cannot see any
 merges you've made.  Furthermore, if you merge or pull from a git branch
 that is a mirror of an SVN branch, dcommit may commit to the wrong
 branch.
 
-'git-clone' does not clone branches under the refs/remotes/ hierarchy or
+'git clone' does not clone branches under the refs/remotes/ hierarchy or
 any git-svn metadata, or config.  So repositories created and managed with
 using git-svn should use rsync(1) for cloning, if cloning is to be done
 at all.
-- 
1.5.3.7
