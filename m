From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 5/5] RelNotes: wordsmithing
Date: Thu, 23 Apr 2015 14:27:50 +0200
Message-ID: <1429792070-22991-6-git-send-email-mhagger@alum.mit.edu>
References: <1429792070-22991-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 14:28:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlGEu-0005wU-Am
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 14:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934443AbbDWM2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 08:28:13 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:42377 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934422AbbDWM2E (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2015 08:28:04 -0400
X-AuditID: 12074414-f797f6d000004084-63-5538e55267ac
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 92.6D.16516.255E8355; Thu, 23 Apr 2015 08:28:02 -0400 (EDT)
Received: from michael.fritz.box (p4FC97208.dip0.t-ipconnect.de [79.201.114.8])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3NCRsfO011822
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 23 Apr 2015 08:28:01 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1429792070-22991-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsUixO6iqBv01CLUoP2LoEXXlW4mi4beK8wW
	t1fMZ3Zg9vj7/gOTx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGd8bGhiKpjwhLFi4uwTzA2M
	EzYzdjFyckgImEhM//KeCcIWk7hwbz1bFyMXh5DAZUaJnd37mSCc40wSx+ZdZwapYhPQlVjU
	0wzWISKgJjGx7RALiM0s4CCx+XMj2FRhAW2Jk3/vsIPYLAKqElvmvAOL8wq4SMxbsIUNYpuc
	xPnjP8Fmcgq4Smyf3gZmCwHVfL5zh30CI+8CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRboW
	ermZJXqpKaWbGCEBI7KD8chJuUOMAhyMSjy8L7ItQoVYE8uKK3MPMUpyMCmJ8p69CRTiS8pP
	qcxILM6ILyrNSS0+xCjBwawkwrvnNlCONyWxsiq1KB8mJc3BoiTO+22xup+QQHpiSWp2ampB
	ahFMVoaDQ0mCV/EJUKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KD7ii4ERApLi
	AdpbCdLOW1yQmAsUhWg9xajLse9o42ImIZa8/LxUKXHeOpAiAZCijNI8uBWw9PCKURzoY2Fe
	bZAqHmBqgZv0CmgJE9CSmUvBlpQkIqSkGhj9dkyq4TVfmxpTPu3hxN/FuhH7jIOE9aRushU9
	WM+if6w1r/Sc06EZTiULPv7kVRZcGygbczW/yEh5gfGCWfe3nLxZc061puF75v5n99wyv2+t
	PqDb+O9EmrnN8oX3J1xhN7IKu77j0Tmexcuf7Tlrdn1OZ1TGFKGV19pnnnCbrlW/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267688>

Make many textual tweaks to the 2.4.0 release notes.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/RelNotes/2.4.0.txt | 336 ++++++++++++++++++++-------------------
 1 file changed, 172 insertions(+), 164 deletions(-)

diff --git a/Documentation/RelNotes/2.4.0.txt b/Documentation/RelNotes/2.4.0.txt
index 7b23ca3..cde64be 100644
--- a/Documentation/RelNotes/2.4.0.txt
+++ b/Documentation/RelNotes/2.4.0.txt
@@ -6,19 +6,19 @@ Backward compatibility warning(s)
 
 This release has a few changes in the user-visible output from
 Porcelain commands. These are not meant to be parsed by scripts, but
-the users still may want to be aware of the changes:
+users still may want to be aware of the changes:
 
- * Output from "git log --decorate" (and "%d" format specifier used in
-   the userformat "--format=<string>" parameter "git log" family of
-   command takes) used to list "HEAD" just like other tips of branch
-   names, separated with a comma in between.  E.g.
+ * The output from "git log --decorate" (and, more generally, the "%d"
+   format specifier used in the "--format=<string>" parameter to the
+   "git log" family of commands) has changed. It used to list "HEAD"
+   just like other branches; e.g.,
 
      $ git log --decorate -1 master
      commit bdb0f6788fa5e3cacc4315e9ff318a27b2676ff4 (HEAD, master)
      ...
 
-   This release updates the output slightly when HEAD refers to the tip
-   of a branch whose name is also shown in the output.  The above is
+   This release changes the output slightly when HEAD refers to a
+   branch whose name is also shown in the output. The above is now
    shown as:
 
      $ git log --decorate -1 master
@@ -26,15 +26,15 @@ the users still may want to be aware of the changes:
      ...
 
  * The phrasing "git branch" uses to describe a detached HEAD has been
-   updated to match that of "git status":
+   updated to agree with the phrasing used by "git status":
 
-    - When the HEAD is at the same commit as it was originally
+    - When HEAD is at the same commit as when it was originally
       detached, they now both show "detached at <commit object name>".
 
-    - When the HEAD has moved since it was originally detached,
-      they now both show "detached from <commit object name>".
+    - When HEAD has moved since it was originally detached, they now
+      both show "detached from <commit object name>".
 
-    Earlier "git branch" always used "from"
+   Previously, "git branch" always used "from".
 
 
 Updates since v2.3
@@ -46,8 +46,9 @@ Ports
    platforms with smaller SSIZE_MAX, leading to read(2)/write(2)
    failures.
 
- * We did not check the curl library version before using
-   CURLOPT_PROXYAUTH feature that may not exist.
+ * We did not check the curl library version before using the
+   CURLOPT_PROXYAUTH feature, which did not exist in older versions of
+   the library.
 
  * We now detect number of CPUs on older BSD-derived systems.
 
@@ -66,99 +67,105 @@ UI, Workflows & Features
  * "git log --invert-grep --grep=WIP" will show only commits that do
    not have the string "WIP" in their messages.
 
- * "git push" has been taught a "--atomic" option that makes push to
-   update more than one ref an "all-or-none" affair.
+ * "git push" has been taught an "--atomic" option that makes a push
+   that updates more than one ref an "all-or-none" affair.
 
- * Extending the "push to deploy" added in 2.3, the behaviour of "git
-   push" when updating the branch that is checked out can now be
-   tweaked by push-to-checkout hook.
+ * Extending the "push to deploy" feature that was added in 2.3, the
+   behaviour of "git push" when updating the branch that is checked
+   out can now be tweaked by a "push-to-checkout" hook.
 
- * Using environment variable LANGUAGE and friends on the client side,
-   HTTP-based transports now send Accept-Language when making requests.
+ * HTTP-based transports now send Accept-Language when making
+   requests. The languages to accept are inferred from environment
+   variables on the client side (LANGUAGE, etc).
 
  * "git send-email" used to accept a mistaken "y" (or "yes") as an
-   answer to "What encoding do you want to use [UTF-8]? " without
-   questioning.  Now it asks for confirmation when the answer looks
-   too short to be a valid encoding name.
+   answer to "What encoding do you want to use [UTF-8]?" without
+   questioning. Now it asks for confirmation when the answer looks too
+   short to be a valid encoding name.
 
  * When "git apply --whitespace=fix" fixed whitespace errors in the
    common context lines, the command reports that it did so.
 
- * "git status" now allows the "-v" to be given twice to show the
-   differences that are left in the working tree not to be committed.
+ * "git status" now allows the "-v" option to be given twice, in which
+   case it also shows the differences in the working tree that are not
+   staged to be committed.
 
- * "git cherry-pick" used to clean-up the log message even when it is
-   merely replaying an existing commit.  It now replays the message
-   verbatim unless you are editing the message of resulting commits.
+ * "git cherry-pick" used to clean up the log message even when it is
+   merely replaying an existing commit. It now replays the message
+   verbatim unless you are editing the message of the resulting
+   commit.
 
  * "git archive" can now be told to set the 'text' attribute in the
    resulting zip archive.
 
- * Output from "git log --decorate" mentions HEAD when it points at a
-   tip of an branch differently from a detached HEAD.
+ * Output from "git log --decorate" now distinguishes between a
+   detached HEAD vs. a HEAD that points at a branch.
 
-   This is a potentially backward-incompatible change.
+   This is a potentially backward-incompatible change; see above for
+   more information.
 
- * "git branch" on a detached HEAD always said "(detached from xyz)",
-   even when "git status" would report "detached at xyz".  The HEAD is
-   actually at xyz and haven't been moved since it was detached in
-   such a case, but the user cannot read what the current value of
-   HEAD is when "detached from" is used.
+ * When HEAD was detached when at commit xyz and hasn't been moved
+   since it was detached, "git status" would report "detached at xyz"
+   whereas "git branch" would report "detached from xyz". Now the
+   output of "git branch" agrees with that of "git status".
 
- * "git -C '' subcmd" refused to work in the current directory, unlike
-   "cd ''" which silently behaves as a no-op.
+   This is a potentially backward-incompatible change; see above for
+   more information.
+
+ * "git -C '' subcmd" now works in the current directory (analogously
+   to "cd ''") rather than dying with an error message.
    (merge 6a536e2 kn/git-cd-to-empty later to maint).
 
  * The versionsort.prereleaseSuffix configuration variable can be used
-   to specify that v1.0-pre1 comes before v1.0.
+   to specify that, for example, v1.0-pre1 comes before v1.0.
 
  * A new "push.followTags" configuration turns the "--follow-tags"
    option on by default for the "git push" command.
 
- * "git log --graph --no-walk A B..." is a conflicting request that
-   asks nonsense; no-walk tells us show discrete points in the
-   history, while graph asks to draw connections between these
-   discrete points. Forbid the combination.
+ * "git log --graph --no-walk A B..." is a nonsensical combination of
+   options: "--no-walk" requests discrete points in the history, while
+   "--graph" asks to draw connections between these discrete points.
+   Forbid the use of these options together.
 
  * "git rev-list --bisect --first-parent" does not work (yet) and can
-   even cause SEGV; forbid it.  "git log --bisect --first-parent"
-   would not be useful until "git bisect --first-parent" materializes,
-   so it is also forbidden for now.
+   even cause SEGV; forbid it. "git log --bisect --first-parent" would
+   not be useful until "git bisect --first-parent" materializes, so
+   also forbid it for now.
 
 
 Performance, Internal Implementation, Development Support etc.
 
- * Implementation of N_() macro has been updated slightly to help us
+ * Slightly change the implementation of the N_() macro to help us
    detect mistakes.
 
- * Implementation of "reflog expire" has been restructured to fit the
-   reflogs better with the recently updated ref API.
+ * Restructure the implementation of "reflog expire" to fit better
+   with the recently updated reference API.
 
- * The transport-helper did not give transport options such as
+ * The transport-helper did not pass transport options such as
    verbosity, progress, cloning, etc. to import and export based
    helpers, like it did for fetch and push based helpers, robbing them
-   the chance to honor the wish of the end-users better.
-
- * The tests that wanted to see that file becomes unreadable after
-   running "chmod a-r file", and the tests that wanted to make sure it
-   is not run as root, we used "can we write into the / directory?" as
-   a cheap substitute, but on some platforms that is not a good
-   heuristics.  The tests and their prerequisites have been updated to
-   check what they really require.
+   of the chance to honor the wish of the end-users better.
+
+ * The tests that wanted to see that a file becomes unreadable after
+   running "chmod a-r file", and the tests that wanted to make sure
+   that they are not run as root, used "can we write into the /
+   directory?" as a cheap substitute. But on some platforms that is
+   not a good heuristic. The tests and their prerequisites have been
+   updated to check what they really require.
    (merge f400e51 jk/sanity later to maint).
 
  * Various issues around "reflog expire", e.g. using --updateref when
    expiring a reflog for a symbolic reference, have been corrected
    and/or made saner.
 
- * The strbuf API was explained between the API documentation and in
-   the header file.  Move missing bits to strbuf.h so that programmers
-   can check only one place for all necessary information.
+ * The documentation for the strbuf API had been split between the API
+   documentation and the header file. Consolidate the documentation in
+   strbuf.h.
 
  * The error handling functions and conventions are now documented in
-   the API manual.
+   the API manual (in api-error-handling.txt).
 
- * Optimize attribute look-up, mostly useful in "git grep" on a
+ * Optimize gitattribute look-up, mostly useful in "git grep" on a
    project that does not use many attributes, by avoiding it when we
    (should) know that the attributes are not defined in the first
    place.
@@ -170,26 +177,25 @@ Performance, Internal Implementation, Development Support etc.
    (merge 0b868f0 sb/hex-object-name-is-at-most-41-bytes-long later to maint).
    (merge 5d30851 dp/remove-duplicated-header-inclusion later to maint).
 
- * Simplify the ref transaction API around how "the ref should be
-   pointing at this object" is specified.
+ * Simplify the ref transaction API for verifying that "the ref should
+   be pointing at this object".
 
- * Code in "git daemon" to parse out and hold hostnames used in
-   request interpolation has been simplified.
+ * Simplify the code in "git daemon" that parses out and holds
+   hostnames used in request interpolation.
 
- * "git push" codepath has been restructured to make it easier to add
-   new configuration bits.
+ * Restructure the "git push" codepath to make it easier to add new
+   configuration bits.
 
- * The run-command interface was easy to abuse and make a pipe for us
-   to read from the process, wait for the process to finish and then
-   attempt to read its output, which is a pattern that lead to a
-   deadlock.  Fix such uses by introducing a helper to do this
-   correctly (i.e. we need to read first and then wait the process to
-   finish) and also add code to prevent such abuse in the run-command
-   helper.
+ * The run-command interface made it easy to make a pipe for us to
+   read from a process, wait for the process to finish, and then
+   attempt to read its output. But this pattern can lead to deadlock.
+   So introduce a helper to do this correctly (i.e., first read, and
+   then wait the process to finish) and also add code to prevent such
+   abuse in the run-command helper.
 
  * People often forget to chain the commands in their test together
-   with &&, leaving a failure from an earlier command in the test go
-   unnoticed.  The new GIT_TEST_CHAIN_LINT mechanism allows you to
+   with &&, letting a failure from an earlier command in the test go
+   unnoticed. The new GIT_TEST_CHAIN_LINT mechanism allows you to
    catch such a mistake more easily.
 
 
@@ -208,33 +214,34 @@ notes for details).
    (merge a46442f jk/blame-commit-label later to maint).
 
  * "git rerere" (invoked internally from many mergy operations) did
