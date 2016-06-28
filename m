Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16D071FF40
	for <e@80x24.org>; Tue, 28 Jun 2016 11:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430AbcF1Lln (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 07:41:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42724 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752257AbcF1Ll1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 07:41:27 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u5SBeL7k028887
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 28 Jun 2016 13:40:21 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u5SBeHF5019214;
	Tue, 28 Jun 2016 13:40:23 +0200
From:	Matthieu Moy <Matthieu.Moy@imag.fr>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org,
	Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>,
	Samuel GROOT <samuel.groot@ensimag.grenoble-inp.fr>,
	Erwan MATHONIERE <erwan.mathoniere@ensimag.grenoble-inp.fr>,
	Tom RUSSELLO <tom.russello@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 3/7] doc: typeset long command-line options as literal
Date:	Tue, 28 Jun 2016 13:40:11 +0200
Message-Id: <20160628114015.25828-4-Matthieu.Moy@imag.fr>
X-Mailer: git-send-email 2.8.2.397.gbe91ebf.dirty
In-Reply-To: <20160628114015.25828-1-Matthieu.Moy@imag.fr>
References: <20160627174623.11084-1-Matthieu.Moy@imag.fr>
 <20160628114015.25828-1-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Tue, 28 Jun 2016 13:40:21 +0200 (CEST)
X-IMAG-MailScanner-Information:	Please contact MI2S MIM  for more information
X-MailScanner-ID: u5SBeL7k028887
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check:	1467718823.51928@cnD2uaKb42skp6jAq4ND5Q
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Similarly to the previous commit, use backquotes instead of
forward-quotes, for long options.

This was obtained with:

  perl -pi -e "s/'(--[a-z][a-z=<>-]*)'/\`\$1\`/g" *.txt

and manual tweak to remove false positive in ascii-art (o'--o'--o' to
describe rewritten history).

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/config.txt                 | 32 ++++++++++++++++----------------
 Documentation/diff-format.txt            |  2 +-
 Documentation/diff-generate-patch.txt    |  4 ++--
 Documentation/fetch-options.txt          |  6 +++---
 Documentation/git-am.txt                 |  4 ++--
 Documentation/git-branch.txt             |  2 +-
 Documentation/git-cat-file.txt           |  2 +-
 Documentation/git-cherry-pick.txt        |  2 +-
 Documentation/git-commit.txt             |  2 +-
 Documentation/git-config.txt             | 26 +++++++++++++-------------
 Documentation/git-credential-store.txt   |  2 +-
 Documentation/git-cvsserver.txt          |  2 +-
 Documentation/git-daemon.txt             |  6 +++---
 Documentation/git-describe.txt           |  2 +-
 Documentation/git-diff-index.txt         |  4 ++--
 Documentation/git-diff-tree.txt          |  6 +++---
 Documentation/git-difftool.txt           |  2 +-
 Documentation/git-fetch-pack.txt         |  2 +-
 Documentation/git-filter-branch.txt      |  4 ++--
 Documentation/git-for-each-ref.txt       |  2 +-
 Documentation/git-fsck.txt               |  2 +-
 Documentation/git-grep.txt               |  8 ++++----
 Documentation/git-help.txt               |  6 +++---
 Documentation/git-http-push.txt          |  4 ++--
 Documentation/git-interpret-trailers.txt |  2 +-
 Documentation/git-ls-files.txt           |  2 +-
 Documentation/git-p4.txt                 | 20 ++++++++++----------
 Documentation/git-push.txt               |  2 +-
 Documentation/git-rebase.txt             | 10 +++++-----
 Documentation/git-remote.txt             | 10 +++++-----
 Documentation/git-revert.txt             |  4 ++--
 Documentation/git-send-email.txt         | 24 ++++++++++++------------
 Documentation/git-send-pack.txt          | 10 +++++-----
 Documentation/git-show-branch.txt        |  2 +-
 Documentation/git-show-ref.txt           |  6 +++---
 Documentation/git-svn.txt                | 26 +++++++++++++-------------
 Documentation/git-tag.txt                |  2 +-
 Documentation/git-update-index.txt       | 14 +++++++-------
 Documentation/git-web--browse.txt        |  2 +-
 Documentation/git.txt                    |  8 ++++----
 Documentation/gitcore-tutorial.txt       |  2 +-
 Documentation/gitdiffcore.txt            |  4 ++--
 Documentation/gitk.txt                   |  2 +-
 Documentation/gitmodules.txt             |  2 +-
 Documentation/gitremote-helpers.txt      |  8 ++++----
 Documentation/revisions.txt              |  2 +-
 46 files changed, 149 insertions(+), 149 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6d5e5ba..556ed0e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -140,7 +140,7 @@ boolean::
        false;; Boolean false can be spelled as `no`, `off`,
 		`false`, or `0`.
 +
-When converting value to the canonical form using '--bool' type
+When converting value to the canonical form using `--bool` type
 specifier; 'git config' will ensure that the output is "true" or
 "false" (spelled in lowercase).
 
@@ -481,7 +481,7 @@ core.worktree::
 	If `GIT_COMMON_DIR` environment variable is set, core.worktree
 	is ignored and not used for determining the root of working tree.
 	This can be overridden by the `GIT_WORK_TREE` environment
-	variable and the '--work-tree' command-line option.
+	variable and the `--work-tree` command-line option.
 	The value can be an absolute path or relative to the path to
 	the .git directory, which is either specified by --git-dir
 	or GIT_DIR, or automatically discovered.
@@ -779,7 +779,7 @@ core.abbrev::
 add.ignoreErrors::
 add.ignore-errors (deprecated)::
 	Tells 'git add' to continue adding files when some files cannot be
-	added due to indexing errors. Equivalent to the '--ignore-errors'
+	added due to indexing errors. Equivalent to the `--ignore-errors`
 	option of linkgit:git-add[1].  `add.ignore-errors` is deprecated,
 	as it does not follow the usual naming convention for configuration
 	variables.
@@ -805,9 +805,9 @@ from the original current directory. See linkgit:git-rev-parse[1].
 
 am.keepcr::
 	If true, git-am will call git-mailsplit for patches in mbox format
-	with parameter '--keep-cr'. In this case git-mailsplit will
+	with parameter `--keep-cr`. In this case git-mailsplit will
 	not remove `\r` from lines ending with `\r\n`. Can be overridden
-	by giving '--no-keep-cr' from the command line.
+	by giving `--no-keep-cr` from the command line.
 	See linkgit:git-am[1], linkgit:git-mailsplit[1].
 
 am.threeWay::
@@ -820,7 +820,7 @@ am.threeWay::
 
 apply.ignoreWhitespace::
 	When set to 'change', tells 'git apply' to ignore changes in
-	whitespace, in the same way as the '--ignore-space-change'
+	whitespace, in the same way as the `--ignore-space-change`
 	option.
 	When set to one of: no, none, never, false tells 'git apply' to
 	respect all whitespace differences.
