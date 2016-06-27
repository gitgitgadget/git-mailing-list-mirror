Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_20,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 752BB2018A
	for <e@80x24.org>; Mon, 27 Jun 2016 17:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbcF0Rqr (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 13:46:47 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36722 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751638AbcF0Rqq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 13:46:46 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u5RHkafW011966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 27 Jun 2016 19:46:36 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u5RHkbQc004426;
	Mon, 27 Jun 2016 19:46:37 +0200
From:	Matthieu Moy <Matthieu.Moy@imag.fr>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org,
	Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>,
	Samuel GROOT <samuel.groot@ensimag.grenoble-inp.fr>,
	Erwan MATHONIERE <erwan.mathoniere@ensimag.grenoble-inp.fr>,
	Tom RUSSELLO <tom.russello@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/6] doc: typeset short command-line options as literal
Date:	Mon, 27 Jun 2016 19:46:18 +0200
Message-Id: <20160627174623.11084-1-Matthieu.Moy@imag.fr>
X-Mailer: git-send-email 2.8.2.397.gbe91ebf.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Mon, 27 Jun 2016 19:46:36 +0200 (CEST)
X-IMAG-MailScanner-Information:	Please contact MI2S MIM  for more information
X-MailScanner-ID: u5RHkafW011966
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check:	1467654398.93583@FyzlbYGH5GRJDYOlsZVlLw
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

It was common in our documentation to surround short option names with
forward quotes, which renders as italic in HTML. Instead, use backquotes
which renders as monospace. This is one more step toward conformance to
Documentation/CodingGuidelines.

This was obtained with:

  perl -pi -e "s/'(-[a-z])'/\`\$1\`/g" *.txt

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/config.txt              |  8 ++++----
 Documentation/diff-config.txt         |  2 +-
 Documentation/diff-format.txt         |  8 ++++----
 Documentation/diff-generate-patch.txt |  4 ++--
 Documentation/git-cat-file.txt        | 12 ++++++------
 Documentation/git-checkout.txt        |  4 ++--
 Documentation/git-clean.txt           |  2 +-
 Documentation/git-commit-tree.txt     |  2 +-
 Documentation/git-commit.txt          |  2 +-
 Documentation/git-cvsimport.txt       |  6 +++---
 Documentation/git-cvsserver.txt       |  8 ++++----
 Documentation/git-diff-tree.txt       | 14 +++++++-------
 Documentation/git-fetch-pack.txt      |  2 +-
 Documentation/git-filter-branch.txt   |  2 +-
 Documentation/git-grep.txt            |  2 +-
 Documentation/git-help.txt            |  4 ++--
 Documentation/git-ls-tree.txt         |  4 ++--
 Documentation/git-mktree.txt          |  2 +-
 Documentation/git-mv.txt              |  2 +-
 Documentation/git-notes.txt           |  2 +-
 Documentation/git-repack.txt          |  4 ++--
 Documentation/git-shell.txt           |  4 ++--
 Documentation/git.txt                 |  4 ++--
 23 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ef77f03..c483785 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -913,7 +913,7 @@ browser.<tool>.cmd::
 
 browser.<tool>.path::
 	Override the path for the given tool that may be used to
-	browse HTML help (see '-w' option in linkgit:git-help[1]) or a
+	browse HTML help (see `-w` option in linkgit:git-help[1]) or a
 	working repository in gitweb (see linkgit:git-instaweb[1]).
 
 clean.requireForce::
@@ -1394,9 +1394,9 @@ gitcvs.logFile::
 
 gitcvs.usecrlfattr::
 	If true, the server will look up the end-of-line conversion
-	attributes for files to determine the '-k' modes to use. If
+	attributes for files to determine the `-k` modes to use. If
 	the attributes force Git to treat a file as text,
-	the '-k' mode will be left blank so CVS clients will
+	the `-k` mode will be left blank so CVS clients will
 	treat it as text. If they suppress text conversion, the file
 	will be set with '-kb' mode, which suppresses any newline munging
 	the client might otherwise do. If the attributes do not allow
