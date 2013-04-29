From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH] Fix grammar in the 1.8.3 release notes.
Date: Mon, 29 Apr 2013 15:15:04 -0400
Message-ID: <1367262904-9885-1-git-send-email-marcnarc@xiplink.com>
References: <7vvc78u8jl.fsf@alter.siamese.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 29 21:22:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWte7-000624-Op
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 21:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933057Ab3D2TVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 15:21:34 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:7477 "EHLO
	cubert.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932552Ab3D2TVc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 15:21:32 -0400
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Apr 2013 15:21:31 EDT
Received: from xiplink.com (rincewind.xiplink.com [192.168.1.178])
	by cubert.xiplink.com (Postfix) with ESMTP id C2BB961D4E;
	Mon, 29 Apr 2013 15:15:03 -0400 (EDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <7vvc78u8jl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222850>

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>

---

This started out as an attempt to make the backward compatibility notes
more parsable, but then I just kept going...

		M.


 Documentation/RelNotes/1.8.3.txt | 145 +++++++++++++++++++--------------------
 1 file changed, 72 insertions(+), 73 deletions(-)

diff --git a/Documentation/RelNotes/1.8.3.txt b/Documentation/RelNotes/1.8.3.txt
index 6d25165..06bc831 100644
--- a/Documentation/RelNotes/1.8.3.txt
+++ b/Documentation/RelNotes/1.8.3.txt
@@ -8,23 +8,22 @@ When "git push [$there]" does not say what to push, we have used the
 traditional "matching" semantics so far (all your branches were sent
 to the remote as long as there already are branches of the same name
 over there).  In Git 2.0, the default will change to the "simple"
-semantics that pushes the current branch to the branch with the same
-name, only when the current branch is set to integrate with that
-remote branch.  There is a user preference configuration variable
+semantics that pushes only the current branch to the branch with the same
+name, and only when the current branch is set to integrate with that
+remote branch.  Use the user preference configuration variable
 "push.default" to change this.  If you are an old-timer who is used
-to the "matching" semantics, you can set it to "matching" to keep the
+to the "matching" semantics, you can set the varaible to "matching" to keep the
 traditional behaviour.  If you want to live in the future early,
 you can set it to "simple" today without waiting for Git 2.0.
 
-When "git add -u" and "git add -A", that does not specify what paths
-to add on the command line is run from inside a subdirectory, these
-commands will operate on the entire tree in Git 2.0 for consistency
-with "git commit -a" and other commands. Because there will be no
-mechanism to make "git add -u" behave as if "git add -u .", it is
-important for those who are used to "git add -u" (without pathspec)
-updating the index only for paths in the current subdirectory to start
-training their fingers to explicitly say "git add -u ." when they mean
-it before Git 2.0 comes.  A warning is issued when these commands are
+When "git add -u" (and "git add -A") is run inside a subdirectory and
+does not specify which paths to add on the command line, it
+will operate on the entire tree in Git 2.0 for consistency
+with "git commit -a" and other commands.  There will be no
+mechanism to make plain "git add -u" behave like "git add -u .".
+Current users of "git add -u" (without a pathspec) should start
+training their fingers to explicitly say "git add -u ."
+before Git 2.0 comes.  A warning is issued when these commands are
 run without a pathspec and when you have local changes outside the
 current directory, because the behaviour in Git 2.0 will be different
 from today's version in such a situation.
@@ -33,8 +32,8 @@ In Git 2.0, "git add <path>" will behave as "git add -A <path>", so
 that "git add dir/" will notice paths you removed from the directory
 and record the removal.  Versions before Git 2.0, including this
 release, will keep ignoring removals, but the users who rely on this
-behaviour is encouraged to use "git add --ignore-removal <path>" and
-get used to it.
+behaviour are encouraged to start using "git add --ignore-removal <path>"
+now before 2.0 is released.
 
 
 Updates since v1.8.2
@@ -114,7 +113,7 @@ UI, Workflows & Features
  * "git status" suggests users to look into using --untracked=no option
    when it takes too long.
 
- * "git status" shows a bit more information to "git status" during a
+ * "git status" shows a bit more information during a
    rebase/bisect session.
 
  * "git fetch" learned to fetch a commit at the tip of an unadvertised
@@ -148,8 +147,8 @@ UI, Workflows & Features
 
  * "git mergetool" now feeds files to the "p4merge" backend in the
    order that matches the p4 convention, where "theirs" is usually
-   shown on the left side, which is the opposite from other backend
-   expects.
+   shown on the left side, which is the opposite from what other backends
+   expect.
 
  * "show/log" now honors gpg.program configuration just like other
    parts of the code that use GnuPG.
@@ -173,7 +172,7 @@ Performance, Internal Implementation, etc.
 
  * Updates for building under msvc.
 
- * A handful of issues in the code to traverse working tree to find
+ * A handful of issues in the code that traverses the working tree to find
    untracked and/or ignored files have been fixed, and the general
    codepath involved in "status -u" and "clean" have been cleaned up
    and optimized.
@@ -182,15 +181,15 @@ Performance, Internal Implementation, etc.
    pack has been shrunk.
 
  * The logic to coalesce the same lines removed from the parents in
-   the output from "diff -c/--cc" has been updated, but with an O(n^2)
+   the output from "diff -c/--cc" has been updated, but with O(n^2)
    complexity, so this might turn out to be undesirable.
 
  * The code to enforce permission bits on files in $GIT_DIR/ for
-   shared repositories have been simplified.
+   shared repositories has been simplified.
 
- * A few codepaths knew how much data they need to put in the
-   hashtables they use upfront, but still started from a small table
-   repeatedly growing and rehashing.
+ * A few codepaths know how much data they need to put in the
+   hashtables they use when they start, but still began with small tables
+   and repeatedly grew and rehashed them.
 
  * The API to walk reflog entries from the latest to older, which was
    necessary for operations such as "git checkout -", was cumbersome
@@ -202,9 +201,9 @@ Performance, Internal Implementation, etc.
  * The pkt-line API, implementation and its callers have been cleaned
    up to make them more robust.
 
- * Cygwin port has a faster-but-lying lstat(2) emulation whose
+ * The Cygwin port has a faster-but-lying lstat(2) emulation whose
    incorrectness does not matter in practice except for a few
-   codepaths, and setting permission bits to directories is a codepath
+   codepaths, and setting permission bits on directories is a codepath
    that needs to use a more correct one.
 
  * "git checkout" had repeated pathspec matches on the same paths,
@@ -225,42 +224,42 @@ Unless otherwise noted, all the fixes since v1.8.2 in the maintenance
 track are contained in this release (see release notes to them for
 details).
 
- * When receive-pack detects error in the pack header it received in
+ * When receive-pack detects an error in the pack header it received in
    order to decide which of unpack-objects or index-pack to run, it
-   returned without closing the error stream, which led to a hang
+   returned without closing the error stream, which led to a hung
    sideband thread.
 
- * Zsh completion forgot that '%' character used to signal untracked
+ * Zsh completion forgot that the '%' character used to signal untracked
    files needs to be escaped with another '%'.
 
  * A commit object whose author or committer ident are malformed
-   crashed some code that trusted that a name, an email and an
+   crashed some code that trusted that a name, an email and a
    timestamp can always be found in it.
 
  * When "upload-pack" fails while generating a pack in response to
-   "git fetch" (or "git clone"), the receiving side mistakenly said
-   there was a programming error to trigger the die handler
+   "git fetch" (or "git clone"), the receiving side had
+   a programming error that triggered the die handler
    recursively.
 
- * "rev-list --stdin" and friends kept bogus pointers into input
+ * "rev-list --stdin" and friends kept bogus pointers into the input
    buffer around as human readble object names.  This was not a huge
    problem but was exposed by a new change that uses these names in
    error output.
    (merge 70d26c6 tr/copy-revisions-from-stdin later to maint).
 
  * Smart-capable HTTP servers were not restricted via the
-   GIT_NAMESPACE mechanism when talking with commit-walker clients,
-   like they do when talking with smart HTTP clients.
+   GIT_NAMESPACE mechanism when talking with commit-walking clients,
+   like they are when talking with smart HTTP clients.
    (merge 6130f86 jk/http-dumb-namespaces later to maint).
 
  * "git merge-tree" did not omit a merge result that is identical to
-   "our" side in certain cases.
+   the "our" side in certain cases.
    (merge aacecc3 jk/merge-tree-added-identically later to maint).
 
- * Perl scripts like "git-svn" closed (not redirecting to /dev/null)
+ * Perl scripts like "git-svn" closed (instead of redirecting to /dev/null)
    the standard error stream, which is not a very smart thing to do.
-   Later open may return file descriptor #2 for unrelated purpose, and
-   error reporting code may write into them.
+   A later open may return file descriptor #2 for an unrelated purpose, and
+   error reporting code may write into it.
 
  * "git show-branch" was not prepared to show a very long run of
    ancestor operators e.g. foobar^2~2^2^2^2...^2~4 correctly.
@@ -268,17 +267,17 @@ details).
  * "git diff --diff-algorithm algo" is also understood as "git diff
    --diff-algorithm=algo".
 
