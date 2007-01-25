From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: [PATCH] Hash name is SHA-1
Date: Thu, 25 Jan 2007 09:50:07 -0300
Message-ID: <1169729410294-git-send-email-vonbrand@inf.utfsm.cl>
References: <11697294071178-git-send-email-vonbrand@inf.utfsm.cl>
Cc: git@vger.kernel.org, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jan 25 13:50:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA43o-0007U9-CB
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 13:50:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965286AbXAYMu2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 07:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965280AbXAYMu2
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 07:50:28 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:37836 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965286AbXAYMuW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 07:50:22 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l0PCoAHZ029542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 25 Jan 2007 09:50:10 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l0PCoAk7011515;
	Thu, 25 Jan 2007 09:50:10 -0300
Received: (from vonbrand@localhost)
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8/Submit) id l0PCoAU7011514;
	Thu, 25 Jan 2007 09:50:10 -0300
X-Mailer: git-send-email 1.5.0.rc2
In-Reply-To: <11697294071178-git-send-email-vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [0.0.0.0]); Thu, 25 Jan 2007 09:50:10 -0300 (CLST)
X-Virus-Scanned: ClamAV 0.88.7/2488/Thu Jan 25 06:57:17 2007 on inti.inf.utfsm.cl
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.6
X-Spam-Checker-Version: SpamAssassin 3.0.6 (2005-12-07) on inti.inf.utfsm.cl
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37720>

From: Horst H. von Brand <vonbrand@inf.utfsm.cl> - unquoted

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/git-receive-pack.txt |   14 ++++++------
 Documentation/git-rev-parse.txt    |    8 +++---
 Documentation/git-show-branch.txt  |    4 +-
 Documentation/git-show-index.txt   |    2 +-
 Documentation/git-show-ref.txt     |    4 +-
 Documentation/git-svn.txt          |    6 ++--
 Documentation/git-tag.txt          |    2 +-
 Documentation/git-unpack-file.txt  |    2 +-
 Documentation/git-update-index.txt |   14 ++++++------
 Documentation/git-verify-pack.txt  |    4 +-
 Documentation/git-verify-tag.txt   |    2 +-
 Documentation/git.txt              |    4 +-
 Documentation/glossary.txt         |    8 +++---
 Documentation/pretty-formats.txt   |   16 +++++++-------
 Documentation/tutorial-2.txt       |   16 +++++++-------
 builtin-apply.c                    |   18 ++++++++++------
 builtin-blame.c                    |   20 ++++++++++++------
 builtin-cat-file.c                 |    5 ++-
 builtin-commit-tree.c              |    3 +-
 builtin-describe.c                 |    3 +-
 builtin-diff-tree.c                |    9 ++++---
 builtin-diff.c                     |    6 +++-
 builtin-for-each-ref.c             |    6 +++-
 builtin-init-db.c                  |    2 +-
 builtin-log.c                      |    5 ++-
 builtin-name-rev.c                 |    2 +-
 builtin-pack-objects.c             |   21 +++++++++++--------
 builtin-prune.c                    |    2 +-
 builtin-push.c                     |    4 ++-
 builtin-read-tree.c                |    6 ++++-
 builtin-reflog.c                   |    3 +-
 builtin-rev-list.c                 |    6 +++-
 builtin-rm.c                       |    8 ++++--
 builtin-shortlog.c                 |    2 +-
 builtin-show-branch.c              |   19 ++++++++++++-----
 builtin-show-ref.c                 |    8 +++++-
 builtin-unpack-objects.c           |    2 +-
 builtin-update-index.c             |   37 +++++++++++++++++++++++------------
 builtin-update-ref.c               |    4 +-
 builtin-write-tree.c               |    3 +-
 cache-tree.c                       |    9 +++++--
 cache.h                            |    2 +-
 combine-diff.c                     |    2 +-
 commit.c                           |    2 +-
 connect.c                          |    3 +-
 convert-objects.c                  |    6 ++--
 csum-file.c                        |    8 +++---
 csum-file.h                        |    2 +-
 diff-lib.c                         |    6 +++-
 diff.c                             |   35 ++++++++++++++++++++++-----------
 diffcore-break.c                   |    3 +-
 diffcore.h                         |    6 +++-
 fetch-pack.c                       |    3 +-
 fetch.h                            |    4 +-
 fsck-objects.c                     |    4 +-
 git-archimport.perl                |    4 +-
 git-merge-one-file.sh              |    6 ++--
 git-svn.perl                       |    6 ++--
 http-fetch.c                       |    8 ++++--
 http-push.c                        |    7 +++--
 index-pack.c                       |   22 ++++++++++----------
 merge-tree.c                       |    8 +++---
 mktag.c                            |    6 ++--
 mktree.c                           |    7 +++--
 object.c                           |    2 +-
 pack-check.c                       |    8 +++---
 patch-id.c                         |    2 +-
 read-cache.c                       |    6 ++--
 receive-pack.c                     |    2 +-
 refs.c                             |    2 +-
 setup.c                            |    2 +-
 sha1_file.c                        |   16 +++++++-------
 sha1_name.c                        |    2 +-
 upload-pack.c                      |    4 +-
 74 files changed, 303 insertions(+), 222 deletions(-)

diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 10e8c46..2fafc79 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -20,7 +20,7 @@ The UI for the protocol is on the 'git-send-pack' side, and the
 program pair is meant to be used to push updates to remote
 repository.  For pull operations, see 'git-fetch-pack'.
 
-The command allows for creation and fast forwarding of sha1 refs
+The command allows for creation and fast forwarding of SHA-1 refs
 (heads/tags) on the remote end (strictly speaking, it is the
 local end receive-pack runs, but to the user who is sitting at
 the send-pack end, it is updating the remote.  Confused?)
@@ -30,12 +30,12 @@ and executable, it is called with three parameters:
 
        $GIT_DIR/hooks/update refname sha1-old sha1-new
 
-The refname parameter is relative to $GIT_DIR; e.g. for the
-master head this is "refs/heads/master".  Two sha1 are the
-object names for the refname before and after the update.  Note
-that the hook is called before the refname is updated, so either
-sha1-old is 0{40} (meaning there is no such ref yet), or it
-should match what is recorded in refname.
+The refname parameter is relative to $GIT_DIR; e.g. for the master
+head this is "refs/heads/master".  The two sha1 are the object names
+for the refname before and after the update.  Note that the hook is
+called before the refname is updated, so either sha1-old is 0{40}
+(meaning there is no such ref yet), or it should match what is
+recorded in refname.
 
 The hook should exit with non-zero status if it wants to
 disallow updating the named ref.  Otherwise it should exit with
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index aeb37b6..9363257 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -59,7 +59,7 @@ OPTIONS
 	one.
 
 --symbolic::
