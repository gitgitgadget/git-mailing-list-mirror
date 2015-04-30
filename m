From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.4.0
Date: Thu, 30 Apr 2015 12:51:08 -0700
Message-ID: <xmqq7fstz977.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Thu Apr 30 21:51:25 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YnuUW-0005fE-3W
	for glk-linux-kernel-3@plane.gmane.org; Thu, 30 Apr 2015 21:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbbD3TvQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 30 Apr 2015 15:51:16 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55576 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752095AbbD3TvL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Apr 2015 15:51:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CD48A4DF72;
	Thu, 30 Apr 2015 15:51:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=iq297QQncKBxT7S3ML4KT1f4n
	E4=; b=fyV1df/VJDl3pZJs1lleHvePn8oorUlzOur56QcRF9GBGBoPr+sGJGvPO
	6TJVdyaNq23p6kaao6CP5LHxpc9PLzIblmPx1D8w9PtHq1PnV7MdW4rRy1umM5kT
	CZ/sT8whAfcWpKUTT9SgJ1S4jrFM0H/osva+v0Fec4eo4D4gOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=AeWKnJvWYtm/xfkapKx
	7YJK169xBunRl2AVNid+ICYUqYmqT84wifM5McOm5j8D1bKSRu2kbsW++tVsIh+N
	T0KjN7GpSLTC0RTA8FktLJFrZ32knXX7LRAJuxXGW8D+qRBu9t7IW+VTlDie745w
	wOoP3H7IUS7+xk6/mGe5ulNY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C245C4DF71;
	Thu, 30 Apr 2015 15:51:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E315C4DF70;
	Thu, 30 Apr 2015 15:51:09 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3F8D00AE-EF72-11E4-A058-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268098>

The latest feature release Git v2.4.0 is now available at the
usual places.  It is comprised of 426 non-merge commits since
v2.3.0, contributed by 76 people, 25 of which are new faces.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.4.0'
tag and the 'master' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.3.0 are as follows.
Welcome to the Git development community!

  Aleksander Boruch-Gruszecki, Aleksey Vasenev, Christoph Junghans,
  Cody A Taylor, Csaba Kiraly, Dimitriy Ryazantcev, Dongcan Jiang,
  Doug Kelly, Gabriele Mazzotta, Henri GEIST, Ivan Ukhov, J=C3=A9r=C3=B4=
me
  Zago, Julian Gindi, Karthik Nayak, Kevin Daudt, M=C3=A1rcio Almada,
  Matthias R=C3=BCster, Michael Lutz, Mikko Rapeli, Patrick Steinhardt,
  Paul Tan, Remi Rampin, Ryuichi Kokubo, Tom G. Christensen,
  and Wilhelm Schuermann.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Alexander Kuleshov, Alexander Shopov, Alex Henrie, Anders
  Kaseorg, Ben Walton, brian m. carlson, Chris Packham, Dave
  Olszewski, David Turner, Eric Sunshine, Eric Wong, Jean-Noel
  Avila, Jeff King, Jiang Xin, Johannes Sixt, John Keeping,
  John Szakmeister, Jonathan Nieder, Jonathon Mah, Junio C
  Hamano, Kirill A. Shutemov, Kyle J. McKay, Lukas Fleischer,
  Luke Diamand, M=C3=A5rten Kongstad, Matthieu Moy, Max Kirillov,
  Michael Haggerty, Michael J Gruber, Michal Sojka, Mike Hommey,
  Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy, Pat Thoyts, Paul Mackerras=
, Peter
  Krefting, Phil Hord, Phillip Sz, Ralf Thielow, Ramsay Allan
  Jones, Ren=C3=A9 Scharfe, Ronnie Sahlberg, Sebastian Schuberth,
  Stefan Beller, SZEDER G=C3=A1bor, Thomas Ackermann, Thomas Gummerer,
  Torsten B=C3=B6gershausen, Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n, Vitor=
 Antunes,
  Yi EungJun, and =D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=D0=BB=D0=B0=
=D1=83=D0=B7=D0=BE=D0=B2.

----------------------------------------------------------------

Git 2.4 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Backward compatibility warning(s)
---------------------------------

