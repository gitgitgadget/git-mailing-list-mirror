From: Brian Hetro <whee@smaertness.net>
Subject: [PATCH] Documentation: Correct various misspellings and typos.
Date: Thu, 23 Aug 2007 20:44:13 -0400
Message-ID: <20070824004413.GB21778@ruiner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 24 02:44:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IONHp-00066R-CK
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 02:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934495AbXHXAoW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 20:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934493AbXHXAoV
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 20:44:21 -0400
Received: from ag-out-0708.google.com ([72.14.246.243]:33302 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934144AbXHXAoS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 20:44:18 -0400
Received: by ag-out-0708.google.com with SMTP id 35so1500150aga
        for <git@vger.kernel.org>; Thu, 23 Aug 2007 17:44:17 -0700 (PDT)
Received: by 10.90.53.16 with SMTP id b16mr7752614aga.1187916257052;
        Thu, 23 Aug 2007 17:44:17 -0700 (PDT)
Received: from smaertness.net ( [66.67.48.108])
        by mx.google.com with ESMTPS id 36sm7670051aga.2007.08.23.17.44.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Aug 2007 17:44:15 -0700 (PDT)
Received: by smaertness.net (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	whee@smaertness.net; Thu, 23 Aug 2007 20:44:14 -0400 (EDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-PGP-Key: http://whee.smaertness.net/pubkey.asc
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56544>

Fix minor typos throughout the documentation.

Signed-off-by: Brian Hetro <whee@smaertness.net>
---
This patch is rather large...but full of trivial, typo related, fixes.
I am not sure if it should be split up.

 Documentation/config.txt            |   12 ++++++------
 Documentation/git-commit-tree.txt   |    2 +-
 Documentation/git-config.txt        |    2 +-
 Documentation/git-fast-import.txt   |   18 +++++++++---------
 Documentation/git-fmt-merge-msg.txt |    2 +-
 Documentation/git-format-patch.txt  |    2 +-
 Documentation/git-gui.txt           |    2 +-
 Documentation/git-http-fetch.txt    |    2 +-
 Documentation/git-local-fetch.txt   |    2 +-
 Documentation/git-name-rev.txt      |    2 +-
 Documentation/git-receive-pack.txt  |    2 +-
 Documentation/git-reflog.txt        |    2 +-
 Documentation/git-repack.txt        |    2 +-
 Documentation/git-rev-list.txt      |    2 +-
 Documentation/git-svn.txt           |    4 ++--
 Documentation/gitattributes.txt     |    6 +++---
 Documentation/hooks.txt             |    2 +-
 Documentation/tutorial.txt          |    2 +-
 Documentation/user-manual.txt       |   12 ++++++------
 19 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a9fb221..903610f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -283,7 +283,7 @@ core.excludesfile::
 
 core.editor::
 	Commands such as `commit` and `tag` that lets you edit
-	messages by lauching an editor uses the value of this
+	messages by launching an editor uses the value of this
 	variable when it is set, and the environment variable
 	`GIT_EDITOR` is not set.  The order of preference is
 	`GIT_EDITOR` environment, `core.editor`, `VISUAL` and
@@ -500,10 +500,10 @@ gitcvs.dbuser, gitcvs.dbpass::
 	'gitcvs.dbuser' supports variable substitution (see
 	gitlink:git-cvsserver[1] for details).
 
-All gitcvs variables except for 'gitcvs.allbinary' can also specifed
-as 'gitcvs.<access_method>.<varname>' (where 'access_method' is one
-of "ext" and "pserver") to make them apply only for the given access
-method.
+All gitcvs variables except for 'gitcvs.allbinary' can also be
+specified as 'gitcvs.<access_method>.<varname>' (where 'access_method'
+is one of "ext" and "pserver") to make them apply only for the given
+access method.
 
 http.sslVerify::
 	Whether to verify the SSL certificate when fetching or pushing
@@ -615,7 +615,7 @@ pack.compression::
 	not set,  defaults to -1.
 
 pack.deltaCacheSize::
-	The maxium memory in bytes used for caching deltas in
+	The maximum memory in bytes used for caching deltas in
 	gitlink:git-pack-objects[1].
 	A value of 0 means no limit. Defaults to 0.
 
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index 6a328f4..a2537e1 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -52,7 +52,7 @@ A commit encapsulates:
 - committer name and email and the commit time.
 
 While parent object ids are provided on the command line, author and
-commiter information is taken from the following environment variables,
+committer information is taken from the following environment variables,
 if set:
 
 	GIT_AUTHOR_NAME
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index c3dffff..5b794f4 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -139,7 +139,7 @@ See also <<FILES>>.
 FILES
 -----
 
-If not set explicitely with '--file', there are three files where
+If not set explicitly with '--file', there are three files where
 git-config will search for configuration options:
 
 .git/config::
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 0a019dd..d511967 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -241,7 +241,7 @@ been well tested in the wild.
 +
 Frontends should prefer the `raw` format if the source material
 already uses UNIX-epoch format, can be coaxed to give dates in that
-format, or its format is easiliy convertible to it, as there is no
+format, or its format is easily convertible to it, as there is no
 ambiguity in parsing.
 
 `now`::
@@ -343,7 +343,7 @@ Zero or more `filemodify`, `filedelete`, `filecopy`, `filerename`
 and `filedeleteall` commands
 may be included to update the contents of the branch prior to
 creating the commit.  These commands may be supplied in any order.
-However it is recommended that a `filedeleteall` command preceed
+However it is recommended that a `filedeleteall` command precede
 all `filemodify`, `filecopy` and `filerename` commands in the same
 commit, as `filedeleteall`
 wipes the branch clean (see below).
@@ -402,7 +402,7 @@ Here `<committish>` is any of the following:
 +
 The reason fast-import uses `:` to denote a mark reference is this character
 is not legal in a Git branch name.  The leading `:` makes it easy
-to distingush between the mark 42 (`:42`) and the branch 42 (`42`
+to distinguish between the mark 42 (`:42`) and the branch 42 (`42`
 or `refs/heads/42`), or an abbreviated SHA-1 which happened to
 consist only of base-10 digits.
 +
@@ -487,7 +487,7 @@ start with double quote (`"`).
 If an `LF` or double quote must be encoded into `<path>` shell-style
 quoting should be used, e.g. `"path/with\n and \" in it"`.
 
-The value of `<path>` must be in canoncial form. That is it must not:
+The value of `<path>` must be in canonical form. That is it must not:
 
 * contain an empty directory component (e.g. `foo//bar` is invalid),
 * end with a directory separator (e.g. `foo/` is invalid),
@@ -733,7 +733,7 @@ of the next line, even if `<raw>` did not end with an `LF`.
 Delimited format::
 	A delimiter string is used to mark the end of the data.
 	fast-import will compute the length by searching for the delimiter.
-	This format is primarly useful for testing and is not
+	This format is primarily useful for testing and is not
 	recommended for real data.
 +
 ....
@@ -873,7 +873,7 @@ to remove the dummy branch.
 Import Now, Repack Later
 ~~~~~~~~~~~~~~~~~~~~~~~~
 As soon as fast-import completes the Git repository is completely valid
-and ready for use.  Typicallly this takes only a very short time,
+and ready for use.  Typically this takes only a very short time,
 even for considerably large projects (100,000+ commits).
 
 However repacking the repository is necessary to improve data
@@ -942,8 +942,8 @@ Memory Utilization
 ------------------
 There are a number of factors which affect how much memory fast-import
 requires to perform an import.  Like critical sections of core
-Git, fast-import uses its own memory allocators to ammortize any overheads
-associated with malloc.  In practice fast-import tends to ammoritize any
+Git, fast-import uses its own memory allocators to amortize any overheads
+associated with malloc.  In practice fast-import tends to amortize any
 malloc overheads to 0, due to its use of large block allocations.
 
 per object
@@ -1000,7 +1000,7 @@ per active tree
 ~~~~~~~~~~~~~~~
 Trees (aka directories) use just 12 bytes of memory on top of the
 memory required for their entries (see ``per active file'' below).
-The cost of a tree is virtually 0, as its overhead ammortizes out
+The cost of a tree is virtually 0, as its overhead amortizes out
 over the individual file entries.
 
 per active file entry
diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 6affc5b..7088ed4 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 git-fmt-merge-msg [--summary | --no-summary] <$GIT_DIR/FETCH_HEAD
-git-fmt-merge-msg [--summary | --no-summray] -F <file>
+git-fmt-merge-msg [--summary | --no-summary] -F <file>
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 6cbcf93..c514fdd 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -118,7 +118,7 @@ include::diff-options.txt[]
 
 --suffix=.<sfx>::
 	Instead of using `.patch` as the suffix for generated
-	filenames, use specifed suffix.  A common alternative is
+	filenames, use specified suffix.  A common alternative is
 	`--suffix=.txt`.
 +
 Note that you would need to include the leading dot `.` if you
diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
index bd613b2..13252a1 100644
--- a/Documentation/git-gui.txt
+++ b/Documentation/git-gui.txt
@@ -89,7 +89,7 @@ See Also
 Other
 -----
 git-gui is actually maintained as an independent project, but stable
-versions are distributed as part of the Git suite for the convience
+versions are distributed as part of the Git suite for the convenience
 of end users.
 
 A git-gui development repository can be obtained from:
diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
index 45e4845..389c6ed 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -34,7 +34,7 @@ commit-id::
         the local end after the transfer is complete.
 
 --stdin::
-	Instead of a commit id on the commandline (which is not expected in this
+	Instead of a commit id on the command line (which is not expected in this
 	case), 'git-http-fetch' expects lines on stdin in the format
 
 		<commit-id>['\t'<filename-as-in--w>]
diff --git a/Documentation/git-local-fetch.txt b/Documentation/git-local-fetch.txt
index 141b767..e830dee 100644
--- a/Documentation/git-local-fetch.txt
+++ b/Documentation/git-local-fetch.txt
@@ -44,7 +44,7 @@ OPTIONS
         the local end after the transfer is complete.
 
 --stdin::
-	Instead of a commit id on the commandline (which is not expected in this
+	Instead of a commit id on the command line (which is not expected in this
 	case), 'git-local-fetch' expects lines on stdin in the format
 
 		<commit-id>['\t'<filename-as-in--w>]
diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index 91eede1..306e1a4 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -37,7 +37,7 @@ OPTIONS
 --name-only::
 	Instead of printing both the SHA-1 and the name, print only
 	the name.  If given with --tags the usual tag prefix of
-	"tags/" is also ommitted from the name, matching the output
+	"tags/" is also omitted from the name, matching the output
 	of gitlink::git-describe[1] more closely.  This option
 	cannot be combined with --stdin.
 
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 4ef1840..2633d94 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -78,7 +78,7 @@ The hook should exit with non-zero status if it wants to disallow
 updating the named ref.  Otherwise it should exit with zero.
 
 Successful execution (a zero exit status) of this hook does not
-ensure the ref will actully be updated, it is only a prerequisite.
+ensure the ref will actually be updated, it is only a prerequisite.
 As such it is not a good idea to send notices (e.g. email) from
 this hook.  Consider using the post-receive hook instead.
 
diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 29b7d9f..5180f68 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -30,7 +30,7 @@ Entries older than `expire` time, or entries older than
 tip, are removed from the reflog.  This is typically not used
 directly by the end users -- instead, see gitlink:git-gc[1].
 
-The subcommand "show" (which is also the default, in the absense of any
+The subcommand "show" (which is also the default, in the absence of any
 subcommands) will take all the normal log options, and show the log of
 `HEAD`, which will cover all recent actions, including branch switches.
 It is basically an alias for 'git log -g --abbrev-commit
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 5283ef8..12e2079 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -14,7 +14,7 @@ DESCRIPTION
 -----------
 
 This script is used to combine all objects that do not currently
-reside in a "pack", into a pack.  It can also be used to re-organise
+reside in a "pack", into a pack.  It can also be used to re-organize
 existing packs into a single, more efficient pack.
 
 A pack is a collection of objects, individually compressed, with
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index a0c611e..7cd0e89 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -113,7 +113,7 @@ e.g. "2 hours ago".
 `--date=rfc` (or `--date=rfc2822`) shows timestamps in RFC 2822
 format, often found in E-mail messages.
 +
-`--date=short` shows only date but not time, in `YYYY-MM-DD` fomat.
+`--date=short` shows only date but not time, in `YYYY-MM-DD` format.
 +
 `--date=default` shows timestamps in the original timezone
 (either committer's or author's).
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 3e2a63b..3420c5c 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -99,7 +99,7 @@ COMMANDS
 
 This works similarly to 'svn update' or 'git-pull' except that
 it preserves linear history with 'git-rebase' instead of
-'git-merge' for ease of dcommit-ing with git-svn.
+'git-merge' for ease of dcommiting with git-svn.
 
 This accepts all options that 'git-svn fetch' and 'git-rebase'
 accepts.  However '--fetch-all' only fetches from the current
@@ -551,7 +551,7 @@ listed below are allowed:
 Keep in mind that the '*' (asterisk) wildcard of the local ref
 (left of the ':') *must* be the farthest right path component;
 however the remote wildcard may be anywhere as long as it's own
-independent path componet (surrounded by '/' or EOL).   This
+independent path component (surrounded by '/' or EOL).   This
 type of configuration is not automatically created by 'init' and
 should be manually entered with a text-editor or using
 gitlink:git-config[1]
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 8b90a5b..46f9d59 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -285,7 +285,7 @@ want to appear as the hunk header, like this:
 Note.  A single level of backslashes are eaten by the
 configuration file parser, so you would need to double the
 backslashes; the pattern above picks a line that begins with a
-backslash, and zero or more occurences of `sub` followed by
+backslash, and zero or more occurrences of `sub` followed by
 `section` followed by open brace, to the end of line.
 
 There are a few built-in patterns to make this easier, and `tex`
@@ -394,7 +394,7 @@ abc	-foo -bar
 the attributes given to path `t/abc` are computed as follows:
 
 1. By examining `t/.gitattributes` (which is in the same
-   diretory as the path in question), git finds that the first
+   directory as the path in question), git finds that the first
    line matches.  `merge` attribute is set.  It also finds that
    the second line matches, and attributes `foo` and `bar`
    are unset.
@@ -410,7 +410,7 @@ the attributes given to path `t/abc` are computed as follows:
    a match, and `foo` is set, `bar` is reverted to unspecified
    state, and `baz` is unset.
 
-As the result, the attributes assignement to `t/abc` becomes:
+As the result, the attributes assignment to `t/abc` becomes:
 
 ----------------------------------------------------------------
 foo	set to true
diff --git a/Documentation/hooks.txt b/Documentation/hooks.txt
index 6836477..c39edc5 100644
--- a/Documentation/hooks.txt
+++ b/Documentation/hooks.txt
@@ -176,7 +176,7 @@ hook does on its standard input.
 This hook does not affect the outcome of `git-receive-pack`, as it
 is called after the real work is done.
 
-This supersedes the <<post-update,'post-update'>> hook in that it get's
+This supersedes the <<post-update,'post-update'>> hook in that it gets
 both old and new values of all the refs in addition to their
 names.
 
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index bd9fbee..fff1068 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -339,7 +339,7 @@ $ git pull . remotes/bob/master
 -------------------------------------
 
 Note that git pull always merges into the current branch,
-regardless of what else is given on the commandline.
+regardless of what else is given on the command line.
 
 Later, Bob can update his repo with Alice's latest changes using
 
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index f89952a..3d02198 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -4,7 +4,7 @@ ______________________________________________
 
 Git is a fast distributed revision control system.
 
-This manual is designed to be readable by someone with basic unix
+This manual is designed to be readable by someone with basic UNIX
 command-line skills, but no previous knowledge of git.
 
 <<repositories-and-branches>> and <<exploring-git-history>> explain how
@@ -217,7 +217,7 @@ commits will help understand how the git organizes history.
 
 In the following, we say that commit X is "reachable" from commit Y
 if commit X is an ancestor of commit Y.  Equivalently, you could say
-that Y is a descendent of X, or that there is a chain of parents
+that Y is a descendant of X, or that there is a chain of parents
 leading from commit Y to commit X.
 
 [[history-diagrams]]
@@ -1911,7 +1911,7 @@ gitlink:git-update-server-info[1], and the documentation
 link:hooks.html[Hooks used by git].)
 
 Advertise the url of proj.git.  Anybody else should then be able to
-clone or pull from that url, for example with a commandline like:
+clone or pull from that url, for example with a command line like:
 
 -------------------------------------------------
 $ git clone http://yourserver.com/~you/proj.git
@@ -2531,7 +2531,7 @@ them again with gitlink:git-am[1].
 Other tools
 -----------
 
-There are numerous other tools, such as stgit, which exist for the
+There are numerous other tools, such as StGIT, which exist for the
 purpose of maintaining a patch series.  These are outside of the scope of
 this manual.
 
@@ -3961,8 +3961,8 @@ This is a work in progress.
 
 The basic requirements:
 	- It must be readable in order, from beginning to end, by
-	  someone intelligent with a basic grasp of the unix
-	  commandline, but without any special knowledge of git.  If
+	  someone intelligent with a basic grasp of the UNIX
+	  command line, but without any special knowledge of git.  If
 	  necessary, any other prerequisites should be specifically
 	  mentioned as they arise.
 	- Whenever possible, section headings should clearly describe
-- 
1.5.3.rc6.17.g1911