@@ -1466,7 +1466,7 @@ gitweb.snapshot::
 	See linkgit:gitweb.conf[5] for description.
 
 grep.lineNumber::
-	If set to true, enable '-n' option by default.
+	If set to true, enable `-n` option by default.
 
 grep.patternType::
 	Set the default matching behavior. Using a value of 'basic', 'extended',
diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 7513795..0ddb7a6 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -105,7 +105,7 @@ diff.orderFile::
 
 diff.renameLimit::
 	The number of files to consider when performing the copy/rename
-	detection; equivalent to the 'git diff' option '-l'.
+	detection; equivalent to the 'git diff' option `-l`.
 
 diff.renames::
 	Tells Git to detect renames.  If set to any boolean value, it
diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index 85b0890..f10fd54 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -46,11 +46,11 @@ That is, from the left to the right:
 . sha1 for "dst"; 0\{40\} if creation, unmerged or "look at work tree".
 . a space.
 . status, followed by optional "score" number.
-. a tab or a NUL when '-z' option is used.
+. a tab or a NUL when `-z` option is used.
 . path for "src"
-. a tab or a NUL when '-z' option is used; only exists for C or R.
+. a tab or a NUL when `-z` option is used; only exists for C or R.
 . path for "dst"; only exists for C or R.
-. an LF or a NUL when '-z' option is used, to terminate the record.
+. an LF or a NUL when `-z` option is used, to terminate the record.
 
 Possible status letters are:
 
@@ -86,7 +86,7 @@ diff format for merges
 ----------------------
 
 "git-diff-tree", "git-diff-files" and "git-diff --raw"
-can take '-c' or '--cc' option
+can take `-c` or '--cc' option
 to generate diff output also for merge commits.  The output differs
 from the format described above in the following way:
 
diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index c91afee..18608f5 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -2,7 +2,7 @@ Generating patches with -p
 --------------------------
 
 When "git-diff-index", "git-diff-tree", or "git-diff-files" are run
-with a '-p' option, "git diff" without the '--raw' option, or
+with a `-p` option, "git diff" without the '--raw' option, or
 "git log" with the "-p" option, they
 do not produce the output described above; instead they produce a
 patch file.  You can customize the creation of such patches via the
@@ -114,7 +114,7 @@ index fabadb8,cc95eb0..4866510
 ------------
 
 1.   It is preceded with a "git diff" header, that looks like
-     this (when '-c' option is used):
+     this (when `-c` option is used):
 
        diff --combined file
 +
diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index eb3d694..f8d0dcf 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -15,8 +15,8 @@ SYNOPSIS
 DESCRIPTION
 -----------
 In its first form, the command provides the content or the type of an object in
-the repository. The type is required unless '-t' or '-p' is used to find the
-object type, or '-s' is used to find the object size, or '--textconv' is used
+the repository. The type is required unless `-t` or `-p` is used to find the
+object type, or `-s` is used to find the object size, or '--textconv' is used
 (which implies type "blob").
 
 In the second form, a list of objects (separated by linefeeds) is provided on
@@ -144,13 +144,13 @@ respectively print:
 
 OUTPUT
 ------
-If '-t' is specified, one of the <type>.
+If `-t` is specified, one of the <type>.
 
-If '-s' is specified, the size of the <object> in bytes.
+If `-s` is specified, the size of the <object> in bytes.
 
-If '-e' is specified, no output.
+If `-e` is specified, no output.
 
-If '-p' is specified, the contents of <object> are pretty-printed.
+If `-p` is specified, the contents of <object> are pretty-printed.
 
 If <type> is specified, the raw (though uncompressed) contents of the <object>
 will be returned.
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 5e5273e..7a2201b 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -157,7 +157,7 @@ of it").
 	When creating a new branch, set up "upstream" configuration. See
 	"--track" in linkgit:git-branch[1] for details.
 +