This release has a few changes in the user-visible output from
Porcelain commands. These are not meant to be parsed by scripts, but
users still may want to be aware of the changes:

 * The output from "git log --decorate" (and, more generally, the "%d"
   format specifier used in the "--format=3D<string>" parameter to the
   "git log" family of commands) has changed. It used to list "HEAD"
   just like other branches; e.g.,

     $ git log --decorate -1 master
     commit bdb0f6788fa5e3cacc4315e9ff318a27b2676ff4 (HEAD, master)
     ...

   This release changes the output slightly when HEAD refers to a
   branch whose name is also shown in the output. The above is now
   shown as:

     $ git log --decorate -1 master
     commit bdb0f6788fa5e3cacc4315e9ff318a27b2676ff4 (HEAD -> master)
     ...

 * The phrasing "git branch" uses to describe a detached HEAD has been
   updated to agree with the phrasing used by "git status":

    - When HEAD is at the same commit as when it was originally
      detached, they now both show "detached at <commit object name>".

    - When HEAD has moved since it was originally detached, they now
      both show "detached from <commit object name>".

   Previously, "git branch" always used "from".


Updates since v2.3
------------------

Ports

 * Our default I/O size (8 MiB) for large files was too large for some
   platforms with smaller SSIZE_MAX, leading to read(2)/write(2)
   failures.

 * We did not check the curl library version before using the
   CURLOPT_PROXYAUTH feature, which did not exist in older versions of
   the library.

 * We now detect number of CPUs on older BSD-derived systems.

 * Portability fixes and workarounds for shell scripts have been added
   to help BSD-derived systems.


UI, Workflows & Features

 * The command usage info strings given by "git cmd -h" and in
   documentation have been tweaked for consistency.

 * The "sync" subcommand of "git p4" now allows users to exclude
   subdirectories like its "clone" subcommand does.

 * "git log --invert-grep --grep=3DWIP" will show only commits that do
   not have the string "WIP" in their messages.

 * "git push" has been taught an "--atomic" option that makes a push
   that updates more than one ref an "all-or-none" affair.

 * Extending the "push to deploy" feature that was added in 2.3, the
   behaviour of "git push" when updating the branch that is checked
   out can now be tweaked by a "push-to-checkout" hook.

 * HTTP-based transports now send Accept-Language when making
   requests. The languages to accept are inferred from environment
   variables on the client side (LANGUAGE, etc).

 * "git send-email" used to accept a mistaken "y" (or "yes") as an
   answer to "What encoding do you want to use [UTF-8]?" without
   questioning. Now it asks for confirmation when the answer looks too
   short to be a valid encoding name.

 * When "git apply --whitespace=3Dfix" fixed whitespace errors in the
   common context lines, the command reports that it did so.

 * "git status" now allows the "-v" option to be given twice, in which
   case it also shows the differences in the working tree that are not
   staged to be committed.

 * "git cherry-pick" used to clean up the log message even when it is
   merely replaying an existing commit. It now replays the message
   verbatim unless you are editing the message of the resulting
   commit.

 * "git archive" can now be told to set the 'text' attribute in the
   resulting zip archive.

 * Output from "git log --decorate" now distinguishes between a
   detached HEAD vs. a HEAD that points at a branch.

   This is a potentially backward-incompatible change; see above for
   more information.

 * When HEAD was detached when at commit xyz and hasn't been moved
   since it was detached, "git status" would report "detached at xyz"
   whereas "git branch" would report "detached from xyz". Now the
   output of "git branch" agrees with that of "git status".

   This is a potentially backward-incompatible change; see above for
   more information.

 * "git -C '' subcmd" now works in the current directory (analogously
   to "cd ''") rather than dying with an error message.
   (merge 6a536e2 kn/git-cd-to-empty later to maint).

 * The versionsort.prereleaseSuffix configuration variable can be used
   to specify that, for example, v1.0-pre1 comes before v1.0.

 * A new "push.followTags" configuration turns the "--follow-tags"
   option on by default for the "git push" command.

 * "git log --graph --no-walk A B..." is a nonsensical combination of
   options: "--no-walk" requests discrete points in the history, while
   "--graph" asks to draw connections between these discrete points.
   Forbid the use of these options together.

 * "git rev-list --bisect --first-parent" does not work (yet) and can
   even cause SEGV; forbid it. "git log --bisect --first-parent" would
   not be useful until "git bisect --first-parent" materializes, so
   also forbid it for now.


