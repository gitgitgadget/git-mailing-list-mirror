From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/2] More missed dashed 'git-cmd' forms
Date: Sun, 10 Jan 2010 13:10:54 +0100
Message-ID: <48822ef1fee0a734817bad9f63e122e4d1d66106.1263123648.git.trast@student.ethz.ch>
References: <201001101310.21455.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 10 13:11:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTwdP-0006xY-ME
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 13:11:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697Ab0AJMLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 07:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752531Ab0AJMLA
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 07:11:00 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:24939 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752022Ab0AJMK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 07:10:57 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sun, 10 Jan
 2010 13:10:55 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sun, 10 Jan
 2010 13:10:55 +0100
X-Mailer: git-send-email 1.6.6.218.g502b0
In-Reply-To: <201001101310.21455.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136570>

Squashed into the corresponding commit of the original series.
---
 Documentation/config.txt                |   14 +++++++-------
 Documentation/git-archive.txt           |    2 +-
 Documentation/git-commit.txt            |    2 +-
 Documentation/git-daemon.txt            |    4 ++--
 Documentation/git-diff-index.txt        |    4 ++--
 Documentation/git-diff-tree.txt         |    6 +++---
 Documentation/git-for-each-ref.txt      |    2 +-
 Documentation/git-gc.txt                |    2 +-
 Documentation/git-get-tar-commit-id.txt |    2 +-
 Documentation/git-help.txt              |    2 +-
 Documentation/git-instaweb.txt          |    2 +-
 Documentation/git-log.txt               |    2 +-
 Documentation/git-ls-files.txt          |    2 +-
 Documentation/git-mailinfo.txt          |    2 +-
 Documentation/git-merge-index.txt       |    2 +-
 Documentation/git-merge-one-file.txt    |    4 ++--
 Documentation/git-prune.txt             |    2 +-
 Documentation/git-read-tree.txt         |    2 +-
 Documentation/git-repack.txt            |    2 +-
 Documentation/git-rerere.txt            |    2 +-
 Documentation/git-rev-parse.txt         |    4 ++--
 Documentation/git-show-index.txt        |    2 +-
 Documentation/git-show.txt              |    2 +-
 Documentation/git-tag.txt               |    2 +-
 Documentation/git-tar-tree.txt          |    2 +-
 Documentation/git-update-index.txt      |    8 ++++----
 Documentation/git-upload-archive.txt    |    2 +-
 Documentation/git-web--browse.txt       |    4 ++--
 Documentation/gitcore-tutorial.txt      |   12 ++++++------
 Documentation/gitdiffcore.txt           |   18 +++++++++---------
 Documentation/githooks.txt              |    8 ++++----
 Documentation/gitrepository-layout.txt  |    2 +-
 32 files changed, 64 insertions(+), 64 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 937dfbe..5d549ca 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -443,7 +443,7 @@ core.pager::
 core.whitespace::
 	A comma separated list of common whitespace problems to
 	notice.  'git diff' will use `color.diff.whitespace` to
-	highlight them, and 'git-apply --whitespace=error' will
+	highlight them, and 'git apply --whitespace=error' will
 	consider them as errors.  You can prefix `-` to disable
 	any of them (e.g. `-trailing-space`):
 +
@@ -673,7 +673,7 @@ color.interactive::
 	colors only when the output is to the terminal. Defaults to false.
 
 color.interactive.<slot>::
-	Use customized color for 'git-add --interactive'
+	Use customized color for 'git add --interactive'
 	output. `<slot>` may be `prompt`, `header`, `help` or `error`, for
 	four distinct types of normal output from interactive
 	commands.  The values of these variables may be specified as
@@ -858,7 +858,7 @@ format.signoff::
 
 gc.aggressiveWindow::
 	The window size parameter used in the delta compression
-	algorithm used by 'git-gc --aggressive'.  This defaults
+	algorithm used by 'git gc --aggressive'.  This defaults
 	to 10.
 
 gc.auto::
@@ -889,22 +889,22 @@ gc.pruneexpire::
 	unreachable objects immediately.
 
 gc.reflogexpire::