@@ -828,7 +828,7 @@ apply.ignoreWhitespace::
 
 apply.whitespace::
 	Tells 'git apply' how to handle whitespaces, in the same way
-	as the '--whitespace' option. See linkgit:git-apply[1].
+	as the `--whitespace` option. See linkgit:git-apply[1].
 
 branch.autoSetupMerge::
 	Tells 'git branch' and 'git checkout' to set up new branches
@@ -1505,12 +1505,12 @@ grep.lineNumber::
 
 grep.patternType::
 	Set the default matching behavior. Using a value of 'basic', 'extended',
-	'fixed', or 'perl' will enable the '--basic-regexp', '--extended-regexp',
-	'--fixed-strings', or '--perl-regexp' option accordingly, while the
+	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
+	`--fixed-strings`, or `--perl-regexp` option accordingly, while the
 	value 'default' will return to the default matching behavior.
 
 grep.extendedRegexp::
-	If set to true, enable '--extended-regexp' option by default. This
+	If set to true, enable `--extended-regexp` option by default. This
 	option is ignored when the `grep.patternType` option is set to a value
 	other than 'default'.
 
@@ -1967,7 +1967,7 @@ log.decorate::
 	specified, the full ref name (including prefix) will be printed.
 	If 'auto' is specified, then if the output is going to a terminal,
 	the ref names are shown as if 'short' were given, otherwise no ref
-	names are shown. This is the same as the '--decorate' option
+	names are shown. This is the same as the `--decorate` option
 	of the `git log`.
 
 log.follow::
@@ -2350,16 +2350,16 @@ new default).
 --
 
 push.followTags::
-	If set to true enable '--follow-tags' option by default.  You
+	If set to true enable `--follow-tags` option by default.  You
 	may override this configuration at time of push by specifying
-	'--no-follow-tags'.
+	`--no-follow-tags`.
 
 push.gpgSign::
 	May be set to a boolean value, or the string 'if-asked'. A true
-	value causes all pushes to be GPG signed, as if '--signed' is
+	value causes all pushes to be GPG signed, as if `--signed` is
 	passed to linkgit:git-push[1]. The string 'if-asked' causes
 	pushes to be signed if the server supports it, as if
-	'--signed=if-asked' is passed to 'git push'. A false value may
+	`--signed=if-asked` is passed to 'git push'. A false value may
 	override a value from a lower-priority config file. An explicit
 	command-line flag always overrides this config option.
 
@@ -2382,7 +2382,7 @@ rebase.stat::
 	rebase. False by default.
 
 rebase.autoSquash::
-	If set to true enable '--autosquash' option by default.
+	If set to true enable `--autosquash` option by default.
 
 rebase.autoStash::
 	When set to true, automatically create a temporary stash
diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index f10fd54..cf52626 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -86,7 +86,7 @@ diff format for merges
 ----------------------
 
 "git-diff-tree", "git-diff-files" and "git-diff --raw"
-can take `-c` or '--cc' option
+can take `-c` or `--cc` option
 to generate diff output also for merge commits.  The output differs
 from the format described above in the following way:
 
diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 18608f5..d2a7ff5 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -2,7 +2,7 @@ Generating patches with -p
 --------------------------
 
 When "git-diff-index", "git-diff-tree", or "git-diff-files" are run
-with a `-p` option, "git diff" without the '--raw' option, or
+with a `-p` option, "git diff" without the `--raw` option, or
 "git log" with the "-p" option, they
 do not produce the output described above; instead they produce a
 patch file.  You can customize the creation of such patches via the
@@ -118,7 +118,7 @@ index fabadb8,cc95eb0..4866510
 
        diff --combined file
 +
-or like this (when '--cc' option is used):
+or like this (when `--cc` option is used):
 
        diff --cc file
 
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index b05a834..9eab1f5 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -88,7 +88,7 @@ ifndef::git-pull[]
 	to whatever else would otherwise be fetched.  Using this
 	option alone does not subject tags to pruning, even if --prune
 	is used (though tags may be pruned anyway if they are also the
-	destination of an explicit refspec; see '--prune').
+	destination of an explicit refspec; see `--prune`).
 
 --recurse-submodules[=yes|on-demand|no]::
 	This option controls if and under what conditions new commits of
@@ -110,7 +110,7 @@ ifndef::git-pull[]
 
 --no-recurse-submodules::
 	Disable recursive fetching of submodules (this has the same effect as
-	using the '--recurse-submodules=no' option).
+	using the `--recurse-submodules=no` option).
 
 --submodule-prefix=<path>::
 	Prepend <path> to paths printed in informative messages
@@ -137,7 +137,7 @@ endif::git-pull[]
 
 --upload-pack <upload-pack>::
 	When given, and the repository to fetch from is handled
-	by 'git fetch-pack', '--exec=<upload-pack>' is passed to
+	by 'git fetch-pack', `--exec=<upload-pack>` is passed to
 	the command to specify non-default path for the command
 	run on the other end.
 
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 13cdd7f..8dd9e4f 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -198,12 +198,12 @@ When initially invoking `git am`, you give it the names of the mailboxes
 to process.  Upon seeing the first patch that does not apply, it
 aborts in the middle.  You can recover from this in one of two ways:
 
-. skip the current patch by re-running the command with the '--skip'
+. skip the current patch by re-running the command with the `--skip`
   option.
 
 . hand resolve the conflict in the working directory, and update
   the index file to bring it into a state that the patch should
-  have produced.  Then run the command with the '--continue' option.
+  have produced.  Then run the command with the `--continue` option.
 
 The command refuses to process new mailboxes until the current
 operation is finished, so if you decide to start over from scratch,
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 4a7037f..123144f 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -172,7 +172,7 @@ This option is only applicable in non-verbose mode.
 +
 This behavior is the default when the start point is a remote-tracking branch.
 Set the branch.autoSetupMerge configuration variable to `false` if you
-want `git checkout` and `git branch` to always behave as if '--no-track'
+want `git checkout` and `git branch` to always behave as if `--no-track`
 were given. Set it to `always` if you want this behavior when the
 start-point is either a local or remote-tracking branch.
 
diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index f8d0dcf..18d03d8 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -16,7 +16,7 @@ DESCRIPTION
 -----------
 In its first form, the command provides the content or the type of an object in
 the repository. The type is required unless `-t` or `-p` is used to find the
-object type, or `-s` is used to find the object size, or '--textconv' is used
+object type, or `-s` is used to find the object size, or `--textconv` is used
 (which implies type "blob").
 
 In the second form, a list of objects (separated by linefeeds) is provided on
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index c104a59..d35d771 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -47,7 +47,7 @@ OPTIONS
 	For a more complete list of ways to spell commits, see
 	linkgit:gitrevisions[7].
 	Sets of commits can be passed but no traversal is done by