- * The new core.commentchar configuration was not applied to a few
+ * The new core.commentchar configuration was not applied in a few
    places.
 
  * "git bundle" did not like a bundle created using a commit without
-   any message as its one of the prerequistes.
+   any message, as it is one of the prerequistes.
 
  * "git log -S/-G" started paying attention to textconv filter, but
-   there was no way to disable this.  Make it honor --no-textconv
+   there was no way to disable this.  Make it honor the --no-textconv
    option.
 
- * When used with "-d temporary-directory" option, "git filter-branch"
+ * When used with the "-d temporary-directory" option, "git filter-branch"
    failed to come back to the original working tree to perform the
    final clean-up procedure.
 
@@ -287,9 +286,9 @@ details).
    not pay much attention to the annotated tag payload.  Make the code
    notice the type of the tag object, in addition to the dwim_ref()
    based classification the current code uses (i.e. the name appears
-   in refs/tags/) to decide when to special case merging of tags.
+   in refs/tags/) to decide when to special-case tag merging.
 
- * Fix 1.8.1.x regression that stopped matching "dir" (without
+ * Fix a 1.8.1.x regression that stopped matching "dir" (without a
    trailing slash) to a directory "dir".
    (merge efa5f82 jc/directory-attrs-regression-fix later to maint-1.8.1).
 
@@ -300,46 +299,46 @@ details).
  * The prompt string generator (in contrib/completion/) did not notice
    when we are in a middle of a "git revert" session.
 