-	'git-reflog expire' removes reflog entries older than
+	'git reflog expire' removes reflog entries older than
 	this time; defaults to 90 days.
 
 gc.reflogexpireunreachable::
-	'git-reflog expire' removes reflog entries older than
+	'git reflog expire' removes reflog entries older than
 	this time and are not reachable from the current tip;
 	defaults to 30 days.
 
 gc.rerereresolved::
 	Records of conflicted merge you resolved earlier are
-	kept for this many days when 'git-rerere gc' is run.
+	kept for this many days when 'git rerere gc' is run.
 	The default is 60 days.  See linkgit:git-rerere[1].
 
 gc.rerereunresolved::
 	Records of conflicted merge you have not resolved are
-	kept for this many days when 'git-rerere gc' is run.
+	kept for this many days when 'git rerere gc' is run.
 	The default is 15 days.  See linkgit:git-rerere[1].
 
 gitcvs.commitmsgannotation::
diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 980bc62..799c8b6 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -27,7 +27,7 @@ used as the modification time of each file in the archive.  In the latter
 case the commit time as recorded in the referenced commit object is
 used instead.  Additionally the commit ID is stored in a global
 extended pax header if the tar format is used; it can be extracted
-using 'git-get-tar-commit-id'. In ZIP files it is stored as a file
+using 'git get-tar-commit-id'. In ZIP files it is stored as a file
 comment.
 
 OPTIONS
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 8914543..c322c75 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -40,7 +40,7 @@ The content to be added can be specified in several ways:
 
 5. by using the --interactive switch with the 'commit' command to decide one
    by one which files should be part of the commit, before finalizing the
-   operation.  Currently, this is done by invoking 'git-add --interactive'.
+   operation.  Currently, this is done by invoking 'git add --interactive'.
 
 The `--dry-run` option can be used to obtain a
 summary of what is included by any of the above for the next
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index ece232e..01c9f8e 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -181,7 +181,7 @@ upload-pack::
 	item to `false`.
 
 upload-archive::
-	This serves 'git-archive --remote'.  It is disabled by
+	This serves 'git archive --remote'.  It is disabled by
 	default, but a repository can enable it by setting
 	`daemon.uploadarch` configuration item to `true`.
 
@@ -258,7 +258,7 @@ Repositories can still be accessed by hostname though, assuming
 they correspond to these IP addresses.
 
 selectively enable/disable services per repository::
-	To enable 'git-archive --remote' and disable 'git fetch' against
+	To enable 'git archive --remote' and disable 'git fetch' against
 	a repository, have the following in the configuration file in the
 	repository (that is the file 'config' next to 'HEAD', 'refs' and
 	'objects').
diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-index.txt
index 84acf49..162cb74 100644
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -72,7 +72,7 @@ In fact, `git diff-index --cached` *should* always be entirely equivalent to
 actually doing a 'git write-tree' and comparing that. Except this one is much
 nicer for the case where you just want to check where you are.
 
-So doing a 'git-diff-index --cached' is basically very useful when you are
+So doing a `git diff-index --cached` is basically very useful when you are
 asking yourself "what have I already marked for being committed, and
 what's the difference to a previous tree".
 
@@ -87,7 +87,7 @@ The non-cached version asks the question:
   tree - index contents _and_ files that aren't up-to-date
 
 which is obviously a very useful question too, since that tells you what
-you *could* commit. Again, the output matches the 'git-diff-tree -r'
+you *could* commit. Again, the output matches the 'git diff-tree -r'
 output to a tee, but with a twist.
 
 The twist is that if some file doesn't match the index, we don't have
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 95c402a..a7e37b8 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -67,19 +67,19 @@ The following flags further affect the behavior when comparing
 commits (but not trees).
 
 -m::
-	By default, 'git-diff-tree --stdin' does not show
+	By default, 'git diff-tree --stdin' does not show
 	differences for merge commits.  With this flag, it shows
 	differences to that commit from all of its parents. See
 	also '-c'.
 
 -s::
