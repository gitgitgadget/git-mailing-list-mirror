From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH v3 3/6] Change 'git' to 'Git' whenever the whole system is
 referred to #2
Date: Mon, 21 Jan 2013 20:19:40 +0100 (CET)
Message-ID: <2009548606.632825.1358795980319.JavaMail.ngmail@webmail20.arcor-online.net>
References: <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net> <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net> <7vvcark1f2.fsf@alter.siamese.dyndns.org> <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: davvid@gmail.com, git@vger.kernel.org
To: gitster@pobox.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Mon Jan 21 20:20:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxMuf-0005Df-3W
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 20:20:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644Ab3AUTTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 14:19:44 -0500
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:34082 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752766Ab3AUTTn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2013 14:19:43 -0500
Received: from mail-in-14-z2.arcor-online.net (mail-in-14-z2.arcor-online.net [151.189.8.31])
	by mx.arcor.de (Postfix) with ESMTP id 661CC2124FC;
	Mon, 21 Jan 2013 20:19:40 +0100 (CET)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-14-z2.arcor-online.net (Postfix) with ESMTP id 5EF3320800F;
	Mon, 21 Jan 2013 20:19:40 +0100 (CET)
Received: from webmail20.arcor-online.net (webmail20.arcor-online.net [151.189.8.201])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 545EBE3DEA;
	Mon, 21 Jan 2013 20:19:40 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-05.arcor-online.net 545EBE3DEA
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1358795980; bh=Anv5TUwia+ofnHD9JAGoZ9dQxq1BJiUZA4cHZdLrOLY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=Yp0JY8KVzyu5Tfk6ll3dzS+QAZRAsjCg1ML9b9bBroRjJIPqeIk8zsHDwRVBdstrR
	 0g8VBYuEs7JTqCoN2yiMDUSuCOqzawwVkiyp+85gfkrClGzWLHHyDuI51MSvXsRc95
	 EORnpai3vKceoUgSbjyPGXfoDboW4Zi9HJCOqXyA=
Received: from [188.105.98.86] by webmail20.arcor-online.net (151.189.8.201) with HTTP (Arcor Webmail); Mon, 21 Jan 2013 20:19:40 +0100 (CET)
In-Reply-To: <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.98.86
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214148>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b87f744..5a831ad2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1,14 +1,14 @@
 CONFIGURATION FILE
 ------------------
 
-The git configuration file contains a number of variables that affect
+The Git configuration file contains a number of variables that affect
 the git command's behavior. The `.git/config` file in each repository
 is used to store the configuration for that repository, and
 `$HOME/.gitconfig` is used to store a per-user configuration as
 fallback values for the `.git/config` file. The file `/etc/gitconfig`
 can be used to store a system-wide default configuration.
 
-The configuration variables are used by both the git plumbing
+The configuration variables are used by both the Git plumbing
 and the porcelains. The variables are divided into sections, wherein
 the fully qualified variable name of the variable itself is the last
 dot-separated segment and the section name is everything before the last
@@ -209,9 +209,9 @@ core.ignoreCygwinFSTricks::
 
 core.ignorecase::
 	If true, this option enables various workarounds to enable
-	git to work better on filesystems that are not case sensitive,
+	Git to work better on filesystems that are not case sensitive,
 	like FAT. For example, if a directory listing finds
-	"makefile" when git expects "Makefile", git will assume
+	"makefile" when Git expects "Makefile", Git will assume
 	it is really the same file, and continue to remember it as
 	"Makefile".
 +
@@ -220,13 +220,13 @@ will probe and set core.ignorecase true if appropriate when the repository
 is created.
 
 core.precomposeunicode::
-	This option is only used by Mac OS implementation of git.
-	When core.precomposeunicode=true, git reverts the unicode decomposition
+	This option is only used by Mac OS implementation of Git.
+	When core.precomposeunicode=true, Git reverts the unicode decomposition
 	of filenames done by Mac OS. This is useful when sharing a repository
 	between Mac OS and Linux or Windows.
-	(Git for Windows 1.7.10 or higher is needed, or git under cygwin 1.7).
-	When false, file names are handled fully transparent by git,
-	which is backward compatible with older versions of git.
+	(Git for Windows 1.7.10 or higher is needed, or Git under cygwin 1.7).
+	When false, file names are handled fully transparent by Git,
+	which is backward compatible with older versions of Git.
 
 core.trustctime::
 	If false, the ctime differences between the index and the
@@ -256,20 +256,20 @@ core.eol::
 	conversion.
 
 core.safecrlf::
-	If true, makes git check if converting `CRLF` is reversible when
+	If true, makes Git check if converting `CRLF` is reversible when
 	end-of-line conversion is active.  Git will verify if a command
 	modifies a file in the work tree either directly or indirectly.
 	For example, committing a file followed by checking out the
 	same file should yield the original file in the work tree.  If
 	this is not the case for the current setting of
-	`core.autocrlf`, git will reject the file.  The variable can
-	be set to "warn", in which case git will only warn about an
+	`core.autocrlf`, Git will reject the file.  The variable can
+	be set to "warn", in which case Git will only warn about an
 	irreversible conversion but continue the operation.
 +
 CRLF conversion bears a slight chance of corrupting data.
-When it is enabled, git will convert CRLF to LF during commit and LF to
+When it is enabled, Git will convert CRLF to LF during commit and LF to
 CRLF during checkout.  A file that contains a mixture of LF and
-CRLF before the commit cannot be recreated by git.  For text
+CRLF before the commit cannot be recreated by Git.  For text
 files this is the right thing to do: it corrects line endings
 such that we have only LF line endings in the repository.
 But for binary files that are accidentally classified as text the
@@ -279,7 +279,7 @@ If you recognize such corruption early you can easily fix it by
 setting the conversion type explicitly in .gitattributes.  Right
 after committing you still have the original file in your work
 tree and this file is not yet corrupted.  You can explicitly tell
-git that this file is binary and git will handle the file
+Git that this file is binary and Git will handle the file
 appropriately.
 +
 Unfortunately, the desired effect of cleaning up text files with
@@ -324,7 +324,7 @@ is created.
 core.gitProxy::
 	A "proxy command" to execute (as 'command host port') instead
 	of establishing direct connection to the remote server when
-	using the git protocol for fetching. If the variable value is
+	using the Git protocol for fetching. If the variable value is
 	in the "COMMAND for DOMAIN" format, the command is applied only
 	on hostnames ending with the specified domain string. This variable
 	may be set multiple times and is matched in the given order;
@@ -383,7 +383,7 @@ Note that this variable is honored even when set in a configuration
 file in a ".git" subdirectory of a directory and its value differs
 from the latter directory (e.g. "/path/to/.git/config" has
 core.worktree set to "/different/path"), which is most likely a