-	default, as if the '--no-walk' option was specified, see
+	default, as if the `--no-walk` option was specified, see
 	linkgit:git-rev-list[1]. Note that specifying a range will
 	feed all <commit>... arguments to a single revision walk
 	(see a later example that uses 'maint master..next').
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index e295d49..b0a294d 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -260,7 +260,7 @@ FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
 	staged for other paths. This is the default mode of operation of
 	'git commit' if any paths are given on the command line,
 	in which case this option can be omitted.
-	If this option is specified together with '--amend', then
+	If this option is specified together with `--amend`, then
 	no paths need to be specified, which can be used to amend
 	the last commit without committing changes that have
 	already been staged.
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index a89c304..79905fb 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -31,29 +31,29 @@ You can query/set/replace/unset options with this command. The name is
 actually the section and the key separated by a dot, and the value will be
 escaped.
 
-Multiple lines can be added to an option by using the '--add' option.
+Multiple lines can be added to an option by using the `--add` option.
 If you want to update or unset an option which can occur on multiple
 lines, a POSIX regexp `value_regex` needs to be given.  Only the
 existing values that match the regexp are updated or unset.  If
 you want to handle the lines that do *not* match the regex, just
 prepend a single exclamation mark in front (see also <<EXAMPLES>>).
 
-The type specifier can be either '--int' or '--bool', to make
+The type specifier can be either `--int` or `--bool`, to make
 'git config' ensure that the variable(s) are of the given type and
 convert the value to the canonical form (simple decimal number for int,
-a "true" or "false" string for bool), or '--path', which does some
-path expansion (see '--path' below).  If no type specifier is passed, no
+a "true" or "false" string for bool), or `--path`, which does some
+path expansion (see `--path` below).  If no type specifier is passed, no
 checks or transformations are performed on the value.
 
 When reading, the values are read from the system, global and
 repository local configuration files by default, and options
-'--system', '--global', '--local' and '--file <filename>' can be
+`--system`, `--global`, `--local` and '--file <filename>' can be
 used to tell the command to read from only that location (see <<FILES>>).
 
 When writing, the new value is written to the repository local
-configuration file by default, and options '--system', '--global',
+configuration file by default, and options `--system`, `--global`,
 '--file <filename>' can be used to tell the command to write to
-that location (you can say '--local' but that is the default).
+that location (you can say `--local` but that is the default).
 
 This command will fail with non-zero status upon error.  Some exit
 codes are:
@@ -138,7 +138,7 @@ See also <<FILES>>.
 	Use the given config file instead of the one specified by GIT_CONFIG.
 
 --blob blob::
-	Similar to '--file' but use the given blob instead of a file. E.g.
+	Similar to `--file` but use the given blob instead of a file. E.g.
 	you can use 'master:.gitmodules' to read values from the file
 	'.gitmodules' in the master branch. See "SPECIFYING REVISIONS"
 	section in linkgit:gitrevisions[7] for a more complete list of
@@ -220,7 +220,7 @@ See also <<FILES>>.
 -e::
 --edit::
 	Opens an editor to modify the specified config file; either
-	'--system', '--global', or repository (default).
+	`--system`, `--global`, or repository (default).
 
 --[no-]includes::
 	Respect `include.*` directives in config files when looking up
@@ -232,7 +232,7 @@ See also <<FILES>>.
 FILES
 -----
 
-If not set explicitly with '--file', there are four files where
+If not set explicitly with `--file`, there are four files where
 'git config' will search for configuration options:
 
 $(prefix)/etc/gitconfig::
@@ -264,11 +264,11 @@ precedence over values read earlier.  When multiple values are taken then all
 values of a key from all files will be used.
 
 All writing options will per default write to the repository specific
-configuration file. Note that this also affects options like '--replace-all'
-and '--unset'. *'git config' will only ever change one file at a time*.
+configuration file. Note that this also affects options like `--replace-all`
+and `--unset`. *'git config' will only ever change one file at a time*.
 
 You can override these rules either by command-line options or by environment
-variables. The '--global' and the '--system' options will limit the file used
+variables. The `--global` and the `--system` options will limit the file used
 to the global or system-wide file respectively. The `GIT_CONFIG` environment
 variable has a similar effect, but you can specify any filename you want.
 
diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
index e3c8f27..25fb963 100644
--- a/Documentation/git-credential-store.txt
+++ b/Documentation/git-credential-store.txt
@@ -44,7 +44,7 @@ OPTIONS
 FILES
 -----
 
-If not set explicitly with '--file', there are two files where
+If not set explicitly with `--file`, there are two files where
 git-credential-store will search for credentials in order of precedence:
 
 ~/.git-credentials::
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 5e3c6a8..a1a5234 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -54,7 +54,7 @@ Print usage information and exit
 You can specify a list of allowed directories. If no directories
 are given, all are allowed. This is an additional restriction, gitcvs
 access still needs to be enabled by the `gitcvs.enabled` config option
-unless '--export-all' was given, too.
+unless `--export-all` was given, too.
 
 
 DESCRIPTION
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index dc20275..7901c54 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -30,7 +30,7 @@ that service if it is enabled.
 
 It verifies that the directory has the magic file "git-daemon-export-ok", and
 it will refuse to export any Git directory that hasn't explicitly been marked
-for export this way (unless the '--export-all' parameter is specified). If you
+for export this way (unless the `--export-all` parameter is specified). If you
 pass some directory paths as 'git daemon' arguments, you can further restrict
 the offers to a whitelist comprising of those.
 
@@ -90,10 +90,10 @@ OPTIONS
 	is not supported, then --listen=hostname is also not supported and
 	--listen must be given an IPv4 address.
 	Can be given more than once.
-	Incompatible with '--inetd' option.
+	Incompatible with `--inetd` option.
 
 --port=<n>::
-	Listen on an alternative port.  Incompatible with '--inetd' option.
+	Listen on an alternative port.  Incompatible with `--inetd` option.
 
 --init-timeout=<n>::
 	Timeout (in seconds) between the moment the connection is established
diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index c8f28c8..e4ac448 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -154,7 +154,7 @@ is found, its name will be output and searching will stop.
 If an exact match was not found, 'git describe' will walk back
 through the commit history to locate an ancestor commit which
 has been tagged.  The ancestor's tag will be output along with an
-abbreviation of the input commit-ish's SHA-1. If '--first-parent' was
+abbreviation of the input commit-ish's SHA-1. If `--first-parent` was
 specified then the walk will only consider the first parent of each
 commit.
 
diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-index.txt
index a86cf62..a171506 100644
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -40,13 +40,13 @@ include::diff-format.txt[]
 Operating Modes
 ---------------
 You can choose whether you want to trust the index file entirely
-(using the '--cached' flag) or ask the diff logic to show any files
+(using the `--cached` flag) or ask the diff logic to show any files
 that don't match the stat state as being "tentatively changed".  Both
 of these operations are very useful indeed.
 
 Cached Mode
 -----------