Performance, Internal Implementation, Development Support etc.

 * Slightly change the implementation of the N_() macro to help us
   detect mistakes.

 * Restructure the implementation of "reflog expire" to fit better
   with the recently updated reference API.

 * The transport-helper did not pass transport options such as
   verbosity, progress, cloning, etc. to import and export based
   helpers, like it did for fetch and push based helpers, robbing them
   of the chance to honor the wish of the end-users better.

 * The tests that wanted to see that a file becomes unreadable after
   running "chmod a-r file", and the tests that wanted to make sure
   that they are not run as root, used "can we write into the /
   directory?" as a cheap substitute. But on some platforms that is
   not a good heuristic. The tests and their prerequisites have been
   updated to check what they really require.
   (merge f400e51 jk/sanity later to maint).

 * Various issues around "reflog expire", e.g. using --updateref when
   expiring a reflog for a symbolic reference, have been corrected
   and/or made saner.

 * The documentation for the strbuf API had been split between the API
   documentation and the header file. Consolidate the documentation in
   strbuf.h.

 * The error handling functions and conventions are now documented in
   the API manual (in api-error-handling.txt).

 * Optimize gitattribute look-up, mostly useful in "git grep" on a
   project that does not use many attributes, by avoiding it when we
   (should) know that the attributes are not defined in the first
   place.

 * Typofix in comments.
   (merge ef2956a ak/git-pm-typofix later to maint).

 * Code clean-up.
   (merge 0b868f0 sb/hex-object-name-is-at-most-41-bytes-long later to =
maint).
   (merge 5d30851 dp/remove-duplicated-header-inclusion later to maint)=
=2E

 * Simplify the ref transaction API for verifying that "the ref should
   be pointing at this object".

 * Simplify the code in "git daemon" that parses out and holds
   hostnames used in request interpolation.

 * Restructure the "git push" codepath to make it easier to add new
   configuration bits.

 * The run-command interface made it easy to make a pipe for us to
   read from a process, wait for the process to finish, and then
   attempt to read its output. But this pattern can lead to deadlock.
   So introduce a helper to do this correctly (i.e., first read, and
   then wait the process to finish) and also add code to prevent such
   abuse in the run-command helper.

 * People often forget to chain the commands in their test together
   with &&, letting a failure from an earlier command in the test go
   unnoticed. The new GIT_TEST_CHAIN_LINT mechanism allows you to
   catch such a mistake more easily.


Also contains various documentation updates and code clean-ups.


=46ixes since v2.3
----------------

Unless otherwise noted, all the fixes since v2.3 in the maintenance
track are contained in this release (see the maintenance releases'
notes for details).

 * "git blame HEAD -- missing" failed to correctly say "HEAD" when it
   tried to say "No such path 'missing' in HEAD".
   (merge a46442f jk/blame-commit-label later to maint).

 * "git rerere" (invoked internally from many mergy operations) did
   not correctly signal errors when it attempted to update the working
   tree files but failed for whatever reason.
   (merge 89ea903 jn/rerere-fail-on-auto-update-failure later to maint)=
=2E

 * Setting diff.submodule to 'log' made "git format-patch" produce
   broken patches.
   (merge 339de50 dk/format-patch-ignore-diff-submodule later to maint)=
=2E

 * After attempting and failing a password-less authentication (e.g.,
   Kerberos), libcURL refuses to fall back to password-based Basic
   authentication without a bit of help/encouragement.
   (merge 4dbe664 bc/http-fallback-to-password-after-krb-fails later to=
 maint).

 * The "git push" documentation for the "--repo=3D<there>" option was
   easily misunderstood.
   (merge 57b92a7 mg/push-repo-option-doc later to maint).

 * Code to read a branch name from various files in the .git/
   directory would have overrun array limits if asked to read an empty
   file.
   (merge 66ec904 jk/status-read-branch-name-fix later to maint).

 * Remove a superfluous conditional that is always true.
   (merge 94ee8e2 jk/remote-curl-an-array-in-struct-cannot-be-null late=
r to maint).

 * The "git diff --raw" documentation incorrectly implied that C(opy)
   and R(ename) are the only statuses that can be followed by a score
   number.
   (merge ac1c2d9 jc/diff-format-doc later to maint).

 * A broken pack .idx file in the receiving repository prevented the
   dumb http transport from fetching a good copy of it from the other
   side.
   (merge 8b9c2dd jk/dumb-http-idx-fetch-fix later to maint).

 * The error message from "git commit", when a non-existing author
   name was given as value to the "--author=3D" parameter, has been
   reworded to avoid misunderstanding.
   (merge 1044b1f mg/commit-author-no-match-malformed-message later to =
maint).

 * "git log --help" used to show rev-list options that are irrelevant
   to the "log" command.
   (merge 3cab02d jc/doc-log-rev-list-options later to maint).

 * "git apply --whitespace=3Dfix" used to under-allocate memory when th=
