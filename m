From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] *config.txt: stick to camelCase naming convention
Date: Wed, 11 Mar 2015 19:20:18 +0700
Message-ID: <1426076418-13741-1-git-send-email-pclouds@gmail.com>
References: <xmqqfv9cxwsm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 11 13:21:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVfdF-0003QB-6G
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 13:21:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbbCKMUz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Mar 2015 08:20:55 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:46443 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbbCKMUl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 08:20:41 -0400
Received: by pdev10 with SMTP id v10so10779972pde.13
        for <git@vger.kernel.org>; Wed, 11 Mar 2015 05:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=69YG+gWzUUdN32bDo2abBiJJsq9DzZCpDKW1fHyXC9A=;
        b=VGpzJIxuU12GnC1F4FIFUvHTfreEWGYm1dSmJ9+KyJQG1UyCL5+vW7/Gfj9NrNoGb8
         32Tja7X/xx75xnK7AIyuCJ7HFniFb8z47YdkNSMtOAl628x7Hu+rSbZKGHVNC8yutTyI
         W3ZHnopSQcPb/3FOMhOVqmtnzjpo/LX8uq6N0TcVgOOV/tkpNWbXXzo3EGLP0P257wkM
         k8Cu6/+xz7DNP1u8Q7Yx/i23rMrc4KFv8b6Qv8g3JIG6+xZ3/sKO6ucn7XJ27JWgpCPa
         USF5MQJiUtdWcPIbVj1KIBLw3Lq5PG9Ub2pPvNu8DX2pbW1kMDsx8rzv334JEaoJMNz6
         0WKw==
X-Received: by 10.70.88.234 with SMTP id bj10mr53109341pdb.165.1426076440796;
        Wed, 11 Mar 2015 05:20:40 -0700 (PDT)
Received: from lanh ([115.73.203.101])
        by mx.google.com with ESMTPSA id cb9sm5844893pad.46.2015.03.11.05.20.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Mar 2015 05:20:39 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 11 Mar 2015 19:20:37 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <xmqqfv9cxwsm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265322>

This should improve readability. Compare "thislongname" and
"thisLongName". The following keys are left in unchanged. We can
decide what to do with them later.

 - am.keepcr
 - core.autocrlf .safecrlf .trustctime
 - diff.dirstat .noprefix
 - gitcvs.usecrlfattr
 - gui.blamehistoryctx .trustmtime
 - pull.twohead
 - receive.autogc
 - sendemail.signedoffbycc .smtpsslcertpath .suppresscc

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt       | 190 ++++++++++++++++++++-------------=
--------
 Documentation/diff-config.txt  |   8 +-
 Documentation/merge-config.txt |   2 +-
 3 files changed, 100 insertions(+), 100 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1530255..54ae0f6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -225,7 +225,7 @@ See linkgit:git-update-index[1].
 +
 The default is true (when core.filemode is not specified in the config=
 file).
=20
-core.ignorecase::
+core.ignoreCase::
 	If true, this option enables various workarounds to enable
 	Git to work better on filesystems that are not case sensitive,
 	like FAT. For example, if a directory listing finds
@@ -237,7 +237,7 @@ The default is false, except linkgit:git-clone[1] o=
r linkgit:git-init[1]
 will probe and set core.ignorecase true if appropriate when the reposi=
tory
 is created.
=20
-core.precomposeunicode::
+core.precomposeUnicode::
 	This option is only used by Mac OS implementation of Git.
 	When core.precomposeunicode=3Dtrue, Git reverts the unicode decomposi=
tion
 	of filenames done by Mac OS. This is useful when sharing a repository
@@ -264,13 +264,13 @@ core.trustctime::
 	crawlers and some backup systems).
 	See linkgit:git-update-index[1]. True by default.
=20
-core.checkstat::
+core.checkStat::
 	Determines which stat fields to match between the index
 	and work tree. The user can set this to 'default' or
 	'minimal'. Default (or explicitly 'default'), is to check
 	all fields, including the sub-second part of mtime and ctime.
=20
-core.quotepath::
+core.quotePath::
 	The commands that output paths (e.g. 'ls-files',
 	'diff'), when not given the `-z` option, will quote
 	"unusual" characters in the pathname by enclosing the
