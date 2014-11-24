From: Richard Littauer <richard.littauer@gmail.com>
Subject: [PATCH 71/71] Change 'usually' to 'by default'
Date: Mon, 24 Nov 2014 16:07:04 -0500
Message-ID: <1416863224-68392-1-git-send-email-richard.littauer@gmail.com>
Cc: Richard Littauer <richard.littauer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 24 22:07:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt0r4-0001HY-1K
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 22:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbaKXVHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 16:07:25 -0500
Received: from mail-qa0-f52.google.com ([209.85.216.52]:40631 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbaKXVHX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 16:07:23 -0500
Received: by mail-qa0-f52.google.com with SMTP id dc16so7085883qab.11
        for <git@vger.kernel.org>; Mon, 24 Nov 2014 13:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=nai4l6Zc5B+WAqzOAStzlrgLf/VZZj4LmqvsBFWk6FM=;
        b=q4fkJPsQJZiK3oXChW9iI/NR/6pd5SV8KGtlg2F860y+q21z5rc+Xm+FYxm4ciKTH5
         RBGdB7ACGIK2shgZu4oP9kFX1OpduPWtRUUdQDgl9twgJHCO959/ypehwBc9jpKg4aLU
         R2GcT8anXWg+f+HPD7AwGImv7mySdoMnGM9MBQu1c4QOXm+uDsz8Jrwf47q6M1csdvka
         QLcqMMA/Nc7p2H1YvfG/lTZZajsot9rbEBaN0BmbCVX71DQBVvWOgFcR9vB/29430fEH
         HrMyH6UtS92YkTndEtSpkauSC9c/x5ydvsXEkxAiEwPf4hGAK6WGnXLLA55X04lKxpDE
         OfxQ==
X-Received: by 10.224.131.135 with SMTP id x7mr32157943qas.38.1416863242793;
        Mon, 24 Nov 2014 13:07:22 -0800 (PST)
Received: from localhost.localdomain ([64.119.130.114])
        by mx.google.com with ESMTPSA id 91sm12873210qgy.15.2014.11.24.13.07.20
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 24 Nov 2014 13:07:21 -0800 (PST)
X-Mailer: git-send-email 2.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260146>

I've been confused several times by the docs when running across
the word 'usually'. It is difficult to know before hand if it
means 'under normal conditions' or 'by default'. I've gone through
the Documentation to identify specific cases where I think that 'by
default' is more explanatory than 'usually'. I know that patches
that touch too much code is unwelcome - as this is a small fix to
very specific lines, I think this might be OK.

For the majority of cases, usually works fine. However, especially
for the docs concerning flags, it is good to know if 'usually' was
just used by the documenter to mean 'unless your version has been
exntensively modified' or if it mean "unless you've messed up."
Hopefully, this isn't too pedantic.

Signed-off-by: Richard Littauer <richard.littauer@gmail.com>
---
 Documentation/git-branch.txt                  |  2 +-
 Documentation/git-cherry-pick.txt             |  2 +-
 Documentation/git-commit.txt                  |  2 +-
 Documentation/git-grep.txt                    |  2 +-
 Documentation/git-http-push.txt               |  2 +-
 Documentation/git-ls-files.txt                |  2 +-
 Documentation/git-ls-remote.txt               |  2 +-
 Documentation/git-mailinfo.txt                |  2 +-
 Documentation/git-pack-refs.txt               |  2 +-
 Documentation/git-push.txt                    |  4 ++--
 Documentation/git-read-tree.txt               |  6 +++---
 Documentation/git-rev-parse.txt               |  4 ++--
 Documentation/git-revert.txt                  |  2 +-
 Documentation/git-send-pack.txt               |  2 +-
 Documentation/git-show-branch.txt             |  2 +-
 Documentation/git-unpack-objects.txt          |  2 +-
 Documentation/gitattributes.txt               |  2 +-
 Documentation/gitcli.txt                      |  6 +++---
 Documentation/gitweb.conf.txt                 | 10 +++++-----
 Documentation/technical/api-parse-options.txt |  2 +-
 Documentation/technical/racy-git.txt          |  4 ++--
 Documentation/user-manual.txt                 |  9 ++++-----
 builtin/apply.c                               |  2 +-
 contrib/hooks/multimail/README                |  2 +-
 gitweb/INSTALL                                |  8 ++++----
 remote.c                                      |  2 +-
 remote.h                                      |  2 +-
 t/README                                      |  2 +-
 28 files changed, 45 insertions(+), 46 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 311b336..c5284e5 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -88,7 +88,7 @@ OPTIONS
 	Create the branch's reflog.  This activates recording of
 	all changes made to the branch ref, enabling use of date
 	based sha1 expressions such as "<branchname>@\{yesterday}".
-	Note that in non-bare repositories, reflogs are usually
+	Note that in non-bare repositories, reflogs are
 	enabled by default by the `core.logallrefupdates` config option.
 
 -f::
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 1c03c79..6d8a43e 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -86,7 +86,7 @@ OPTIONS
 
 -n::
 --no-commit::
-	Usually the command automatically creates a sequence of commits.
+	By default the command automatically creates a sequence of commits.
 	This flag applies the changes necessary to cherry-pick
 	each named commit to your working tree and the index,
 	without making any commit.  In addition, when this
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 0bbc8f5..d82add3 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -203,7 +203,7 @@ variable (see linkgit:git-config[1]).
 -e::
 --edit::
 	The message taken from file with `-F`, command line with
-	`-m`, and from commit object with `-C` are usually used as
+	`-m`, and from commit object with `-C` are by default used as
 	the commit log message unmodified. This option lets you
 	further edit the message taken from these sources.
 
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 31811f1..f6b0638 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -124,7 +124,7 @@ OPTIONS
 	line.
 
 --full-name::
-	When run from a subdirectory, the command usually
+	When run from a subdirectory, the command by default
 	outputs paths relative to the current directory.  This
 	option forces paths to be output relative to the project
 	top directory.
diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.txt
index 2e67362..bd72f75 100644
--- a/Documentation/git-http-push.txt
+++ b/Documentation/git-http-push.txt
@@ -28,7 +28,7 @@ OPTIONS
 	ref's history exist in the remote repository.
 
 --force::
-	Usually, the command refuses to update a remote ref that
+	By default, the command refuses to update a remote ref that
 	is not an ancestor of the local ref used to overwrite it.
 	This flag disables the check.  What this means is that
 	the remote repository can lose commits; use it with
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index e26f01f..0a01570 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -131,7 +131,7 @@ a space) at the start of each line:
 	linkgit:git-update-index[1]).
 
 --full-name::