e
   fix resulted in a longer text than the original patch.
   (merge 407a792 jc/apply-ws-fix-expands later to maint).

 * The interactive "show a list and let the user choose from it"
   interface used by "git add -i" unnecessarily prompted the user even
   when the candidate list was empty, against which the only "choice"
   the user could have made was to choose nothing.
   (merge a9c4641 ak/add-i-empty-candidates later to maint).

 * The todo list created by "git rebase -i" did not fully honor
   core.abbrev settings.
   (merge edb72d5 ks/rebase-i-abbrev later to maint).

 * "git fetch" over a remote-helper that cannot respond to the "list"
   command could not fetch from a symbolic reference (e.g., HEAD).
   (merge 33cae54 mh/deref-symref-over-helper-transport later to maint)=
=2E

 * "git push --signed" gave an incorrectly worded error message when
   the other side did not support the capability.

 * The "git push --signed" protocol extension did not limit what the
   "nonce" (a server-chosen string) could contain nor how long it
   could be, which was unnecessarily lax. Limit both the length and
   the alphabet to a reasonably small space that can still have enough
   entropy.
   (merge afcb6ee jc/push-cert later to maint).

 * The completion script (in contrib/) clobbered the shell variable $x
   in the global shell namespace.
   (merge 852ff1c ma/bash-completion-leaking-x later to maint).

 * We incorrectly formatted a "uintmax_t" integer that doesn't fit in
   "int".
   (merge d306f3d jk/decimal-width-for-uintmax later to maint).

 * The configuration parser used to be confused when reading
   configuration from a blob object that ends with a lone CR.
   (merge 1d0655c jk/config-no-ungetc-eof later to maint).

 * The pack bitmap support did not build with older versions of GCC.
   (merge bd4e882 jk/pack-bitmap later to maint).

 * The documentation wasn't clear that "remote.<nick>.pushURL" and
   "remote.<nick>.URL" are there to name the same repository accessed
   via different transports, not two separate repositories.
   (merge 697f652 jc/remote-set-url-doc later to maint).

 * Older GnuPG implementations may not correctly import the keyring
   material we prepare for the tests to use.
   (merge 1f985d6 ch/new-gpg-drops-rfc-1991 later to maint).

 * The credential helper for Windows (in contrib/) used to mishandle
   user names that contain an at-sign.
   (merge 13d261e av/wincred-with-at-in-username-fix later to maint).

 * "diff-highlight" (in contrib/) used to show byte-by-byte
   differences, which could cause multi-byte characters to be chopped
   in the middle. It learned to pay attention to character boundaries
   (assuming UTF-8).
   (merge 8d00662 jk/colors later to maint).

 * Document longstanding configuration variable naming rules in
   CodingGuidelines.
   (merge 35840a3 jc/conf-var-doc later to maint).

 * An earlier workaround to squelch unhelpful deprecation warnings
   from the compiler on OS X unnecessarily set a minimum required
   version of the OS, which the user might want to raise (or lower)
   for other reasons.
   (merge 88c03eb es/squelch-openssl-warnings-on-macosx later to maint)=
