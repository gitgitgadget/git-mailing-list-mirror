From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH] RelNotes: Spelling & grammar fixes.
Date: Thu, 14 Nov 2013 12:01:13 -0500
Message-ID: <1384448473-25840-1-git-send-email-marcnarc@xiplink.com>
References: <xmqqsiuzdhov.fsf@gitster.dls.corp.google.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 14 18:07:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vh0OA-0002wx-Ck
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 18:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049Ab3KNRH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 12:07:26 -0500
Received: from IP-192-252-130-194.static.fibrenoire.ca ([192.252.130.194]:1375
	"EHLO cubert.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752930Ab3KNRHX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Nov 2013 12:07:23 -0500
X-Greylist: delayed 406 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Nov 2013 12:07:23 EST
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
	by cubert.xiplink.com (Postfix) with ESMTP id C9E946009C;
	Thu, 14 Nov 2013 12:00:36 -0500 (EST)
X-Mailer: git-send-email 1.8.4.3.dirty
In-Reply-To: <xmqqsiuzdhov.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237858>

---

Mostly just tweaks, although I did change the "foo^{tag}" description a lot.

		M.

 Documentation/RelNotes/1.8.5.txt | 158 ++++++++++++++++++++-------------------
 1 file changed, 80 insertions(+), 78 deletions(-)

diff --git a/Documentation/RelNotes/1.8.5.txt b/Documentation/RelNotes/1.8.5.txt
index 13b4336..352dbbb 100644
--- a/Documentation/RelNotes/1.8.5.txt
+++ b/Documentation/RelNotes/1.8.5.txt
@@ -8,7 +8,7 @@ When "git push [$there]" does not say what to push, we have used the
 traditional "matching" semantics so far (all your branches were sent
 to the remote as long as there already are branches of the same name
 over there).  In Git 2.0, the default will change to the "simple"
-semantics that pushes:
+semantics, which pushes:
 
  - only the current branch to the branch with the same name, and only
    when the current branch is set to integrate with that remote
@@ -55,7 +55,7 @@ Foreign interfaces, subsystems and ports.
 
  * "git-svn" used with SVN 1.8.0 when talking over https:// connection
    dumped core due to a bug in the serf library that SVN uses.  Work
-   it around on our side, even though the SVN side is being fixed.
+   around it on our side, even though the SVN side is being fixed.
 
  * On MacOS X, we detected if the filesystem needs the "pre-composed
    unicode strings" workaround, but did not automatically enable it.
@@ -65,7 +65,7 @@ Foreign interfaces, subsystems and ports.
    repository relative to the home directory, e.g. "clone hg::~/there".
 
  * imap-send ported to OS X uses Apple's security framework instead of
-   OpenSSL one.
+   OpenSSL's.
 
  * Subversion 1.8.0 that was recently released breaks older subversion
    clients coming over http/https in various ways.
@@ -79,22 +79,22 @@ UI, Workflows & Features
  * xdg-open can be used as a browser backend for "git web-browse"
    (hence to show "git help -w" output), when available.
 
- * "git grep" and "git show" pays attention to "--textconv" option
+ * "git grep" and "git show" pay attention to the "--textconv" option
    when these commands are told to operate on blob objects (e.g. "git
-   grep -e pattern HEAD:Makefile").
+   grep -e pattern --textconv HEAD:Makefile").
 
  * "git replace" helper no longer allows an object to be replaced with
    another object of a different type to avoid confusion (you can
-   still manually craft such replacement using "git update-ref", as an
+   still manually craft such a replacement using "git update-ref", as an
    escape hatch).
 
- * "git status" no longer prints dirty status information for
+ * "git status" no longer prints the dirty status information of
    submodules for which submodule.$name.ignore is set to "all".
 
  * "git rebase -i" honours core.abbrev when preparing the insn sheet
    for editing.
 
- * "git status" during a cherry-pick shows what original commit is
+ * "git status" during a cherry-pick shows which original commit is
    being picked.
 
  * Instead of typing four capital letters "HEAD", you can say "@" now,
@@ -102,21 +102,21 @@ UI, Workflows & Features
 
  * "git check-ignore" follows the same rule as "git add" and "git
    status" in that the ignore/exclude mechanism does not take effect
-   on paths that are already tracked.  With "--no-index" option, it
+   on paths that are already tracked.  With the "--no-index" option, it
    can be used to diagnose which paths that should have been ignored
    have been mistakenly added to the index.
 
  * Some irrelevant "advice" messages that are shared with "git status"
    output have been removed from the commit log template.
 
- * "update-refs" learnt a "--stdin" option to read multiple update
+ * "update-refs" learned a "--stdin" option to read multiple update
    requests and perform them in an all-or-none fashion.
 
  * Just like "make -C <directory>", "git -C <directory> ..." tells Git
    to go there before doing anything else.
 
- * Just like "git checkout -" knows to check out and "git merge -"
-   knows to merge the branch you were previously on, "git cherry-pick"
+ * Just like "git checkout -" knows to check out, and "git merge -"
+   knows to merge, the branch you were previously on, "git cherry-pick"
    now understands "git cherry-pick -" to pick from the previous
    branch.
 
@@ -126,56 +126,58 @@ UI, Workflows & Features
    "git status --porcelain" instead, as its format is stable and easier
    to parse.
 
- * Make "foo^{tag}" to peel a tag to itself, i.e. no-op., and fail if
-   "foo" is not a tag.  "git rev-parse --verify v1.0^{tag}" would be
-   a more convenient way to say "test $(git cat-file -t v1.0) = tag".
+ * The ref syntax "foo^{tag}" (with the literal string "{tag}") peels a
+   tag ref to itself, i.e. it's a no-op., and fails if
+   "foo" is not a tag.  "git rev-parse --verify v1.0^{tag}" is
+   a more convenient way than "test $(git cat-file -t v1.0) = tag" to
+   check if v1.0 is a tag.
 
  * "git branch -v -v" (and "git status") did not distinguish among a
-   branch that does not build on any other branch, a branch that is in
-   sync with the branch it builds on, and a branch that is configured
-   to build on some other branch that no longer exists.
+   branch that is not tracking any other branch, a branch that is in
+   sync with the branch it is tracking, and a branch that is tracking
+   some other branch that no longer exists.
 
- * Earlier we started rejecting an attempt to add 0{40} object name to
+ * Earlier we started rejecting any attempt to add the 0{40} object name to
    the index and to tree objects, but it sometimes is necessary to
-   allow so to be able to use tools like filter-branch to correct such
-   broken tree objects.  "filter-branch" can again be used to to do
-   so.
+   allow this to be able to use tools like filter-branch to correct such
+   broken tree objects.  "filter-branch" can again be used to do this.
 
  * "git config" did not provide a way to set or access numbers larger
    than a native "int" on the platform; it now provides 64-bit signed
    integers on all platforms.
 
  * "git pull --rebase" always chose to do the bog-standard flattening
-   rebase.  You can tell it to run "rebase --preserve-merges" by
+   rebase.  You can tell it to run "rebase --preserve-merges" with
+   "git pull --rebase=preserve" or by
    setting "pull.rebase" configuration to "preserve".
 
  * "git push --no-thin" actually disables the "thin pack transfer"
    optimization.
 
- * Magic pathspecs like ":(icase)makefile" that matches both Makefile
-   and makefile and ":(glob)foo/**/bar" that matches "bar" in "foo"
-   and any subdirectory of "foo" can be used in more places.
+ * Magic pathspecs like ":(icase)makefile" (matches both Makefile
+   and makefile) and ":(glob)foo/**/bar" (matches "bar" in "foo"
+   and any subdirectory of "foo") can be used in more places.
 
- * The "http.*" variables can now be specified per URL that the
-   configuration applies.  For example,
+ * The "http.*" variables can now be specified for individual URLs.
+   For example,
 
    [http]
        sslVerify = true
    [http "https://weak.example.com/"]
        sslVerify = false
 
-   would flip http.sslVerify off only when talking to that specified
+   would flip http.sslVerify off only when talking to that specific
    site.
 
- * "git mv A B" when moving a submodule A has been taught to
-   relocate its working tree and to adjust the paths in the
+ * "git mv A B" when moving a submodule has been taught to
+   relocate the submodule's working tree and to adjust the paths in the
    .gitmodules file.
 
  * "git blame" can now take more than one -L option to discover the
-   origin of multiple blocks of the lines.
+   origin of multiple blocks of lines.
 
  * The http transport clients can optionally ask to save cookies
-   with http.savecookies configuration variable.
+   with the http.savecookies configuration variable.
 
  * "git push" learned a more fine grained control over a blunt
    "--force" when requesting a non-fast-forward update with the
@@ -197,7 +199,7 @@ UI, Workflows & Features
 
  * "git whatchanged" may still be used by old timers, but mention of
    it in documents meant for new users will only waste readers' time
-   wonderig what the difference is between it and "git log".  Make it
+   wondering what the difference is between it and "git log".  Make it
    less prominent in the general part of the documentation and explain
    that it is merely a "git log" with different default behaviour in
    its own document.
@@ -219,23 +221,23 @@ Performance, Internal Implementation, etc.
    should apply the same "no subprocess or pipe" optimization as we
    apply to user-supplied GIT_PAGER=cat.
 
- * Many commands use --dashed-option as a operation mode selector
-   (e.g. "git tag --delete") that the user can use at most one
-   (e.g. "git tag --delete --verify" is a nonsense) and you cannot
-   negate (e.g. "git tag --no-delete" is a nonsense).  parse-options
+ * Many commands use a --dashed-option as an operation mode selector
+   (e.g. "git tag --delete") that excludes other operation modes
+   (e.g. "git tag --delete --verify" is nonsense) and that cannot be
+   negated (e.g. "git tag --no-delete" is nonsense).  The parse-options
    API learned a new OPT_CMDMODE macro to make it easier to implement
    such a set of options.
 
- * OPT_BOOLEAN() in parse-options API was misdesigned to be "counting
+ * OPT_BOOLEAN() in the parse-options API was misdesigned to be "counting
    up" but many subcommands expect it to behave as "on/off". Update
    them to use OPT_BOOL() which is a proper boolean.
 
- * "git gc" exits early without doing a double-work when it detects
+ * "git gc" exits early without doing any work when it detects
    that another instance of itself is already running.
 
  * Under memory pressure and/or file descriptor pressure, we used to
-   close pack windows that are not used and also closed filehandle to
-   an open but unused packfiles. These are now controlled separately
+   close pack windows that are not used and also closed filehandles to
+   open but unused packfiles. These are now controlled separately
    to better cope with the load.
 
 Also contains various documentation updates and code clean-ups.
@@ -245,32 +247,32 @@ Fixes since v1.8.4
 ------------------
 
 Unless otherwise noted, all the fixes since v1.8.4 in the maintenance
-track are contained in this release (see release notes to them for
+track are contained in this release (see the maintenance releases' notes for
 details).
 
  * An ancient How-To on serving Git repositories on an HTTP server
-   lacked a warning that it has been mostly superseded with more
+   lacked a warning that it has been mostly superseded with a more
    modern way.
    (merge 6d52bc3 sc/doc-howto-dumb-http later to maint).
 
- * The interaction between use of Perl in our test suite and NO_PERL
+ * The interaction between the use of Perl in our test suite and NO_PERL
    has been clarified a bit.
    (merge f8fc0ee jn/test-prereq-perl-doc later to maint).
 
- * The synopsis section of "git unpack-objects" documentation has been
+ * The synopsis section of the "git unpack-objects" documentation has been
    clarified a bit.
    (merge 61e2e22 vd/doc-unpack-objects later to maint).
 
- * We did not generate HTML version of documentation to "git subtree"
+ * We did not generate the HTML version of the documentation to "git subtree"
    in contrib/.
    (merge 95c62fb jk/subtree-install-fix later to maint).
 
  * A fast-import stream expresses a pathname with funny characters by
-   quoting them in C style; remote-hg remote helper forgot to unquote
+   quoting them in C style; the remote-hg remote helper forgot to unquote
    such a path.
    (merge 1136265 ap/remote-hg-unquote-cquote later to maint).
 
- * "git reset -p HEAD" has a codepath to special case it to behave
+ * "git reset -p HEAD" has a codepath to special-case it to behave
    differently from resetting to contents of other commits, but a
    recent change broke it.
 
@@ -289,38 +291,38 @@ details).
    "HEAD" points at, and the receiving end needed to guess.  A new
    capability has been defined in the pack protocol to convey this
    information so that cloning from a repository with more than one
-   branches pointing at the same commit where the HEAD is at now
+   branch pointing at the same commit where the HEAD is at now
    reliably sets the initial branch in the resulting repository.
    (merge 360a326 jc/upload-pack-send-symref later to maint).
 
- * We did not handle cases where http transport gets redirected during
+ * We did not handle cases where the http transport gets redirected during
    the authorization request (e.g. from http:// to https://).
    (merge 70900ed jk/http-auth-redirects later to maint).
 
  * Bash prompting code to deal with an SVN remote as an upstream
-   were coded in a way not supported by older Bash versions (3.x).
+   was coded in a way unsupported by older Bash versions (3.x).
    (merge 52ec889 sg/prompt-svn-remote-fix later to maint).
 
  * The fall-back parsing of commit objects with broken author or
-   committer lines were less robust than ideal in picking up the
+   committer lines was less robust than ideal in picking up the
    timestamps.
    (merge 03818a4 jk/split-broken-ident later to maint).
 
- * "git rev-list --objects ^v1.0^ v1.0" gave v1.0 tag itself in the
+ * "git rev-list --objects ^v1.0^ v1.0" gave the v1.0 tag itself in the
    output, but "git rev-list --objects v1.0^..v1.0" did not.
    (merge 895c5ba jc/revision-range-unpeel later to maint).
 
- * "git clone" gave some progress messages to the standard output, not
-   to the standard error, and did not allow suppressing them with the
+ * "git clone" wrote some progress messages to standard output, not
+   to standard error, and did not suppress them with the
    --no-progress option.
    (merge 643f918 jk/clone-progress-to-stderr later to maint).
 
- * "format-patch --from=<whom>" forgot to omit unnecessary in-body
+ * "format-patch --from=<whom>" forgot to omit an unnecessary in-body
    from line, i.e. when <whom> is the same as the real author.
    (merge 662cc30 jk/format-patch-from later to maint).
 
  * "git shortlog" used to choke and die when there is a malformed
-   commit (e.g. missing authors); it now simply ignore such a commit
+   commit (e.g. missing authors); it now simply ignores such a commit
    and keeps going.
    (merge cd4f09e jk/shortlog-tolerate-broken-commit later to maint).
 
@@ -334,16 +336,16 @@ details).
    small empty messages to keep the connection alive.
    (merge 115dedd jk/upload-pack-keepalive later to maint).
 
- * "git rebase" had a portability regression in v1.8.4 to trigger a
+ * "git rebase" had a portability regression in v1.8.4 that triggered a
    bug in some BSD shell implementations.
    (merge 99855dd mm/rebase-continue-freebsd-WB later to maint).
 
  * "git branch --track" had a minor regression in v1.8.3.2 and later
    that made it impossible to base your local work on anything but a
-   local branch of the upstream repository you are tracking from.
+   local branch of the upstream repository you are tracking.
    (merge b0f49ff jh/checkout-auto-tracking later to maint).
 
- * When the webserver responds with "405 Method Not Allowed", "git
+ * When the web server responds with "405 Method Not Allowed", "git
    http-backend" should tell the client what methods are allowed with
    the "Allow" header.
    (merge 9247be0 bc/http-backend-allow-405 later to maint).
@@ -357,22 +359,22 @@ details).
    executable files.
    (merge 1b48d56 jc/cvsserver-perm-bit-fix later to maint).
 
- * When send-email comes up with an error message to die with upon
+ * When send-email obtains an error message to die with upon
    failure to start an SSL session, it tried to read the error string
    from a wrong place.
    (merge 6cb0c88 bc/send-email-ssl-die-message-fix later to maint).
 
- * The implementation of "add -i" has a crippling code to work around
+ * The implementation of "add -i" has some crippling code to work around an
    ActiveState Perl limitation but it by mistake also triggered on Git
    for Windows where MSYS perl is used.
    (merge df17e77 js/add-i-mingw later to maint).
 
- * We made sure that we notice the user-supplied GIT_DIR is actually a
+ * We made sure that we notice when the user-supplied GIT_DIR is actually a
    gitfile, but did not do the same when the default ".git" is a
    gitfile.
    (merge 487a2b7 nd/git-dir-pointing-at-gitfile later to maint).
 
- * When an object is not found after checking the packfiles and then
+ * When an object is not found after checking the packfiles and the
    loose object directory, read_sha1_file() re-checks the packfiles to
    prevent racing with a concurrent repacker; teach the same logic to
    has_sha1_file().
@@ -390,22 +392,22 @@ details).
    made it unnecessarily inefficient.
    (merge 680be04 jc/ls-files-killed-optim later to maint).
 