-	When run from a subdirectory, the command usually
+	When run from a subdirectory, the command by default
 	outputs paths relative to the current directory.  This
 	option forces paths to be output relative to the project
 	top directory.
diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 2e22915..faf7351 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -38,7 +38,7 @@ OPTIONS
 
 --exit-code::
 	Exit with status "2" when no matching refs are found in the remote
-	repository. Usually the command exits with status "0" to indicate
+	repository. By default the command exits with status "0" to indicate
 	it successfully talked with the remote repository, whether it
 	found any matching refs.
 
diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index 164a3c6..342b2da 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -25,7 +25,7 @@ command directly.  See linkgit:git-am[1] instead.
 OPTIONS
 -------
 -k::
-	Usually the program removes email cruft from the Subject:
+	By default the program removes email cruft from the Subject:
 	header line to extract the title line for the commit log
 	message.  This option prevents this munging, and is most
 	useful when used to read back 'git format-patch -k' output.
diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.txt
index 154081f..c97e62a 100644
--- a/Documentation/git-pack-refs.txt
+++ b/Documentation/git-pack-refs.txt
@@ -56,7 +56,7 @@ a repository with many branches of historical interests.
 
 --no-prune::
 
-The command usually removes loose refs under `$GIT_DIR/refs`
+The command be default removes loose refs under `$GIT_DIR/refs`
 hierarchy after packing them.  This option tells it not to.
 
 
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index c0d7403..48760f3 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -139,7 +139,7 @@ already exists on the remote side.
 --[no-]force-with-lease::
 --force-with-lease=<refname>::
 --force-with-lease=<refname>:<expect>::
