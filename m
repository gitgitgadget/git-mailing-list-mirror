From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH v3 3/4] The name of the hash function is "SHA-1", not "SHA1"
Date: Mon, 15 Apr 2013 19:49:04 +0200 (CEST)
Message-ID: <1781595479.996520.1366048144788.JavaMail.ngmail@webmail19.arcor-online.net>
References: <46832203.996447.1366047902197.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: th.acker@arcor.de, gitster@pobox.com
To: th.acker@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 15 19:49:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URnWk-0002zn-Mj
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 19:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756146Ab3DORtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 13:49:09 -0400
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:34852 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754733Ab3DORtG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Apr 2013 13:49:06 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mx.arcor.de (Postfix) with ESMTP id DC415BE07B;
	Mon, 15 Apr 2013 19:49:04 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id D08461F6006;
	Mon, 15 Apr 2013 19:49:04 +0200 (CEST)
Received: from webmail19.arcor-online.net (webmail19.arcor-online.net [151.189.8.77])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id C57051634E3;
	Mon, 15 Apr 2013 19:49:04 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-06.arcor-online.net C57051634E3
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1366048144; bh=2VzkcWB9eIgsWjlDegt9h97lrbvTjsF+QByntt4CZBQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=lKC/072/m1tRt1xlQ37UqkUg6bA4Sa47/P6beEVVbizSvamy+FrDni5mYIARJq8Dh
	 xX9xozRxeFCJujxXkMU8ypvNEZZfAmgJ0fYgSXQES6BINfzt42CXdZimSefAWBPDZC
	 dJqNQL2/BwwWnUdRVJScSPXnNe5B+R2UNRJqhtIM=
Received: from [188.105.109.185] by webmail19.arcor-online.net (151.189.8.77) with HTTP (Arcor Webmail); Mon, 15 Apr 2013 19:49:04 +0200 (CEST)
In-Reply-To: <46832203.996447.1366047902197.JavaMail.ngmail@webmail19.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.109.185
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221271>


Use "SHA-1" instead of "SHA1" whenever we talk about the hash function.
When used as a programming symbol, we keep "SHA1".

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/config.txt                              |  2 +-
 Documentation/git-cat-file.txt                        |  6 +++---
 Documentation/git-describe.txt                        |  2 +-
 Documentation/git-fsck.txt                            |  4 ++--
 Documentation/git-index-pack.txt                      |  2 +-
 Documentation/git-ls-files.txt                        |  2 +-
 Documentation/git-merge-index.txt                     |  2 +-
 Documentation/git-pack-objects.txt                    |  2 +-
 Documentation/git-patch-id.txt                        |  2 +-
 Documentation/git-replace.txt                         |  4 ++--
 Documentation/git-rev-parse.txt                       |  4 ++--
 Documentation/git-show-branch.txt                     |  4 ++--
 Documentation/git-show-index.txt                      |  2 +-
 Documentation/git-show-ref.txt                        |  4 ++--
 Documentation/git-tag.txt                             |  2 +-
 Documentation/git-update-index.txt                    |  2 +-
 Documentation/git-verify-pack.txt                     |  4 ++--
 Documentation/git-verify-tag.txt                      |  2 +-
 Documentation/git.txt                                 | 10 +++++-----
 Documentation/gitcore-tutorial.txt                    |  8 ++++----
 Documentation/gitdiffcore.txt                         |  2 +-
 Documentation/githooks.txt                            | 10 +++++-----
 Documentation/gitrepository-layout.txt                |  2 +-
 Documentation/gittutorial-2.txt                       | 16 ++++++++--------
 Documentation/howto/recover-corrupted-blob-object.txt |  6 +++---
 Documentation/pretty-formats.txt                      |  2 +-
 Documentation/revisions.txt                           |  4 ++--
 Documentation/technical/api-sha1-array.txt            |  4 ++--
 Documentation/technical/pack-format.txt               | 14 +++++++-------
 Documentation/technical/pack-heuristics.txt           |  2 +-
 Documentation/technical/shallow.txt                   |  4 ++--
 31 files changed, 68 insertions(+), 68 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3d750e0..5123636 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -412,7 +412,7 @@ repository's usual working tree).
 core.logAllRefUpdates::
 	Enable the reflog. Updates to a ref <ref> is logged to the file
 	"$GIT_DIR/logs/<ref>", by appending the new and old