-If no '-b' option is given, the name of the new branch will be
+If no `-b` option is given, the name of the new branch will be
 derived from the remote-tracking branch, by looking at the local part of
 the refspec configured for the corresponding remote, and then stripping
 the initial part up to the "*".
@@ -165,7 +165,7 @@ This would tell us to use "hack" as the local branch when branching
 off of "origin/hack" (or "remotes/origin/hack", or even
 "refs/remotes/origin/hack").  If the given name has no slash, or the above
 guessing results in an empty name, the guessing is aborted.  You can
-explicitly give a name with '-b' in such a case.
+explicitly give a name with `-b` in such a case.
 
 --no-track::
 	Do not set up "upstream" configuration, even if the
diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 51a7e26..03056da 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -16,7 +16,7 @@ DESCRIPTION
 Cleans the working tree by recursively removing files that are not
 under version control, starting from the current directory.
 
-Normally, only files unknown to Git are removed, but if the '-x'
+Normally, only files unknown to Git are removed, but if the `-x`
 option is specified, ignored files are also removed. This can, for
 example, be useful to remove all build products.
 
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index 48c33d7..ff13025 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -44,7 +44,7 @@ OPTIONS
 	An existing tree object
 
 -p <parent>::
-	Each '-p' indicates the id of a parent commit object.
+	Each `-p` indicates the id of a parent commit object.
 
 -m <message>::
 	A paragraph in the commit log message. This can be given more than
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 19ee2dd..2afda81 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -75,7 +75,7 @@ OPTIONS
 
 -c <commit>::
 --reedit-message=<commit>::
-	Like '-C', but with '-c' the editor is invoked, so that
+	Like '-C', but with `-c` the editor is invoked, so that
 	the user can further edit the commit message.
 
 --fixup=<commit>::
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 00a0679..bbf1c2b 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -103,7 +103,7 @@ the old cvs2git tool.
 
 -p <options-for-cvsps>::
 	Additional options for cvsps.
-	The options '-u' and '-A' are implicit and should not be used here.
+	The options `-u` and '-A' are implicit and should not be used here.
 +
 If you need to pass multiple options, separate them with a comma.
 
@@ -122,7 +122,7 @@ If you need to pass multiple options, separate them with a comma.
 
 -M <regex>::
 	Attempt to detect merges based on the commit message with a custom
-	regex. It can be used with '-m' to enable the default regexes
+	regex. It can be used with `-m` to enable the default regexes
 	as well. You must escape forward slashes.
 +
 The regex must capture the source branch name in $1.
@@ -186,7 +186,7 @@ messages, bug-tracking systems, email archives, and the like.
 
 OUTPUT
 ------
-If '-v' is specified, the script reports what it is doing.
+If `-v` is specified, the script reports what it is doing.
 
 Otherwise, success is indicated the Unix way, i.e. by simply exiting with
 a zero exit status.
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index db4d7a9..5e3c6a8 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -402,12 +402,12 @@ Exports and tagging (tags and branches) are not supported at this stage.
 CRLF Line Ending Conversions
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-By default the server leaves the '-k' mode blank for all files,
+By default the server leaves the `-k` mode blank for all files,
 which causes the CVS client to treat them as a text files, subject
 to end-of-line conversion on some platforms.
 
 You can make the server use the end-of-line conversion attributes to
-set the '-k' modes for files by setting the `gitcvs.usecrlfattr`
+set the `-k` modes for files by setting the `gitcvs.usecrlfattr`
 config variable.  See linkgit:gitattributes[5] for more information
 about end-of-line conversion.
 
@@ -415,9 +415,9 @@ Alternatively, if `gitcvs.usecrlfattr` config is not enabled
 or the attributes do not allow automatic detection for a filename, then
 the server uses the `gitcvs.allBinary` config for the default setting.
 If `gitcvs.allBinary` is set, then file not otherwise
-specified will default to '-kb' mode. Otherwise the '-k' mode
+specified will default to '-kb' mode. Otherwise the `-k` mode
 is left blank. But if `gitcvs.allBinary` is set to "guess", then