@@ -476,7 +476,7 @@ core.compression::
 	If set, this provides a default to other compression variables,
 	such as 'core.loosecompression' and 'pack.compression'.
=20
-core.loosecompression::
+core.looseCompression::
 	An integer -1..9, indicating the compression level for objects that
 	are not in a pack file. -1 is the zlib default. 0 means no
 	compression, and 1..9 are various speed/size tradeoffs, 9 being
@@ -537,7 +537,7 @@ be delta compressed, but larger binary media files =
won't be.
 +
 Common unit suffixes of 'k', 'm', or 'g' are supported.
=20
-core.excludesfile::
+core.excludesFile::
 	In addition to '.gitignore' (per-directory) and
 	'.git/info/exclude', Git looks into this file for patterns
 	of files which are not meant to be tracked.  "`~/`" is expanded
@@ -546,7 +546,7 @@ core.excludesfile::
 	If $XDG_CONFIG_HOME is either not set or empty, $HOME/.config/git/ign=
ore
 	is used instead. See linkgit:gitignore[5].
=20
-core.askpass::
+core.askPass::
 	Some commands (e.g. svn and http interfaces) that interactively
 	ask for a password can be told to use an external program given
 	via the value of this variable. Can be overridden by the 'GIT_ASKPASS=
'
@@ -555,7 +555,7 @@ core.askpass::
 	prompt. The external program shall be given a suitable prompt as
 	command-line argument and write the password on its STDOUT.
=20
-core.attributesfile::
+core.attributesFile::
 	In addition to '.gitattributes' (per-directory) and
 	'.git/info/attributes', Git looks into this file for attributes
 	(see linkgit:gitattributes[5]). Path expansions are made the same
@@ -569,7 +569,7 @@ core.editor::
 	variable when it is set, and the environment variable
 	`GIT_EDITOR` is not set.  See linkgit:git-var[1].
=20
-core.commentchar::
+core.commentChar::
 	Commands such as `commit` and `tag` that lets you edit
 	messages consider a line that begins with this character
 	commented, and removes them after the editor returns
@@ -638,7 +638,7 @@ core.whitespace::
   is relevant for `indent-with-non-tab` and when Git fixes `tab-in-ind=
ent`
   errors. The default tab width is 8. Allowed values are 1 to 63.
=20
-core.fsyncobjectfiles::
+core.fsyncObjectFiles::
 	This boolean will enable 'fsync()' when writing object files.
 +
 This is a total waste of time and effort on a filesystem that orders
@@ -646,7 +646,7 @@ data writes properly, but can be useful for filesys=
tems that do not use
 journalling (traditional UNIX filesystems) or that only journal metada=