-   not correctly signal errors when told to update the working tree
-   files and failed to do so for whatever reason.
+   not correctly signal errors when it attempted to update the working
+   tree files but failed for whatever reason.
    (merge 89ea903 jn/rerere-fail-on-auto-update-failure later to maint).
 
  * Setting diff.submodule to 'log' made "git format-patch" produce
    broken patches.
    (merge 339de50 dk/format-patch-ignore-diff-submodule later to maint).
 
- * After attempting and failing a password-less authentication
-   (e.g. Kerberos), libcURL refuses to fall back to password based
-   Basic authentication without a bit of help/encouragement.
+ * After attempting and failing a password-less authentication (e.g.,
+   Kerberos), libcURL refuses to fall back to password-based Basic
+   authentication without a bit of help/encouragement.
    (merge 4dbe664 bc/http-fallback-to-password-after-krb-fails later to maint).
 
- * The "git push" documentation made the "--repo=<there>" option
+ * The "git push" documentation for the "--repo=<there>" option was
    easily misunderstood.
    (merge 57b92a7 mg/push-repo-option-doc later to maint).
 
- * Code to read branch name from various files in .git/ directory
-   would have misbehaved if the code to write them left an empty file.
+ * Code to read a branch name from various files in the .git/
+   directory would have overrun array limits if asked to read an empty
+   file.
    (merge 66ec904 jk/status-read-branch-name-fix later to maint).
 