-the correct '-k' mode will be guessed based on the contents of
+the correct `-k` mode will be guessed based on the contents of
 the file.
 
 For best consistency with 'cvs', it is probably best to override the
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 1439486..7558e49 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -70,13 +70,13 @@ commits (but not trees).
 	By default, 'git diff-tree --stdin' does not show
 	differences for merge commits.  With this flag, it shows
 	differences to that commit from all of its parents. See
-	also '-c'.
+	also `-c`.
 
 -s::
 	By default, 'git diff-tree --stdin' shows differences,
-	either in machine-readable form (without '-p') or in patch
-	form (with '-p').  This output can be suppressed.  It is
-	only useful with '-v' flag.
+	either in machine-readable form (without `-p`) or in patch
+	form (with `-p`).  This output can be suppressed.  It is
+	only useful with `-v` flag.
 
 -v::
 	This flag causes 'git diff-tree --stdin' to also show
@@ -94,14 +94,14 @@ include::pretty-options.txt[]
 	one <tree-ish>, or '--stdin').  It shows the differences
 	from each of the parents to the merge result simultaneously
 	instead of showing pairwise diff between a parent and the
-	result one at a time (which is what the '-m' option does).
+	result one at a time (which is what the `-m` option does).
 	Furthermore, it lists only files which were modified
 	from all parents.
 
 --cc::
 	This flag changes the way a merge commit patch is displayed,
-	in a similar way to the '-c' option. It implies the '-c'
-	and '-p' options and further compresses the patch output
+	in a similar way to the `-c` option. It implies the `-c`
+	and `-p` options and further compresses the patch output
 	by omitting uninteresting hunks whose the contents in the parents
 	have only two variants and the merge result picks one of them
 	without modification.  When all hunks are uninteresting, the commit
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index 239623c..4c8219d 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -47,7 +47,7 @@ be in a separate packet, and the list must end with a flush packet.
 
 -q::
 --quiet::
-	Pass '-q' flag to 'git unpack-objects'; this makes the
+	Pass `-q` flag to 'git unpack-objects'; this makes the
 	cloning process less verbose.
 
 -k::
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index bd560d3..2d30297 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -52,7 +52,7 @@ if different from the rewritten ones, will be stored in the namespace
 
 Note that since this operation is very I/O expensive, it might
 be a good idea to redirect the temporary directory off-disk with the
-'-d' option, e.g. on tmpfs.  Reportedly the speedup is very noticeable.
+`-d` option, e.g. on tmpfs.  Reportedly the speedup is very noticeable.
 
 
 Filters
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 40cfe37..557973b 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -41,7 +41,7 @@ CONFIGURATION
 -------------
 
 grep.lineNumber::
-	If set to true, enable '-n' option by default.
+	If set to true, enable `-n` option by default.
 
 grep.patternType::
 	Set the default matching behavior. Using a value of 'basic', 'extended',
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 338b8d6..c6f7ce7 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -18,10 +18,10 @@ With no options and no COMMAND or GUIDE given, the synopsis of the 'git'
 command and a list of the most commonly used Git commands are printed
 on the standard output.
 
-If the option '--all' or '-a' is given, all available commands are
+If the option '--all' or `-a` is given, all available commands are
 printed on the standard output.
 
-If the option '--guide' or '-g' is given, a list of the useful
+If the option '--guide' or `-g` is given, a list of the useful
 Git guides is also printed on the standard output.
 
 If a command, or a guide, is given, a manual page for that command or
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 16e87fd..a9f1909 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -20,7 +20,7 @@ in the current working directory.  Note that:
 
  - the behaviour is slightly different from that of "/bin/ls" in that the
    '<path>' denotes just a list of patterns to match, e.g. so specifying
-   directory name (without '-r') will behave differently, and order of the
+   directory name (without `-r`) will behave differently, and order of the
    arguments does not matter.
 
  - the behaviour is similar to that of "/bin/ls" in that the '<path>' is