-	By default, 'git-diff-tree --stdin' shows differences,
+	By default, 'git diff-tree --stdin' shows differences,
 	either in machine-readable form (without '-p') or in patch
 	form (with '-p').  This output can be suppressed.  It is
 	only useful with '-v' flag.
 
 -v::
-	This flag causes 'git-diff-tree --stdin' to also show
+	This flag causes 'git diff-tree --stdin' to also show
 	the commit message before the differences.
 
 include::pretty-options.txt[]
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 8dc873f..7e83288 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -82,7 +82,7 @@ objecttype::
 	The type of the object (`blob`, `tree`, `commit`, `tag`).
 
 objectsize::
-	The size of the object (the same as 'git-cat-file -s' reports).
+	The size of the object (the same as 'git cat-file -s' reports).
 
 objectname::
 	The object name (aka SHA-1).
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 07f211f..771807f 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -50,7 +50,7 @@ Housekeeping is required if there are too many loose objects or
 too many packs in the repository. If the number of loose objects
 exceeds the value of the `gc.auto` configuration variable, then
 all loose objects are combined into a single pack using
-'git-repack -d -l'.  Setting the value of `gc.auto` to 0
+'git repack -d -l'.  Setting the value of `gc.auto` to 0
 disables automatic packing of loose objects.
 +
 If the number of packs exceeds the value of `gc.autopacklimit`,
diff --git a/Documentation/git-get-tar-commit-id.txt b/Documentation/git-get-tar-commit-id.txt
index 94c434b..790af95 100644
--- a/Documentation/git-get-tar-commit-id.txt
+++ b/Documentation/git-get-tar-commit-id.txt
@@ -17,7 +17,7 @@ Acts as a filter, extracting the commit ID stored in archives created by
 'git archive'.  It reads only the first 1024 bytes of input, thus its
 runtime is not influenced by the size of <tarfile> very much.
 
-If no commit ID is found, 'git-get-tar-commit-id' quietly exists with a
+If no commit ID is found, 'git get-tar-commit-id' quietly exists with a
 return code of 1.  This can happen if <tarfile> had not been created
 using 'git archive' or if the first parameter of 'git archive' had been
 a tree ID instead of a commit ID or tag.
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index ce41b65..f8df109 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -55,7 +55,7 @@ other display programs (see below).
 +
 The web browser can be specified using the configuration variable
 'help.browser', or 'web.browser' if the former is not set. If none of
-these config variables is set, the 'git-web--browse' helper script
+these config variables is set, the 'git web--browse' helper script
 (called by 'git help') will pick a suitable default. See
 linkgit:git-web--browse[1] for more information about this.
 
diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instaweb.txt
index 0771f25..a1f17df 100644
--- a/Documentation/git-instaweb.txt
+++ b/Documentation/git-instaweb.txt
@@ -44,7 +44,7 @@ OPTIONS
 -b::
 --browser::
 	The web browser that should be used to view the gitweb
-	page. This will be passed to the 'git-web--browse' helper
+	page. This will be passed to the 'git web--browse' helper
 	script along with the URL of the gitweb instance. See
 	linkgit:git-web--browse[1] for more information about this. If
 	the script fails, the URL will be printed to stdout.
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index cb12f09..ff4063b 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -16,7 +16,7 @@ Shows the commit logs.
 
 The command takes options applicable to the 'git rev-list'
 command to control what is shown and how, and options applicable to
-the 'git-diff-*' commands to control how the changes
+the 'git diff-*' commands to control how the changes
 each commit introduces are shown.
 
 
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 92b21d7..7faba23 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -145,7 +145,7 @@ which case it outputs:
 
         [<tag> ]<mode> <object> <stage> <file>
 
-'git-ls-files --unmerged' and 'git-ls-files --stage' can be used to examine
+'git ls-files --unmerged' and 'git ls-files --stage' can be used to examine
 detailed information on unmerged paths.
 
 For an unmerged path, instead of recording a single mode/SHA1 pair,
diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index a524252..e3d58cb 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -30,7 +30,7 @@ OPTIONS
 	whitespaces, (3) '[' up to ']', typically '[PATCH]', and
 	then prepends "[PATCH] ".  This flag forbids this
 	munging, and is most useful when used to read back
