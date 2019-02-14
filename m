Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B0251F453
	for <e@80x24.org>; Thu, 14 Feb 2019 16:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407967AbfBNQcA (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 11:32:00 -0500
Received: from cisrsmtp.univ-lyon1.fr ([134.214.188.146]:59041 "EHLO
        cisrsmtp.univ-lyon1.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407943AbfBNQb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 11:31:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTP id E554BA004B
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 17:31:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at cisrsmtp.univ-lyon1.fr
Received: from cisrsmtp.univ-lyon1.fr ([127.0.0.1])
        by localhost (cisrsmtp.univ-lyon1.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id B0ae-WMIXUNN for <git@vger.kernel.org>;
        Thu, 14 Feb 2019 17:31:44 +0100 (CET)
Received: from BEMBX2013-01.univ-lyon1.fr (bembx2013-01.univ-lyon1.fr [134.214.201.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTPS id B7B19A003D
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 17:31:43 +0100 (CET)
Received: from Corentin-Linux.lan (134.214.126.172) by
 BEMBX2013-01.univ-lyon1.fr (134.214.201.247) with Microsoft SMTP Server (TLS)
 id 15.0.1263.5; Thu, 14 Feb 2019 17:31:43 +0100
From:   Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
To:     <git@vger.kernel.org>
CC:     <corentin.bompard@etu.univ-lyon1.fr>,
        <nathan.berbezier@etu.univ-lyon1.fr>,
        <pablo.chabanne@etu.univ-lyon1.fr>, <matthieu.moy@univ-lyon1.fr>
Subject: [PATCH] doc: format pathnames and URLs as monospace
Date:   Thu, 14 Feb 2019 17:30:43 +0100
Message-ID: <20190214163043.7103-1-corentin.bompard@etu.univ-lyon1.fr>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [134.214.126.172]
X-ClientProxiedBy: JPMBX2013-01.univ-lyon1.fr (134.214.201.245) To
 BEMBX2013-01.univ-lyon1.fr (134.214.201.247)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
---
 Documentation/SubmittingPatches                    |  6 ++--
 Documentation/config/checkout.txt                  |  2 +-
 Documentation/config/core.txt                      | 14 ++++----
 Documentation/config/log.txt                       |  4 +--
 Documentation/git-cvsserver.txt                    |  4 +--
 Documentation/git-daemon.txt                       |  2 +-
 Documentation/git-fast-export.txt                  |  2 +-
 Documentation/git-filter-branch.txt                |  8 ++---
 Documentation/git-help.txt                         |  4 +--
 Documentation/git-log.txt                          |  4 +--
 Documentation/git-ls-tree.txt                      |  4 +--
 Documentation/git-p4.txt                           | 26 +++++++-------
 Documentation/git-remote-ext.txt                   |  2 +-
 Documentation/git-remote.txt                       |  4 +--
 Documentation/git-show-ref.txt                     |  6 ++--
 Documentation/git-submodule.txt                    |  2 +-
 Documentation/git-web--browse.txt                  |  4 +--
 Documentation/gitk.txt                             |  8 ++---
 Documentation/gitmodules.txt                       |  2 +-
 Documentation/gitrepository-layout.txt             |  2 +-
 Documentation/gittutorial.txt                      |  2 +-
 Documentation/gitweb.conf.txt                      | 30 ++++++++--------
 Documentation/gitweb.txt                           | 40 +++++++++++-----------
 Documentation/glossary-content.txt                 |  4 +--
 Documentation/howto/maintain-git.txt               |  2 +-
 Documentation/howto/setup-git-server-over-http.txt |  4 +--
 Documentation/merge-options.txt                    |  2 +-
 Documentation/revisions.txt                        | 26 +++++++-------
 Documentation/sequencer.txt                        |  2 +-
 Documentation/technical/pack-protocol.txt          |  2 +-
 30 files changed, 112 insertions(+), 112 deletions(-)

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
 
diff --git a/Documentation/config/checkout.txt b/Documentation/config/checkout.txt
index c4118fa19..8ba92f274 100644
--- a/Documentation/config/checkout.txt
+++ b/Documentation/config/checkout.txt
@@ -1,7 +1,7 @@
 checkout.defaultRemote::
 	When you run 'git checkout <something>' and only have one
 	remote, it may implicitly fall back on checking out and
-	tracking e.g. 'origin/<something>'. This stops working as soon
+	tracking e.g. `origin/<something>`. This stops working as soon
 	as you have more than one remote with a '<something>'
 	reference. This setting allows for setting the name of a
 	preferred remote that should always win when it comes to
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
diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
index 78d9e4453..59b816afb 100644
--- a/Documentation/config/log.txt
+++ b/Documentation/config/log.txt
@@ -10,8 +10,8 @@ log.date::
 
 log.decorate::
 	Print out the ref names of any commits that are shown by the log
-	command. If 'short' is specified, the ref name prefixes 'refs/heads/',
-	'refs/tags/' and 'refs/remotes/' will not be printed. If 'full' is
+	command. If 'short' is specified, the ref name prefixes `refs/heads/`,
+	`refs/tags/` and `refs/remotes/` will not be printed. If 'full' is
 	specified, the full ref name (including prefix) will be printed.
 	If 'auto' is specified, then if the output is going to a terminal,
 	the ref names are shown as if 'short' were given, otherwise no ref
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index f98b7c6ed..6643bc39f 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -140,7 +140,7 @@ CVS_SERVER directly in CVSROOT like
 ------
 cvs -d ":ext;CVS_SERVER=git cvsserver:user@server/path/repo.git" co <HEAD_name>
 ------
-This has the advantage that it will be saved in your 'CVS/Root' files and
+This has the advantage that it will be saved in your `CVS/Root` files and
 you don't need to worry about always setting the correct environment
 variable.  SSH users restricted to 'git-shell' don't need to override the default
 with CVS_SERVER (and shouldn't) as 'git-shell' understands `cvs` to mean
@@ -179,7 +179,7 @@ allowing access over SSH.
 ------
 --
 3. If you didn't specify the CVSROOT/CVS_SERVER directly in the checkout command,
-   automatically saving it in your 'CVS/Root' files, then you need to set them
+   automatically saving it in your `CVS/Root` files, then you need to set them
    explicitly in your environment.  CVSROOT should be set as per normal, but the
    directory should point at the appropriate Git repo.  As above, for SSH clients
    _not_ restricted to 'git-shell', CVS_SERVER should be set to 'git-cvsserver'.
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
diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 64c01ba91..a734f45ab 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -164,7 +164,7 @@ This makes a new branch called 'other' from 'master~5..master'
 
 Note that this assumes that none of the blobs and commit messages
 referenced by that revision range contains the string
-'refs/heads/master'.
+`refs/heads/master`.
 
 
 ANONYMIZING
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index e6f08ab18..cef94c788 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -48,7 +48,7 @@ rewriting published history.)
 
 Always verify that the rewritten version is correct: The original refs,
 if different from the rewritten ones, will be stored in the namespace
-'refs/original/'.
+`refs/original/`.
 
 Note that since this operation is very I/O expensive, it might
 be a good idea to redirect the temporary directory off-disk with the
@@ -182,21 +182,21 @@ to other tags will be rewritten to point to the underlying commit.
 
 --original <namespace>::
 	Use this option to set the namespace where the original commits
-	will be stored. The default value is 'refs/original'.
+	will be stored. The default value is `refs/original`.
 
 -d <directory>::
 	Use this option to set the path to the temporary directory used for
 	rewriting.  When applying a tree filter, the command needs to
 	temporarily check out the tree to some directory, which may consume
 	considerable space in case of large projects.  By default it
-	does this in the '.git-rewrite/' directory but you can override
+	does this in the `.git-rewrite/` directory but you can override
 	that choice by this parameter.
 
 -f::
 --force::
 	'git filter-branch' refuses to start with an existing temporary
 	directory or when there are already refs starting with
-	'refs/original/', unless forced.
+	`refs/original/`, unless forced.
 
 --state-branch <branch>::
 	This option will cause the mapping from old to new objects to
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
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index b02e922dc..6e4867623 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -31,8 +31,8 @@ OPTIONS
 --no-decorate::
 --decorate[=short|full|auto|no]::
 	Print out the ref names of any commits that are shown. If 'short' is
-	specified, the ref name prefixes 'refs/heads/', 'refs/tags/' and
-	'refs/remotes/' will not be printed. If 'full' is specified, the
+	specified, the ref name prefixes `refs/heads/`, `refs/tags/` and
+	`refs/remotes/` will not be printed. If 'full' is specified, the
 	full ref name (including prefix) will be printed. If 'auto' is
 	specified, then if the output is going to a terminal, the ref names
 	are shown as if 'short' were given, otherwise no ref names are
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
 
diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 3494a1db3..88d7338d0 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -74,7 +74,7 @@ This:
 1. Creates an empty Git repository in a subdirectory called 'project'.
 +
 2. Imports the full contents of the head revision from the given p4
-   depot path into a single commit in the Git branch 'refs/remotes/p4/master'.
+   depot path into a single commit in the Git branch `refs/remotes/p4/master`.
 +
 3. Creates a local branch, 'master' from this remote and checks it out.
 
@@ -103,11 +103,11 @@ $ git init
 $ git p4 sync //path/in/your/perforce/depot
 ------------
 This imports the specified depot into
-'refs/remotes/p4/master' in an existing Git repository.  The
+`refs/remotes/p4/master` in an existing Git repository.  The
 `--branch` option can be used to specify a different branch to
 be used for the p4 content.
 
-If a Git repository includes branches 'refs/remotes/origin/p4', these
+If a Git repository includes branches `refs/remotes/origin/p4`, these
 will be fetched and consulted first during a 'git p4 sync'.  Since
 importing directly from p4 is considerably slower than pulling changes
 from a Git remote, this can be useful in a multi-developer environment.
@@ -139,7 +139,7 @@ variable 'git-p4.client'.  The p4 client must exist, but the client root
 will be created and populated if it does not already exist.
 
 To submit all changes that are in the current Git branch but not in
-the 'p4/master' branch, use:
+the `p4/master` branch, use:
 ------------
 $ git p4 submit
 ------------
@@ -155,7 +155,7 @@ $ git p4 submit --commit <sha1>
 $ git p4 submit --commit <sha1..sha1>
 ------------
 
-The upstream reference is generally 'refs/remotes/p4/master', but can
+The upstream reference is generally `refs/remotes/p4/master`, but can
 be overridden using the `--origin=` command-line option.
 
 The p4 changes will be created as the user invoking 'git p4 submit'. The
@@ -254,10 +254,10 @@ Git repository:
 	Import labels from p4 into Git.
 
 --import-local::
-	By default, p4 branches are stored in 'refs/remotes/p4/',
+	By default, p4 branches are stored in `refs/remotes/p4/`,
 	where they will be treated as remote-tracking branches by
 	linkgit:git-branch[1] and other commands.  This option instead
-	puts p4 branches in 'refs/heads/p4/'.  Note that future
+	puts p4 branches in `refs/heads/p4/`.  Note that future
 	sync operations must specify `--import-local` as well so that
 	they can find the p4 branches in refs/heads.
 
@@ -281,9 +281,9 @@ Git repository:
 	The mapping of file names from the p4 depot path to Git, by
 	default, involves removing the entire depot path.  With this
 	option, the full p4 depot path is retained in Git.  For example,
-	path '//depot/main/foo/bar.c', when imported from
-	'//depot/main/', becomes 'foo/bar.c'.  With `--keep-path`, the
-	Git path is instead 'depot/main/foo/bar.c'.
+	path `//depot/main/foo/bar.c`, when imported from
+	`//depot/main/`, becomes `foo/bar.c`.  With `--keep-path`, the
+	Git path is instead `depot/main/foo/bar.c`.
 
 --use-client-spec::
 	Use a client spec to find the list of interesting files in p4.
@@ -483,8 +483,8 @@ Then this 'git p4 clone' command:
 ----
 git p4 clone --detect-branches //depot@all
 ----
-produces a separate branch in 'refs/remotes/p4/' for //depot/main,
-called 'master', and one for //depot/branch1 called 'depot/branch1'.
+produces a separate branch in `refs/remotes/p4/` for //depot/main,
+called 'master', and one for //depot/branch1 called `depot/branch1`.
 
 However, it is not necessary to create branches in p4 to be able to use
 them like branches.  Because it is difficult to infer branch
@@ -552,7 +552,7 @@ Clone and sync variables
 git-p4.syncFromOrigin::
 	Because importing commits from other Git repositories is much faster
 	than importing them from p4, a mechanism exists to find p4 changes
-	first in Git remotes.  If branches exist under 'refs/remote/origin/p4',
+	first in Git remotes.  If branches exist under `refs/remote/origin/p4`,
 	those will be fetched and used when syncing from p4.  This
 	variable can be set to 'false' to disable this behavior.
 
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
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 0cad37fb8..06cf486f7 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -72,8 +72,8 @@ With `-m <master>` option, a symbolic-ref `refs/remotes/<name>/HEAD` is set
 up to point at remote's `<master>` branch. See also the set-head command.
 +
 When a fetch mirror is created with `--mirror=fetch`, the refs will not
-be stored in the 'refs/remotes/' namespace, but rather everything in
-'refs/' on the remote will be directly mirrored into 'refs/' in the
+be stored in the `refs/remotes/` namespace, but rather everything in
+`refs/` on the remote will be directly mirrored into 'refs/' in the
 local repository. This option only makes sense in bare repositories,
 because a fetch would overwrite any local commits.
 +
diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index ab4d27192..ce7a3a636 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -89,9 +89,9 @@ OPTIONS
 
 	Show references matching one or more patterns. Patterns are matched from
 	the end of the full name, and only complete parts are matched, e.g.
-	'master' matches 'refs/heads/master', 'refs/remotes/origin/master',
-	'refs/tags/jedi/master' but not 'refs/heads/mymaster' or
-	'refs/remotes/master/jedi'.
+	'master' matches `refs/heads/master`, `refs/remotes/origin/master`,
+	`refs/tags/jedi/master` but not `refs/heads/mymaster` or
+	`refs/remotes/master/jedi`.
 
 OUTPUT
 ------
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
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 242de31cb..f87eaa46e 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -109,7 +109,7 @@ summary of the situation with 'git status':
 $ git status
 On branch master
 Changes to be committed:
-Your branch is up to date with 'origin/master'.
+Your branch is up to date with `origin/master`.
   (use "git reset HEAD <file>..." to unstage)
 
 	modified:   file1
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
index 88450589a..e350b0556 100644
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
@@ -48,10 +48,10 @@ repository root, i.e. be all under a single parent repository (but see also
 projects' root" subsection).
 
 -----------------------------------------------------------------------
-our $projectroot = '/path/to/parent/directory';
+our $projectroot = `/path/to/parent/directory`;
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
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 023ca95e7..9848d0d84 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -524,7 +524,7 @@ The most notable example is `HEAD`.
 [[def_remote_tracking_branch]]remote-tracking branch::
 	A <<def_ref,ref>> that is used to follow changes from another
 	<<def_repository,repository>>. It typically looks like
-	'refs/remotes/foo/bar' (indicating that it tracks a branch named
+	`refs/remotes/foo/bar` (indicating that it tracks a branch named
 	'bar' in a remote named 'foo'), and matches the right-hand-side of
 	a configured fetch <<def_refspec,refspec>>. A remote-tracking
 	branch should not contain direct modifications or have local
@@ -654,7 +654,7 @@ The most notable example is `HEAD`.
 	The default <<def_branch,branch>> that is merged into the branch in
 	question (or the branch in question is rebased onto). It is configured
 	via branch.<name>.remote and branch.<name>.merge. If the upstream branch
-	of 'A' is 'origin/B' sometimes we say "'A' is tracking 'origin/B'".
+	of 'A' is `origin/B` sometimes we say "'A' is tracking `origin/B`".
 
 [[def_working_tree]]working tree::
 	The tree of actual checked out files.  The working tree normally
diff --git a/Documentation/howto/maintain-git.txt b/Documentation/howto/maintain-git.txt
index ca4378740..2d76e2916 100644
--- a/Documentation/howto/maintain-git.txt
+++ b/Documentation/howto/maintain-git.txt
@@ -348,7 +348,7 @@ Some observations to be made.
  * A topic already in 'next' can get fixes while still in
    'next'.  Such a topic will have many merges to 'next' (in
    other words, "git log --first-parent next" will show many
-   "Merge branch 'ai/topic' to next" for the same topic.
+   "Merge branch `ai/topic` to next" for the same topic.
 
  * An unobvious fix for 'maint' is cooked in 'next' and then
    merged to 'master' to make extra sure it is Ok and then
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
 
 
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 63a3fc095..e28f2dd64 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -36,7 +36,7 @@ set to `no` at the beginning of them.
 	Create a merge commit even when the merge resolves as a
 	fast-forward.  This is the default behaviour when merging an
 	annotated (and possibly signed) tag that is not stored in
-	its natural place in 'refs/tags/' hierarchy.
+	its natural place in `refs/tags/` hierarchy.
 
 --ff-only::
 	Refuse to merge and exit with a non-zero status unless the
diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 72daa20e7..92b1d5638 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -23,27 +23,27 @@ characters and to avoid word splitting.
   followed by a dash and a number of commits, followed by a dash, a
   'g', and an abbreviated object name.
 
-'<refname>', e.g. 'master', 'heads/master', 'refs/heads/master'::
+'<refname>', e.g. 'master', `heads/master`, `refs/heads/master`::
   A symbolic ref name.  E.g. 'master' typically means the commit
-  object referenced by 'refs/heads/master'.  If you
-  happen to have both 'heads/master' and 'tags/master', you can
-  explicitly say 'heads/master' to tell Git which one you mean.
+  object referenced by `refs/heads/master`.  If you
+  happen to have both `heads/master` and `tags/master`, you can
+  explicitly say `heads/master` to tell Git which one you mean.
   When ambiguous, a '<refname>' is disambiguated by taking the
   first match in the following rules:
 
-  . If '$GIT_DIR/<refname>' exists, that is what you mean (this is usually
+  . If `$GIT_DIR/<refname>` exists, that is what you mean (this is usually
     useful only for `HEAD`, `FETCH_HEAD`, `ORIG_HEAD`, `MERGE_HEAD`
     and `CHERRY_PICK_HEAD`);
 
-  . otherwise, 'refs/<refname>' if it exists;
+  . otherwise, `refs/<refname>` if it exists;
 
-  . otherwise, 'refs/tags/<refname>' if it exists;
+  . otherwise, `refs/tags/<refname>` if it exists;
 
-  . otherwise, 'refs/heads/<refname>' if it exists;
+  . otherwise, `refs/heads/<refname>` if it exists;
 
-  . otherwise, 'refs/remotes/<refname>' if it exists;
+  . otherwise, `refs/remotes/<refname>` if it exists;
 
-  . otherwise, 'refs/remotes/<refname>/HEAD' if it exists.
+  . otherwise, `refs/remotes/<refname>/HEAD` if it exists.
 +
 `HEAD` names the commit on which you based the changes in the working tree.
 `FETCH_HEAD` records the branch which you fetched from a remote repository
@@ -57,8 +57,8 @@ when you run `git merge`.
 `CHERRY_PICK_HEAD` records the commit which you are cherry-picking
 when you run `git cherry-pick`.
 +
-Note that any of the 'refs/*' cases above may come either from
-the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
+Note that any of the `refs/*` cases above may come either from
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
diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 7a2375a55..bbc984235 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -107,7 +107,7 @@ Initiating the upload-pack or receive-pack processes over SSH is
 executing the binary on the server via SSH remote execution.
 It is basically equivalent to running this:
 
-   $ ssh git.example.com "git-upload-pack '/project.git'"
+   $ ssh git.example.com "git-upload-pack `/project.git`"
 
 For a server to support Git pushing and pulling for a given user over
 SSH, that user needs to be able to execute one or both of those
-- 
2.11.0


