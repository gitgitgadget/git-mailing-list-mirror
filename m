From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/4] git-svn.txt: stop using dash-form of commands.
Date: Mon,  6 Jul 2009 00:03:14 +0200
Message-ID: <1246831397-19489-2-git-send-email-ydirson@altern.org>
References: <1246831397-19489-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 00:02:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNZma-0000Tw-Ef
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 00:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031AbZGEWBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2009 18:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753648AbZGEWBs
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jul 2009 18:01:48 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:39790 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753583AbZGEWBo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2009 18:01:44 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 7995A9400E6;
	Mon,  6 Jul 2009 00:01:39 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 2C9A894011B;
	Mon,  6 Jul 2009 00:01:37 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 34971A004; Mon,  6 Jul 2009 00:03:24 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1246831397-19489-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122759>

Also consistently use single quotes around git commands to make things clear
(was only needed at a couple of places).

Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 Documentation/git-svn.txt |  110 ++++++++++++++++++++++----------------------
 1 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 7e9b9a0..a42f96a 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -11,11 +11,11 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-'git-svn' is a simple conduit for changesets between Subversion and git.
+'git svn' is a simple conduit for changesets between Subversion and git.
 It provides a bidirectional flow of changes between a Subversion and a git
 repository.
 
-'git-svn' can track a standard Subversion repository,
+'git svn' can track a standard Subversion repository,
 following the common "trunk/branches/tags" layout, with the --stdlayout option.
 It can also follow branches and tags in any layout with the -T/-t/-b options
 (see options to 'init' below, and also the 'clone' command).
@@ -30,7 +30,7 @@ COMMANDS
 
 'init'::
 	Initializes an empty git repository with additional
-	metadata directories for 'git-svn'.  The Subversion URL
+	metadata directories for 'git svn'.  The Subversion URL
 	may be specified as a command-line argument, or as full
 	URL arguments to -T/-t/-b.  Optionally, the target
 	directory to operate on can be specified as a second
@@ -100,7 +100,7 @@ COMMANDS
 
 --localtime;;
 	Store Git commit times in the local timezone instead of UTC.  This
-	makes 'git-log' (even without --date=local) show the same times
+	makes 'git log' (even without --date=local) show the same times
 	that `svn log` would in the local timezone.
 
 --parent;;
@@ -148,20 +148,20 @@ Examples:
 	This fetches revisions from the SVN parent of the current HEAD
 	and rebases the current (uncommitted to SVN) work against it.
 
-This works similarly to `svn update` or 'git-pull' except that
-it preserves linear history with 'git-rebase' instead of
-'git-merge' for ease of dcommitting with 'git-svn'.
+This works similarly to `svn update` or 'git pull' except that
+it preserves linear history with 'git rebase' instead of
+'git merge' for ease of dcommitting with 'git svn'.
 
-This accepts all options that 'git-svn fetch' and 'git-rebase'
+This accepts all options that 'git svn fetch' and 'git rebase'
 accept.  However, '--fetch-all' only fetches from the current
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
@@ -169,7 +169,7 @@ and have no uncommitted changes.
 	repository, and then rebase or reset (depending on whether or
 	not there is a diff between SVN and head).  This will create
 	a revision in SVN for each commit in git.