- * A misspelled conditional that is always true has been fixed.
+ * Remove a superfluous conditional that is always true.
    (merge 94ee8e2 jk/remote-curl-an-array-in-struct-cannot-be-null later to maint).
 
- * The documentation incorrectly said that C(opy) and R(ename) are the
-   only ones that can be followed by the score number in the output in
-   the --raw format.
+ * The "git diff --raw" documentation incorrectly implied that C(opy)
+   and R(ename) are the only statuses that can be followed by a score
+   number.
    (merge ac1c2d9 jc/diff-format-doc later to maint).
 
  * A broken pack .idx file in the receiving repository prevented the
@@ -251,44 +258,44 @@ notes for details).
    to the "log" command.
    (merge 3cab02d jc/doc-log-rev-list-options later to maint).
 
- * "git apply --whitespace=fix" used to under-allocate the memory when
-   the fix resulted in a longer text than the original patch.
+ * "git apply --whitespace=fix" used to under-allocate memory when the
+   fix resulted in a longer text than the original patch.
    (merge 407a792 jc/apply-ws-fix-expands later to maint).
 
  * The interactive "show a list and let the user choose from it"
-   interface "add -i" used showed and prompted to the user even when
-   the candidate list was empty, against which the only "choice" the
-   user could have made was to choose nothing.
+   interface used by "git add -i" unnecessarily prompted the user even
+   when the candidate list was empty, against which the only "choice"
+   the user could have made was to choose nothing.
    (merge a9c4641 ak/add-i-empty-candidates later to maint).
 