ta
 and not file contents (OS X's HFS+, or Linux ext3 with "data=3Dwriteba=
ck").
=20
-core.preloadindex::
+core.preloadIndex::
 	Enable parallel index preload for operations like 'git diff'
 +
 This can speed up operations like 'git diff' and 'git status' especial=
ly
@@ -717,7 +717,7 @@ am.keepcr::
 	by giving '--no-keep-cr' from the command line.
 	See linkgit:git-am[1], linkgit:git-mailsplit[1].
=20
-apply.ignorewhitespace::
+apply.ignoreWhitespace::
 	When set to 'change', tells 'git apply' to ignore changes in
 	whitespace, in the same way as the '--ignore-space-change'
 	option.
@@ -729,7 +729,7 @@ apply.whitespace::
 	Tells 'git apply' how to handle whitespaces, in the same way
 	as the '--whitespace' option. See linkgit:git-apply[1].
=20
-branch.autosetupmerge::
+branch.autoSetupMerge::
 	Tells 'git branch' and 'git checkout' to set up new branches
 	so that linkgit:git-pull[1] will appropriately merge from the
 	starting point branch. Note that even if this option is not set,
@@ -741,7 +741,7 @@ branch.autosetupmerge::
 	local branch or remote-tracking
 	branch. This option defaults to true.
=20
-branch.autosetuprebase::
+branch.autoSetupRebase::
 	When a new branch is created with 'git branch' or 'git checkout'
 	that tracks another branch, this variable tells Git to set
 	up pull to rebase instead of merge (see "branch.<name>.rebase").
@@ -767,7 +767,7 @@ branch.<name>.remote::
 	Additionally, `.` (a period) is the current local repository
 	(a dot-repository), see `branch.<name>.merge`'s final note below.
=20
-branch.<name>.pushremote::
+branch.<name>.pushRemote::
 	When on branch <name>, it overrides `branch.<name>.remote` for
 	pushing.  It also overrides `remote.pushdefault` for pushing
 	from branch <name>.  When you pull from one place (e.g. your
@@ -794,7 +794,7 @@ branch.<name>.merge::
 	branch.<name>.merge to the desired branch, and use the relative path
 	setting `.` (a period) for branch.<name>.remote.
=20
-branch.<name>.mergeoptions::
+branch.<name>.mergeOptions::
 	Sets default options for merging into branch <name>. The syntax and
 	supported options are the same as those of linkgit:git-merge[1], but
 	option values containing whitespace characters are currently not
@@ -938,7 +938,7 @@ color.pager::
 	A boolean to enable/disable colored output when the pager is in
 	use (default is true).
=20
-color.showbranch::
+color.showBranch::
 	A boolean to enable/disable color in the output of
 	linkgit:git-show-branch[1]. May be set to `always`,
 	`false` (or `never`) or `auto` (or `true`), in which case colors are =
used
@@ -1038,7 +1038,7 @@ commit.cleanup::
 	have to remove the help lines that begin with `#` in the commit log
 	template yourself, if you do this).
=20
-commit.gpgsign::
+commit.gpgSign::
=20
 	A boolean to specify whether all commits should be GPG signed.
 	Use of this option when doing operations such as rebase can
@@ -1151,7 +1151,7 @@ format.cc::
 	by mail.  See the --to and --cc options in
 	linkgit:git-format-patch[1].
=20
-format.subjectprefix::
+format.subjectPrefix::
 	The default for format-patch is to output files with the '[PATCH]'
 	subject prefix. Use this variable to change that prefix.
=20
@@ -1161,7 +1161,7 @@ format.signature::
 	Set this variable to the empty string ("") to suppress
 	signature generation.
=20
-format.signaturefile::
+format.signatureFile::
 	Works just like format.signature except the contents of the
 	file specified by this variable will be used as the signature.
=20
@@ -1185,7 +1185,7 @@ format.thread::
 	A true boolean value is the same as `shallow`, and a false
 	value disables threading.
=20
-format.signoff::
+format.signOff::
 	A boolean value which lets you enable the `-s/--signoff` option of
 	format-patch by default. *Note:* Adding the Signed-off-by: line to a
 	patch should be a conscious act and means that you certify you have
@@ -1224,17 +1224,17 @@ gc.auto::
 	light-weight garbage collection from time to time.  The
 	default value is 6700.  Setting this to 0 disables it.
=20
-gc.autopacklimit::
+gc.autoPackLimit::
 	When there are more than this many packs that are not
 	marked with `*.keep` file in the repository, `git gc
 	--auto` consolidates them into one larger pack.  The
 	default	value is 50.  Setting this to 0 disables it.
=20
-gc.autodetach::
+gc.autoDetach::
 	Make `git gc --auto` return immediately and run in background
 	if the system supports it. Default is true.
=20
-gc.packrefs::
+gc.packRefs::
 	Running `git pack-refs` in a repository renders it
 	unclonable by Git versions prior to 1.5.1.2 over dumb
 	transports such as HTTP.  This variable determines whether
@@ -1242,38 +1242,38 @@ gc.packrefs::
 	to enable it within all non-bare repos or it can be set to a
 	boolean value.  The default is `true`.
=20
-gc.pruneexpire::
+gc.pruneExpire::
 	When 'git gc' is run, it will call 'prune --expire 2.weeks.ago'.
 	Override the grace period with this config variable.  The value
 	"now" may be used to disable this  grace period and always prune
 	unreachable objects immediately.
=20
-gc.reflogexpire::
-gc.<pattern>.reflogexpire::
+gc.reflogExpire::
+gc.<pattern>.reflogExpire::
 	'git reflog expire' removes reflog entries older than
 	this time; defaults to 90 days.  With "<pattern>" (e.g.
 	"refs/stash") in the middle the setting applies only to
 	the refs that match the <pattern>.
=20
-gc.reflogexpireunreachable::
-gc.<ref>.reflogexpireunreachable::
+gc.reflogExpireUnreachable::
+gc.<ref>.reflogExpireUnreachable::
 	'git reflog expire' removes reflog entries older than
 	this time and are not reachable from the current tip;
 	defaults to 30 days.  With "<pattern>" (e.g. "refs/stash")
 	in the middle, the setting applies only to the refs that
 	match the <pattern>.
=20
-gc.rerereresolved::
+gc.rerereResolved::
 	Records of conflicted merge you resolved earlier are
 	kept for this many days when 'git rerere gc' is run.
 	The default is 60 days.  See linkgit:git-rerere[1].
=20
-gc.rerereunresolved::
+gc.rerereUnresolved::
 	Records of conflicted merge you have not resolved are
 	kept for this many days when 'git rerere gc' is run.
 	The default is 15 days.  See linkgit:git-rerere[1].
=20
-gitcvs.commitmsgannotation::
+gitcvs.commitMsgAnnotation::
 	Append this string to each commit message. Set to empty string
 	to disable this feature. Defaults to "via git-CVS emulator".
=20
@@ -1281,7 +1281,7 @@ gitcvs.enabled::
 	Whether the CVS server interface is enabled for this repository.
 	See linkgit:git-cvsserver[1].
=20
-gitcvs.logfile::
+gitcvs.logFile::
 	Path to a log file where the CVS server interface well... logs
 	various stuff. See linkgit:git-cvsserver[1].
=20
@@ -1296,7 +1296,7 @@ gitcvs.usecrlfattr::
 	the file type to be determined, then 'gitcvs.allbinary' is
 	used. See linkgit:gitattributes[5].
=20
-gitcvs.allbinary::
+gitcvs.allBinary::
 	This is used if 'gitcvs.usecrlfattr' does not resolve
 	the correct '-kb' mode to use. If true, all
 	unresolved files are sent to the client in
@@ -1306,7 +1306,7 @@ gitcvs.allbinary::
 	then the contents of the file are examined to decide if
 	it is binary, similar to 'core.autocrlf'.
=20
-gitcvs.dbname::
+gitcvs.dbName::
 	Database used by git-cvsserver to cache revision information
 	derived from the Git repository. The exact meaning depends on the
 	used database driver, for SQLite (which is the default driver) this
@@ -1314,7 +1314,7 @@ gitcvs.dbname::
 	linkgit:git-cvsserver[1] for details). May not contain semicolons (`;=
`).
 	Default: '%Ggitcvs.%m.sqlite'