-	Usually, "git push" refuses to update a remote ref that is
+	By default, "git push" refuses to update a remote ref that is
 	not an ancestor of the local ref used to overwrite it.
 +
 This option bypasses the check, but instead requires that the
@@ -188,7 +188,7 @@ command line.
 
 -f::
 --force::
-	Usually, the command refuses to update a remote ref that is
+	By default, the command refuses to update a remote ref that is
 	not an ancestor of the local ref used to overwrite it.
 	Also, when `--force-with-lease` option is used, the command refuses
 	to update a remote ref whose current value does not match
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index fa1d557..91fb62f 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -46,7 +46,7 @@ OPTIONS
 	tree with the result of the merge.
 
 -i::
-	Usually a merge requires the index file as well as the
+	By default a merge requires the index file as well as the
 	files in the working tree to be up to date with the
 	current head commit, in order not to lose local
 	changes.  This flag disables the check with the working
@@ -69,7 +69,7 @@ OPTIONS
 	conflicting files unresolved in the index.
 
 --aggressive::
-	Usually a three-way merge by 'git read-tree' resolves
+	By default a three-way merge by 'git read-tree' resolves
 	the merge for really trivial cases and leaves other
 	cases unresolved in the index, so that porcelains can
 	implement different merge policies.  This flag makes the
@@ -91,7 +91,7 @@ OPTIONS
 --exclude-per-directory=<gitignore>::
 	When running the command with `-u` and `-m` options, the
 	merge result may need to overwrite paths that are not
-	tracked in the current branch.  The command usually
+	tracked in the current branch.  The command by default
 	refuses to proceed with the merge to avoid losing such a
 	path.  However this safety valve sometimes gets in the
 	way.  For example, it often happens that the other
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 0b84769..262cd01 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -116,7 +116,7 @@ can be used.
 	instead exit with non-zero status silently.
 
 --sq::
-	Usually the output is made one line per flag and
+	By default the output is made one line per flag and
 	parameter.  This option makes output a single line,
 	properly quoted for consumption by shell.  Useful when
 	you expect your parameter to contain whitespaces and
@@ -141,7 +141,7 @@ can be used.
 	7 is used. The minimum length is 4.
 
 --symbolic::
