Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02D2F20248
	for <e@80x24.org>; Wed,  6 Mar 2019 13:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfCFNGN (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 08:06:13 -0500
Received: from cisrsmtp.univ-lyon1.fr ([134.214.188.146]:60858 "EHLO
        cisrsmtp.univ-lyon1.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbfCFNGN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 08:06:13 -0500
Received: from localhost (localhost [127.0.0.1])
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTP id C92B9A020F
        for <git@vger.kernel.org>; Wed,  6 Mar 2019 14:06:09 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at cisrsmtp.univ-lyon1.fr
Received: from cisrsmtp.univ-lyon1.fr ([127.0.0.1])
        by localhost (cisrsmtp.univ-lyon1.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5UWOD0zYlrkS for <git@vger.kernel.org>;
        Wed,  6 Mar 2019 14:06:06 +0100 (CET)
Received: from BEMBX2013-01.univ-lyon1.fr (bembx2013-01.univ-lyon1.fr [134.214.201.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTPS id 07151A0158
        for <git@vger.kernel.org>; Wed,  6 Mar 2019 14:06:06 +0100 (CET)
Received: from Corentin-Linux.lan (134.214.126.172) by
 BEMBX2013-01.univ-lyon1.fr (134.214.201.247) with Microsoft SMTP Server (TLS)
 id 15.0.1263.5; Wed, 6 Mar 2019 14:05:47 +0100
From:   Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
To:     <git@vger.kernel.org>
CC:     <corentin.bompard@etu.univ-lyon1.fr>,
        <nathan.berbezier@etu.univ-lyon1.fr>,
        <pablo.chabanne@etu.univ-lyon1.fr>, <matthieu.moy@univ-lyon1.fr>
Subject: [PATCH 2/2 v3] doc: format pathnames and URLs as monospace.
Date:   Wed, 6 Mar 2019 14:04:46 +0100
Message-ID: <20190306130446.2193-2-corentin.bompard@etu.univ-lyon1.fr>
X-Mailer: git-send-email 2.21.0-rc0
In-Reply-To: <20190306130446.2193-1-corentin.bompard@etu.univ-lyon1.fr>
References: <20190306130446.2193-1-corentin.bompard@etu.univ-lyon1.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [134.214.126.172]
X-ClientProxiedBy: BPMBX2013-01.univ-lyon1.fr (134.214.201.243) To
 BEMBX2013-01.univ-lyon1.fr (134.214.201.247)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Applying CodingGuidelines about monospace on pathnames and URLs.

See Documentation/CodingGuidelines.txt for more information.

Signed-off-by: Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
Signed-off-by: Nathan BERBEZIER <nathan.berbezier@etu.univ-lyon1.fr>
Signed-off-by: Pablo CHABANNE <pablo.chabanne@etu.univ-lyon1.fr>
Signed-off-by: Matthieu MOY <matthieu.moy@univ-lyon1.fr>
---
 Changes: We listen to Matthieu MOY and Eric SUNSHINE's remarks about
 our mistakes on the last patch.

 Documentation/SubmittingPatches               |  6 +--
 Documentation/config/core.txt                 | 14 +++----
 Documentation/git-daemon.txt                  |  2 +-
 Documentation/git-filter-branch.txt           |  2 +-
 Documentation/git-help.txt                    |  4 +-
 Documentation/git-ls-tree.txt                 |  4 +-
 Documentation/git-remote-ext.txt              |  2 +-
 Documentation/git-submodule.txt               |  2 +-
 Documentation/git-web--browse.txt             |  4 +-
 Documentation/gitk.txt                        |  8 ++--
 Documentation/gitmodules.txt                  |  2 +-
 Documentation/gitrepository-layout.txt        |  2 +-
 Documentation/gitweb.conf.txt                 | 30 +++++++--------
 Documentation/gitweb.txt                      | 38 +++++++++----------
 .../howto/setup-git-server-over-http.txt      |  4 +-
 Documentation/revisions.txt                   |  4 +-
 Documentation/sequencer.txt                   |  2 +-
 17 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index ec8b20514..6d589e118 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -372,15 +372,15 @@ such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".
 Some parts of the system have dedicated maintainers with their own
 repositories.
 
-- 'git-gui/' comes from git-gui project, maintained by Pat Thoyts:
+- `git-gui/` comes from git-gui project, maintained by Pat Thoyts:
 
 	git://repo.or.cz/git-gui.git
 
-- 'gitk-git/' comes from Paul Mackerras's gitk project:
+- `gitk-git/` comes from Paul Mackerras's gitk project:
 
 	git://ozlabs.org/~paulus/gitk
 
-- 'po/' comes from the localization coordinator, Jiang Xin:
+- `po/` comes from the localization coordinator, Jiang Xin:
 
 	https://github.com/git-l10n/git-po/
 
diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 7e9b6c8f4..75538d27e 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -414,7 +414,7 @@ Common unit suffixes of 'k', 'm', or 'g' are supported.
 core.excludesFile::
 	Specifies the pathname to the file that contains patterns to
 	describe paths that are not meant to be tracked, in addition
-	to '.gitignore' (per-directory) and '.git/info/exclude'.
+	to `.gitignore` (per-directory) and `.git/info/exclude`.
 	Defaults to `$XDG_CONFIG_HOME/git/ignore`.
 	If `$XDG_CONFIG_HOME` is either not set or empty, `$HOME/.config/git/ignore`
 	is used instead. See linkgit:gitignore[5].
@@ -429,8 +429,8 @@ core.askPass::
 	command-line argument and write the password on its STDOUT.
 
 core.attributesFile::
-	In addition to '.gitattributes' (per-directory) and
-	'.git/info/attributes', Git looks into this file for attributes
+	In addition to `.gitattributes` (per-directory) and
+	`.git/info/attributes`, Git looks into this file for attributes
 	(see linkgit:gitattributes[5]). Path expansions are made the same
 	way as for `core.excludesFile`. Its default value is
 	`$XDG_CONFIG_HOME/git/attributes`. If `$XDG_CONFIG_HOME` is either not
@@ -438,10 +438,10 @@ core.attributesFile::
 
 core.hooksPath::
 	By default Git will look for your hooks in the
-	'$GIT_DIR/hooks' directory. Set this to different path,
-	e.g. '/etc/git/hooks', and Git will try to find your hooks in
-	that directory, e.g. '/etc/git/hooks/pre-receive' instead of
-	in '$GIT_DIR/hooks/pre-receive'.
+	`$GIT_DIR/hooks` directory. Set this to different path,
+	e.g. `/etc/git/hooks`, and Git will try to find your hooks in
+	that directory, e.g. `/etc/git/hooks/pre-receive` instead of
+	in `$GIT_DIR/hooks/pre-receive`.
 +
 The path can be either absolute or relative. A relative path is
 taken as relative to the directory where the hooks are run (see
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 56d54a489..fdc28c041 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -57,7 +57,7 @@ OPTIONS
 	This is sort of "Git root" - if you run 'git daemon' with
 	'--base-path=/srv/git' on example.com, then if you later try to pull
 	'git://example.com/hello.git', 'git daemon' will interpret the path
-	as '/srv/git/hello.git'.
+	as `/srv/git/hello.git`.
 
 --base-path-relaxed::
 	If --base-path is enabled and repo lookup fails, with this option
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index e6f08ab18..6b53dd7e0 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -189,7 +189,7 @@ to other tags will be rewritten to point to the underlying commit.
 	rewriting.  When applying a tree filter, the command needs to
 	temporarily check out the tree to some directory, which may consume
 	considerable space in case of large projects.  By default it
-	does this in the '.git-rewrite/' directory but you can override
+	does this in the `.git-rewrite/` directory but you can override
 	that choice by this parameter.
 
 -f::
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index c318bf87e..f71db0daa 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -171,8 +171,8 @@ variable, we launch 'kfmclient' to try to open the man page on an
 already opened konqueror in a new tab if possible.
 
 For consistency, we also try such a trick if 'man.konqueror.path' is
-set to something like 'A_PATH_TO/konqueror'. That means we will try to
-launch 'A_PATH_TO/kfmclient' instead.
+set to something like `A_PATH_TO/konqueror`. That means we will try to
+launch `A_PATH_TO/kfmclient` instead.
 
 If you really want to use 'konqueror', then you can use something like
 the following:
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 9dee7bef3..a7515714d 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -27,9 +27,9 @@ in the current working directory.  Note that:
    taken as relative to the current working directory.  E.g. when you are
    in a directory 'sub' that has a directory 'dir', you can run 'git
    ls-tree -r HEAD dir' to list the contents of the tree (that is
-   'sub/dir' in `HEAD`).  You don't want to give a tree that is not at the
+   `sub/dir` in `HEAD`).  You don't want to give a tree that is not at the
    root level (e.g. `git ls-tree -r HEAD:sub dir`) in this case, as that
-   would result in asking for 'sub/sub/dir' in the `HEAD` commit.
+   would result in asking for `sub/sub/dir` in the `HEAD` commit.
    However, the current working directory can be ignored by passing
    --full-tree option.
 
diff --git a/Documentation/git-remote-ext.txt b/Documentation/git-remote-ext.txt
index 3fc5d9433..6ccffa1c1 100644
--- a/Documentation/git-remote-ext.txt
+++ b/Documentation/git-remote-ext.txt
@@ -104,7 +104,7 @@ begins with `ext::`.  Examples:
 	link-level address).
 
 "ext::git-server-alias foo %G/repo% with% spaces %Vfoo"::
-	Represents a repository with path '/repo with spaces' accessed
+	Represents a repository with path `/repo with spaces` accessed
 	using the helper program "git-server-alias foo".  The hostname for
 	the remote server passed in the protocol stream will be "foo"
 	(this allows multiple virtual Git servers to share a
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index ba3c4df55..764bcf13e 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -38,7 +38,7 @@ This may be either an absolute URL, or (if it begins with ./
 or ../), the location relative to the superproject's default remote
 repository (Please note that to specify a repository 'foo.git'
 which is located right next to a superproject 'bar.git', you'll
-have to use '../foo.git' instead of './foo.git' - as one might expect
+have to use `../foo.git` instead of `./foo.git` - as one might expect
 when following the rules for relative URLs - because the evaluation
 of relative URLs in Git is identical to that of relative directories).
 +
diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index fd952a5ff..8d162b56c 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -92,8 +92,8 @@ configuration variable, we launch 'kfmclient' to try to open the HTML
 man page on an already opened konqueror in a new tab if possible.
 
 For consistency, we also try such a trick if 'browser.konqueror.path' is
-set to something like 'A_PATH_TO/konqueror'. That means we will try to
-launch 'A_PATH_TO/kfmclient' instead.
+set to something like `A_PATH_TO/konqueror`. That means we will try to
+launch `A_PATH_TO/kfmclient` instead.
 
 If you really want to use 'konqueror', then you can use something like
 the following:
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 244cd0149..1eabb0aaf 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -168,12 +168,12 @@ Files
 -----
 User configuration and preferences are stored at:
 
-* '$XDG_CONFIG_HOME/git/gitk' if it exists, otherwise
-* '$HOME/.gitk' if it exists
+* `$XDG_CONFIG_HOME/git/gitk` if it exists, otherwise
+* `$HOME/.gitk` if it exists
 
-If neither of the above exist then '$XDG_CONFIG_HOME/git/gitk' is created and
+If neither of the above exist then `$XDG_CONFIG_HOME/git/gitk` is created and
 used by default. If '$XDG_CONFIG_HOME' is not set it defaults to
-'$HOME/.config' in all cases.
+`$HOME/.config` in all cases.
 
 History
 -------
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 312b6f925..a66e95b70 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -115,7 +115,7 @@ Consider the following .gitmodules file:
 
 
 This defines two submodules, `libfoo` and `libbar`. These are expected to
-be checked out in the paths 'include/foo' and 'include/bar', and for both
+be checked out in the paths `include/foo` and `include/bar`, and for both
 submodules a URL is specified which can be used for cloning the submodules.
 
 SEE ALSO
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index 366dee238..216b11ee8 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -84,7 +84,7 @@ objects/info/alternates::
 	to the object database, not to the repository!) in your
 	alternates file, but it will not work if you use absolute
 	paths unless the absolute path in filesystem and web URL
-	is the same. See also 'objects/info/http-alternates'.
+	is the same. See also `objects/info/http-alternates`.
 
 objects/info/http-alternates::
 	This file records URLs to alternate object stores that
diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index 92535dbac..18e1b6ad4 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -50,11 +50,11 @@ following order:
  * built-in values (some set during build stage),
 
  * common system-wide configuration file (defaults to
-   '/etc/gitweb-common.conf'),
+   `/etc/gitweb-common.conf`),
 
  * either per-instance configuration file (defaults to 'gitweb_config.perl'
    in the same directory as the installed gitweb), or if it does not exists
-   then fallback system-wide configuration file (defaults to '/etc/gitweb.conf').
+   then fallback system-wide configuration file (defaults to `/etc/gitweb.conf`).
 
 Values obtained in later configuration files override values obtained earlier
 in the above sequence.
@@ -82,7 +82,7 @@ You can include other configuration file using read_config_file()
 subroutine.  For example, one might want to put gitweb configuration
 related to access control for viewing repositories via Gitolite (one
 of Git repository management tools) in a separate file, e.g. in
-'/etc/gitweb-gitolite.conf'.  To include it, put
+`/etc/gitweb-gitolite.conf`.  To include it, put
 
 --------------------------------------------------
 read_config_file("/etc/gitweb-gitolite.conf");
@@ -142,7 +142,7 @@ and its path_info based equivalent
 http://git.example.com/gitweb.cgi/foo/bar.git
 ------------------------------------------------
 +
-will map to the path '/srv/git/foo/bar.git' on the filesystem.
+will map to the path `/srv/git/foo/bar.git` on the filesystem.
 
 $projects_list::
 	Name of a plain text file listing projects, or a name of directory
@@ -234,9 +234,9 @@ $GIT::
 
 $mimetypes_file::
 	File to use for (filename extension based) guessing of MIME types before
-	trying '/etc/mime.types'.  *NOTE* that this path, if relative, is taken
+	trying `/etc/mime.types`.  *NOTE* that this path, if relative, is taken
 	as relative to the current Git repository, not to CGI script.  If unset,
-	only '/etc/mime.types' is used (if present on filesystem).  If no mimetypes
+	only `/etc/mime.types` is used (if present on filesystem).  If no mimetypes
 	file is found, mimetype guessing based on extension of file is disabled.
 	Unset by default.
 
@@ -297,8 +297,8 @@ relative to base URI of gitweb.
 +
 This list should contain the URI of gitweb's standard stylesheet.  The default
 URI of gitweb stylesheet can be set at build time using the `GITWEB_CSS`
-makefile variable.  Its default value is 'static/gitweb.css'
-(or 'static/gitweb.min.css' if the `CSSMIN` variable is defined,
+makefile variable.  Its default value is `static/gitweb.css`
+(or `static/gitweb.min.css` if the `CSSMIN` variable is defined,
 i.e. if CSS minifier is used during build).
 +
 *Note*: there is also a legacy `$stylesheet` configuration variable, which was
@@ -311,7 +311,7 @@ $logo::
 	is displayed in the top right corner of each gitweb page and used as
 	a logo for the Atom feed.  Relative to the base URI of gitweb (as a path).
 	Can be adjusted when building gitweb using `GITWEB_LOGO` variable
-	By default set to 'static/git-logo.png'.
+	By default set to `static/git-logo.png`.
 
 $favicon::
 	Points to the location where you put 'git-favicon.png' on your web
@@ -320,7 +320,7 @@ $favicon::
 	may display them in the browser's URL bar and next to the site name in
 	bookmarks.  Relative to the base URI of gitweb.  Can be adjusted at
 	build time using `GITWEB_FAVICON` variable.
-	By default set to 'static/git-favicon.png'.
+	By default set to `static/git-favicon.png`.
 
 $javascript::
 	Points to the location where you put 'gitweb.js' on your web server,
@@ -328,7 +328,7 @@ $javascript::
 	Relative to the base URI of gitweb.  Can be set at build time using
 	the `GITWEB_JS` build-time configuration variable.
 +
-The default value is either 'static/gitweb.js', or 'static/gitweb.min.js' if
+The default value is either `static/gitweb.js`, or `static/gitweb.min.js` if
 the `JSMIN` build variable was defined, i.e. if JavaScript minifier was used
 at build time.  *Note* that this single file is generated from multiple
 individual JavaScript "modules".
@@ -444,7 +444,7 @@ $default_blob_plain_mimetype::
 	doesn't result in some other type; by default "text/plain".
 	Gitweb guesses mimetype of a file to display based on extension
 	of its filename, using `$mimetypes_file` (if set and file exists)
-	and '/etc/mime.types' files (see *mime.types*(5) manpage; only
+	and `/etc/mime.types` files (see *mime.types*(5) manpage; only
 	filename extension rules are supported by gitweb).
 
 $default_text_plain_charset::
@@ -486,7 +486,7 @@ affects how "summary" pages look like, or load limiting).
 	(for example one for `git://` protocol, and one for `http://`
 	protocol).
 +
-Note that per repository configuration can be set in '$GIT_DIR/cloneurl'
+Note that per repository configuration can be set in `$GIT_DIR/cloneurl`
 file, or as values of multi-value `gitweb.url` configuration variable in
 project config.  Per-repository configuration takes precedence over value
 composed from `@git_base_url_list` elements and project name.
@@ -520,7 +520,7 @@ $maxload::
 	If the server load exceeds this value then gitweb will return
 	"503 Service Unavailable" error.  The server load is taken to be 0
 	if gitweb cannot determine its value.  Currently it works only on Linux,
-	where it uses '/proc/loadavg'; the load there is the number of active
+	where it uses `/proc/loadavg`; the load there is the number of active
 	tasks on the system -- processes that are actually running -- averaged
 	over the last minute.
 +
@@ -739,7 +739,7 @@ Currently available providers are *"gravatar"* and *"picon"*.
 Only one provider at a time can be selected ('default' is one element list).
 If an unknown provider is specified, the feature is disabled.
 *Note* that some providers might require extra Perl packages to be
-installed; see 'gitweb/INSTALL' for more details.
+installed; see `gitweb/INSTALL` for more details.
 +
 This feature can be configured on a per-repository basis via
 repository's `gitweb.avatar` configuration variable.
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index 88450589a..c7436098c 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -36,7 +36,7 @@ browsed using gitweb itself.
 CONFIGURATION
 -------------
 Various aspects of gitweb's behavior can be controlled through the configuration
-file 'gitweb_config.perl' or '/etc/gitweb.conf'.  See the linkgit:gitweb.conf[5]
+file `gitweb_config.perl` or `/etc/gitweb.conf`.  See the linkgit:gitweb.conf[5]
 for details.
 
 Repositories
@@ -51,7 +51,7 @@ projects' root" subsection).
 our $projectroot = '/path/to/parent/directory';
 -----------------------------------------------------------------------
 
-The default value for `$projectroot` is '/pub/git'.  You can change it during
+The default value for `$projectroot` is `/pub/git`.  You can change it during
 building gitweb via `GITWEB_PROJECTROOT` build configuration variable.
 
 By default all Git repositories under `$projectroot` are visible and available
@@ -231,7 +231,7 @@ Unnamed repository; edit this file to name it for gitweb.
 -------------------------------------------------------------------------------
 +
 from the template during repository creation, usually installed in
-'/usr/share/git-core/templates/'.  You can use the `gitweb.description` repo
+`/usr/share/git-core/templates/`.  You can use the `gitweb.description` repo
 configuration variable, but the file takes precedence.
 
 category (or `gitweb.category`)::
@@ -407,7 +407,7 @@ in the instructions so they can be included in a future release.
 Apache as CGI
 ~~~~~~~~~~~~~
 Apache must be configured to support CGI scripts in the directory in
-which gitweb is installed.  Let's assume that it is '/var/www/cgi-bin'
+which gitweb is installed.  Let's assume that it is `/var/www/cgi-bin`
 directory.
 
 -----------------------------------------------------------------------
@@ -431,7 +431,7 @@ You can use mod_perl with gitweb.  You must install Apache::Registry
 (for mod_perl 1.x) or ModPerl::Registry (for mod_perl 2.x) to enable
 this support.
 
-Assuming that gitweb is installed to '/var/www/perl', the following
+Assuming that gitweb is installed to `/var/www/perl`, the following
 Apache configuration (for mod_perl 2.x) is suitable.
 
 -----------------------------------------------------------------------
@@ -456,7 +456,7 @@ Apache with FastCGI
 ~~~~~~~~~~~~~~~~~~~
 Gitweb works with Apache and FastCGI.  First you need to rename, copy
 or symlink gitweb.cgi to gitweb.fcgi.  Let's assume that gitweb is
-installed in '/usr/share/gitweb' directory.  The following Apache
+installed in `/usr/share/gitweb` directory.  The following Apache
 configuration is suitable (UNTESTED!)
 
 -----------------------------------------------------------------------
@@ -503,22 +503,22 @@ repositories, you can configure Apache like this:
 -----------------------------------------------------------------------
 
 The above configuration expects your public repositories to live under
-'/pub/git' and will serve them as `http://git.domain.org/dir-under-pub-git`,
+`/pub/git` and will serve them as `http://git.domain.org/dir-under-pub-git`,
 both as clonable Git URL and as browseable gitweb interface.  If you then
 start your linkgit:git-daemon[1] with `--base-path=/pub/git --export-all`
 then you can even use the `git://` URL with exactly the same path.
 
 Setting the environment variable `GITWEB_CONFIG` will tell gitweb to use the
-named file (i.e. in this example '/etc/gitweb.conf') as a configuration for
+named file (i.e. in this example `/etc/gitweb.conf`) as a configuration for
 gitweb.  You don't really need it in above example; it is required only if
 your configuration file is in different place than built-in (during
-compiling gitweb) 'gitweb_config.perl' or '/etc/gitweb.conf'.  See
+compiling gitweb) 'gitweb_config.perl' or `/etc/gitweb.conf`.  See
 linkgit:gitweb.conf[5] for details, especially information about precedence
 rules.
 
 If you use the rewrite rules from the example you *might* also need
 something like the following in your gitweb configuration file
-('/etc/gitweb.conf' following example):
+(`/etc/gitweb.conf` following example):
 ----------------------------------------------------------------------------
 @stylesheets = ("/some/absolute/path/gitweb.css");
 $my_uri    = "/";
@@ -575,7 +575,7 @@ like this:
 
 Here actual project root is passed to gitweb via `GITWEB_PROJECT_ROOT`
 environment variable from a web server, so you need to put the following
-line in gitweb configuration file ('/etc/gitweb.conf' in above example):
+line in gitweb configuration file (`/etc/gitweb.conf` in above example):
 --------------------------------------------------------------------------
 $projectroot = $ENV{'GITWEB_PROJECTROOT'} || "/pub/git";
 --------------------------------------------------------------------------
@@ -585,7 +585,7 @@ referenced by `$per_request_config`;
 
 These configurations enable two things. First, each unix user (`<user>`) of
 the server will be able to browse through gitweb Git repositories found in
-'~/public_git/' with the following url:
+`~/public_git/` with the following url:
 
   http://git.example.org/~<user>/
 
@@ -596,7 +596,7 @@ If you already use `mod_userdir` in your virtual host or you don't want to
 use the \'~' as first character, just comment or remove the second rewrite
 rule, and uncomment one of the following according to what you want.
 
-Second, repositories found in '/pub/scm/' and '/var/git/' will be accessible
+Second, repositories found in `/pub/scm/` and `/var/git/` will be accessible
 through `http://git.example.org/scm/` and `http://git.example.org/var/`.
 You can add as many project roots as you want by adding rewrite rules like
 the third and the fourth.
@@ -614,7 +614,7 @@ that it consumes and produces URLs in the form
   http://git.example.com/project.git/shortlog/sometag
 
 i.e. without 'gitweb.cgi' part, by using a configuration such as the
-following.  This configuration assumes that '/var/www/gitweb' is the
+following.  This configuration assumes that `/var/www/gitweb` is the
 DocumentRoot of your webserver, contains the gitweb.cgi script and
 complementary static files (stylesheet, favicon, JavaScript):
 
@@ -645,9 +645,9 @@ parameter.
 `@stylesheets`, `$my_uri` and `$home_link`, but you lose "dumb client"
 access to your project .git dirs (described in "Single URL for gitweb and
 for fetching" section).  A possible workaround for the latter is the
-following: in your project root dir (e.g. '/pub/git') have the projects
-named *without* a .git extension (e.g. '/pub/git/project' instead of
-'/pub/git/project.git') and configure Apache as follows:
+following: in your project root dir (e.g. `/pub/git`) have the projects
+named *without* a .git extension (e.g. `/pub/git/project` instead of
+`/pub/git/project.git`) and configure Apache as follows:
 ----------------------------------------------------------------------------
 <VirtualHost *:80>
 	ServerAlias git.example.com
@@ -681,7 +681,7 @@ cloned), while
 will provide human-friendly gitweb access.
 
 This solution is not 100% bulletproof, in the sense that if some project has
-a named ref (branch, tag) starting with 'git/', then paths such as
+a named ref (branch, tag) starting with `git/`, then paths such as
 
   http://git.example.com/project/command/abranch..git/abranch
 
@@ -697,7 +697,7 @@ SEE ALSO
 --------
 linkgit:gitweb.conf[5], linkgit:git-instaweb[1]
 
-'gitweb/README', 'gitweb/INSTALL'
+`gitweb/README`, `gitweb/INSTALL`
 
 GIT
 ---
diff --git a/Documentation/howto/setup-git-server-over-http.txt b/Documentation/howto/setup-git-server-over-http.txt
index f44e5e945..bfe6f9b50 100644
--- a/Documentation/howto/setup-git-server-over-http.txt
+++ b/Documentation/howto/setup-git-server-over-http.txt
@@ -244,8 +244,8 @@ Using a proxy:
 --------------
 
 If you have to access the WebDAV server from behind an HTTP(S) proxy,
-set the variable 'all_proxy' to 'http://proxy-host.com:port', or
-'http://login-on-proxy:passwd-on-proxy@proxy-host.com:port'. See 'man
+set the variable 'all_proxy' to `http://proxy-host.com:port`, or
+`http://login-on-proxy:passwd-on-proxy@proxy-host.com:port`. See 'man
 curl' for details.
 
 
diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 72daa20e7..2337a995e 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -58,7 +58,7 @@ when you run `git merge`.
 when you run `git cherry-pick`.
 +
 Note that any of the 'refs/*' cases above may come either from
-the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
+the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
 While the ref name encoding is unspecified, UTF-8 is preferred as
 some output processing may assume ref names in UTF-8.
 
@@ -108,7 +108,7 @@ some output processing may assume ref names in UTF-8.
   `git push` were run while `branchname` was checked out (or the current
   `HEAD` if no branchname is specified). Since our push destination is
   in a remote repository, of course, we report the local tracking branch
-  that corresponds to that branch (i.e., something in 'refs/remotes/').
+  that corresponds to that branch (i.e., something in `refs/remotes/`).
 +
 Here's an example to make it more clear:
 +
diff --git a/Documentation/sequencer.txt b/Documentation/sequencer.txt
index 5747f442f..5a57c4a40 100644
--- a/Documentation/sequencer.txt
+++ b/Documentation/sequencer.txt
@@ -1,6 +1,6 @@
 --continue::
 	Continue the operation in progress using the information in
-	'.git/sequencer'.  Can be used to continue after resolving
+	`.git/sequencer`.  Can be used to continue after resolving
 	conflicts in a failed cherry-pick or revert.
 
 --quit::
-- 
2.21.0-rc0