=2E

 * Certain older vintages of cURL give irregular output from
   "curl-config --vernum", which confused our build system.
   (merge 3af6792 tc/curl-vernum-output-broken-in-7.11 later to maint).

 * In v2.2.0, we broke "git prune" that runs in a repository that
   borrows from an alternate object store.
   (merge b0a4264 jk/prune-mtime later to maint).

 * "git submodule add" failed to squash "path/to/././submodule" to
   "path/to/submodule".
   (merge 8196e72 ps/submodule-sanitize-path-upon-add later to maint).

 * "git merge-file" did not work correctly when invoked in a
   subdirectory.
   (merge 204a8ff ab/merge-file-prefix later to maint).

 * "git blame" could die trying to free an uninitialized piece of
   memory.
   (merge e600592 es/blame-commit-info-fix later to maint).

 * "git fast-import" used to crash when it could not close and
   finalize the resulting packfile cleanly.
   (merge 5e915f3 jk/fast-import-die-nicely-fix later to maint).

 * "update-index --refresh" used to leak memory when an entry could
   not be refreshed for whatever reason.
   (merge bc1c2ca sb/plug-leak-in-make-cache-entry later to maint).

 * The "interpolated-path" option of "git daemon" inserted any string
   the client declared on the "host=3D" capability request without
   checking. Sanitize and limit %H and %CH to a saner and a valid DNS
   name.
   (merge b485373 jk/daemon-interpolate later to maint).

 * "git daemon" unnecessarily looked up the hostname even when "%CH"
   and "%IP" interpolations were not requested.
   (merge dc8edc8 rs/daemon-interpolate later to maint).

 * We relied on "--no-" prefix handling in Perl's Getopt::Long
   package, even though that support didn't exist in Perl 5.8 (which
   we still support). Manually add support to help people with older
   Getopt::Long packages.
   (merge f471494 km/send-email-getopt-long-workarounds later to maint)=