- * The todo list "git rebase -i" creates did not fully honor
+ * The todo list created by "git rebase -i" did not fully honor
    core.abbrev settings.
    (merge edb72d5 ks/rebase-i-abbrev later to maint).
 
- * "git fetch" over a remote-helper that cannot respond to "list"
-   command could not fetch from a symbolic reference e.g. HEAD.
+ * "git fetch" over a remote-helper that cannot respond to the "list"
+   command could not fetch from a symbolic reference (e.g., HEAD).
    (merge 33cae54 mh/deref-symref-over-helper-transport later to maint).
 
  * "git push --signed" gave an incorrectly worded error message when
    the other side did not support the capability.
 
  * The "git push --signed" protocol extension did not limit what the
-   "nonce" that is a server-chosen string can contain or how long it
-   can be, which was unnecessarily lax.  Limit both the length and the
-   alphabet to a reasonably small space that can still have enough
+   "nonce" (a server-chosen string) could contain nor how long it
+   could be, which was unnecessarily lax. Limit both the length and
+   the alphabet to a reasonably small space that can still have enough
    entropy.
    (merge afcb6ee jc/push-cert later to maint).
 
- * The completion script (in contrib/) contaminated global namespace
-   and clobbered on a shell variable $x.
+ * The completion script (in contrib/) clobbered the shell variable $x
+   in the global shell namespace.
    (merge 852ff1c ma/bash-completion-leaking-x later to maint).
 
