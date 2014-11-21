From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH] RelNotes: Spelling & grammar tweaks.
Date: Fri, 21 Nov 2014 18:10:04 -0500
Message-ID: <1416611404-16518-1-git-send-email-marcnarc@xiplink.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 22 00:16:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrxR2-0004WB-EZ
	for gcvg-git-2@plane.gmane.org; Sat, 22 Nov 2014 00:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbaKUXQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 18:16:12 -0500
Received: from domain.not.configured ([192.252.130.194]:32893 "EHLO
	cubert.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751170AbaKUXQL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2014 18:16:11 -0500
X-Greylist: delayed 418 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Nov 2014 18:16:11 EST
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
	by cubert.xiplink.com (Postfix) with ESMTP id B6CD1601AD;
	Fri, 21 Nov 2014 18:09:10 -0500 (EST)
X-Mailer: git-send-email 2.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---
 Documentation/RelNotes/2.2.0.txt | 102 +++++++++++++++++++--------------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/Documentation/RelNotes/2.2.0.txt b/Documentation/RelNotes/2.2.0.txt
index d4001c5..9d9d5d5 100644
--- a/Documentation/RelNotes/2.2.0.txt
+++ b/Documentation/RelNotes/2.2.0.txt
@@ -9,20 +9,20 @@ Ports
  * Building on older MacOS X systems automatically sets
    the necessary NO_APPLE_COMMON_CRYPTO build-time option.
 
- * The support to build with NO_PTHREADS has been resurrected.
+ * Building with NO_PTHREADS has been resurrected.
 
- * Compilation options has been updated a bit to support z/OS port
-   better.
+ * Compilation options have been updated a bit to better support the
+   z/OS port.
 
 
 UI, Workflows & Features
 
- * "git archive" learned to filter what gets archived with pathspec.
+ * "git archive" learned to filter what gets archived with a pathspec.
 
  * "git config --edit --global" starts from a skeletal per-user
    configuration file contents, instead of a total blank, when the
-   user does not already have any.  This immediately reduces the
-   need for a later "Have you forgotten setting core.user?" and we
+   user does not already have any global config.  This immediately reduces the
+   need later "Have you forgotten to set core.user?" messages, and we
    can add more to the template as we gain more experience.
 
  * "git stash list -p" used to be almost always a no-op because each
@@ -33,35 +33,35 @@ UI, Workflows & Features
  * Sometimes users want to report a bug they experience on their
    repository, but they are not at liberty to share the contents of
    the repository.  "fast-export" was taught an "--anonymize" option
-   to replace blob contents, names of people and paths and log
+   to replace blob contents, names of people, paths and log
    messages with bland and simple strings to help them.
 
  * "git difftool" learned an option to stop feeding paths to the
    diff backend when it exits with a non-zero status.
 
- * "git grep" allows to paint (or not paint) partial matches on
+ * "git grep" learned to paint (or not paint) partial matches on
    context lines when showing "grep -C<num>" output in color.
 
- * "log --date=iso" uses a slight variant of ISO 8601 format that is
-   made more human readable.  A new "--date=iso-strict" option gives
-   datetime output that is more strictly conformant.
+ * "log --date=iso" uses a slight variant of the ISO 8601 format that is
+   more human readable.  A new "--date=iso-strict" option gives
+   datetime output that conforms more strictly.
 
  * The logic "git prune" uses is more resilient against various corner
    cases.
 
  * A broken reimplementation of Git could write an invalid index that
-   records both stage #0 and higher stage entries for the same path.
+   records both stage #0 and higher-stage entries for the same path.
    We now notice and reject such an index, as there is no sensible
    fallback (we do not know if the broken tool wanted to resolve and
-   forgot to remove higher stage entries, or if it wanted to unresolve
-   and forgot to remove the stage#0 entry).
+   forgot to remove the higher-stage entries, or if it wanted to unresolve
+   and forgot to remove the stage #0 entry).
 
- * The temporary files "git mergetool" uses are named to avoid too
+ * The temporary files "git mergetool" uses are renamed to avoid too
    many dots in them (e.g. a temporary file for "hello.c" used to be
    named e.g. "hello.BASE.4321.c" but now uses underscore instead,
    e.g. "hello_BASE_4321.c").
 
- * The temporary files "git mergetools" uses can be placed in a newly
+ * The temporary files "git mergetool" uses can be placed in a newly
    created temporary directory, instead of the current directory, by
    setting the mergetool.writeToTemp configuration variable.
 
@@ -73,7 +73,7 @@ UI, Workflows & Features
    to consume their input fully (not following this requirement used
    to result in intermittent errors in "git push").
 
- * The pretty-format specifier "%d", which expanded to " (tagname)"
+ * The pretty-format specifier "%d", which expands to " (tagname)"
    for a tagged commit, gained a cousin "%D" that just gives the
    "tagname" without frills.
 
@@ -86,14 +86,14 @@ UI, Workflows & Features
    without having to "trust" the server.
 
  * "git interpret-trailers" is a new filter to programmatically edit
-    the tail end of the commit log messages.
+   the tail end of the commit log messages.
 
  * "git help everyday" shows the "Everyday Git in 20 commands or so"
    document, whose contents have been updated to more modern Git
    practice.
 
- * On the "git svn" front, work to reduce memory consumption and
-   to improve handling of mergeinfo progresses.
+ * On the "git svn" front, work progresses to reduce memory consumption and
+   to improve handling of mergeinfo.
 
 
 Performance, Internal Implementation, etc.
@@ -106,18 +106,18 @@ Performance, Internal Implementation, etc.
  * The lockfile API and its users have been cleaned up.
 
  * We no longer attempt to keep track of individual dependencies to
-   the header files in the build procedure, relying on automated
+   the header files in the build procedure, relying instead on automated
    dependency generation support from modern compilers.
 
  * In tests, we have been using NOT_{MINGW,CYGWIN} test prerequisites
    long before negated prerequisites e.g. !MINGW were invented.
    The former has been converted to the latter to avoid confusion.
 
- * Looking up remotes configuration in a repository with very many
-   remotes defined has been optimized.
+ * Optimized looking up a remote's configuration in a repository with very many
+   remotes defined.
 
  * There are cases where you lock and open to write a file, close it
-   to show the updated contents to external processes, and then have
+   to show the updated contents to an external processes, and then have
    to update the file again while still holding the lock, but the
    lockfile API lacked support for such an access pattern.
 
@@ -125,15 +125,15 @@ Performance, Internal Implementation, etc.
    decoration has been updated to make it less cumbersome to use.
 
  * An in-core caching layer to let us avoid reading the same
-   configuration files number of times has been added.  A few commands
+   configuration files several times has been added.  A few commands
    have been converted to use this subsystem.
 
  * Various code paths have been cleaned up and simplified by using
-   "strbuf", "starts_with()", and "skip_prefix()" APIs more.
+   the "strbuf", "starts_with()", and "skip_prefix()" APIs more.
 
  * A few codepaths that died when large blobs that would not fit in
    core are involved in their operation have been taught to punt
-   instead, by e.g. marking too large a blob as not to be diffed.
+   instead, by e.g. marking a too-large blob as not to be diffed.
 
  * A few more code paths in "commit" and "checkout" have been taught
    to repopulate the cache-tree in the index, to help speed up later
@@ -141,7 +141,7 @@ Performance, Internal Implementation, etc.
    "status").
 
  * A common programming mistake to assign the same short option name
-   to two separate options is detected by parse_options() API to help
+   to two separate options is detected by the parse_options() API to help
    developers.
 
  * The code path to write out the packed-refs file has been optimized,
@@ -153,7 +153,7 @@ Performance, Internal Implementation, etc.
    especially matters in a repository with a large number of existing
    refs.
 
- * "git fsck" was taught to check contents of tag objects a bit more.
+ * "git fsck" was taught to check the contents of tag objects a bit more.
 
  * "git hash-object" was taught a "--literally" option to help
    debugging.
@@ -162,8 +162,8 @@ Performance, Internal Implementation, etc.
    original before feeding the filter.  Instead, stream the file
    contents directly to the filter and process its output.
 
- * The scripts in the test suite can be run with "-x" option to show
-   a shell-trace of each command run in them.
+ * The scripts in the test suite can be run with the "-x" option to show
+   a shell-trace of each command they run.
 
  * The "run-command" API learned to manage the argv and environment
    array for child process, alleviating the need for the callers to
@@ -171,7 +171,7 @@ Performance, Internal Implementation, etc.
 
  * Some people use AsciiDoctor, instead of AsciiDoc, to format our
    documentation set; the documentation has been adjusted, as
-   AsciiDoctor is pickier than AsciiDoc in its input mark-up.
+   AsciiDoctor is pickier than AsciiDoc about its input mark-up.
 
 
 Also contains various documentation updates and code clean-ups.
@@ -189,21 +189,21 @@ notes for details).
    format", which was counterintuitive.
 
  * "git -c section.var command" and "git -c section.var= command"