-misconfiguration.  Running git commands in the "/path/to" directory will
+misconfiguration.  Running Git commands in the "/path/to" directory will
 still use "/different/path" as the root of the work tree and can cause
 confusion unless you know what you are doing (e.g. you are creating a
 read-only snapshot of the same index to a location different from the
@@ -415,7 +415,7 @@ core.sharedRepository::
 	several users in a group (making sure all the files and objects are
 	group-writable). When 'all' (or 'world' or 'everybody'), the
 	repository will be readable by all users, additionally to being
-	group-shareable. When 'umask' (or 'false'), git will use permissions
+	group-shareable. When 'umask' (or 'false'), Git will use permissions
 	reported by umask(2). When '0xxx', where '0xxx' is an octal number,
 	files in the repository will have this mode value. '0xxx' will override
 	user's umask value (whereas the other options will only override
@@ -426,7 +426,7 @@ core.sharedRepository::
 	See linkgit:git-init[1]. False by default.
 
 core.warnAmbiguousRefs::
-	If true, git will warn you if the ref name you passed it is ambiguous
+	If true, Git will warn you if the ref name you passed it is ambiguous
 	and might match multiple refs in the .git/refs/ tree. True by default.
 
 core.compression::
@@ -498,7 +498,7 @@ Common unit suffixes of 'k', 'm', or 'g' are supported.
 
 core.excludesfile::
 	In addition to '.gitignore' (per-directory) and
-	'.git/info/exclude', git looks into this file for patterns
+	'.git/info/exclude', Git looks into this file for patterns
 	of files which are not meant to be tracked.  "`~/`" is expanded
 	to the value of `$HOME` and "`~user/`" to the specified user's
 	home directory. Its default value is $XDG_CONFIG_HOME/git/ignore.
@@ -516,7 +516,7 @@ core.askpass::
 
 core.attributesfile::
 	In addition to '.gitattributes' (per-directory) and
-	'.git/info/attributes', git looks into this file for attributes
+	'.git/info/attributes', Git looks into this file for attributes
 	(see linkgit:gitattributes[5]). Path expansions are made the same
 	way as for `core.excludesfile`. Its default value is
 	$XDG_CONFIG_HOME/git/attributes. If $XDG_CONFIG_HOME is either not
@@ -535,9 +535,9 @@ sequence.editor::
 	When not configured the default commit message editor is used instead.
 
 core.pager::
-	The command that git will use to paginate output.  Can
+	The command that Git will use to paginate output.  Can
 	be overridden with the `GIT_PAGER` environment
-	variable.  Note that git sets the `LESS` environment
+	variable.  Note that Git sets the `LESS` environment
 	variable to `FRSX` if it is unset when it runs the
 	pager.  One can change these settings by setting the
 	`LESS` variable to some other value.  Alternately,
@@ -545,11 +545,11 @@ core.pager::
 	global basis by setting the `core.pager` option.
 	Setting `core.pager` has no effect on the `LESS`
 	environment variable behaviour above, so if you want
-	to override git's default settings this way, you need
+	to override Git's default settings this way, you need
 	to be explicit.  For example, to disable the S option
 	in a backward compatible manner, set `core.pager`
 	to `less -+S`.  This will be passed to the shell by
-	git, which will translate the final command to
+	Git, which will translate the final command to
 	`LESS=FRSX less -+S`.
 
 core.whitespace::
@@ -578,7 +578,7 @@ core.whitespace::
   does not trigger if the character before such a carriage-return
   is not a whitespace (not enabled by default).
 * `tabwidth=<n>` tells how many character positions a tab occupies; this
-  is relevant for `indent-with-non-tab` and when git fixes `tab-in-indent`
+  is relevant for `indent-with-non-tab` and when Git fixes `tab-in-indent`
   errors. The default tab width is 8. Allowed values are 1 to 63.
 
 core.fsyncobjectfiles::
@@ -594,7 +594,7 @@ core.preloadindex::
 +
 This can speed up operations like 'git diff' and 'git status' especially
 on filesystems like NFS that have weak caching semantics and thus
-relatively high IO latencies.  With this set to 'true', git will do the
+relatively high IO latencies.  With this set to 'true', Git will do the
 index comparison to the filesystem data in parallel, allowing
 overlapping IO's.
 
@@ -630,9 +630,9 @@ add.ignore-errors::
 add.ignoreErrors::
 	Tells 'git add' to continue adding files when some files cannot be
 	added due to indexing errors. Equivalent to the '--ignore-errors'
-	option of linkgit:git-add[1].  Older versions of git accept only
+	option of linkgit:git-add[1].  Older versions of Git accept only
 	`add.ignore-errors`, which does not follow the usual naming
-	convention for configuration variables.  Newer versions of git
+	convention for configuration variables.  Newer versions of Git
 	honor `add.ignoreErrors` as well.
 
 alias.*::
@@ -640,7 +640,7 @@ alias.*::
 	after defining "alias.last = cat-file commit HEAD", the invocation
 	"git last" is equivalent to "git cat-file commit HEAD". To avoid
 	confusion and troubles with script usage, aliases that
-	hide existing git commands are ignored. Arguments are split by
+	hide existing Git commands are ignored. Arguments are split by
 	spaces, the usual shell quoting and escaping is supported.
 	quote pair and a backslash can be used to quote them.
 +
@@ -687,7 +687,7 @@ branch.autosetupmerge::
 
 branch.autosetuprebase::
 	When a new branch is created with 'git branch' or 'git checkout'
-	that tracks another branch, this variable tells git to set
+	that tracks another branch, this variable tells Git to set
 	up pull to rebase instead of merge (see "branch.<name>.rebase").
 	When `never`, rebase is never automatically set to true.
 	When `local`, rebase is set to true for tracked branches of
@@ -868,7 +868,7 @@ color.status.<slot>::
 	one of `header` (the header text of the status message),
 	`added` or `updated` (files which are added but not committed),
 	`changed` (files which are changed but not added in the index),
-	`untracked` (files which are not tracked by git),
+	`untracked` (files which are not tracked by Git),
 	`branch` (the current branch), or
 	`nobranch` (the color the 'no branch' warning is shown in, defaulting
 	to red). The values of these variables may be specified as in
@@ -882,7 +882,7 @@ color.ui::
 	to `always` if you want all output not intended for machine
 	consumption to use color, to `true` or `auto` if you want such
 	output to use color when written to the terminal, or to `false` or
-	`never` if you prefer git commands not to use color unless enabled
+	`never` if you prefer Git commands not to use color unless enabled
 	explicitly with some other configuration or the `--color` option.
 
 column.ui::
@@ -1039,7 +1039,7 @@ format.subjectprefix::
 
 format.signature::
 	The default for format-patch is to output a signature containing
-	the git version number. Use this variable to change that default.
+	the Git version number. Use this variable to change that default.
 	Set this variable to the empty string ("") to suppress
 	signature generation.
 
@@ -1152,7 +1152,7 @@ gitcvs.logfile::
 gitcvs.usecrlfattr::
 	If true, the server will look up the end-of-line conversion
 	attributes for files to determine the '-k' modes to use. If
-	the attributes force git to treat a file as text,
+	the attributes force Git to treat a file as text,
 	the '-k' mode will be left blank so CVS clients will
 	treat it as text. If they suppress text conversion, the file
 	will be set with '-kb' mode, which suppresses any newline munging
@@ -1172,7 +1172,7 @@ gitcvs.allbinary::
 
 gitcvs.dbname::
 	Database used by git-cvsserver to cache revision information
-	derived from the git repository. The exact meaning depends on the
+	derived from the Git repository. The exact meaning depends on the
 	used database driver, for SQLite (which is the default driver) this
 	is a filename. Supports variable substitution (see
 	linkgit:git-cvsserver[1] for details). May not contain semicolons (`;`).
@@ -1384,7 +1384,7 @@ http.proxy::
 
 http.cookiefile::
 	File containing previously stored cookie lines which should be used
-	in the git http session, if they match the server. The file format
+	in the Git http session, if they match the server. The file format
 	of the file to read cookies from should be plain HTTP headers or
 	the Netscape/Mozilla cookie file format (see linkgit:curl[1]).
 	NOTE that the file specified with http.cookiefile is only used as
@@ -1406,7 +1406,7 @@ http.sslKey::
 	variable.
 
 http.sslCertPasswordProtected::
-	Enable git's password prompt for the SSL certificate.  Otherwise
+	Enable Git's password prompt for the SSL certificate.  Otherwise
 	OpenSSL will prompt the user, possibly many times, if the
 	certificate or private key is encrypted.  Can be overridden by the
 	'GIT_SSL_CERT_PASSWORD_PROTECTED' environment variable.
@@ -1453,7 +1453,7 @@ http.noEPSV::
 
 http.useragent::
 	The HTTP USER_AGENT string presented to an HTTP server.  The default
-	value represents the version of the client git such as git/1.7.1.
+	value represents the version of the client Git such as git/1.7.1.
 	This option allows you to override this value to a more common value
 	such as Mozilla/4.0.  This may be necessary, for instance, if
 	connecting through a firewall that restricts HTTP connections to a set
@@ -1461,7 +1461,7 @@ http.useragent::
 	Can be overridden by the 'GIT_HTTP_USER_AGENT' environment variable.
 
 i18n.commitEncoding::
-	Character encoding the commit messages are stored in; git itself
+	Character encoding the commit messages are stored in; Git itself
 	does not care per se, but this information is necessary e.g. when
 	importing commits from emails or in the gitk graphical history
 	browser (and possibly at other places in the future or in other
@@ -1599,7 +1599,7 @@ mergetool.keepBackup::
 	`true` (i.e. keep the backup files).
 
 mergetool.keepTemporaries::
-	When invoking a custom merge tool, git uses a set of temporary
+	When invoking a custom merge tool, Git uses a set of temporary
 	files to pass to the tool. If the tool returns an error and this
 	variable is set to `true`, then these temporary files will be
 	preserved, otherwise they will be removed after the tool has
@@ -1627,7 +1627,7 @@ displayed.
 
 notes.rewrite.<command>::
 	When rewriting commits with <command> (currently `amend` or
-	`rebase`) and this variable is set to `true`, git
+	`rebase`) and this variable is set to `true`, Git
 	automatically copies your notes from the original to the
 	rewritten commit.  Defaults to `true`, but see
 	"notes.rewriteRef" below.
@@ -1707,7 +1707,7 @@ pack.threads::
 	warning. This is meant to reduce packing time on multiprocessor
 	machines. The required amount of memory for the delta search window
 	is however multiplied by the number of threads.
-	Specifying 0 will cause git to auto-detect the number of CPU's
+	Specifying 0 will cause Git to auto-detect the number of CPU's
 	and set the number of threads accordingly.
 
 pack.indexVersion::
@@ -1719,11 +1719,11 @@ pack.indexVersion::
 	and this config option ignored whenever the corresponding pack is
 	larger than 2 GB.
 +
-If you have an old git that does not understand the version 2 `*.idx` file,
+If you have an old Git that does not understand the version 2 `*.idx` file,
 cloning or fetching over a non native protocol (e.g. "http" and "rsync")
 that will copy both `*.pack` file and corresponding `*.idx` file from the
 other side may give you a repository that cannot be accessed with your
-older version of git. If the `*.pack` file is smaller than 2 GB, however,
+older version of Git. If the `*.pack` file is smaller than 2 GB, however,
 you can use linkgit:git-index-pack[1] on the *.pack file to regenerate
 the `*.idx` file.
 
@@ -1738,7 +1738,7 @@ pack.packSizeLimit::
 
 pager.<cmd>::
 	If the value is boolean, turns on or off pagination of the
-	output of a particular git subcommand when writing to a tty.
+	output of a particular Git subcommand when writing to a tty.
 	Otherwise, turns on pagination for the subcommand using the
 	pager specified by the value of `pager.<cmd>`.  If `--paginate`
 	or `--no-pager` is specified on the command line, it takes
@@ -1773,7 +1773,7 @@ pull.twohead::
 	The default merge strategy to use when pulling a single branch.
 
 push.default::
-	Defines the action git push should take if no refspec is given
+	Defines the action Git push should take if no refspec is given
 	on the command line, no refspec is configured in the remote, and
 	no refspec is implied by any of the options given on the command
 	line. Possible values are:
@@ -1913,7 +1913,7 @@ remote.<name>.tagopt::
 	linkgit:git-fetch[1].
 
 remote.<name>.vcs::
-	Setting this to a value <vcs> will cause git to interact with
+	Setting this to a value <vcs> will cause Git to interact with
 	the remote with the git-remote-<vcs> helper.
 
 remotes.<group>::
@@ -1923,9 +1923,9 @@ remotes.<group>::
 repack.usedeltabaseoffset::
 	By default, linkgit:git-repack[1] creates packs that use
 	delta-base offset. If you need to share your repository with
-	git older than version 1.4.4, either directly or via a dumb
+	Git older than version 1.4.4, either directly or via a dumb
 	protocol such as http, then you need to set this option to
-	"false" and repack. Access from old git versions over the
+	"false" and repack. Access from old Git versions over the
 	native protocol are unaffected by this option.
 
 rerere.autoupdate::
@@ -1994,7 +1994,7 @@ showbranch.default::
 status.relativePaths::
 	By default, linkgit:git-status[1] shows paths relative to the
 	current directory. Setting this variable to `false` shows paths
-	relative to the repository root (this was the default for git
+	relative to the repository root (this was the default for Git
 	prior to v1.5.4).
 
 status.showUntrackedFiles::
@@ -2081,7 +2081,7 @@ url.<base>.insteadOf::
 	large number of repositories, and serves them with multiple
 	access methods, and some users need to use different access
 	methods, this feature allows people to specify any of the
-	equivalent URLs and have git automatically rewrite the URL to
+	equivalent URLs and have Git automatically rewrite the URL to
 	the best alternative for the particular user, even for a
 	never-before-seen repository on the site.  When more than one
 	insteadOf strings match a given URL, the longest match is used.
@@ -2092,11 +2092,11 @@ url.<base>.pushInsteadOf::
 	resulting URL will be pushed to. In cases where some site serves
 	a large number of repositories, and serves them with multiple
 	access methods, some of which do not allow push, this feature
-	allows people to specify a pull-only URL and have git
+	allows people to specify a pull-only URL and have Git
 	automatically use an appropriate URL to push, even for a
 	never-before-seen repository on the site.  When more than one
 	pushInsteadOf strings match a given URL, the longest match is
-	used.  If a remote has an explicit pushurl, git will ignore this
+	used.  If a remote has an explicit pushurl, Git will ignore this
 	setting for that remote.
 
 user.email::
diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 69f7e9b..5e60daf 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -1,5 +1,5 @@
 Like other projects, we also have some guidelines to keep to the
-code.  For git in general, three rough rules are:
+code.  For Git in general, three rough rules are:
 
  - Most importantly, we never say "It's in POSIX; we'll happily
    ignore your needs should your system not conform to it."
@@ -22,7 +22,7 @@ code.  For git in general, three rough rules are:
 As for more concrete guidelines, just imitate the existing code
 (this is a good guideline, no matter which project you are
 contributing to). It is always preferable to match the _local_
-convention. New code added to git suite is expected to match
+convention. New code added to Git suite is expected to match
 the overall style of existing code. Modifications to existing
 code is expected to match the style the surrounding code already
 uses (even if it doesn't match the overall style of existing code).
@@ -112,7 +112,7 @@ For C programs:
 
  - We try to keep to at most 80 characters per line.
 
- - We try to support a wide range of C compilers to compile git with,
+ - We try to support a wide range of C compilers to compile Git with,
    including old ones. That means that you should not use C99
    initializers, even if a lot of compilers grok it.
 
@@ -164,14 +164,14 @@ For C programs:
 
  - If you are planning a new command, consider writing it in shell
    or perl first, so that changes in semantics can be easily
-   changed and discussed.  Many git commands started out like
+   changed and discussed.  Many Git commands started out like
    that, and a few are still scripts.
 
- - Avoid introducing a new dependency into git. This means you
+ - Avoid introducing a new dependency into Git. This means you
    usually should stay away from scripting languages not already
-   used in the git core command set (unless your command is clearly
+   used in the Git core command set (unless your command is clearly
    separate from it, such as an importer to convert random-scm-X
-   repositories to git).
+   repositories to Git).
 
  - When we pass <string, length> pair to functions, we should try to
    pass them in that order.
diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 6d696e0..e18c3b0 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -14,17 +14,17 @@ DESCRIPTION
 -----------
 
 Remote helper programs are normally not used directly by end users,
-but they are invoked by git when it needs to interact with remote
-repositories git does not support natively.  A given helper will
-implement a subset of the capabilities documented here. When git
+but they are invoked by Git when it needs to interact with remote
+repositories Git does not support natively.  A given helper will
+implement a subset of the capabilities documented here. When Git
 needs to interact with a repository using a remote helper, it spawns
 the helper as an independent process, sends commands to the helper's
 standard input, and expects results from the helper's standard
 output. Because a remote helper runs as an independent process from
-git, there is no need to re-link git to add a new helper, nor any
-need to link the helper with the implementation of git.
+Git, there is no need to re-link Git to add a new helper, nor any
+need to link the helper with the implementation of Git.
 
-Every helper must support the "capabilities" command, which git
+Every helper must support the "capabilities" command, which Git
 uses to determine what other commands the helper will accept.  Those
 other commands can be used to discover and update remote refs,
 transport objects between the object database and the remote repository,
@@ -45,9 +45,9 @@ argument specifies a URL; it is usually of the form
 '<transport>://<address>', but any arbitrary string is possible.
 The 'GIT_DIR' environment variable is set up for the remote helper
 and can be used to determine where to store additional data or from
-which directory to invoke auxiliary git commands.
+which directory to invoke auxiliary Git commands.
 
-When git encounters a URL of the form '<transport>://<address>', where
+When Git encounters a URL of the form '<transport>://<address>', where
 '<transport>' is a protocol that it cannot handle natively, it
 automatically invokes 'git remote-<transport>' with the full URL as
 the second argument. If such a URL is encountered directly on the
@@ -55,14 +55,14 @@ command line, the first argument is the same as the second, and if it
 is encountered in a configured remote, the first argument is the name
 of that remote.
 
-A URL of the form '<transport>::<address>' explicitly instructs git to
+A URL of the form '<transport>::<address>' explicitly instructs Git to
 invoke 'git remote-<transport>' with '<address>' as the second
 argument. If such a URL is encountered directly on the command line,
 the first argument is '<address>', and if it is encountered in a
 configured remote, the first argument is the name of that remote.
 
 Additionally, when a configured remote has 'remote.<name>.vcs' set to
-'<transport>', git explicitly invokes 'git remote-<transport>' with
+'<transport>', Git explicitly invokes 'git remote-<transport>' with
 '<name>' as the first argument. If set, the second argument is
 'remote.<name>.url'; otherwise, the second argument is omitted.
 
@@ -85,7 +85,7 @@ Capabilities
 ~~~~~~~~~~~~
 
 Each remote helper is expected to support only a subset of commands.
-The operations a helper supports are declared to git in the response
+The operations a helper supports are declared to Git in the response
 to the `capabilities` command (see COMMANDS, below).
 
 In the following, we list all defined capabilities and for
@@ -114,10 +114,10 @@ Supported commands: 'list for-push', 'push'.
 +
 Supported commands: 'list for-push', 'export'.
 
-If a helper advertises 'connect', git will use it if possible and
+If a helper advertises 'connect', Git will use it if possible and
 fall back to another capability if the helper requests so when
 connecting (see the 'connect' command under COMMANDS).
-When choosing between 'push' and 'export', git prefers 'push'.
+When choosing between 'push' and 'export', Git prefers 'push'.
 Other frontends may have some other order of preference.
 
 
@@ -126,7 +126,7 @@ Capabilities for Fetching
 'connect'::
 	Can try to connect to 'git upload-pack' (for fetching),
 	'git receive-pack', etc for communication using the
-	git's native packfile protocol. This
+	Git's native packfile protocol. This
 	requires a bidirectional, full-duplex connection.
 +
 Supported commands: 'connect'.
@@ -143,10 +143,10 @@ Supported commands: 'list', 'fetch'.
 +
 Supported commands: 'list', 'import'.
 
-If a helper advertises 'connect', git will use it if possible and
+If a helper advertises 'connect', Git will use it if possible and
 fall back to another capability if the helper requests so when
 connecting (see the 'connect' command under COMMANDS).
-When choosing between 'fetch' and 'import', git prefers 'fetch'.
+When choosing between 'fetch' and 'import', Git prefers 'fetch'.
 Other frontends may have some other order of preference.
 
 Miscellaneous capabilities
@@ -183,22 +183,22 @@ there is an implied `refspec *:*`.
 	to retrieve information about blobs and trees that already exist in
 	fast-import's memory. This requires a channel from fast-import to the
 	remote-helper.
-	If it is advertised in addition to "import", git establishes a pipe from
+	If it is advertised in addition to "import", Git establishes a pipe from
 	fast-import to the remote-helper's stdin.
-	It follows that git and fast-import are both connected to the
-	remote-helper's stdin. Because git can send multiple commands to
+	It follows that Git and fast-import are both connected to the
+	remote-helper's stdin. Because Git can send multiple commands to
 	the remote-helper it is required that helpers that use 'bidi-import'
 	buffer all 'import' commands of a batch before sending data to fast-import.
 	This is to prevent mixing commands and fast-import responses on the
 	helper's stdin.
 
 'export-marks' <file>::
-	This modifies the 'export' capability, instructing git to dump the
+	This modifies the 'export' capability, instructing Git to dump the
 	internal marks table to <file> when complete. For details,
 	read up on '--export-marks=<file>' in linkgit:git-fast-export[1].
 
 'import-marks' <file>::
-	This modifies the 'export' capability, instructing git to load the
+	This modifies the 'export' capability, instructing Git to load the
 	marks specified in <file> before processing any input. For details,
 	read up on '--import-marks=<file>' in linkgit:git-fast-export[1].
 
@@ -213,7 +213,7 @@ Commands are given by the caller on the helper's standard input, one per line.
 'capabilities'::
 	Lists the capabilities of the helper, one per line, ending
 	with a blank line. Each capability may be preceded with '*',
-	which marks them mandatory for git versions using the remote
+	which marks them mandatory for Git versions using the remote
 	helper to understand. Any unknown mandatory capability is a
 	fatal error.
 +
@@ -376,7 +376,7 @@ OPTIONS
 -------
 
 The following options are defined and (under suitable circumstances)
-set by git if the remote helper has the 'option' capability.
+set by Git if the remote helper has the 'option' capability.
 
 'option verbosity' <n>::
 	Changes the verbosity of messages displayed by the helper.
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index bd3eaa6..dc3a568 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -3,7 +3,7 @@ git-send-pack(1)
 
 NAME
 ----
-git-send-pack - Push objects over git protocol to another repository
+git-send-pack - Push objects over Git protocol to another repository
 
 
 SYNOPSIS
diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
index 5e5f1c8..6a9f66d 100644
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -3,7 +3,7 @@ git-sh-setup(1)
 
 NAME
 ----
-git-sh-setup - Common git shell script setup code
+git-sh-setup - Common Git shell script setup code
 
 SYNOPSIS
 --------
@@ -19,7 +19,7 @@ Porcelain-ish scripts and/or are writing new ones.
 
 The 'git sh-setup' scriptlet is designed to be sourced (using
 `.`) by other shell scripts to set up some variables pointing at
-the normal git directories and a few helper shell functions.
+the normal Git directories and a few helper shell functions.
 
 Before sourcing it, your script should set up a few variables;
 `USAGE` (and `LONG_USAGE`, if any) is used to define message
diff --git a/Documentation/git-show-index.txt b/Documentation/git-show-index.txt
index 2dcbbb2..9cbbed9 100644
--- a/Documentation/git-show-index.txt
+++ b/Documentation/git-show-index.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Reads given idx file for packed git archive created with
+Reads given idx file for packed Git archive created with
 'git pack-objects' command, and dumps its contents.
 
 The information it outputs is subset of what you can get from
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 9f1ef9a..0412c40 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -16,7 +16,7 @@ DESCRIPTION
 Displays paths that have differences between the index file and the
 current HEAD commit, paths that have differences between the working
 tree and the index file, and paths in the working tree that are not
-tracked by git (and are not ignored by linkgit:gitignore[5]). The first
+tracked by Git (and are not ignored by linkgit:gitignore[5]). The first
 are what you _would_ commit by running `git commit`; the second and
 third are what you _could_ commit by running 'git add' before running
 `git commit`.
@@ -35,7 +35,7 @@ OPTIONS
 --porcelain::
 	Give the output in an easy-to-parse format for scripts.
 	This is similar to the short output, but will remain stable
-	across git versions and regardless of user configuration. See
+	across Git versions and regardless of user configuration. See
 	below for details.
 
 --long::
@@ -96,7 +96,7 @@ The default, long format, is designed to be human readable,
 verbose and descriptive.  Its contents and format are subject to change
 at any time.
 
-The paths mentioned in the output, unlike many other git commands, are
+The paths mentioned in the output, unlike many other Git commands, are
 made relative to the current directory if you are working in a
 subdirectory (this is on purpose, to help cutting and pasting). See
 the status.relativePaths config option below.
@@ -168,7 +168,7 @@ Porcelain Format
 ~~~~~~~~~~~~~~~~
 
 The porcelain format is similar to the short format, but is guaranteed
-not to change in a backwards-incompatible way between git versions or
+not to change in a backwards-incompatible way between Git versions or
 based on user configuration. This makes it ideal for parsing by scripts.
 The description of the short format above also describes the porcelain
 format, with a few exceptions:
diff --git a/Documentation/git-stripspace.txt b/Documentation/git-stripspace.txt
index a80d946..eed921e 100644
--- a/Documentation/git-stripspace.txt
+++ b/Documentation/git-stripspace.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Clean the input in the manner used by 'git' for text such as commit
+Clean the input in the manner used by Git for text such as commit
 messages, notes, tags and branch descriptions.
 
 With no arguments, this will:
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index b1996f1..a0c9df8 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -91,7 +91,7 @@ working directory is used instead.
 <path> is the relative location for the cloned submodule to
 exist in the superproject. If <path> does not exist, then the
 submodule is created by cloning from the named URL. If <path> does
-exist and is already a valid git repository, then this is added
+exist and is already a valid Git repository, then this is added
 to the changeset without cloning. This second form is provided
 to ease creating a new submodule from scratch, and presumes
 the user will later push the submodule to the given URL.
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 34d438b..1b8b649 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -3,7 +3,7 @@ git-svn(1)
 
 NAME
 ----
-git-svn - Bidirectional operation between a Subversion repository and git
+git-svn - Bidirectional operation between a Subversion repository and Git
 
 SYNOPSIS
 --------
@@ -12,8 +12,8 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-'git svn' is a simple conduit for changesets between Subversion and git.
-It provides a bidirectional flow of changes between a Subversion and a git
+'git svn' is a simple conduit for changesets between Subversion and Git.
+It provides a bidirectional flow of changes between a Subversion and a Git
 repository.
 
 'git svn' can track a standard Subversion repository,
@@ -21,15 +21,15 @@ following the common "trunk/branches/tags" layout, with the --stdlayout option.
 It can also follow branches and tags in any layout with the -T/-t/-b options
 (see options to 'init' below, and also the 'clone' command).
 
-Once tracking a Subversion repository (with any of the above methods), the git
+Once tracking a Subversion repository (with any of the above methods), the Git
 repository can be updated from Subversion by the 'fetch' command and
-Subversion updated from git by the 'dcommit' command.
+Subversion updated from Git by the 'dcommit' command.
 
 COMMANDS
 --------
 
 'init'::
-	Initializes an empty git repository with additional
+	Initializes an empty Git repository with additional
 	metadata directories for 'git svn'.  The Subversion URL
 	may be specified as a command-line argument, or as full
 	URL arguments to -T/-t/-b.  Optionally, the target
@@ -199,9 +199,9 @@ and have no uncommitted changes.
 	Commit each diff from the current branch directly to the SVN
 	repository, and then rebase or reset (depending on whether or
 	not there is a diff between SVN and head).  This will create
-	a revision in SVN for each commit in git.
+	a revision in SVN for each commit in Git.
 +
-When an optional git branch name (or a git commit object name)
+When an optional Git branch name (or a Git commit object name)
 is specified as an argument, the subcommand works on the specified
 branch, not on the current branch.
 +
@@ -316,7 +316,7 @@ New features:
 +
 --
 --show-commit;;
-	shows the git commit sha1, as well
+	shows the Git commit sha1, as well
 --oneline;;
 	our version of --pretty=oneline
 --
@@ -337,13 +337,13 @@ Any other arguments are passed directly to 'git log'
 +
 --git-format;;
 	Produce output in the same format as 'git blame', but with
-	SVN revision numbers instead of git commit hashes. In this mode,
+	SVN revision numbers instead of Git commit hashes. In this mode,
 	changes that haven't been committed to SVN (including local
 	working-copy edits) are shown as revision 0.
 
 'find-rev'::
 	When given an SVN revision number of the form 'rN', returns the
-	corresponding git commit hash (this can optionally be followed by a
+	corresponding Git commit hash (this can optionally be followed by a
 	tree-ish to specify which branch should be searched).  When given a
 	tree-ish, returns the corresponding SVN revision number.
 +
@@ -378,7 +378,7 @@ Any other arguments are passed directly to 'git log'
 	the $GIT_DIR/info/exclude file.
 
 'mkdirs'::
-	Attempts to recreate empty directories that core git cannot track
+	Attempts to recreate empty directories that core Git cannot track
 	based on information in $GIT_DIR/svn/<refname>/unhandled.log files.
 	Empty directories are automatically recreated when using
 	"git svn clone" and "git svn rebase", so "mkdirs" is intended
@@ -510,9 +510,9 @@ order.  Only the leading sha1 is read from each line, so
 +
 Remove directories from the SVN tree if there are no files left
 behind.  SVN can version empty directories, and they are not
-removed by default if there are no files left in them.  git
+removed by default if there are no files left in them.  Git
 cannot version empty directories.  Enabling this flag will make
-the commit to SVN act like git.
+the commit to SVN act like Git.
 +
 [verse]
 config key: svn.rmdir
@@ -599,7 +599,7 @@ Passed directly to 'git rebase' when using 'dcommit' if a
 	This can be used with the 'dcommit', 'rebase', 'branch' and
 	'tag' commands.
 +
-For 'dcommit', print out the series of git arguments that would show
+For 'dcommit', print out the series of Git arguments that would show
 which diffs would be committed to SVN.
 +
 For 'rebase', display the local branch associated with the upstream svn
@@ -610,14 +610,14 @@ For 'branch' and 'tag', display the urls that will be used for copying when
 creating the branch or tag.
 
 --use-log-author::
-	When retrieving svn commits into git (as part of 'fetch', 'rebase', or
+	When retrieving svn commits into Git (as part of 'fetch', 'rebase', or
 	'dcommit' operations), look for the first `From:` or `Signed-off-by:` line
 	in the log message and use that as the author string.
 --add-author-from::
-	When committing to svn from git (as part of 'commit-diff', 'set-tree' or 'dcommit'
+	When committing to svn from Git (as part of 'commit-diff', 'set-tree' or 'dcommit'
 	operations), if the existing log message doesn't already have a
 	`From:` or `Signed-off-by:` line, append a `From:` line based on the
-	git commit's author string.  If you use this, then `--use-log-author`
+	Git commit's author string.  If you use this, then `--use-log-author`
 	will retrieve a valid author string for all commits.
 
 
@@ -642,7 +642,7 @@ ADVANCED OPTIONS
 	one of the repository layout options --trunk, --tags,
 	--branches, --stdlayout). For each tracked branch, try to find
 	out where its revision was copied from, and set
-	a suitable parent in the first git commit for the branch.
+	a suitable parent in the first Git commit for the branch.
 	This is especially helpful when we're tracking a directory
 	that has been moved around within the repository.  If this
 	feature is disabled, the branches created by 'git svn' will all
@@ -674,7 +674,7 @@ option for (hopefully) obvious reasons.
 +
 This option is NOT recommended as it makes it difficult to track down
 old references to SVN revision numbers in existing documentation, bug
-reports and archives.  If you plan to eventually migrate from SVN to git
+reports and archives.  If you plan to eventually migrate from SVN to Git
 and are certain about dropping SVN history, consider
 linkgit:git-filter-branch[1] instead.  filter-branch also allows
 reformatting of metadata for ease-of-reading and rewriting authorship
@@ -714,7 +714,7 @@ svn-remote.<name>.rewriteUUID::
 
 svn-remote.<name>.pushurl::
 
-	Similar to git's 'remote.<name>.pushurl', this key is designed
+	Similar to Git's 'remote.<name>.pushurl', this key is designed
 	to be used in cases where 'url' points to an SVN repository
 	via a read-only transport, to provide an alternate read/write
 	transport. It is assumed that both keys point to the same
@@ -768,15 +768,15 @@ Tracking and contributing to the trunk of a Subversion-managed project
 	cd trunk
 # You should be on master branch, double-check with 'git branch'
 	git branch
-# Do some work and commit locally to git:
+# Do some work and commit locally to Git:
 	git commit ...
 # Something is committed to SVN, rebase your local changes against the
 # latest changes in SVN:
 	git svn rebase
-# Now commit your changes (that were committed previously using git) to SVN,
+# Now commit your changes (that were committed previously using Git) to SVN,
 # as well as automatically updating your working HEAD:
 	git svn dcommit
-# Append svn:ignore settings to the default git exclude file:
+# Append svn:ignore settings to the default Git exclude file:
 	git svn show-ignore >> .git/info/exclude
 ------------------------------------------------------------------------
 
@@ -816,7 +816,7 @@ have each person clone that repository with 'git clone':
 	git remote add origin server:/pub/project
 	git config --replace-all remote.origin.fetch '+refs/remotes/*:refs/remotes/*'
 	git fetch
-# Prevent fetch/pull from remote git server in the future,
+# Prevent fetch/pull from remote Git server in the future,
 # we only want to use git svn for future updates
 	git config --remove-section remote.origin
 # Create a local branch from one of the branches just fetched
@@ -849,13 +849,13 @@ While 'git svn' can track
 copy history (including branches and tags) for repositories adopting a
 standard layout, it cannot yet represent merge history that happened
 inside git back upstream to SVN users.  Therefore it is advised that
-users keep history as linear as possible inside git to ease
+users keep history as linear as possible inside Git to ease
 compatibility with SVN (see the CAVEATS section below).
 
 HANDLING OF SVN BRANCHES
 ------------------------
 If 'git svn' is configured to fetch branches (and --follow-branches
-is in effect), it sometimes creates multiple git branches for one
+is in effect), it sometimes creates multiple Git branches for one
 SVN branch, where the addtional branches have names of the form
 'branchname@nnn' (with nnn an SVN revision number).  These additional
 branches are created if 'git svn' cannot find a parent commit for the
@@ -865,17 +865,17 @@ the other branches.
 Normally, the first commit in an SVN branch consists
 of a copy operation. 'git svn' will read this commit to get the SVN
 revision the branch was created from. It will then try to find the
-git commit that corresponds to this SVN revision, and use that as the
+Git commit that corresponds to this SVN revision, and use that as the
 parent of the branch. However, it is possible that there is no suitable
-git commit to serve as parent.  This will happen, among other reasons,
+Git commit to serve as parent.  This will happen, among other reasons,
 if the SVN branch is a copy of a revision that was not fetched by 'git
 svn' (e.g. because it is an old revision that was skipped with
 '--revision'), or if in SVN a directory was copied that is not tracked
 by 'git svn' (such as a branch that is not tracked at all, or a
 subdirectory of a tracked branch). In these cases, 'git svn' will still
-create a git branch, but instead of using an existing git commit as the
+create a Git branch, but instead of using an existing Git commit as the
 parent of the branch, it will read the SVN history of the directory the
-branch was copied from and create appropriate git commits.  This is
+branch was copied from and create appropriate Git commits.  This is
 indicated by the message "Initializing parent: <branchname>".
 
 Additionally, it will create a special branch named
@@ -885,15 +885,15 @@ created parent commit of the branch.  If in SVN the branch was deleted
 and later recreated from a different version, there will be multiple
 such branches with an '@'.
 
-Note that this may mean that multiple git commits are created for a
+Note that this may mean that multiple Git commits are created for a
 single SVN revision.
 
 An example: in an SVN repository with a standard
 trunk/tags/branches layout, a directory trunk/sub is created in r.100.
 In r.200, trunk/sub is branched by copying it to branches/. 'git svn
-clone -s' will then create a branch 'sub'. It will also create new git
+clone -s' will then create a branch 'sub'. It will also create new Git
 commits for r.100 through r.199 and use these as the history of branch
-'sub'. Thus there will be two git commits for each revision from r.100
+'sub'. Thus there will be two Git commits for each revision from r.100
 to r.199 (one containing trunk/, one containing trunk/sub/). Finally,
 it will create a branch 'sub@200' pointing to the new parent commit of
 branch 'sub' (i.e. the commit for r.200 and trunk/sub/).
@@ -904,13 +904,13 @@ CAVEATS
 For the sake of simplicity and interoperating with Subversion,
 it is recommended that all 'git svn' users clone, fetch and dcommit
 directly from the SVN server, and avoid all 'git clone'/'pull'/'merge'/'push'
-operations between git repositories and branches.  The recommended
-method of exchanging code between git branches and users is
+operations between Git repositories and branches.  The recommended
+method of exchanging code between Git branches and users is
 'git format-patch' and 'git am', or just 'dcommit'ing to the SVN repository.
 
 Running 'git merge' or 'git pull' is NOT recommended on a branch you
 plan to 'dcommit' from because Subversion users cannot see any
-merges you've made.  Furthermore, if you merge or pull from a git branch
+merges you've made.  Furthermore, if you merge or pull from a Git branch
 that is a mirror of an SVN branch, 'dcommit' may commit to the wrong
 branch.
 
@@ -929,7 +929,7 @@ any 'git svn' metadata, or config.  So repositories created and managed with
 using 'git svn' should use 'rsync' for cloning, if cloning is to be done
 at all.
 
-Since 'dcommit' uses rebase internally, any git branches you 'git push' to
+Since 'dcommit' uses rebase internally, any Git branches you 'git push' to
 before 'dcommit' on will require forcing an overwrite of the existing ref
 on the remote repository.  This is generally considered bad practice,
 see the linkgit:git-push[1] documentation for details.
@@ -941,7 +941,7 @@ dcommit with SVN is analogous to that.
 
 When cloning an SVN repository, if none of the options for describing
 the repository layout is used (--trunk, --tags, --branches,
---stdlayout), 'git svn clone' will create a git repository with
+--stdlayout), 'git svn clone' will create a Git repository with
 completely linear history, where branches and tags appear as separate
 directories in the working copy.  While this is the easiest way to get a
 copy of a complete repository, for projects with many branches it will
@@ -957,7 +957,7 @@ branches and tags is required, the options '--trunk' / '--branches' /
 When using multiple --branches or --tags, 'git svn' does not automatically
 handle name collisions (for example, if two branches from different paths have
 the same name, or if a branch and a tag have the same name).  In these cases,
-use 'init' to set up your git repository then, before your first 'fetch', edit
+use 'init' to set up your Git repository then, before your first 'fetch', edit
 the .git/config file so that the branches and tags are associated with
 different name spaces.  For example:
 
@@ -970,12 +970,12 @@ BUGS
 We ignore all SVN properties except svn:executable.  Any unhandled
 properties are logged to $GIT_DIR/svn/<refname>/unhandled.log
 
-Renamed and copied directories are not detected by git and hence not
+Renamed and copied directories are not detected by Git and hence not
 tracked when committing to SVN.  I do not plan on adding support for
 this as it's quite difficult and time-consuming to get working for all
-the possible corner cases (git doesn't do it, either).  Committing
+the possible corner cases (Git doesn't do it, either).  Committing
 renamed and copied files is fully supported if they're similar enough
-for git to detect them.
+for Git to detect them.
 
 In SVN, it is possible (though discouraged) to commit changes to a tag
 (because a tag is just a directory copy, thus technically the same as a
@@ -987,7 +987,7 @@ CONFIGURATION
 -------------
 
 'git svn' stores [svn-remote] configuration information in the
-repository .git/config file.  It is similar the core git
+repository .git/config file.  It is similar the core Git
 [remote] sections except 'fetch' keys do not accept glob
 arguments; but they are instead handled by the 'branches'
 and 'tags' keys.  Since some SVN repositories are oddly
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 6470cff..e3032c4 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -242,7 +242,7 @@ $ git pull git://git..../proj.git master
 In such a case, you do not want to automatically follow the other
 person's tags.
 
-One important aspect of git is its distributed nature, which
+One important aspect of Git is its distributed nature, which
 largely means there is no inherent "upstream" or
 "downstream" in the system.  On the face of it, the above
 example might seem to indicate that the tag namespace is owned
diff --git a/Documentation/git-tools.txt b/Documentation/git-tools.txt
index 2f51b83..338986a 100644
--- a/Documentation/git-tools.txt
+++ b/Documentation/git-tools.txt
@@ -1,11 +1,11 @@
-A short git tools survey
+A short Git tools survey
 ========================
 
 
 Introduction
 ------------
 
-Apart from git contrib/ area there are some others third-party tools
+Apart from Git contrib/ area there are some others third-party tools
 you may want to look.
 
 This document presents a brief summary of each tool and the corresponding
@@ -17,7 +17,7 @@ Alternative/Augmentative Porcelains
 
    - *Cogito* (http://www.kernel.org/pub/software/scm/cogito/)
 
-   Cogito is a version control system layered on top of the git tree history
+   Cogito is a version control system layered on top of the Git tree history
    storage system. It aims at seamless user interface and ease of use,
    providing generally smoother user experience than the "raw" Core Git
    itself and indeed many other version control systems.
@@ -50,7 +50,7 @@ History Viewers
 
    - *gitview*  (contrib/)
 
-   gitview is a GTK based repository browser for git
+   gitview is a GTK based repository browser for Git
 
 
    - *gitweb* (shipped with git-core)
@@ -63,15 +63,15 @@ History Viewers
    QGit is a git/StGIT GUI viewer built on Qt/C++. QGit could be used
    to browse history and directory tree, view annotated files, commit
    changes cherry picking single files or applying patches.
-   Currently it is the fastest and most feature rich among the git
+   Currently it is the fastest and most feature rich among the Git
    viewers and commit tools.
 
    - *tig* (http://jonas.nitro.dk/tig/)
 
-   tig by Jonas Fonseca is a simple git repository browser
+   tig by Jonas Fonseca is a simple Git repository browser
    written using ncurses. Basically, it just acts as a front-end
    for git-log and git-show/git-diff. Additionally, you can also
-   use it as a pager for git commands.
+   use it as a pager for Git commands.
 
 
 Foreign SCM interface
@@ -80,20 +80,20 @@ Foreign SCM interface
    - *git-svn* (shipped with git-core)
 
    git-svn is a simple conduit for changesets between a single Subversion
-   branch and git.
+   branch and Git.
 
 
    - *quilt2git / git2quilt* (http://home-tj.org/wiki/index.php/Misc)
 
    These utilities convert patch series in a quilt repository and commit
-   series in git back and forth.
+   series in Git back and forth.
 
 
    - *hg-to-git* (contrib/)
 
-   hg-to-git converts a Mercurial repository into a git one, and
+   hg-to-git converts a Mercurial repository into a Git one, and
    preserves the full branch history in the process. hg-to-git can
-   also be used in an incremental way to keep the git repository
+   also be used in an incremental way to keep the Git repository
    in sync with the master Mercurial repository.
 
 
@@ -102,14 +102,14 @@ Others
 
    - *(h)gct* (http://www.cyd.liu.se/users/~freku045/gct/)
 
-   Commit Tool or (h)gct is a GUI enabled commit tool for git and
+   Commit Tool or (h)gct is a GUI enabled commit tool for Git and
    Mercurial (hg). It allows the user to view diffs, select which files
    to committed (or ignored / reverted) write commit messages and
    perform the commit itself.
 
    - *git.el* (contrib/)
 
-   This is an Emacs interface for git. The user interface is modeled on
+   This is an Emacs interface for Git. The user interface is modeled on
    pcl-cvs. It has been developed on Emacs 21 and will probably need some
    tweaking to work on XEmacs.
 
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 9d0b151..77a912d 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -82,10 +82,10 @@ OPTIONS
 	When these flags are specified, the object names recorded
 	for the paths are not updated.  Instead, these options
 	set and unset the "assume unchanged" bit for the
-	paths.  When the "assume unchanged" bit is on, git stops
+	paths.  When the "assume unchanged" bit is on, Git stops
 	checking the working tree files for possible
 	modifications, so you need to manually unset the bit to
-	tell git when you change the working tree file. This is
+	tell Git when you change the working tree file. This is
 	sometimes helpful when working with a big project on a
 	filesystem that has very slow lstat(2) system call
 	(e.g. cifs).
@@ -253,18 +253,18 @@ $ git ls-files -s
 Using ``assume unchanged'' bit
 ------------------------------
 
-Many operations in git depend on your filesystem to have an
+Many operations in Git depend on your filesystem to have an
 efficient `lstat(2)` implementation, so that `st_mtime`
 information for working tree files can be cheaply checked to see
 if the file contents have changed from the version recorded in
 the index file.  Unfortunately, some filesystems have
 inefficient `lstat(2)`.  If your filesystem is one of them, you
 can set "assume unchanged" bit to paths you have not changed to
-cause git not to do this check.  Note that setting this bit on a
-path does not mean git will check the contents of the file to
-see if it has changed -- it makes git to omit any checking and
+cause Git not to do this check.  Note that setting this bit on a
+path does not mean Git will check the contents of the file to
+see if it has changed -- it makes Git to omit any checking and
 assume it has *not* changed.  When you make changes to working
-tree files, you have to explicitly tell git about it by dropping
+tree files, you have to explicitly tell Git about it by dropping
 "assume unchanged" bit, either before or after you modify them.
 
 In order to set "assume unchanged" bit, use `--assume-unchanged`
@@ -274,7 +274,7 @@ have the "assume unchanged" bit set, use `git ls-files -v`
 
 The command looks at `core.ignorestat` configuration variable.  When
 this is true, paths updated with `git update-index paths...` and
-paths updated with other git commands that update both index and
+paths updated with other Git commands that update both index and
 working tree (e.g. 'git apply --index', 'git checkout-index -u',
 and 'git read-tree -u') are automatically marked as "assume
 unchanged".  Note that "assume unchanged" bit is *not* set if
diff --git a/Documentation/git-upload-archive.txt b/Documentation/git-upload-archive.txt
index 4d52d38..d09bbb5 100644
--- a/Documentation/git-upload-archive.txt
+++ b/Documentation/git-upload-archive.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Invoked by 'git archive --remote' and sends a generated archive to the
-other end over the git protocol.
+other end over the Git protocol.
 
 This command is usually not invoked directly by the end user.  The UI
 for the protocol is on the 'git archive' side, and the program pair
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index 71f1608..0abc806 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -26,7 +26,7 @@ OPTIONS
 -------
 
 --strict::
-	Do not try <directory>/.git/ if <directory> is no git directory.
+	Do not try <directory>/.git/ if <directory> is no Git directory.
 
 --timeout=<n>::
 	Interrupt transfer after <n> seconds of inactivity.
diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 67edf58..44ff954 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -3,7 +3,7 @@ git-var(1)
 
 NAME
 ----
-git-var - Show a git logical variable
+git-var - Show a Git logical variable
 
 
 SYNOPSIS
@@ -13,13 +13,13 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Prints a git logical variable.
+Prints a Git logical variable.
 
 OPTIONS
 -------
 -l::
 	Cause the logical variables to be listed. In addition, all the
-	variables of the git configuration file .git/config are listed
+	variables of the Git configuration file .git/config are listed
 	as well. (However, the configuration variables listing functionality
 	is deprecated in favor of `git config -l`.)
 
@@ -35,10 +35,10 @@ GIT_AUTHOR_IDENT::
     The author of a piece of code.
 
 GIT_COMMITTER_IDENT::
-    The person who put a piece of code into git.
+    The person who put a piece of code into Git.
 
 GIT_EDITOR::
-    Text editor for use by git commands.  The value is meant to be
+    Text editor for use by Git commands.  The value is meant to be
     interpreted by the shell when it is used.  Examples: `~/bin/vi`,
     `$SOME_ENVIRONMENT_VARIABLE`, `"C:\Program Files\Vim\gvim.exe"
     --nofork`.  The order of preference is the `$GIT_EDITOR`
@@ -50,7 +50,7 @@ ifdef::git-default-editor[]
 endif::git-default-editor[]
 
 GIT_PAGER::
-    Text viewer for use by git commands (e.g., 'less').  The value
+    Text viewer for use by Git commands (e.g., 'less').  The value
     is meant to be interpreted by the shell.  The order of preference
     is the `$GIT_PAGER` environment variable, then `core.pager`
     configuration, then `$PAGER`, and then the default chosen at
diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
index cd23076..d4ae05b 100644
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Reads given idx file for packed git archive created with the
+Reads given idx file for packed Git archive created with the
 'git pack-objects' command and verifies idx file and the
 corresponding pack file.
 
diff --git a/Documentation/git-verify-tag.txt b/Documentation/git-verify-tag.txt
index 5ff76e8..e996135 100644
--- a/Documentation/git-verify-tag.txt
+++ b/Documentation/git-verify-tag.txt
@@ -21,7 +21,7 @@ OPTIONS
 	Print the contents of the tag object before validating it.
 
 <tag>...::
-	SHA1 identifiers of git tag objects.
+	SHA1 identifiers of Git tag objects.
 
 GIT
 ---
diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index c2bc87b..ba79cb4 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -3,7 +3,7 @@ git-web{litdd}browse(1)
 
 NAME
 ----
-git-web--browse - git helper script to launch a web browser
+git-web--browse - Git helper script to launch a web browser
 
 SYNOPSIS
 --------
@@ -50,7 +50,7 @@ OPTIONS
 
 -c <conf.var>::
 --config=<conf.var>::
-	CONF.VAR is looked up in the git config files. If it's set,
+	CONF.VAR is looked up in the Git config files. If it's set,
 	then its value specifies the browser that should be used.
 
 CONFIGURATION VARIABLES
diff --git a/Documentation/git-whatchanged.txt b/Documentation/git-whatchanged.txt
index 6c8f510..c600b61 100644
--- a/Documentation/git-whatchanged.txt
+++ b/Documentation/git-whatchanged.txt
@@ -24,7 +24,7 @@ This manual page describes only the most frequently used options.
 OPTIONS
 -------
 -p::
-	Show textual diffs, instead of the git internal diff
+	Show textual diffs, instead of the Git internal diff
 	output format that is useful only to tell the changed
 	paths and their nature of changes.
 
@@ -36,7 +36,7 @@ OPTIONS
 	exclusive, top inclusive).
 
 -r::
-	Show git internal diff output, but for the whole tree,
+	Show Git internal diff output, but for the whole tree,
 	not just the top level.
 
 -m::
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 1aac71e..c431ba2 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -27,11 +27,11 @@ commands.  The link:user-manual.html[Git User's Manual] has a more
 in-depth introduction.
 
 After you mastered the basic concepts, you can come back to this
-page to learn what commands git offers.  You can learn more about
-individual git commands with "git help command".  linkgit:gitcli[7]
+page to learn what commands Git offers.  You can learn more about
+individual Git commands with "git help command".  linkgit:gitcli[7]
 manual page gives you an overview of the command line command syntax.
 
-Formatted and hyperlinked version of the latest git documentation
+Formatted and hyperlinked version of the latest Git documentation
 can be viewed at `http://git-htmldocs.googlecode.com/git/git.html`.
 
 ifdef::stalenotes[]
@@ -39,7 +39,7 @@ ifdef::stalenotes[]
 ============
 
 You are reading the documentation for the latest (possibly
-unreleased) version of git, that is available from 'master'
+unreleased) version of Git, that is available from 'master'
 branch of the `git.git` repository.
 Documentation for older releases are available here:
 
@@ -355,12 +355,12 @@ endif::stalenotes[]
 OPTIONS
 -------
 --version::
-	Prints the git suite version that the 'git' program came from.
+	Prints the Git suite version that the 'git' program came from.
 
 --help::
 	Prints the synopsis and a list of the most commonly used
 	commands. If the option '--all' or '-a' is given then all
-	available commands are printed. If a git command is named this
+	available commands are printed. If a Git command is named this
 	option will bring up the manual page for that command.
 +
 Other options are available to control how the manual page is
@@ -375,22 +375,22 @@ help ...`.
 	'git config' (subkeys separated by dots).
 
 --exec-path[=<path>]::
-	Path to wherever your core git programs are installed.
+	Path to wherever your core Git programs are installed.
 	This can also be controlled by setting the GIT_EXEC_PATH
 	environment variable. If no path is given, 'git' will print
 	the current setting and then exit.
 
 --html-path::
-	Print the path, without trailing slash, where git's HTML
+	Print the path, without trailing slash, where Git's HTML
 	documentation is installed and exit.
 
 --man-path::
 	Print the manpath (see `man(1)`) for the man pages for
-	this version of git and exit.
+	this version of Git and exit.
 
 --info-path::
 	Print the path where the Info files documenting this
-	version of git are installed and exit.
+	version of Git are installed and exit.
 
 -p::
 --paginate::
@@ -400,7 +400,7 @@ help ...`.
 	below).
 
 --no-pager::
-	Do not pipe git output into a pager.
+	Do not pipe Git output into a pager.
 
 --git-dir=<path>::
 	Set the path to the repository. This can also be controlled by
@@ -416,7 +416,7 @@ help ...`.
 	more detailed discussion).
 
 --namespace=<path>::
-	Set the git namespace.  See linkgit:gitnamespaces[7] for more
+	Set the Git namespace.  See linkgit:gitnamespaces[7] for more
 	details.  Equivalent to setting the `GIT_NAMESPACE` environment
 	variable.
 
@@ -426,7 +426,7 @@ help ...`.
 	directory.
 
 --no-replace-objects::
-	Do not use replacement refs to replace git objects. See
+	Do not use replacement refs to replace Git objects. See
 	linkgit:git-replace[1] for more information.
 
 --literal-pathspecs::
@@ -438,7 +438,7 @@ help ...`.
 GIT COMMANDS
 ------------
 
-We divide git into high level ("porcelain") commands and low level
+We divide Git into high level ("porcelain") commands and low level
 ("plumbing") commands.
 
 High-level commands (porcelain)
@@ -475,7 +475,7 @@ include::cmds-foreignscminterface.txt[]
 Low-level commands (plumbing)
 -----------------------------
 
-Although git includes its
+Although Git includes its
 own porcelain layer, its low-level commands are sufficient to support
 development of alternative porcelains.  Developers of such porcelains
 might start by reading about linkgit:git-update-index[1] and
@@ -596,7 +596,7 @@ Identifier Terminology
 
 Symbolic Identifiers
 --------------------
-Any git command accepting any <object> can also use the following
+Any Git command accepting any <object> can also use the following
 symbolic notation:
 
 HEAD::
@@ -632,13 +632,13 @@ Please see linkgit:gitglossary[7].
 
 Environment Variables
 ---------------------
-Various git commands use the following environment variables:
+Various Git commands use the following environment variables:
 
-The git Repository
+The Git Repository
 ~~~~~~~~~~~~~~~~~~
-These environment variables apply to 'all' core git commands. Nb: it
+These environment variables apply to 'all' core Git commands. Nb: it
 is worth noting that they may be used/overridden by SCMS sitting above
-git so take care if using Cogito etc.
+Git so take care if using Cogito etc.
 
 'GIT_INDEX_FILE'::
 	This environment allows the specification of an alternate
@@ -652,10 +652,10 @@ git so take care if using Cogito etc.
 	directory is used.
 
 'GIT_ALTERNATE_OBJECT_DIRECTORIES'::
-	Due to the immutable nature of git objects, old objects can be
+	Due to the immutable nature of Git objects, old objects can be
 	archived into shared, read-only directories. This variable
 	specifies a ":" separated (on Windows ";" separated) list
-	of git object directories which can be used to search for git
+	of Git object directories which can be used to search for Git
 	objects. New objects will not be written to these directories.
 
 'GIT_DIR'::
@@ -672,12 +672,12 @@ git so take care if using Cogito etc.
 	option and the core.worktree configuration variable.
 
 'GIT_NAMESPACE'::
-	Set the git namespace; see linkgit:gitnamespaces[7] for details.
+	Set the Git namespace; see linkgit:gitnamespaces[7] for details.
 	The '--namespace' command-line option also sets this value.
 
 'GIT_CEILING_DIRECTORIES'::
 	This should be a colon-separated list of absolute paths.
-	If set, it is a list of directories that git should not chdir
+	If set, it is a list of directories that Git should not chdir
 	up into while looking for a repository directory.
 	It will not exclude the current working directory or
 	a GIT_DIR set on the command line or in the environment.
@@ -685,15 +685,15 @@ git so take care if using Cogito etc.
 
 'GIT_DISCOVERY_ACROSS_FILESYSTEM'::
 	When run in a directory that does not have ".git" repository
-	directory, git tries to find such a directory in the parent
+	directory, Git tries to find such a directory in the parent
 	directories to find the top of the working tree, but by default it
 	does not cross filesystem boundaries.  This environment variable
-	can be set to true to tell git not to stop at filesystem
+	can be set to true to tell Git not to stop at filesystem
 	boundaries.  Like 'GIT_CEILING_DIRECTORIES', this will not affect
 	an explicit repository directory set via 'GIT_DIR' or on the
 	command line.
 
-git Commits
+Git Commits
 ~~~~~~~~~~~
 'GIT_AUTHOR_NAME'::
 'GIT_AUTHOR_EMAIL'::
@@ -704,13 +704,13 @@ git Commits
 'EMAIL'::
 	see linkgit:git-commit-tree[1]
 
-git Diffs
+Git Diffs
 ~~~~~~~~~
 'GIT_DIFF_OPTS'::
 	Only valid setting is "--unified=??" or "-u??" to set the
 	number of context lines shown when a unified diff is created.
 	This takes precedence over any "-U" or "--unified" option
-	value passed on the git diff command line.
+	value passed on the Git diff command line.
 
 'GIT_EXTERNAL_DIFF'::
 	When the environment variable 'GIT_EXTERNAL_DIFF' is set, the
@@ -745,13 +745,13 @@ other
 
 'GIT_PAGER'::
 	This environment variable overrides `$PAGER`. If it is set
-	to an empty string or to the value "cat", git will not launch
+	to an empty string or to the value "cat", Git will not launch
 	a pager.  See also the `core.pager` option in
 	linkgit:git-config[1].
 
 'GIT_EDITOR'::
 	This environment variable overrides `$EDITOR` and `$VISUAL`.
-	It is used by several git commands when, on interactive mode,
+	It is used by several Git commands when, on interactive mode,
 	an editor is to be launched. See also linkgit:git-var[1]
 	and the `core.editor` option in linkgit:git-config[1].
 
@@ -772,7 +772,7 @@ personal `.ssh/config` file.  Please consult your ssh documentation
 for further details.
 
 'GIT_ASKPASS'::
-	If this environment variable is set, then git commands which need to
+	If this environment variable is set, then Git commands which need to
 	acquire passwords or passphrases (e.g. for HTTP or IMAP authentication)
 	will call this program with a suitable prompt as command line argument
 	and read the password from its STDOUT. See also the 'core.askpass'
@@ -793,30 +793,30 @@ for further details.
 	after each commit-oriented record have been flushed.   If this
 	variable is set to "0", the output of these commands will be done
 	using completely buffered I/O.   If this environment variable is
-	not set, git will choose buffered or record-oriented flushing
+	not set, Git will choose buffered or record-oriented flushing
 	based on whether stdout appears to be redirected to a file or not.
 
 'GIT_TRACE'::
 	If this variable is set to "1", "2" or "true" (comparison
-	is case insensitive), git will print `trace:` messages on
+	is case insensitive), Git will print `trace:` messages on
 	stderr telling about alias expansion, built-in command
 	execution and external command execution.
 	If this variable is set to an integer value greater than 1
-	and lower than 10 (strictly) then git will interpret this
+	and lower than 10 (strictly) then Git will interpret this
 	value as an open file descriptor and will try to write the
 	trace messages into this file descriptor.
 	Alternatively, if this variable is set to an absolute path
-	(starting with a '/' character), git will interpret this
+	(starting with a '/' character), Git will interpret this
 	as a file path and will try to write the trace messages
 	into it.
 
 GIT_LITERAL_PATHSPECS::
-	Setting this variable to `1` will cause git to treat all
+	Setting this variable to `1` will cause Git to treat all
 	pathspecs literally, rather than as glob patterns. For example,
 	running `GIT_LITERAL_PATHSPECS=1 git log -- '*.c'` will search
 	for commits that touch the path `*.c`, not any paths that the
 	glob `*.c` matches. You might want this if you are feeding
-	literal paths to git (e.g., paths previously given to you by
+	literal paths to Git (e.g., paths previously given to you by
 	`git ls-tree`, `--raw` diff output, etc).
 
 
@@ -824,10 +824,10 @@ Discussion[[Discussion]]
 ------------------------
 
 More detail on the following is available from the
-link:user-manual.html#git-concepts[git concepts chapter of the
+link:user-manual.html#git-concepts[Git concepts chapter of the
 user-manual] and linkgit:gitcore-tutorial[7].
 
-A git project normally consists of a working directory with a ".git"
+A Git project normally consists of a working directory with a ".git"
 subdirectory at the top level.  The .git directory contains, among other
 things, a compressed object database representing the complete history
 of the project, an "index" file which links that history to the current
@@ -877,12 +877,12 @@ FURTHER DOCUMENTATION
 ---------------------
 
 See the references in the "description" section to get started
-using git.  The following is probably more detail than necessary
+using Git.  The following is probably more detail than necessary
 for a first-time user.
 
-The link:user-manual.html#git-concepts[git concepts chapter of the
+The link:user-manual.html#git-concepts[Git concepts chapter of the
 user-manual] and linkgit:gitcore-tutorial[7] both provide
-introductions to the underlying git architecture.
+introductions to the underlying Git architecture.
 
 See linkgit:gitworkflows[7] for an overview of recommended workflows.
 
@@ -899,7 +899,7 @@ read linkgit:gitcvs-migration[7].
 Authors
 -------
 Git was started by Linus Torvalds, and is currently maintained by Junio
-C Hamano. Numerous contributions have come from the git mailing list
+C Hamano. Numerous contributions have come from the Git mailing list
 <git@vger.kernel.org>.  http://www.ohloh.net/p/git/contributors/summary
 gives you a more complete list of contributors.
 
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 2698f63..b9c0eec 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -58,7 +58,7 @@ attribute.  The rules how the pattern matches paths are the
 same as in `.gitignore` files; see linkgit:gitignore[5].
 Unlike `.gitignore`, negative patterns are forbidden.
 
-When deciding what attributes are assigned to a path, git
+When deciding what attributes are assigned to a path, Git
 consults `$GIT_DIR/info/attributes` file (which has the highest
 precedence), `.gitattributes` file in the same directory as the
 path in question, and its parent directories up to the toplevel of the
@@ -94,7 +94,7 @@ the name of the attribute prefixed with an exclamation point `!`.
 EFFECTS
 -------
 
-Certain operations by git can be influenced by assigning
+Certain operations by Git can be influenced by assigning
 particular attributes to a path.  Currently, the following
 operations are attributes-aware.
 
@@ -104,7 +104,7 @@ Checking-out and checking-in
 These attributes affect how the contents stored in the
 repository are copied to the working tree files when commands
 such as 'git checkout' and 'git merge' run.  They also affect how
-git stores the contents you prepare in the working tree in the
+Git stores the contents you prepare in the working tree in the
 repository upon 'git add' and 'git commit'.
 
 `text`
@@ -124,22 +124,22 @@ Set::
 
 Unset::
 
-	Unsetting the `text` attribute on a path tells git not to
+	Unsetting the `text` attribute on a path tells Git not to
 	attempt any end-of-line conversion upon checkin or checkout.
 
 Set to string value "auto"::
 
 	When `text` is set to "auto", the path is marked for automatic
-	end-of-line normalization.  If git decides that the content is
+	end-of-line normalization.  If Git decides that the content is
 	text, its line endings are normalized to LF on checkin.
 
 Unspecified::
 
-	If the `text` attribute is unspecified, git uses the
+	If the `text` attribute is unspecified, Git uses the
 	`core.autocrlf` configuration variable to determine if the
 	file should be converted.
 
-Any other value causes git to act as if `text` has been left
+Any other value causes Git to act as if `text` has been left
 unspecified.
 
 `eol`
@@ -151,13 +151,13 @@ content checks, effectively setting the `text` attribute.
 
 Set to string value "crlf"::
 
-	This setting forces git to normalize line endings for this
+	This setting forces Git to normalize line endings for this
 	file on checkin and convert them to CRLF when the file is
 	checked out.
 
 Set to string value "lf"::
 
-	This setting forces git to normalize line endings to LF on
+	This setting forces Git to normalize line endings to LF on
 	checkin and prevents conversion to CRLF when the file is
 	checked out.
 
@@ -176,11 +176,11 @@ crlf=input	eol=lf
 End-of-line conversion
 ^^^^^^^^^^^^^^^^^^^^^^
 
-While git normally leaves file contents alone, it can be configured to
+While Git normally leaves file contents alone, it can be configured to
 normalize line endings to LF in the repository and, optionally, to
 convert them to CRLF when files are checked out.
 
-Here is an example that will make git normalize .txt, .vcproj and .sh
+Here is an example that will make Git normalize .txt, .vcproj and .sh
 files, ensure that .vcproj files have CRLF and .sh files have LF in
 the working directory, and prevent .jpg files from being normalized
 regardless of their content.
@@ -194,7 +194,7 @@ regardless of their content.
 
 Other source code management systems normalize all text files in their
 repositories, and there are two ways to enable similar automatic
-normalization in git.
+normalization in Git.
 
 If you simply want to have CRLF line endings in your working directory
 regardless of the repository you are working with, you can set the
@@ -219,9 +219,9 @@ attribute to "auto" for _all_ files.
 *	text=auto
 ------------------------
 
-This ensures that all files that git considers to be text will have
+This ensures that all files that Git considers to be text will have
 normalized (LF) line endings in the repository.  The `core.eol`
-configuration variable controls which line endings git will use for
+configuration variable controls which line endings Git will use for
 normalized files in your working directory; the default is to use the
 native line ending for your platform, or CRLF if `core.autocrlf` is
 set.
@@ -234,7 +234,7 @@ directory:
 
 -------------------------------------------------
 $ echo "* text=auto" >>.gitattributes
-$ rm .git/index     # Remove the index to force git to
+$ rm .git/index     # Remove the index to force Git to
 $ git reset         # re-scan the working directory
 $ git status        # Show files that will be normalized
 $ git add -u
@@ -249,17 +249,17 @@ unset their `text` attribute before running 'git add -u'.
 manual.pdf	-text
 ------------------------
 
-Conversely, text files that git does not detect can have normalization
+Conversely, text files that Git does not detect can have normalization
 enabled manually.
 
 ------------------------
 weirdchars.txt	text
 ------------------------
 
-If `core.safecrlf` is set to "true" or "warn", git verifies if
+If `core.safecrlf` is set to "true" or "warn", Git verifies if
 the conversion is reversible for the current setting of
-`core.autocrlf`.  For "true", git rejects irreversible
-conversions; for "warn", git only prints a warning but accepts
+`core.autocrlf`.  For "true", Git rejects irreversible
+conversions; for "warn", Git only prints a warning but accepts
 an irreversible conversion.  The safety triggers to prevent such
 a conversion done to the files in the work tree, but there are a
 few exceptions.  Even though...
@@ -280,7 +280,7 @@ few exceptions.  Even though...
 `ident`
 ^^^^^^^
 
-When the attribute `ident` is set for a path, git replaces
+When the attribute `ident` is set for a path, Git replaces
 `$Id$` in the blob object with `$Id:`, followed by the
 40-character hexadecimal blob object name, followed by a dollar
 sign `$` upon checkout.  Any byte sequence that begins with
@@ -311,7 +311,7 @@ the appropriate filter program, the project should still be usable.
 
 Another use of the content filtering is to store the content that cannot
 be directly used in the repository (e.g. a UUID that refers to the true
-content stored outside git, or an encrypted content) and turn it into a
+content stored outside Git, or an encrypted content) and turn it into a
 usable form upon checkout (e.g. download the external content, or decrypt
 the encrypted content).
 
@@ -397,7 +397,7 @@ clean/smudge filter or text/eol/ident attributes, merging anything
 where the attribute is not in place would normally cause merge
 conflicts.
 
-To prevent these unnecessary merge conflicts, git can be told to run a
+To prevent these unnecessary merge conflicts, Git can be told to run a
 virtual check-out and check-in of all three stages of a file when
 resolving a three-way merge by setting the `merge.renormalize`
 configuration variable.  This prevents changes caused by check-in
@@ -417,11 +417,11 @@ Generating diff text
 `diff`
 ^^^^^^
 
-The attribute `diff` affects how 'git' generates diffs for particular
-files. It can tell git whether to generate a textual patch for the path
+The attribute `diff` affects how Git generates diffs for particular
+files. It can tell Git whether to generate a textual patch for the path
 or to treat the path as a binary file.  It can also affect what line is
-shown on the hunk header `@@ -k,l +n,m @@` line, tell git to use an
-external command to generate the diff, or ask git to convert binary
+shown on the hunk header `@@ -k,l +n,m @@` line, tell Git to use an
+external command to generate the diff, or ask Git to convert binary
 files to a text format before generating the diff.
 
 Set::
@@ -467,7 +467,7 @@ To define an external diff driver `jcdiff`, add a section to your
 	command = j-c-diff
 ----------------------------------------------------------------
 
-When git needs to show you a diff for the path with `diff`
+When Git needs to show you a diff for the path with `diff`
 attribute set to `jcdiff`, it calls the command you specified
 with the above configuration, i.e. `j-c-diff`, with 7
 parameters, just like `GIT_EXTERNAL_DIFF` program is called.
@@ -606,7 +606,7 @@ should generate it separately and send it as a comment _in
 addition to_ the usual binary diff that you might send.
 
 Because text conversion can be slow, especially when doing a
-large number of them with `git log -p`, git provides a mechanism
+large number of them with `git log -p`, Git provides a mechanism
 to cache the output and use it in future diffs.  To enable
 caching, set the "cachetextconv" variable in your diff driver's
 config. For example:
@@ -619,7 +619,7 @@ config. For example:
 
 This will cache the result of running "exif" on each blob
 indefinitely. If you change the textconv config variable for a
-diff driver, git will automatically invalidate the cache entries
+diff driver, Git will automatically invalidate the cache entries
 and re-run the textconv filter. If you want to invalidate the
 cache manually (e.g., because your version of "exif" was updated
 and now produces better output), you can remove the cache
@@ -640,7 +640,7 @@ output to resemble unified diff. You are free to locate and report
 changes in the most appropriate way for your data format.
 
 A textconv, by comparison, is much more limiting. You provide a
-transformation of the data into a line-oriented text format, and git
+transformation of the data into a line-oriented text format, and Git
 uses its regular diff tools to generate the output. There are several
 advantages to choosing this method:
 
@@ -650,7 +650,7 @@ advantages to choosing this method:
    odt2txt).
 
 2. Git diff features. By performing only the transformation step
-   yourself, you can still utilize many of git's diff features,
+   yourself, you can still utilize many of Git's diff features,
    including colorization, word-diff, and combined diffs for merges.
 
 3. Caching. Textconv caching can speed up repeated diffs, such as those
@@ -831,7 +831,7 @@ control per path.
 
 Set::
 
-	Notice all types of potential whitespace errors known to git.
+	Notice all types of potential whitespace errors known to Git.
 	The tab width is taken from the value of the `core.whitespace`
 	configuration variable.
 
@@ -863,7 +863,7 @@ archive files.
 `export-subst`
 ^^^^^^^^^^^^^^
 
-If the attribute `export-subst` is set for a file then git will expand
+If the attribute `export-subst` is set for a file then Git will expand
 several placeholders when adding this file to an archive.  The
 expansion depends on the availability of a commit ID, i.e., if
 linkgit:git-archive[1] has been given a tree instead of a commit or a
@@ -961,7 +961,7 @@ abc	-foo -bar
 the attributes given to path `t/abc` are computed as follows:
 
 1. By examining `t/.gitattributes` (which is in the same
-   directory as the path in question), git finds that the first
+   directory as the path in question), Git finds that the first
    line matches.  `merge` attribute is set.  It also finds that
    the second line matches, and attributes `foo` and `bar`
    are unset.
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 3bc1500..dc9e617 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -3,7 +3,7 @@ gitcli(7)
 
 NAME
 ----
-gitcli - git command line interface and conventions
+gitcli - Git command line interface and conventions
 
 SYNOPSIS
 --------
@@ -13,7 +13,7 @@ gitcli
 DESCRIPTION
 -----------
 
-This manual describes the convention used throughout git CLI.
+This manual describes the convention used throughout Git CLI.
 
 Many commands take revisions (most often "commits", but sometimes
 "tree-ish", depending on the context and command) and paths as their
@@ -32,7 +32,7 @@ arguments.  Here are the rules:
    between the HEAD commit and the work tree as a whole".  You can say
    `git diff HEAD --` to ask for the latter.
 
- * Without disambiguating `--`, git makes a reasonable guess, but errors
+ * Without disambiguating `--`, Git makes a reasonable guess, but errors
    out and asking you to disambiguate when ambiguous.  E.g. if you have a
    file called HEAD in your work tree, `git diff HEAD` is ambiguous, and
    you have to say either `git diff HEAD --` or `git diff -- HEAD` to
@@ -60,9 +60,9 @@ see `hello.c` in your working tree with the former, but with the latter
 you will.
 
 Here are the rules regarding the "flags" that you should follow when you are
-scripting git:
+scripting Git:
 
- * it's preferred to use the non dashed form of git commands, which means that
+ * it's preferred to use the non dashed form of Git commands, which means that
    you should prefer `git foo` to `git-foo`.
 
  * splitting short options to separate words (prefer `git foo -a -b`
@@ -90,7 +90,7 @@ scripting git:
 
 ENHANCED OPTION PARSER
 ----------------------
-From the git 1.5.4 series and further, many git commands (not all of them at the
+From the Git 1.5.4 series and further, many Git commands (not all of them at the
 time of the writing though) come with an enhanced option parser.
 
 Here is a list of the facilities provided by this option parser.
@@ -117,7 +117,7 @@ usage: git describe [options] <committish>*
 ---------------------------------------------
 
 --help-all::
-	Some git commands take options that are only used for plumbing or that
+	Some Git commands take options that are only used for plumbing or that
 	are deprecated, and such options are hidden from the default usage. This
 	option gives the full list of options.
 
-- 
1.8.0.msysgit.0


---
Thomas