=20
-gitcvs.dbdriver::
+gitcvs.dbDriver::
 	Used Perl DBI driver. You can specify any available driver
 	for this here, but it might not work. git-cvsserver is tested
 	with 'DBD::SQLite', reported to work with 'DBD::Pg', and
@@ -1322,7 +1322,7 @@ gitcvs.dbdriver::
 	May not contain double colons (`:`). Default: 'SQLite'.
 	See linkgit:git-cvsserver[1].
=20
-gitcvs.dbuser, gitcvs.dbpass::
+gitcvs.dbUser, gitcvs.dbPass::
 	Database user and password. Only useful if setting 'gitcvs.dbdriver',
 	since SQLite has no concept of database users and/or passwords.
 	'gitcvs.dbuser' supports variable substitution (see
@@ -1354,7 +1354,7 @@ gitweb.highlight::
 gitweb.patches::
 gitweb.pickaxe::
 gitweb.remote_heads::
-gitweb.showsizes::
+gitweb.showSizes::
 gitweb.snapshot::
 	See linkgit:gitweb.conf[5] for description.
=20
@@ -1383,15 +1383,15 @@ gpg.program::
 	signed, and the program is expected to send the result to its
 	standard output.
=20
-gui.commitmsgwidth::
+gui.commitMsgWidth::
 	Defines how wide the commit message window is in the
 	linkgit:git-gui[1]. "75" is the default.
=20
-gui.diffcontext::
+gui.diffContext::
 	Specifies how many context lines should be used in calls to diff
 	made by the linkgit:git-gui[1]. The default is "5".
=20
-gui.displayuntracked::
+gui.displayUntracked::
 	Determines if linkgit::git-gui[1] shows untracked files
 	in the file list. The default is "true".
=20
@@ -1403,16 +1403,16 @@ gui.encoding::
 	If this option is not set, the tools default to the
 	locale encoding.
=20
-gui.matchtrackingbranch::
+gui.matchTrackingBranch::
 	Determines if new branches created with linkgit:git-gui[1] should
 	default to tracking remote branches with matching names or
 	not. Default: "false".
=20
-gui.newbranchtemplate::
+gui.newBranchTemplate::
 	Is used as suggested name when creating new branches using the
 	linkgit:git-gui[1].
=20
-gui.pruneduringfetch::
+gui.pruneDuringFetch::
 	"true" if linkgit:git-gui[1] should prune remote-tracking branches wh=
en
 	performing a fetch. The default value is "false".
=20
@@ -1420,17 +1420,17 @@ gui.trustmtime::
 	Determines if linkgit:git-gui[1] should trust the file modification
 	timestamp or not. By default the timestamps are not trusted.
=20
-gui.spellingdictionary::
+gui.spellingDictionary::
 	Specifies the dictionary used for spell checking commit messages in
 	the linkgit:git-gui[1]. When set to "none" spell checking is turned
 	off.
=20
-gui.fastcopyblame::
+gui.fastCopyBlame::
 	If true, 'git gui blame' uses `-C` instead of `-C -C` for original
 	location detection. It makes blame significantly faster on huge
 	repositories at the expense of less thorough copy detection.
=20
-gui.copyblamethreshold::
+gui.copyBlameThreshold::
 	Specifies the threshold to use in 'git gui blame' original location
 	detection, measured in alphanumeric characters. See the
 	linkgit:git-blame[1] manual for more information on copy detection.
@@ -1450,22 +1450,22 @@ guitool.<name>.cmd::
 	'FILENAME', and the name of the current branch as 'CUR_BRANCH' (if
 	the head is detached, 'CUR_BRANCH' is empty).
=20
-guitool.<name>.needsfile::
+guitool.<name>.needsFile::
 	Run the tool only if a diff is selected in the GUI. It guarantees
 	that 'FILENAME' is not empty.
=20
-guitool.<name>.noconsole::
+guitool.<name>.noConsole::
 	Run the command silently, without creating a window to display its
 	output.
=20
-guitool.<name>.norescan::
+guitool.<name>.noRescan::
 	Don't rescan the working directory for changes after the tool
 	finishes execution.
=20
 guitool.<name>.confirm::
 	Show a confirmation dialog before actually running the tool.
=20
-guitool.<name>.argprompt::
+guitool.<name>.argPrompt::
 	Request a string argument from the user, and pass it to the tool
 	through the 'ARGS' environment variable. Since requesting an
 	argument implies confirmation, the 'confirm' option has no effect
@@ -1473,12 +1473,12 @@ guitool.<name>.argprompt::
 	the dialog uses a built-in generic prompt; otherwise the exact
 	value of the variable is used.
=20
-guitool.<name>.revprompt::
+guitool.<name>.revPrompt::
 	Request a single valid revision from the user, and set the
 	'REVISION' environment variable. In other aspects this option
 	is similar to 'argprompt', and can be used together with it.
=20
-guitool.<name>.revunmerged::
+guitool.<name>.revUnmerged::
 	Show only unmerged branches in the 'revprompt' subdialog.
 	This is useful for tools similar to merge or rebase, but not
 	for things like checkout or reset.
@@ -1501,7 +1501,7 @@ help.format::
 	Values 'man', 'info', 'web' and 'html' are supported. 'man' is
 	the default. 'web' and 'html' are the same.
=20
-help.autocorrect::
+help.autoCorrect::
 	Automatically correct and execute mistyped commands after
 	waiting for the given number of deciseconds (0.1 sec). If more
 	than one command can be deduced from the entered text, nothing
@@ -1510,7 +1510,7 @@ help.autocorrect::
 	value is 0 - the command will be just shown but not executed.
 	This is the default.
=20
-help.htmlpath::
+help.htmlPath::
 	Specify the path where the HTML documentation resides. File system pa=
ths
 	and URLs are supported. HTML pages will be prefixed with this path wh=
en
 	help is displayed in the 'web' format. This defaults to the documenta=
tion
@@ -1522,7 +1522,7 @@ http.proxy::
 	`curl(1)`).  This can be overridden on a per-remote basis; see
 	remote.<name>.proxy