- * We didn't format an integer that wouldn't fit in "int" but in
-   "uintmax_t" correctly.
+ * We incorrectly formatted a "uintmax_t" integer that doesn't fit in
+   "int".
    (merge d306f3d jk/decimal-width-for-uintmax later to maint).
 
- * Reading configuration from a blob object, when it ends with a lone
-   CR, use to confuse the configuration parser.
+ * The configuration parser used to be confused when reading
+   configuration from a blob object that ends with a lone CR.
    (merge 1d0655c jk/config-no-ungetc-eof later to maint).
 
  * The pack bitmap support did not build with older versions of GCC.
@@ -304,21 +311,21 @@ notes for details).
    (merge 1f985d6 ch/new-gpg-drops-rfc-1991 later to maint).
 
  * The credential helper for Windows (in contrib/) used to mishandle
-   a user name with an at-sign in it.
+   user names that contain an at-sign.
    (merge 13d261e av/wincred-with-at-in-username-fix later to maint).
 
  * "diff-highlight" (in contrib/) used to show byte-by-byte
-   differences, which meant that multi-byte characters can be chopped
-   in the middle.  It learned to pay attention to character boundaries
-   (assuming the UTF-8 payload).
+   differences, which could cause multi-byte characters to be chopped
+   in the middle. It learned to pay attention to character boundaries
+   (assuming UTF-8).
    (merge 8d00662 jk/colors later to maint).
 
- * Longstanding configuration variable naming rules has been added to
-   the documentation.
+ * Document longstanding configuration variable naming rules in
+   CodingGuidelines.
    (merge 35840a3 jc/conf-var-doc later to maint).
 
  * An earlier workaround to squelch unhelpful deprecation warnings
-   from the compiler on Mac OSX unnecessarily set minimum required
+   from the compiler on OS X unnecessarily set a minimum required
    version of the OS, which the user might want to raise (or lower)
    for other reasons.
    (merge 88c03eb es/squelch-openssl-warnings-on-macosx later to maint).
@@ -335,33 +342,36 @@ notes for details).
    "path/to/submodule".
    (merge 8196e72 ps/submodule-sanitize-path-upon-add later to maint).
 
- * "git merge-file" did not work correctly in a subdirectory.
+ * "git merge-file" did not work correctly when invoked in a
+   subdirectory.
    (merge 204a8ff ab/merge-file-prefix later to maint).
 
