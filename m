From: Tom Russello <tom.russello@grenoble-inp.org>
Subject: [PATCH v3 3/3] doc: change configuration variables format
Date: Mon,  6 Jun 2016 12:09:05 +0200
Message-ID: <20160606100905.23006-4-tom.russello@grenoble-inp.org>
References: <20160603220837.9842-1-tom.russello@grenoble-inp.org>
 <20160606100905.23006-1-tom.russello@grenoble-inp.org>
Cc: gitster@pobox.com, erwan.mathoniere@grenoble-inp.org,
	samuel.groot@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr,
	Tom Russello <tom.russello@grenoble-inp.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 12:09:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9rTa-0006eY-0k
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 12:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbcFFKJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 06:09:33 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:52164 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbcFFKJa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 06:09:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 7C92420B4;
	Mon,  6 Jun 2016 12:09:27 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q0Ht0NisBfJe; Mon,  6 Jun 2016 12:09:27 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 65E1D20AA;
	Mon,  6 Jun 2016 12:09:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 60AEC2066;
	Mon,  6 Jun 2016 12:09:27 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IFJmqP8Oys7o; Mon,  6 Jun 2016 12:09:27 +0200 (CEST)
Received: from ux-305.grenet.fr (eduroam-033212.grenet.fr [130.190.33.212])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 3EDFB2055;
	Mon,  6 Jun 2016 12:09:27 +0200 (CEST)
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160606100905.23006-1-tom.russello@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296496>