- * "submodule summary --summary-limit" option did not support
+ * "submodule summary --summary-limit" option did not support the
    "--option=value" form.
 
  * "index-pack --fix-thin" used an uninitialized value to compute
-   delta depths of objects it appends to the resulting pack.
+   the delta depths of objects it appends to the resulting pack.
 
- * "index-pack --verify-stat" used a few counters outside protection
-   of mutex, possibly showing incorrect numbers.
+ * "index-pack --verify-stat" used a few counters outside the protection
+   of a mutex, possibly showing incorrect numbers.
 
  * The code to keep track of what directory names are known to Git on
-   platforms with case insensitive filesystems can get confused upon a
-   hash collision between these pathnames and looped forever.
+   platforms with case insensitive filesystems could get confused upon a
+   hash collision between these pathnames and would loop forever.
 
- * Annotated tags outside refs/tags/ hierarchy were not advertised
-   correctly to the ls-remote and fetch with recent version of Git.
+ * Annotated tags outside the refs/tags/ hierarchy were not advertised
+   correctly to ls-remote and fetch with recent versions of Git.
 
- * Recent optimization broke shallow clones.
+ * Recent optimizations broke shallow clones.
 
  * "git cmd -- ':(top'" was not diagnosed as an invalid syntax, and
    instead the parser kept reading beyond the end of the string.
 
  * "git tag -f <tag>" always said "Updated tag '<tag>'" even when