- * "git blame" died, trying to free an uninitialized piece of memory.
+ * "git blame" could die trying to free an uninitialized piece of
+   memory.
    (merge e600592 es/blame-commit-info-fix later to maint).
 
  * "git fast-import" used to crash when it could not close and
-   conclude the resulting packfile cleanly.
+   finalize the resulting packfile cleanly.
    (merge 5e915f3 jk/fast-import-die-nicely-fix later to maint).
 
- * "update-index --refresh" used to leak when an entry cannot be
-   refreshed for whatever reason.
+ * "update-index --refresh" used to leak memory when an entry could
+   not be refreshed for whatever reason.
    (merge bc1c2ca sb/plug-leak-in-make-cache-entry later to maint).
 
  * The "interpolated-path" option of "git daemon" inserted any string
-   client declared on the "host=" capability request without checking.
-   Sanitize and limit %H and %CH to a saner and a valid DNS name.
+   the client declared on the "host=" capability request without
+   checking. Sanitize and limit %H and %CH to a saner and a valid DNS
+   name.
    (merge b485373 jk/daemon-interpolate later to maint).
 
- * "git daemon" looked up the hostname even when "%CH" and "%IP"
-   interpolations are not requested, which was unnecessary.
+ * "git daemon" unnecessarily looked up the hostname even when "%CH"
+   and "%IP" interpolations were not requested.
    (merge dc8edc8 rs/daemon-interpolate later to maint).
 
- * Even though we officially haven't dropped Perl 5.8 support, the
-   Getopt::Long package that came with it does not support "--no-"
-   prefix to negate a boolean option; manually add support to help
-   people with older Getopt::Long package.
+ * We relied on "--no-" prefix handling in Perl's Getopt::Long
+   package, even though that support didn't exist in Perl 5.8 (which
+   we still support). Manually add support to help people with older
+   Getopt::Long packages.
    (merge f471494 km/send-email-getopt-long-workarounds later to maint).
 
  * "git apply" was not very careful about reading from, removing,
@@ -370,13 +380,13 @@ notes for details).
    replacement for GNU patch).
    (merge e0d201b jc/apply-beyond-symlink later to maint).
 
- * A breakage to git-svn around v2.2 era that triggers premature
-   closing of FileHandle has been corrected.
+ * Correct a breakage in git-svn, introduced around the v2.2 era, that
+   can cause FileHandles to be closed prematurely.
    (merge e426311 ew/svn-maint-fixes later to maint).
 
- * We did not parse username followed by literal IPv6 address in SSH
-   transport URLs, e.g. ssh://user@[2001:db8::1]:22/repo.git
-   correctly.
+ * We did not parse usernames followed by literal IPv6 addresses
+   correctly in SSH transport URLs; e.g.,
+   ssh://user@[2001:db8::1]:22/repo.git.
    (merge 6b6c5f7 tb/connect-ipv6-parse-fix later to maint).
 
  * The configuration variable 'mailinfo.scissors' was hard to
@@ -387,28 +397,26 @@ notes for details).
    submodule.*.update configuration was not clearly documented.
    (merge 5c31acf ms/submodule-update-config-doc later to maint).
 
- * "git diff --shortstat --dirstat=changes" showed a dirstat based on
-   lines that was never asked by the end user in addition to the
-   dirstat that the user asked for.
+ * "git diff --shortstat" used together with "--dirstat=changes" or
+   "--dirstat=files" incorrectly output dirstat information twice.
    (merge ab27389 mk/diff-shortstat-dirstat-fix later to maint).
 
- * "git remote add" mentioned "--tags" and "--no-tags" and was not
-   clear that fetch from the remote in the future will use the default
-   behaviour when neither is given to override it.
+ * The manpage for "git remote add" mentioned "--tags" and "--no-tags"
+   but did not explain what happens if neither option is provided.
    (merge aaba0ab mg/doc-remote-tags-or-not later to maint).
 
- * Description given by "grep -h" for its --exclude-standard option
-   was phrased poorly.
+ * The description of "--exclude-standard option" in the output of
+   "git grep -h" was phrased poorly.
    (merge 77fdb8a nd/grep-exclude-standard-help-fix later to maint).
 