-	'git-format-patch -k' output.
+	'git format-patch -k' output.
 
 -b::
 	When -k is not in effect, all leading strings bracketed with '['
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index 493f061..4d266de 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -43,7 +43,7 @@ code.
 Typically this is run with a script calling git's imitation of
 the 'merge' command from the RCS package.
 
-A sample script called 'git-merge-one-file' is included in the
+A sample script called 'git merge-one-file' is included in the
 distribution.
 
 ALERT ALERT ALERT! The git "merge object order" is different from the
diff --git a/Documentation/git-merge-one-file.txt b/Documentation/git-merge-one-file.txt
index 7360202..a163cfc 100644
--- a/Documentation/git-merge-one-file.txt
+++ b/Documentation/git-merge-one-file.txt
@@ -8,12 +8,12 @@ git-merge-one-file - The standard helper program to use with git-merge-index
 
 SYNOPSIS
 --------
-'git-merge-one-file'
+'git merge-one-file'
 
 DESCRIPTION
 -----------
 This is the standard helper program to use with 'git merge-index'
-to resolve a merge after the trivial merge done with 'git-read-tree -m'.
+to resolve a merge after the trivial merge done with 'git read-tree -m'.
 
 Author
 ------
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index 437d7c4..3bb7304 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -16,7 +16,7 @@ DESCRIPTION
 NOTE: In most cases, users should run 'git gc', which calls
 'git prune'. See the section "NOTES", below.
 
-This runs 'git-fsck --unreachable' using all the refs
+This runs 'git fsck --unreachable' using all the refs
 available in `$GIT_DIR/refs`, optionally with additional set of
 objects specified on the command line, and prunes all unpacked
 objects unreachable from any of these head objects from the object database.
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 469cd69..a31a4cb 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -298,7 +298,7 @@ populated.  Here is an outline of how the algorithm works:
     trivial rules ..
 
 You would normally use 'git merge-index' with supplied
-'git-merge-one-file' to do this last step.  The script updates
+'git merge-one-file' to do this last step.  The script updates
 the files in the working tree as it merges each path and at the
 end of a successful merge.
 
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 50a5c96..538895c 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -71,7 +71,7 @@ other objects in that pack they already have locally.
 
 -n::
 	Do not update the server information with
-	'git-update-server-info'.  This option skips
+	'git update-server-info'.  This option skips
 	updating local catalog files needed to publish
 	this repository (or a direct copy of it)
 	over HTTP or FTP.  See linkgit:git-update-server-info[1].
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index 8dab467..acc220a 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -37,7 +37,7 @@ its working state.
 'clear'::
 
 This resets the metadata used by rerere if a merge resolution is to be
-aborted.  Calling 'git-am [--skip|--abort]' or 'git-rebase [--skip|--abort]'
+aborted.  Calling 'git am [--skip|--abort]' or 'git rebase [--skip|--abort]'
 will automatically invoke this command.
 
 'diff'::
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index fff4cb8..82ae16e 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -74,7 +74,7 @@ OPTIONS
 	properly quoted for consumption by shell.  Useful when
 	you expect your parameter to contain whitespaces and
 	newlines (e.g. when using pickaxe `-S` with
-	'git-diff-\*'). In contrast to the `--sq-quote` option,
+	'git diff-\*'). In contrast to the `--sq-quote` option,
 	the command input is still interpreted as usual.
 
 --not::
@@ -361,7 +361,7 @@ usage on the standard error stream, and exits with code 129.
 Input Format
 ~~~~~~~~~~~~
 
-'git-rev-parse --parseopt' input format is fully text based. It has two parts,
+'git rev-parse --parseopt' input format is fully text based. It has two parts,
 separated by a line that contains only `--`. The lines before the separator
 (should be more than one) are used for the usage.
 The lines after the separator describe the options.
diff --git a/Documentation/git-show-index.txt b/Documentation/git-show-index.txt
index deebdc8..8382fbe 100644
--- a/Documentation/git-show-index.txt
+++ b/Documentation/git-show-index.txt
@@ -17,7 +17,7 @@ Reads given idx file for packed git archive created with
 'git pack-objects' command, and dumps its contents.
 
 The information it outputs is subset of what you can get from