-   should pass the configuration differently (the former should be a
+   should pass the configuration value differently (the former should be a
    boolean true, the latter should be an empty string).
 
  * Applying a patch not generated by Git in a subdirectory used to
-   check the whitespace breakage using the attributes for incorrect
+   check for whitespace breakage using the attributes of incorrect
    paths. Also whitespace checks were performed even for paths
-   excluded via "git apply --exclude=<path>" mechanism.
+   excluded via the "git apply --exclude=<path>" mechanism.
 
- * "git bundle create" with date-range specification were meant to
+ * "git bundle create" with a date-range specification was meant to
    exclude tags outside the range, but it didn't.
 
- * "git add x" where x that used to be a directory has become a
+ * "git add x" where x used to be a directory and is now a
    symbolic link to a directory misbehaved.
 
- * The prompt script checked $GIT_DIR/ref/stash file to see if there
+ * The prompt script checked the $GIT_DIR/ref/stash file to see if there
    is a stash, which was a no-no.
 
  * Pack-protocol documentation had a minor typo.
@@ -217,7 +217,7 @@ notes for details).
    (merge 107efbe rs/daemon-fixes later to maint).
 
  * With sufficiently long refnames, "git fast-import" could have
-   overflown an on-stack buffer.
+   overflowed an on-stack buffer.
 
  * After "pack-refs --prune" packed refs at the top-level, it failed
    to prune them.