-If '--cached' is specified, it allows you to ask:
+If `--cached` is specified, it allows you to ask:
 
 	show me the differences between HEAD and the current index
 	contents (the ones I'd write using 'git write-tree')
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 7558e49..7870e17 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -43,11 +43,11 @@ include::diff-options.txt[]
 	show tree entry itself as well as subtrees.  Implies -r.
 
 --root::
-	When '--root' is specified the initial commit will be shown as a big
+	When `--root` is specified the initial commit will be shown as a big
 	creation event. This is equivalent to a diff against the NULL tree.
 
 --stdin::
-	When '--stdin' is specified, the command does not take
+	When `--stdin` is specified, the command does not take
 	<tree-ish> arguments from the command line.  Instead, it
 	reads lines containing either two <tree>, one <commit>, or a
 	list of <commit> from its standard input.  (Use a single space
@@ -91,7 +91,7 @@ include::pretty-options.txt[]
 -c::
 	This flag changes the way a merge commit is displayed
 	(which means it is useful only when the command is given
-	one <tree-ish>, or '--stdin').  It shows the differences
+	one <tree-ish>, or `--stdin`).  It shows the differences
 	from each of the parents to the merge result simultaneously
 	instead of showing pairwise diff between a parent and the
 	result one at a time (which is what the `-m` option does).
diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 333cf6f..224fb30 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -98,7 +98,7 @@ instead.  `--no-symlinks` is the default on Windows.
 	invoked diff tool returns a non-zero exit code.
 +
 'git-difftool' will forward the exit code of the invoked tool when
-'--trust-exit-code' is used.
+`--trust-exit-code` is used.
 
 See linkgit:git-diff[1] for the full list of supported options.
 
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index 4c8219d..24417ee 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -41,7 +41,7 @@ OPTIONS
 	option, then the refs from stdin are processed after those
 	on the command line.
 +
-If '--stateless-rpc' is specified together with this option then
+If `--stateless-rpc` is specified together with this option then
 the list of refs must be in packet format (pkt-line). Each ref must
 be in a separate packet, and the list must end with a flush packet.
 
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 2d30297..060ebb3 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -171,7 +171,7 @@ to other tags will be rewritten to point to the underlying commit.
 	untouched.  This switch allow git-filter-branch to ignore such
 	commits.  Though, this switch only applies for commits that have one
 	and only one parent, it will hence keep merges points. Also, this
-	option is not compatible with the use of '--commit-filter'. Though you
+	option is not compatible with the use of `--commit-filter`. Though you
 	just need to use the function 'git_commit_non_empty_tree "$@"' instead
 	of the `git commit-tree "$@"` idiom in your commit filter to make that
 	happen.
@@ -197,7 +197,7 @@ to other tags will be rewritten to point to the underlying commit.
 <rev-list options>...::
 	Arguments for 'git rev-list'.  All positive refs included by
 	these options are rewritten.  You may also specify options
-	such as '--all', but you must use '--' to separate them from
+	such as `--all`, but you must use '--' to separate them from
 	the 'git filter-branch' options. Implies <<Remap_to_ancestor>>.
 
 
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index d9d406d..f57e69b 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -142,7 +142,7 @@ align::
 	<width> and <position> used instead.  For instance,
 	`%(align:<width>,<position>)`. If the contents length is more
 	than the width then no alignment is performed. If used with
-	'--quote' everything in between %(align:...) and %(end) is
+	`--quote` everything in between %(align:...) and %(end) is
 	quoted, but if nested then only the topmost level performs
 	quoting.
 
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 84ee92e..7fc68eb 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -95,7 +95,7 @@ DISCUSSION
 git-fsck tests SHA-1 and general object sanity, and it does full tracking
 of the resulting reachability and everything else. It prints out any
 corruption it finds (missing or bad objects), and if you use the
-'--unreachable' flag it will also print out objects that exist but that
+`--unreachable` flag it will also print out objects that exist but that
 aren't reachable from any of the specified head nodes (or the default
 set, as mentioned above).
 
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 557973b..0ecea6e 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -45,12 +45,12 @@ grep.lineNumber::
 
 grep.patternType::
 	Set the default matching behavior. Using a value of 'basic', 'extended',
-	'fixed', or 'perl' will enable the '--basic-regexp', '--extended-regexp',
-	'--fixed-strings', or '--perl-regexp' option accordingly, while the
+	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
+	`--fixed-strings`, or `--perl-regexp` option accordingly, while the
 	value 'default' will return to the default matching behavior.
 
 grep.extendedRegexp::
-	If set to true, enable '--extended-regexp' option by default. This
+	If set to true, enable `--extended-regexp` option by default. This
 	option is ignored when the `grep.patternType` option is set to a value
 	other than 'default'.
 
@@ -59,7 +59,7 @@ grep.threads::
 	8 threads are used by default (for now).
 
 grep.fullName::
-	If set to true, enable '--full-name' option by default.
+	If set to true, enable `--full-name` option by default.
 
 grep.fallbackToNoIndex::
 	If set to true, fall back to git grep --no-index if git grep
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index c6f7ce7..40d328a 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -18,10 +18,10 @@ With no options and no COMMAND or GUIDE given, the synopsis of the 'git'
 command and a list of the most commonly used Git commands are printed
 on the standard output.
 
-If the option '--all' or `-a` is given, all available commands are
+If the option `--all` or `-a` is given, all available commands are
 printed on the standard output.
 
-If the option '--guide' or `-g` is given, a list of the useful
+If the option `--guide` or `-g` is given, a list of the useful
 Git guides is also printed on the standard output.
 
 If a command, or a guide, is given, a manual page for that command or
@@ -176,7 +176,7 @@ Note about git config --global
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Note that all these configuration variables should probably be set
-using the '--global' flag, for example like this:
+using the `--global` flag, for example like this:
 
 ------------------------------------------------
 $ git config --global help.format web
diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.txt
index 2e67362..2aceb6f 100644
--- a/Documentation/git-http-push.txt
+++ b/Documentation/git-http-push.txt
@@ -81,13 +81,13 @@ destination side.
      exist in the set of remote refs; the ref matched <src>
      locally is used as the name of the destination.
 
-Without '--force', the <src> ref is stored at the remote only if
+Without `--force`, the <src> ref is stored at the remote only if
 <dst> does not exist, or <dst> is a proper subset (i.e. an
 ancestor) of <src>.  This check, known as "fast-forward check",
 is performed in order to avoid accidentally overwriting the
 remote ref and lose other peoples' commits from there.
 
-With '--force', the fast-forward check is disabled for all refs.
+With `--force`, the fast-forward check is disabled for all refs.
 
 Optionally, a <ref> parameter can be prefixed with a plus '+' sign
 to disable the fast-forward check only on that ref.
diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index a77b901..93d1db6 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -219,7 +219,7 @@ Signed-off-by: Alice <alice@example.com>
 Signed-off-by: Bob <bob@example.com>
 ------------
 