- * The commit object names in the insn sheet that was prepared at the
-   beginning of "rebase -i" session can become ambiguous as the
+ * The shortened commit object names in the insn sheet that is prepared at the
+   beginning of a "rebase -i" session can become ambiguous as the
    rebasing progresses and the repository gains more commits. Make
    sure the internal record is kept with full 40-hex object names.
    (merge 75c6976 es/rebase-i-no-abbrev later to maint).
 
  * "git rebase --preserve-merges" internally used the merge machinery
-   and as a side effect, left merge summary message in the log, but
-   when rebasing, there should not be a need for merge summary.
+   and as a side effect left the merge summary message in the log, but
+   when rebasing there is no need for the merge summary.
    (merge a9f739c rt/rebase-p-no-merge-summary later to maint).
 
- * A call to xread() was used without a loop around to cope with short
-   read in the codepath to stream new contents to a pack.
+ * A call to xread() was used without a loop around it to cope with short
+   reads in the codepath to stream new contents to a pack.
    (merge e92527c js/xread-in-full later to maint).
 
- * "git rebase -i" forgot that the comment character can be
+ * "git rebase -i" forgot that the comment character is
    configurable while reading its insn sheet.
    (merge 7bca7af es/rebase-i-respect-core-commentchar later to maint).
 