-	SHA1, the date/time and the reason of the update, but
+	SHA-1, the date/time and the reason of the update, but
 	only when the file exists.  If this configuration
 	variable is set to true, missing "$GIT_DIR/logs/<ref>"
 	file is automatically created for branch heads (i.e. under
diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 2fb95bb..30d585a 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -20,7 +20,7 @@ object type, or '-s' is used to find the object size, or '--textconv' is used
 (which implies type "blob").
 
 In the second form, a list of objects (separated by linefeeds) is provided on
-stdin, and the SHA1, type, and size of each object is printed on stdout.
+stdin, and the SHA-1, type, and size of each object is printed on stdout.
 
 OPTIONS
 -------
@@ -58,11 +58,11 @@ OPTIONS
 	to apply the filter to the content recorded in the index at <path>.
 
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
index 3c81e85..28e5ec0 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -149,7 +149,7 @@ is found, its name will be output and searching will stop.
 If an exact match was not found, 'git describe' will walk back
 through the commit history to locate an ancestor commit which
 has been tagged.  The ancestor's tag will be output along with an
-abbreviation of the input committish's SHA1.
+abbreviation of the input committish's SHA-1.
 
 If multiple tags were found during the walk then the tag which
 has the fewest commits different from the input committish will be
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index eff9188..e5878bd 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -23,7 +23,7 @@ OPTIONS
 	An object to treat as the head of an unreachability trace.
 +
 If no objects are given, 'git fsck' defaults to using the
-index file, all SHA1 references in `refs` namespace, and all reflogs
+index file, all SHA-1 references in `refs` namespace, and all reflogs
 (unless --no-reflogs is given) as heads.
 
 --unreachable::
@@ -89,7 +89,7 @@ index file, all SHA1 references in `refs` namespace, and all reflogs
 DISCUSSION
 ----------
 
-git-fsck tests SHA1 and general object sanity, and it does full tracking
+git-fsck tests SHA-1 and general object sanity, and it does full tracking
 of the resulting reachability and everything else. It prints out any
 corruption it finds (missing or bad objects), and if you use the
 '--unreachable' flag it will also print out objects that exist but that
diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 36adc5f..bde8eec 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -89,7 +89,7 @@ Note
 ----
 
 Once the index has been created, the list of object names is sorted
-and the SHA1 hash of that list is printed to stdout. If --stdin was
+and the SHA-1 hash of that list is printed to stdout. If --stdin was
 also used then this is prefixed by either "pack\t", or "keep\t" if a
 new .keep file was successfully created. This is useful to remove a
 .keep file used as a lock to prevent the race with 'git repack'
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 0bdebff..c0856a6 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -164,7 +164,7 @@ which case it outputs:
 'git ls-files --unmerged' and 'git ls-files --stage' can be used to examine
 detailed information on unmerged paths.
 
-For an unmerged path, instead of recording a single mode/SHA1 pair,
+For an unmerged path, instead of recording a single mode/SHA-1 pair,
 the index records up to three such pairs; one from tree O in stage
 1, A in stage 2, and B in stage 3.  This information can be used by
 the user (or the porcelain) to see what should eventually be recorded at the
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index 0c80cec..02676fb 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 This looks up the <file>(s) in the index and, if there are any merge
-entries, passes the SHA1 hash for those files as arguments 1, 2, 3 (empty
+entries, passes the SHA-1 hash for those files as arguments 1, 2, 3 (empty
 argument if no file), and <file> as argument 4.  File modes for the three
 files are passed as arguments 5, 6 and 7.
 
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 69c9313..d94edcd 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -50,7 +50,7 @@ base-name::
 	Write into a pair of files (.pack and .idx), using
 	<base-name> to determine the name of the created file.
 	When this option is used, the two files are written in
-	<base-name>-<SHA1>.{pack,idx} files.  <SHA1> is a hash
+	<base-name>-<SHA-1>.{pack,idx} files.  <SHA-1> is a hash
 	of the sorted object names to make the resulting filename
 	based on the pack content, and written to the standard
 	output of the command.
diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
index 90268f0..312c3b1 100644
--- a/Documentation/git-patch-id.txt
+++ b/Documentation/git-patch-id.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-A "patch ID" is nothing but a SHA1 of the diff associated with a patch, with
+A "patch ID" is nothing but a SHA-1 of the diff associated with a patch, with
 whitespace and line numbers ignored.  As such, it's "reasonably stable", but at
 the same time also reasonably unique, i.e., two patches that have the same "patch
 ID" are almost guaranteed to be the same thing.
diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index 0142cd1..e0b4057 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -16,8 +16,8 @@ DESCRIPTION
 -----------
 Adds a 'replace' reference in `refs/replace/` namespace.
 
-The name of the 'replace' reference is the SHA1 of the object that is
-replaced. The content of the 'replace' reference is the SHA1 of the
+The name of the 'replace' reference is the SHA-1 of the object that is
+replaced. The content of the 'replace' reference is the SHA-1 of the
 replacement object.
 
 Unless `-f` is given, the 'replace' reference must not yet exist.
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 1f9ed6c..947d62f 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -95,7 +95,7 @@ can be used.
 	one.
 
 --symbolic::
-	Usually the object names are output in SHA1 form (with
+	Usually the object names are output in SHA-1 form (with
 	possible '{caret}' prefix); this option makes them output in a
 	form as close to the original input as possible.
 
@@ -180,7 +180,7 @@ print a message to stderr and exit with nonzero status.
 
 --short::
 --short=number::
-	Instead of outputting the full SHA1 values of object names try to
+	Instead of outputting the full SHA-1 values of object names try to
 	abbreviate them to a shorter unique name. When no length is specified
 	7 is used. The minimum length is 4.
 
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index a8e77b5..a515648 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -31,7 +31,7 @@ no <rev> nor <glob> is given on the command line.
 OPTIONS
 -------
 <rev>::
-	Arbitrary extended SHA1 expression (see linkgit:gitrevisions[7])
+	Arbitrary extended SHA-1 expression (see linkgit:gitrevisions[7])
 	that typically names a branch head or a tag.
 
 <glob>::
@@ -142,7 +142,7 @@ displayed, indented N places.  If a commit is on the I-th
 branch, the I-th indentation character shows a `+` sign;
 otherwise it shows a space.  Merge commits are denoted by
 a `-` sign.  Each commit shows a short name that
-can be used as an extended SHA1 to name that commit.
+can be used as an extended SHA-1 to name that commit.
 
 The following example shows three branches, "master", "fixes"
 and "mhf":
diff --git a/Documentation/git-show-index.txt b/Documentation/git-show-index.txt
index 9cbbed9..fbdc8ad 100644
--- a/Documentation/git-show-index.txt
+++ b/Documentation/git-show-index.txt
@@ -19,7 +19,7 @@ Reads given idx file for packed Git archive created with
 
 The information it outputs is subset of what you can get from
 'git verify-pack -v'; this command only shows the packfile
-offset and SHA1 of each object.
+offset and SHA-1 of each object.
 
 GIT
 ---
diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 5dbcd47..de4d352 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -50,8 +50,8 @@ OPTIONS
 -s::
 --hash[=<n>]::
 
-	Only show the SHA1 hash, not the reference name. When combined with
-	--dereference the dereferenced tag will still be shown after the SHA1.
+	Only show the SHA-1 hash, not the reference name. When combined with
+	--dereference the dereferenced tag will still be shown after the SHA-1.
 
 --verify::
 
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index b21aa87..22894cb 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -33,7 +33,7 @@ in the tag message.
 If `-m <msg>` or `-F <file>` is given and `-a`, `-s`, and `-u <key-id>`
 are absent, `-a` is implied.
 
-Otherwise just a tag reference for the SHA1 object name of the commit object is
+Otherwise just a tag reference for the SHA-1 object name of the commit object is
 created (i.e. a lightweight tag).
 
 A GnuPG signed tag object will be created when `-s` or `-u
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index c927758..670e9fb 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -247,7 +247,7 @@ $ git update-index --index-info
 ------------
 
 The first line of the input feeds 0 as the mode to remove the
-path; the SHA1 does not matter as long as it is well formatted.
+path; the SHA-1 does not matter as long as it is well formatted.
 Then the second and third line feeds stage 1 and stage 2 entries
 for that path.  After the above, we would end up with this:
 
diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
index 0eb9ffb..526ba7b 100644
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -40,11 +40,11 @@ OUTPUT FORMAT
 -------------
 When specifying the -v option the format used is:
 
-	SHA1 type size size-in-pack-file offset-in-packfile
+	SHA-1 type size size-in-pack-file offset-in-packfile
 
 for objects that are not deltified in the pack, and
 
-	SHA1 type size size-in-packfile offset-in-packfile depth base-SHA1
+	SHA-1 type size size-in-packfile offset-in-packfile depth base-SHA-1
 
 for objects that are deltified.
 
diff --git a/Documentation/git-verify-tag.txt b/Documentation/git-verify-tag.txt
index e996135..f88ba96 100644
--- a/Documentation/git-verify-tag.txt
+++ b/Documentation/git-verify-tag.txt
@@ -21,7 +21,7 @@ OPTIONS
 	Print the contents of the tag object before validating it.
 
 <tag>...::
-	SHA1 identifiers of Git tag objects.
+	SHA-1 identifiers of Git tag objects.
 
 GIT
 ---
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 6a875f2..807a13c 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -741,7 +741,7 @@ where:
 
 	<old|new>-file:: are files GIT_EXTERNAL_DIFF can use to read the
                          contents of <old|new>,
-	<old|new>-hex:: are the 40-hexdigit SHA1 hashes,
+	<old|new>-hex:: are the 40-hexdigit SHA-1 hashes,
 	<old|new>-mode:: are the octal representation of the file modes.
 +
 The file parameters can point at the user's working file
@@ -864,7 +864,7 @@ The commit, equivalent to what other systems call a "changeset" or
 represents an immediately preceding step.  Commits with more than one
 parent represent merges of independent lines of development.
 
-All objects are named by the SHA1 hash of their contents, normally
+All objects are named by the SHA-1 hash of their contents, normally
 written as a string of 40 hex digits.  Such names are globally unique.
 The entire history leading up to a commit can be vouched for by signing
 just that commit.  A fourth object type, the tag, is provided for this
@@ -874,9 +874,9 @@ When first created, objects are stored in individual files, but for
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
index 59c1c17..f538a87 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -106,9 +106,9 @@ branch. A number of the Git tools will assume that `.git/HEAD` is
 valid, though.
 
 [NOTE]
-An 'object' is identified by its 160-bit SHA1 hash, aka 'object name',
+An 'object' is identified by its 160-bit SHA-1 hash, aka 'object name',
 and a reference to an object is always the 40-byte hex
-representation of that SHA1 name. The files in the `refs`
+representation of that SHA-1 name. The files in the `refs`
 subdirectory are expected to contain these hex references
 (usually with a final `\n` at the end), and you should thus
 expect to see a number of 41-byte files containing these
@@ -763,7 +763,7 @@ already discussed, the `HEAD` branch is nothing but a symlink to one of
 these object pointers.
 
 You can at any time create a new branch by just picking an arbitrary
-point in the project history, and just writing the SHA1 name of that
+point in the project history, and just writing the SHA-1 name of that
 object into a file under `.git/refs/heads/`. You can use any filename you
 want (and indeed, subdirectories), but the convention is that the
 "normal" branch is called `master`. That's just a convention, though,
@@ -1233,7 +1233,7 @@ file (the first tree goes to stage 1, the second to stage 2,
 etc.).  After reading three trees into three stages, the paths
 that are the same in all three stages are 'collapsed' into stage
 0.  Also paths that are the same in two of three stages are
-collapsed into stage 0, taking the SHA1 from either stage 2 or
+collapsed into stage 0, taking the SHA-1 from either stage 2 or
 stage 3, whichever is different from stage 1 (i.e. only one side
 changed from the common ancestor).
 
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 4ed71c7..568d757 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -108,7 +108,7 @@ it changes it to:
 For the purpose of breaking a filepair, diffcore-break examines
 the extent of changes between the contents of the files before
 and after modification (i.e. the contents that have "bcd1234..."
-and "0123456..." as their SHA1 content ID, in the above
+and "0123456..." as their SHA-1 content ID, in the above
 example).  The amount of deletion of original contents and
 insertion of new material are added together, and if it exceeds
 the "break score", the filepair is broken into two.  The break
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index dc6693f..d48bf4d 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -99,7 +99,7 @@ given); `template` (if a `-t` option was given or the
 configuration option `commit.template` is set); `merge` (if the
 commit is a merge or a `.git/MERGE_MSG` file exists); `squash`
 (if a `.git/SQUASH_MSG` file exists); or `commit`, followed by
-a commit SHA1 (if a `-c`, `-C` or `--amend` option was given).
+a commit SHA-1 (if a `-c`, `-C` or `--amend` option was given).
 
 If the exit status is non-zero, 'git commit' will abort.
 
@@ -196,11 +196,11 @@ hook would receive a line like the following:
 
   refs/heads/master 67890 refs/heads/foreign 12345
 
-although the full, 40-character SHA1s would be supplied.  If the foreign ref
-does not yet exist the `<remote SHA1>` will be 40 `0`.  If a ref is to be
+although the full, 40-character SHA-1s would be supplied.  If the foreign ref
+does not yet exist the `<remote SHA-1>` will be 40 `0`.  If a ref is to be
 deleted, the `<local ref>` will be supplied as `(delete)` and the `<local
-SHA1>` will be 40 `0`.  If the local commit was specified by something other
-than a name which could be expanded (such as `HEAD~`, or a SHA1) it will be
+SHA-1>` will be 40 `0`.  If the local commit was specified by something other
+than a name which could be expanded (such as `HEAD~`, or a SHA-1) it will be
 supplied as it was originally given.
 
 If this hook exits with a non-zero status, 'git push' will abort without
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index f0eef76..2ad09f4 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -106,7 +106,7 @@ refs/remotes/`name`::
 	from a remote repository.
 
 refs/replace/`<obj-sha1>`::
-	records the SHA1 of the object that replaces `<obj-sha1>`.
+	records the SHA-1 of the object that replaces `<obj-sha1>`.
 	This is similar to info/grafts and is internally used and
 	maintained by linkgit:git-replace[1]. Such refs can be exchanged
 	between repositories while grafts are not.
diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutorial-2.txt
index 94c906e..3109ea8 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -46,9 +46,9 @@ What are the 7 digits of hex that Git responded to the commit with?
 
 We saw in part one of the tutorial that commits have names like this.
 It turns out that every object in the Git history is stored under
-a 40-digit hex name.  That name is the SHA1 hash of the object's
+a 40-digit hex name.  That name is the SHA-1 hash of the object's
 contents; among other things, this ensures that Git will never store
-the same data twice (since identical data is given an identical SHA1
+the same data twice (since identical data is given an identical SHA-1
 name), and that the contents of a Git object will never change (since
 that would change the object's name as well). The 7 char hex strings
 here are simply the abbreviation of such 40 character long strings.
@@ -56,7 +56,7 @@ Abbreviations can be used everywhere where the 40 character strings
 can be used, so long as they are unambiguous.
 
 It is expected that the content of the commit object you created while
-following the example above generates a different SHA1 hash than
+following the example above generates a different SHA-1 hash than
 the one shown above because the commit object records the time when
 it was created and the name of the person performing the commit.
 
@@ -80,14 +80,14 @@ A tree can refer to one or more "blob" objects, each corresponding to
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
@@ -106,7 +106,7 @@ Note that this is the old file data; so the object that Git named in
 its response to the initial tree was a tree with a snapshot of the
 directory state that was recorded by the first commit.
 
-All of these objects are stored under their SHA1 names inside the Git
+All of these objects are stored under their SHA-1 names inside the Git
 directory:
 
 ------------------------------------------------
@@ -142,7 +142,7 @@ ref: refs/heads/master
 
 As you can see, this tells us which branch we're currently on, and it
 tells us this by naming a file under the .git directory, which itself
-contains a SHA1 name referring to a commit object, which we can
+contains a SHA-1 name referring to a commit object, which we can
 examine with cat-file:
 
 ------------------------------------------------
@@ -208,7 +208,7 @@ project's history:
 
 Note, by the way, that lots of commands take a tree as an argument.
 But as we can see above, a tree can be referred to in many different
-ways--by the SHA1 name for that tree, by the name of a commit that
+ways--by the SHA-1 name for that tree, by the name of a commit that
 refers to the tree, by the name of a branch whose head refers to that
 tree, etc.--and most such commands can accept any of these names.
 
diff --git a/Documentation/howto/recover-corrupted-blob-object.txt b/Documentation/howto/recover-corrupted-blob-object.txt
index 6d362ce..1b3b188 100644
--- a/Documentation/howto/recover-corrupted-blob-object.txt
+++ b/Documentation/howto/recover-corrupted-blob-object.txt
@@ -15,7 +15,7 @@ On Fri, 9 Nov 2007, Yossi Leybovich wrote:
 > Any one know how can I track this object and understand which file is it
 -----------------------------------------------------------
 
-So exactly *because* the SHA1 hash is cryptographically secure, the hash
+So exactly *because* the SHA-1 hash is cryptographically secure, the hash
 itself doesn't actually tell you anything, in order to fix a corrupt
 object you basically have to find the "original source" for it.
 
@@ -44,7 +44,7 @@ So:
 -----------------------------------------------------------
 
 This is the right thing to do, although it's usually best to save it under
-it's full SHA1 name (you just dropped the "4b" from the result ;).
+it's full SHA-1 name (you just dropped the "4b" from the result ;).
 
 Let's see what that tells us:
 
@@ -89,7 +89,7 @@ working tree, in which case fixing this problem is really simple, just do
 
 	git hash-object -w my-magic-file
 
-again, and if it outputs the missing SHA1 (4b945..) you're now all done!
+again, and if it outputs the missing SHA-1 (4b945..) you're now all done!
 
 But that's the really lucky case, so let's assume that it was some older
 version that was broken. How do you tell which version it was?
diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index afac703..f5b50dc 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -75,7 +75,7 @@ This is designed to be as compact as possible.
 * 'raw'
 +
 The 'raw' format shows the entire commit exactly as
-stored in the commit object.  Notably, the SHA1s are
+stored in the commit object.  Notably, the SHA-1s are
 displayed in full, regardless of whether --abbrev or
 --no-abbrev are used, and 'parents' information show the
 true parent commits, without taking grafts nor history
diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 8855b1a..a8ff691 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -2,13 +2,13 @@ SPECIFYING REVISIONS
 --------------------
 
 A revision parameter '<rev>' typically, but not necessarily, names a
-commit object.  It uses what is called an 'extended SHA1'
+commit object.  It uses what is called an 'extended SHA-1'
 syntax.  Here are various ways to spell object names.  The
 ones listed near the end of this list name trees and
 blobs contained in a commit.
 
 '<sha1>', e.g. 'dae86e1950b1277e545cee180551750029cfe735', 'dae86e'::
-  The full SHA1 object name (40-byte hexadecimal string), or
+  The full SHA-1 object name (40-byte hexadecimal string), or
   a leading substring that is unique within the repository.
   E.g. dae86e1950b1277e545cee180551750029cfe735 and dae86e both
   name the same commit object if there is no other object in
diff --git a/Documentation/technical/api-sha1-array.txt b/Documentation/technical/api-sha1-array.txt
index 45d1c51..3e75497 100644
--- a/Documentation/technical/api-sha1-array.txt
+++ b/Documentation/technical/api-sha1-array.txt
@@ -1,7 +1,7 @@
 sha1-array API
 ==============
 
-The sha1-array API provides storage and manipulation of sets of SHA1
+The sha1-array API provides storage and manipulation of sets of SHA-1
 identifiers. The emphasis is on storage and processing efficiency,
 making them suitable for large lists. Note that the ordering of items is
 not preserved over some operations.
@@ -11,7 +11,7 @@ Data Structures
 
 `struct sha1_array`::
 
-	A single array of SHA1 hashes. This should be initialized by
+	A single array of SHA-1 hashes. This should be initialized by
 	assignment from `SHA1_ARRAY_INIT`.  The `sha1` member contains
 	the actual data. The `nr` member contains the number of items in
 	the set.  The `alloc` and `sorted` members are used internally,
diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index a37f137..8e5bf60 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -34,7 +34,7 @@ Git pack format
      Observation: length of each object is encoded in a variable
      length format and is not constrained to 32-bit or anything.
 
-  - The trailer records 20-byte SHA1 checksum of all of the above.
+  - The trailer records 20-byte SHA-1 checksum of all of the above.
 
 == Original (version 1) pack-*.idx files have the following format:
 
@@ -55,10 +55,10 @@ Git pack format
 
   - The file is concluded with a trailer:
 
-    A copy of the 20-byte SHA1 checksum at the end of
+    A copy of the 20-byte SHA-1 checksum at the end of
     corresponding packfile.
 
-    20-byte SHA1-checksum of all of the above.
+    20-byte SHA-1-checksum of all of the above.
 
 Pack Idx file:
 
@@ -106,7 +106,7 @@ Pack file entry: <+
         If it is not DELTA, then deflated bytes (the size above
 		is the size before compression).
 	If it is REF_DELTA, then
-	  20-byte base object name SHA1 (the size above is the
+	  20-byte base object name SHA-1 (the size above is the
 		size of the delta data that follows).
           delta data, deflated.
 	If it is OFS_DELTA, then
@@ -135,7 +135,7 @@ Pack file entry: <+
 
   - A 256-entry fan-out table just like v1.
 
-  - A table of sorted 20-byte SHA1 object names.  These are
+  - A table of sorted 20-byte SHA-1 object names.  These are
     packed together without offset values to reduce the cache
     footprint of the binary search for a specific object name.
 
@@ -156,7 +156,7 @@ Pack file entry: <+
 
   - The same trailer as a v1 pack file:
 
-    A copy of the 20-byte SHA1 checksum at the end of
+    A copy of the 20-byte SHA-1 checksum at the end of
     corresponding packfile.
 
-    20-byte SHA1-checksum of all of the above.
+    20-byte SHA-1-checksum of all of the above.
diff --git a/Documentation/technical/pack-heuristics.txt b/Documentation/technical/pack-heuristics.txt
index dbdf7ba..912ebcf 100644
--- a/Documentation/technical/pack-heuristics.txt
+++ b/Documentation/technical/pack-heuristics.txt
@@ -89,7 +89,7 @@ Ah, grasshopper!  And thus the enlightenment begins anew.
 
     <linus> The "magic" is actually in theory totally arbitrary.
         ANY order will give you a working pack, but no, it's not
-        ordered by SHA1.
+        ordered by SHA-1.
 
         Before talking about the ordering for the sliding delta
         window, let's talk about the recency order. That's more
diff --git a/Documentation/technical/shallow.txt b/Documentation/technical/shallow.txt
index ea2f69f..5183b15 100644
--- a/Documentation/technical/shallow.txt
+++ b/Documentation/technical/shallow.txt
@@ -8,7 +8,7 @@ repo, and therefore grafts are introduced pretending that
 these commits have no parents.
 *********************************************************
 
-The basic idea is to write the SHA1s of shallow commits into
+The basic idea is to write the SHA-1s of shallow commits into
 $GIT_DIR/shallow, and handle its contents like the contents
 of $GIT_DIR/info/grafts (with the difference that shallow
 cannot contain parent information).
@@ -18,7 +18,7 @@ even the config, since the user should not touch that file
 at all (even throughout development of the shallow clone, it
 was never manually edited!).
 
-Each line contains exactly one SHA1. When read, a commit_graft
+Each line contains exactly one SHA-1. When read, a commit_graft
 will be constructed, which has nr_parent < 0 to make it easier
 to discern from user provided grafts.
 
-- 
1.8.1.msysgit.1


---
Thomas