As a first step, this change configuration variables that where in italic style
to monospace font according to the guideline. It was obtained with

	grep '[[:alpha:]]*\.[[:alpha:]]*::$' config.txt | \
	sed -e 's/::$//' -e 's/\./\\\\./' | \
	xargs -iP perl -pi -e "s/\'P\'/\`P\`/g" ./*.txt

Signed-off-by: Tom Russello <tom.russello@grenoble-inp.org>
Signed-off-by: Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>
Signed-off-by: Samuel Groot <samuel.groot@grenoble-inp.org>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
Currently, in Documentation/git-status.txt, status.relativePaths (l.120) has no
particular style whereas in Documentation/git-send-email.txt, sendemail.annotate
is wrapped with single-quotes ('sendemail.annotate' - l.50) and
sendemail.xmailer is wrapped with backticks (`sendemail.xmailer` - l.149).

 Documentation/config.txt            | 26 ++++++++--------
 Documentation/diff-config.txt       |  2 +-
 Documentation/git-commit.txt        |  2 +-
 Documentation/git-format-patch.txt  |  6 ++--
 Documentation/git-gc.txt            | 16 +++++-----
 Documentation/git-grep.txt          |  2 +-
 Documentation/git-help.txt          | 24 +++++++-------
 Documentation/git-instaweb.txt      |  4 +--
 Documentation/git-push.txt          |  6 ++--
 Documentation/git-send-email.txt    | 62 ++++++++++++++++++-------------------
 Documentation/git-svn.txt           |  2 +-
 Documentation/git-tag.txt           |  2 +-
 Documentation/git-web--browse.txt   |  6 ++--
 Documentation/git.txt               |  2 +-
 Documentation/gitignore.txt         |  2 +-
 Documentation/gitremote-helpers.txt |  4 +--
 Documentation/pretty-options.txt    |  4 +--
 17 files changed, 86 insertions(+), 86 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3897906..c645d1f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -545,7 +545,7 @@ core.compression::
 	-1 is the zlib default. 0 means no compression,
 	and 1..9 are various speed/size tradeoffs, 9 being slowest.
 	If set, this provides a default to other compression variables,
-	such as 'core.looseCompression' and 'pack.compression'.
+	such as `core.looseCompression` and `pack.compression`.
 
 core.looseCompression::
 	An integer -1..9, indicating the compression level for objects that
@@ -1426,18 +1426,18 @@ gitcvs.usecrlfattr::
 	treat it as text. If they suppress text conversion, the file
 	will be set with '-kb' mode, which suppresses any newline munging
 	the client might otherwise do. If the attributes do not allow
-	the file type to be determined, then 'gitcvs.allBinary' is
+	the file type to be determined, then `gitcvs.allBinary` is
 	used. See linkgit:gitattributes[5].
 
 gitcvs.allBinary::
-	This is used if 'gitcvs.usecrlfattr' does not resolve
+	This is used if `gitcvs.usecrlfattr` does not resolve
 	the correct '-kb' mode to use. If true, all
 	unresolved files are sent to the client in
 	mode '-kb'. This causes the client to treat them
 	as binary files, which suppresses any newline munging it
 	otherwise might do. Alternatively, if it is set to "guess",
 	then the contents of the file are examined to decide if
-	it is binary, similar to 'core.autocrlf'.
+	it is binary, similar to `core.autocrlf`.
 
 gitcvs.dbName::
 	Database used by git-cvsserver to cache revision information
@@ -1456,7 +1456,7 @@ gitcvs.dbDriver::
 	See linkgit:git-cvsserver[1].
 
 gitcvs.dbUser, gitcvs.dbPass::
-	Database user and password. Only useful if setting 'gitcvs.dbDriver',
+	Database user and password. Only useful if setting `gitcvs.dbDriver`,
 	since SQLite has no concept of database users and/or passwords.
 	'gitcvs.dbUser' supports variable substitution (see
 	linkgit:git-cvsserver[1] for details).
@@ -1468,8 +1468,8 @@ gitcvs.dbTableNamePrefix::
 	linkgit:git-cvsserver[1] for details).  Any non-alphabetic
 	characters will be replaced with underscores.
 
-All gitcvs variables except for 'gitcvs.usecrlfattr' and
-'gitcvs.allBinary' can also be specified as
+All gitcvs variables except for `gitcvs.usecrlfattr` and
+`gitcvs.allBinary` can also be specified as
 'gitcvs.<access_method>.<varname>' (where 'access_method'
 is one of "ext" and "pserver") to make them apply only for the given
 access method.
@@ -1502,7 +1502,7 @@ grep.patternType::
 
 grep.extendedRegexp::
 	If set to true, enable '--extended-regexp' option by default. This
-	option is ignored when the 'grep.patternType' option is set to a value
+	option is ignored when the `grep.patternType` option is set to a value
 	other than 'default'.
 
 grep.threads::
@@ -2630,7 +2630,7 @@ sendemail.identity::
 	A configuration identity. When given, causes values in the
 	'sendemail.<identity>' subsection to take precedence over
 	values in the 'sendemail' section. The default identity is
-	the value of 'sendemail.identity'.
+	the value of `sendemail.identity`.
 
 sendemail.smtpEncryption::
 	See linkgit:git-send-email[1] for description.  Note that this
@@ -2647,7 +2647,7 @@ sendemail.<identity>.*::
 	Identity-specific versions of the 'sendemail.*' parameters
 	found below, taking precedence over those when the this
 	identity is selected, through command-line or
-	'sendemail.identity'.
+	`sendemail.identity`.
 
 sendemail.aliasesFile::
 sendemail.aliasFileType::
@@ -2677,7 +2677,7 @@ sendemail.xmailer::
 	See linkgit:git-send-email[1] for description.
 
 sendemail.signedoffcc (deprecated)::
-	Deprecated alias for 'sendemail.signedoffbycc'.
+	Deprecated alias for `sendemail.signedoffbycc`.
 
 showbranch.default::
 	The default set of branches for linkgit:git-show-branch[1].
@@ -2918,8 +2918,8 @@ user.name::
 	environment variables.  See linkgit:git-commit-tree[1].
 
 user.useConfigOnly::
-	Instruct Git to avoid trying to guess defaults for 'user.email'
-	and 'user.name', and instead retrieve the values only from the
+	Instruct Git to avoid trying to guess defaults for `user.email`
+	and `user.name`, and instead retrieve the values only from the
 	configuration. For example, if you have multiple email addresses
 	and would like to use a different one for each repository, then
 	with this configuration option set to `true` in the global config
diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index edba565..f8a5059 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -75,7 +75,7 @@ diff.ignoreSubmodules::
 	commands such as 'git diff-files'. 'git checkout' also honors
 	this setting when reporting uncommitted changes. Setting it to
 	'all' disables the submodule summary normally shown by 'git commit'
-	and 'git status' when 'status.submoduleSummary' is set unless it is
+	and 'git status' when `status.submoduleSummary` is set unless it is
 	overridden by using the --ignore-submodules command-line option.
 	The 'git submodule' commands are not affected by this setting.
 
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index d474226..9121773 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -201,7 +201,7 @@ default::
 	Otherwise `whitespace`.
 --
 +
-The default can be changed by the 'commit.cleanup' configuration
+The default can be changed by the `commit.cleanup` configuration
 variable (see linkgit:git-config[1]).
 
 -e::
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index bdeecd5..9624c84 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -58,7 +58,7 @@ output, unless the `--stdout` option is specified.
 
 If `-o` is specified, output files are created in <dir>.  Otherwise
 they are created in the current working directory. The default path
-can be set with the 'format.outputDirectory' configuration option.
+can be set with the `format.outputDirectory` configuration option.
 The `-o` option takes precedence over `format.outputDirectory`.
 To store patches in the current working directory even when
 `format.outputDirectory` points elsewhere, use `-o .`.
@@ -146,9 +146,9 @@ series, where the head is chosen from the cover letter, the
 `--in-reply-to`, and the first patch mail, in this order.  'deep'
 threading makes every mail a reply to the previous one.
 +
-The default is `--no-thread`, unless the 'format.thread' configuration
+The default is `--no-thread`, unless the `format.thread` configuration
 is set.  If `--thread` is specified without a style, it defaults to the
-style specified by 'format.thread' if any, or else `shallow`.
+style specified by `format.thread` if any, or else `shallow`.
 +
 Beware that the default for 'git send-email' is to thread emails
 itself.  If you want `git format-patch` to take care of threading, you
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index fa15104..bed60f4 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -82,13 +82,13 @@ automatic consolidation of packs.
 Configuration
 -------------
 
-The optional configuration variable 'gc.reflogExpire' can be
+The optional configuration variable `gc.reflogExpire` can be
 set to indicate how long historical entries within each branch's
 reflog should remain available in this repository.  The setting is
 expressed as a length of time, for example '90 days' or '3 months'.
 It defaults to '90 days'.
 
-The optional configuration variable 'gc.reflogExpireUnreachable'
+The optional configuration variable `gc.reflogExpireUnreachable`
 can be set to indicate how long historical reflog entries which
 are not part of the current branch should remain available in
 this repository.  These types of entries are generally created as
@@ -107,30 +107,30 @@ branches:
 	reflogExpireUnreachable = 3 days
 ------------
 
-The optional configuration variable 'gc.rerereResolved' indicates
+The optional configuration variable `gc.rerereResolved` indicates
 how long records of conflicted merge you resolved earlier are
 kept.  This defaults to 60 days.
 
-The optional configuration variable 'gc.rerereUnresolved' indicates
+The optional configuration variable `gc.rerereUnresolved` indicates
 how long records of conflicted merge you have not resolved are
 kept.  This defaults to 15 days.
 
-The optional configuration variable 'gc.packRefs' determines if
+The optional configuration variable `gc.packRefs` determines if
 'git gc' runs 'git pack-refs'. This can be set to "notbare" to enable
 it within all non-bare repos or it can be set to a boolean value.
 This defaults to true.
 
-The optional configuration variable 'gc.aggressiveWindow' controls how
+The optional configuration variable `gc.aggressiveWindow` controls how
 much time is spent optimizing the delta compression of the objects in
 the repository when the --aggressive option is specified.  The larger
 the value, the more time is spent optimizing the delta compression.  See
 the documentation for the --window' option in linkgit:git-repack[1] for
 more details.  This defaults to 250.
 
-Similarly, the optional configuration variable 'gc.aggressiveDepth'
+Similarly, the optional configuration variable `gc.aggressiveDepth`
 controls --depth option in linkgit:git-repack[1]. This defaults to 250.
 
-The optional configuration variable 'gc.pruneExpire' controls how old
+The optional configuration variable `gc.pruneExpire` controls how old
 the unreferenced loose objects have to be before they are pruned.  The
 default is "2 weeks ago".
 
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index cb0f6cf..40cfe37 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -51,7 +51,7 @@ grep.patternType::
 
 grep.extendedRegexp::
 	If set to true, enable '--extended-regexp' option by default. This
-	option is ignored when the 'grep.patternType' option is set to a value
+	option is ignored when the `grep.patternType` option is set to a value
 	other than 'default'.
 
 grep.threads::
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 3956525..22500e0 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -57,10 +57,10 @@ OPTIONS
 --man::
 	Display manual page for the command in the 'man' format. This
 	option may be used to override a value set in the
-	'help.format' configuration variable.
+	`help.format` configuration variable.
 +
 By default the 'man' program will be used to display the manual page,
-but the 'man.viewer' configuration variable may be used to choose
+but the `man.viewer` configuration variable may be used to choose
 other display programs (see below).
 
 -w::
@@ -69,7 +69,7 @@ other display programs (see below).
 	format. A web browser will be used for that purpose.
 +
 The web browser can be specified using the configuration variable
-'help.browser', or 'web.browser' if the former is not set. If none of
+`help.browser`, or `web.browser` if the former is not set. If none of
 these config variables is set, the 'git web{litdd}browse' helper script
 (called by 'git help') will pick a suitable default. See
 linkgit:git-web{litdd}browse[1] for more information about this.
@@ -80,7 +80,7 @@ CONFIGURATION VARIABLES
 help.format
 ~~~~~~~~~~~
 
-If no command-line option is passed, the 'help.format' configuration
+If no command-line option is passed, the `help.format` configuration
 variable will be checked. The following values are supported for this
 variable; they make 'git help' behave as their corresponding command-
 line option:
@@ -92,7 +92,7 @@ line option:
 help.browser, web.browser and browser.<tool>.path
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-The 'help.browser', 'web.browser' and 'browser.<tool>.path' will also
+The `help.browser`, `web.browser` and `browser.<tool>.path` will also
 be checked if the 'web' format is chosen (either by command-line
 option or configuration variable). See '-w|--web' in the OPTIONS
 section above and linkgit:git-web{litdd}browse[1].
@@ -100,7 +100,7 @@ section above and linkgit:git-web{litdd}browse[1].
 man.viewer
 ~~~~~~~~~~
 
-The 'man.viewer' configuration variable will be checked if the 'man'
+The `man.viewer` configuration variable will be checked if the 'man'
 format is chosen. The following values are currently supported:
 
 * "man": use the 'man' program as usual,
@@ -110,9 +110,9 @@ format is chosen. The following values are currently supported:
 tab (see 'Note about konqueror' below).
 
 Values for other tools can be used if there is a corresponding
-'man.<tool>.cmd' configuration entry (see below).
+`man.<tool>.cmd` configuration entry (see below).
 
-Multiple values may be given to the 'man.viewer' configuration
+Multiple values may be given to the `man.viewer` configuration
 variable. Their corresponding programs will be tried in the order
 listed in the configuration file.
 
@@ -135,7 +135,7 @@ man.<tool>.path
 ~~~~~~~~~~~~~~~
 
 You can explicitly provide a full path to your preferred man viewer by
-setting the configuration variable 'man.<tool>.path'. For example, you
+setting the configuration variable `man.<tool>.path`. For example, you
 can configure the absolute path to konqueror by setting
 'man.konqueror.path'. Otherwise, 'git help' assumes the tool is
 available in PATH.
@@ -143,9 +143,9 @@ available in PATH.
 man.<tool>.cmd
 ~~~~~~~~~~~~~~
 
-When the man viewer, specified by the 'man.viewer' configuration
+When the man viewer, specified by the `man.viewer` configuration
 variables, is not among the supported ones, then the corresponding
-'man.<tool>.cmd' configuration variable will be looked up. If this
+`man.<tool>.cmd` configuration variable will be looked up. If this
 variable exists then the specified tool will be treated as a custom
 command and a shell eval will be used to run the command with the man
 page passed as arguments.
@@ -153,7 +153,7 @@ page passed as arguments.
 Note about konqueror
 ~~~~~~~~~~~~~~~~~~~~
 
-When 'konqueror' is specified in the 'man.viewer' configuration
+When 'konqueror' is specified in the `man.viewer` configuration
 variable, we launch 'kfmclient' to try to open the man page on an
 already opened konqueror in a new tab if possible.
 
diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instaweb.txt
index cc75b25..e8ecdbf 100644
--- a/Documentation/git-instaweb.txt
+++ b/Documentation/git-instaweb.txt
@@ -80,8 +80,8 @@ You may specify configuration in your .git/config
 
 -----------------------------------------------------------------------
 
-If the configuration variable 'instaweb.browser' is not set,
-'web.browser' will be used instead if it is defined. See
+If the configuration variable `instaweb.browser` is not set,
+`web.browser` will be used instead if it is defined. See
 linkgit:git-web{litdd}browse[1] for more information about this.
 
 SEE ALSO
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index cf6ee4a..19f46b6 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -137,8 +137,8 @@ already exists on the remote side.
 	and also push annotated tags in `refs/tags` that are missing
 	from the remote but are pointing at commit-ish that are
 	reachable from the refs being pushed.  This can also be specified
-	with configuration variable 'push.followTags'.  For more
-	information, see 'push.followTags' in linkgit:git-config[1].
+	with configuration variable `push.followTags`.  For more
+	information, see `push.followTags` in linkgit:git-config[1].
 
 --[no-]signed::
 --sign=(true|false|if-asked)::
@@ -240,7 +240,7 @@ origin +master` to force a push to the `master` branch). See the
 	For every branch that is up to date or successfully pushed, add
 	upstream (tracking) reference, used by argument-less
 	linkgit:git-pull[1] and other commands. For more information,
-	see 'branch.<name>.merge' in linkgit:git-config[1].
+	see `branch.<name>.merge` in linkgit:git-config[1].
 
 --[no-]thin::
 	These options are passed to linkgit:git-send-pack[1]. A thin transfer
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index edbba3a..f9ff9c1 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -47,18 +47,18 @@ Composing
 
 --annotate::
 	Review and edit each patch you're about to send. Default is the value
-	of 'sendemail.annotate'. See the CONFIGURATION section for
-	'sendemail.multiEdit'.
+	of `sendemail.annotate`. See the CONFIGURATION section for
+	`sendemail.multiEdit`.
 
 --bcc=<address>,...::
 	Specify a "Bcc:" value for each email. Default is the value of
-	'sendemail.bcc'.
+	`sendemail.bcc`.
 +
 This option may be specified multiple times.
 
 --cc=<address>,...::
 	Specify a starting "Cc:" value for each email.
-	Default is the value of 'sendemail.cc'.
+	Default is the value of `sendemail.cc`.
 +
 This option may be specified multiple times.
 
@@ -74,12 +74,12 @@ and In-Reply-To headers will be used unless they are removed.
 +
 Missing From or In-Reply-To headers will be prompted for.
 +
-See the CONFIGURATION section for 'sendemail.multiEdit'.
+See the CONFIGURATION section for `sendemail.multiEdit`.
 
 --from=<address>::
 	Specify the sender of the emails.  If not specified on the command line,
-	the value of the 'sendemail.from' configuration option is used.  If
-	neither the command-line option nor 'sendemail.from' are set, then the
+	the value of the `sendemail.from` configuration option is used.  If
+	neither the command-line option nor `sendemail.from` are set, then the
 	user will be prompted for the value.  The default for the prompt will be
 	the value of GIT_AUTHOR_IDENT, or GIT_COMMITTER_IDENT if that is not
 	set, as returned by "git var -l".
@@ -114,7 +114,7 @@ is not set, this will be prompted for.
 --to=<address>,...::
 	Specify the primary recipient of the emails generated. Generally, this
 	will be the upstream maintainer of the project involved. Default is the
-	value of the 'sendemail.to' configuration value; if that is unspecified,
+	value of the `sendemail.to` configuration value; if that is unspecified,
 	and --to-cmd is not specified, this will be prompted for.
 +
 This option may be specified multiple times.
@@ -138,7 +138,7 @@ Note that no attempts whatsoever are made to validate the encoding.
 	can be useful when the repository contains files that contain carriage
 	returns, but makes the raw patch email file (as saved from a MUA) much
 	harder to inspect manually.  base64 is even more fool proof, but also
-	even more opaque.  Default is the value of the 'sendemail.transferEncoding'
+	even more opaque.  Default is the value of the `sendemail.transferEncoding`
 	configuration value; if that is unspecified, git will use 8bit and not
 	add a Content-Transfer-Encoding header.
 
@@ -157,20 +157,20 @@ Sending
 	subscribed to a list. In order to use the 'From' address, set the
 	value to "auto". If you use the sendmail binary, you must have
 	suitable privileges for the -f parameter.  Default is the value of the
-	'sendemail.envelopeSender' configuration variable; if that is
+	`sendemail.envelopeSender` configuration variable; if that is
 	unspecified, choosing the envelope sender is left to your MTA.
 
 --smtp-encryption=<encryption>::
 	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
 	value reverts to plain SMTP.  Default is the value of
-	'sendemail.smtpEncryption'.
+	`sendemail.smtpEncryption`.
 
 --smtp-domain=<FQDN>::
 	Specifies the Fully Qualified Domain Name (FQDN) used in the
 	HELO/EHLO command to the SMTP server.  Some servers require the
 	FQDN to match your IP address.  If not set, git send-email attempts
 	to determine your FQDN automatically.  Default is the value of
-	'sendemail.smtpDomain'.
+	`sendemail.smtpDomain`.
 
 --smtp-auth=<mechanisms>::
 	Whitespace-separated list of allowed SMTP-AUTH mechanisms. This setting
@@ -188,13 +188,13 @@ is specified, all mechanisms supported by the SASL library can be used.
 --smtp-pass[=<password>]::
 	Password for SMTP-AUTH. The argument is optional: If no
 	argument is specified, then the empty string is used as
-	the password. Default is the value of 'sendemail.smtpPass',
+	the password. Default is the value of `sendemail.smtpPass`,
 	however '--smtp-pass' always overrides this value.
 +
 Furthermore, passwords need not be specified in configuration files
 or on the command line. If a username has been specified (with
-'--smtp-user' or a 'sendemail.smtpUser'), but no password has been
-specified (with '--smtp-pass' or 'sendemail.smtpPass'), then
+'--smtp-user' or a `sendemail.smtpUser`), but no password has been
+specified (with '--smtp-pass' or `sendemail.smtpPass`), then
 a password is obtained using 'git-credential'.
 
 --smtp-server=<host>::
@@ -202,7 +202,7 @@ a password is obtained using 'git-credential'.
 	`smtp.example.com` or a raw IP address).  Alternatively it can
 	specify a full pathname of a sendmail-like program instead;
 	the program must support the `-i` option.  Default value can
-	be specified by the 'sendemail.smtpServer' configuration
+	be specified by the `sendemail.smtpServer` configuration
 	option; the built-in default is `/usr/sbin/sendmail` or
 	`/usr/lib/sendmail` if such program is available, or
 	`localhost` otherwise.
@@ -213,11 +213,11 @@ a password is obtained using 'git-credential'.
 	submission port 587, or the common SSL smtp port 465);
 	symbolic port names (e.g. "submission" instead of 587)
 	are also accepted. The port can also be set with the
-	'sendemail.smtpServerPort' configuration variable.
+	`sendemail.smtpServerPort` configuration variable.
 
 --smtp-server-option=<option>::
 	If set, specifies the outgoing SMTP server option to use.
-	Default value can be specified by the 'sendemail.smtpServerOption'
+	Default value can be specified by the `sendemail.smtpServerOption`
 	configuration option.
 +
 The --smtp-server-option option must be repeated for each option you want
@@ -234,13 +234,13 @@ must be used for each option.
 	certificates concatenated together: see verify(1) -CAfile and
 	-CApath for more information on these). Set it to an empty string
 	to disable certificate verification. Defaults to the value of the
-	'sendemail.smtpsslcertpath' configuration variable, if set, or the
+	`sendemail.smtpsslcertpath` configuration variable, if set, or the
 	backing SSL library's compiled-in default otherwise (which should
 	be the best choice on most platforms).
 
 --smtp-user=<user>::
-	Username for SMTP-AUTH. Default is the value of 'sendemail.smtpUser';
-	if a username is not specified (with '--smtp-user' or 'sendemail.smtpUser'),
+	Username for SMTP-AUTH. Default is the value of `sendemail.smtpUser`;
+	if a username is not specified (with '--smtp-user' or `sendemail.smtpUser`),
 	then authentication is not attempted.
 
 --smtp-debug=0|1::
@@ -261,25 +261,25 @@ Automating
 	Specify a command to execute once per patch file which
 	should generate patch file specific "Cc:" entries.
 	Output of this command must be single email address per line.
-	Default is the value of 'sendemail.ccCmd' configuration value.
+	Default is the value of `sendemail.ccCmd` configuration value.
 
 --[no-]chain-reply-to::
 	If this is set, each email will be sent as a reply to the previous
 	email sent.  If disabled with "--no-chain-reply-to", all emails after
 	the first will be sent as replies to the first email sent.  When using
 	this, it is recommended that the first file given be an overview of the
-	entire patch series. Disabled by default, but the 'sendemail.chainReplyTo'
+	entire patch series. Disabled by default, but the `sendemail.chainReplyTo`
 	configuration variable can be used to enable it.
 
 --identity=<identity>::
 	A configuration identity. When given, causes values in the
 	'sendemail.<identity>' subsection to take precedence over
 	values in the 'sendemail' section. The default identity is
-	the value of 'sendemail.identity'.
+	the value of `sendemail.identity`.
 
 --[no-]signed-off-by-cc::
 	If this is set, add emails found in Signed-off-by: or Cc: lines to the
-	cc list. Default is the value of 'sendemail.signedoffbycc' configuration
+	cc list. Default is the value of `sendemail.signedoffbycc` configuration
 	value; if that is unspecified, default to --signed-off-by-cc.
 
 --[no-]cc-cover::
@@ -312,13 +312,13 @@ Automating
 - 'all' will suppress all auto cc values.
 --
 +
-Default is the value of 'sendemail.suppresscc' configuration value; if
+Default is the value of `sendemail.suppresscc` configuration value; if
 that is unspecified, default to 'self' if --suppress-from is
 specified, as well as 'body' if --no-signed-off-cc is specified.
 
 --[no-]suppress-from::
 	If this is set, do not add the From: address to the cc: list.
-	Default is the value of 'sendemail.suppressFrom' configuration
+	Default is the value of `sendemail.suppressFrom` configuration
 	value; if that is unspecified, default to --no-suppress-from.
 
 --[no-]thread::
@@ -330,7 +330,7 @@ specified, as well as 'body' if --no-signed-off-cc is specified.
 +
 If disabled with "--no-thread", those headers will not be added
 (unless specified with --in-reply-to).  Default is the value of the
-'sendemail.thread' configuration value; if that is unspecified,
+`sendemail.thread` configuration value; if that is unspecified,
 default to --thread.
 +
 It is up to the user to ensure that no In-Reply-To header already
@@ -355,7 +355,7 @@ Administering
 - 'auto' is equivalent to 'cc' + 'compose'
 --
 +
-Default is the value of 'sendemail.confirm' configuration value; if that
+Default is the value of `sendemail.confirm` configuration value; if that
 is unspecified, default to 'auto' unless any of the suppress options
 have been specified, in which case default to 'compose'.
 
@@ -381,7 +381,7 @@ have been specified, in which case default to 'compose'.
 			is due to SMTP limits as described by http://www.ietf.org/rfc/rfc2821.txt.
 --
 +
-Default is the value of 'sendemail.validate'; if this is not set,
+Default is the value of `sendemail.validate`; if this is not set,
 default to '--validate'.
 
 --force::
@@ -403,7 +403,7 @@ CONFIGURATION
 
 sendemail.aliasesFile::
 	To avoid typing long email addresses, point this to one or more
-	email aliases files.  You must also supply 'sendemail.aliasFileType'.
+	email aliases files.  You must also supply `sendemail.aliasFileType`.
 
 sendemail.aliasFileType::
 	Format of the file(s) specified in sendemail.aliasesFile. Must be
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index fb23a98..90a7079 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -748,7 +748,7 @@ svn-remote.<name>.rewriteUUID::
 
 svn-remote.<name>.pushurl::
 
-	Similar to Git's 'remote.<name>.pushurl', this key is designed
+	Similar to Git's `remote.<name>.pushurl`, this key is designed
 	to be used in cases where 'url' points to an SVN repository
 	via a read-only transport, to provide an alternate read/write
 	transport. It is assumed that both keys point to the same
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index abab481..4b1c1b8 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -104,7 +104,7 @@ OPTIONS
 	order can also be affected by the
 	"versionsort.prereleaseSuffix" configuration variable.
 	The keys supported are the same as those in `git for-each-ref`.
-	Sort order defaults to the value configured for the 'tag.sort'
+	Sort order defaults to the value configured for the `tag.sort`
 	variable if it exists, or lexicographic order otherwise. See
 	linkgit:git-config[1].
 
diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index 16ede5b..7daa28f 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -62,14 +62,14 @@ CONF.VAR (from -c option) and web.browser
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The web browser can be specified using a configuration variable passed
-with the -c (or --config) command-line option, or the 'web.browser'
+with the -c (or --config) command-line option, or the `web.browser`
 configuration variable if the former is not used.
 
 browser.<tool>.path
 ~~~~~~~~~~~~~~~~~~~
 
 You can explicitly provide a full path to your preferred browser by
-setting the configuration variable 'browser.<tool>.path'. For example,
+setting the configuration variable `browser.<tool>.path`. For example,
 you can configure the absolute path to firefox by setting
 'browser.firefox.path'. Otherwise, 'git web{litdd}browse' assumes the tool
 is available in PATH.
@@ -79,7 +79,7 @@ browser.<tool>.cmd
 
 When the browser, specified by options or configuration variables, is
 not among the supported ones, then the corresponding
-'browser.<tool>.cmd' configuration variable will be looked up. If this
+`browser.<tool>.cmd` configuration variable will be looked up. If this
 variable exists then 'git web{litdd}browse' will treat the specified tool
 as a custom command and will use a shell eval to run the command with
 the URLs passed as arguments.
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 48f5bf7..bc6a231 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -990,7 +990,7 @@ for further details.
 	If this environment variable is set, then Git commands which need to
 	acquire passwords or passphrases (e.g. for HTTP or IMAP authentication)
 	will call this program with a suitable prompt as command-line argument
-	and read the password from its STDOUT. See also the 'core.askPass'
+	and read the password from its STDOUT. See also the `core.askPass`
 	option in linkgit:git-config[1].
 
 `GIT_TERMINAL_PROMPT`::
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 473623d..63260f0 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -38,7 +38,7 @@ precedence, the last matching pattern decides the outcome):
  * Patterns read from `$GIT_DIR/info/exclude`.
 
  * Patterns read from the file specified by the configuration
-   variable 'core.excludesFile'.
+   variable `core.excludesFile`.
 
 Which file to place a pattern in depends on how the pattern is meant to
 be used.
diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index e279327..1e86594 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -61,10 +61,10 @@ argument. If such a URL is encountered directly on the command line,
 the first argument is '<address>', and if it is encountered in a
 configured remote, the first argument is the name of that remote.
 
-Additionally, when a configured remote has 'remote.<name>.vcs' set to
+Additionally, when a configured remote has `remote.<name>.vcs` set to
 '<transport>', Git explicitly invokes 'git remote-<transport>' with
 '<name>' as the first argument. If set, the second argument is
-'remote.<name>.url'; otherwise, the second argument is omitted.
+`remote.<name>.url`; otherwise, the second argument is omitted.
 
 INPUT FORMAT
 ------------
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 6c67182..e44fc8f 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -26,7 +26,7 @@ people using 80-column terminals.
 --no-abbrev-commit::
 	Show the full 40-byte hexadecimal commit object name. This negates
 	`--abbrev-commit` and those options which imply it such as
-	"--oneline". It also overrides the 'log.abbrevCommit' variable.
+	"--oneline". It also overrides the `log.abbrevCommit` variable.
 
 --oneline::
 	This is a shorthand for "--pretty=oneline --abbrev-commit"
@@ -65,7 +65,7 @@ ifndef::git-rev-list[]
 	on the command line.
 +
 By default, the notes shown are from the notes refs listed in the
-'core.notesRef' and 'notes.displayRef' variables (or corresponding
+`core.notesRef` and `notes.displayRef` variables (or corresponding
 environment overrides). See linkgit:git-config[1] for more details.
 +
 With an optional '<treeish>' argument, use the treeish to find the notes
-- 
2.8.3