-   creating a new tag (i.e. not overwriting nor updating).
+   creating a new tag (i.e. neither overwriting nor updating).
 
  * "git p4" did not behave well when the path to the root of the P4
    client was not its real path.
    (merge bbd8486 pw/p4-symlinked-root later to maint).
 
- * "git archive" reports a failure when asked to create an archive out
-   of an empty tree.  It would be more intuitive to give an empty
+ * "git archive" reported a failure when asked to create an archive out
+   of an empty tree.  It is more intuitive to give an empty
    archive back in such a case.
 
- * When "format-patch" quoted a non-ascii strings on the header files,
+ * When "format-patch" quoted a non-ascii string in header files,
    it incorrectly applied rfc2047 and chopped a single character in
-   the middle of it.
+   the middle of the string.
 
  * An aliased command spawned from a bare repository that does not say
-   it is bare with "core.bare = yes" is treated as non-bare by mistake.
+   it is bare with "core.bare = yes" was treated as non-bare by mistake.
 
- * In "git reflog expire", REACHABLE bit was not cleared from the
+ * In "git reflog expire", the REACHABLE bit was not cleared from the
    correct objects.
 
  * The logic used by "git diff -M --stat" to shorten the names of
@@ -347,9 +346,9 @@ details).
    common prefix and suffix between the two filenames overlapped.
 
  * The "--match=<pattern>" option of "git describe", when used with
-   "--all" to allow refs that are not annotated tags to be used as a
+   "--all" to allow refs that are not annotated tags to be a
    base of description, did not restrict the output from the command
-   to those that match the given pattern.
+   to those refs that match the given pattern.
 
  * Clarify in the documentation "what" gets pushed to "where" when the
    command line to "git push" does not say these explicitly.
@@ -357,7 +356,7 @@ details).
  * The "--color=<when>" argument to the commands in the diff family
    was described poorly.
 
- * The arguments given to pre-rebase hook were not documented.
+ * The arguments given to the pre-rebase hook were not documented.
 
  * The v4 index format was not documented.
 
@@ -375,7 +374,7 @@ details).
 
  * In the v1.8.0 era, we changed symbols that do not have to be global
    to file scope static, but a few functions in graph.c were used by
-   CGit from sideways bypassing the entry points of the API the
+   CGit sideways, bypassing the entry points of the API the
    in-tree users use.
 
  * "git update-index -h" did not do the usual "-h(elp)" thing.
@@ -388,30 +387,30 @@ details).
    $msg already ended with one.
 
  * The SSL peer verification done by "git imap-send" did not ask for
-   Server Name Indication (RFC 4366), failing to connect SSL/TLS
+   Server Name Indication (RFC 4366), failing to connect to SSL/TLS
    sites that serve multiple hostnames on a single IP.
 
  * perl/Git.pm::cat_blob slurped everything in core only to write it
    out to a file descriptor, which was not a very smart thing to do.
 
  * "git branch" did not bother to check nonsense command line
-   parameters and issue errors in many cases.
+   parameters.  It now issues errors in many cases.
 
- * Verification of signed tags were not done correctly when not in C
+ * Verification of signed tags was not done correctly when not in C
    or en/US locale.
 
  * Some platforms and users spell UTF-8 differently; retry with the
    most official "UTF-8" when the system does not understand the
-   user-supplied encoding name that are the common alternative
-   spellings of UTF-8.
+   user-supplied encoding name that is a common alternative
+   spelling of UTF-8.
 
- * When export-subst is used, "zip" output recorded incorrect
+ * When export-subst is used, "zip" output recorded an incorrect
    size of the file.
 
  * "git am $maildir/" applied messages in an unexpected order; sort
    filenames read from the maildir/ in a way that is more likely to
-   sort messages in the order the writing MUA meant to, by sorting
-   numeric segment in numeric order and non-numeric segment in
+   sort the messages in the order the writing MUA meant to, by sorting
+   numeric segments in numeric order and non-numeric segments in
    alphabetical order.
 
  * "git submodule update", when recursed into sub-submodules, did not
-- 
1.8.2