=20
-http.cookiefile::
+http.cookieFile::
 	File containing previously stored cookie lines which should be used
 	in the Git http session, if they match the server. The file format
 	of the file to read cookies from should be plain HTTP headers or
@@ -1530,7 +1530,7 @@ http.cookiefile::
 	NOTE that the file specified with http.cookiefile is only used as
 	input unless http.saveCookies is set.
=20
-http.savecookies::
+http.saveCookies::
 	If set, store cookies received during requests to the file specified =
by
 	http.cookiefile. Has no effect if http.cookiefile is unset.
=20
@@ -1603,7 +1603,7 @@ http.noEPSV::
 	support EPSV mode. Can be overridden by the 'GIT_CURL_FTP_NO_EPSV'
 	environment variable. Default is false (curl will use EPSV).
=20
-http.useragent::
+http.userAgent::
 	The HTTP USER_AGENT string presented to an HTTP server.  The default
 	value represents the version of the client Git such as git/1.7.1.
 	This option allows you to override this value to a more common value
@@ -1676,7 +1676,7 @@ index.version::
 	Specify the version with which new index files should be
 	initialized.  This does not affect existing repositories.
=20
-init.templatedir::
+init.templateDir::
 	Specify the directory from which templates will be copied.
 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
=20
@@ -1692,7 +1692,7 @@ instaweb.local::
 	If true the web server started by linkgit:git-instaweb[1] will
 	be bound to the local IP (127.0.0.1).