- * "git rebase -i" recently started to include the number of
-   commits in the todo list to be processed, but on a platform
-   that prepends leading whitespaces to "wc -l" output, the numbers
-   are shown with extra whitespaces that aren't necessary.
+ * "git rebase -i" recently started to include the number of commits
+   in the todo list, but that output included extraneous whitespace on
+   a platform that prepends leading whitespaces to its "wc -l" output.
    (merge 2185d3b es/rebase-i-count-todo later to maint).
 
- * The borrowed code in kwset API did not follow our usual convention
-   to use "unsigned char" to store values that range from 0-255.
+ * The borrowed code in the kwset API did not follow our usual
+   convention to use "unsigned char" to store values that range from
+   0-255.
    (merge 189c860 bw/kwset-use-unsigned later to maint).
 
  * A corrupt input to "git diff -M" used to cause it to segfault.
@@ -418,9 +426,8 @@ notes for details).
    (merge 3f88c1b mg/verify-commit later to maint).
 
  * "git imap-send" learned to optionally talk with an IMAP server via
-   libcURL; because there is no other option when Git is built with
-   NO_OPENSSL option, use that codepath by default under such
-   configuration.
+   libcURL. Because there is no other option when Git is built with
+   the NO_OPENSSL option, use libcURL by default in that case.
    (merge dcd01ea km/imap-send-libcurl-options later to maint).
 
  * "git log --decorate" did not reset colors correctly around the
@@ -436,44 +443,45 @@ notes for details).
    transport.
    (merge 8ddf3ca jk/smart-http-hide-refs later to maint).
 
- * "git tag -h" used to show the "--column" and "--sort" options
-   that are about listing in a wrong section.
+ * In the "git tag -h" output, move the documentation for the
+   "--column" and "--sort" options to the "Tag listing options"
+   section.
    (merge dd059c6 jk/tag-h-column-is-a-listing-option later to maint).
 
  * "git prune" used to largely ignore broken refs when deciding which
-   objects are still being used, which could spread an existing small
-   damage and make it a larger one.
+   objects are still being used, which could cause reference
+   corruption to lead to object loss.
    (merge ea56c4e jk/prune-with-corrupt-refs later to maint).
 
- * The split-index mode introduced at v2.3.0-rc0~41 was broken in the
+ * The split-index mode introduced in v2.3.0-rc0~41 was broken in the
    codepath to protect us against a broken reimplementation of Git
    that writes an invalid index with duplicated index entries, etc.
    (merge 03f15a7 tg/fix-check-order-with-split-index later to maint).
 
- * "git fetch" that fetches a commit using the allow-tip-sha1-in-want
-   extension could have failed to fetch all the requested refs.
+ * "git fetch", when fetching a commit using the
+   allow-tip-sha1-in-want extension, could have failed to fetch all of
+   the requested refs.
    (merge 32d0462 jk/fetch-pack later to maint).
 
  * An failure early in the "git clone" that started creating the
-   working tree and repository could have resulted in some directories
-   and files left without getting cleaned up.
+   working tree and repository could have resulted in the failure to
+   clean up some directories and files.
    (merge 16eff6c jk/cleanup-failed-clone later to maint).
 
  * Recommend format-patch and send-email for those who want to submit
    patches to this project.
    (merge b25c469 jc/submitting-patches-mention-send-email later to maint).
 
- * Even though "git grep --quiet" is run merely to ask for the exit
-   status, we spawned the pager regardless.  Stop doing that.
+ * Do not spawn the pager when "git grep" is run with "--quiet".
    (merge c2048f0 ws/grep-quiet-no-pager later to maint).
 
  * The prompt script (in contrib/) did not show the untracked sign
    when working in a subdirectory without any untracked files.
    (merge 9bdc517 ct/prompt-untracked-fix later to maint).
 
- * An earlier update to the parser that disects a URL broke an
-   address, followed by a colon, followed by an empty string (instead
-   of the port number), e.g. ssh://example.com:/path/to/repo.
+ * An earlier update to the URL parser broke an address that contains
+   a colon but an empty string for the port number, like
+   ssh://example.com:/path/to/repo.
    (merge 6b6c5f7 tb/connect-ipv6-parse-fix later to maint).
 
  * Code cleanups and documentation updates.
-- 
2.1.4