@@ -46,7 +46,7 @@ OPTIONS
 
 -t::
 	Show tree entries even when going to recurse them. Has no effect
-	if '-r' was not passed. '-d' implies '-t'.
+	if `-r` was not passed. `-d` implies `-t`.
 
 -l::
 --long::
diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
index 5c6ebdf..c3616e7 100644
--- a/Documentation/git-mktree.txt
+++ b/Documentation/git-mktree.txt
@@ -32,7 +32,7 @@ OPTIONS
 --batch::
 	Allow building of more than one tree object before exiting.  Each
 	tree is separated by as single blank line. The final new-line is
-	optional.  Note - if the '-z' option is used, lines are terminated
+	optional.  Note - if the `-z` option is used, lines are terminated
 	with NUL.
 
 GIT
diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index e453132..cbae886 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -35,7 +35,7 @@ OPTIONS
         Skip move or rename actions which would lead to an error
 	condition. An error happens when a source is neither existing nor
 	controlled by Git, or when it would overwrite an existing
-        file unless '-f' is given.
+        file unless `-f` is given.
 -n::
 --dry-run::
 	Do nothing; only show what would happen
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 02a10bc..be7db30 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -152,7 +152,7 @@ OPTIONS
 
 -c <object>::
 --reedit-message=<object>::
-	Like '-C', but with '-c' the editor is invoked, so that
+	Like '-C', but with `-c` the editor is invoked, so that
 	the user can further edit the note message.
 
 --allow-empty::
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index b9c02ce..0c03eec 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -33,7 +33,7 @@ OPTIONS
 	pack everything referenced into a single pack.
 	Especially useful when packing a repository that is used
 	for private development. Use
-	with '-d'.  This will clean up the objects that `git prune`
+	with `-d`.  This will clean up the objects that `git prune`
 	leaves behind, but `git fsck --full --dangling` shows as
 	dangling.
 +
@@ -42,7 +42,7 @@ whole new pack in order to get any contained object, no matter how many
 other objects in that pack they already have locally.
 
 -A::
-	Same as `-a`, unless '-d' is used.  Then any unreachable
+	Same as `-a`, unless `-d` is used.  Then any unreachable
 	objects in a previous pack become loose, unpacked objects,
 	instead of being left in the old pack.  Unreachable objects
 	are never intentionally added to a pack, even when repacking.
diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
index e4bdd22..2e30a3e 100644
--- a/Documentation/git-shell.txt
+++ b/Documentation/git-shell.txt
@@ -24,7 +24,7 @@ named `git-shell-commands` in the user's home directory.
 COMMANDS
 --------
 
-'git shell' accepts the following commands after the '-c' option:
+'git shell' accepts the following commands after the `-c` option:
 
 'git receive-pack <argument>'::
 'git upload-pack <argument>'::
@@ -43,7 +43,7 @@ directory.
 INTERACTIVE USE
 ---------------
 
-By default, the commands above can be executed only with the '-c'
+By default, the commands above can be executed only with the `-c`
 option; the shell is not interactive.
 
 If a `~/git-shell-commands` directory is present, 'git shell'
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 25ef006..24efc63 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -508,7 +508,7 @@ OPTIONS
 
 --help::
 	Prints the synopsis and a list of the most commonly used
-	commands. If the option '--all' or '-a' is given then all
+	commands. If the option '--all' or `-a` is given then all
 	available commands are printed. If a Git command is named this
 	option will bring up the manual page for that command.
 +
@@ -974,7 +974,7 @@ other
 	The command will be given exactly two or four arguments: the
 	'username@host' (or just 'host') from the URL and the shell
 	command to execute on that remote system, optionally preceded by
-	'-p' (literally) and the 'port' from the URL when it specifies
+	`-p` (literally) and the 'port' from the URL when it specifies
 	something other than the default SSH port.
 +
 `$GIT_SSH_COMMAND` takes precedence over `$GIT_SSH`, and is interpreted
-- 
2.8.2.397.gbe91ebf.dirty