=20
-instaweb.modulepath::
+instaweb.modulePath::
 	The default module path for linkgit:git-instaweb[1] to use
 	instead of /usr/lib/apache2/modules.  Only used if httpd
 	is Apache.
@@ -1701,7 +1701,7 @@ instaweb.port::
 	The port number to bind the gitweb httpd to. See
 	linkgit:git-instaweb[1].
=20
-interactive.singlekey::
+interactive.singleKey::
 	In interactive commands, allow the user to provide one-letter
 	input with a single key (i.e., without hitting enter).
 	Currently this is used by the `--patch` mode of
@@ -1729,7 +1729,7 @@ log.decorate::
 	specified, the full ref name (including prefix) will be printed.
 	This is the same as the log commands '--decorate' option.
=20
-log.showroot::
+log.showRoot::
 	If true, the initial commit will be shown as a big creation event.
 	This is equivalent to a diff against an empty tree.
 	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
@@ -1966,7 +1966,7 @@ pack.useBitmaps::
 	true. You should not generally need to turn this off unless
 	you are debugging pack bitmaps.
=20
-pack.writebitmaps (deprecated)::
+pack.writeBitmaps (deprecated)::
 	This is a deprecated synonym for `repack.writeBitmaps`.
=20
 pack.writeBitmapHashCache::
@@ -2089,10 +2089,10 @@ rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
 	rebase. False by default.
=20
-rebase.autosquash::
+rebase.autoSquash::
 	If set to true enable '--autosquash' option by default.
=20
-rebase.autostash::
+rebase.autoStash::
 	When set to true, automatically create a temporary stash
 	before the operation begins, and apply it after the operation
 	ends.  This means that you can run rebase on a dirty worktree.
@@ -2100,7 +2100,7 @@ rebase.autostash::
 	successful rebase might result in non-trivial conflicts.
 	Defaults to false.
=20
-receive.advertiseatomic::
+receive.advertiseAtomic::
 	By default, git-receive-pack will advertise the atomic push
 	capability to its clients. If you don't want to this capability
 	to be advertised, set this variable to false.
@@ -2110,13 +2110,13 @@ receive.autogc::
 	receiving data from git-push and updating refs.  You can stop
 	it by setting this variable to false.
=20
-receive.certnonceseed::
+receive.certNonceSeed::
 	By setting this variable to a string, `git receive-pack`
 	will accept a `git push --signed` and verifies it by using
 	a "nonce" protected by HMAC using this string as a secret
 	key.