-'git-verify-pack -v'; this command only shows the packfile
+'git verify-pack -v'; this command only shows the packfile
 offset and SHA1 of each object.
 
 
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index de83d6b..55e687a 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -16,7 +16,7 @@ Shows one or more objects (blobs, trees, tags and commits).
 
 For commits it shows the log message and textual diff. It also
 presents the merge commit in a special format as produced by
-'git-diff-tree --cc'.
+'git diff-tree --cc'.
 
 For tags, it shows the tag message and the referenced objects.
 
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 518bf98..31c78a8 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -131,7 +131,7 @@ and be done with it.
 
 . The insane thing.
 You really want to call the new version "X" too, 'even though'
-others have already seen the old one. So just use 'git-tag -f'
+others have already seen the old one. So just use 'git tag -f'
 again, as if you hadn't already published the old one.
 
 However, Git does *not* (and it should not) change tags behind
diff --git a/Documentation/git-tar-tree.txt b/Documentation/git-tar-tree.txt
index 7c116ec..3c786bd 100644
--- a/Documentation/git-tar-tree.txt
+++ b/Documentation/git-tar-tree.txt
@@ -24,7 +24,7 @@ a commit ID or tag ID.  In the first case the current time is used as
 modification time of each file in the archive.  In the latter case the
 commit time as recorded in the referenced commit object is used instead.
 Additionally the commit ID is stored in a global extended pax header.
-It can be extracted using 'git-get-tar-commit-id'.
+It can be extracted using 'git get-tar-commit-id'.
 
 OPTIONS
 -------
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index c2477b9..e8c19be 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -206,7 +206,7 @@ into the index file.
     . mode         SP sha1 SP stage TAB path
 +
 This format is to put higher order stages into the
-index file and matches 'git-ls-files --stage' output.
+index file and matches 'git ls-files --stage' output.
 
 To place a higher stage entry to the index, the path should
 first be removed by feeding a mode=0 entry for the path, and
@@ -263,8 +263,8 @@ option.  To unset, use `--no-assume-unchanged`.
 The command looks at `core.ignorestat` configuration variable.  When
 this is true, paths updated with `git update-index paths...` and
 paths updated with other git commands that update both index and