@@ -416,8 +418,8 @@ details).
  * We used to send a large request to read(2)/write(2) as a single
    system call, which was bad from the latency point of view when
    the operation needs to be killed, and also triggered an error on
-   broken 64-bit systems that refuse to take more than 2GB read or
-   write in one go.
+   broken 64-bit systems that refuse to read or write more than 2GB
+   in one go.
    (merge a487916 sp/clip-read-write-to-8mb later to maint).
 
  * "git fetch" that auto-followed tags incorrectly reused the
@@ -431,17 +433,17 @@ details).
    had a similar problem.
    (merge 838f9a1 tr/log-full-diff-keep-true-parents later to maint).
 
- * Setting submodule.*.path configuration variable to true (without
+ * Setting a submodule.*.path configuration variable to true (without
    giving "= value") caused Git to segfault.
    (merge 4b05440 jl/some-submodule-config-are-not-boolean later to maint).
 
  * "git rebase -i" (there could be others, as the root cause is pretty
-   generic) fed a random, data dependeant string to 'echo' and
-   expects it to come out literally, corrupting its error message.
+   generic) fed a random, data dependent string to 'echo' and
+   expected it to come out literally, corrupting its error message.
    (merge 89b0230 mm/no-shell-escape-in-die-message later to maint).
 
  * Some people still use rather old versions of bash, which cannot
-   grok some constructs like 'printf -v varname' the prompt and
+   grok some constructs like 'printf -v varname' which the prompt and
    completion code started to use recently.
    (merge a44aa69 bc/completion-for-bash-3.0 later to maint).
 
-- 
1.8.4.3.dirty