@@ -232,8 +232,8 @@ notes for details).
    to first check out <branch>.
    (merge 95c6826 so/rebase-doc later to maint).
 
- * "git push" over HTTP transport had an artificial limit on number of
-   refs that can be pushed imposed by the command line length.
+ * "git push" over HTTP transport had an artificial limit on the number of
+   refs that can be pushed, imposed by the command line length.
    (merge 26be19b jk/send-pack-many-refspecs later to maint).
 
  * When receiving an invalid pack stream that records the same object
@@ -248,19 +248,19 @@ notes for details).
    detached HEAD as a starting point to traverse objects still in use.
    (merge c40fdd0 mk/reachable-protect-detached-head later to maint).
 
- * "git config --add section.var val" used to lose existing
-   section.var whose value was an empty string.
+ * "git config --add section.var val" when section.var already has an
+   empty-string value used to lose the empty-string value.
    (merge c1063be ta/config-add-to-empty-or-true-fix later to maint).
 
  * "git fsck" failed to report that it found corrupt objects via its
    exit status in some cases.
    (merge 30d1038 jk/fsck-exit-code-fix later to maint).
 
- * Use of "--verbose" option used to break "git branch --merged".
+ * Use of the "--verbose" option used to break "git branch --merged".
    (merge 12994dd jk/maint-branch-verbose-merged later to maint).
 
- * Some MUAs mangled a line in a message that begins with "From " to
-   ">From " when writing to a mailbox file and feeding such an input
+ * Some MUAs mangle a line in a message that begins with "From " to
+   ">From " when writing to a mailbox file, and feeding such an input
    to "git am" used to lose such a line.
    (merge 85de86a jk/mbox-from-line later to maint).
 
@@ -273,8 +273,8 @@ notes for details).
    coding guidelines.
    (merge 1c4b660 da/include-compat-util-first-in-c later to maint).
 
- * t7004 test, which tried to run Git with small stack space, has been
-   updated to give a bit larger stack to avoid false breakage on some
+ * The t7004 test, which tried to run Git with small stack space, has been
+   updated to use a bit larger stack to avoid false breakage on some
    platforms.
    (merge b9a1907 sk/tag-contains-wo-recursion later to maint).
 
@@ -287,11 +287,11 @@ notes for details).
    CGI.pm as of 4.04; use CGI::start_from instead.
    (merge 4750f4b rm/gitweb-start-form later to maint).
 
- * Newer versions of 'meld' breaks the auto-detection we use to see if
+ * Newer versions of 'meld' break the auto-detection we use to see if
    they are new enough to support the `--output` option.
    (merge b12d045 da/mergetool-meld later to maint).
 
- * "git pack-objects" forgot to disable the codepath to generate
+ * "git pack-objects" forgot to disable the codepath to generate the
    object reachability bitmap when it needs to split the resulting
    pack.
    (merge 2113471 jk/pack-objects-no-bitmap-when-splitting later to maint).
@@ -301,7 +301,7 @@ notes for details).
    index file.
    (merge 729dbbd jk/cache-tree-protect-from-broken-libgit2 later to maint).
 
- * "git fetch" into a repository where branch B was deleted earlier
+ * "git fetch" into a repository where branch B was deleted earlier,
    back when it had reflog enabled, and then branch B/C is fetched
    into it without reflog enabled, which is arguably an unlikely
    corner case, unnecessarily failed.
-- 
2.1.3