=2E

 * "git apply" was not very careful about reading from, removing,
   updating and creating paths outside the working tree (under
   --index/--cached) or the current directory (when used as a
   replacement for GNU patch).
   (merge e0d201b jc/apply-beyond-symlink later to maint).

 * Correct a breakage in git-svn, introduced around the v2.2 era, that
   can cause FileHandles to be closed prematurely.
   (merge e426311 ew/svn-maint-fixes later to maint).

 * We did not parse usernames followed by literal IPv6 addresses
   correctly in SSH transport URLs; e.g.,
   ssh://user@[2001:db8::1]:22/repo.git.
   (merge 6b6c5f7 tb/connect-ipv6-parse-fix later to maint).

 * The configuration variable 'mailinfo.scissors' was hard to
   discover in the documentation.
   (merge afb5de7 mm/am-c-doc later to maint).

 * The interaction between "git submodule update" and the
   submodule.*.update configuration was not clearly documented.
   (merge 5c31acf ms/submodule-update-config-doc later to maint).

 * "git diff --shortstat" used together with "--dirstat=3Dchanges" or
   "--dirstat=3Dfiles" incorrectly output dirstat information twice.
   (merge ab27389 mk/diff-shortstat-dirstat-fix later to maint).

 * The manpage for "git remote add" mentioned "--tags" and "--no-tags"
   but did not explain what happens if neither option is provided.
   (merge aaba0ab mg/doc-remote-tags-or-not later to maint).

 * The description of "--exclude-standard option" in the output of
   "git grep -h" was phrased poorly.
   (merge 77fdb8a nd/grep-exclude-standard-help-fix later to maint).

 * "git rebase -i" recently started to include the number of commits
   in the todo list, but that output included extraneous whitespace on
   a platform that prepends leading whitespaces to its "wc -l" output.
   (merge 2185d3b es/rebase-i-count-todo later to maint).

 * The borrowed code in the kwset API did not follow our usual
   convention to use "unsigned char" to store values that range from
   0-255.
   (merge 189c860 bw/kwset-use-unsigned later to maint).

 * A corrupt input to "git diff -M" used to cause it to segfault.
   (merge 4d6be03 jk/diffcore-rename-duplicate later to maint).

 * Certain builds of GPG triggered false breakages in a test.
   (merge 3f88c1b mg/verify-commit later to maint).

 * "git imap-send" learned to optionally talk with an IMAP server via
   libcURL. Because there is no other option when Git is built with
   the NO_OPENSSL option, use libcURL by default in that case.
   (merge dcd01ea km/imap-send-libcurl-options later to maint).

 * "git log --decorate" did not reset colors correctly around the
   branch names.
   (merge 5ee8758 jc/decorate-leaky-separator-color later to maint).

 * The code that reads from the ctags file in the completion script
   (in contrib/) did not spell ${param/pattern/string} substitution
   correctly, which happened to work with bash but not with zsh.
   (merge db8d750 js/completion-ctags-pattern-substitution-fix later to=
 maint).

 * The transfer.hiderefs support did not quite work for smart-http
   transport.
   (merge 8ddf3ca jk/smart-http-hide-refs later to maint).

 * In the "git tag -h" output, move the documentation for the
   "--column" and "--sort" options to the "Tag listing options"
   section.
   (merge dd059c6 jk/tag-h-column-is-a-listing-option later to maint).

 * "git prune" used to largely ignore broken refs when deciding which
   objects are still being used, which could cause reference
   corruption to lead to object loss.
   (merge ea56c4e jk/prune-with-corrupt-refs later to maint).

 * The split-index mode introduced in v2.3.0-rc0~41 was broken in the
   codepath to protect us against a broken reimplementation of Git
   that writes an invalid index with duplicated index entries, etc.
   (merge 03f15a7 tg/fix-check-order-with-split-index later to maint).

 * "git fetch", when fetching a commit using the
   allow-tip-sha1-in-want extension, could have failed to fetch all of
   the requested refs.
   (merge 32d0462 jk/fetch-pack later to maint).

 * An failure early in the "git clone" that started creating the
   working tree and repository could have resulted in the failure to
   clean up some directories and files.
   (merge 16eff6c jk/cleanup-failed-clone later to maint).

 * Recommend format-patch and send-email for those who want to submit
   patches to this project.
   (merge b25c469 jc/submitting-patches-mention-send-email later to mai=
nt).

 * Do not spawn the pager when "git grep" is run with "--quiet".
   (merge c2048f0 ws/grep-quiet-no-pager later to maint).

 * The prompt script (in contrib/) did not show the untracked sign
   when working in a subdirectory without any untracked files.
   (merge 9bdc517 ct/prompt-untracked-fix later to maint).

 * An earlier update to the URL parser broke an address that contains
   a colon but an empty string for the port number, like
   ssh://example.com:/path/to/repo.
   (merge 6b6c5f7 tb/connect-ipv6-parse-fix later to maint).

 * Code cleanups and documentation updates.
   (merge 2ce63e9 rs/simple-cleanups later to maint).
   (merge 33baa69 rj/no-xopen-source-for-cygwin later to maint).
   (merge 817d03e jc/diff-test-updates later to maint).
   (merge eb32c66 ak/t5516-typofix later to maint).
   (merge bcd57cb mr/doc-clean-f-f later to maint).
   (merge 0d6accc mg/doc-status-color-slot later to maint).
   (merge 53e53c7 sg/completion-remote later to maint).
   (merge 8fa7975 ak/git-done-help-cleanup later to maint).
   (merge 9a6f128 rs/deflate-init-cleanup later to maint).
   (merge 6f75d45 rs/use-isxdigit later to maint).
   (merge 376e4b3 jk/test-annoyances later to maint).
   (merge 7032054 nd/doc-git-index-version later to maint).
   (merge e869c5e tg/test-index-v4 later to maint).
   (merge 599d223 jk/simplify-csum-file-sha1fd-check later to maint).
   (merge 260d585 sg/completion-gitcomp-nl-for-refs later to maint).
   (merge 777c55a jc/report-path-error-to-dir later to maint).
   (merge fddfaf8 ph/push-doc-cas later to maint).
   (merge d50d31e ss/pull-rebase-preserve later to maint).
   (merge c8c3f1d pt/enter-repo-comment-fix later to maint).
   (merge d7bfb9e jz/gitweb-conf-doc-fix later to maint).
   (merge f907282 jk/cherry-pick-docfix later to maint).
   (merge d3c0811 iu/fix-parse-options-h-comment later to maint).
   (merge 6c3b2af jg/cguide-we-cannot-count later to maint).
   (merge 2b8bd44 jk/pack-corruption-post-mortem later to maint).
   (merge 9585cb8 jn/doc-fast-import-no-16-octopus-limit later to maint=
).
   (merge 5dcd1b1 ps/grep-help-all-callback-arg later to maint).
   (merge f1f4c84 va/fix-git-p4-tests later to maint).
