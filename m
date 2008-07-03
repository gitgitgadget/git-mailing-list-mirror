From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH 07/15] Documentation: more "git-" versus "git " changes
Date: Thu, 3 Jul 2008 00:28:15 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807030020390.16085@harper.uchicago.edu>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
 <7viqvqov01.fsf@gitster.siamese.dyndns.org> <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johanness Schindelin <Johannes.Schindelin@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 09:02:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEIpf-0003HF-9j
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 09:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755580AbYGCG7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 02:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753873AbYGCG6A
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:58:00 -0400
Received: from smtp01.uchicago.edu ([128.135.12.77]:36695 "EHLO
	smtp01.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754791AbYGCF2k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 01:28:40 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp01.uchicago.edu (8.13.8/8.13.8) with ESMTP id m635SFmB009704;
	Thu, 3 Jul 2008 00:28:15 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m635SFxo018934;
	Thu, 3 Jul 2008 00:28:15 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87228>

With git-commands moving out of $(bindir), it is useful to make a
clearer distinction between the git subcommand 'git-whatever' and
the command you type, `git whatever <options>`.  So we use a dash
after "git" when referring to the former and not the latter.

I already sent a patch doing this same thing, but I missed some
spots.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
 Documentation/config.txt            |   52 +++++++++++++++++-----------------
 Documentation/git-bisect.txt        |    4 +-
 Documentation/git-commit.txt        |    2 +-
 Documentation/git-filter-branch.txt |    2 +-
 Documentation/git-format-patch.txt  |    2 +-
 Documentation/git-help.txt          |    2 +-
 Documentation/git-rebase.txt        |    4 +-
 Documentation/git-reflog.txt        |    2 +-
 Documentation/git-remote.txt        |    2 +-
 Documentation/git-rerere.txt        |    2 +-
 Documentation/git-shortlog.txt      |    2 +-
 Documentation/gitcore-tutorial.txt  |   30 ++++++++++----------
 Documentation/user-manual.txt       |   36 ++++++++++++------------
 13 files changed, 71 insertions(+), 71 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 498247a..5a98a5b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -356,8 +356,8 @@ core.pager::
 
 core.whitespace::
 	A comma separated list of common whitespace problems to
-	notice.  `git diff` will use `color.diff.whitespace` to
-	highlight them, and `git apply --whitespace=error` will
+	notice.  `git-diff` will use `color.diff.whitespace` to
+	highlight them, and `git-apply --whitespace=error` will
 	consider them as errors:
 +
 * `trailing-space` treats trailing whitespaces at the end of the line
@@ -426,20 +426,20 @@ branch.autosetuprebase::
 	This option defaults to never.
 
 branch.<name>.remote::
-	When in branch <name>, it tells `git fetch` which remote to fetch.
-	If this option is not given, `git fetch` defaults to remote "origin".
+	When in branch <name>, it tells `git-fetch` which remote to fetch.
+	If this option is not given, `git-fetch` defaults to remote "origin".
 
 branch.<name>.merge::
-	When in branch <name>, it tells `git fetch` the default
+	When in branch <name>, it tells `git-fetch` the default
 	refspec to be marked for merging in FETCH_HEAD. The value is
 	handled like the remote part of a refspec, and must match a
 	ref which is fetched from the remote given by
 	"branch.<name>.remote".
-	The merge information is used by `git pull` (which at first calls
-	`git fetch`) to lookup the default branch for merging. Without
-	this option, `git pull` defaults to merge the first refspec fetched.
+	The merge information is used by `git-pull` (which at first calls
+	`git-fetch`) to lookup the default branch for merging. Without
+	this option, `git-pull` defaults to merge the first refspec fetched.
 	Specify multiple values to get an octopus merge.
-	If you wish to setup `git pull` so that it merges into <name> from
+	If you wish to setup `git-pull` so that it merges into <name> from
 	another branch in the local repository, you can point
 	branch.<name>.merge to the desired branch, and use the special setting
 	`.` (a period) for branch.<name>.remote.
@@ -508,12 +508,12 @@ color.diff.<slot>::
 
 color.interactive::
 	When set to `always`, always use colors for interactive prompts
-	and displays (such as those used by "git add --interactive").
+	and displays (such as those used by "git-add --interactive").
 	When false (or `never`), never.  When set to `true` or `auto`, use
 	colors only when the output is to the terminal. Defaults to false.
 
 color.interactive.<slot>::
-	Use customized color for `git add --interactive`
+	Use customized color for `git-add --interactive`
 	output. `<slot>` may be `prompt`, `header`, or `help`, for
 	three distinct types of normal output from interactive
 	programs.  The values of these variables may be specified as
@@ -550,14 +550,14 @@ color.ui::
 	take precedence over this setting. Defaults to false.
 
 diff.autorefreshindex::
-	When using `git diff` to compare with work tree
+	When using `git-diff` to compare with work tree
 	files, do not consider stat-only change as changed.
 	Instead, silently run `git update-index --refresh` to
 	update the cached stat information for paths whose
 	contents in the work tree match the contents in the
 	index.  This option defaults to true.  Note that this
-	affects only `git diff` Porcelain, and not lower level
-	`diff` commands, such as `git diff-files`.
+	affects only `git-diff` Porcelain, and not lower level
+	`diff` commands, such as `git-diff-files`.
 
 diff.external::
 	If this config variable is set, diff generation is not
@@ -568,7 +568,7 @@ diff.external::
 
 diff.renameLimit::
 	The number of files to consider when performing the copy/rename
-	detection; equivalent to the git diff option '-l'.
+	detection; equivalent to the git-diff option '-l'.
 
 diff.renames::
 	Tells git to detect renames.  If set to any boolean value, it
@@ -608,7 +608,7 @@ format.pretty::
 
 gc.aggressiveWindow::
 	The window size parameter used in the delta compression
-	algorithm used by 'git gc --aggressive'.  This defaults
+	algorithm used by 'git-gc --aggressive'.  This defaults
 	to 10.
 
 gc.auto::
@@ -625,37 +625,37 @@ gc.autopacklimit::
 	default	value is 50.  Setting this to 0 disables it.
 
 gc.packrefs::
-	`git gc` does not run `git pack-refs` in a bare repository by
+	`git-gc` does not run `git pack-refs` in a bare repository by
 	default so that older dumb-transport clients can still fetch
-	from the repository.  Setting this to `true` lets `git gc`
+	from the repository.  Setting this to `true` lets `git-gc`
 	to run `git pack-refs`.  Setting this to `false` tells
-	`git gc` never to run `git pack-refs`. The default setting is
+	`git-gc` never to run `git pack-refs`. The default setting is
 	`notbare`. Enable it only when you know you do not have to
 	support such clients.  The default setting will change to `true`
 	at some stage, and setting this to `false` will continue to
-	prevent `git pack-refs` from being run from `git gc`.
+	prevent `git pack-refs` from being run from `git-gc`.
 
 gc.pruneexpire::
-	When `git gc` is run, it will call `prune --expire 2.weeks.ago`.
+	When `git-gc` is run, it will call `prune --expire 2.weeks.ago`.
 	Override the grace period with this config variable.
 
 gc.reflogexpire::
-	`git reflog expire` removes reflog entries older than
+	`git-reflog expire` removes reflog entries older than
 	this time; defaults to 90 days.
 
 gc.reflogexpireunreachable::
-	`git reflog expire` removes reflog entries older than
+	`git-reflog expire` removes reflog entries older than
 	this time and are not reachable from the current tip;
 	defaults to 30 days.
 
 gc.rerereresolved::
 	Records of conflicted merge you resolved earlier are
-	kept for this many days when `git rerere gc` is run.
+	kept for this many days when `git-rerere gc` is run.
 	The default is 60 days.  See linkgit:git-rerere[1].
 
 gc.rerereunresolved::
 	Records of conflicted merge you have not resolved are
-	kept for this many days when `git rerere gc` is run.
+	kept for this many days when `git-rerere gc` is run.
 	The default is 15 days.  See linkgit:git-rerere[1].
 
 rerere.autoupdate::
@@ -849,7 +849,7 @@ instaweb.port::
 
 log.date::
 	Set default date-time mode for the log command. Setting log.date
-	value is similar to using git log's --date option. The value is one of
+	value is similar to using git-log's --date option. The value is one of the
 	following alternatives: {relative,local,default,iso,rfc,short}.
 	See linkgit:git-log[1].
 
diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 8bbcb94..a13983f 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -26,7 +26,7 @@ on the subcommand:
  git bisect log
  git bisect run <cmd>...
 
-This command uses `git rev-list --bisect` to help drive the
+This command uses `git-rev-list --bisect` to help drive the
 binary search process to find which change introduced a bug, given an
 old "good" commit object name and a later "bad" commit object name.
 
@@ -101,7 +101,7 @@ $ git bisect visualize
 to see the currently remaining suspects in `gitk`.  `visualize` is a bit
 too long to type and `view` is provided as a synonym.
 
-If `DISPLAY` environment variable is not set, `git log` is used
+If 'DISPLAY' environment variable is not set, `git-log` is used
 instead.  You can even give command line options such as `-p` and
 `--stat`.
 
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 0ac6204..9812dbd 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -155,7 +155,7 @@ but can be used to amend a merge commit.
 	Make a commit only from the paths specified on the
 	command line, disregarding any contents that have been
 	staged so far. This is the default mode of operation of
-	'git commit' if any paths are given on the command line,
+	'git-commit' if any paths are given on the command line,
 	in which case this option can be omitted.
 	If this option is specified together with '--amend', then
 	no paths need be specified, which can be used to amend
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index a9388e0..4262309 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -163,7 +163,7 @@ to other tags will be rewritten to point to the underlying commit.
 
 -f::
 --force::
-	`git filter-branch` refuses to start with an existing temporary
+	`git-filter-branch` refuses to start with an existing temporary
 	directory or when there are already refs starting with
 	'refs/original/', unless forced.
 
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index b990052..41e487a 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -190,7 +190,7 @@ EXAMPLES
 the current branch using `git-am` to cherry-pick them:
 +
 ------------
-$ git format-patch -k --stdout R1..R2 | git-am -3 -k
+$ git format-patch -k --stdout R1..R2 | git am -3 -k
 ------------
 
 * Extract all commits which are in the current branch but not in the
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 5ace863..73ec7ad 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -120,7 +120,7 @@ man.<tool>.path
 You can explicitly provide a full path to your preferred man viewer by
 setting the configuration variable 'man.<tool>.path'. For example, you
 can configure the absolute path to konqueror by setting
-'man.konqueror.path'. Otherwise, 'git help' assumes the tool is
+'man.konqueror.path'. Otherwise, 'git-help' assumes the tool is
 available in PATH.
 
 man.<tool>.cmd
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 754230e..67aa497 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -259,10 +259,10 @@ NOTES
 When you rebase a branch, you are changing its history in a way that
 will cause problems for anyone who already has a copy of the branch
 in their repository and tries to pull updates from you.  You should
-understand the implications of using 'git rebase' on a repository that
+understand the implications of using 'git-rebase' on a repository that
 you share.
 
-When the git rebase command is run, it will first execute a "pre-rebase"
+When the git-rebase command is run, it will first execute a "pre-rebase"
 hook if one exists.  You can use this hook to do sanity checks and
 reject the rebase if it isn't appropriate.  Please see the template
 pre-rebase hook script for an example.
diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 8492aea..d963c51 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -60,7 +60,7 @@ OPTIONS
 	refs.
 +
 This computation involves traversing all the reachable objects, i.e. it
-has the same cost as 'git prune'.  Fortunately, once this is run, we
+has the same cost as 'git-prune'.  Fortunately, once this is run, we
 should not have to ever worry about missing objects, because the current
 prune and pack-objects know about reflogs and protect objects referred by
 them.
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 32db0ae..3634efd 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -124,7 +124,7 @@ $ git checkout -b nfs linux-nfs/master
 ...
 ------------
 
-* Imitate 'git clone' but track only selected branches
+* Imitate 'git-clone' but track only selected branches
 +
 ------------
 $ mkdir project.git
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index 3458029..ae2b2b5 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -163,7 +163,7 @@ If this three-way merge resolves cleanly, the result is written
 out to your working tree file, so you would not have to manually
 resolve it.  Note that `git-rerere` leaves the index file alone,
 so you still need to do the final sanity checks with `git diff`
-(or `git diff -c`) and `git add` when you are satisfied.
+(or `git diff -c`) and `git-add` when you are satisfied.
 
 As a convenience measure, `git-merge` automatically invokes
 `git-rerere` when it exits with a failed automerge, which
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 6e4cbc4..74a5f29 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -3,7 +3,7 @@ git-shortlog(1)
 
 NAME
 ----
-git-shortlog - Summarize 'git log' output
+git-shortlog - Summarize 'git-log' output
 
 SYNOPSIS
 --------
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 7d721c5..059c8ff 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -595,7 +595,7 @@ pointer to the state you want to tag, but also a small tag name and
 message, along with optionally a PGP signature that says that yes,
 you really did
 that tag. You create these annotated tags with either the `-a` or
-`-s` flag to `git tag`:
+`-s` flag to `git-tag`:
 
 ----------------
 $ git tag -s <tagname>
@@ -642,7 +642,7 @@ and it will be gone. There's no external repository, and there's no
 history outside the project you created.
 
  - if you want to move or duplicate a git repository, you can do so. There
-   is `git clone` command, but if all you want to do is just to
+   is `git-clone` command, but if all you want to do is just to
    create a copy of your repository (with all the full history that
    went along with it), you can do so with a regular
    `cp -a git-tutorial new-git-tutorial`.
@@ -776,7 +776,7 @@ to it.
 ================================================
 If you make the decision to start your new branch at some
 other point in the history than the current `HEAD`, you can do so by
-just telling `git checkout` what the base of the checkout would be.
+just telling `git-checkout` what the base of the checkout would be.
 In other words, if you have an earlier tag or branch, you'd just do
 
 ------------
@@ -819,7 +819,7 @@ $ git branch <branchname> [startingpoint]
 
 which will simply _create_ the branch, but will not do anything further.
 You can then later -- once you decide that you want to actually develop
-on that branch -- switch to that branch with a regular `git checkout`
+on that branch -- switch to that branch with a regular `git-checkout`
 with the branchname as the argument.
 
 
@@ -881,7 +881,7 @@ source.
 Anyway, let's exit `gitk` (`^Q` or the File menu), and decide that we want
 to merge the work we did on the `mybranch` branch into the `master`
 branch (which is currently our `HEAD` too). To do that, there's a nice
-script called `git merge`, which wants to know which branches you want
+script called `git-merge`, which wants to know which branches you want
 to resolve and what the merge is all about:
 
 ------------
@@ -1023,12 +1023,12 @@ Merging external work
 It's usually much more common that you merge with somebody else than
 merging with your own branches, so it's worth pointing out that git
 makes that very easy too, and in fact, it's not that different from
-doing a `git merge`. In fact, a remote merge ends up being nothing
+doing a `git-merge`. In fact, a remote merge ends up being nothing
 more than "fetch the work from a remote repository into a temporary tag"
-followed by a `git merge`.
+followed by a `git-merge`.
 
 Fetching from a remote repository is done by, unsurprisingly,
-`git fetch`:
+`git-fetch`:
 
 ----------------
 $ git fetch <remote-repository>
@@ -1115,7 +1115,7 @@ argument.
 [NOTE]
 You could do without using any branches at all, by
 keeping as many local repositories as you would like to have
-branches, and merging between them with `git pull`, just like
+branches, and merging between them with `git-pull`, just like
 you merge between branches. The advantage of this approach is
 that it lets you keep a set of files for each `branch` checked
 out and you may find it easier to switch back and forth if you
@@ -1132,7 +1132,7 @@ like this:
 $ git config remote.linus.url http://www.kernel.org/pub/scm/git/git.git/
 ------------------------------------------------
 
-and use the "linus" keyword with `git pull` instead of the full URL.
+and use the "linus" keyword with `git-pull` instead of the full URL.
 
 Examples.
 
@@ -1168,7 +1168,7 @@ $ git show-branch --more=2 master mybranch
 +* [master^] Some fun.
 ------------
 
-Remember, before running `git merge`, our `master` head was at
+Remember, before running `git-merge`, our `master` head was at
 "Some fun." commit, while our `mybranch` head was at "Some
 work." commit.
 
@@ -1345,7 +1345,7 @@ $ mkdir my-git.git
 ------------
 
 Then, make that directory into a git repository by running
-`git init`, but this time, since its name is not the usual
+`git-init`, but this time, since its name is not the usual
 `.git`, we do things slightly differently:
 
 ------------
@@ -1407,7 +1407,7 @@ $ git repack
 
 will do it for you. If you followed the tutorial examples, you
 would have accumulated about 17 objects in `.git/objects/??/`
-directories by now. `git repack` tells you how many objects it
+directories by now. `git-repack` tells you how many objects it
 packed, and stores the packed file in `.git/objects/pack`
 directory.
 
@@ -1656,8 +1656,8 @@ $ git reset --hard master~2
 ------------
 
 You can make sure 'git show-branch' matches the state before
-those two 'git merge' you just did.  Then, instead of running
-two 'git merge' commands in a row, you would merge these two
+those two 'git-merge' you just did.  Then, instead of running
+two 'git-merge' commands in a row, you would merge these two
 branch heads (this is known as 'making an Octopus'):
 
 ------------
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 61cf30f..01c1af6 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1963,10 +1963,10 @@ error: failed to push to 'ssh://yourserver.com/~you/proj.git'
 
 This can happen, for example, if you:
 
-	- use `git reset --hard` to remove already-published commits, or
-	- use `git commit --amend` to replace already-published commits
+	- use `git-reset --hard` to remove already-published commits, or
+	- use `git-commit --amend` to replace already-published commits
 	  (as in <<fixing-a-mistake-by-rewriting-history>>), or
-	- use `git rebase` to rebase any already-published commits (as
+	- use `git-rebase` to rebase any already-published commits (as
 	  in <<using-git-rebase>>).
 
 You may force git-push to perform the update anyway by preceding the
@@ -2170,7 +2170,7 @@ they are for, or what status they are in.  To get a reminder of what
 changes are in a specific branch, use:
 
 -------------------------------------------------
-$ git log linux..branchname | git-shortlog
+$ git log linux..branchname | git shortlog
 -------------------------------------------------
 
 To see whether it has already been merged into the test or release branches,
@@ -2443,7 +2443,7 @@ patches to the new mywork.  The result will look like:
 ................................................
 
 In the process, it may discover conflicts.  In that case it will stop
-and allow you to fix the conflicts; after fixing conflicts, use "git add"
+and allow you to fix the conflicts; after fixing conflicts, use "git-add"
 to update the index with those contents, and then, instead of
 running git-commit, just run
 
@@ -2700,7 +2700,7 @@ master branch.  In more detail:
 git fetch and fast-forwards
 ---------------------------
 
-In the previous example, when updating an existing branch, "git fetch"
+In the previous example, when updating an existing branch, "git-fetch"
 checks to make sure that the most recent commit on the remote
 branch is a descendant of the most recent commit on your copy of the
 branch before updating your copy of the branch to point at the new
@@ -2726,7 +2726,7 @@ resulting in a situation like:
             o--o--o <-- new head of the branch
 ................................................
 
-In this case, "git fetch" will fail, and print out a warning.
+In this case, "git-fetch" will fail, and print out a warning.
 
 In that case, you can still force git to update to the new head, as
 described in the following section.  However, note that in the
@@ -3106,7 +3106,7 @@ $ git prune
 
 to remove any of the "loose" objects that are now contained in the
 pack.  This will also remove any unreferenced objects (which may be
-created when, for example, you use "git reset" to remove a commit).
+created when, for example, you use "git-reset" to remove a commit).
 You can verify that the loose objects are gone by looking at the
 .git/objects directory or by running
 
@@ -3135,7 +3135,7 @@ branch still exists, as does everything it pointed to. The branch
 pointer itself just doesn't, since you replaced it with another one.
 
 There are also other situations that cause dangling objects. For
-example, a "dangling blob" may arise because you did a "git add" of a
+example, a "dangling blob" may arise because you did a "git-add" of a
 file, but then, before you actually committed it and made it part of the
 bigger picture, you changed something else in that file and committed
 that *updated* thing--the old state that you added originally ends up
@@ -3185,7 +3185,7 @@ Usually, dangling blobs and trees aren't very interesting. They're
 almost always the result of either being a half-way mergebase (the blob
 will often even have the conflict markers from a merge in it, if you
 have had conflicting merges that you fixed up by hand), or simply
-because you interrupted a "git fetch" with ^C or something like that,
+because you interrupted a "git-fetch" with ^C or something like that,
 leaving _some_ of the new objects in the object database, but just
 dangling and useless.
 
@@ -3694,7 +3694,7 @@ removed. The only thing `--remove` means is that update-index will be
 considering a removed file to be a valid thing, and if the file really
 does not exist any more, it will update the index accordingly.
 
-As a special case, you can also do `git-update-index --refresh`, which
+As a special case, you can also do `git update-index --refresh`, which
 will refresh the "stat" information of each index to match the current
 stat information. It will 'not' update the object status itself, and
 it will only update the fields that are used to quickly test whether
@@ -3770,7 +3770,7 @@ from one representation to the other:
 Tying it all together
 ~~~~~~~~~~~~~~~~~~~~~
 
-To commit a tree you have instantiated with "git-write-tree", you'd
+To commit a tree you have instantiated with "git write-tree", you'd
 create a "commit" object that refers to that tree and the history
 behind it--most notably the "parent" commits that preceded it in
 history.
@@ -3927,7 +3927,7 @@ $ git read-tree -m -u <origtree> <yourtree> <targettree>
 
 which will do all trivial merge operations for you directly in the
 index file, and you can just write the result out with
-`git-write-tree`.
+`git write-tree`.
 
 
 [[merging-multiple-trees-2]]
@@ -4095,7 +4095,7 @@ functions like `get_sha1_basic()` or the likes.
 This is just to get you into the groove for the most libified part of Git:
 the revision walker.
 
-Basically, the initial version of `git log` was a shell script:
+Basically, the initial version of `git-log` was a shell script:
 
 ----------------------------------------------------------------
 $ git-rev-list --pretty $(git-rev-parse --default HEAD "$@") | \
@@ -4130,7 +4130,7 @@ just have a look at the first implementation of `cmd_log()`; call
 `git show v1.3.0{tilde}155^2{tilde}4` and scroll down to that function (note that you
 no longer need to call `setup_pager()` directly).
 
-Nowadays, `git log` is a builtin, which means that it is _contained_ in the
+Nowadays, `git-log` is a builtin, which means that it is _contained_ in the
 command `git`.  The source side of a builtin is
 
 - a function called `cmd_<bla>`, typically defined in `builtin-<bla>.c`,
@@ -4146,7 +4146,7 @@ since they share quite a bit of code.  In that case, the commands which are
 _not_ named like the `.c` file in which they live have to be listed in
 `BUILT_INS` in the `Makefile`.
 
-`git log` looks more complicated in C than it does in the original script,
+`git-log` looks more complicated in C than it does in the original script,
 but that allows for a much greater flexibility and performance.
 
 Here again it is a good point to take a pause.
@@ -4157,9 +4157,9 @@ the organization of Git (after you know the basic concepts).
 So, think about something which you are interested in, say, "how can I
 access a blob just knowing the object name of it?".  The first step is to
 find a Git command with which you can do it.  In this example, it is either
-`git show` or `git cat-file`.
+`git-show` or `git-cat-file`.
 
-For the sake of clarity, let's stay with `git cat-file`, because it
+For the sake of clarity, let's stay with `git-cat-file`, because it
 
 - is plumbing, and
 
-- 
1.5.5.GIT