=20
-receive.certnonceslop::
+receive.certNonceSlop::
 	When a `git push --signed` sent a push certificate with a
 	"nonce" that was issued by a receive-pack serving the same
 	repository within this many seconds, export the "nonce"
@@ -2180,7 +2180,7 @@ receive.denyNonFastForwards::
 	even if that push is forced. This configuration variable is
 	set when initializing a shared repository.
=20
-receive.hiderefs::
+receive.hideRefs::
 	String(s) `receive-pack` uses to decide which refs to omit
 	from its initial advertisement.  Use more than one
 	definitions to specify multiple prefix strings. A ref that
@@ -2189,15 +2189,15 @@ receive.hiderefs::
 	push`, and an attempt to update or delete a hidden ref by
 	`git push` is rejected.
=20
-receive.updateserverinfo::
+receive.updateServerInfo::
 	If set to true, git-receive-pack will run git-update-server-info
 	after receiving data from git-push and updating refs.
=20
-receive.shallowupdate::
+receive.shallowUpdate::
 	If set to true, .git/shallow can be updated when new refs
 	require new shallow roots. Otherwise those refs are rejected.
=20
-remote.pushdefault::
+remote.pushDefault::
 	The remote to push to by default.  Overrides
 	`branch.<name>.remote` for all branches, and is overridden by
 	`branch.<name>.pushremote` for specific branches.
@@ -2244,7 +2244,7 @@ remote.<name>.uploadpack::
 	The default program to execute on the remote side when fetching.  See
 	option \--upload-pack of linkgit:git-fetch-pack[1].
=20
-remote.<name>.tagopt::
+remote.<name>.tagOpt::
 	Setting this value to \--no-tags disables automatic tag following whe=
n
 	fetching from remote <name>. Setting it to \--tags will fetch every
 	tag from remote <name>, even if they are not reachable from remote
@@ -2266,7 +2266,7 @@ remotes.<group>::
 	The list of remotes which are fetched by "git remote update
 	<group>".  See linkgit:git-remote[1].
=20
-repack.usedeltabaseoffset::
+repack.useDeltaBaseOffset::
 	By default, linkgit:git-repack[1] creates packs that use
 	delta-base offset. If you need to share your repository with
 	Git older than version 1.4.4, either directly or via a dumb
@@ -2289,7 +2289,7 @@ repack.writeBitmaps::
 	space and extra time spent on the initial repack.  Defaults to
 	false.
=20
-rerere.autoupdate::
+rerere.autoUpdate::
 	When set to true, `git-rerere` updates the index with the
 	resulting contents after it cleanly resolves conflicts using
 	previously recorded resolution.  Defaults to false.
@@ -2308,7 +2308,7 @@ sendemail.identity::
 	values in the 'sendemail' section. The default identity is
 	the value of 'sendemail.identity'.
=20
-sendemail.smtpencryption::
+sendemail.smtpEncryption::
 	See linkgit:git-send-email[1] for description.  Note that this
 	setting is not subject to the 'identity' mechanism.
=20
@@ -2325,29 +2325,29 @@ sendemail.<identity>.*::
 	identity is selected, through command-line or
 	'sendemail.identity'.
=20
-sendemail.aliasesfile::
-sendemail.aliasfiletype::
+sendemail.aliasesFile::
+sendemail.aliasFileType::
 sendemail.annotate::
 sendemail.bcc::
 sendemail.cc::
-sendemail.cccmd::
-sendemail.chainreplyto::
+sendemail.ccCmd::
+sendemail.chainReplyTo::
 sendemail.confirm::
-sendemail.envelopesender::
+sendemail.envelopeSender::
 sendemail.from::
-sendemail.multiedit::
+sendemail.multiEdit::
 sendemail.signedoffbycc::
-sendemail.smtppass::
+sendemail.smtpPass::
 sendemail.suppresscc::
-sendemail.suppressfrom::
+sendemail.suppressFrom::
 sendemail.to::
-sendemail.smtpdomain::
-sendemail.smtpserver::
-sendemail.smtpserverport::
-sendemail.smtpserveroption::
-sendemail.smtpuser::
+sendemail.smtpDomain::
+sendemail.smtpServer::
+sendemail.smtpServerPort::
+sendemail.smtpServerOption::
+sendemail.smtpUser::
 sendemail.thread::
-sendemail.transferencoding::
+sendemail.transferEncoding::
 sendemail.validate::
 sendemail.xmailer::
 	See linkgit:git-send-email[1] for description.
@@ -2399,7 +2399,7 @@ If this variable is not specified, it defaults to=
 'normal'.
 This variable can be overridden with the -u|--untracked-files option
 of linkgit:git-status[1] and linkgit:git-commit[1].
=20
-status.submodulesummary::
+status.submoduleSummary::
 	Defaults to false.
 	If this is set to a non zero number or true (identical to -1 or an
 	unlimited number), the submodule summary will be enabled and a
@@ -2474,7 +2474,7 @@ transfer.fsckObjects::
 	not set, the value of this variable is used instead.
 	Defaults to false.
=20
-transfer.hiderefs::
+transfer.hideRefs::
 	This variable can be used to set both `receive.hiderefs`
 	and `uploadpack.hiderefs` at the same time to the same
 	values.  See entries for these other variables.
@@ -2491,7 +2491,7 @@ uploadarchive.allowUnreachable::
 	linkgit:git-upload-archive[1] for more details. Defaults to
 	`false`.
=20
-uploadpack.hiderefs::
+uploadpack.hideRefs::
 	String(s) `upload-pack` uses to decide which refs to omit
 	from its initial advertisement.  Use more than one
 	definitions to specify multiple prefix strings. A ref that
@@ -2506,7 +2506,7 @@ uploadpack.allowtipsha1inwant::
 	of a hidden ref (by default, such a request is rejected).
 	see also `uploadpack.hiderefs`.
=20
-uploadpack.keepalive::
+uploadpack.keepAlive::
 	When `upload-pack` has started `pack-objects`, there may be a
 	quiet period while `pack-objects` prepares the pack. Normally
 	it would output progress information, but if `--quiet` was used
@@ -2551,7 +2551,7 @@ user.name::
 	Can be overridden by the 'GIT_AUTHOR_NAME' and 'GIT_COMMITTER_NAME'
 	environment variables.  See linkgit:git-commit-tree[1].
=20
-user.signingkey::
+user.signingKey::
 	If linkgit:git-tag[1] or linkgit:git-commit[1] is not selecting the
 	key you want it to automatically when creating a signed tag or
 	commit, you can override the default selection with this variable.
diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.=
txt
index b001779..779f127 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -1,4 +1,4 @@
-diff.autorefreshindex::
+diff.autoRefreshIndex::
 	When using 'git diff' to compare with work tree
 	files, do not consider stat-only change as changed.
 	Instead, silently run `git update-index --refresh` to
@@ -79,7 +79,7 @@ diff.ignoreSubmodules::
 	overridden by using the --ignore-submodules command-line option.
 	The 'git submodule' commands are not affected by this setting.
=20
-diff.mnemonicprefix::
+diff.mnemonicPrefix::
 	If set, 'git diff' uses a prefix pair that is different from the
 	standard "a/" and "b/" depending on what is being compared.  When
 	this configuration is in effect, reverse diff output also swaps
@@ -98,7 +98,7 @@ diff.mnemonicprefix::
 diff.noprefix::
 	If set, 'git diff' does not show any source or destination prefix.
=20
-diff.orderfile::
+diff.orderFile::
 	File indicating how to order files within a diff, using
 	one shell glob pattern per line.
 	Can be overridden by the '-O' option to linkgit:git-diff[1].
@@ -148,7 +148,7 @@ diff.<driver>.textconv::
 	conversion is used to generate a human-readable diff.  See
 	linkgit:gitattributes[5] for details.
=20
-diff.<driver>.wordregex::
+diff.<driver>.wordRegex::
 	The regular expression that the diff driver should use to
 	split words in a line.  See linkgit:gitattributes[5] for
 	details.
diff --git a/Documentation/merge-config.txt b/Documentation/merge-confi=
g.txt
index d78d6d8..8a0e52f 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -1,4 +1,4 @@
-merge.conflictstyle::
+merge.conflictStyle::
 	Specify the style in which conflicted hunks are written out to
 	working tree files upon merge.  The default is "merge", which
 	shows a `<<<<<<<` conflict marker, changes made by one side,
--=20
2.3.0.rc1.137.g477eb31