-* Use the '--in-place' option to edit a message file in place:
+* Use the `--in-place` option to edit a message file in place:
 +
 ------------
 $ cat msg.txt
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 75c3f41..078b556 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -175,7 +175,7 @@ followed by the  ("attr/<eolattr>").
 
 Output
 ------
-'git ls-files' just outputs the filenames unless '--stage' is specified in
+'git ls-files' just outputs the filenames unless `--stage` is specified in
 which case it outputs:
 
         [<tag> ]<mode> <object> <stage> <file>
diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 9d4f151..21c7af2 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -104,7 +104,7 @@ $ git p4 sync //path/in/your/perforce/depot
 ------------
 This imports the specified depot into
 'refs/remotes/p4/master' in an existing Git repository.  The
-'--branch' option can be used to specify a different branch to
+`--branch` option can be used to specify a different branch to
 be used for the p4 content.
 
 If a Git repository includes branches 'refs/remotes/origin/p4', these
@@ -114,7 +114,7 @@ from a Git remote, this can be useful in a multi-developer environment.
 
 If there are multiple branches, doing 'git p4 sync' will automatically
 use the "BRANCH DETECTION" algorithm to try to partition new changes
-into the right branch.  This can be overridden with the '--branch'
+into the right branch.  This can be overridden with the `--branch`
 option to specify just a single branch to update.
 
 
@@ -150,10 +150,10 @@ $ git p4 submit topicbranch
 ------------
 
 The upstream reference is generally 'refs/remotes/p4/master', but can
-be overridden using the '--origin=' command-line option.
+be overridden using the `--origin=` command-line option.
 
 The p4 changes will be created as the user invoking 'git p4 submit'. The
-'--preserve-user' option will cause ownership to be modified
+`--preserve-user` option will cause ownership to be modified
 according to the author of the Git commit.  This option requires admin
 privileges in p4, which can be granted using 'p4 protect'.
 
@@ -221,7 +221,7 @@ Git repository:
 	where they will be treated as remote-tracking branches by
 	linkgit:git-branch[1] and other commands.  This option instead
 	puts p4 branches in 'refs/heads/p4/'.  Note that future
-	sync operations must specify '--import-local' as well so that
+	sync operations must specify `--import-local` as well so that
 	they can find the p4 branches in refs/heads.
 
 --max-changes <n>::
@@ -245,7 +245,7 @@ Git repository:
 	default, involves removing the entire depot path.  With this
 	option, the full p4 depot path is retained in Git.  For example,
 	path '//depot/main/foo/bar.c', when imported from
-	'//depot/main/', becomes 'foo/bar.c'.  With '--keep-path', the
+	'//depot/main/', becomes 'foo/bar.c'.  With `--keep-path`, the
 	Git path is instead 'depot/main/foo/bar.c'.
 
 --use-client-spec::
@@ -341,7 +341,7 @@ p4 revision specifier on the end:
     Import all changes from both named depot paths into a single
     repository.  Only files below these directories are included.
     There is not a subdirectory in Git for each "proj1" and "proj2".
-    You must use the '--destination' option when specifying more
+    You must use the `--destination` option when specifying more
     than one depot path.  The revision specifier must be specified
     identically on each depot path.  If there are files in the
     depot paths with the same name, the path with the most recently
@@ -355,7 +355,7 @@ CLIENT SPEC
 The p4 client specification is maintained with the 'p4 client' command
 and contains among other fields, a View that specifies how the depot
 is mapped into the client repository.  The 'clone' and 'sync' commands
-can consult the client spec when given the '--use-client-spec' option or
+can consult the client spec when given the `--use-client-spec` option or
 when the useClientSpec variable is true.  After 'git p4 clone', the
 useClientSpec variable is automatically set in the repository
 configuration file.  This allows future 'git p4 submit' commands to
@@ -390,7 +390,7 @@ different areas in the tree, and indicate related content.  'git p4'
 can use these mappings to determine branch relationships.
 
 If you have a repository where all the branches of interest exist as
-subdirectories of a single depot path, you can use '--detect-branches'
+subdirectories of a single depot path, you can use `--detect-branches`
 when cloning or syncing to have 'git p4' automatically find
 subdirectories in p4, and to generate these as branches in Git.
 
@@ -507,7 +507,7 @@ git-p4.labelImportRegexp::
 git-p4.useClientSpec::
 	Specify that the p4 client spec should be used to identify p4
 	depot paths of interest.  This is equivalent to specifying the