-working tree (e.g. 'git-apply --index', 'git-checkout-index -u',
-and 'git-read-tree -u') are automatically marked as "assume
+working tree (e.g. 'git apply --index', 'git checkout-index -u',
+and 'git read-tree -u') are automatically marked as "assume
 unchanged".  Note that "assume unchanged" bit is *not* set if
 `git update-index --refresh` finds the working tree file matches
 the index (use `git update-index --really-refresh` if you want
@@ -317,7 +317,7 @@ unreliable, this should be set to 'false' (see linkgit:git-config[1]).
 This causes the command to ignore differences in file modes recorded
 in the index and the file mode on the filesystem if they differ only on
 executable bit.   On such an unfortunate filesystem, you may
-need to use 'git-update-index --chmod='.
+need to use 'git update-index --chmod='.
 
 Quite similarly, if `core.symlinks` configuration variable is set
 to 'false' (see linkgit:git-config[1]), symbolic links are checked out
diff --git a/Documentation/git-upload-archive.txt b/Documentation/git-upload-archive.txt
index afe6595..f5f2b39 100644
--- a/Documentation/git-upload-archive.txt
+++ b/Documentation/git-upload-archive.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Invoked by 'git-archive --remote' and sends a generated archive to the
+Invoked by 'git archive --remote' and sends a generated archive to the
 other end over the git protocol.
 
 This command is usually not invoked directly by the end user.  The UI
diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index 91a54a6..7572049 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -62,7 +62,7 @@ browser.<tool>.path
 You can explicitly provide a full path to your preferred browser by
 setting the configuration variable 'browser.<tool>.path'. For example,
 you can configure the absolute path to firefox by setting
-'browser.firefox.path'. Otherwise, 'git-web--browse' assumes the tool
+'browser.firefox.path'. Otherwise, 'git web--browse' assumes the tool
 is available in PATH.
 
 browser.<tool>.cmd
@@ -71,7 +71,7 @@ browser.<tool>.cmd
 When the browser, specified by options or configuration variables, is
 not among the supported ones, then the corresponding
 'browser.<tool>.cmd' configuration variable will be looked up. If this
-variable exists then 'git-web--browse' will treat the specified tool
+variable exists then 'git web--browse' will treat the specified tool
 as a custom command and will use a shell eval to run the command with
 the URLs passed as arguments.
 
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 202a379..c005f37 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -428,7 +428,7 @@ $ git update-index hello
 (note how we didn't need the `\--add` flag this time, since git knew
 about the file already).
 
-Note what happens to the different 'git-diff-\*' versions here. After
+Note what happens to the different 'git diff-\*' versions here. After
 we've updated `hello` in the index, `git diff-files -p` now shows no
 differences, but `git diff-index -p HEAD` still *does* show that the
 current state is different from the state we committed. In fact, now
@@ -1095,7 +1095,7 @@ The 'commit walkers' are sometimes also called 'dumb
 transports', because they do not require any git aware smart
 server like git Native transport does.  Any stock HTTP server
 that does not even support directory index would suffice.  But
-you must prepare your repository with 'git-update-server-info'
+you must prepare your repository with 'git update-server-info'
 to help dumb transport downloaders.
 
 Once you fetch from the remote repository, you `merge` that
@@ -1260,7 +1260,7 @@ $ git ls-files --unmerged
 
 The next step of merging is to merge these three versions of the
 file, using 3-way merge.  This is done by giving
-'git-merge-one-file' command as one of the arguments to
+'git merge-one-file' command as one of the arguments to
 'git merge-index' command:
 
 ------------
@@ -1270,7 +1270,7 @@ ERROR: Merge conflict in hello
 fatal: merge program failed
 ------------
 
-'git-merge-one-file' script is called with parameters to
+'git merge-one-file' script is called with parameters to
 describe those three versions, and is responsible to leave the
 merge results in the working tree.
 It is a fairly straightforward shell script, and
@@ -1487,10 +1487,10 @@ If other people are pulling from your repository over dumb
 transport protocols (HTTP), you need to keep this repository
 'dumb transport friendly'.  After `git init`,
 `$GIT_DIR/hooks/post-update.sample` copied from the standard templates
-would contain a call to 'git-update-server-info'
+would contain a call to 'git update-server-info'
 but you need to manually enable the hook with
 `mv post-update.sample post-update`.  This makes sure
-'git-update-server-info' keeps the necessary files up-to-date.
+'git update-server-info' keeps the necessary files up-to-date.
 
 3. Push into the public repository from your primary
    repository.
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 5244925..dcdea54 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -23,7 +23,7 @@ that is easier to understand than the conventional kind.
 The chain of operation
 ----------------------
 
-The 'git-diff-{asterisk}' family works by first comparing two sets of
+The 'git diff-{asterisk}' family works by first comparing two sets of
 files:
 
  - 'git diff-index' compares contents of a "tree" object and the
@@ -74,12 +74,12 @@ into another list.  There are currently 5 such transformations:
 - diffcore-pickaxe
 - diffcore-order
 
-These are applied in sequence.  The set of filepairs 'git-diff-{asterisk}'
+These are applied in sequence.  The set of filepairs 'git diff-{asterisk}'
 commands find are used as the input to diffcore-break, and
 the output from diffcore-break is used as the input to the
 next transformation.  The final result is then passed to the
 output routine and generates either diff-raw format (see Output
-format sections of the manual for 'git-diff-{asterisk}' commands) or
+format sections of the manual for 'git diff-{asterisk}' commands) or
 diff-patch format.
 
 
@@ -87,7 +87,7 @@ diffcore-break: For Splitting Up "Complete Rewrites"
 ----------------------------------------------------
 
 The second transformation in the chain is diffcore-break, and is