-	Usually the object names are output in SHA1 form (with
+	Usually the object names are output in SHA-1 form (with
 	possible '{caret}' prefix); this option makes them output in a
 	form as close to the original input as possible.
 
@@ -90,7 +90,7 @@ OPTIONS
 	Show `$GIT_DIR` if defined else show the path to the .git directory.
 
 --short, --short=number::
-	Instead of outputting the full SHA1 values of object names try to
+	Instead of outputting the full SHA-1 values of object names try to
 	abbreviate them to a shorter unique name. When no length is specified
 	7 is used. The minimum length is 4.
 
@@ -110,12 +110,12 @@ SPECIFYING REVISIONS
 --------------------
 
 A revision parameter typically, but not necessarily, names a
-commit object.  They use what is called an 'extended SHA1'
+commit object.  They use what is called an 'extended SHA-1'
 syntax.  Here are various ways to spell object names.  The
 ones listed near the end of this list are to name trees and
 blobs contained in a commit.
 
-* The full SHA1 object name (40-byte hexadecimal string), or
+* The full SHA-1 object name (40-byte hexadecimal string), or
   a substring of such that is unique within the repository.
   E.g. dae86e1950b1277e545cee180551750029cfe735 and dae86e both
   name the same commit object if there are no other object in
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 529f3a6..5807884 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -29,7 +29,7 @@ no <rev> nor <glob> is given on the command line.
 OPTIONS
 -------
 <rev>::
-	Arbitrary extended SHA1 expression (see `git-rev-parse`)
+	Arbitrary extended SHA-1 expression (see `git-rev-parse`)
 	that typically names a branch HEAD or a tag.
 
 <glob>::
@@ -119,7 +119,7 @@ displayed, indented N places.  If a commit is on the I-th
 branch, the I-th indentation character shows a `+` sign;
 otherwise it shows a space.  Merge commits are denoted by
 a `-` sign.  Each commit shows a short name that
-can be used as an extended SHA1 to name that commit.
+can be used as an extended SHA-1 to name that commit.
 
 The following example shows three branches, "master", "fixes"
 and "mhf":
diff --git a/Documentation/git-show-index.txt b/Documentation/git-show-index.txt
index be09b62..04f1d22 100644
--- a/Documentation/git-show-index.txt
+++ b/Documentation/git-show-index.txt
@@ -18,7 +18,7 @@ git-pack-objects command, and dumps its contents.
 
 The information it outputs is subset of what you can get from
 'git-verify-pack -v'; this command only shows the packfile
-offset and SHA1 of each object.
+offset and SHA-1 of each object.
 
 
 Author
diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 5973a82..85aa106 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -42,8 +42,8 @@ OPTIONS
 
 -s, --hash::
 
-	Only show the SHA1 hash, not the reference name. When also using
-	--dereference the dereferenced tag will still be shown after the SHA1.
+	Only show the SHA-1 hash, not the reference name. When also using
+	--dereference the dereferenced tag will still be shown after the SHA-1.
 
 --verify::
 
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index b95ff1d..b4aeb5b 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -82,7 +82,7 @@ manually joining branches on commit.
 
 	New features:
 
-	--show-commit        - shows the git commit sha1, as well
+	--show-commit        - shows the git commit SHA-1, as well
 	--oneline            - our version of --pretty=oneline
 
 	Any other arguments are passed directly to `git log'
@@ -191,7 +191,7 @@ This can allow you to make partial mirrors when running fetch.
 Only used with the 'set-tree' command.
 
 Read a list of commits from stdin and commit them in reverse
-order.  Only the leading sha1 is read from each line, so
+order.  Only the leading SHA-1 is read from each line, so
 git-rev-list --pretty=oneline output can be used.
 
 --rmdir::
@@ -450,7 +450,7 @@ This is for advanced users, most users should ignore this section.
 
 Unfetched SVN revisions may be imported as children of existing commits
 by specifying additional arguments to 'fetch'.  Additional parents may
-optionally be specified in the form of sha1 hex sums at the
+optionally be specified in the form of SHA-1 hex sums at the
 command-line.  Unfetched SVN revisions may also be tied to particular
 git commits with the following syntax:
 
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 13c7aef..d3e01fe 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -25,7 +25,7 @@ creates a 'tag' object, and requires the tag message.  Unless
 `-m <msg>` is given, an editor is started for the user to type
 in the tag message.
 
-Otherwise just the SHA1 object name of the commit object is
+Otherwise just the SHA-1 object name of the commit object is
 written (i.e. a lightweight tag).
 
 A GnuPG signed tag object will be created when `-s` or `-u
diff --git a/Documentation/git-unpack-file.txt b/Documentation/git-unpack-file.txt
index 213dc81..c7b3be1 100644
--- a/Documentation/git-unpack-file.txt
+++ b/Documentation/git-unpack-file.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Creates a file holding the contents of the blob specified by sha1. It
+Creates a file holding the contents of the blob specified by SHA-1. It
 returns the name of the temporary file in the following format:
 	.merge_file_XXXXX
 
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 5bbae42..9244460 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -129,7 +129,7 @@ OPTIONS
 
 Using --refresh
 ---------------
-'--refresh' does not calculate a new sha1 file or bring the index
+'--refresh' does not calculate a new SHA-1 file or bring the index
 up-to-date for mode/content changes. But what it *does* do is to
 "re-match" the stat information of a file with the index, so that you
 can refresh the index for a file that hasn't been changed but where
@@ -144,10 +144,10 @@ Using --cacheinfo or --info-only
 current working directory.  This is useful for minimum-checkout
 merging.
 
-To pretend you have a file with mode and sha1 at path, say:
+To pretend you have a file with mode and SHA-1 at path, say:
 
 ----------------
-$ git-update-index --cacheinfo mode sha1 path
+$ git-update-index --cacheinfo mode SHA-1 path
 ----------------
 
 '--info-only' is used to register files without placing them in the object
@@ -167,19 +167,19 @@ Using --index-info
 multiple entry definitions from the standard input, and designed
 specifically for scripts.  It can take inputs of three formats:
 
-    . mode         SP sha1          TAB path
+    . mode         SP SHA-1         TAB path
 +
 The first format is what "git-apply --index-info"
 reports, and used to reconstruct a partial tree
 that is used for phony merge base tree when falling
 back on 3-way merge.
 
-    . mode SP type SP sha1          TAB path
+    . mode SP type SP SHA-1         TAB path
 +
 The second format is to stuff git-ls-tree output
 into the index file.
 
-    . mode         SP sha1 SP stage TAB path
+    . mode         SP SHA-1 SP stage TAB path
 +
 This format is to put higher order stages into the
 index file and matches git-ls-files --stage output.
@@ -205,7 +205,7 @@ $ git update-index --index-info
 ------------
 
 The first line of the input feeds 0 as the mode to remove the
-path; the SHA1 does not matter as long as it is well formatted.
+path; the SHA-1 does not matter as long as it is well formatted.
 Then the second and third line feeds stage 1 and stage 2 entries
 for that path.  After the above, we would end up with this:
 
diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
index 7a6132b..8eb8226 100644
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -32,11 +32,11 @@ OUTPUT FORMAT
 -------------
 When specifying the -v option the format used is:
 
-	SHA1 type size offset-in-packfile
+	SHA-1 type size offset-in-packfile
 
 for objects that are not deltified in the pack, and
 
-	SHA1 type size offset-in-packfile depth base-SHA1
+	SHA-1 type size offset-in-packfile depth base-SHA-1
 
 for objects that are deltified.
 
diff --git a/Documentation/git-verify-tag.txt b/Documentation/git-verify-tag.txt
index 0f9bdb5..d610a8b 100644
--- a/Documentation/git-verify-tag.txt
+++ b/Documentation/git-verify-tag.txt
@@ -16,7 +16,7 @@ Validates the gpg signature created by git-tag.
 OPTIONS
 -------
 <tag>::
-	SHA1 identifier of a git tag object.
+	SHA-1 identifier of a git tag object.
 
 Author
 ------
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 9761de3..f359cf1 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -272,7 +272,7 @@ git so take care if using Cogito etc.
 
 'GIT_OBJECT_DIRECTORY'::
 	If the object storage directory is specified via this
-	environment variable then the sha1 directories are created
+	environment variable then the SHA-1 directories are created
 	underneath - otherwise the default `$GIT_DIR/objects`
 	directory is used.
 
@@ -317,7 +317,7 @@ where:
 
 	<old|new>-file:: are files GIT_EXTERNAL_DIFF can use to read the
                          contents of <old|new>,
-	<old|new>-hex:: are the 40-hexdigit SHA1 hashes,
+	<old|new>-hex:: are the 40-hexdigit SHA-1 hashes,
 	<old|new>-mode:: are the octal representation of the file modes.
 
 +
diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
index d20eb62..9cf8b19 100644
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -163,7 +163,7 @@ merge::
 
 object::
 	The unit of storage in git. It is uniquely identified by
-	the SHA1 of its contents. Consequently, an object can not
+	the SHA-1 of its contents. Consequently, an object can not
 	be changed.
 
 object database::
@@ -247,7 +247,7 @@ rebase::
 	changes from that branch.
 
 ref::
-	A 40-byte hex representation of a SHA1 or a name that denotes
+	A 40-byte hex representation of a SHA-1 or a name that denotes
 	a particular object. These may be stored in `$GIT_DIR/refs/`.
 
 refspec::
@@ -283,7 +283,7 @@ rewind::
 SCM::
 	Source code management (tool).
 
-SHA1::
+SHA-1::
 	Synonym for object name.
 
 shallow repository::
@@ -299,7 +299,7 @@ shallow repository::
 	history can be later deepened with gitlink:git-fetch[1].
 
 symref::
-	Symbolic reference: instead of containing the SHA1 id itself, it
+	Symbolic reference: instead of containing the SHA-1 id itself, it
 	is of the format 'ref: refs/some/thing' and when referenced, it
 	recursively dereferences to this reference. 'HEAD' is a prime
 	example of a symref. Symbolic references are manipulated with
diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index fb0b0b9..563f935 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -5,7 +5,7 @@
 	If the commit is a merge, and if the pretty-format
         is not 'oneline', 'email' or 'raw', an additional line is
         inserted before the 'Author:' line.  This line begins with
-        "Merge: " and the sha1s of ancestral commits are printed,
+        "Merge: " and the SHA-1s of ancestral commits are printed,
         separated by spaces.  Note that the listed commits may not
         necessarily be the list of the *direct* parent commits if you
         have limited your view of history: for example, if you are
@@ -14,20 +14,20 @@
 
         * 'oneline'
 
-	  <sha1> <title line>
+	  <SHA-1> <title line>
 +
 This is designed to be as compact as possible.
 
         * 'short'
 
-	  commit <sha1>
+	  commit <SHA-1>
 	  Author: <author>
 
 	      <title line>
 
         * 'medium'
 
-	  commit <sha1>
+	  commit <SHA-1>
 	  Author: <author>
 	  Date: <date>
 
@@ -37,7 +37,7 @@ This is designed to be as compact as possible.
 
         * 'full'
 
-	  commit <sha1>
+	  commit <SHA-1>
 	  Author: <author>
 	  Commit: <committer>
 
@@ -47,7 +47,7 @@ This is designed to be as compact as possible.
 
         * 'fuller'
 
-	  commit <sha1>
+	  commit <SHA-1>
 	  Author: <author>
 	  AuthorDate: <date & time>
 	  Commit: <committer>
@@ -60,7 +60,7 @@ This is designed to be as compact as possible.
 
         * 'email'
 
-	  From <sha1> <date>
+	  From <SHA-1> <date>
 	  From: <author>
 	  Date: <date & time>
 	  Subject: [PATCH] <title line>
@@ -71,7 +71,7 @@ This is designed to be as compact as possible.
 	* 'raw'
 +
 The 'raw' format shows the entire commit exactly as
-stored in the commit object.  Notably, the SHA1s are
+stored in the commit object.  Notably, the SHA-1s are
 displayed in full, regardless of whether --abbrev or
 --no-abbrev are used, and 'parents' information show the
 true parent commits, without taking grafts nor history
diff --git a/Documentation/tutorial-2.txt b/Documentation/tutorial-2.txt
index f363d17..4b3f42d 100644
--- a/Documentation/tutorial-2.txt
+++ b/Documentation/tutorial-2.txt
@@ -33,14 +33,14 @@ What are the 40 digits of hex that git responded to the commit with?
 
 We saw in part one of the tutorial that commits have names like this.
 It turns out that every object in the git history is stored under
-such a 40-digit hex name.  That name is the SHA1 hash of the object's
+such a 40-digit hex name.  That name is the SHA-1 hash of the object's
 contents; among other things, this ensures that git will never store
-the same data twice (since identical data is given an identical SHA1
+the same data twice (since identical data is given an identical SHA-1
 name), and that the contents of a git object will never change (since
 that would change the object's name as well).
 
 It is expected that the content of the commit object you created while
-following the example above generates a different SHA1 hash than
+following the example above generates a different SHA-1 hash than
 the one shown above because the commit object records the time when
 it was created and the name of the person performing the commit.
 
@@ -64,14 +64,14 @@ A tree can refer to one or more "blob" objects, each corresponding to
 a file.  In addition, a tree can also refer to other tree objects,
 thus creating a directory hierarchy.  You can examine the contents of
 any tree using ls-tree (remember that a long enough initial portion
-of the SHA1 will also work):
+of the SHA-1 will also work):
 
 ------------------------------------------------
 $ git ls-tree 92b8b694
 100644 blob 3b18e512dba79e4c8300dd08aeb37f8e728b8dad    file.txt
 ------------------------------------------------
 
-Thus we see that this tree has one file in it.  The SHA1 hash is a
+Thus we see that this tree has one file in it.  The SHA-1 hash is a
 reference to that file's data:
 
 ------------------------------------------------
@@ -90,7 +90,7 @@ Note that this is the old file data; so the object that git named in
 its response to the initial tree was a tree with a snapshot of the
 directory state that was recorded by the first commit.
 
-All of these objects are stored under their SHA1 names inside the git
+All of these objects are stored under their SHA-1 names inside the git
 directory:
 
 ------------------------------------------------
@@ -126,7 +126,7 @@ ref: refs/heads/master
 
 As you can see, this tells us which branch we're currently on, and it
 tells us this by naming a file under the .git directory, which itself
-contains a SHA1 name referring to a commit object, which we can
+contains a SHA-1 name referring to a commit object, which we can
 examine with cat-file:
 
 ------------------------------------------------
@@ -192,7 +192,7 @@ project's history:
 
 Note, by the way, that lots of commands take a tree as an argument.
 But as we can see above, a tree can be referred to in many different
-ways--by the SHA1 name for that tree, by the name of a commit that
+ways--by the SHA-1 name for that tree, by the name of a commit that
 refers to the tree, by the name of a branch whose head refers to that
 tree, etc.--and most such commands can accept any of these names.
 
diff --git a/builtin-apply.c b/builtin-apply.c
index 3fefdac..814f78f 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1800,8 +1800,9 @@ static int apply_binary(struct buffer_desc *desc, struct patch *patch)
 	const char *name = patch->old_name ? patch->old_name : patch->new_name;
 	unsigned char sha1[20];
 
-	/* For safety, we require patch index line to contain
-	 * full 40-byte textual SHA1 for old and new, at least for now.
+	/* 
+	 * For safety, we require patch index line to contain
+	 * full 40-byte textual SHA-1 for old and new, at least for now.
 	 */
 	if (strlen(patch->old_sha1_prefix) != 40 ||
 	    strlen(patch->new_sha1_prefix) != 40 ||
@@ -1811,7 +1812,8 @@ static int apply_binary(struct buffer_desc *desc, struct patch *patch)
 			     "without full index line", name);
 
 	if (patch->old_name) {
-		/* See if the old one matches what the patch
+		/* 
+		 * See if the old one matches what the patch
 		 * applies to.
 		 */
 		hash_sha1_file(desc->buffer, desc->size, blob_type, sha1);
@@ -1850,7 +1852,8 @@ static int apply_binary(struct buffer_desc *desc, struct patch *patch)
 		desc->alloc = desc->size = size;
 	}
 	else {
-		/* We have verified desc matches the preimage;
+		/* 
+		 * We have verified desc matches the preimage;
 		 * apply the patch data to it, which is stored
 		 * in the patch->fragments->{patch,size}.
 		 */
@@ -2074,8 +2077,9 @@ static void show_index_list(struct patch *list)
 {
 	struct patch *patch;
 
-	/* Once we start supporting the reverse patch, it may be
-	 * worth showing the new sha1 prefix, but until then...
+	/*
+	 * Once we start supporting the reverse patch, it may be
+	 * worth showing the new SHA-1 prefix, but until then...
 	 */
 	for (patch = list; patch; patch = patch->next) {
 		const unsigned char *sha1_ptr;
@@ -2086,7 +2090,7 @@ static void show_index_list(struct patch *list)
 		if (0 < patch->is_new)
 			sha1_ptr = null_sha1;
 		else if (get_sha1(patch->old_sha1_prefix, sha1))
-			die("sha1 information is lacking or useless (%s).",
+			die("SHA-1 information is lacking or useless (%s).",
 			    name);
 		else
 			sha1_ptr = sha1;
diff --git a/builtin-blame.c b/builtin-blame.c
index 4a1accf..9120b08 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -19,7 +19,7 @@ static char blame_usage[] =
 "git-blame [-c] [-l] [-t] [-f] [-n] [-p] [-L n,m] [-S <revs-file>] [-M] [-C] [-C] [commit] [--] file\n"
 "  -c, --compatibility Use the same output mode as git-annotate (Default: off)\n"
 "  -b                  Show blank SHA-1 for boundary commits (Default: off)\n"
-"  -l, --long          Show long commit SHA1 (Default: off)\n"
+"  -l, --long          Show long commit SHA-1 (Default: off)\n"
 "  --root              Do not treat root commits as boundaries (Default: off)\n"
 "  -t, --time          Show raw timestamp (Default: off)\n"
 "  -f, --show-name     Show original filename (Default: auto)\n"
@@ -244,7 +244,8 @@ static struct origin *find_origin(struct scoreboard *sb,
 	const char *paths[2];
 
 	if (parent->util) {
-		/* This is a freestanding copy of origin and not
+		/* 
+		 * This is a freestanding copy of origin and not
 		 * refcounted.
 		 */
 		struct origin *cached = parent->util;
@@ -259,7 +260,8 @@ static struct origin *find_origin(struct scoreboard *sb,
 		parent->util = NULL;
 	}
 
-	/* See if the origin->path is different between parent
+	/* 
+	 * See if the origin->path is different between parent
 	 * and origin first.  Most of the time they are the
 	 * same and diff-tree is fairly efficient about this.
 	 */
@@ -278,7 +280,8 @@ static struct origin *find_origin(struct scoreboard *sb,
 		       "", &diff_opts);
 	diffcore_std(&diff_opts);
 
-	/* It is either one entry that says "modified", or "created",
+	/* 
+	 * It is either one entry that says "modified", or "created",
 	 * or nothing.
 	 */
 	if (!diff_queued_diff.nr) {
@@ -879,7 +882,8 @@ static int find_copy_in_parent(struct scoreboard *sb,
 	if (diff_setup_done(&diff_opts) < 0)
 		die("diff-setup");
 
-	/* Try "find copies harder" on new path if requested;
+	/* 
+	 * Try "find copies harder" on new path if requested;
 	 * we do not want to use diffcore_rename() actually to
 	 * match things up; find_copies_harder is set only to
 	 * force diff_tree_sha1() to feed all filepairs to diff_queue,
@@ -1205,7 +1209,8 @@ static void get_commit_info(struct commit *commit,
 	static char committer_buf[1024];
 	static char summary_buf[1024];
 
-	/* We've operated without save_commit_buffer, so
+	/* 
+	 * We've operated without save_commit_buffer, so
 	 * we now need to populate them for output.
 	 */
 	if (!commit->buffer) {
@@ -1863,7 +1868,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		add_pending_object(&revs, &(sb.final->object), "HEAD");
 	}
 
-	/* If we have bottom, this will mark the ancestors of the
+	/* 
+	 * If we have bottom, this will mark the ancestors of the
 	 * bottom commits we would reach while traversing as
 	 * uninteresting.
 	 */
diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 6c16bfa..088cebf 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -66,7 +66,8 @@ static void pprint_tag(const unsigned char *sha1, const char *buf, unsigned long
 			/* end of header */
 			break;
 	}
-	/* At this point, we have copied out the header up to the end of
+	/* 
+	 * At this point, we have copied out the header up to the end of
 	 * the tagger line and cp points at one past \n.  It could be the
 	 * next header line after the tagger line, or it could be another
 	 * \n that marks the end of the headers.  We need to copy out the
@@ -86,7 +87,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config);
 	if (argc != 3)
-		usage("git-cat-file [-t|-s|-e|-p|<type>] <sha1>");
+		usage("git-cat-file [-t|-s|-e|-p|<type>] <SHA-1>");
 	if (get_sha1(argv[2], sha1))
 		die("Not a valid object name %s", argv[2]);
 
diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index 0651e59..8375395 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -63,7 +63,8 @@ static void check_valid(unsigned char *sha1, const char *expect)
 #define MAXPARENT (16)
 static unsigned char parent_sha1[MAXPARENT][20];
 
-static const char commit_tree_usage[] = "git-commit-tree <sha1> [-p <sha1>]* < changelog";
+static const char commit_tree_usage[] = 
+       "git-commit-tree <sha1> [-p <sha1>]* < changelog";
 
 static int new_parent(int idx)
 {
diff --git a/builtin-describe.c b/builtin-describe.c
index e7b8f95..e2f97d6 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -48,7 +48,8 @@ static int get_name(const char *path, const unsigned char *sha1, int flag, void
 	if (!commit)
 		return 0;
 	object = parse_object(sha1);
-	/* If --all, then any refs are used.
+	/* 
+	 * If --all, then any refs are used.
 	 * If --tags, then any tags are used.
 	 * Otherwise only annotated tags are used.
 	 */
diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index 24cb2d7..339a1ff 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -53,10 +53,11 @@ static int diff_tree_stdin(char *line)
 }
 
 static const char diff_tree_usage[] =
-"git-diff-tree [--stdin] [-m] [-c] [--cc] [-s] [-v] [--pretty] [-t] [-r] [--root] "
-"[<common diff options>] <tree-ish> [<tree-ish>] [<path>...]\n"
-"  -r            diff recursively\n"
-"  --root        include the initial commit as diff against /dev/null\n"
+       "git-diff-tree [--stdin] [-m] [-c] [--cc] [-s] [-v] "
+       "[--pretty] [-t] [-r] [--root] "
+       "[<common diff options>] <tree-ish> [<tree-ish>] [<path>...]\n"
+       "  -r            diff recursively\n"
+       "  --root        include the initial commit as diff against /dev/null\n"
 COMMON_DIFF_OPTIONS_HELP;
 
 int cmd_diff_tree(int argc, const char **argv, const char *prefix)
diff --git a/builtin-diff.c b/builtin-diff.c
index a659020..c1a5f05 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -13,7 +13,8 @@
 #include "log-tree.h"
 #include "builtin.h"
 
-/* NEEDSWORK: struct object has place for name but we _do_
+/* 
+ * NEEDSWORK: struct object has place for name but we _do_
  * know mode when we extracted the blob out of a tree, which
  * we currently lose.
  */
@@ -164,7 +165,8 @@ static int builtin_diff_tree(struct rev_info *revs,
 	if (argc > 1)
 		usage(builtin_diff_usage);
 
-	/* We saw two trees, ent[0] and ent[1].
+	/* 
+	 * We saw two trees, ent[0] and ent[1].
 	 * if ent[1] is uninteresting, they are swapped
 	 */
 	if (ent[1].item->flags & UNINTERESTING)
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index af72a12..ddaa95c 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -579,7 +579,8 @@ static void populate_value(struct refinfo *ref)
 	 */
 	tagged = ((struct tag *)obj)->tagged->sha1;
 
-	/* NEEDSWORK: This derefs tag only once, which
+	/* 
+	 * NEEDSWORK: This derefs tag only once, which
 	 * is good to deal with chains of trust, but
 	 * is not consistent with what deref_tag() does
 	 * which peels the onion to the core.
@@ -645,7 +646,8 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 			return 0;
 	}
 
-	/* We do not open the object yet; sort may only need refname
+	/* 
+	 * We do not open the object yet; sort may only need refname
 	 * to do its job and the resulting list may yet to be pruned
 	 * by maxcount logic.
 	 */
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 8e7540b..a169b4f 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -267,7 +267,7 @@ static const char init_db_usage[] =
 
 /*
  * If you want to, you can share the DB area with any number of branches.
- * That has advantages: you can save space by sharing all the SHA1 objects.
+ * That has advantages: you can save space by sharing all the SHA-1 objects.
  * On the other hand, it might just make lookup slower and messier. You
  * be the judge.  The default case is to have one DB per managed directory.
  */
diff --git a/builtin-log.c b/builtin-log.c
index 503cd1e..55d6a13 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -396,7 +396,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	/*
 	 * Parse the arguments before setup_revisions(), or something
 	 * like "git fmt-patch -o a123 HEAD^.." may fail; a123 is
-	 * possibly a valid SHA1.
+	 * possibly a valid SHA-1.
 	 */
 	for (i = 1, j = 1; i < argc; i++) {
 		if (!strcmp(argv[i], "--stdout"))
@@ -547,7 +547,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		free(commit->buffer);
 		commit->buffer = NULL;
 
-		/* We put one extra blank line between formatted
+		/* 
+		 * We put one extra blank line between formatted
 		 * patches and this flag is used by log-tree code
 		 * to see if it needs to emit a LF before showing
 		 * the log; when using one file per patch, we do
diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index b4f15cc..c46eaf1 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -165,7 +165,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		}
 
 		if (get_sha1(*argv, sha1)) {
-			fprintf(stderr, "Could not get sha1 for %s. Skipping.\n",
+			fprintf(stderr, "Could not get SHA-1 for %s. Skipping.\n",
 					*argv);
 			continue;
 		}
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 3824ee3..35d6bee 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -91,14 +91,14 @@ static int object_ix_hashsz;
  * corresponding pack file where each object's data starts, but the entries
  * do not store the size of the compressed representation (uncompressed
  * size is easily available by examining the pack entry header).  It is
- * also rather expensive to find the sha1 for an object given its offset.
+ * also rather expensive to find the SHA-1 for an object given its offset.
  *
  * We build a hashtable of existing packs (pack_revindex), and keep reverse
  * index here -- pack index file is sorted by object name mapping to offset;
  * this pack_revindex[].revindex array is a list of offset/index_nr pairs
  * ordered by offset, so if you know the offset of an object, next offset
  * is where its packed representation ends and the index_nr can be used to
- * get the object sha1 from the main index.
+ * get the object SHA-1 from the main index.
  */
 struct revindex_entry {
 	unsigned int offset;
@@ -451,7 +451,7 @@ static unsigned long write_object(struct sha1file *f,
 		} else if (obj_type == OBJ_REF_DELTA) {
 			/*
 			 * Deltas with a base reference contain
-			 * an additional 20 bytes for the base sha1.
+			 * an additional 20 bytes for the base SHA-1.
 			 */
 			sha1write(f, entry->delta->sha1, 20);
 			hdrlen += 20;
@@ -590,7 +590,7 @@ static void write_index_file(void)
 	sha1write(f, array, 256 * 4);
 
 	/*
-	 * Write the actual SHA1 entries..
+	 * Write the actual SHA-1 entries..
 	 */
 	list = sorted_by_sha;
 	for (i = 0; i < nr_result; i++) {
@@ -752,7 +752,8 @@ static int pbase_tree_cache_ix_incr(int ix)
 
 static struct pbase_tree {
 	struct pbase_tree *next;
-	/* This is a phony "cache" entry; we are not
+	/* 
+	 * This is a phony "cache" entry; we are not
 	 * going to evict it nor find it through _get()
 	 * mechanism -- this is for the toplevel node that
 	 * would almost always change with any commit.
@@ -770,7 +771,8 @@ static struct pbase_tree_cache *pbase_tree_get(const unsigned char *sha1)
 	int my_ix = pbase_tree_cache_ix(sha1);
 	int available_ix = -1;
 
-	/* pbase-tree-cache acts as a limited hashtable.
+	/* 
+	 * pbase-tree-cache acts as a limited hashtable.
 	 * your object will be found at your index or within a few
 	 * slots after that slot if it is cached.
 	 */
@@ -789,7 +791,8 @@ static struct pbase_tree_cache *pbase_tree_get(const unsigned char *sha1)
 		my_ix = pbase_tree_cache_ix_incr(my_ix);
 	}
 
-	/* Did not find one.  Either we got a bogus request or
+	/* 
+	 * Did not find one.  Either we got a bogus request or
 	 * we need to read and perhaps cache.
 	 */
 	data = read_sha1_file(sha1, type, &size);
@@ -1477,13 +1480,13 @@ static void read_object_list_from_stdin(void)
 		}
 		if (line[0] == '-') {
 			if (get_sha1_hex(line+1, sha1))
-				die("expected edge sha1, got garbage:\n %s",
+				die("expected edge SHA-1, got garbage:\n %s",
 				    line);
 			add_preferred_base(sha1);
 			continue;
 		}
 		if (get_sha1_hex(line, sha1))
-			die("expected sha1, got garbage:\n %s", line);
+			die("expected SHA-1, got garbage:\n %s", line);
 
 		hash = name_hash(line+41);
 		add_preferred_base_object(line+41, hash);
diff --git a/builtin-prune.c b/builtin-prune.c
index 6f0ba0d..fbbf9e5 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -63,7 +63,7 @@ static int prune_dir(int i, char *path)
 			prune_object(path, de->d_name, sha1);
 			continue;
 		}
-		fprintf(stderr, "bad sha1 file: %s/%s\n", path, de->d_name);
+		fprintf(stderr, "bad SHA-1 file: %s/%s\n", path, de->d_name);
 	}
 	closedir(dir);
 	return 0;
diff --git a/builtin-push.c b/builtin-push.c
index 5f4d7d3..3a98474 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -8,7 +8,9 @@
 
 #define MAX_URI (16)
 
-static const char push_usage[] = "git-push [--all] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]";
+static const char push_usage[] = 
+	"git-push [--all] [--tags] [--receive-pack=<git-receive-pack>] "
+	"[--repo=all] [-f | --force] [-v] [<repository> <refspec>...]";
 
 static int all, tags, force, thin = 1, verbose;
 static const char *receivepack;
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 8ba436d..db18a80 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -85,7 +85,11 @@ static void prime_cache_tree(void)
 
 }
 
-static const char read_tree_usage[] = "git-read-tree (<sha> | [[-m [--aggressive] | --reset | --prefix=<prefix>] [-u | -i]] [--exclude-per-directory=<gitignore>] <sha1> [<sha2> [<sha3>]])";
+static const char read_tree_usage[] = 
+       "git-read-tree (<sha> | "
+       "[[-m [--aggressive] | --reset | --prefix=<prefix>] "
+       "[-u | -i]] [--exclude-per-directory=<gitignore>] "
+       "<sha1> [<sha2> [<sha3>]])";
 
 static struct lock_file lock_file;
 
diff --git a/builtin-reflog.c b/builtin-reflog.c
index b443ed9..c24716b 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -249,7 +249,8 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 		return error("not a ref '%s'", ref);
 
 	memset(&cb, 0, sizeof(cb));
-	/* we take the lock for the ref itself to prevent it from
+	/* 
+	 * We take the lock for the ref itself to prevent it from
 	 * getting updated.
 	 */
 	lock = lock_ref_sha1(ref + 5, sha1);
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 1bb3a06..b23707b 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -75,7 +75,8 @@ static void show_commit(struct commit *commit)
 			printf(" %s", sha1_to_hex(o->sha1));
 			o->flags |= TMP_MARK;
 		}
-		/* TMP_MARK is a general purpose flag that can
+		/* 
+		 * TMP_MARK is a general purpose flag that can
 		 * be used locally, but the user should clean
 		 * things up after it is done with them.
 		 */
@@ -107,7 +108,8 @@ static void show_commit(struct commit *commit)
 
 static void show_object(struct object_array_entry *p)
 {
-	/* An object with name "foo\n0000000..." can be used to
+	/* 
+	 * An object with name "foo\n0000000..." can be used to
 	 * confuse downstream git-pack-objects very badly.
 	 */
 	const char *ep = strchr(p->name, '\n');
diff --git a/builtin-rm.c b/builtin-rm.c
index 00dbe39..78bd2f0 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -10,7 +10,7 @@
 #include "tree-walk.h"
 
 static const char builtin_rm_usage[] =
-"git-rm [-f] [-n] [-r] [--cached] [--] <file>...";
+       "git-rm [-f] [-n] [-r] [--cached] [--] <file>...";
 
 static struct {
 	int nr, alloc;
@@ -48,7 +48,8 @@ static int remove_file(const char *name)
 
 static int check_local_mod(unsigned char *head)
 {
-	/* items in list are already sorted in the cache order,
+	/* 
+	 * Items in list are already sorted in the cache order,
 	 * so we could do this a lot more efficiently by using
 	 * tree_desc based traversal if we wanted to, but I am
 	 * lazy, and who cares if removal of files is a tad
@@ -79,7 +80,8 @@ static int check_local_mod(unsigned char *head)
 			continue;
 		}
 		else if (S_ISDIR(st.st_mode)) {
-			/* if a file was removed and it is now a
+			/*
+			 * If a file was removed and it is now a
 			 * directory, that is the same as ENOENT as
 			 * far as git is concerned; we do not track
 			 * directories.
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index edb4042..19cf5b7 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -6,7 +6,7 @@
 #include "revision.h"
 
 static const char shortlog_usage[] =
-"git-shortlog [-n] [-s] [<commit-id>... ]";
+       "git-shortlog [-n] [-s] [<commit-id>... ]";
 
 static char *common_repo_prefix;
 
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index b54c410..91e0e81 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -4,9 +4,13 @@
 #include "builtin.h"
 
 static const char show_branch_usage[] =
-"git-show-branch [--sparse] [--current] [--all] [--remotes] [--topo-order] [--more=count | --list | --independent | --merge-base ] [--topics] [<refs>...] | --reflog[=n[,b]] <branch>";
+       "git-show-branch [--sparse] [--current] [--all] [--remotes] "
+       "[--topo-order] "
+       "[--more=count | --list | --independent | --merge-base ] "
+       "[--topics] [<refs>...] | --reflog[=n[,b]] <branch>";
 static const char show_branch_usage_reflog[] =
-"--reflog is incompatible with --all, --remotes, --independent or --merge-base";
+       "--reflog is incompatible with --all, --remotes, "
+       "--independent or --merge-base";
 
 static int default_num;
 static int default_alloc;
@@ -380,7 +384,8 @@ static int append_head_ref(const char *refname, const unsigned char *sha1, int f
 	int ofs = 11;
 	if (strncmp(refname, "refs/heads/", ofs))
 		return 0;
-	/* If both heads/foo and tags/foo exists, get_sha1 would
+	/* 
+	 * If both heads/foo and tags/foo exists, get_sha1 would
 	 * get confused.
 	 */
 	if (get_sha1(refname + ofs, tmp) || hashcmp(tmp, sha1))
@@ -394,7 +399,8 @@ static int append_remote_ref(const char *refname, const unsigned char *sha1, int
 	int ofs = 13;
 	if (strncmp(refname, "refs/remotes/", ofs))
 		return 0;
-	/* If both heads/foo and tags/foo exists, get_sha1 would
+	/* 
+	 * If both heads/foo and tags/foo exists, get_sha1 would
 	 * get confused.
 	 */
 	if (get_sha1(refname + ofs, tmp) || hashcmp(tmp, sha1))
@@ -422,7 +428,8 @@ static int count_slash(const char *s)
 
 static int append_matching_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
-	/* we want to allow pattern hold/<asterisk> to show all
+	/* 
+	 * We want to allow pattern hold/<asterisk> to show all
 	 * branches under refs/heads/hold/, and v0.99.9? to show
 	 * refs/tags/v0.99.9a and friends.
 	 */
@@ -528,7 +535,7 @@ static void append_one_rev(const char *av)
 			sort_ref_range(saved_matches, ref_name_cnt);
 		return;
 	}
-	die("bad sha1 reference %s", av);
+	die("bad SHA-1 reference %s", av);
 }
 
 static int git_show_branch_config(const char *var, const char *value)
diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index 853f13f..d7b9d8d 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -4,7 +4,10 @@
 #include "tag.h"
 #include "path-list.h"
 
-static const char show_ref_usage[] = "git show-ref [-q|--quiet] [--verify] [-h|--head] [-d|--dereference] [-s|--hash[=<length>]] [--abbrev[=<length>]] [--tags] [--heads] [--] [pattern*] < ref-list";
+static const char show_ref_usage[] = 
+	"git show-ref [-q|--quiet] [--verify] [-h|--head] "
+	"[-d|--dereference] [-s|--hash[=<length>]] "
+	"[--abbrev[=<length>]] [--tags] [--heads] [--] [pattern*] < ref-list";
 
 static int deref_tags = 0, show_head = 0, tags_only = 0, heads_only = 0,
 	found_match = 0, verify = 0, quiet = 0, hash_only = 0, abbrev = 0;
@@ -56,7 +59,8 @@ static int show_ref(const char *refname, const unsigned char *sha1, int flag, vo
 match:
 	found_match++;
 
-	/* This changes the semantics slightly that even under quiet we
+	/* 
+	 * This changes the semantics slightly that even under quiet we
 	 * detect and return error if the repository is corrupt and
 	 * ref points at a nonexistent object.
 	 */
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index d351e02..9a47437 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -395,7 +395,7 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 	SHA1_Update(&ctx, buffer, offset);
 	SHA1_Final(sha1, &ctx);
 	if (hashcmp(fill(20), sha1))
-		die("final sha1 did not match");
+		die("final SHA-1 did not match");
 	use(20);
 
 	/* Write the last part of the buffer to stdout */
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 182331d..10ed20b 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -111,7 +111,8 @@ static int add_file_to_cache(const char *path)
 
 	ce->ce_mode = create_ce_mode(st.st_mode);
 	if (!trust_executable_bit) {
-		/* If there is an existing entry, pick the mode bits
+		/* 
+		 * If there is an existing entry, pick the mode bits
 		 * from it, otherwise assume unexecutable.
 		 */
 		int pos = cache_name_pos(path, namelen);
@@ -228,19 +229,20 @@ static void read_index_info(int line_termination)
 		unsigned int mode;
 		int stage;
 
-		/* This reads lines formatted in one of three formats:
+		/* 
+		 * This reads lines formatted in one of three formats:
 		 *
-		 * (1) mode         SP sha1          TAB path
+		 * (1) mode         SP SHA-1          TAB path
 		 * The first format is what "git-apply --index-info"
 		 * reports, and used to reconstruct a partial tree
 		 * that is used for phony merge base tree when falling
 		 * back on 3-way merge.
 		 *
-		 * (2) mode SP type SP sha1          TAB path
+		 * (2) mode SP type SP SHA-1          TAB path
 		 * The second format is to stuff git-ls-tree output
 		 * into the index file.
 		 *
-		 * (3) mode         SP sha1 SP stage TAB path
+		 * (3) mode         SP SHA-1 SP stage TAB path
 		 * This format is to put higher order stages into the
 		 * index file and matches git-ls-files --stage output.
 		 */
@@ -289,9 +291,10 @@ static void read_index_info(int line_termination)
 				    ptr);
 		}
 		else {
-			/* mode ' ' sha1 '\t' name
+			/* 
+			 * mode ' ' SHA-1 '\t' name
 			 * ptr[-1] points at tab,
-			 * ptr[-41] is at the beginning of sha1
+			 * ptr[-41] is at the beginning of SHA-1
 			 */
 			ptr[-42] = ptr[-1] = 0;
 			if (add_cacheinfo(mode, sha1, path_name, stage))
@@ -308,7 +311,11 @@ static void read_index_info(int line_termination)
 }
 
 static const char update_index_usage[] =
-"git-update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--refresh] [--really-refresh] [--cacheinfo] [--chmod=(+|-)x] [--assume-unchanged] [--info-only] [--force-remove] [--stdin] [--index-info] [--unresolve] [--again | -g] [--ignore-missing] [-z] [--verbose] [--] <file>...";
+        "git-update-index [-q] [--add] [--replace] [--remove] "
+	"[--unmerged] [--refresh] [--really-refresh] [--cacheinfo] "
+	"[--chmod=(+|-)x] [--assume-unchanged] [--info-only] "
+	"[--force-remove] [--stdin] [--index-info] [--unresolve] "
+	"[--again | -g] [--ignore-missing] [-z] [--verbose] [--] <file>...";
 
 static unsigned char head_sha1[20];
 static unsigned char merge_head_sha1[20];
@@ -369,7 +376,8 @@ static int unresolve_one(const char *path)
 		}
 	}
 
-	/* Grab blobs from given path from HEAD and MERGE_HEAD,
+	/* 
+	 * Grab blobs from given path from HEAD and MERGE_HEAD,
 	 * stuff HEAD version in stage #2,
 	 * stuff MERGE_HEAD version in stage #3.
 	 */
@@ -438,7 +446,8 @@ static int do_unresolve(int ac, const char **av,
 static int do_reupdate(int ac, const char **av,
 		       const char *prefix, int prefix_length)
 {
-	/* Read HEAD and run update-index on paths that are
+	/* 
+	 * Read HEAD and run update-index on paths that are
 	 * merged and already different between index and HEAD.
 	 */
 	int pos;
@@ -446,7 +455,8 @@ static int do_reupdate(int ac, const char **av,
 	const char **pathspec = get_pathspec(prefix, av + 1);
 
 	if (read_ref("HEAD", head_sha1))
-		/* If there is no HEAD, that means it is an initial
+		/* 
+		 * If there is no HEAD, that means it is an initial
 		 * commit.  Update everything in the index.
 		 */
 		has_head = 0;
@@ -466,7 +476,8 @@ static int do_reupdate(int ac, const char **av,
 			free(old);
 			continue; /* unchanged */
 		}
-		/* Be careful.  The working tree may not have the
+		/* 
+		 * Be careful.  The working tree may not have the
 		 * path anymore, in which case, under 'allow_remove',
 		 * or worse yet 'allow_replace', active_nr may decrease.
 		 */
@@ -540,7 +551,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				unsigned int mode;
 
 				if (i+3 >= argc)
-					die("git-update-index: --cacheinfo <mode> <sha1> <path>");
+					die("git-update-index: --cacheinfo <mode> <SHA-1> <path>");
 
 				if ((sscanf(argv[i+1], "%o", &mode) != 1) ||
 				    get_sha1_hex(argv[i+2], sha1) ||
diff --git a/builtin-update-ref.c b/builtin-update-ref.c
index b34e598..ebd2a91 100644
--- a/builtin-update-ref.c
+++ b/builtin-update-ref.c
@@ -48,7 +48,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		usage(git_update_ref_usage);
 
 	if (get_sha1(value, sha1))
-		die("%s: not a valid SHA1", value);
+		die("%s: not a valid SHA-1", value);
 
 	if (delete) {
 		if (oldval)
@@ -58,7 +58,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 
 	hashclr(oldsha1);
 	if (oldval && *oldval && get_sha1(oldval, oldsha1))
-		die("%s: not a valid old SHA1", oldval);
+		die("%s: not a valid old SHA-1", oldval);
 
 	lock = lock_any_ref_for_update(refname, oldval ? oldsha1 : NULL);
 	if (!lock)
diff --git a/builtin-write-tree.c b/builtin-write-tree.c
index 50670dc..7e58045 100644
--- a/builtin-write-tree.c
+++ b/builtin-write-tree.c
@@ -39,7 +39,8 @@ int write_tree(unsigned char *sha1, int missing_ok, const char *prefix)
 					&& !close(newfd))
 				commit_lock_file(lock_file);
 		}
-		/* Not being able to write is fine -- we are only interested
+		/*
+		 * Not being able to write is fine -- we are only interested
 		 * in updating the cache-tree part, and if the next caller
 		 * ends up using the old index with unupdated cache-tree part
 		 * it misses the work we did here, but that is just a
diff --git a/cache-tree.c b/cache-tree.c
index 9b73c86..91da11d 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -167,13 +167,15 @@ static int verify_cache(struct cache_entry **cache,
 	if (funny)
 		return -1;
 
-	/* Also verify that the cache does not have path and path/file
+	/* 
+	 * Also verify that the cache does not have path and path/file
 	 * at the same time.  At this point we know the cache has only
 	 * stage 0 entries.
 	 */
 	funny = 0;
 	for (i = 0; i < entries - 1; i++) {
-		/* path/file always comes after path because of the way
+		/* 
+		 * path/file always comes after path because of the way
 		 * the cache is sorted.  Also path can appear only once,
 		 * which means conflicting one would immediately follow.
 		 */
@@ -387,7 +389,8 @@ static void *write_one(struct cache_tree *it,
 {
 	int i;
 
-	/* One "cache-tree" entry consists of the following:
+	/*
+	 * One "cache-tree" entry consists of the following:
 	 * path (NUL terminated)
 	 * entry_count, subtree_nr ("%d %d\n")
 	 * tree-sha1 (missing if invalid)
diff --git a/cache.h b/cache.h
index 473197d..fd2a659 100644
--- a/cache.h
+++ b/cache.h
@@ -214,7 +214,7 @@ extern int check_repository_format(void);
 #define DATA_CHANGED    0x0020
 #define TYPE_CHANGED    0x0040
 
-/* Return a statically allocated filename matching the sha1 signature */
+/* Return a statically allocated filename matching the SHA-1 signature */
 extern char *mkpath(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
 extern char *git_path(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
 extern char *sha1_file_name(const unsigned char *sha1);
diff --git a/combine-diff.c b/combine-diff.c
index 29d0c9c..8ddee2f 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -835,7 +835,7 @@ static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct re
 		}
 		printf("%s%06o", prefix, p->mode);
 
-		/* Show sha1's */
+		/* Show SHA-1's */
 		for (i = 0; i < num_parent; i++)
 			printf(" %s", diff_unique_abbrev(p->parent[i].sha1,
 							 opt->abbrev));
diff --git a/commit.c b/commit.c
index 9b2b842..14b05a1 100644
--- a/commit.c
+++ b/commit.c
@@ -292,7 +292,7 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
 	item->tree = lookup_tree(parent);
 	if (item->tree)
 		n_refs++;
-	bufptr += 46; /* "tree " + "hex sha1" + "\n" */
+	bufptr += 46; /* "tree " + "hex SHA-1" + "\n" */
 	pptr = &item->parents;
 
 	graft = lookup_commit_graft(item->object.sha1);
diff --git a/connect.c b/connect.c
index 7844888..51598f0 100644
--- a/connect.c
+++ b/connect.c
@@ -263,7 +263,8 @@ static int match_explicit_refs(struct ref *src, struct ref *dst,
 		case 1:
 			break;
 		case 0:
-			/* The source could be in the get_sha1() format
+			/*
+			 * The source could be in the get_sha1() format
 			 * not a reference name.  :refs/other is a
 			 * way to delete 'other' ref at the remote end.
 			 */
diff --git a/convert-objects.c b/convert-objects.c
index a630132..1e02ffe 100644
--- a/convert-objects.c
+++ b/convert-objects.c
@@ -238,13 +238,13 @@ static void convert_date(void *buffer, unsigned long size, unsigned char *result
 	char *new = xmalloc(size + 100);
 	unsigned long newlen = 0;
 
-	/* "tree <sha1>\n" */
+	/* "tree <SHA-1>\n" */
 	memcpy(new + newlen, buffer, 46);
 	newlen += 46;
 	buffer = (char *) buffer + 46;
 	size -= 46;
 
-	/* "parent <sha1>\n" */
+	/* "parent <SHA-1>\n" */
 	while (!memcmp(buffer, "parent ", 7)) {
 		memcpy(new + newlen, buffer, 48);
 		newlen += 48;
@@ -273,7 +273,7 @@ static void convert_commit(void *buffer, unsigned long size, unsigned char *resu
 	if (memcmp(buffer, "tree ", 5))
 		die("Bad commit '%s'", (char*) buffer);
 	convert_ascii_sha1((char *) buffer + 5);
-	buffer = (char *) buffer + 46;    /* "tree " + "hex sha1" + "\n" */
+	buffer = (char *) buffer + 46;    /* "tree " + "hex SHA-1" + "\n" */
 	while (!memcmp(buffer, "parent ", 7)) {
 		convert_ascii_sha1((char *) buffer + 7);
 		buffer = (char *) buffer + 48;
diff --git a/csum-file.c b/csum-file.c
index b7174c6..a3fbecd 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2005 Linus Torvalds
  *
- * Simple file write infrastructure for writing SHA1-summed
+ * Simple file write infrastructure for writing SHA-1-summed
  * files. Useful when you write a file that you want to be
  * able to verify hasn't been messed with afterwards.
  */
@@ -24,8 +24,8 @@ static void sha1flush(struct sha1file *f, unsigned int count)
 			return;
 		}
 		if (!ret)
-			die("sha1 file '%s' write error. Out of diskspace", f->name);
-		die("sha1 file '%s' write error (%s)", f->name, strerror(errno));
+			die("SHA-1 file '%s' write error. Out of diskspace", f->name);
+		die("SHA-1 file '%s' write error (%s)", f->name, strerror(errno));
 	}
 }
 
@@ -42,7 +42,7 @@ int sha1close(struct sha1file *f, unsigned char *result, int update)
 	if (update)
 		sha1flush(f, 20);
 	if (close(f->fd))
-		die("%s: sha1 file error on close (%s)", f->name, strerror(errno));
+		die("%s: SHA-1 file error on close (%s)", f->name, strerror(errno));
 	free(f);
 	return 0;
 }
diff --git a/csum-file.h b/csum-file.h
index 3ad1a99..4f2b7ec 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -1,7 +1,7 @@
 #ifndef CSUM_FILE_H
 #define CSUM_FILE_H
 
-/* A SHA1-protected file */
+/* A SHA-1-protected file */
 struct sha1file {
 	int fd, error;
 	unsigned int offset, namelen;
diff --git a/diff-lib.c b/diff-lib.c
index 2c9be60..8877649 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -188,7 +188,8 @@ static void show_new_file(struct rev_info *revs,
 	unsigned char *sha1;
 	unsigned int mode;
 
-	/* New file in the index: it might actually be different in
+	/* 
+         * New file in the index: it might actually be different in
 	 * the working copy.
 	 */
 	if (get_stat_data(new, &sha1, &mode, cached, match_missing) < 0)
@@ -283,7 +284,8 @@ static int diff_cache(struct rev_info *revs,
 						     ce->sha1, ce->ce_mode);
 				break;
 			}
-			/* We come here with ce pointing at stage 1
+			/* 
+			 * We come here with ce pointing at stage 1
 			 * (original tree) and ac[1] pointing at stage
 			 * 3 (unmerged).  show-modified with
 			 * report-missing set to false does not say the
diff --git a/diff.c b/diff.c
index ad476f7..745bbc9 100644
--- a/diff.c
+++ b/diff.c
@@ -1196,7 +1196,8 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
 	struct stat st;
 	int pos, len;
 
-	/* We do not read the cache ourselves here, because the
+	/* 
+	 * We do not read the cache ourselves here, because the
 	 * benchmark with my previous version that always reads cache
 	 * shows that it makes things worse for diff-tree comparing
 	 * two linux-2.6 kernel trees in an already checked out work
@@ -1211,7 +1212,8 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
 	if (!active_cache)
 		return 0;
 
-	/* We want to avoid the working directory if our caller
+	/* 
+	 * We want to avoid the working directory if our caller
 	 * doesn't need the data in a normal file, this system
 	 * is rather slow with its stat/open/mmap/close syscalls,
 	 * and the object is contained in a pack file.  The pack
@@ -1233,7 +1235,8 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
 	    ce_match_stat(ce, &st, 0) ||
 	    hashcmp(sha1, ce->sha1))
 		return 0;
-	/* we return 1 only when we can stat, it is a regular file,
+	/* 
+	 * We return 1 only when we can stat, it is a regular file,
 	 * stat information matches, and sha1 recorded in the cache
 	 * matches.  I.e. we know the file in the work tree really is
 	 * the same as the <name, sha1> pair.
@@ -1442,7 +1445,8 @@ static void prepare_temp_file(const char *name,
 				strcpy(temp->hex, sha1_to_hex(null_sha1));
 			else
 				strcpy(temp->hex, sha1_to_hex(one->sha1));
-			/* Even though we may sometimes borrow the
+			/* 
+			 * Even though we may sometimes borrow the
 			 * contents from the work tree, we always want
 			 * one->mode.  mode is trustworthy even when
 			 * !(one->sha1_valid), as long as
@@ -1498,7 +1502,8 @@ static int spawn_prog(const char *pgm, const char **arg)
 		return -1;
 	}
 
-	/* Earlier we did not check the exit status because
+	/* 
+	 * Earlier we did not check the exit status because
 	 * diff exits non-zero if files are different, and
 	 * we are not interested in knowing that.  It was a
 	 * mistake which made it harder to quit a diff-*
@@ -1512,7 +1517,8 @@ static int spawn_prog(const char *pgm, const char **arg)
 	return -1;
 }
 
-/* An external diff command takes:
+/* 
+ * An external diff command takes:
  *
  * diff-cmd name infile1 infile1-sha1 infile1-mode \
  *               infile2 infile2-sha1 infile2-mode [ rename-to ]
@@ -2204,7 +2210,8 @@ static void diff_flush_name(struct diff_filepair *p, int line_termination)
 
 int diff_unmodified_pair(struct diff_filepair *p)
 {
-	/* This function is written stricter than necessary to support
+	/* 
+	 * This function is written stricter than necessary to support
 	 * the currently implemented transformers, but the idea is to
 	 * let transformers to produce diff_filepairs any way they want,
 	 * and filter and clean them up here before producing the output.
@@ -2217,7 +2224,8 @@ int diff_unmodified_pair(struct diff_filepair *p)
 	one = p->one;
 	two = p->two;
 
-	/* deletion, addition, mode or type change
+	/*
+	 * deletion, addition, mode or type change
 	 * and rename are all interesting.
 	 */
 	if (DIFF_FILE_VALID(one) != DIFF_FILE_VALID(two) ||
@@ -2225,7 +2233,8 @@ int diff_unmodified_pair(struct diff_filepair *p)
 	    strcmp(one->path, two->path))
 		return 0;
 
-	/* both are valid and point at the same path.  that is, we are
+	/* 
+	 * both are valid and point at the same path.  that is, we are
 	 * dealing with a change.
 	 */
 	if (one->sha1_valid && two->sha1_valid &&
@@ -2372,7 +2381,8 @@ static void diff_resolve_rename_copy(void)
 			 p->one->mode != p->two->mode)
 			p->status = DIFF_STATUS_MODIFIED;
 		else {
-			/* This is a "no-change" entry and should not
+			/* 
+			 * This is a "no-change" entry and should not
 			 * happen anymore, but prepare for broken callers.
 			 */
 			error("feeding unmodified %s to diffcore",
@@ -2510,7 +2520,7 @@ static void patch_id_consume(void *priv, char *line, unsigned long len)
 	struct patch_id_t *data = priv;
 	int new_len;
 
-	/* Ignore line numbers when computing the SHA1 of the patch */
+	/* Ignore line numbers when computing the SHA-1 of the patch */
 	if (!strncmp(line, "@@ -", 4))
 		return;
 
@@ -2818,7 +2828,8 @@ void diff_addremove(struct diff_options *options,
 	char concatpath[PATH_MAX];
 	struct diff_filespec *one, *two;
 
-	/* This may look odd, but it is a preparation for
+	/*
+	 * This may look odd, but it is a preparation for
 	 * feeding "there are unchanged files which should
 	 * not produce diffs, but when you are doing copy
 	 * detection you would need them, so here they are"
diff --git a/diffcore-break.c b/diffcore-break.c
index acb18db..eacc9d0 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -10,7 +10,8 @@ static int should_break(struct diff_filespec *src,
 			int break_score,
 			int *merge_score_p)
 {
-	/* dst is recorded as a modification of src.  Are they so
+	/* 
+         * dst is recorded as a modification of src.  Are they so
 	 * different that we are better off recording this as a pair
 	 * of delete and create?
 	 *
diff --git a/diffcore.h b/diffcore.h
index 1ea8067..fc71323 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -4,12 +4,14 @@
 #ifndef _DIFFCORE_H_
 #define _DIFFCORE_H_
 
-/* This header file is internal between diff.c and its diff transformers
+/* 
+ * This header file is internal between diff.c and its diff transformers
  * (e.g. diffcore-rename, diffcore-pickaxe).  Never include this header
  * in anything else.
  */
 
-/* We internally use unsigned short as the score value,
+/* 
+ * We internally use unsigned short as the score value,
  * and rely on an int capable to hold 32-bits.  -B can take
  * -Bmerge_score/break_score format and the two scores are
  * passed around in one int (high 16-bit for merge and low 16-bit
diff --git a/fetch-pack.c b/fetch-pack.c
index 726140a..fc48577 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -584,7 +584,8 @@ static int fetch_pack(int fd[2], int nr_match, char **match)
 	}
 	if (find_common(fd, sha1, ref) < 0)
 		if (keep_pack != 1)
-			/* When cloning, it is not unusual to have
+			/* 
+                         * When cloning, it is not unusual to have
 			 * no common commit.
 			 */
 			fprintf(stderr, "warning: no common commits\n");
diff --git a/fetch.h b/fetch.h
index be48c6f..ee8a5d8 100644
--- a/fetch.h
+++ b/fetch.h
@@ -2,7 +2,7 @@
 #define PULL_H
 
 /*
- * Fetch object given SHA1 from the remote, and store it locally under
+ * Fetch object given SHA-1 from the remote, and store it locally under
  * GIT_OBJECT_DIRECTORY.  Return 0 on success, -1 on failure.  To be
  * provided by the particular implementation.
  */
@@ -17,7 +17,7 @@ extern void prefetch(unsigned char *sha1);
 
 /*
  * Fetch ref (relative to $GIT_DIR/refs) from the remote, and store
- * the 20-byte SHA1 in sha1.  Return 0 on success, -1 on failure.  To
+ * the 20-byte SHA-1 in sha1.  Return 0 on success, -1 on failure.  To
  * be provided by the particular implementation.
  */
 extern int fetch_ref(char *ref, unsigned char *sha1);
diff --git a/fsck-objects.c b/fsck-objects.c
index ecfb014..cc17788 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -449,7 +449,7 @@ static void fsck_dir(int i, char *path)
 			add_sha1_list(sha1, DIRENT_SORT_HINT(de));
 			continue;
 		}
-		fprintf(stderr, "bad sha1 file: %s/%s\n", path, de->d_name);
+		fprintf(stderr, "bad SHA-1 file: %s/%s\n", path, de->d_name);
 	}
 	closedir(dir);
 }
@@ -656,7 +656,7 @@ int main(int argc, char **argv)
 			heads++;
 			continue;
 		}
-		error("invalid parameter: expected sha1, got '%s'", arg);
+		error("invalid parameter: expected SHA-1, got '%s'", arg);
 	}
 
 	/*
diff --git a/git-archimport.perl b/git-archimport.perl
index 2e15781..a24ec8f 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -105,7 +105,7 @@ my %stats  = (			# Track which strategy we used to import:
 );
 
 my %rptags = ();                # my reverse private tags
-                                # to map a SHA1 to a commitid
+                                # to map a SHA-1 to a commitid
 my $TLA = $ENV{'ARCH_CLIENT'} || 'tla';
 
 sub do_abrowse {
@@ -1013,7 +1013,7 @@ sub git_rev_parse {
     return $val;
 }
 
-# resolve a SHA1 to a known patchset
+# resolve a SHA-1 to a known patchset
 sub commitid2pset {
     my $commitid = shift;
     chomp $commitid;
diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 7d62d79..f134d02 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -4,9 +4,9 @@
 #
 # This is the git per-file merge script, called with
 #
-#   $1 - original file SHA1 (or empty)
-#   $2 - file in branch1 SHA1 (or empty)
-#   $3 - file in branch2 SHA1 (or empty)
+#   $1 - original file SHA-1 (or empty)
+#   $2 - file in branch1 SHA-1 (or empty)
+#   $3 - file in branch2 SHA-1 (or empty)
 #   $4 - pathname in repository
 #   $5 - original file mode (or empty)
 #   $6 - file in branch1 mode (or empty)
diff --git a/git-svn.perl b/git-svn.perl
index 83ec03d..d27a90b 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -240,7 +240,7 @@ sub rebuild {
 	while (<$rev_list>) {
 		chomp;
 		my $c = $_;
-		croak "Non-SHA1: $c\n" unless $c =~ /^$sha1$/o;
+		croak "Non-SHA-1: $c\n" unless $c =~ /^$sha1$/o;
 		my @commit = grep(/^git-svn-id: /,
 		                  command(qw/cat-file commit/, $c));
 		next if (!@commit); # skip merges
@@ -2534,7 +2534,7 @@ sub libsvn_skip_unknown_revs {
 # And yes, it's still pretty fast (faster than Tie::File).
 sub revdb_set {
 	my ($file, $rev, $commit) = @_;
-	length $commit == 40 or croak "arg3 must be a full SHA1 hexsum\n";
+	length $commit == 40 or croak "arg3 must be a full SHA-1 hexsum\n";
 	open my $fh, '+<', $file or croak $!;
 	my $offset = $rev * 41;
 	# assume that append is the common case:
@@ -2754,7 +2754,7 @@ sub close_file {
 		chomp($hash = do { local $/; <$out> });
 		close $out or croak $!;
 		close $fh or croak $!;
-		$hash =~ /^[a-f\d]{40}$/ or die "not a sha1: $hash\n";
+		$hash =~ /^[a-f\d]{40}$/ or die "not a SHA-1: $hash\n";
 		close $fb->{base} or croak $!;
 	} else {
 		$hash = $fb->{blob} or die "no blob information\n";
diff --git a/http-fetch.c b/http-fetch.c
index 67dfb0a..bafb0be 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -191,7 +191,7 @@ static void start_object_request(struct object_request *obj_req)
 	}
 	unlink(prevfile);
 
-	/* Reset inflate/SHA1 if there was an error reading the previous temp
+	/* Reset inflate/SHA-1 if there was an error reading the previous temp
 	   file; also rewind to the beginning of the local file. */
 	if (prev_read == -1) {
 		memset(&obj_req->stream, 0, sizeof(obj_req->stream));
@@ -417,8 +417,10 @@ static int fetch_index(struct alt_base *repo, unsigned char *sha1)
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
 	slot->local = indexfile;
 
-	/* If there is data present from a previous transfer attempt,
-	   resume where it left off */
+	/* 
+         * If there is data present from a previous transfer attempt,
+         * resume where it left off 
+         */
 	prev_posn = ftell(indexfile);
 	if (prev_posn>0) {
 		if (get_verbosely)
diff --git a/http-push.c b/http-push.c
index 0a15f53..387c849 100644
--- a/http-push.c
+++ b/http-push.c
@@ -304,7 +304,7 @@ static void start_fetch_loose(struct transfer_request *request)
 	}
 	unlink(prevfile);
 
-	/* Reset inflate/SHA1 if there was an error reading the previous temp
+	/* Reset inflate/SHA-1 if there was an error reading the previous temp
 	   file; also rewind to the beginning of the local file. */
 	if (prev_read == -1) {
 		memset(&request->stream, 0, sizeof(request->stream));
@@ -2167,7 +2167,7 @@ static void fetch_symref(const char *path, char **symref, unsigned char *sha1)
 	if (buffer.posn == 0)
 		return;
 
-	/* If it's a symref, set the refname; otherwise try for a sha1 */
+	/* If it's a symref, set the refname; otherwise try for a SHA-1 */
 	if (!strncmp((char *)buffer.buffer, "ref: ", 5)) {
 		*symref = xmalloc(buffer.posn - 5);
 		strlcpy(*symref, (char *)buffer.buffer + 5, buffer.posn - 5);
@@ -2426,7 +2426,8 @@ int main(int argc, char **argv)
 			if (!has_sha1_file(ref->old_sha1) ||
 			    !ref_newer(ref->peer_ref->new_sha1,
 				       ref->old_sha1)) {
-				/* We do not have the remote ref, or
+				/*
+				 * We do not have the remote ref, or
 				 * we know that the remote ref is not
 				 * an ancestor of what we are trying to
 				 * push.  Either way this can be losing
diff --git a/index-pack.c b/index-pack.c
index 72e0962..f718439 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -413,7 +413,7 @@ static int compare_delta_entry(const void *a, const void *b)
 	return memcmp(&delta_a->base, &delta_b->base, UNION_BASE_SZ);
 }
 
-/* Parse all objects and return the pack content SHA1 hash */
+/* Parse all objects and return the pack content SHA-1 hash */
 static void parse_pack_objects(unsigned char *sha1)
 {
 	int i, percent = -1;
@@ -424,8 +424,8 @@ static void parse_pack_objects(unsigned char *sha1)
 	/*
 	 * First pass:
 	 * - find locations of all objects;
-	 * - calculate SHA1 of all non-delta objects;
-	 * - remember base (SHA1 or offset) for all deltas.
+	 * - calculate SHA-1 of all non-delta objects;
+	 * - remember base (SHA-1 or offset) for all deltas.
 	 */
 	if (verbose)
 		fprintf(stderr, "Indexing %d objects.\n", nr_objects);
@@ -451,7 +451,7 @@ static void parse_pack_objects(unsigned char *sha1)
 	flush();
 	SHA1_Final(sha1, &input_ctx);
 	if (hashcmp(fill(20), sha1))
-		die("pack is corrupted (SHA1 mismatch)");
+		die("pack is corrupted (SHA-1 mismatch)");
 	use(20);
 
 	/* If input_fd is a file, we should have reached its end now. */
@@ -463,7 +463,7 @@ static void parse_pack_objects(unsigned char *sha1)
 	if (!nr_deltas)
 		return;
 
-	/* Sort deltas by base SHA1/offset for fast searching */
+	/* Sort deltas by base SHA-1/offset for fast searching */
 	qsort(deltas, nr_deltas, sizeof(struct delta_entry),
 	      compare_delta_entry);
 
@@ -647,7 +647,7 @@ static void readjust_pack_header_and_sha1(unsigned char *sha1)
 	if (lseek(output_fd, 0, SEEK_SET) != 0)
 		die("cannot seek back: %s", strerror(errno));
 
-	/* Recompute and store the new pack's SHA1 */
+	/* Recompute and store the new pack's SHA-1 */
 	SHA1_Init(&ctx);
 	do {
 		unsigned char *buf[4096];
@@ -668,8 +668,8 @@ static int sha1_compare(const void *_a, const void *_b)
 }
 
 /*
- * On entry *sha1 contains the pack content SHA1 hash, on exit it is
- * the SHA1 hash of sorted object names.
+ * On entry *sha1 contains the pack content SHA-1 hash, on exit it is
+ * the SHA-1 hash of sorted object names.
  */
 static const char *write_index_file(const char *index_name, unsigned char *sha1)
 {
@@ -725,13 +725,13 @@ static const char *write_index_file(const char *index_name, unsigned char *sha1)
 	}
 	sha1write(f, array, 256 * sizeof(int));
 
-	/* recompute the SHA1 hash of sorted object names.
+	/* recompute the SHA-1 hash of sorted object names.
 	 * currently pack-objects does not do this, but that
 	 * can be fixed.
 	 */
 	SHA1_Init(&ctx);
 	/*
-	 * Write the actual SHA1 entries..
+	 * Write the actual SHA-1 entries..
 	 */
 	list = sorted_by_sha;
 	for (i = 0; i < nr_objects; i++) {
@@ -931,7 +931,7 @@ int main(int argc, char **argv)
 			die("pack has %d unresolved deltas",
 			    nr_deltas - nr_resolved_deltas);
 	} else {
-		/* Flush remaining pack final 20-byte SHA1. */
+		/* Flush remaining pack final 20-byte SHA-1. */
 		flush();
 	}
 	free(deltas);
diff --git a/merge-tree.c b/merge-tree.c
index 692ede0..72c9835 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -274,14 +274,14 @@ static void unresolved(const char *base, struct name_entry n[3])
  *
  * The output will be either:
  *  - successful merge
- *	 "0 mode sha1 filename"
+ *	 "0 mode SHA-1 filename"
  *    NOTE NOTE NOTE! FIXME! We really really need to walk the index
  *    in parallel with this too!
  *
  *  - conflict:
- *	"1 mode sha1 filename"
- *	"2 mode sha1 filename"
- *	"3 mode sha1 filename"
+ *	"1 mode SHA-1 filename"
+ *	"2 mode SHA-1 filename"
+ *	"3 mode SHA-1 filename"
  *    where not all of the 1/2/3 lines may exist, of course.
  *
  * The successful merge rules are the same as for the three-way merge
diff --git a/mktag.c b/mktag.c
index 3448a5d..d9ae24c 100644
--- a/mktag.c
+++ b/mktag.c
@@ -3,13 +3,13 @@
 
 /*
  * A signature file has a very simple fixed format: four lines
- * of "object <sha1>" + "type <typename>" + "tag <tagname>" +
+ * of "object <SHA-1>" + "type <typename>" + "tag <tagname>" +
  * "tagger <committer>", followed by a blank line, a free-form tag
  * message and a signature block that git itself doesn't care about,
  * but that can be verified with gpg or similar.
  *
  * The first three lines are guaranteed to be at least 63 bytes:
- * "object <sha1>\n" is 48 bytes, "type tag\n" at 9 bytes is the
+ * "object <SHA-1>\n" is 48 bytes, "type tag\n" at 9 bytes is the
  * shortest possible type-line, and "tag .\n" at 6 bytes is the
  * shortest single-character-tag line. 
  *
@@ -133,7 +133,7 @@ int main(int argc, char **argv)
 	}
 
 	/* Verify it for some basic sanity: it needs to start with
-	   "object <sha1>\ntype\ntagger " */
+	   "object <SHA-1>\ntype\ntagger " */
 	if (verify_tag(buffer, size) < 0)
 		die("invalid tag signature file");
 
diff --git a/mktree.c b/mktree.c
index 56205d1..08de0d0 100644
--- a/mktree.c
+++ b/mktree.c
@@ -103,8 +103,9 @@ int main(int ac, char **av)
 			break;
 		len = sb.len;
 		ptr = sb.buf;
-		/* Input is non-recursive ls-tree output format
-		 * mode SP type SP sha1 TAB name
+		/* 
+                 * Input is non-recursive ls-tree output format
+		 * mode SP type SP SHA-1 TAB name
 		 */
 		mode = strtoul(ptr, &ntr, 8);
 		if (ptr == ntr || !ntr || *ntr != ' ')
@@ -117,7 +118,7 @@ int main(int ac, char **av)
 			die("input format error: %s", sb.buf);
 		if (sha1_object_info(sha1, type, NULL))
 			die("object %s unavailable", sha1_to_hex(sha1));
-		*ntr++ = 0; /* now at the beginning of SHA1 */
+		*ntr++ = 0; /* now at the beginning of SHA-1 */
 		if (strcmp(ptr, type))
 			die("object type %s mismatch (%s)", ptr, type);
 		ntr += 41; /* at the beginning of name */
diff --git a/object.c b/object.c
index de244e2..05afc52 100644
--- a/object.c
+++ b/object.c
@@ -183,7 +183,7 @@ struct object *parse_object(const unsigned char *sha1)
 	if (buffer) {
 		struct object *obj;
 		if (check_sha1_signature(sha1, buffer, size, type) < 0)
-			printf("sha1 mismatch %s\n", sha1_to_hex(sha1));
+			printf("SHA-1 mismatch %s\n", sha1_to_hex(sha1));
 
 		obj = parse_object_buffer(sha1, type, size, buffer, &eaten);
 		if (!eaten)
diff --git a/pack-check.c b/pack-check.c
index 08a9fd8..d735d8b 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -28,10 +28,10 @@ static int verify_packfile(struct packed_git *p,
 	}
 	SHA1_Final(sha1, &ctx);
 	if (hashcmp(sha1, use_pack(p, w_curs, pack_sig, NULL)))
-		return error("Packfile %s SHA1 mismatch with itself",
+		return error("Packfile %s SHA-1 mismatch with itself",
 			     p->pack_name);
 	if (hashcmp(sha1, (unsigned char *)index_base + index_size - 40))
-		return error("Packfile %s SHA1 mismatch with idx",
+		return error("Packfile %s SHA-1 mismatch with idx",
 			     p->pack_name);
 	unuse_pack(w_curs);
 
@@ -130,12 +130,12 @@ int verify_pack(struct packed_git *p, int verbose)
 	int ret;
 
 	ret = 0;
-	/* Verify SHA1 sum of the index file */
+	/* Verify SHA-1 sum of the index file */
 	SHA1_Init(&ctx);
 	SHA1_Update(&ctx, index_base, index_size - 20);
 	SHA1_Final(sha1, &ctx);
 	if (hashcmp(sha1, (unsigned char *)index_base + index_size - 20))
-		ret = error("Packfile index for %s SHA1 mismatch",
+		ret = error("Packfile index for %s SHA-1 mismatch",
 			    p->pack_name);
 
 	if (!ret) {
diff --git a/patch-id.c b/patch-id.c
index 086d2d9..f036c78 100644
--- a/patch-id.c
+++ b/patch-id.c
@@ -60,7 +60,7 @@ static void generate_id_list(void)
 		if (!memcmp(line, "index ", 6))
 			continue;
 
-		/* Ignore line numbers when computing the SHA1 of the patch */
+		/* Ignore line numbers when computing the SHA-1 of the patch */
 		if (!memcmp(line, "@@ -", 4))
 			continue;
 
diff --git a/read-cache.c b/read-cache.c
index c54a611..2647e96 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -227,7 +227,7 @@ int ce_modified(struct cache_entry *ce, struct stat *st, int really)
 
 	/* Immediately after read-tree or update-index --cacheinfo,
 	 * the length field is zero.  For other cases the ce_size
-	 * should match the SHA1 recorded in the index entry.
+	 * should match the SHA-1 recorded in the index entry.
 	 */
 	if ((changed & DATA_CHANGED) && ce->ce_size != htonl(0))
 		return changed;
@@ -630,7 +630,7 @@ int add_cache_entry(struct cache_entry *ce, int option)
 }
 
 /*
- * "refresh" does not calculate a new sha1 file or bring the
+ * "refresh" does not calculate a new SHA-1 file or bring the
  * cache up-to-date for mode/content changes. But what it
  * _does_ do is to "re-match" the stat information of a file
  * with the cache, so that you can refresh the cache for a
@@ -924,7 +924,7 @@ static int ce_flush(SHA_CTX *context, int fd)
 		left = 0;
 	}
 
-	/* Append the SHA1 signature at the end */
+	/* Append the SHA-1 signature at the end */
 	SHA1_Final(write_buffer + left, context);
 	left += 20;
 	return (write_in_full(fd, write_buffer, left) != left) ? -1 : 0;
diff --git a/receive-pack.c b/receive-pack.c
index 6333f00..301738c 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -340,7 +340,7 @@ static const char *unpack(void)
 		/*
 		 * The first thing we expects from index-pack's output
 		 * is "pack\t%40s\n" or "keep\t%40s\n" (46 bytes) where
-		 * %40s is the newly created pack SHA1 name.  In the "keep"
+		 * %40s is the newly created pack SHA-1 name.  In the "keep"
 		 * case, we need it to remove the corresponding .keep file
 		 * later on.  If we don't get that then tough luck with it.
 		 */
diff --git a/refs.c b/refs.c
index 8117328..85a0a42 100644
--- a/refs.c
+++ b/refs.c
@@ -20,7 +20,7 @@ static const char *parse_ref_line(char *line, unsigned char *sha1)
 	 * 42: the answer to everything.
 	 *
 	 * In this case, it happens to be the answer to
-	 *  40 (length of sha1 hex representation)
+	 *  40 (length of SHA-1 hex representation)
 	 *  +1 (space in between hex and name)
 	 *  +1 (newline at the end of the line)
 	 */
diff --git a/setup.c b/setup.c
index e9d3f5a..47872f3 100644
--- a/setup.c
+++ b/setup.c
@@ -141,7 +141,7 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
  *  - a refs/ directory
  *  - either a HEAD symlink or a HEAD file that is formatted as
  *    a proper "ref:", or a regular file HEAD that has a properly
- *    formatted sha1 object name.
+ *    formatted SHA-1 object name.
  */
 static int is_git_directory(const char *suspect)
 {
diff --git a/sha1_file.c b/sha1_file.c
index 43ff402..443174d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  *
- * This handles basic git sha1 object files - packing, unpacking,
+ * This handles basic git SHA-1 object files - packing, unpacking,
  * creation etc.
  */
 #include "cache.h"
@@ -149,7 +149,7 @@ static void fill_sha1_path(char *pathbuf, const unsigned char *sha1)
  * filename.
  *
  * Also note that this returns the location for creating.  Reading
- * SHA1 file can happen from any alternate directory listed in the
+ * SHA-1 file can happen from any alternate directory listed in the
  * DB_ENVIRONMENT environment variable if it is not found in
  * the primary object database.
  */
@@ -238,7 +238,7 @@ static void read_info_alternates(const char * alternates, int depth);
  * contains "/the/directory/corresponding/to/.git/objects/...", while
  * its name points just after the slash at the end of ".git/objects/"
  * in the example above, and has enough space to hold 40-byte hex
- * SHA1, an extra slash for the first level indirection, and the
+ * SHA-1, an extra slash for the first level indirection, and the
  * terminating NUL.
  */
 static int link_alt_odb_entry(const char * entry, int len, const char * relative_base, int depth)
@@ -480,8 +480,8 @@ static int check_packed_git_idx(const char *path, unsigned long *idx_size_,
 	 * Total size:
 	 *  - 256 index entries 4 bytes each
 	 *  - 24-byte entries * nr (20-byte sha1 + 4-byte offset)
-	 *  - 20-byte SHA1 of the packfile
-	 *  - 20-byte SHA1 file checksum
+	 *  - 20-byte SHA-1 of the packfile
+	 *  - 20-byte SHA-1 file checksum
 	 */
 	if (idx_size != 4*256 + nr * 24 + 20 + 20)
 		return error("wrong index file size in %s", path);
@@ -1618,7 +1618,7 @@ int move_temp_to_file(const char *tmpfile, const char *filename)
 	unlink(tmpfile);
 	if (ret) {
 		if (ret != EEXIST) {
-			return error("unable to write sha1 filename %s: %s\n", filename, strerror(ret));
+			return error("unable to write SHA-1 filename %s: %s\n", filename, strerror(ret));
 		}
 		/* FIXME!!! Collision check here ? */
 	}
@@ -1753,7 +1753,7 @@ int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned cha
 	size = stream.total_out;
 
 	if (write_buffer(fd, compressed, size) < 0)
-		die("unable to write sha1 file");
+		die("unable to write SHA-1 file");
 	fchmod(fd, 0444);
 	close(fd);
 	free(compressed);
@@ -1869,7 +1869,7 @@ int write_sha1_from_fd(const unsigned char *sha1, int fd, char *buffer,
 					    stream.avail_out);
 			} while (stream.avail_in && ret == Z_OK);
 			if (write_buffer(local, buffer, *bufposn - stream.avail_in) < 0)
-				die("unable to write sha1 file");
+				die("unable to write SHA-1 file");
 			memmove(buffer, buffer + *bufposn - stream.avail_in,
 				stream.avail_in);
 			*bufposn = stream.avail_in;
diff --git a/sha1_name.c b/sha1_name.c
index 9dfb3ac..b4bf045 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -182,7 +182,7 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 
 	status = find_unique_short_object(i, canonical, res, sha1);
 	if (!quietly && (status == SHORT_NAME_AMBIGUOUS))
-		return error("short SHA1 %.*s is ambiguous.", len, canonical);
+		return error("short SHA-1 %.*s is ambiguous.", len, canonical);
 	return status;
 }
 
diff --git a/upload-pack.c b/upload-pack.c
index 3648aae..ba3faae 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -343,7 +343,7 @@ static int got_sha1(char *hex, unsigned char *sha1)
 	int we_knew_they_have = 0;
 
 	if (get_sha1_hex(hex, sha1))
-		die("git-upload-pack: expected SHA1 object, got '%s'", hex);
+		die("git-upload-pack: expected SHA-1 object, got '%s'", hex);
 	if (!has_sha1_file(sha1))
 		return -1;
 
@@ -484,7 +484,7 @@ static int get_common_commits(void)
 			packet_write(1, "NAK\n");
 			return -1;
 		}
-		die("git-upload-pack: expected SHA1 list, got '%s'", line);
+		die("git-upload-pack: expected SHA-1 list, got '%s'", line);
 	}
 }
 
-- 
1.5.0.rc2
