From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/2] Documentation: replace SHA1 by SHA-1
Date: Fri, 24 Apr 2009 16:49:35 +0200
Message-ID: <1240584575-5702-3-git-send-email-git@drmicha.warpmail.net>
References: <1240584575-5702-1-git-send-email-git@drmicha.warpmail.net>
 <1240584575-5702-2-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 24 16:52:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxMlW-0005Ku-96
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 16:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757737AbZDXOt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 10:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757325AbZDXOtz
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 10:49:55 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:50966 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757008AbZDXOts (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2009 10:49:48 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 1294B322885;
	Fri, 24 Apr 2009 10:49:48 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 24 Apr 2009 10:49:48 -0400
X-Sasl-enc: pHmGqc2i5azLcpShp9FoWhdIPkGpYsvGdiXbvdGJoNMy 1240584587
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 04FA339103;
	Fri, 24 Apr 2009 10:49:46 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.rc1.51.gea0b7
In-Reply-To: <1240584575-5702-2-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117445>

Replace SHA1 by SHA-1 with the following exceptions:

* asciidoc anchor definitions
* irc conversations contained as documentation
  (Documentation/technical/pack-heuristics.txt)

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/config.txt                           |    2 +-
 Documentation/git-cat-file.txt                     |    6 +++---
 Documentation/git-describe.txt                     |    2 +-
 Documentation/git-fsck.txt                         |    4 ++--
 Documentation/git-index-pack.txt                   |    2 +-
 Documentation/git-ls-files.txt                     |    2 +-
 Documentation/git-merge-index.txt                  |    2 +-
 Documentation/git-pack-objects.txt                 |    2 +-
 Documentation/git-patch-id.txt                     |    2 +-
 Documentation/git-rev-parse.txt                    |    8 ++++----
 Documentation/git-show-branch.txt                  |    4 ++--
 Documentation/git-show-index.txt                   |    2 +-
 Documentation/git-show-ref.txt                     |    4 ++--
 Documentation/git-tag.txt                          |    2 +-
 Documentation/git-update-index.txt                 |    2 +-
 Documentation/git-verify-pack.txt                  |    4 ++--
 Documentation/git-verify-tag.txt                   |    2 +-
 Documentation/git.txt                              |   10 +++++-----
 Documentation/gitcore-tutorial.txt                 |    8 ++++----
 Documentation/gitdiffcore.txt                      |    2 +-
 Documentation/githooks.txt                         |    2 +-
 Documentation/gittutorial-2.txt                    |   16 ++++++++--------
 Documentation/glossary-content.txt                 |    8 ++++----
 .../howto/recover-corrupted-blob-object.txt        |    6 +++---
 Documentation/pretty-formats.txt                   |    2 +-
 Documentation/technical/pack-format.txt            |   14 +++++++-------
 Documentation/technical/pack-protocol.txt          |   20 ++++++++++----------
 Documentation/technical/shallow.txt                |    4 ++--
 28 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f3ebd2f..4deac24 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -271,7 +271,7 @@ core.worktree::
 core.logAllRefUpdates::
 	Enable the reflog. Updates to a ref <ref> is logged to the file
 	"$GIT_DIR/logs/<ref>", by appending the new and old
-	SHA1, the date/time and the reason of the update, but
+	SHA-1, the date/time and the reason of the update, but
 	only when the file exists.  If this configuration
 	variable is set to true, missing "$GIT_DIR/logs/<ref>"
 	file is automatically created for branch heads.
diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index db56d6e..c9385f7 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -19,7 +19,7 @@ the repository. The type is required unless '-t' or '-p' is used to find the
 object type, or '-s' is used to find the object size.
 
 In the second form, a list of objects (separated by linefeeds) is provided on
-stdin, and the SHA1, type, and size of each object is printed on stdout.
+stdin, and the SHA-1, type, and size of each object is printed on stdout.
 
 OPTIONS
 -------
@@ -52,11 +52,11 @@ OPTIONS
 	points at it.
 
 --batch::
-	Print the SHA1, type, size, and contents of each object provided on
+	Print the SHA-1, type, size, and contents of each object provided on
 	stdin. May not be combined with any other options or arguments.
 
 --batch-check::
-	Print the SHA1, type, and size of each object provided on stdin. May not
+	Print the SHA-1, type, and size of each object provided on stdin. May not
 	be combined with any other options or arguments.
 
 OUTPUT
diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index b231dbb..c051b5c 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -129,7 +129,7 @@ is found, its name will be output and searching will stop.
 If an exact match was not found, 'git-describe' will walk back
 through the commit history to locate an ancestor commit which
 has been tagged.  The ancestor's tag will be output along with an
-abbreviation of the input committish's SHA1.
+abbreviation of the input committish's SHA-1.
 
 If multiple tags were found during the walk then the tag which
 has the fewest commits different from the input committish will be
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 73e1dc4..88d12fc 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -22,7 +22,7 @@ OPTIONS
 	An object to treat as the head of an unreachability trace.
 +
 If no objects are given, 'git-fsck' defaults to using the
-index file, all SHA1 references in .git/refs/*, and all reflogs (unless
+index file, all SHA-1 references in .git/refs/*, and all reflogs (unless
 --no-reflogs is given) as heads.
 
 --unreachable::
@@ -71,7 +71,7 @@ index file, all SHA1 references in .git/refs/*, and all reflogs (unless
 	a blob, the contents are written into the file, rather than
 	its object name.
 
-It tests SHA1 and general object sanity, and it does full tracking of
+It tests SHA-1 and general object sanity, and it does full tracking of
 the resulting reachability and everything else. It prints out any
 corruption it finds (missing or bad objects), and if you use the
 '--unreachable' flag it will also print out objects that exist but
diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 4b5c743..3f499a2 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -83,7 +83,7 @@ Note
 ----
 
 Once the index has been created, the list of object names is sorted
-and the SHA1 hash of that list is printed to stdout. If --stdin was
+and the SHA-1 hash of that list is printed to stdout. If --stdin was
 also used then this is prefixed by either "pack\t", or "keep\t" if a
 new .keep file was successfully created. This is useful to remove a
 .keep file used as a lock to prevent the race with 'git-repack'
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 057a021..1f1ce15 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -146,7 +146,7 @@ which case it outputs:
 'git-ls-files --unmerged' and 'git-ls-files --stage' can be used to examine
 detailed information on unmerged paths.
 
-For an unmerged path, instead of recording a single mode/SHA1 pair,
+For an unmerged path, instead of recording a single mode/SHA-1 pair,
 the index records up to three such pairs; one from tree O in stage
 1, A in stage 2, and B in stage 3.  This information can be used by
 the user (or the porcelain) to see what should eventually be recorded at the
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index 123e6d0..d7262ff 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 This looks up the <file>(s) in the index and, if there are any merge
-entries, passes the SHA1 hash for those files as arguments 1, 2, 3 (empty
+entries, passes the SHA-1 hash for those files as arguments 1, 2, 3 (empty
 argument if no file), and <file> as argument 4.  File modes for the three
 files are passed as arguments 5, 6 and 7.
 
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 7d4c1a7..fbbea99 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -47,7 +47,7 @@ base-name::
 	Write into a pair of files (.pack and .idx), using
 	<base-name> to determine the name of the created file.
 	When this option is used, the two files are written in
-	<base-name>-<SHA1>.{pack,idx} files.  <SHA1> is a hash
+	<base-name>-<SHA-1>.{pack,idx} files.  <SHA-1> is a hash
 	of the sorted object names to make the resulting filename
 	based on the pack content, and written to the standard
 	output of the command.
diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
index 253fc0f..e37c815 100644
--- a/Documentation/git-patch-id.txt
+++ b/Documentation/git-patch-id.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-A "patch ID" is nothing but a SHA1 of the diff associated with a patch, with
+A "patch ID" is nothing but a SHA-1 of the diff associated with a patch, with
 whitespace and line numbers ignored.  As such, it's "reasonably stable", but at
 the same time also reasonably unique, i.e., two patches that have the same "patch
 ID" are almost guaranteed to be the same thing.
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 5ed2bc8..9fa0622 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -72,7 +72,7 @@ OPTIONS
 	one.
 
 --symbolic::
-	Usually the object names are output in SHA1 form (with
+	Usually the object names are output in SHA-1 form (with
 	possible '{caret}' prefix); this option makes them output in a
 	form as close to the original input as possible.
 
@@ -122,7 +122,7 @@ OPTIONS
 
 --short::
 --short=number::
-	Instead of outputting the full SHA1 values of object names try to
+	Instead of outputting the full SHA-1 values of object names try to
 	abbreviate them to a shorter unique name. When no length is specified
 	7 is used. The minimum length is 4.
 
@@ -144,12 +144,12 @@ SPECIFYING REVISIONS
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
index 7e9ff37..1259058 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -29,7 +29,7 @@ no <rev> nor <glob> is given on the command line.
 OPTIONS
 -------
 <rev>::
-	Arbitrary extended SHA1 expression (see linkgit:git-rev-parse[1])
+	Arbitrary extended SHA-1 expression (see linkgit:git-rev-parse[1])
 	that typically names a branch head or a tag.
 
 <glob>::
@@ -123,7 +123,7 @@ displayed, indented N places.  If a commit is on the I-th
 branch, the I-th indentation character shows a `+` sign;
 otherwise it shows a space.  Merge commits are denoted by
 a `-` sign.  Each commit shows a short name that
-can be used as an extended SHA1 to name that commit.
+can be used as an extended SHA-1 to name that commit.
 
 The following example shows three branches, "master", "fixes"
 and "mhf":
diff --git a/Documentation/git-show-index.txt b/Documentation/git-show-index.txt
index e3285aa..d30dd25 100644
--- a/Documentation/git-show-index.txt
+++ b/Documentation/git-show-index.txt
@@ -18,7 +18,7 @@ Reads given idx file for packed git archive created with
 
 The information it outputs is subset of what you can get from
 'git-verify-pack -v'; this command only shows the packfile
-offset and SHA1 of each object.
+offset and SHA-1 of each object.
 
 
 Author
diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 2f173ff..5dedffb 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -50,8 +50,8 @@ OPTIONS
 -s::
 --hash::
 
-	Only show the SHA1 hash, not the reference name. When also using
-	--dereference the dereferenced tag will still be shown after the SHA1.
+	Only show the SHA-1 hash, not the reference name. When also using
+	--dereference the dereferenced tag will still be shown after the SHA-1.
 
 --verify::
 
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index fa73321..b93248c 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -30,7 +30,7 @@ in the tag message.
 If `-m <msg>` or `-F <file>` is given and `-a`, `-s`, and `-u <key-id>`
 are absent, `-a` is implied.
 
-Otherwise just the SHA1 object name of the commit object is
+Otherwise just the SHA-1 object name of the commit object is
 written (i.e. a lightweight tag).
 
 A GnuPG signed tag object will be created when `-s` or `-u
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index ab98949..b946b02 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -225,7 +225,7 @@ $ git update-index --index-info
 ------------
 
 The first line of the input feeds 0 as the mode to remove the
-path; the SHA1 does not matter as long as it is well formatted.
+path; the SHA-1 does not matter as long as it is well formatted.
 Then the second and third line feeds stage 1 and stage 2 entries
 for that path.  After the above, we would end up with this:
 
diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
index c861163..1942cd0 100644
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -32,11 +32,11 @@ OUTPUT FORMAT
 -------------
 When specifying the -v option the format used is:
 
-	SHA1 type size size-in-pack-file offset-in-packfile
+	SHA-1 type size size-in-pack-file offset-in-packfile
 
 for objects that are not deltified in the pack, and
 
-	SHA1 type size size-in-packfile offset-in-packfile depth base-SHA1
+	SHA-1 type size size-in-packfile offset-in-packfile depth base-SHA-1
 
 for objects that are deltified.
 
diff --git a/Documentation/git-verify-tag.txt b/Documentation/git-verify-tag.txt
index 84e70a0..fa92728 100644
--- a/Documentation/git-verify-tag.txt
+++ b/Documentation/git-verify-tag.txt
@@ -16,7 +16,7 @@ Validates the gpg signature created by 'git-tag'.
 OPTIONS
 -------
 <tag>...::
-	SHA1 identifiers of git tag objects.
+	SHA-1 identifiers of git tag objects.
 
 Author
 ------
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 5d2d5b7..af12570 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -505,7 +505,7 @@ where:
 
 	<old|new>-file:: are files GIT_EXTERNAL_DIFF can use to read the
                          contents of <old|new>,
-	<old|new>-hex:: are the 40-hexdigit SHA1 hashes,
+	<old|new>-hex:: are the 40-hexdigit SHA-1 hashes,
 	<old|new>-mode:: are the octal representation of the file modes.
 
 +
@@ -595,7 +595,7 @@ The commit, equivalent to what other systems call a "changeset" or
 represents an immediately preceding step.  Commits with more than one
 parent represent merges of independent lines of development.
 
-All objects are named by the SHA1 hash of their contents, normally
+All objects are named by the SHA-1 hash of their contents, normally
 written as a string of 40 hex digits.  Such names are globally unique.
 The entire history leading up to a commit can be vouched for by signing
 just that commit.  A fourth object type, the tag, is provided for this
@@ -605,9 +605,9 @@ When first created, objects are stored in individual files, but for
 efficiency may later be compressed together into "pack files".
 
 Named pointers called refs mark interesting points in history.  A ref
-may contain the SHA1 name of an object or the name of another ref.  Refs
-with names beginning `ref/head/` contain the SHA1 name of the most
-recent commit (or "head") of a branch under development.  SHA1 names of
+may contain the SHA-1 name of an object or the name of another ref.  Refs
+with names beginning `ref/head/` contain the SHA-1 name of the most
+recent commit (or "head") of a branch under development.  SHA-1 names of
 tags of interest are stored under `ref/tags/`.  A special ref named
 `HEAD` contains the name of the currently checked-out branch.
 
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 7ba5e58..a204fdf 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -98,9 +98,9 @@ branch. A number of the git tools will assume that `.git/HEAD` is
 valid, though.
 
 [NOTE]
-An 'object' is identified by its 160-bit SHA1 hash, aka 'object name',
+An 'object' is identified by its 160-bit SHA-1 hash, aka 'object name',
 and a reference to an object is always the 40-byte hex
-representation of that SHA1 name. The files in the `refs`
+representation of that SHA-1 name. The files in the `refs`
 subdirectory are expected to contain these hex references
 (usually with a final `\'\n\'` at the end), and you should thus
 expect to see a number of 41-byte files containing these
@@ -755,7 +755,7 @@ already discussed, the `HEAD` branch is nothing but a symlink to one of
 these object pointers.
 
 You can at any time create a new branch by just picking an arbitrary
-point in the project history, and just writing the SHA1 name of that
+point in the project history, and just writing the SHA-1 name of that
 object into a file under `.git/refs/heads/`. You can use any filename you
 want (and indeed, subdirectories), but the convention is that the
 "normal" branch is called `master`. That's just a convention, though,
@@ -1226,7 +1226,7 @@ file (the first tree goes to stage 1, the second to stage 2,
 etc.).  After reading three trees into three stages, the paths
 that are the same in all three stages are 'collapsed' into stage
 0.  Also paths that are the same in two of three stages are
-collapsed into stage 0, taking the SHA1 from either stage 2 or
+collapsed into stage 0, taking the SHA-1 from either stage 2 or
 stage 3, whichever is different from stage 1 (i.e. only one side
 changed from the common ancestor).
 
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index e8041bc..a36e8d8 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -107,7 +107,7 @@ it changes it to:
 For the purpose of breaking a filepair, diffcore-break examines
 the extent of changes between the contents of the files before
 and after modification (i.e. the contents that have "bcd1234..."
-and "0123456..." as their SHA1 content ID, in the above
+and "0123456..." as their SHA-1 content ID, in the above
 example).  The amount of deletion of original contents and
 insertion of new material are added together, and if it exceeds
 the "break score", the filepair is broken into two.  The break
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 1c73673..4862044 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -96,7 +96,7 @@ given); `template` (if a `-t` option was given or the
 configuration option `commit.template` is set); `merge` (if the
 commit is a merge or a `.git/MERGE_MSG` file exists); `squash`
 (if a `.git/SQUASH_MSG` file exists); or `commit`, followed by
-a commit SHA1 (if a `-c`, `-C` or `\--amend` option was given).
+a commit SHA-1 (if a `-c`, `-C` or `\--amend` option was given).
 
 If the exit status is non-zero, 'git-commit' will abort.
 
diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutorial-2.txt
index dc8fc3a..4fb0275 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -45,9 +45,9 @@ What are the 7 digits of hex that git responded to the commit with?
 
 We saw in part one of the tutorial that commits have names like this.
 It turns out that every object in the git history is stored under
-a 40-digit hex name.  That name is the SHA1 hash of the object's
+a 40-digit hex name.  That name is the SHA-1 hash of the object's
 contents; among other things, this ensures that git will never store
-the same data twice (since identical data is given an identical SHA1
+the same data twice (since identical data is given an identical SHA-1
 name), and that the contents of a git object will never change (since
 that would change the object's name as well). The 7 char hex strings
 here are simply the abbreviation of such 40 character long strings.
@@ -55,7 +55,7 @@ Abbreviations can be used everywhere where the 40 character strings
 can be used, so long as they are unambiguous.
 
 It is expected that the content of the commit object you created while
-following the example above generates a different SHA1 hash than
+following the example above generates a different SHA-1 hash than
 the one shown above because the commit object records the time when
 it was created and the name of the person performing the commit.
 
@@ -79,14 +79,14 @@ A tree can refer to one or more "blob" objects, each corresponding to
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
@@ -105,7 +105,7 @@ Note that this is the old file data; so the object that git named in
 its response to the initial tree was a tree with a snapshot of the
 directory state that was recorded by the first commit.
 
-All of these objects are stored under their SHA1 names inside the git
+All of these objects are stored under their SHA-1 names inside the git
 directory:
 
 ------------------------------------------------
@@ -141,7 +141,7 @@ ref: refs/heads/master
 
 As you can see, this tells us which branch we're currently on, and it
 tells us this by naming a file under the .git directory, which itself
-contains a SHA1 name referring to a commit object, which we can
+contains a SHA-1 name referring to a commit object, which we can
 examine with cat-file:
 
 ------------------------------------------------
@@ -207,7 +207,7 @@ project's history:
 
 Note, by the way, that lots of commands take a tree as an argument.
 But as we can see above, a tree can be referred to in many different
-ways--by the SHA1 name for that tree, by the name of a commit that
+ways--by the SHA-1 name for that tree, by the name of a commit that
 refers to the tree, by the name of a branch whose head refers to that
 tree, etc.--and most such commands can accept any of these names.
 
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 572374f..558107f 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -229,7 +229,7 @@ This commit is referred to as a "merge commit", or sometimes just a
 
 [[def_object]]object::
 	The unit of storage in git. It is uniquely identified by the
-	<<def_SHA1,SHA1>> of its contents. Consequently, an
+	<<def_SHA1,SHA-1>> of its contents. Consequently, an
 	object can not be changed.
 
 [[def_object_database]]object database::
@@ -326,7 +326,7 @@ This commit is referred to as a "merge commit", or sometimes just a
 	to the result.
 
 [[def_ref]]ref::
-	A 40-byte hex representation of a <<def_SHA1,SHA1>> or a name that
+	A 40-byte hex representation of a <<def_SHA1,SHA-1>> or a name that
 	denotes a particular <<def_object,object>>. These may be stored in
 	`$GIT_DIR/refs/`.
 
@@ -373,7 +373,7 @@ This commit is referred to as a "merge commit", or sometimes just a
 [[def_SCM]]SCM::
 	Source code management (tool).
 
-[[def_SHA1]]SHA1::
+[[def_SHA1]]SHA-1::
 	Synonym for <<def_object_name,object name>>.
 
 [[def_shallow_repository]]shallow repository::
@@ -388,7 +388,7 @@ This commit is referred to as a "merge commit", or sometimes just a
 	its history can be later deepened with linkgit:git-fetch[1].
 
 [[def_symref]]symref::
-	Symbolic reference: instead of containing the <<def_SHA1,SHA1>>
+	Symbolic reference: instead of containing the <<def_SHA1,SHA-1>>
 	id itself, it is of the format 'ref: refs/some/thing' and when
 	referenced, it recursively dereferences to this reference.
 	'<<def_HEAD,HEAD>>' is a prime example of a symref. Symbolic
diff --git a/Documentation/howto/recover-corrupted-blob-object.txt b/Documentation/howto/recover-corrupted-blob-object.txt
index 323b513..0fc7013 100644
--- a/Documentation/howto/recover-corrupted-blob-object.txt
+++ b/Documentation/howto/recover-corrupted-blob-object.txt
@@ -9,7 +9,7 @@ On Fri, 9 Nov 2007, Yossi Leybovich wrote:
 > Did not help still the repository look for this object?
 > Any one know how can I track this object and understand which file is it
 
-So exactly *because* the SHA1 hash is cryptographically secure, the hash
+So exactly *because* the SHA-1 hash is cryptographically secure, the hash
 itself doesn't actually tell you anything, in order to fix a corrupt
 object you basically have to find the "original source" for it.
 
@@ -36,7 +36,7 @@ So:
 > ib]$ mv .git/objects/4b/9458b3786228369c63936db65827de3cc06200 ../
 
 This is the right thing to do, although it's usually best to save it under
-it's full SHA1 name (you just dropped the "4b" from the result ;).
+it's full SHA-1 name (you just dropped the "4b" from the result ;).
 
 Let's see what that tells us:
 
@@ -79,7 +79,7 @@ working tree, in which case fixing this problem is really simple, just do
 
 	git hash-object -w my-magic-file
 
-again, and if it outputs the missing SHA1 (4b945..) you're now all done!
+again, and if it outputs the missing SHA-1 (4b945..) you're now all done!
 
 But that's the really lucky case, so let's assume that it was some older
 version that was broken. How do you tell which version it was?
diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index fac8ebd..a480ea8 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -70,7 +70,7 @@ This is designed to be as compact as possible.
 * 'raw'
 +
 The 'raw' format shows the entire commit exactly as
-stored in the commit object.  Notably, the SHA1s are
+stored in the commit object.  Notably, the SHA-1s are
 displayed in full, regardless of whether --abbrev or
 --no-abbrev are used, and 'parents' information show the
 true parent commits, without taking grafts nor history
diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 1803e64..4ce3534 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -32,7 +32,7 @@ GIT pack format
      Observation: length of each object is encoded in a variable
      length format and is not constrained to 32-bit or anything.
 
-  - The trailer records 20-byte SHA1 checksum of all of the above.
+  - The trailer records 20-byte SHA-1 checksum of all of the above.
 
 = Original (version 1) pack-*.idx files have the following format:
 
@@ -53,10 +53,10 @@ GIT pack format
 
   - The file is concluded with a trailer:
 
-    A copy of the 20-byte SHA1 checksum at the end of
+    A copy of the 20-byte SHA-1 checksum at the end of
     corresponding packfile.
 
-    20-byte SHA1-checksum of all of the above.
+    20-byte SHA-1-checksum of all of the above.
 
 Pack Idx file:
 
@@ -104,7 +104,7 @@ Pack file entry: <+
         If it is not DELTA, then deflated bytes (the size above
 		is the size before compression).
 	If it is REF_DELTA, then
-	  20-byte base object name SHA1 (the size above is the
+	  20-byte base object name SHA-1 (the size above is the
 		size of the delta data that follows).
           delta data, deflated.
 	If it is OFS_DELTA, then
@@ -133,7 +133,7 @@ Pack file entry: <+
 
   - A 256-entry fan-out table just like v1.
 
-  - A table of sorted 20-byte SHA1 object names.  These are
+  - A table of sorted 20-byte SHA-1 object names.  These are
     packed together without offset values to reduce the cache
     footprint of the binary search for a specific object name.
 
@@ -154,7 +154,7 @@ Pack file entry: <+
 
   - The same trailer as a v1 pack file:
 
-    A copy of the 20-byte SHA1 checksum at the end of
+    A copy of the 20-byte SHA-1 checksum at the end of
     corresponding packfile.
 
-    20-byte SHA1-checksum of all of the above.
+    20-byte SHA-1-checksum of all of the above.
diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 9cd48b4..9df76e3 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -6,22 +6,22 @@ There are two Pack push-pull protocols.
 upload-pack (S) | fetch/clone-pack (C) protocol:
 
 	# Tell the puller what commits we have and what their names are
-	S: SHA1 name
+	S: SHA-1 name
 	S: ...
-	S: SHA1 name
+	S: SHA-1 name
 	S: # flush -- it's your turn
 	# Tell the pusher what commits we want, and what we have
 	C: want name
 	C: ..
 	C: want name
-	C: have SHA1
-	C: have SHA1
+	C: have SHA-1
+	C: have SHA-1
 	C: ...
 	C: # flush -- occasionally ask "had enough?"
 	S: NAK
-	C: have SHA1
+	C: have SHA-1
 	C: ...
-	C: have SHA1
+	C: have SHA-1
 	S: ACK
 	C: done
 	S: XXXXXXX -- packfile contents.
@@ -29,13 +29,13 @@ upload-pack (S) | fetch/clone-pack (C) protocol:
 send-pack | receive-pack protocol.
 
 	# Tell the pusher what commits we have and what their names are
-	C: SHA1 name
+	C: SHA-1 name
 	C: ...
-	C: SHA1 name
+	C: SHA-1 name
 	C: # flush -- it's your turn
 	# Tell the puller what the pusher has
-	S: old-SHA1 new-SHA1 name
-	S: old-SHA1 new-SHA1 name
+	S: old-SHA-1 new-SHA-1 name
+	S: old-SHA-1 new-SHA-1 name
 	S: ...
 	S: # flush -- done with the list
 	S: XXXXXXX --- packfile contents.
diff --git a/Documentation/technical/shallow.txt b/Documentation/technical/shallow.txt
index 559263a..73214c3 100644
--- a/Documentation/technical/shallow.txt
+++ b/Documentation/technical/shallow.txt
@@ -2,7 +2,7 @@ Def.: Shallow commits do have parents, but not in the shallow
 repo, and therefore grafts are introduced pretending that
 these commits have no parents.
 
-The basic idea is to write the SHA1s of shallow commits into
+The basic idea is to write the SHA-1s of shallow commits into
 $GIT_DIR/shallow, and handle its contents like the contents
 of $GIT_DIR/info/grafts (with the difference that shallow
 cannot contain parent information).
@@ -12,7 +12,7 @@ even the config, since the user should not touch that file
 at all (even throughout development of the shallow clone, it
 was never manually edited!).
 
-Each line contains exactly one SHA1. When read, a commit_graft
+Each line contains exactly one SHA-1. When read, a commit_graft
 will be constructed, which has nr_parent < 0 to make it easier
 to discern from user provided grafts.
 
-- 
1.6.3.rc1.51.gea0b7