-	It is recommended that you run 'git-svn' fetch and rebase (not
+	It is recommended that you run 'git svn' fetch and rebase (not
 	pull or merge) your commits against the latest changes in the
 	SVN repository.
 	An optional revision or branch argument may be specified, and
@@ -182,7 +182,7 @@ and have no uncommitted changes.
 	After committing, do not rebase or reset.
 --commit-url <URL>;;
 	Commit to this SVN URL (the full path).  This is intended to
-	allow existing git-svn repositories created with one transport
+	allow existing 'git svn' repositories created with one transport
 	method (e.g. `svn://` or `http://` for anonymous read) to be
 	reused if a user is later given access to an alternate transport
 	method (e.g. `svn+ssh://` or `https://`) for commit.
@@ -258,7 +258,7 @@ NOTE: SVN itself only stores times in UTC and nothing else. The regular svn
 client converts the UTC time to the local time (or based on the TZ=
 environment). This command has the same behaviour.
 +
-Any other arguments are passed directly to 'git-log'
+Any other arguments are passed directly to 'git log'
 
 'blame'::
        Show what revision and author last modified each line of a file. The
@@ -266,10 +266,10 @@ Any other arguments are passed directly to 'git-log'
        `svn blame' by default. Like the SVN blame command,
        local uncommitted changes in the working copy are ignored;
        the version of the file in the HEAD revision is annotated. Unknown
-       arguments are passed directly to 'git-blame'.
+       arguments are passed directly to 'git blame'.
 +
 --git-format;;
-	Produce output in the same format as 'git-blame', but with
+	Produce output in the same format as 'git blame', but with
 	SVN revision numbers instead of git commit hashes. In this mode,
 	changes that haven't been committed to SVN (including local
 	working-copy edits) are shown as revision 0.
@@ -288,7 +288,7 @@ Any other arguments are passed directly to 'git-log'
 	absolutely no attempts to do patching when committing to SVN, it
 	simply overwrites files with those specified in the tree or
 	commit.  All merging is assumed to have taken place
-	independently of 'git-svn' functions.
+	independently of 'git svn' functions.
 
 'create-ignore'::
 	Recursively finds the svn:ignore property on directories and
@@ -303,12 +303,12 @@ Any other arguments are passed directly to 'git-log'
 
 'commit-diff'::
 	Commits the diff of two tree-ish arguments from the
-	command-line.  This command does not rely on being inside an `git-svn
+	command-line.  This command does not rely on being inside an `git svn
 	init`-ed repository.  This command takes three arguments, (a) the
 	original tree to diff against, (b) the new tree result, (c) the
 	URL of the target Subversion repository.  The final argument
-	(URL) may be omitted if you are working from a 'git-svn'-aware
-	repository (that has been `init`-ed with 'git-svn').
+	(URL) may be omitted if you are working from a 'git svn'-aware
+	repository (that has been `init`-ed with 'git svn').
 	The -r<revision> option is required for this.
 
 'info'::
@@ -396,7 +396,7 @@ OPTIONS
 --shared[={false|true|umask|group|all|world|everybody}]::
 --template=<template_directory>::
 	Only used with the 'init' command.
-	These are passed directly to 'git-init'.
+	These are passed directly to 'git init'.
 
 -r <ARG>::
 --revision <ARG>::
@@ -418,7 +418,7 @@ Only used with the 'set-tree' command.
 
 Read a list of commits from stdin and commit them in reverse
 order.  Only the leading sha1 is read from each line, so
-'git-rev-list --pretty=oneline' output can be used.
+'git rev-list --pretty=oneline' output can be used.
 
 --rmdir::
 
@@ -448,7 +448,7 @@ config key: svn.edit
 
 Only used with the 'dcommit', 'set-tree' and 'commit-diff' commands.
 
-They are both passed directly to 'git-diff-tree'; see
+They are both passed directly to 'git diff-tree'; see
 linkgit:git-diff-tree[1] for more information.
 
 [verse]
@@ -458,16 +458,16 @@ config key: svn.findcopiesharder
 -A<filename>::
 --authors-file=<filename>::
 
-Syntax is compatible with the file used by 'git-cvsimport':
+Syntax is compatible with the file used by 'git cvsimport':
 
 ------------------------------------------------------------------------
 	loginname = Joe User <user@example.com>
 ------------------------------------------------------------------------
 
-If this option is specified and 'git-svn' encounters an SVN
-committer name that does not exist in the authors-file, 'git-svn'
+If this option is specified and 'git svn' encounters an SVN
+committer name that does not exist in the authors-file, 'git svn'
 will abort operation. The user will then have to add the
-appropriate entry.  Re-running the previous 'git-svn' command
+appropriate entry.  Re-running the previous 'git svn' command
 after the authors-file is modified should continue operation.
 
 config key: svn.authorsfile
@@ -482,7 +482,7 @@ the authors file.
 
 -q::
 --quiet::
-	Make 'git-svn' less verbose. Specify a second time to make it
+	Make 'git svn' less verbose. Specify a second time to make it
 	even less verbose.
 
 --repack[=<n>]::
@@ -495,7 +495,7 @@ with many revisions.
 to fetch before repacking.  This defaults to repacking every
 1000 commits fetched if no argument is specified.
 
---repack-flags are passed directly to 'git-repack'.
+--repack-flags are passed directly to 'git repack'.
 
 [verse]
 config key: svn.repack
@@ -508,8 +508,8 @@ config key: svn.repackflags
 
 These are only used with the 'dcommit' and 'rebase' commands.
 
-Passed directly to 'git-rebase' when using 'dcommit' if a
-'git-reset' cannot be used (see 'dcommit').
+Passed directly to 'git rebase' when using 'dcommit' if a
+'git reset' cannot be used (see 'dcommit').
 
 -n::
 --dry-run::
@@ -566,18 +566,18 @@ svn-remote.<name>.noMetadata::
 
 This gets rid of the 'git-svn-id:' lines at the end of every commit.
 
-If you lose your .git/svn/git-svn/.rev_db file, 'git-svn' will not
+If you lose your .git/svn/git-svn/.rev_db file, 'git svn' will not
 be able to rebuild it and you won't be able to fetch again,
 either.  This is fine for one-shot imports.
 
-The 'git-svn log' command will not work on repositories using
+The 'git svn log' command will not work on repositories using
 this, either.  Using this conflicts with the 'useSvmProps'
 option for (hopefully) obvious reasons.
 
 svn.useSvmProps::
 svn-remote.<name>.useSvmProps::
 
-This allows 'git-svn' to re-map repository URLs and UUIDs from
+This allows 'git svn' to re-map repository URLs and UUIDs from
 mirrors created using SVN::Mirror (or svk) for metadata.
 
 If an SVN revision has a property, "svm:headrev", it is likely
@@ -596,7 +596,7 @@ svn-remote.<name>.useSvnsyncprops::
 
 svn-remote.<name>.rewriteRoot::
 	This allows users to create repositories from alternate
-	URLs.  For example, an administrator could run 'git-svn' on the
+	URLs.  For example, an administrator could run 'git svn' on the
 	server locally (accessing via file://) but wish to distribute
 	the repository with a public http:// or svn:// URL in the
 	metadata so users of it will see the public URL.
@@ -605,14 +605,14 @@ svn.brokenSymlinkWorkaround::
 This disables potentially expensive checks to workaround broken symlinks
 checked into SVN by broken clients.  Set this option to "false" if you
 track a SVN repository with many empty blobs that are not symlinks.
-This option may be changed while "git-svn" is running and take effect on
-the next revision fetched.  If unset, git-svn assumes this option to be
+This option may be changed while 'git svn' is running and take effect on
+the next revision fetched.  If unset, 'git svn' assumes this option to be
 "true".
 
 --
 
 Since the noMetadata, rewriteRoot, useSvnsyncProps and useSvmProps
-options all affect the metadata generated and used by 'git-svn'; they
+options all affect the metadata generated and used by 'git svn'; they
 *must* be set in the configuration file before any history is imported
 and these settings should never be changed once they are set.
 
@@ -630,7 +630,7 @@ Tracking and contributing to the trunk of a Subversion-managed project:
 	git svn clone http://svn.example.com/project/trunk
 # Enter the newly cloned directory:
 	cd trunk
-# You should be on master branch, double-check with git-branch
+# You should be on master branch, double-check with 'git branch'
 	git branch
 # Do some work and commit locally to git:
 	git commit ...
@@ -661,12 +661,12 @@ Tracking and contributing to an entire Subversion-managed project
 # of dcommit/rebase/show-ignore should be the same as above.
 ------------------------------------------------------------------------
 
-The initial 'git-svn clone' can be quite time-consuming
+The initial 'git svn clone' can be quite time-consuming
 (especially for large Subversion repositories). If multiple
 people (or one person with multiple machines) want to use
-'git-svn' to interact with the same Subversion repository, you can
-do the initial 'git-svn clone' to a repository on a server and
-have each person clone that repository with 'git-clone':
+'git svn' to interact with the same Subversion repository, you can
+do the initial 'git svn clone' to a repository on a server and
+have each person clone that repository with 'git clone':
 
 ------------------------------------------------------------------------
 # Do the initial import on a server
@@ -680,7 +680,7 @@ have each person clone that repository with 'git-clone':
 	git fetch
 # Create a local branch from one of the branches just fetched
 	git checkout -b master FETCH_HEAD
-# Initialize git-svn locally (be sure to use the same URL and -T/-b/-t options as were used on server)
+# Initialize 'git svn' locally (be sure to use the same URL and -T/-b/-t options as were used on server)
 	git svn init http://svn.example.com/project
 # Pull the latest changes from Subversion
 	git svn rebase
@@ -689,7 +689,7 @@ have each person clone that repository with 'git-clone':
 REBASE VS. PULL/MERGE
 ---------------------
 
-Originally, 'git-svn' recommended that the 'remotes/git-svn' branch be
+Originally, 'git svn' recommended that the 'remotes/git-svn' branch be
 pulled or merged from.  This is because the author favored
 `git svn set-tree B` to commit a single head rather than the
 `git svn set-tree A..B` notation to commit multiple commits.
@@ -704,7 +704,7 @@ previous commits in SVN.
 DESIGN PHILOSOPHY
 -----------------
 Merge tracking in Subversion is lacking and doing branched development
-with Subversion can be cumbersome as a result.  While 'git-svn' can track
+with Subversion can be cumbersome as a result.  While 'git svn' can track
 copy history (including branches and tags) for repositories adopting a
 standard layout, it cannot yet represent merge history that happened
 inside git back upstream to SVN users.  Therefore it is advised that
@@ -715,25 +715,25 @@ CAVEATS
 -------
 
 For the sake of simplicity and interoperating with a less-capable system
-(SVN), it is recommended that all 'git-svn' users clone, fetch and dcommit
-directly from the SVN server, and avoid all 'git-clone'/'pull'/'merge'/'push'
+(SVN), it is recommended that all 'git svn' users clone, fetch and dcommit
+directly from the SVN server, and avoid all 'git clone'/'pull'/'merge'/'push'
 operations between git repositories and branches.  The recommended
 method of exchanging code between git branches and users is
-'git-format-patch' and 'git-am', or just 'dcommit'ing to the SVN repository.
+'git format-patch' and 'git am', or just 'dcommit'ing to the SVN repository.
 
-Running 'git-merge' or 'git-pull' is NOT recommended on a branch you
+Running 'git merge' or 'git pull' is NOT recommended on a branch you
 plan to 'dcommit' from.  Subversion does not represent merges in any
 reasonable or useful fashion; so users using Subversion cannot see any
 merges you've made.  Furthermore, if you merge or pull from a git branch
 that is a mirror of an SVN branch, 'dcommit' may commit to the wrong
 branch.
 
-'git-clone' does not clone branches under the refs/remotes/ hierarchy or
-any 'git-svn' metadata, or config.  So repositories created and managed with
-using 'git-svn' should use 'rsync' for cloning, if cloning is to be done
+'git clone' does not clone branches under the refs/remotes/ hierarchy or
+any 'git svn' metadata, or config.  So repositories created and managed with
+using 'git svn' should use 'rsync' for cloning, if cloning is to be done
 at all.
 
-Since 'dcommit' uses rebase internally, any git branches you 'git-push' to
+Since 'dcommit' uses rebase internally, any git branches you 'git push' to
 before 'dcommit' on will require forcing an overwrite of the existing ref
 on the remote repository.  This is generally considered bad practice,
 see the linkgit:git-push[1] documentation for details.
@@ -769,7 +769,7 @@ for git to detect them.
 CONFIGURATION
 -------------
 
-'git-svn' stores [svn-remote] configuration information in the
+'git svn' stores [svn-remote] configuration information in the
 repository .git/config file.  It is similar the core git
 [remote] sections except 'fetch' keys do not accept glob
 arguments; but they are instead handled by the 'branches'
@@ -790,7 +790,7 @@ Keep in mind that the '\*' (asterisk) wildcard of the local ref
 however the remote wildcard may be anywhere as long as it's an
 independent path component (surrounded by '/' or EOL).   This
 type of configuration is not automatically created by 'init' and
-should be manually entered with a text-editor or using 'git-config'.
+should be manually entered with a text-editor or using 'git config'.
 
 SEE ALSO
 --------
-- 
1.6.3.3
