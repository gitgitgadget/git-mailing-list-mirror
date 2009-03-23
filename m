From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/WIP 2/2] Documentation: format git commands consistently
Date: Mon, 23 Mar 2009 15:28:53 +0100
Message-ID: <1237818533-31577-3-git-send-email-git@drmicha.warpmail.net>
References: <1237818533-31577-1-git-send-email-git@drmicha.warpmail.net>
 <1237818533-31577-2-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 15:30:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LllAw-00064l-36
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 15:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755516AbZCWO3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 10:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755497AbZCWO3V
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 10:29:21 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:36538 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755049AbZCWO3Q (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 10:29:16 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id F0B4E2FA91E;
	Mon, 23 Mar 2009 10:29:14 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 23 Mar 2009 10:29:15 -0400
X-Sasl-enc: nvtbxqtRZIPh7aMF2moL1RK7+QXd4rbuvCqOiXnhY2PC 1237818553
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E5B5D4600B;
	Mon, 23 Mar 2009 10:29:13 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.149.g6462
In-Reply-To: <1237818533-31577-2-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114314>

Commands should be formatted `command` in asciidoc. So, try and catch all
present styles ("command", 'command', command) and convert to this at
least for git commands.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/config.txt              |  114 ++++++++++++++++----------------
 Documentation/diff-format.txt         |    6 +-
 Documentation/diff-generate-patch.txt |   12 ++--
 Documentation/diff-options.txt        |    4 +-
 Documentation/everyday.txt            |    6 +-
 Documentation/fetch-options.txt       |   12 ++--
 Documentation/git-add.txt             |   28 ++++----
 Documentation/git-am.txt              |   16 ++--
 8 files changed, 99 insertions(+), 99 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e093ff3..ea15552 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -63,7 +63,7 @@ The values following the equals sign in variable assign are all either
 a string, an integer, or a boolean.  Boolean values may be given as yes/no,
 0/1 or true/false.  Case is not significant in boolean values, when
 converting value to the canonical form using '--bool' type specifier;
-'git-config' will ensure that the output is "true" or "false".
+`git-config` will ensure that the output is "true" or "false".
 
 String values may be entirely or partially enclosed in double quotes.
 You need to enclose variable value in double quotes if you want to
@@ -393,8 +393,8 @@ core.pager::
 
 core.whitespace::
 	A comma separated list of common whitespace problems to
-	notice.  'git-diff' will use `color.diff.whitespace` to
-	highlight them, and 'git-apply --whitespace=error' will
+	notice.  `git-diff` will use `color.diff.whitespace` to
+	highlight them, and `git-apply --whitespace=error` will
 	consider them as errors.  You can prefix `-` to disable
 	any of them (e.g. `-trailing-space`):
 +
@@ -419,9 +419,9 @@ journalling (traditional UNIX filesystems) or that only journal metadata
 and not file contents (OS X's HFS+, or Linux ext3 with "data=writeback").
 
 core.preloadindex::
-	Enable parallel index preload for operations like 'git diff'
+	Enable parallel index preload for operations like `git diff`
 +
-This can speed up operations like 'git diff' and 'git status' especially
+This can speed up operations like `git diff` and `git status` especially
 on filesystems like NFS that have weak caching semantics and thus
 relatively high IO latencies.  With this set to 'true', git will do the
 index comparison to the filesystem data in parallel, allowing
@@ -430,7 +430,7 @@ overlapping IO's.
 alias.*::
 	Command aliases for the linkgit:git[1] command wrapper - e.g.
 	after defining "alias.last = cat-file commit HEAD", the invocation
-	"git last" is equivalent to "git cat-file commit HEAD". To avoid
+	`git last` is equivalent to `git cat-file commit HEAD`. To avoid
 	confusion and troubles with script usage, aliases that
 	hide existing git commands are ignored. Arguments are split by
 	spaces, the usual shell quoting and escaping is supported.
@@ -439,15 +439,15 @@ alias.*::
 If the alias expansion is prefixed with an exclamation point,
 it will be treated as a shell command.  For example, defining
 "alias.new = !gitk --all --not ORIG_HEAD", the invocation
-"git new" is equivalent to running the shell command
-"gitk --all --not ORIG_HEAD".
+`git new` is equivalent to running the shell command
+`gitk --all --not ORIG_HEAD`.
 
 apply.whitespace::
-	Tells 'git-apply' how to handle whitespaces, in the same way
+	Tells `git-apply` how to handle whitespaces, in the same way
 	as the '--whitespace' option. See linkgit:git-apply[1].
 
 branch.autosetupmerge::
-	Tells 'git-branch' and 'git-checkout' to setup new branches
+	Tells `git-branch` and `git-checkout` to setup new branches
 	so that linkgit:git-pull[1] will appropriately merge from the
 	starting point branch. Note that even if this option is not set,
 	this behavior can be chosen per-branch using the `--track`
@@ -458,7 +458,7 @@ branch.autosetupmerge::
 	branch. This option defaults to true.
 
 branch.autosetuprebase::
-	When a new branch is created with 'git-branch' or 'git-checkout'
+	When a new branch is created with `git-branch` or `git-checkout`
 	that tracks another branch, this variable tells git to set
 	up pull to rebase instead of merge (see "branch.<name>.rebase").
 	When `never`, rebase is never automatically set to true.
@@ -473,20 +473,20 @@ branch.autosetuprebase::
 	This option defaults to never.
 
 branch.<name>.remote::
-	When in branch <name>, it tells 'git-fetch' which remote to fetch.
-	If this option is not given, 'git-fetch' defaults to remote "origin".
+	When in branch <name>, it tells `git-fetch` which remote to fetch.
+	If this option is not given, `git-fetch` defaults to remote "origin".
 
 branch.<name>.merge::
-	When in branch <name>, it tells 'git-fetch' the default
+	When in branch <name>, it tells `git-fetch` the default
 	refspec to be marked for merging in FETCH_HEAD. The value is
 	handled like the remote part of a refspec, and must match a
 	ref which is fetched from the remote given by
 	"branch.<name>.remote".
-	The merge information is used by 'git-pull' (which at first calls
-	'git-fetch') to lookup the default branch for merging. Without
-	this option, 'git-pull' defaults to merge the first refspec fetched.
+	The merge information is used by `git-pull` (which at first calls
+	`git-fetch`) to lookup the default branch for merging. Without
+	this option, `git-pull` defaults to merge the first refspec fetched.
 	Specify multiple values to get an octopus merge.
-	If you wish to setup 'git-pull' so that it merges into <name> from
+	If you wish to setup `git-pull` so that it merges into <name> from
 	another branch in the local repository, you can point
 	branch.<name>.merge to the desired branch, and use the special setting
 	`.` (a period) for branch.<name>.remote.
@@ -500,7 +500,7 @@ branch.<name>.mergeoptions::
 branch.<name>.rebase::
 	When true, rebase the branch <name> on top of the fetched branch,
 	instead of merging the default branch from the default remote when
-	"git pull" is run.
+	`git pull` is run.
 	*NOTE*: this is a possibly dangerous operation; do *not* use
 	it unless you understand the implications (see linkgit:git-rebase[1]
 	for details).
@@ -516,7 +516,7 @@ browser.<tool>.path::
 	working repository in gitweb (see linkgit:git-instaweb[1]).
 
 clean.requireForce::
-	A boolean to make git-clean do nothing unless given -f
+	A boolean to make `git-clean` do nothing unless given -f
 	or -n.   Defaults to true.
 
 color.branch::
@@ -574,12 +574,12 @@ color.grep.match::
 
 color.interactive::
 	When set to `always`, always use colors for interactive prompts
-	and displays (such as those used by "git-add --interactive").
+	and displays (such as those used by `git-add --interactive`).
 	When false (or `never`), never.  When set to `true` or `auto`, use
 	colors only when the output is to the terminal. Defaults to false.
 
 color.interactive.<slot>::
-	Use customized color for 'git-add --interactive'
+	Use customized color for `git-add --interactive`
 	output. `<slot>` may be `prompt`, `header`, `help` or `error`, for
 	four distinct types of normal output from interactive
 	programs.  The values of these variables may be specified as
@@ -616,14 +616,14 @@ commit.template::
 	Specify a file to use as the template for new commit messages.
 
 diff.autorefreshindex::
-	When using 'git-diff' to compare with work tree
+	When using `git-diff` to compare with work tree
 	files, do not consider stat-only change as changed.
 	Instead, silently run `git update-index --refresh` to
 	update the cached stat information for paths whose
 	contents in the work tree match the contents in the
 	index.  This option defaults to true.  Note that this
-	affects only 'git-diff' Porcelain, and not lower level
-	'diff' commands, such as 'git-diff-files'.
+	affects only `git-diff` Porcelain, and not lower level
+	`diff` commands, such as `git-diff-files`.
 
 diff.external::
 	If this config variable is set, diff generation is not
@@ -635,24 +635,24 @@ diff.external::
 	your files, you	might want to use linkgit:gitattributes[5] instead.
 
 diff.mnemonicprefix::
-	If set, 'git-diff' uses a prefix pair that is different from the
+	If set, `git-diff` uses a prefix pair that is different from the
 	standard "a/" and "b/" depending on what is being compared.  When
 	this configuration is in effect, reverse diff output also swaps
 	the order of the prefixes:
-'git-diff';;
+`git-diff`;;
 	compares the (i)ndex and the (w)ork tree;
-'git-diff HEAD';;
+`git-diff HEAD`;;
 	 compares a (c)ommit and the (w)ork tree;
-'git diff --cached';;
+`git diff --cached`;;
 	compares a (c)ommit and the (i)ndex;
-'git-diff HEAD:file1 file2';;
+`git-diff HEAD:file1 file2`;;
 	compares an (o)bject and a (w)ork tree entity;
-'git diff --no-index a b';;
+`git diff --no-index a b`;;
 	compares two non-git things (1) and (2).
 
 diff.renameLimit::
 	The number of files to consider when performing the copy/rename
-	detection; equivalent to the 'git-diff' option '-l'.
+	detection; equivalent to the `git-diff` option '-l'.
 
 diff.renames::
 	Tells git to detect renames.  If set to any boolean value, it
@@ -719,7 +719,7 @@ format.pretty::
 	linkgit:git-whatchanged[1].
 
 format.thread::
-	The default threading style for 'git-format-patch'.  Can be
+	The default threading style for `git-format-patch`.  Can be
 	either a boolean value, `shallow` or `deep`.  'Shallow'
 	threading makes every mail a reply to the head of the series,
 	where the head is chosen from the cover letter, the
@@ -730,7 +730,7 @@ format.thread::
 
 gc.aggressiveWindow::
 	The window size parameter used in the delta compression
-	algorithm used by 'git-gc --aggressive'.  This defaults
+	algorithm used by `git-gc --aggressive`.  This defaults
 	to 10.
 
 gc.auto::
@@ -747,39 +747,39 @@ gc.autopacklimit::
 	default	value is 50.  Setting this to 0 disables it.
 
 gc.packrefs::
-	'git-gc' does not run `git pack-refs` in a bare repository by
+	`git-gc` does not run `git pack-refs` in a bare repository by
 	default so that older dumb-transport clients can still fetch
-	from the repository.  Setting this to `true` lets 'git-gc'
+	from the repository.  Setting this to `true` lets `git-gc`
 	to run `git pack-refs`.  Setting this to `false` tells
-	'git-gc' never to run `git pack-refs`. The default setting is
+	`git-gc` never to run `git pack-refs`. The default setting is
 	`notbare`. Enable it only when you know you do not have to
 	support such clients.  The default setting will change to `true`
 	at some stage, and setting this to `false` will continue to
-	prevent `git pack-refs` from being run from 'git-gc'.
+	prevent `git pack-refs` from being run from `git-gc`.
 
 gc.pruneexpire::
-	When 'git-gc' is run, it will call 'prune --expire 2.weeks.ago'.
+	When `git-gc` is run, it will call `prune --expire 2.weeks.ago`.
 	Override the grace period with this config variable.  The value
 	"now" may be used to disable this  grace period and always prune
 	unreachable objects immediately.
 
 gc.reflogexpire::
-	'git-reflog expire' removes reflog entries older than
+	`git-reflog expire` removes reflog entries older than
 	this time; defaults to 90 days.
 
 gc.reflogexpireunreachable::
-	'git-reflog expire' removes reflog entries older than
+	`git-reflog expire` removes reflog entries older than
 	this time and are not reachable from the current tip;
 	defaults to 30 days.
 
 gc.rerereresolved::
 	Records of conflicted merge you resolved earlier are
-	kept for this many days when 'git-rerere gc' is run.
+	kept for this many days when `git-rerere gc` is run.
 	The default is 60 days.  See linkgit:git-rerere[1].
 
 gc.rerereunresolved::
 	Records of conflicted merge you have not resolved are
-	kept for this many days when 'git-rerere gc' is run.
+	kept for this many days when `git-rerere gc` is run.
 	The default is 15 days.  See linkgit:git-rerere[1].
 
 gitcvs.commitmsgannotation::
@@ -814,7 +814,7 @@ gitcvs.allbinary::
 	it is binary, similar to 'core.autocrlf'.
 
 gitcvs.dbname::
-	Database used by git-cvsserver to cache revision information
+	Database used by `git-cvsserver` to cache revision information
 	derived from the git repository. The exact meaning depends on the
 	used database driver, for SQLite (which is the default driver) this
 	is a filename. Supports variable substitution (see
@@ -823,7 +823,7 @@ gitcvs.dbname::
 
 gitcvs.dbdriver::
 	Used Perl DBI driver. You can specify any available driver
-        for this here, but it might not work. git-cvsserver is tested
+        for this here, but it might not work. `git-cvsserver` is tested
 	with 'DBD::SQLite', reported to work with 'DBD::Pg', and
 	reported *not* to work with 'DBD::mysql'. Experimental feature.
 	May not contain double colons (`:`). Default: 'SQLite'.
@@ -887,19 +887,19 @@ gui.spellingdictionary::
 	off.
 
 gui.fastcopyblame::
-	If true, 'git gui blame' uses '-C' instead of '-C -C' for original
+	If true, `git gui blame` uses '-C' instead of '-C -C' for original
 	location detection. It makes blame significantly faster on huge
 	repositories at the expense of less thorough copy detection.
 
 gui.copyblamethreshold::
-	Specifies the threshold to use in 'git gui blame' original location
+	Specifies the threshold to use in `git gui blame` original location
 	detection, measured in alphanumeric characters. See the
 	linkgit:git-blame[1] manual for more information on copy detection.
 
 gui.blamehistoryctx::
 	Specifies the radius of history context in days to show in
 	linkgit:gitk[1] for the selected commit, when the `Show History
-	Context` menu item is invoked from 'git gui blame'. If this
+	Context` menu item is invoked from `git gui blame`. If this
 	variable is set to zero, the whole history is shown.
 
 guitool.<name>.cmd::
@@ -1026,7 +1026,7 @@ i18n.commitEncoding::
 
 i18n.logOutputEncoding::
 	Character encoding the commit messages are converted to when
-	running 'git-log' and friends.
+	running `git-log` and friends.
 
 imap::
 	The configuration variables in the 'imap' section are described
@@ -1060,7 +1060,7 @@ interactive.singlekey::
 
 log.date::
 	Set default date-time mode for the log command. Setting log.date
-	value is similar to using 'git-log'\'s --date option. The value is one of the
+	value is similar to using `git-log`\'s --date option. The value is one of the
 	following alternatives: {relative,local,default,iso,rfc,short}.
 	See linkgit:git-log[1].
 
@@ -1212,7 +1212,7 @@ pull.twohead::
 	The default merge strategy to use when pulling a single branch.
 
 push.default::
-	Defines the action git push should take if no refspec is given
+	Defines the action `git push` should take if no refspec is given
 	on the command line, no refspec is configured in the remote, and
 	no refspec is implied by any of the options given on the command
 	line.
@@ -1234,7 +1234,7 @@ rebase.stat::
 	rebase. False by default.
 
 receive.fsckObjects::
-	If it is set to true, git-receive-pack will check all received
+	If it is set to true, `git-receive-pack` will check all received
 	objects. It will abort in the case of a malformed object or a
 	broken link. The result of an abort are only dangling objects.
 	Defaults to false.
@@ -1250,11 +1250,11 @@ receive.unpackLimit::
 	`transfer.unpackLimit` is used instead.
 
 receive.denyDeletes::
-	If set to true, git-receive-pack will deny a ref update that deletes
+	If set to true, `git-receive-pack` will deny a ref update that deletes
 	the ref. Use this to prevent such a ref deletion via a push.
 
 receive.denyCurrentBranch::
-	If set to true or "refuse", git-receive-pack will deny a ref update
+	If set to true or "refuse", `git-receive-pack` will deny a ref update
 	to the currently checked out branch of a non-bare repository.
 	Such a push is potentially dangerous because it brings the HEAD
 	out of sync with the index and working tree. If set to "warn",
@@ -1263,7 +1263,7 @@ receive.denyCurrentBranch::
 	message. Defaults to "warn".
 
 receive.denyNonFastForwards::
-	If set to true, git-receive-pack will deny a ref update which is
+	If set to true, `git-receive-pack` will deny a ref update which is
 	not a fast forward. Use this to prevent such an update via a push,
 	even if that push is forced. This configuration variable is
 	set when initializing a shared repository.
@@ -1306,8 +1306,8 @@ remote.<name>.tagopt::
 	fetching from remote <name>
 
 remotes.<group>::
-	The list of remotes which are fetched by "git remote update
-	<group>".  See linkgit:git-remote[1].
+	The list of remotes which are fetched by `git remote update
+	<group>`.  See linkgit:git-remote[1].
 
 repack.usedeltabaseoffset::
 	By default, linkgit:git-repack[1] creates packs that use
diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index 1eeb1c7..31653c1 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -1,5 +1,5 @@
-The output format from "git-diff-index", "git-diff-tree",
-"git-diff-files" and "git diff --raw" are very similar.
+The output format from `git-diff-index`, `git-diff-tree`,
+`git-diff-files` and `git diff --raw` are very similar.
 
 These commands all compare two sets of things; what is
 compared differs:
@@ -78,7 +78,7 @@ respectively.
 diff format for merges
 ----------------------
 
-"git-diff-tree", "git-diff-files" and "git-diff --raw"
+`git-diff-tree`, `git-diff-files` and `git-diff --raw`
 can take '-c' or '--cc' option
 to generate diff output also for merge commits.  The output differs
 from the format described above in the following way:
diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 0f25ba7..8889d19 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -1,9 +1,9 @@
 Generating patches with -p
 --------------------------
 
-When "git-diff-index", "git-diff-tree", or "git-diff-files" are run
-with a '-p' option, "git diff" without the '--raw' option, or
-"git log" with the "-p" option, they
+When `git-diff-index`, `git-diff-tree`, or `git-diff-files` are run
+with a '-p' option, `git diff` without the '--raw' option, or
+`git log` with the "-p" option, they
 do not produce the output described above; instead they produce a
 patch file.  You can customize the creation of such patches via the
 GIT_EXTERNAL_DIFF and the GIT_DIFF_OPTS environment variables.
@@ -11,7 +11,7 @@ GIT_EXTERNAL_DIFF and the GIT_DIFF_OPTS environment variables.
 What the -p option produces is slightly different from the traditional
 diff format.
 
-1.   It is preceded with a "git diff" header, that looks like
+1.   It is preceded with a `git diff` header, that looks like
      this:
 
        diff --git a/file1 b/file2
@@ -54,9 +54,9 @@ file made it into the new one.
 combined diff format
 --------------------
 
-"git-diff-tree", "git-diff-files" and "git-diff" can take '-c' or
+`git-diff-tree`, `git-diff-files` and `git-diff` can take '-c' or
 '--cc' option to produce 'combined diff'.  For showing a merge commit
-with "git log -p", this is the default format.
+with `git log -p`, this is the default format.
 A 'combined diff' format looks like this:
 
 ------------
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 9276fae..8fc26b3 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -78,7 +78,7 @@ endif::git-format-patch[]
 -z::
 	NUL-line termination on output.  This affects the --raw
 	output field terminator.  Also output from commands such
-	as "git-log" will be delimited with NUL between commits.
+	as `git-log` will be delimited with NUL between commits.
 
 --name-only::
 	Show only names of changed files.
@@ -128,7 +128,7 @@ override configuration settings.
 
 --binary::
 	In addition to --full-index, output "binary diff" that
-	can be applied with "git apply".
+	can be applied with `git apply`.
 
 --abbrev[=<n>]::
 	Instead of showing the full 40-byte hexadecimal object
diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index 9310b65..da3dfa0 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -360,7 +360,7 @@ $ grep 9418 /etc/services
 git		9418/tcp		# Git Version Control System
 ------------
 
-Run git-daemon to serve /pub/scm from inetd.::
+Run `git-daemon` to serve /pub/scm from inetd.::
 +
 ------------
 $ grep git /etc/inetd.conf
@@ -370,7 +370,7 @@ git	stream	tcp	nowait	nobody \
 +
 The actual configuration line should be on one line.
 
-Run git-daemon to serve /pub/scm from xinetd.::
+Run `git-daemon` to serve /pub/scm from xinetd.::
 +
 ------------
 $ cat /etc/xinetd.d/git-daemon
@@ -405,7 +405,7 @@ $ grep git /etc/shells <2>
 /usr/bin/git-shell
 ------------
 +
-<1> log-in shell is set to /usr/bin/git-shell, which does not
+<1> log-in shell is set to `/usr/bin/git-shell`, which does not
 allow anything but `git push` and `git pull`.  The users should
 get an ssh access to the machine.
 <2> in many distributions /etc/shells needs to list what is used
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index d313795..4aed833 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -1,6 +1,6 @@
 -q::
 --quiet::
-	Pass --quiet to git-fetch-pack and silence any other internally
+	Pass --quiet to `git-fetch-pack` and silence any other internally
 	used programs.
 
 -v::
@@ -15,13 +15,13 @@
 
 --upload-pack <upload-pack>::
 	When given, and the repository to fetch from is handled
-	by 'git-fetch-pack', '--exec=<upload-pack>' is passed to
+	by `git-fetch-pack`, `--exec=<upload-pack>` is passed to
 	the command to specify non-default path for the command
 	run on the other end.
 
 -f::
 --force::
-	When 'git-fetch' is used with `<rbranch>:<lbranch>`
+	When `git-fetch` is used with `<rbranch>:<lbranch>`
 	refspec, it refuses to update the local branch
 	`<lbranch>` unless the remote branch `<rbranch>` it
 	fetches is a descendant of `<lbranch>`.  This option
@@ -53,10 +53,10 @@ endif::git-pull[]
 
 -u::
 --update-head-ok::
-	By default 'git-fetch' refuses to update the head which
+	By default `git-fetch` refuses to update the head which
 	corresponds to the current branch.  This flag disables the
-	check.  This is purely for the internal use for 'git-pull'
-	to communicate with 'git-fetch', and unless you are
+	check.  This is purely for the internal use for `git-pull`
+	to communicate with `git-fetch`, and unless you are
 	implementing your own Porcelain you are not supposed to
 	use it.
 
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index ce71838..ef9c136 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -8,7 +8,7 @@ git-add - Add file contents to the index
 SYNOPSIS
 --------
 [verse]
-'git add' [-n] [-v] [--force | -f] [--interactive | -i] [--patch | -p]
+`git add` [-n] [-v] [--force | -f] [--interactive | -i] [--patch | -p]
 	  [--all | [--update | -u]] [--intent-to-add | -N]
 	  [--refresh] [--ignore-errors] [--] <filepattern>...
 
@@ -20,22 +20,22 @@ index, thus staging that content for inclusion in the next commit.
 The "index" holds a snapshot of the content of the working tree, and it
 is this snapshot that is taken as the contents of the next commit.  Thus
 after making any changes to the working directory, and before running
-the commit command, you must use the 'add' command to add any new or
+the commit command, you must use the `add` command to add any new or
 modified files to the index.
 
 This command can be performed multiple times before a commit.  It only
 adds the content of the specified file(s) at the time the add command is
 run; if you want subsequent changes included in the next commit, then
-you must run 'git add' again to add the new content to the index.
+you must run `git add` again to add the new content to the index.
 
-The 'git status' command can be used to obtain a summary of which
+The `git status` command can be used to obtain a summary of which
 files have changes that are staged for the next commit.
 
-The 'git add' command will not add ignored files by default.  If any
-ignored files were explicitly specified on the command line, 'git add'
+The `git add` command will not add ignored files by default.  If any
+ignored files were explicitly specified on the command line, `git add`
 will fail with a list of ignored files.  Ignored files reached by
 directory recursion or filename globbing performed by Git (quote your
-globs before the shell) will be silently ignored.  The 'add' command can
+globs before the shell) will be silently ignored.  The `add` command can
 be used to add ignored files with the `-f` (force) option.
 
 Please see linkgit:git-commit[1] for alternative ways to add content to a
@@ -81,7 +81,7 @@ OPTIONS
 	Update only files that git already knows about, staging modified
 	content for commit and marking deleted files for removal. This
 	is similar
-	to what "git commit -a" does in preparation for making a commit,
+	to what `git commit -a` does in preparation for making a commit,
 	except that the update is limited to paths specified on the
 	command line. If no paths are specified, all tracked files in the
 	current directory and its subdirectories are updated.
@@ -98,8 +98,8 @@ OPTIONS
 	Record only the fact that the path will be added later. An entry
 	for the path is placed in the index with no content. This is
 	useful for, among other things, showing the unstaged content of
-	such files with 'git diff' and committing them with 'git commit
-	-a'.
+	such files with `git diff` and committing them with `git commit
+	-a`.
 
 --refresh::
 	Don't add the file(s), but only refresh their stat()
@@ -120,7 +120,7 @@ Configuration
 -------------
 
 The optional configuration variable 'core.excludesfile' indicates a path to a
-file containing patterns of file names to exclude from git-add, similar to
+file containing patterns of file names to exclude from `git-add`, similar to
 $GIT_DIR/info/exclude.  Patterns in the exclude file are used in addition to
 those in info/exclude.  See linkgit:gitrepository-layout[5].
 
@@ -175,9 +175,9 @@ The main command loop has 6 subcommands (plus help and quit).
 status::
 
    This shows the change between HEAD and index (i.e. what will be
-   committed if you say "git commit"), and between index and
+   committed if you say `git commit`), and between index and
    working tree files (i.e. what you could stage further before
-   "git commit" using "git-add") for each path.  A sample output
+   `git commit` using `git-add`) for each path.  A sample output
    looks like this:
 +
 ------------
@@ -191,7 +191,7 @@ binary so line count cannot be shown) and there is no
 difference between indexed copy and the working tree
 version (if the working tree version were also different,
 'binary' would have been shown in place of 'nothing').  The
-other file, git-add--interactive.perl, has 403 lines added
+other file, `git-add--interactive.perl`, has 403 lines added
 and 35 lines deleted if you commit what is in the index, but
 working tree file has further modifications (one addition and
 one deletion).
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 1e71dd5..c9a444b 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -9,13 +9,13 @@ git-am - Apply a series of patches from a mailbox
 SYNOPSIS
 --------
 [verse]
-'git am' [--signoff] [--keep] [--utf8 | --no-utf8]
+`git am` [--signoff] [--keep] [--utf8 | --no-utf8]
 	 [--3way] [--interactive] [--committer-date-is-author-date]
 	 [--ignore-date]
 	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
 	 [--reject]
 	 [<mbox> | <Maildir>...]
-'git am' (--skip | --resolved | --abort)
+`git am` (--skip | --resolved | --abort)
 
 DESCRIPTION
 -----------
@@ -37,11 +37,11 @@ OPTIONS
 
 -k::
 --keep::
-	Pass `-k` flag to 'git-mailinfo' (see linkgit:git-mailinfo[1]).
+	Pass `-k` flag to `git-mailinfo` (see linkgit:git-mailinfo[1]).
 
 -u::
 --utf8::
-	Pass `-u` flag to 'git-mailinfo' (see linkgit:git-mailinfo[1]).
+	Pass `-u` flag to `git-mailinfo` (see linkgit:git-mailinfo[1]).
 	The proposed commit log message taken from the e-mail
 	is re-coded into UTF-8 encoding (configuration variable
 	`i18n.commitencoding` can be used to specify project's
@@ -51,7 +51,7 @@ This was optional in prior versions of git, but now it is the
 default.   You can use `--no-utf8` to override this.
 
 --no-utf8::
-	Pass `-n` flag to 'git-mailinfo' (see
+	Pass `-n` flag to `git-mailinfo` (see
 	linkgit:git-mailinfo[1]).
 
 -3::
@@ -66,7 +66,7 @@ default.   You can use `--no-utf8` to override this.
 -p<n>::
 --directory=<dir>::
 --reject::
-	These flags are passed to the 'git-apply' (see linkgit:git-apply[1])
+	These flags are passed to the `git-apply` (see linkgit:git-apply[1])
 	program that applies
 	the patch.
 
@@ -106,7 +106,7 @@ default.   You can use `--no-utf8` to override this.
 	to the screen before exiting.  This overrides the
 	standard message informing you to use `--resolved`
 	or `--skip` to handle the failure.  This is solely
-	for internal use between 'git-rebase' and 'git-am'.
+	for internal use between `git-rebase` and `git-am`.
 
 --abort::
 	Restore the original branch and abort the patching operation.
@@ -159,7 +159,7 @@ names.
 
 Before any patches are applied, ORIG_HEAD is set to the tip of the
 current branch.  This is useful if you have problems with multiple
-commits, like running 'git am' on the wrong branch or an error in the
+commits, like running `git am` on the wrong branch or an error in the
 commits that is more easily fixed by changing the mailbox (e.g.
 errors in the "From:" lines).
 
-- 
1.6.2.149.g6462
