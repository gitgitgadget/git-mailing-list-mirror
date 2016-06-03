From: Tom Russello <tom.russello@grenoble-inp.org>
Subject: [PATCH v2 2/3] Change environment variables format
Date: Sat,  4 Jun 2016 00:08:36 +0200
Message-ID: <20160603220837.9842-3-tom.russello@grenoble-inp.org>
References: <1463587109-22476-1-git-send-email-tom.russello@grenoble-inp.org>
 <20160603220837.9842-1-tom.russello@grenoble-inp.org>
Cc: matthieu.moy@grenoble-inp.fr, erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	peff@peff.net, gitster@pobox.com,
	Tom Russello <tom.russello@grenoble-inp.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 00:12:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8xK9-0006Ad-GQ
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 00:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbcFCWMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 18:12:03 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:47653 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964844AbcFCWLz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 18:11:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 92DD02586;
	Sat,  4 Jun 2016 00:11:52 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YAYsi0Typ9MK; Sat,  4 Jun 2016 00:11:52 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 81F112583;
	Sat,  4 Jun 2016 00:11:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 7F5112077;
	Sat,  4 Jun 2016 00:11:52 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z8kI4uhVh_YA; Sat,  4 Jun 2016 00:11:52 +0200 (CEST)
Received: from ux-305.numericable.fr (1.23.6.84.rev.sfr.net [84.6.23.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 3485D2066;
	Sat,  4 Jun 2016 00:11:52 +0200 (CEST)
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160603220837.9842-1-tom.russello@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296415>

As a first step, this change GIT_* variables that where in
italic style to monospace font according to the guideline. It was obtained
with

	perl -pi -e "s/\'(GIT_.*?)\'/\`\1\`/g" *.txt

Signed-off-by: Tom Russello <tom.russello@grenoble-inp.org>
Signed-off-by: Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>
Signed-off-by: Samuel Groot <samuel.groot@grenoble-inp.org>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
Currently, in Documentation/git-config.txt GIT_CONFIG (l.138) has no
particular style whereas in Documentation/config.txt GIT_PROXY_COMMAND
has italic style ('GIT_PROXY_COMMAND' - l.437) and GIT_EDITOR is
monospaced (`GIT_EDITOR` - l.657).

 Documentation/config.txt            |  46 +++++++-------
 Documentation/git-log.txt           |   4 +-
 Documentation/git-notes.txt         |  20 +++---
 Documentation/git-p4.txt            |   2 +-
 Documentation/git-replace.txt       |   2 +-
 Documentation/git.txt               | 120 ++++++++++++++++++------------------
 Documentation/gitremote-helpers.txt |   2 +-
 Documentation/gitweb.txt            |   4 +-
 Documentation/merge-config.txt      |   2 +-
 9 files changed, 101 insertions(+), 101 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2e1b2e4..3897906 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -434,7 +434,7 @@ core.gitProxy::
 	may be set multiple times and is matched in the given order;
 	the first match wins.
 +
-Can be overridden by the 'GIT_PROXY_COMMAND' environment variable
+Can be overridden by the `GIT_PROXY_COMMAND` environment variable
 (which always applies universally, without the special "for"
 handling).
 +
@@ -619,7 +619,7 @@ core.excludesFile::
 core.askPass::
 	Some commands (e.g. svn and http interfaces) that interactively
 	ask for a password can be told to use an external program given
-	via the value of this variable. Can be overridden by the 'GIT_ASKPASS'
+	via the value of this variable. Can be overridden by the `GIT_ASKPASS`
 	environment variable. If not set, fall back to the value of the
 	'SSH_ASKPASS' environment variable or, failing that, a simple password
 	prompt. The external program shall be given a suitable prompt as
@@ -764,7 +764,7 @@ core.notesRef::
 	notes should be printed.
 +
 This setting defaults to "refs/notes/commits", and it can be overridden by
-the 'GIT_NOTES_REF' environment variable.  See linkgit:git-notes[1].
+the `GIT_NOTES_REF` environment variable.  See linkgit:git-notes[1].
 
 core.sparseCheckout::
 	Enable "sparse checkout" feature. See section "Sparse checkout" in
@@ -800,7 +800,7 @@ it will be treated as a shell command.  For example, defining
 "gitk --all --not ORIG_HEAD".  Note that shell commands will be
 executed from the top-level directory of a repository, which may
 not necessarily be the current directory.
-'GIT_PREFIX' is set as returned by running 'git rev-parse --show-prefix'
+`GIT_PREFIX` is set as returned by running 'git rev-parse --show-prefix'
 from the original current directory. See linkgit:git-rev-parse[1].
 
 am.keepcr::
@@ -1587,7 +1587,7 @@ guitool.<name>.cmd::
 	of the linkgit:git-gui[1] `Tools` menu is invoked. This option is
 	mandatory for every tool. The command is executed from the root of
 	the working directory, and in the environment it receives the name of
-	the tool as 'GIT_GUITOOL', the name of the currently selected file as
+	the tool as `GIT_GUITOOL`, the name of the currently selected file as
 	'FILENAME', and the name of the current branch as 'CUR_BRANCH' (if
 	the head is detached, 'CUR_BRANCH' is empty).
 
@@ -1672,7 +1672,7 @@ http.proxyAuthMethod::
 	only takes effect if the configured proxy string contains a user name part
 	(i.e. is of the form 'user@host' or 'user@host:port'). This can be
 	overridden on a per-remote basis; see `remote.<name>.proxyAuthMethod`.
-	Both can be overridden by the 'GIT_HTTP_PROXY_AUTHMETHOD' environment
+	Both can be overridden by the `GIT_HTTP_PROXY_AUTHMETHOD` environment
 	variable.  Possible values are:
 +
 --
@@ -1731,9 +1731,9 @@ http.sslVersion::
 	- tlsv1.2
 
 +
-Can be overridden by the 'GIT_SSL_VERSION' environment variable.
+Can be overridden by the `GIT_SSL_VERSION` environment variable.
 To force git to use libcurl's default ssl version and ignore any
-explicit http.sslversion option, set 'GIT_SSL_VERSION' to the
+explicit http.sslversion option, set `GIT_SSL_VERSION` to the
 empty string.
 
 http.sslCipherList::
@@ -1744,41 +1744,41 @@ http.sslCipherList::
   option; see the libcurl documentation for more details on the format
   of this list.
 +
-Can be overridden by the 'GIT_SSL_CIPHER_LIST' environment variable.
+Can be overridden by the `GIT_SSL_CIPHER_LIST` environment variable.
 To force git to use libcurl's default cipher list and ignore any
-explicit http.sslCipherList option, set 'GIT_SSL_CIPHER_LIST' to the
+explicit http.sslCipherList option, set `GIT_SSL_CIPHER_LIST` to the
 empty string.
 
 http.sslVerify::
 	Whether to verify the SSL certificate when fetching or pushing
-	over HTTPS. Can be overridden by the 'GIT_SSL_NO_VERIFY' environment
+	over HTTPS. Can be overridden by the `GIT_SSL_NO_VERIFY` environment
 	variable.
 
 http.sslCert::
 	File containing the SSL certificate when fetching or pushing
-	over HTTPS. Can be overridden by the 'GIT_SSL_CERT' environment
+	over HTTPS. Can be overridden by the `GIT_SSL_CERT` environment
 	variable.
 
 http.sslKey::
 	File containing the SSL private key when fetching or pushing
-	over HTTPS. Can be overridden by the 'GIT_SSL_KEY' environment
+	over HTTPS. Can be overridden by the `GIT_SSL_KEY` environment
 	variable.
 
 http.sslCertPasswordProtected::
 	Enable Git's password prompt for the SSL certificate.  Otherwise
 	OpenSSL will prompt the user, possibly many times, if the
 	certificate or private key is encrypted.  Can be overridden by the
-	'GIT_SSL_CERT_PASSWORD_PROTECTED' environment variable.
+	`GIT_SSL_CERT_PASSWORD_PROTECTED` environment variable.
 
 http.sslCAInfo::
 	File containing the certificates to verify the peer with when
 	fetching or pushing over HTTPS. Can be overridden by the
-	'GIT_SSL_CAINFO' environment variable.
+	`GIT_SSL_CAINFO` environment variable.
 
 http.sslCAPath::
 	Path containing files with the CA certificates to verify the peer
 	with when fetching or pushing over HTTPS. Can be overridden
-	by the 'GIT_SSL_CAPATH' environment variable.
+	by the `GIT_SSL_CAPATH` environment variable.
 
 http.pinnedpubkey::
 	Public key of the https service. It may either be the filename of
@@ -1798,7 +1798,7 @@ http.sslTry::
 
 http.maxRequests::
 	How many HTTP requests to launch in parallel. Can be overridden
-	by the 'GIT_HTTP_MAX_REQUESTS' environment variable. Default is 5.
+	by the `GIT_HTTP_MAX_REQUESTS` environment variable. Default is 5.
 
 http.minSessions::
 	The number of curl sessions (counted across slots) to be kept across
@@ -1817,13 +1817,13 @@ http.postBuffer::
 http.lowSpeedLimit, http.lowSpeedTime::
 	If the HTTP transfer speed is less than 'http.lowSpeedLimit'
 	for longer than 'http.lowSpeedTime' seconds, the transfer is aborted.
-	Can be overridden by the 'GIT_HTTP_LOW_SPEED_LIMIT' and
-	'GIT_HTTP_LOW_SPEED_TIME' environment variables.
+	Can be overridden by the `GIT_HTTP_LOW_SPEED_LIMIT` and
+	`GIT_HTTP_LOW_SPEED_TIME` environment variables.
 
 http.noEPSV::
 	A boolean which disables using of EPSV ftp command by curl.
 	This can helpful with some "poor" ftp servers which don't
-	support EPSV mode. Can be overridden by the 'GIT_CURL_FTP_NO_EPSV'
+	support EPSV mode. Can be overridden by the `GIT_CURL_FTP_NO_EPSV`
 	environment variable. Default is false (curl will use EPSV).
 
 http.userAgent::
@@ -1833,7 +1833,7 @@ http.userAgent::
 	such as Mozilla/4.0.  This may be necessary, for instance, if
 	connecting through a firewall that restricts HTTP connections to a set
 	of common USER_AGENT strings (but not including those like git/1.7.1).
-	Can be overridden by the 'GIT_HTTP_USER_AGENT' environment variable.
+	Can be overridden by the `GIT_HTTP_USER_AGENT` environment variable.
 
 http.<url>.*::
 	Any of the http.* options above can be applied selectively to some URLs.
@@ -2909,12 +2909,12 @@ url.<base>.pushInsteadOf::
 
 user.email::
 	Your email address to be recorded in any newly created commits.
-	Can be overridden by the 'GIT_AUTHOR_EMAIL', 'GIT_COMMITTER_EMAIL', and
+	Can be overridden by the `GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_EMAIL`, and
 	'EMAIL' environment variables.  See linkgit:git-commit-tree[1].
 
 user.name::
 	Your full name to be recorded in any newly created commits.
-	Can be overridden by the 'GIT_AUTHOR_NAME' and 'GIT_COMMITTER_NAME'
+	Can be overridden by the `GIT_AUTHOR_NAME` and `GIT_COMMITTER_NAME`
 	environment variables.  See linkgit:git-commit-tree[1].
 
 user.useConfigOnly::
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index dec379b..4a6c47f 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -203,7 +203,7 @@ mailmap.*::
 
 notes.displayRef::
 	Which refs, in addition to the default set by `core.notesRef`
-	or 'GIT_NOTES_REF', to read notes from when showing commit
+	or `GIT_NOTES_REF`, to read notes from when showing commit
 	messages with the `log` family of commands.  See
 	linkgit:git-notes[1].
 +
@@ -212,7 +212,7 @@ multiple times.  A warning will be issued for refs that do not exist,
 but a glob that does not match any refs is silently ignored.
 +
 This setting can be disabled by the `--no-notes` option,
-overridden by the 'GIT_NOTES_DISPLAY_REF' environment variable,
+overridden by the `GIT_NOTES_DISPLAY_REF` environment variable,
 and overridden by the `--notes=<ref>` option.
 
 GIT
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 9c4fd68..02a10bc 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -161,7 +161,7 @@ OPTIONS
 
 --ref <ref>::
 	Manipulate the notes tree in <ref>.  This overrides
-	'GIT_NOTES_REF' and the "core.notesRef" configuration.  The ref
+	`GIT_NOTES_REF` and the "core.notesRef" configuration.  The ref
 	specifies the full refname when it begins with `refs/notes/`; when it
 	begins with `notes/`, `refs/` and otherwise `refs/notes/` is prefixed
 	to form a full name of the ref.
@@ -333,10 +333,10 @@ notes.<name>.mergeStrategy::
 notes.displayRef::
 	Which ref (or refs, if a glob or specified more than once), in
 	addition to the default set by `core.notesRef` or
-	'GIT_NOTES_REF', to read notes from when showing commit
+	`GIT_NOTES_REF`, to read notes from when showing commit
 	messages with the 'git log' family of commands.
 	This setting can be overridden on the command line or by the
-	'GIT_NOTES_DISPLAY_REF' environment variable.
+	`GIT_NOTES_DISPLAY_REF` environment variable.
 	See linkgit:git-log[1].
 
 notes.rewrite.<command>::
@@ -345,7 +345,7 @@ notes.rewrite.<command>::
 	notes from the original to the rewritten commit.  Defaults to
 	`true`.  See also "`notes.rewriteRef`" below.
 +
-This setting can be overridden by the 'GIT_NOTES_REWRITE_REF'
+This setting can be overridden by the `GIT_NOTES_REWRITE_REF`
 environment variable.
 
 notes.rewriteMode::
@@ -366,33 +366,33 @@ notes.rewriteRef::
 Does not have a default value; you must configure this variable to
 enable note rewriting.
 +
-Can be overridden with the 'GIT_NOTES_REWRITE_REF' environment variable.
+Can be overridden with the `GIT_NOTES_REWRITE_REF` environment variable.
 
 
 ENVIRONMENT
 -----------
 
-'GIT_NOTES_REF'::
+`GIT_NOTES_REF`::
 	Which ref to manipulate notes from, instead of `refs/notes/commits`.
 	This overrides the `core.notesRef` setting.
 
-'GIT_NOTES_DISPLAY_REF'::
+`GIT_NOTES_DISPLAY_REF`::
 	Colon-delimited list of refs or globs indicating which refs,
 	in addition to the default from `core.notesRef` or
-	'GIT_NOTES_REF', to read notes from when showing commit
+	`GIT_NOTES_REF`, to read notes from when showing commit
 	messages.
 	This overrides the `notes.displayRef` setting.
 +
 A warning will be issued for refs that do not exist, but a glob that
 does not match any refs is silently ignored.
 
-'GIT_NOTES_REWRITE_MODE'::
+`GIT_NOTES_REWRITE_MODE`::
 	When copying notes during a rewrite, what to do if the target
 	commit already has a note.
 	Must be one of `overwrite`, `concatenate`, `cat_sort_uniq`, or `ignore`.
 	This overrides the `core.rewriteMode` setting.
 
-'GIT_NOTES_REWRITE_REF'::
+`GIT_NOTES_REWRITE_REF`::
 	When rewriting commits, which notes to copy from the original
 	to the rewritten commit.  Must be a colon-delimited list of
 	refs or globs.
diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 88ba42b..3385409 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -166,7 +166,7 @@ General options
 All commands except clone accept these options.
 
 --git-dir <dir>::
-	Set the 'GIT_DIR' environment variable.  See linkgit:git[1].
+	Set the `GIT_DIR` environment variable.  See linkgit:git[1].
 
 -v::
 --verbose::
diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index 8fff598..e5c57ae 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -51,7 +51,7 @@ $ git cat-file commit foo
 
 shows information about commit 'bar'.
 
-The 'GIT_NO_REPLACE_OBJECTS' environment variable can be set to
+The `GIT_NO_REPLACE_OBJECTS` environment variable can be set to
 achieve the same effect as the `--no-replace-objects` option.
 
 OPTIONS
diff --git a/Documentation/git.txt b/Documentation/git.txt
index dd6dbf7..48f5bf7 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -821,46 +821,46 @@ These environment variables apply to 'all' core Git commands. Nb: it
 is worth noting that they may be used/overridden by SCMS sitting above
 Git so take care if using a foreign front-end.
 
-'GIT_INDEX_FILE'::
+`GIT_INDEX_FILE`::
 	This environment allows the specification of an alternate
 	index file. If not specified, the default of `$GIT_DIR/index`
 	is used.
 
-'GIT_INDEX_VERSION'::
+`GIT_INDEX_VERSION`::
 	This environment variable allows the specification of an index
 	version for new repositories.  It won't affect existing index
 	files.  By default index file version 2 or 3 is used. See
 	linkgit:git-update-index[1] for more information.
 
-'GIT_OBJECT_DIRECTORY'::
+`GIT_OBJECT_DIRECTORY`::
 	If the object storage directory is specified via this
 	environment variable then the sha1 directories are created
 	underneath - otherwise the default `$GIT_DIR/objects`
 	directory is used.
 
-'GIT_ALTERNATE_OBJECT_DIRECTORIES'::
+`GIT_ALTERNATE_OBJECT_DIRECTORIES`::
 	Due to the immutable nature of Git objects, old objects can be
 	archived into shared, read-only directories. This variable
 	specifies a ":" separated (on Windows ";" separated) list
 	of Git object directories which can be used to search for Git
 	objects. New objects will not be written to these directories.
 
-'GIT_DIR'::
-	If the 'GIT_DIR' environment variable is set then it
+`GIT_DIR`::
+	If the `GIT_DIR` environment variable is set then it
 	specifies a path to use instead of the default `.git`
 	for the base of the repository.
 	The '--git-dir' command-line option also sets this value.
 
-'GIT_WORK_TREE'::
+`GIT_WORK_TREE`::
 	Set the path to the root of the working tree.
 	This can also be controlled by the '--work-tree' command-line
 	option and the core.worktree configuration variable.
 
-'GIT_NAMESPACE'::
+`GIT_NAMESPACE`::
 	Set the Git namespace; see linkgit:gitnamespaces[7] for details.
 	The '--namespace' command-line option also sets this value.
 
-'GIT_CEILING_DIRECTORIES'::
+`GIT_CEILING_DIRECTORIES`::
 	This should be a colon-separated list of absolute paths.  If
 	set, it is a list of directories that Git should not chdir up
 	into while looking for a repository directory (useful for
@@ -873,19 +873,19 @@ Git so take care if using a foreign front-end.
 	can add an empty entry to the list to tell Git that the
 	subsequent entries are not symlinks and needn't be resolved;
 	e.g.,
-	'GIT_CEILING_DIRECTORIES=/maybe/symlink::/very/slow/non/symlink'.
+	`GIT_CEILING_DIRECTORIES=/maybe/symlink::/very/slow/non/symlink`.
 
-'GIT_DISCOVERY_ACROSS_FILESYSTEM'::
+`GIT_DISCOVERY_ACROSS_FILESYSTEM`::
 	When run in a directory that does not have ".git" repository
 	directory, Git tries to find such a directory in the parent
 	directories to find the top of the working tree, but by default it
 	does not cross filesystem boundaries.  This environment variable
 	can be set to true to tell Git not to stop at filesystem
-	boundaries.  Like 'GIT_CEILING_DIRECTORIES', this will not affect
-	an explicit repository directory set via 'GIT_DIR' or on the
+	boundaries.  Like `GIT_CEILING_DIRECTORIES`, this will not affect
+	an explicit repository directory set via `GIT_DIR` or on the
 	command line.
 
-'GIT_COMMON_DIR'::
+`GIT_COMMON_DIR`::
 	If this variable is set to a path, non-worktree files that are
 	normally in $GIT_DIR will be taken from this path
 	instead. Worktree-specific files such as HEAD or index are
@@ -896,28 +896,28 @@ Git so take care if using a foreign front-end.
 
 Git Commits
 ~~~~~~~~~~~
-'GIT_AUTHOR_NAME'::
-'GIT_AUTHOR_EMAIL'::
-'GIT_AUTHOR_DATE'::
-'GIT_COMMITTER_NAME'::
-'GIT_COMMITTER_EMAIL'::
-'GIT_COMMITTER_DATE'::
+`GIT_AUTHOR_NAME`::
+`GIT_AUTHOR_EMAIL`::
+`GIT_AUTHOR_DATE`::
+`GIT_COMMITTER_NAME`::
+`GIT_COMMITTER_EMAIL`::
+`GIT_COMMITTER_DATE`::
 'EMAIL'::
 	see linkgit:git-commit-tree[1]
 
 Git Diffs
 ~~~~~~~~~
-'GIT_DIFF_OPTS'::
+`GIT_DIFF_OPTS`::
 	Only valid setting is "--unified=??" or "-u??" to set the
 	number of context lines shown when a unified diff is created.
 	This takes precedence over any "-U" or "--unified" option
 	value passed on the Git diff command line.
 
-'GIT_EXTERNAL_DIFF'::
-	When the environment variable 'GIT_EXTERNAL_DIFF' is set, the
+`GIT_EXTERNAL_DIFF`::
+	When the environment variable `GIT_EXTERNAL_DIFF` is set, the
 	program named by it is called, instead of the diff invocation
 	described above.  For a path that is added, removed, or modified,
-        'GIT_EXTERNAL_DIFF' is called with 7 parameters:
+        `GIT_EXTERNAL_DIFF` is called with 7 parameters:
 
 	path old-file old-hex old-mode new-file new-hex new-mode
 +
@@ -931,42 +931,42 @@ where:
 The file parameters can point at the user's working file
 (e.g. `new-file` in "git-diff-files"), `/dev/null` (e.g. `old-file`
 when a new file is added), or a temporary file (e.g. `old-file` in the
-index).  'GIT_EXTERNAL_DIFF' should not worry about unlinking the
-temporary file --- it is removed when 'GIT_EXTERNAL_DIFF' exits.
+index).  `GIT_EXTERNAL_DIFF` should not worry about unlinking the
+temporary file --- it is removed when `GIT_EXTERNAL_DIFF` exits.
 +
-For a path that is unmerged, 'GIT_EXTERNAL_DIFF' is called with 1
+For a path that is unmerged, `GIT_EXTERNAL_DIFF` is called with 1
 parameter, <path>.
 +
-For each path 'GIT_EXTERNAL_DIFF' is called, two environment variables,
-'GIT_DIFF_PATH_COUNTER' and 'GIT_DIFF_PATH_TOTAL' are set.
+For each path `GIT_EXTERNAL_DIFF` is called, two environment variables,
+`GIT_DIFF_PATH_COUNTER` and `GIT_DIFF_PATH_TOTAL` are set.
 
-'GIT_DIFF_PATH_COUNTER'::
+`GIT_DIFF_PATH_COUNTER`::
 	A 1-based counter incremented by one for every path.
 
-'GIT_DIFF_PATH_TOTAL'::
+`GIT_DIFF_PATH_TOTAL`::
 	The total number of paths.
 
 other
 ~~~~~
-'GIT_MERGE_VERBOSITY'::
+`GIT_MERGE_VERBOSITY`::
 	A number controlling the amount of output shown by
 	the recursive merge strategy.  Overrides merge.verbosity.
 	See linkgit:git-merge[1]
 
-'GIT_PAGER'::
+`GIT_PAGER`::
 	This environment variable overrides `$PAGER`. If it is set
 	to an empty string or to the value "cat", Git will not launch
 	a pager.  See also the `core.pager` option in
 	linkgit:git-config[1].
 
-'GIT_EDITOR'::
+`GIT_EDITOR`::
 	This environment variable overrides `$EDITOR` and `$VISUAL`.
 	It is used by several Git commands when, on interactive mode,
 	an editor is to be launched. See also linkgit:git-var[1]
 	and the `core.editor` option in linkgit:git-config[1].
 
-'GIT_SSH'::
-'GIT_SSH_COMMAND'::
+`GIT_SSH`::
+`GIT_SSH_COMMAND`::
 	If either of these environment variables is set then 'git fetch'
 	and 'git push' will use the specified command instead of 'ssh'
 	when they need to connect to a remote system.
@@ -986,18 +986,18 @@ Usually it is easier to configure any desired options through your
 personal `.ssh/config` file.  Please consult your ssh documentation
 for further details.
 
-'GIT_ASKPASS'::
+`GIT_ASKPASS`::
 	If this environment variable is set, then Git commands which need to
 	acquire passwords or passphrases (e.g. for HTTP or IMAP authentication)
 	will call this program with a suitable prompt as command-line argument
 	and read the password from its STDOUT. See also the 'core.askPass'
 	option in linkgit:git-config[1].
 
-'GIT_TERMINAL_PROMPT'::
+`GIT_TERMINAL_PROMPT`::
 	If this environment variable is set to `0`, git will not prompt
 	on the terminal (e.g., when asking for HTTP authentication).
 
-'GIT_CONFIG_NOSYSTEM'::
+`GIT_CONFIG_NOSYSTEM`::
 	Whether to skip reading settings from the system-wide
 	`$(prefix)/etc/gitconfig` file.  This environment variable can
 	be used along with `$HOME` and `$XDG_CONFIG_HOME` to create a
@@ -1005,7 +1005,7 @@ for further details.
 	temporarily to avoid using a buggy `/etc/gitconfig` file while
 	waiting for someone with sufficient permissions to fix it.
 
-'GIT_FLUSH'::
+`GIT_FLUSH`::
 	If this environment variable is set to "1", then commands such
 	as 'git blame' (in incremental mode), 'git rev-list', 'git log',
 	'git check-attr' and 'git check-ignore' will
@@ -1016,7 +1016,7 @@ for further details.
 	not set, Git will choose buffered or record-oriented flushing
 	based on whether stdout appears to be redirected to a file or not.
 
-'GIT_TRACE'::
+`GIT_TRACE`::
 	Enables general trace messages, e.g. alias expansion, built-in
 	command execution and external command execution.
 +
@@ -1037,21 +1037,21 @@ into it.
 Unsetting the variable, or setting it to empty, "0" or
 "false" (case insensitive) disables trace messages.
 
-'GIT_TRACE_PACK_ACCESS'::
+`GIT_TRACE_PACK_ACCESS`::
 	Enables trace messages for all accesses to any packs. For each
 	access, the pack file name and an offset in the pack is
 	recorded. This may be helpful for troubleshooting some
 	pack-related performance problems.
-	See 'GIT_TRACE' for available trace output options.
+	See `GIT_TRACE` for available trace output options.
 
-'GIT_TRACE_PACKET'::
+`GIT_TRACE_PACKET`::
 	Enables trace messages for all packets coming in or out of a
 	given program. This can help with debugging object negotiation
 	or other protocol issues. Tracing is turned off at a packet
-	starting with "PACK" (but see 'GIT_TRACE_PACKFILE' below).
-	See 'GIT_TRACE' for available trace output options.
+	starting with "PACK" (but see `GIT_TRACE_PACKFILE` below).
+	See `GIT_TRACE` for available trace output options.
 
-'GIT_TRACE_PACKFILE'::
+`GIT_TRACE_PACKFILE`::
 	Enables tracing of packfiles sent or received by a
 	given program. Unlike other trace output, this trace is
 	verbatim: no headers, and no quoting of binary data. You almost
@@ -1062,22 +1062,22 @@ Unsetting the variable, or setting it to empty, "0" or
 Note that this is currently only implemented for the client side
 of clones and fetches.
 
-'GIT_TRACE_PERFORMANCE'::
+`GIT_TRACE_PERFORMANCE`::
 	Enables performance related trace messages, e.g. total execution
 	time of each Git command.
-	See 'GIT_TRACE' for available trace output options.
+	See `GIT_TRACE` for available trace output options.
 
-'GIT_TRACE_SETUP'::
+`GIT_TRACE_SETUP`::
 	Enables trace messages printing the .git, working tree and current
 	working directory after Git has completed its setup phase.
-	See 'GIT_TRACE' for available trace output options.
+	See `GIT_TRACE` for available trace output options.
 
-'GIT_TRACE_SHALLOW'::
+`GIT_TRACE_SHALLOW`::
 	Enables trace messages that can help debugging fetching /
 	cloning of shallow repositories.
-	See 'GIT_TRACE' for available trace output options.
+	See `GIT_TRACE` for available trace output options.
 
-'GIT_LITERAL_PATHSPECS'::
+`GIT_LITERAL_PATHSPECS`::
 	Setting this variable to `1` will cause Git to treat all
 	pathspecs literally, rather than as glob patterns. For example,
 	running `GIT_LITERAL_PATHSPECS=1 git log -- '*.c'` will search
@@ -1086,19 +1086,19 @@ of clones and fetches.
 	literal paths to Git (e.g., paths previously given to you by
 	`git ls-tree`, `--raw` diff output, etc).
 
-'GIT_GLOB_PATHSPECS'::
+`GIT_GLOB_PATHSPECS`::
 	Setting this variable to `1` will cause Git to treat all
 	pathspecs as glob patterns (aka "glob" magic).
 
-'GIT_NOGLOB_PATHSPECS'::
+`GIT_NOGLOB_PATHSPECS`::
 	Setting this variable to `1` will cause Git to treat all
 	pathspecs as literal (aka "literal" magic).
 
-'GIT_ICASE_PATHSPECS'::
+`GIT_ICASE_PATHSPECS`::
 	Setting this variable to `1` will cause Git to treat all
 	pathspecs as case-insensitive.
 
-'GIT_REFLOG_ACTION'::
+`GIT_REFLOG_ACTION`::
 	When a ref is updated, reflog entries are created to keep
 	track of the reason why the ref was updated (which is
 	typically the name of the high-level command that updated
@@ -1108,7 +1108,7 @@ of clones and fetches.
 	variable when it is invoked as the top level command by the
 	end user, to be recorded in the body of the reflog.
 
-'GIT_REF_PARANOIA'::
+`GIT_REF_PARANOIA`::
 	If set to `1`, include broken or badly named refs when iterating
 	over lists of refs. In a normal, non-corrupted repository, this
 	does nothing. However, enabling it may help git to detect and
@@ -1119,7 +1119,7 @@ of clones and fetches.
 	an operation has touched every ref (e.g., because you are
 	cloning a repository to make a backup).
 
-'GIT_ALLOW_PROTOCOL'::
+`GIT_ALLOW_PROTOCOL`::
 	If set, provide a colon-separated list of protocols which are
 	allowed to be used with fetch/push/clone. This is useful to
 	restrict recursive submodule initialization from an untrusted
diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 78e0b27..e279327 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -43,7 +43,7 @@ arguments. The first argument specifies a remote repository as in Git;
 it is either the name of a configured remote or a URL. The second
 argument specifies a URL; it is usually of the form
 '<transport>://<address>', but any arbitrary string is possible.
-The 'GIT_DIR' environment variable is set up for the remote helper
+The `GIT_DIR` environment variable is set up for the remote helper
 and can be used to determine where to store additional data or from
 which directory to invoke auxiliary Git commands.
 
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index cd9c895..96156e5 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -206,8 +206,8 @@ $export_auth_hook = sub {
 Per-repository gitweb configuration
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 You can configure individual repositories shown in gitweb by creating file
-in the 'GIT_DIR' of Git repository, or by setting some repo configuration
-variable (in 'GIT_DIR/config', see linkgit:git-config[1]).
+in the `GIT_DIR` of Git repository, or by setting some repo configuration
+variable (in `GIT_DIR/config`, see linkgit:git-config[1]).
 
 You can use the following files in repository:
 
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 002ca58..df3ea37 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -61,7 +61,7 @@ merge.verbosity::
 	message if conflicts were detected. Level 1 outputs only
 	conflicts, 2 outputs conflicts and file changes.  Level 5 and
 	above outputs debugging information.  The default is level 2.
-	Can be overridden by the 'GIT_MERGE_VERBOSITY' environment variable.
+	Can be overridden by the `GIT_MERGE_VERBOSITY` environment variable.
 
 merge.<driver>.name::
 	Defines a human-readable name for a custom low-level
-- 
2.8.3