-	option '--use-client-spec'.  See the "CLIENT SPEC" section above.
+	option `--use-client-spec`.  See the "CLIENT SPEC" section above.
 	This variable is a boolean, not the name of a p4 client.
 
 git-p4.pathEncoding::
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 19f46b6..93c3527 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -275,7 +275,7 @@ origin +master` to force a push to the `master` branch). See the
 	all submodules that changed in the revisions to be pushed will be
 	pushed. If on-demand was not able to push all necessary revisions
 	it will also be aborted and exit with non-zero status. A value of
-	'no' or using '--no-recurse-submodules' can be used to override the
+	'no' or using `--no-recurse-submodules` can be used to override the
 	push.recurseSubmodules configuration variable when no submodule
 	recursion is required.
 
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 0387b40..de222c8 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -208,10 +208,10 @@ rebase.stat::
 	rebase. False by default.
 
 rebase.autoSquash::
-	If set to true enable '--autosquash' option by default.
+	If set to true enable `--autosquash` option by default.
 
 rebase.autoStash::
-	If set to true enable '--autostash' option by default.
+	If set to true enable `--autostash` option by default.
 
 rebase.missingCommitsCheck::
 	If set to "warn", print warnings about removed commits in
@@ -220,7 +220,7 @@ rebase.missingCommitsCheck::
 	done. "ignore" by default.
 
 rebase.instructionFormat::
-	Custom commit list format to use during an '--interactive' rebase.
+	Custom commit list format to use during an `--interactive` rebase.
 
 OPTIONS
 -------
@@ -428,9 +428,9 @@ without an explicit `--interactive`.
 	"fixup! " or "squash! " after the first, in case you referred to an
 	earlier fixup/squash with `git commit --fixup/--squash`.
 +
-This option is only valid when the '--interactive' option is used.
+This option is only valid when the `--interactive` option is used.
 +
-If the '--autosquash' option is enabled by default using the
+If the `--autosquash` option is enabled by default using the
 configuration variable `rebase.autoSquash`, this option can be
 used to override and disable this setting.
 
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 1d7ecea..577b969 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -137,9 +137,9 @@ branches, adds to that list.
 Retrieves the URLs for a remote. Configurations for `insteadOf` and
 `pushInsteadOf` are expanded here. By default, only the first URL is listed.
 +
-With '--push', push URLs are queried rather than fetch URLs.
+With `--push`, push URLs are queried rather than fetch URLs.
 +
-With '--all', all URLs for the remote will be listed.
+With `--all`, all URLs for the remote will be listed.
 
 'set-url'::
 
@@ -147,11 +147,11 @@ Changes URLs for the remote. Sets first URL for remote <name> that matches
 regex <oldurl> (first URL if no <oldurl> is given) to <newurl>. If
 <oldurl> doesn't match any URL, an error occurs and nothing is changed.
 +
-With '--push', push URLs are manipulated instead of fetch URLs.
+With `--push`, push URLs are manipulated instead of fetch URLs.
 +
-With '--add', instead of changing existing URLs, new URL is added.
+With `--add`, instead of changing existing URLs, new URL is added.
 +
-With '--delete', instead of changing existing URLs, all URLs matching
+With `--delete`, instead of changing existing URLs, all URLs matching
 regex <url> are deleted for remote <name>.  Trying to delete all
 non-push URLs is an error.
 +
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 573616a..837707a 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -24,7 +24,7 @@ from the HEAD commit).
 Note: 'git revert' is used to record some new commits to reverse the
 effect of some earlier commits (often only a faulty one).  If you want to
 throw away all uncommitted changes in your working directory, you
-should see linkgit:git-reset[1], particularly the '--hard' option.  If
+should see linkgit:git-reset[1], particularly the `--hard` option.  If
 you want to extract specific files as they were in another commit, you
 should see linkgit:git-checkout[1], specifically the `git checkout
 <commit> -- <filename>` syntax.  Take care with these alternatives as
@@ -37,7 +37,7 @@ OPTIONS
 	For a more complete list of ways to spell commit names, see
 	linkgit:gitrevisions[7].
 	Sets of commits can also be given but no traversal is done by
-	default, see linkgit:git-rev-list[1] and its '--no-walk'
+	default, see linkgit:git-rev-list[1] and its `--no-walk`
 	option.
 
 -e::
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index d0b38b4..642d0ef 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -66,7 +66,7 @@ This option may be specified multiple times.
 	Invoke a text editor (see GIT_EDITOR in linkgit:git-var[1])
 	to edit an introductory message for the patch series.
 +
-When '--compose' is used, git send-email will use the From, Subject, and
+When `--compose` is used, git send-email will use the From, Subject, and
 In-Reply-To headers specified in the message. If the body of the message
 (what you type after the headers and a blank line) only contains blank
 (or Git: prefixed) lines, the summary won't be sent, but From, Subject,
@@ -182,19 +182,19 @@ $ git send-email --smtp-auth="PLAIN LOGIN GSSAPI" ...
 +
 If at least one of the specified mechanisms matches the ones advertised by the
 SMTP server and if it is supported by the utilized SASL library, the mechanism
-is used for authentication. If neither 'sendemail.smtpAuth' nor '--smtp-auth'
+is used for authentication. If neither 'sendemail.smtpAuth' nor `--smtp-auth`
 is specified, all mechanisms supported by the SASL library can be used.
 
 --smtp-pass[=<password>]::
 	Password for SMTP-AUTH. The argument is optional: If no
 	argument is specified, then the empty string is used as
 	the password. Default is the value of `sendemail.smtpPass`,
-	however '--smtp-pass' always overrides this value.
+	however `--smtp-pass` always overrides this value.
 +
 Furthermore, passwords need not be specified in configuration files
 or on the command line. If a username has been specified (with
-'--smtp-user' or a `sendemail.smtpUser`), but no password has been
-specified (with '--smtp-pass' or `sendemail.smtpPass`), then
+`--smtp-user` or a `sendemail.smtpUser`), but no password has been
+specified (with `--smtp-pass` or `sendemail.smtpPass`), then
 a password is obtained using 'git-credential'.
 
 --smtp-server=<host>::
@@ -240,7 +240,7 @@ must be used for each option.
 
 --smtp-user=<user>::
 	Username for SMTP-AUTH. Default is the value of `sendemail.smtpUser`;
-	if a username is not specified (with '--smtp-user' or `sendemail.smtpUser`),
+	if a username is not specified (with `--smtp-user` or `sendemail.smtpUser`),
 	then authentication is not attempted.
 
 --smtp-debug=0|1::
@@ -364,8 +364,8 @@ have been specified, in which case default to 'compose'.
 
 --[no-]format-patch::
 	When an argument may be understood either as a reference or as a file name,
-	choose to understand it as a format-patch argument ('--format-patch')
-	or as a file name ('--no-format-patch'). By default, when such a conflict
+	choose to understand it as a format-patch argument (`--format-patch`)
+	or as a file name (`--no-format-patch`). By default, when such a conflict
 	occurs, git send-email will fail.
 
 --quiet::
@@ -382,7 +382,7 @@ have been specified, in which case default to 'compose'.
 --
 +
 Default is the value of `sendemail.validate`; if this is not set,
-default to '--validate'.
+default to `--validate`.
 
 --force::
 	Send emails even if safety checks would prevent it.
@@ -428,13 +428,13 @@ sendmail;;
 
 sendemail.multiEdit::
 	If true (default), a single editor instance will be spawned to edit
-	files you have to edit (patches when '--annotate' is used, and the
-	summary when '--compose' is used). If false, files will be edited one
+	files you have to edit (patches when `--annotate` is used, and the
+	summary when `--compose` is used). If false, files will be edited one
 	after the other, spawning a new editor each time.
 
 sendemail.confirm::
 	Sets the default for whether to confirm before sending. Must be
-	one of 'always', 'never', 'cc', 'compose', or 'auto'. See '--confirm'
+	one of 'always', 'never', 'cc', 'compose', or 'auto'. See `--confirm`
 	in the previous section for the meaning of these values.
 
 EXAMPLE
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 6aa91e8..a831dd0 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -44,7 +44,7 @@ OPTIONS
 	option, then the refs from stdin are processed after those
 	on the command line.
 +
-If '--stateless-rpc' is specified together with this option then
+If `--stateless-rpc` is specified together with this option then
 the list of refs must be in packet format (pkt-line). Each ref must
 be in a separate packet, and the list must end with a flush packet.
 
@@ -99,11 +99,11 @@ Specifying the Refs
 There are three ways to specify which refs to update on the
 remote end.
 
-With '--all' flag, all refs that exist locally are transferred to
+With `--all` flag, all refs that exist locally are transferred to
 the remote side.  You cannot specify any '<ref>' if you use
 this flag.
 
-Without '--all' and without any '<ref>', the heads that exist
+Without `--all` and without any '<ref>', the heads that exist
 both on the local side and on the remote side are updated.
 
 When one or more '<ref>' are specified explicitly (whether on the
@@ -134,13 +134,13 @@ name. See linkgit:git-rev-parse[1].
      exist in the set of remote refs; the ref matched <src>
      locally is used as the name of the destination.
 
-Without '--force', the <src> ref is stored at the remote only if
+Without `--force`, the <src> ref is stored at the remote only if
 <dst> does not exist, or <dst> is a proper subset (i.e. an
 ancestor) of <src>.  This check, known as "fast-forward check",
 is performed in order to avoid accidentally overwriting the
 remote ref and lose other peoples' commits from there.
 
-With '--force', the fast-forward check is disabled for all refs.
+With `--force`, the fast-forward check is disabled for all refs.
 
 Optionally, a <ref> parameter can be prefixed with a plus '+' sign
 to disable the fast-forward check only on that ref.
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index b91d4e5..7818e0f 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -60,7 +60,7 @@ OPTIONS
         are shown before their parents).
 
 --date-order::
-	This option is similar to '--topo-order' in the sense that no
+	This option is similar to `--topo-order` in the sense that no
 	parent comes before all of its children, but otherwise commits
 	are ordered according to their commit date.
 
diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 3a32451..c0aa871 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -60,7 +60,7 @@ OPTIONS
 
 	Enable stricter reference checking by requiring an exact ref path.
 	Aside from returning an error code of 1, it will also print an error
-	message if '--quiet' was not specified.
+	message if `--quiet` was not specified.
 
 --abbrev[=<n>]::
 
@@ -70,7 +70,7 @@ OPTIONS
 -q::
 --quiet::
 
-	Do not print any results to stdout. When combined with '--verify' this
+	Do not print any results to stdout. When combined with `--verify` this
 	can be used to silently check if a reference exists.
 
 --exclude-existing[=<pattern>]::
@@ -134,7 +134,7 @@ use:
 This will show "refs/heads/master" but also "refs/remote/other-repo/master",
 if such references exists.
 
-When using the '--verify' flag, the command requires an exact path:
+When using the `--verify` flag, the command requires an exact path:
 
 -----------------------------------------------------------------------------
 	git show-ref --verify refs/heads/master
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 698a668..7e17cad 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -98,11 +98,11 @@ your Perl's Getopt::Long is < v2.37).
 --ignore-paths=<regex>;;
 	When passed to 'init' or 'clone' this regular expression will
 	be preserved as a config key.  See 'fetch' for a description
-	of '--ignore-paths'.
+	of `--ignore-paths`.
 --include-paths=<regex>;;
 	When passed to 'init' or 'clone' this regular expression will
 	be preserved as a config key.  See 'fetch' for a description
-	of '--include-paths'.
+	of `--include-paths`.
 --no-minimize-url;;
 	When tracking multiple directories (using --stdlayout,
 	--branches, or --tags options), git svn will attempt to connect
@@ -110,7 +110,7 @@ your Perl's Getopt::Long is < v2.37).
 	repository.  This default allows better tracking of history if
 	entire projects are moved within a repository, but may cause
 	issues on repositories where read access restrictions are in
-	place.  Passing '--no-minimize-url' will allow git svn to
+	place.  Passing `--no-minimize-url` will allow git svn to
 	accept URLs as-is without attempting to connect to a higher
 	level directory.  This option is off by default when only
 	one URL/branch is tracked (it would do little good).
@@ -141,7 +141,7 @@ the same local time zone.
 --ignore-paths=<regex>;;
 	This allows one to specify a Perl regular expression that will
 	cause skipping of all matching paths from checkout from SVN.
-	The '--ignore-paths' option should match for every 'fetch'
+	The `--ignore-paths` option should match for every 'fetch'
 	(including automatic fetches due to 'clone', 'dcommit',
 	'rebase', etc) on a given repository.
 +
@@ -170,10 +170,10 @@ Skip "branches" and "tags" of first level directories;;
 --include-paths=<regex>;;
 	This allows one to specify a Perl regular expression that will
 	cause the inclusion of only matching paths from checkout from SVN.
-	The '--include-paths' option should match for every 'fetch'
+	The `--include-paths` option should match for every 'fetch'
 	(including automatic fetches due to 'clone', 'dcommit',
-	'rebase', etc) on a given repository. '--ignore-paths' takes
-	precedence over '--include-paths'.
+	'rebase', etc) on a given repository. `--ignore-paths` takes
+	precedence over `--include-paths`.
 +
 [verse]
 config key: svn-remote.<name>.include-paths
@@ -191,7 +191,7 @@ config key: svn-remote.<name>.include-paths
 	or if a second argument is passed; it will create a directory
 	and work within that.  It accepts all arguments that the
 	'init' and 'fetch' commands accept; with the exception of
-	'--fetch-all' and '--parent'.  After a repository is cloned,
+	`--fetch-all` and `--parent`.  After a repository is cloned,
 	the 'fetch' command will be able to update revisions without
 	affecting the working tree; and the 'rebase' command will be
 	able to update the working tree with the latest changes.
@@ -216,7 +216,7 @@ it preserves linear history with 'git rebase' instead of
 'git merge' for ease of dcommitting with 'git svn'.
 +
 This accepts all options that 'git svn fetch' and 'git rebase'
-accept.  However, '--fetch-all' only fetches from the current
+accept.  However, `--fetch-all` only fetches from the current
 [svn-remote], and not all [svn-remote] definitions.
 +
 Like 'git rebase'; this requires that the working tree be clean
@@ -919,7 +919,7 @@ parent of the branch. However, it is possible that there is no suitable
 Git commit to serve as parent.  This will happen, among other reasons,
 if the SVN branch is a copy of a revision that was not fetched by 'git
 svn' (e.g. because it is an old revision that was skipped with
-'--revision'), or if in SVN a directory was copied that is not tracked
+`--revision`), or if in SVN a directory was copied that is not tracked
 by 'git svn' (such as a branch that is not tracked at all, or a
 subdirectory of a tracked branch). In these cases, 'git svn' will still
 create a Git branch, but instead of using an existing Git commit as the
@@ -996,12 +996,12 @@ directories in the working copy.  While this is the easiest way to get a
 copy of a complete repository, for projects with many branches it will
 lead to a working copy many times larger than just the trunk. Thus for
 projects using the standard directory structure (trunk/branches/tags),
-it is recommended to clone with option '--stdlayout'. If the project
+it is recommended to clone with option `--stdlayout`. If the project
 uses a non-standard structure, and/or if branches and tags are not
 required, it is easiest to only clone one directory (typically trunk),
 without giving any repository layout options.  If the full history with
-branches and tags is required, the options '--trunk' / '--branches' /
-'--tags' must be used.
+branches and tags is required, the options `--trunk` / `--branches` /
+`--tags` must be used.
 
 When using multiple --branches or --tags, 'git svn' does not automatically
 handle name collisions (for example, if two branches from different paths have
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 6b89393..3225d0e 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -167,7 +167,7 @@ This option is only applicable when listing tags without annotation lines.
 
 --[no-]merged [<commit>]::
 	Only list tags whose tips are reachable, or not reachable
-	if '--no-merged' is used, from the specified commit ('HEAD'
+	if `--no-merged` is used, from the specified commit ('HEAD'
 	if not specified).
 
 CONFIGURATION
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index c6cbed1..7386c93 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -102,7 +102,7 @@ thus, in case the assumed-untracked file is changed upstream,
 you will need to handle the situation manually.
 
 --really-refresh::
-	Like '--refresh', but checks stat information unconditionally,
+	Like `--refresh`, but checks stat information unconditionally,
 	without regard to the "assume unchanged" setting.
 
 --[no-]skip-worktree::
@@ -211,7 +211,7 @@ will remove the intended effect of the option.
 
 Using --refresh
 ---------------
-'--refresh' does not calculate a new sha1 file or bring the index
+`--refresh` does not calculate a new sha1 file or bring the index
 up-to-date for mode/content changes. But what it *does* do is to
 "re-match" the stat information of a file with the index, so that you
 can refresh the index for a file that hasn't been changed but where
@@ -222,7 +222,7 @@ up the stat index details with the proper files.
 
 Using --cacheinfo or --info-only
 --------------------------------
-'--cacheinfo' is used to register a file that is not in the
+`--cacheinfo` is used to register a file that is not in the
 current working directory.  This is useful for minimum-checkout
 merging.
 
@@ -232,12 +232,12 @@ To pretend you have a file with mode and sha1 at path, say:
 $ git update-index --cacheinfo <mode>,<sha1>,<path>
 ----------------
 
-'--info-only' is used to register files without placing them in the object
+`--info-only` is used to register files without placing them in the object
 database.  This is useful for status-only repositories.
 
-Both '--cacheinfo' and '--info-only' behave similarly: the index is updated
-but the object database isn't.  '--cacheinfo' is useful when the object is
-in the database but the file isn't available locally.  '--info-only' is
+Both `--cacheinfo` and `--info-only` behave similarly: the index is updated
+but the object database isn't.  `--cacheinfo` is useful when the object is
+in the database but the file isn't available locally.  `--info-only` is
 useful when the file is available, but you do not wish to update the
 object database.
 
diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index 7daa28f..2d6b09a 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -110,7 +110,7 @@ Note about git-config --global
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Note that these configuration variables should probably be set using
-the '--global' flag, for example like this:
+the `--global` flag, for example like this:
 
 ------------------------------------------------
 $ git config --global web.browser firefox
diff --git a/Documentation/git.txt b/Documentation/git.txt
index b861087..0169e1e 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -513,7 +513,7 @@ OPTIONS
 
 --help::
 	Prints the synopsis and a list of the most commonly used
-	commands. If the option '--all' or `-a` is given then all
+	commands. If the option `--all` or `-a` is given then all
 	available commands are printed. If a Git command is named this
 	option will bring up the manual page for that command.
 +
@@ -855,16 +855,16 @@ Git so take care if using a foreign front-end.
 	If the `GIT_DIR` environment variable is set then it
 	specifies a path to use instead of the default `.git`
 	for the base of the repository.
-	The '--git-dir' command-line option also sets this value.
+	The `--git-dir` command-line option also sets this value.
 
 `GIT_WORK_TREE`::
 	Set the path to the root of the working tree.
-	This can also be controlled by the '--work-tree' command-line
+	This can also be controlled by the `--work-tree` command-line
 	option and the core.worktree configuration variable.
 
 `GIT_NAMESPACE`::
 	Set the Git namespace; see linkgit:gitnamespaces[7] for details.
-	The '--namespace' command-line option also sets this value.
+	The `--namespace` command-line option also sets this value.
 
 `GIT_CEILING_DIRECTORIES`::
 	This should be a colon-separated list of absolute paths.  If
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 15b3bfa..4546fa0 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -949,7 +949,7 @@ for details.
 [NOTE]
 If there were more commits on the 'master' branch after the merge, the
 merge commit itself would not be shown by 'git show-branch' by
-default.  You would need to provide '--sparse' option to make the
+default.  You would need to provide `--sparse` option to make the
 merge commit visible in this case.
 
 Now, let's pretend you are the one who did all the work in
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index c579593..08cf622 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -28,8 +28,8 @@ The 'git diff-{asterisk}' family works by first comparing two sets of
 files:
 
  - 'git diff-index' compares contents of a "tree" object and the
-   working directory (when '--cached' flag is not used) or a
-   "tree" object and the index file (when '--cached' flag is
+   working directory (when `--cached` flag is not used) or a
+   "tree" object and the index file (when `--cached` flag is
    used);
 
  - 'git diff-files' compares contents of the index file and the
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 6ade002..a68d860 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -82,7 +82,7 @@ linkgit:git-rev-list[1] for a complete list.
 
 --simplify-merges::
 
-	Additional option to '--full-history' to remove some needless
+	Additional option to `--full-history` to remove some needless
 	merges from the resulting history, as there are no selected
 	commits contributing to this merge.  (See "History
 	simplification" in linkgit:git-log[1] for a more detailed
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index ac70eca..07cdd73 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -19,7 +19,7 @@ of linkgit:git-config[1].
 
 The file contains one subsection per submodule, and the subsection value
 is the name of the submodule. The name is set to the path where the
-submodule has been added unless it was customized with the '--name'
+submodule has been added unless it was customized with the `--name`
 option of 'git submodule add'. Each submodule section also contains the
 following required keys:
 
diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 1e86594..53ce1d0 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -210,17 +210,17 @@ the remote repository.
 'export-marks' <file>::
 	This modifies the 'export' capability, instructing Git to dump the
 	internal marks table to <file> when complete. For details,
-	read up on '--export-marks=<file>' in linkgit:git-fast-export[1].
+	read up on `--export-marks=<file>` in linkgit:git-fast-export[1].
 
 'import-marks' <file>::
 	This modifies the 'export' capability, instructing Git to load the
 	marks specified in <file> before processing any input. For details,
-	read up on '--import-marks=<file>' in linkgit:git-fast-export[1].
+	read up on `--import-marks=<file>` in linkgit:git-fast-export[1].
 
 'signed-tags'::
 	This modifies the 'export' capability, instructing Git to pass
-	'--signed-tags=verbatim' to linkgit:git-fast-export[1].  In the
-	absence of this capability, Git will use '--signed-tags=warn-strip'.
+	`--signed-tags=verbatim` to linkgit:git-fast-export[1].  In the
+	absence of this capability, Git will use `--signed-tags=warn-strip`.
 
 
 
diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 19314e3..15879b3 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -71,7 +71,7 @@ some output processing may assume ref names in UTF-8.
   existing log ('$GIT_DIR/logs/<ref>'). Note that this looks up the state
   of your *local* ref at a given time; e.g., what was in your local
   'master' branch last week. If you want to look at commits made during
-  certain times, see '--since' and '--until'.
+  certain times, see `--since` and `--until`.
 
 '<refname>@{<n>}', e.g. 'master@\{1\}'::
   A ref followed by the suffix '@' with an ordinal specification
-- 
2.8.2.397.gbe91ebf.dirty