-	Usually the object names are output in SHA-1 form (with
+	By default the object names are output in SHA-1 form (with
 	possible '{caret}' prefix); this option makes them output in a
 	form as close to the original input as possible.
 
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index cceb5f2..b0eae3e 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -68,7 +68,7 @@ more details.
 
 -n::
 --no-commit::
-	Usually the command automatically creates some commits with
+	By default the command automatically creates some commits with
 	commit log messages stating which commits were
 	reverted.  This flag applies the changes necessary
 	to revert the named commits to your working tree
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 2a0de42..33a7599 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -49,7 +49,7 @@ be in a separate packet, and the list must end with a flush packet.
 	Do everything except actually send the updates.
 
 --force::
-	Usually, the command refuses to update a remote ref that
+	By default, the command refuses to update a remote ref that
 	is not an ancestor of the local ref used to overwrite it.
 	This flag disables the check.  What this means is that
 	the remote repository can lose commits; use it with
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index b91d4e5..ef4cba3 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -70,7 +70,7 @@ OPTIONS
 	visible.
 
 --more=<n>::
-	Usually the command stops output upon showing the commit
+	By default, the command stops output upon showing the commit
 	that is the common ancestor of all the branches.  This
 	flag tells the command to go <n> more common commits
 	beyond that.  When <n> is negative, display only the
diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
index 12cb108..cbc51fe 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -32,7 +32,7 @@ OPTIONS
 	the objects.
 
 -q::
-	The command usually shows percentage progress.  This
+	The command shows percentage progress by default.  This
 	flag suppresses it.
 
 -r::
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 643c1ba..5a5dd0d 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -482,7 +482,7 @@ is prefixed with a line of the form:
 
 	@@ -k,l +n,m @@ TEXT
 
-This is called a 'hunk header'.  The "TEXT" portion is by default a line
+This is called a 'hunk header'.  The "TEXT" portion is usually a line
 that begins with an alphabet, an underscore or a dollar sign; this
 matches what GNU 'diff -p' output uses.  This default selection however
 is not suited for some contents, and you can use a customized pattern
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index dfe7d83..8259c5e 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -187,19 +187,19 @@ different things.
    usually works on files in the working tree to *only* work
    with the index.  For example, `git grep`, when used
    without a commit to specify from which commit to look for
-   strings in, usually works on files in the working tree,
+   strings in, by default works on files in the working tree,
    but with the `--cached` option, it looks for strings in
    the index.
 
  * The `--index` option is used to ask a command that
    usually works on files in the working tree to *also*
-   affect the index.  For example, `git stash apply` usually
+   affect the index.  For example, `git stash apply` by default
    merges changes recorded in a stash to the working tree,
    but with the `--index` option, it also merges changes to
    the index as well.
 
 `git apply` command can be used with `--cached` and
-`--index` (but not at the same time).  Usually the command
+`--index` (but not at the same time).  By default the command
 only affects the files in the working tree, but with
 `--index`, it patches both the files and their index
 entries, and with `--cached`, it modifies only the index
diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index ebe7a6c..dc07b64 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -222,7 +222,7 @@ The values of these variables are paths on the filesystem.
 
 $GIT::
 	Core git executable to use.  By default set to `$GIT_BINDIR/git`, which
-	in turn is by default set to `$(bindir)/git`.  If you use Git installed
+	in turn is defaulted to `$(bindir)/git`.  If you use Git installed
 	from a binary package, you should usually set this to "/usr/bin/git".
 	This can just be "git" if your web server has a sensible PATH; from
 	security point of view it is better to use absolute path to git binary.
@@ -409,7 +409,7 @@ $home_text::
 $projects_list_description_width::
 	The width (in characters) of the "Description" column of the projects list.
 	Longer descriptions will be truncated (trying to cut at word boundary);
-	the full description is available in the 'title' attribute (usually shown on
+	the full description is available in the 'title' attribute (by default shown on
 	mouseover).  The default is 25, which might be too small if you
 	use long project descriptions.
 
@@ -431,7 +431,7 @@ These configuration variables control _internal_ gitweb behavior.
 
 $default_blob_plain_mimetype::
 	Default mimetype for the blob_plain (raw) view, if mimetype checking
-	doesn't result in some other type; by default "text/plain".
+	doesn't result in some other type; usually "text/plain".
 	Gitweb guesses mimetype of a file to display based on extension
 	of its filename, using `$mimetypes_file` (if set and file exists)
 	and '/etc/mime.types' files (see *mime.types*(5) manpage; only
@@ -633,10 +633,10 @@ override::
 	overridable, which means that it can be configured
 	(or enabled/disabled) on a per-repository basis.
 +
-Usually given "<feature>" is configurable via the `gitweb.<feature>`
+Usually the given "<feature>" is configurable via the `gitweb.<feature>`
 config variable in the per-repository Git configuration file.
 +
-*Note* that no feature is overridable by default.
+*Note* that no feature is overridable usually.
 
 sub::
 	Internal detail of implementation.  What is important is that
diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 1f2db31..7212d3f 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -82,7 +82,7 @@ Flags are the bitwise-or of:
 	non-option arguments.
 
 `PARSE_OPT_STOP_AT_NON_OPTION`::
-	Usually the whole argument vector is massaged and reordered.
+	By default the whole argument vector is massaged and reordered.
 	Using this flag, processing is stopped at the first non-option
 	argument.
 
diff --git a/Documentation/technical/racy-git.txt b/Documentation/technical/racy-git.txt
index 242a044..8c577ee 100644
--- a/Documentation/technical/racy-git.txt
+++ b/Documentation/technical/racy-git.txt
@@ -38,10 +38,10 @@ files vs symbolic links) and executable bits (only for regular
 files) from `st_mode` member, `st_mtime` and `st_ctime`
 timestamps, `st_uid`, `st_gid`, `st_ino`, and `st_size` members.
 With a `USE_STDEV` compile-time option, `st_dev` is also
-compared, but this is not enabled by default because this member
+compared, but this is not enabled usually because this member
 is not stable on network filesystems.  With `USE_NSEC`
 compile-time option, `st_mtim.tv_nsec` and `st_ctim.tv_nsec`
-members are also compared, but this is not enabled by default
+members are also compared, but this is not enabled usually
 because in-core timestamps can have finer granularity than
 on-disk timestamps, resulting in meaningless changes when an
 inode is evicted from the inode cache.  See commit 8ce13b0
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 7330d88..de7423a 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -405,7 +405,7 @@ linkgit:git-pack-refs[1]).
 
 As another useful shortcut, the "HEAD" of a repository can be referred
 to just using the name of that repository.  So, for example, "origin"
-is usually a shortcut for the HEAD branch in the repository "origin".
+is by default a shortcut for the HEAD branch in the repository "origin".
 
 For the complete list of paths which Git checks for references, and
 the order it uses to decide which to choose when there are multiple
@@ -1398,7 +1398,7 @@ $ git add file.txt
 -------------------------------------------------
 
 the different stages of that file will be "collapsed", after which
-`git diff` will (by default) no longer show diffs for that file.
+`git diff` will (usually) no longer show diffs for that file.
 
 [[undoing-a-merge]]
 Undoing a merge
@@ -1759,8 +1759,7 @@ remote-tracking branches `origin/*`, and merge the default branch into
 the current branch.
 
 More generally, a branch that is created from a remote-tracking branch
-will pull
-by default from that branch.  See the descriptions of the
+will pull usually from that branch.  See the descriptions of the
 `branch.<name>.remote` and `branch.<name>.merge` options in
 linkgit:git-config[1], and the discussion of the `--track` option in
 linkgit:git-checkout[1], to learn how to control these defaults.
@@ -2170,7 +2169,7 @@ linkgit:git-fetch[1] to keep them up-to-date; see
 Now create the branches in which you are going to work; these start out
 at the current tip of origin/master branch, and should be set up (using
 the `--track` option to linkgit:git-branch[1]) to merge changes in from
-Linus by default.
+Linus usually.
 
 -------------------------------------------------
 $ git branch --track test origin/master
diff --git a/builtin/apply.c b/builtin/apply.c
index 6b7c764..fb3749f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3085,7 +3085,7 @@ static struct patch *in_fn_table(const char *name)
 
 /*
  * item->util in the filename table records the status of the path.
- * Usually it points at a patch (whose result records the contents
+ * By default it points at a patch (whose result records the contents
  * of it after applying it), but it could be PATH_WAS_DELETED for a
  * path that a previously applied patch has already removed, or
  * PATH_TO_BE_DELETED for a path that a later patch would remove.
diff --git a/contrib/hooks/multimail/README b/contrib/hooks/multimail/README
index 477d65f..6967151 100644
--- a/contrib/hooks/multimail/README
+++ b/contrib/hooks/multimail/README
@@ -138,7 +138,7 @@ community.)
 Configuration
 -------------
 
-By default, git-multimail mostly takes its configuration from the
+By default, git-multimail takes most of its configuration from the
 following "git config" settings:
 
 multimailhook.environment
diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 408f285..23636b9 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -63,14 +63,14 @@ See also "How to configure gitweb for your local system" section below.
   use GITWEB_PROJECTROOT build configuration variable.
 
   By default all git repositories under projectroot are visible and
-  available to gitweb. The list of projects is generated by default by
+  available to gitweb. The list of projects is generated usually by
   scanning the projectroot directory for git repositories. This can be
   changed (configured) as described in "Gitweb repositories" section
   below.
 
   Note that gitweb deals directly with the object database, and does not
   need a working directory; the name of the project is the name of its
-  repository object database, usually projectname.git for bare
+  repository object database, by default projectname.git for bare
   repositories. If you want to provide gitweb access to non-bare (live)
   repositories, you can make projectname.git a symbolic link under
   projectroot linking to projectname/.git (but it is just
@@ -140,7 +140,7 @@ You can specify the following configuration variables when building GIT:
    gitweb.cgi script.  [No default]
  * GITWEB_HOME_LINK_STR
    String of the home link on top of all pages, leading to $home_link
-   (usually main gitweb page, which means projects list).  Used as first
+   (by default main gitweb page, which means projects list).  Used as first
    part of gitweb view "breadcrumb trail": <home> / <project> / <view>.
    [Default: projects]
  * GITWEB_SITENAME
@@ -234,7 +234,7 @@ See also "Runtime gitweb configuration" section in README file
 for gitweb (in gitweb/README), and gitweb.conf(5) manpage.
 
 - You can configure gitweb further using the per-instance gitweb configuration file;
-  by default this is a file named gitweb_config.perl in the same place as
+  usually this is a file named gitweb_config.perl in the same place as
   gitweb.cgi script. You can control the default place for the config file
   using the GITWEB_CONFIG build configuration variable, and you can set it
   using the GITWEB_CONFIG environment variable. If this file does not
diff --git a/remote.c b/remote.c
index 3d6c86a..109f445 100644
--- a/remote.c
+++ b/remote.c
@@ -754,7 +754,7 @@ static void handle_duplicate(struct ref *ref1, struct ref *ref2)
 			    ref1->name, ref2->name, ref2->peer_ref->name);
 		} else if (ref1->fetch_head_status != FETCH_HEAD_IGNORE &&
 			   ref2->fetch_head_status == FETCH_HEAD_IGNORE) {
-			warning(_("%s usually tracks %s, not %s"),
+			warning(_("%s by default tracks %s, not %s"),
 				ref2->peer_ref->name, ref2->name, ref1->name);
 		} else if (ref1->fetch_head_status == FETCH_HEAD_IGNORE &&
 			   ref2->fetch_head_status == FETCH_HEAD_IGNORE) {
diff --git a/remote.h b/remote.h
index 917d383..58161d8 100644
--- a/remote.h
+++ b/remote.h
@@ -181,7 +181,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
  * beforehand, and will be set to the tail pointer of the list of
  * results afterward.
  *
- * missing_ok is usually false, but when we are adding branch.$name.merge
+ * missing_ok is by default false, but when we are adding branch.$name.merge
  * it is Ok if the branch is not at the remote anymore.
  */
 int get_fetch_map(const struct ref *remote_refs, const struct refspec *refspec,
diff --git a/t/README b/t/README
index 52c77ae..f5a173d 100644
--- a/t/README
+++ b/t/README
@@ -504,7 +504,7 @@ library for your script to use.
 
  - test_expect_success [<prereq>] <message> <script>
 
-   Usually takes two strings as parameters, and evaluates the
+   By default takes two strings as parameters, and evaluates the
    <script>.  If it yields success, test is considered
    successful.  <message> should state what it is testing.
 
-- 
2.0.0