-controlled by the -B option to the 'git-diff-{asterisk}' commands.  This is
+controlled by the -B option to the 'git diff-{asterisk}' commands.  This is
 used to detect a filepair that represents "complete rewrite" and
 break such filepair into two filepairs that represent delete and
 create.  E.g.  If the input contained this filepair:
@@ -123,7 +123,7 @@ diffcore-rename: For Detection Renames and Copies
 
 This transformation is used to detect renames and copies, and is
 controlled by the -M option (to detect renames) and the -C option
-(to detect copies as well) to the 'git-diff-{asterisk}' commands.  If the
+(to detect copies as well) to the 'git diff-{asterisk}' commands.  If the
 input contained these filepairs:
 
 ------------------------------------------------
@@ -168,11 +168,11 @@ number after the "-M" or "-C" option (e.g. "-M8" to tell it to use
 8/10 = 80%).
 
 Note.  When the "-C" option is used with `\--find-copies-harder`
-option, 'git-diff-{asterisk}' commands feed unmodified filepairs to
+option, 'git diff-{asterisk}' commands feed unmodified filepairs to
 diffcore mechanism as well as modified ones.  This lets the copy
 detector consider unmodified files as copy source candidates at
 the expense of making it slower.  Without `\--find-copies-harder`,
-'git-diff-{asterisk}' commands can detect copies only if the file that was
+'git diff-{asterisk}' commands can detect copies only if the file that was
 copied happened to have been modified in the same changeset.
 
 
@@ -223,7 +223,7 @@ diffcore-pickaxe: For Detecting Addition/Deletion of Specified String
 
 This transformation is used to find filepairs that represent
 changes that touch a specified string, and is controlled by the
--S option and the `\--pickaxe-all` option to the 'git-diff-{asterisk}'
+-S option and the `\--pickaxe-all` option to the 'git diff-{asterisk}'
 commands.
 
 When diffcore-pickaxe is in use, it checks if there are
@@ -246,7 +246,7 @@ diffcore-order: For Sorting the Output Based on Filenames
 
 This is used to reorder the filepairs according to the user's
 (or project's) taste, and is controlled by the -O option to the
-'git-diff-{asterisk}' commands.
+'git diff-{asterisk}' commands.
 
 This takes a text file each of whose lines is a shell glob
 pattern.  Filepairs that match a glob pattern on an earlier line
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 45559fa..87e2c03 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -202,7 +202,7 @@ updated. If the hook exits with zero, updating of individual refs can
 still be prevented by the <<update,'update'>> hook.
 
 Both standard output and standard error output are forwarded to
-'git-send-pack' on the other end, so you can simply `echo` messages
+'git send-pack' on the other end, so you can simply `echo` messages
 for the user.
 
 [[update]]
@@ -301,7 +301,7 @@ updated values of the refs. You might consider it instead if you need
 them.
 
 When enabled, the default 'post-update' hook runs
-'git-update-server-info' to keep the information used by dumb
+'git update-server-info' to keep the information used by dumb
 transports (e.g., HTTP) up-to-date.  If you are publishing
 a git repository that is accessible via HTTP, you should
 probably enable this hook.
@@ -313,8 +313,8 @@ for the user.
 pre-auto-gc
 ~~~~~~~~~~~
 
-This hook is invoked by 'git-gc --auto'. It takes no parameter, and
-exiting with non-zero status from this script causes the 'git-gc --auto'
+This hook is invoked by 'git gc --auto'. It takes no parameter, and
+exiting with non-zero status from this script causes the 'git gc --auto'
 to abort.
 
 GIT
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index 5c4700c..3cd32d6 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -151,7 +151,7 @@ info/refs::
 	This file helps dumb transports discover what refs are
 	available in this repository.  If the repository is
 	published for dumb transports, this file should be
-	regenerated by 'git-update-server-info' every time a tag
+	regenerated by 'git update-server-info' every time a tag
 	or branch is created or modified.  This is normally done
 	from the `hooks/update` hook, which is run by the
 	'git-receive-pack' command when you 'git push' into the
-- 
1.6.6.218.g502b0
