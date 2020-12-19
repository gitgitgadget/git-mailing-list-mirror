Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5FDC4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 04:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DA1623B7E
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 04:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgLSEfQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 23:35:16 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51687 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgLSEfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 23:35:16 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA1EFA2B53;
        Fri, 18 Dec 2020 23:34:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=Ew8lDuIt50q5LsWRm3j8hmpaA
        bA=; b=pne0NcTOWz1yAmE5ckeV0x1Fwwcv8uEjL1UTnAvt85zfKCMGke1LlAlN6
        gPcUxmk0Jzb9QagCscmD+i/YgU34DxLsAtr4FjyGOlD/ezck00J2X1EXpyDkI7WN
        Z3Hqhp6takdOEOk55DldL6ZclJP6o8UfqQXkpCjH1YOuiMmirU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=Vy3bxhMyyqETe/v2Oaa
        tZcqR7YOAC9BLWcCoI4F9iDPi3uP4OjHdvypZyzjZH6yaU+b1589xRqbOD85wT6W
        0VQ4GK9mz7oXWDkuVkSX8PkIqSdc9Gcev02ZGs6N9keSX9pO7pAq4wrdtR5Eg/qp
        lmvFMshFtLERVeKBEEpqRCa8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D16A2A2B52;
        Fri, 18 Dec 2020 23:34:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4885DA2B51;
        Fri, 18 Dec 2020 23:34:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.30.0-rc1
Date:   Fri, 18 Dec 2020 20:34:23 -0800
Message-ID: <xmqqsg82qur4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7898733A-41B3-11EB-ACBB-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A release candidate Git v2.30.0-rc1 is now available for testing
at the usual places.  It is comprised of 455 non-merge commits
since v2.29.0, contributed by 72 people, 26 of which are new faces.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.30.0-rc1' tag and the 'master' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.29.0 are as follows.
Welcome to the Git development community!

  Alexey, Amanda Shafack, Bradley M. Kuhn, Caleb Tillman, Charvi
  Mendiratta, Daniel Duvall, Daniel Gurney, Dennis Ameling, Javier
  Spagnoletti, Jinoh Kang, Joey Salazar, Konrad Borowski, Marlon
  Rac Cambasis, Martin Sch=C3=B6n, Micha=C5=82 K=C4=99pie=C5=84, Nate Ave=
rs,
  Nipunn Koorapati, Rafael Silva, Robert Karszniewicz, Samuel
  =C4=8Cavoj, Sean Barag, Sibo Dong, Sim=C3=A3o Afonso, Sohom Datta,
  Thomas Koutcher, and Victor Engmark.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Adam Spiers, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, Alex Vandiver, Arn=
out
  Engelen, brian m. carlson, Christian Couder, Chris. Webster,
  David Aguilar, Denton Liu, Derrick Stolee, Dimitriy Ryazantcev,
  =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh, Drew DeVault, Elijah Newren=
,
  Emily Shaffer, Eric Sunshine, Felipe Contreras, Han-Wen
  Nienhuys, Jeff Hostetler, Jeff King, Jiang Xin, Johannes
  Berg, Johannes Schindelin, Jonathan Tan, Josh Steadmon,
  Junio C Hamano, Kyle Meyer, Martin =C3=85gren, Matheus Tavares,
  Nicolas Morey-Chaisemartin, Patrick Steinhardt, Peter Kaestle,
  Philippe Blain, Phillip Wood, Pranit Bauva, Pratyush Yadav,
  Ramsay Jones, Randall S. Becker, Ren=C3=A9 Scharfe, Sergey Organov,
  Serg Tereshchenko, Srinidhi Kaushik, Stefan Haller, =C5=A0t=C4=9Bp=C3=A1=
n
  N=C4=9Bmec, SZEDER G=C3=A1bor, and Taylor Blau.

----------------------------------------------------------------

Git 2.30 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Updates since v2.29
-------------------

UI, Workflows & Features

 * Userdiff for PHP update.

 * Userdiff for Rust update.

 * Userdiff for CSS update.

 * The command line completion script (in contrib/) learned that "git
   stash show" takes the options "git diff" takes.

 * "git worktree list" now shows if each worktree is locked.  This
   possibly may open us to show other kinds of states in the future.

 * "git maintenance", an extended big brother of "git gc", continues
   to evolve.

 * "git push --force-with-lease[=3D<ref>]" can easily be misused to lose
   commits unless the user takes good care of their own "git fetch".
   A new option "--force-if-includes" attempts to ensure that what is
   being force-pushed was created after examining the commit at the
   tip of the remote ref that is about to be force-replaced.

 * "git clone" learned clone.defaultremotename configuration variable
   to customize what nickname to use to call the remote the repository
   was cloned from.

 * "git checkout" learned to use checkout.guess configuration variable
   and enable/disable its "--[no-]guess" option accordingly.

 * "git resurrect" script (in contrib/) learned that the object names
   may be longer than 40-hex depending on the hash function in use.

 * "git diff A...B" learned "git diff --merge-base A B", which is a
   longer short-hand to say the same thing.

 * A sample 'push-to-checkout' hook, that performs the same as
   what the built-in default action does, has been added.

 * "git diff" family of commands learned the "-I<regex>" option to
   ignore hunks whose changed lines all match the given pattern.

 * The userdiff pattern learned to identify the function definition in
   POSIX shells and bash.

 * "git checkout-index" did not consistently signal an error with its
   exit status, but now it does.

 * A commit and tag object may have CR at the end of each and
   every line (you can create such an object with hash-object or
   using --cleanup=3Dverbatim to decline the default clean-up
   action), but it would make it impossible to have a blank line
   to separate the title from the body of the message.  We are now
   more lenient and accept a line with lone CR on it as a blank line,
   too.

 * Exit codes from "git remote add" etc. were not usable by scripted
   callers, but now they are.

 * "git archive" now allows compression level higher than "-9"
   when generating tar.gz output.

 * Zsh autocompletion (in contrib/) update.

 * The maximum length of output filenames "git format-patch" creates
   has become configurable (used to be capped at 64).

 * "git rev-parse" learned the "--end-of-options" to help scripts to
   safely take a parameter that is supposed to be a revision, e.g.
   "git rev-parse --verify -q --end-of-options $rev".

 * The command line completion script (in contrib/) learned to expand
   commands that are alias of alias.

 * "git update-ref --stdin" learns to take multiple transactions in a
   single session.

 * Various subcommands of "git config" that takes value_regex
   learn the "--literal-value" option to take the value_regex option
   as a literal string.

 * The transport layer was taught to optionally exchange the session
   ID assigned by the trace2 subsystem during fetch/push transactions.

 * "git imap-send" used to ignore configuration variables like
   core.askpass; this has been corrected.

 * "git $cmd $args", when $cmd is not a recognised subcommand, by
   default tries to see if $cmd is a typo of an existing subcommand
   and optionally executes the corrected command if there is only one
   possibility, depending on the setting of help.autocorrect; the
   users can now disable the whole thing, including the cycles spent
   to find a likely typo, by setting the configuration variable to
   'never'.

 * "@" sometimes worked (e.g. "git push origin @:there") as a part of
   a refspec element, but "git push origin @" did not work, which has
   been corrected.


Performance, Internal Implementation, Development Support etc.

 * Use "git archive" more to produce the release tarball.

 * GitHub Actions automated test improvement to skip tests on a tree
   identical to what has already been tested.

 * Test-coverage for running commit-graph task "git maintenance" has
   been extended.

 * Our test scripts can be told to run only individual pieces while
   skipping others with the "--run=3D..." option; they were taught to
   take a substring of test title, in addition to numbers, to name the
   test pieces to run.

 * Adjust tests so that they won't scream when the default initial
   branch name is changed to 'main'.

 * Rewriting "git bisect" in C continues.

 * More preliminary tests have been added to document desired outcome
   of various "directory rename" situations.

 * Micro clean-up of a couple of test scripts.

 * "git diff" and other commands that share the same machinery to
   compare with working tree files have been taught to take advantage
   of the fsmonitor data when available.

 * The code to detect premature EOF in the sideband demultiplexer has
   been cleaned up.

 * Test scripts are being prepared to transition of the default branch
   name to 'main'.

 * "git fetch --depth=3D<n>" over the stateless RPC / smart HTTP
   transport handled EOF from the client poorly at the server end.

 * A specialization of hashmap that uses a string as key has been
   introduced.  Hopefully it will see wider use over time.

 * "git bisect start/next" in a large span of history spends a lot of
   time trying to come up with exactly the half-way point; this can be
   optimized by stopping when we see a commit that is close enough to
   the half-way point.

 * A lazily defined test prerequisite can now be defined in terms of
   another lazily defined test prerequisite.

 * Expectation for the original contributor after responding to a
   review comment to use the explanation in a patch update has been
   described.

 * Multiple "credential-store" backends can race to lock the same
   file, causing everybody else but one to fail---reattempt locking
   with some timeout to reduce the rate of the failure.

 * "git-parse-remote" shell script library outlived its usefulness.

 * Like die() and error(), a call to warning() will also trigger a
   trace2 event.

 * Use of non-reentrant localtime() has been removed.

 * Non-reentrant time-related library functions and ctime/asctime with
   awkward calling interfaces are banned from the codebase.


Fixes since v2.29
-----------------

 * In 2.29, "--committer-date-is-author-date" option of "rebase" and
   "am" subcommands lost the e-mail address by mistake, which has been
   corrected.
   (merge 5f35edd9d7 jk/committer-date-is-author-date-fix later to maint)=
.

 * "git checkout -p A...B [-- <path>]" did not work, even though the
   same command without "-p" correctly used the merge-base between
   commits A and B.
   (merge 35166b1fb5 dl/checkout-p-merge-base later to maint).

 * The side-band status report can be sent at the same time as the
   primary payload multiplexed, but the demultiplexer on the receiving
   end incorrectly split a single status report into two, which has
   been corrected.
   (merge 712b0377db js/avoid-split-sideband-message later to maint).

 * "git fast-import" wasted a lot of memory when many marks were in use.
   (merge 3f018ec716 jk/fast-import-marks-alloc-fix later to maint).

 * A test helper "test_cmp A B" was taught to diagnose missing files A
   or B as a bug in test, but some tests legitimately wanted to notice
   a failure to even create file B as an error, in addition to leaving
   the expected result in it, and were misdiagnosed as a bug.  This
   has been corrected.
   (merge 262d5ad5a5 es/test-cmp-typocatcher later to maint).

 * When "git commit-graph" detects the same commit recorded more than
   once while it is merging the layers, it used to die.  The code now
   ignores all but one of them and continues.
   (merge 85102ac71b ds/commit-graph-merging-fix later to maint).

 * The meaning of a Signed-off-by trailer can vary from project to
   project; this and also what it means to this project has been
   clarified in the documentation.
   (merge 3abd4a67d9 bk/sob-dco later to maint).

 * "git credential' didn't honor the core.askPass configuration
   variable (among other things), which has been corrected.
   (merge 567ad2c0f9 tk/credential-config later to maint).

 * Dev support to catch a tentative definition of a variable in our C
   code as an error.
   (merge 5539183622 jk/no-common later to maint).

 * "git rebase --rebase-merges" did not correctly pass --gpg-sign
   command line option to underlying "git merge" when replaying a merge
   using non-default merge strategy or when replaying an octopus merge
   (because replaying a two-head merge with the default strategy was
   done in a separate codepath, the problem did not trigger for most
   users), which has been corrected.
   (merge 43ad4f2eca sc/sequencer-gpg-octopus later to maint).

 * "git apply -R" did not handle patches that touch the same path
   twice correctly, which has been corrected.  This is most relevant
   in a patch that changes a path from a regular file to a symbolic
   link (and vice versa).
   (merge b0f266de11 jt/apply-reverse-twice later to maint).

 * A recent oid->hash conversion missed one spot, breaking "git svn".
   (merge 03bb366de4 bc/svn-hash-oid-fix later to maint).

 * The documentation on the "--abbrev=3D<n>" option did not say the
   output may be longer than "<n>" hexdigits, which has been
   clarified.
   (merge cda34e0d0c jc/abbrev-doc later to maint).

 * "git p4" now honors init.defaultBranch configuration.
   (merge 1b09d1917f js/p4-default-branch later to maint).

 * Recently the format of an internal state file "rebase -i" uses has
   been tightened up for consistency, which would hurt those who start
   "rebase -i" with old git and then continue with new git.  Loosen
   the reader side a bit (which we may want to tighten again in a year
   or so).
   (merge c779386182 jc/sequencer-stopped-sha-simplify later to maint).

 * The code to see if "git stash drop" can safely remove refs/stash
   has been made more carerful.
   (merge 4f44c5659b rs/empty-reflog-check-fix later to maint).

 * "git log -L<range>:<path>" is documented to take no pathspec, but
   this was not enforced by the command line option parser, which has
   been corrected.
   (merge 39664cb0ac jc/line-log-takes-no-pathspec later to maint).

 * "git format-patch --output=3Dthere" did not work as expected and
   instead crashed.  The option is now supported.
   (merge dc1672dd10 jk/format-patch-output later to maint).

 * Define ARM64 compiled with MSVC to be little-endian.
   (merge 0c038fc65a dg/bswap-msvc later to maint).

 * "git rebase -i" did not store ORIG_HEAD correctly.
   (merge 8843302307 pw/rebase-i-orig-head later to maint).

 * "git blame -L :funcname -- path" did not work well for a path for
   which a userdiff driver is defined.

 * "make DEVELOPER=3D1 sparse" used to run sparse and let it emit
   warnings; now such warnings will cause an error.
   (merge 521dc56270 jc/sparse-error-for-developer-build later to maint).

 * "git blame --ignore-revs-file=3D<file>" learned to ignore a
   non-existent object name in the input, instead of complaining.
   (merge c714d05875 jc/blame-ignore-fix later to maint).

 * Running "git diff" while allowing external diff in a state with
   unmerged paths used to segfault, which has been corrected.
   (merge d66851806f jk/diff-release-filespec-fix later to maint).

 * Build configuration cleanup.
   (merge b990f02fd8 ab/config-mak-uname-simplify later to maint).

 * Fix regression introduced when nvimdiff support in mergetool was added=
.
   (merge 12026f46e7 pd/mergetool-nvimdiff later to maint).

 * The exchange between receive-pack and proc-receive hook did not
   carefully check for errors.

 * The code was not prepared to deal with pack .idx file that is
   larger than 4GB.
   (merge 81c4c5cf2e jk/4gb-idx later to maint).

 * Since jgit does not yet work with SHA-256 repositories, mark the
   tests that uses it not to run unless we are testing with ShA-1
   repositories.
   (merge ea699b4adc sg/t5310-jgit-wants-sha1 later to maint).

 * Config parser fix for "git notes".
   (merge 45fef1599a na/notes-displayref-is-not-boolean later to maint).

 * Move a definition of compatibility wrapper from cache.h to
   git-compat-util.h
   (merge a76b138daa hn/sleep-millisec-decl later to maint).

 * Error message fix.
   (merge eaf5341538 km/stash-error-message-fix later to maint).

 * "git pull --rebase --recurse-submodules" checked for local changes
   in a wrong range and failed to run correctly when it should.
   (merge 5176f20ffe pb/pull-rebase-recurse-submodules later to maint).

 * "git push" that is killed may leave a pack-objects process behind,
   still computing to find a good compression, wasting cycles.  This
   has been corrected.
   (merge 8b59935114 jk/stop-pack-objects-when-push-is-killed later to ma=
int).

 * "git fetch" that is killed may leave a pack-objects process behind,
   still computing to find a good compression, wasting cycles.  This
   has been corrected.
   (merge 309a4028e7 jk/stop-pack-objects-when-fetch-is-killed later to m=
aint).

 * "git add -i" failed to honor custom colors configured to show
   patches, which has been corrected.
   (merge 96386faa03 js/add-i-color-fix later to maint).

 * Processes that access packdata while the .idx file gets removed
   (e.g. while repacking) did not fail or fall back gracefully as they
   could.
   (merge 506ec2fbda tb/idx-midx-race-fix later to maint).

 * "git apply" adjusted the permission bits of working-tree files and
   directories according core.sharedRepository setting by mistake and
   for a long time, which has been corrected.
   (merge eb3c027e17 mt/do-not-use-scld-in-working-tree later to maint).

 * "fetch-pack" could pass NULL pointer to unlink(2) when it sees an
   invalid filename; the error checking has been tightened to make
   this impossible.
   (merge 6031af387e rs/fetch-pack-invalid-lockfile later to maint).

 * "git maintenance run/start/stop" needed to be run in a repository
   to hold the lockfile they use, but didn't make sure they are
   actually in a repository, which has been corrected.

 * The glossary described a branch as an "active" line of development,
   which is misleading---a stale and non-moving branch is still a
   branch.
   (merge eef1ceabd8 so/glossary-branch-is-not-necessarily-active later t=
o maint).

 * Newer versions of xsltproc can assign IDs in HTML documents it
   generates in a consistent manner.  Use the feature to help format
   HTML version of the user manual reproducibly.
   (merge 3569e11d69 ae/doc-reproducible-html later to maint).

 * Tighten error checking in the codepath that responds to "git fetch".
   (merge d43a21bdbb jk/check-config-parsing-error-in-upload-pack later t=
o maint).

 * Other code cleanup, docfix, build fix, etc.
   (merge 3e0a5dc9af cc/doc-filter-branch-typofix later to maint).
   (merge 32c83afc2c cw/ci-ghwf-check-ws-errors later to maint).
   (merge 5eb2ed691b rs/tighten-callers-of-deref-tag later to maint).
   (merge 6db29ab213 jk/fast-import-marks-cleanup later to maint).
   (merge e5cf6d3df4 nk/dir-c-comment-update later to maint).
   (merge 5710dcce74 jk/report-fn-typedef later to maint).
   (merge 9a82db1056 en/sequencer-rollback-lock-cleanup later to maint).
   (merge 4e1bee9a99 js/t7006-cleanup later to maint).
   (merge f5bcde6c58 es/tutorial-mention-asciidoc-early later to maint).
   (merge 714d491af0 so/format-patch-doc-on-default-diff-format later to =
maint).
   (merge 0795df4b9b rs/clear-commit-marks-in-repo later to maint).
   (merge 9542d56379 sd/prompt-local-variable later to maint).
   (merge 06d43fad18 rs/pack-write-hashwrite-simplify later to maint).
   (merge b7e20b4373 mc/typofix later to maint).
   (merge f6bcd9a8a4 js/test-whitespace-fixes later to maint).
   (merge 53b67a801b js/test-file-size later to maint).
   (merge 970909c2a7 rs/hashwrite-be64 later to maint).
   (merge 5a923bb1f0 ma/list-object-filter-opt-msgfix later to maint).
   (merge 1c3e412916 rs/archive-plug-leak-refname later to maint).
   (merge d44e5267ea rs/plug-diff-cache-leak later to maint).
   (merge 793c1464d3 ab/gc-keep-base-option later to maint).
   (merge b86339b12b mt/worktree-error-message-fix later to maint).
   (merge e01ae2a4a7 js/pull-rebase-use-advise later to maint).
   (merge e63d774242 sn/config-doc-typofix later to maint).
   (merge 08e9df2395 jk/multi-line-indent-style-fix later to maint).
   (merge e66590348a da/vs-build-iconv-fix later to maint).
   (merge 7fe07275be js/cmake-extra-built-ins-fix later to maint).
   (merge 633eebe142 jb/midx-doc-update later to maint).
   (merge 5885367e8f jh/index-v2-doc-on-fsmn later to maint).
   (merge 14639a4779 jc/compat-util-setitimer-fix later to maint).
   (merge 56f56ac50b ab/unreachable-break later to maint).
   (merge 731d578b4f rb/nonstop-config-mak-uname-update later to maint).
   (merge f4698738f9 es/perf-export-fix later to maint).

----------------------------------------------------------------

Changes since v2.29.0 are as follows:

Adam Spiers (1):
      hook: add sample template for push-to-checkout

Alex Vandiver (2):
      dir.c: fix comments to agree with argument name
      fsmonitor: use fsmonitor data in `git diff`

Alexey (1):
      completion: fix zsh installation instructions

Amanda Shafack (1):
      t2200,t9832: avoid using 'git' upstream in a pipe

Arnout Engelen (1):
      doc: make HTML manual reproducible

Bradley M. Kuhn (2):
      Documentation: clarify and expand description of --signoff
      Documentation: stylistically normalize references to Signed-off-by:

Caleb Tillman (1):
      t0000: use test_path_is_file instead of "test -f"

Charvi Mendiratta (5):
      t7101,t7102,t7201: modernize test formatting
      t7102,t7201: remove unnecessary blank spaces in test body
      t7102,t7201: remove whitespace after redirect operator
      t7201: use 'git -C' to avoid subshell
      t7201: put each command on a separate line

Chris. Webster (1):
      ci: github action - add check for whitespace errors

Christian Couder (1):
      filter-branch doc: fix filter-repo typo

Daniel Duvall (1):
      upload-pack: allow stateless client EOF just prior to haves

Daniel Gurney (2):
      compat/bswap.h: simplify MSVC endianness detection
      compat/bswap.h: don't assume MSVC is little-endian

David Aguilar (1):
      git-gui: ssh-askpass: add a checkbox to show the input text

Dennis Ameling (1):
      ci(vs-build): stop passing the iconv library location explicitly

Denton Liu (18):
      t4068: remove unnecessary >tmp
      git-diff-index.txt: make --cached description a proper sentence
      git-diff.txt: backtick quote command text
      contrib/completion: extract common diff/difftool options
      diff-lib: accept option flags in run_diff_index()
      diff-lib: define diff_get_merge_base()
      t4068: add --merge-base tests
      builtin/diff-index: learn --merge-base
      builtin/diff-tree: learn --merge-base
      contrib/completion: complete `git diff --merge-base`
      Documentation/config/checkout: replace sq with backticks
      builtin/checkout: fix `git checkout -p HEAD...` bug
      Doc: document "A...B" form for <tree-ish> in checkout and switch
      add-patch: add NEEDSWORK about comparing commits
      t2016: add a NEEDSWORK about the PERL prerequisite
      checkout: learn to respect checkout.guess
      contrib/git-resurrect.sh: indent with tabs
      contrib/git-resurrect.sh: use hash-agnostic OID pattern

Derrick Stolee (28):
      maintenance: add prefetch task
      maintenance: add loose-objects task
      maintenance: create auto condition for loose-objects
      midx: enable core.multiPackIndex by default
      midx: use start_delayed_progress()
      maintenance: add incremental-repack task
      maintenance: auto-size incremental-repack batch
      maintenance: add incremental-repack auto condition
      maintenance: optionally skip --auto process
      maintenance: add --schedule option and config
      for-each-repo: run subcommands on configured repos
      maintenance: add [un]register subcommands
      maintenance: add start/stop subcommands
      maintenance: test commit-graph auto condition
      commit-graph: ignore duplicates when merging layers
      commit-graph: don't write commit-graph when disabled
      maintenance: core.commitGraph=3Dfalse prevents writes
      maintenance: create maintenance.strategy config
      maintenance: use 'incremental' strategy by default
      maintenance: add troubleshooting guide to docs
      config: convert multi_replace to flags
      config: replace 'value_regex' with 'value_pattern'
      t1300: test "set all" mode with value-pattern
      t1300: add test for --replace-all with value-pattern
      config: add --fixed-value option, un-implemented
      config: plumb --fixed-value into config API
      config: implement --fixed-value with --get*
      maintenance: use 'git config --fixed-value'

Dimitriy Ryazantcev (1):
      git-gui: update Russian translation

Drew DeVault (1):
      help.c: help.autocorrect=3Dnever means "do not compute suggestions"

Elijah Newren (37):
      hashmap: add usage documentation explaining hashmap_free[_entries](=
)
      directory-rename-detection.txt: update references to regression tes=
ts
      t6423: more involved directory rename test
      t6423: update directory rename detection tests with new rule
      t6423: more involved rules for renaming directories into each other
      t7518: fix flaky grep invocation
      test-lib: allow selecting tests by substring/glob with --run
      t6006, t6012: adjust tests to use 'setup' instead of synonyms
      test-lib: reduce verbosity of skipped tests
      sequencer: remove duplicate rollback_lock_file() call
      t/: new helper for tests that pass with ort but fail with recursive
      merge tests: expect improved directory/file conflict handling in or=
t
      t6416: correct expectation for rename/rename(1to2) + directory/file
      t6404, t6423: expect improved rename/delete handling in ort backend
      t6423: expect improved conflict markers labels in the ort backend
      merge tests: expect slight differences in output for recursive vs. =
ort
      t6423, t6436: note improved ort handling with dirty files
      t6423: note improved ort handling with untracked files
      t6423: add more details about direct resolution of directories
      merge-ort: barebones API of new merge strategy with empty implement=
ation
      merge-ort-wrappers: new convience wrappers to mimic the old merge A=
PI
      fast-rebase: demonstrate merge-ort's API via new test-tool command
      hashmap: adjust spacing to fix argument alignment
      hashmap: allow re-use after hashmap_free()
      hashmap: introduce a new hashmap_partial_clear()
      hashmap: provide deallocation function names
      strmap: new utility functions
      merge,rebase,revert: select ort or recursive by config or environme=
nt
      strmap: add more utility functions
      strmap: enable faster clearing and reusing of strmaps
      strmap: add functions facilitating use as a string->int map
      strmap: split create_entry() out of strmap_put()
      strmap: add a strset sub-type
      strmap: enable allocations to come from a mem_pool
      strmap: take advantage of FLEXPTR_ALLOC_STR when relevant
      Use new HASHMAP_INIT macro to simplify hashmap initialization
      shortlog: use strset from strmap.h

Emily Shaffer (1):
      MyFirstContribution: clarify asciidoc dependency

Eric Sunshine (1):
      t/perf: fix test_export() failure with BSD `sed`

Felipe Contreras (41):
      completion: zsh: fix __gitcomp_direct()
      completion: zsh: fix name due to broken autoloading
      completion: zsh: fix bash script extension
      completion: zsh: reorganize install instructions
      completion: zsh: fix for directories with spaces
      completion: zsh: update slave script locations
      completion: prompt: fix color for Zsh
      completion: zsh: fix for command aliasing
      completion: bash: synchronize zsh wrapper
      completion: bash: remove zsh wrapper
      completion: zsh: fix completion for --no-.. options
      completion: fix conflict with bashcomp
      completion: zsh: add missing direct_append
      completion: zsh: fix splitting of words
      completion: zsh: simplify compadd functions
      completion: zsh: simplify direct compadd
      completion: zsh: trivial cleanup
      completion: zsh: simplify nl_append
      completion: zsh: simplify file_direct
      completion: zsh: shuffle functions around
      completion: zsh: refactor command completion
      completion: zsh: improve command tags
      completion: zsh: add alias descriptions
      completion: zsh: trivial simplification
      completion: zsh: add simple version check
      completion: bash: trivial cleanup
      completion: bash: cleanup cygwin check
      completion: bash: remove old compat wrappers
      zsh: update copyright notices
      completion: bash: support recursive aliases
      completion: bash: check for alias loop
      completion: bash: improve alias loop detection
      tests: push: improve cleanup of HEAD tests
      tests: push: trivial cleanup
      refspec: make @ a synonym of HEAD
      refspec: trivial cleanup
      .gitignore: remove dangling file
      test: completion: fix typos
      tests: lib-functions: trivial style cleanups
      completion: zsh: fix file completion regression
      completion: bash: fix gitk alias regression

Han-Wen Nienhuys (1):
      move sleep_millisec to git-compat-util.h

Javier Spagnoletti (1):
      userdiff: PHP: catch "abstract" and "final" functions

Jeff Hostetler (1):
      index-format.txt: document v2 format of file system monitor extensi=
on

Jeff King (44):
      fast-import: fix over-allocation of marks storage
      usage: define a type for a reporting function
      config.mak.dev: build with -fno-common
      fast-import: remove duplicated option-parsing line
      perl: check for perl warnings while running tests
      t3436: check --committer-date-is-author-date result more carefully
      am: fix broken email with --committer-date-is-author-date
      rebase: fix broken email with --committer-date-is-author-date
      am, sequencer: stop parsing our own committer ident
      test-pkt-line: drop colon from sideband identity
      checkout-index: drop error message from empty --stage=3Dall
      checkout-index: propagate errors to exit code
      sideband: diagnose more sideband anomalies
      format-patch: refactor output selection
      format-patch: tie file-opening logic to output_directory
      format-patch: support --output option
      rev-parse: don't accept options after dashdash
      rev-parse: put all options under the "-" check
      rev-parse: handle --end-of-options
      compute pack .idx byte offsets using size_t
      use size_t to store pack .idx byte offsets
      fsck: correctly compute checksums on idx files larger than 4GB
      block-sha1: take a size_t length parameter
      packfile: detect overflow in .idx file size checks
      repack: make "exts" array available outside cmd_repack()
      send-pack: kill pack-objects helper on signal or exit
      submodule: fix fetch_in_submodule logic
      upload-pack: kill pack-objects helper on signal or exit
      banned.h: mark non-reentrant gmtime, etc as banned
      t7900: speed up expensive test
      gitignore: drop duplicate entry for git-sh-i18n
      banned.h: mark ctime_r() and asctime_r() as banned
      Makefile: mark git-maintenance as a builtin
      upload-pack: propagate return value from object filter config callb=
ack
      style: indent multiline "if" conditions to align
      oid-array.h: drop sha1 mention from header guard
      t0064: drop sha1 mention from filename
      t0064: make duplicate tests more robust
      cache.h: move hash/oid functions to hash.h
      oid-array: make sort function public
      oid-array: provide a for-loop iterator
      commit-graph: drop count_distinct_commits() function
      commit-graph: replace packed_oid_list with oid_array
      commit-graph: use size_t for array allocation and indexing

Jiang Xin (3):
      t5411: new helper filter_out_user_friendly_and_stable_output
      receive-pack: gently write messages to proc-receive
      receive-pack: use default version 0 for proc-receive

Jinoh Kang (2):
      diff: allow passing NULL to diff_free_filespec_data()
      t7800: simplify difftool test

Joey Salazar (1):
      t7006: Use test_path_is_* functions in test script

Johannes Berg (1):
      docs: multi-pack-index: remove note about future 'verify' work

Johannes Schindelin (63):
      ci: work around old records of GitHub runs
      ci: make the "skip-if-redundant" check more defensive
      sideband: avoid reporting incomplete sideband messages
      sideband: report unhandled incomplete sideband messages as bugs
      SKIP_DASHED_BUILT_INS: do not skip the bin/ programs
      fmt-merge-msg: also suppress "into main" by default
      t9801: use `--` in preparation for default branch rename
      tests: start moving to a different default main branch name
      t6200: adjust suppression pattern to also match "main"
      t5703: adjust a test case for the upcoming default branch name
      t3200: prepare for `main` being shorter than `master`
      t9902: prepare a test for the upcoming default branch name
      tests: prepare aligned mentions of the default branch name
      t1400: prepare for `main` being default branch name
      t5411: start using the default branch name "main"
      t5411: start adjusting the support files for init.defaultBranch=3Dm=
ain
      t5411: adjust the remaining support files for init.defaultBranch=3D=
main
      t5411: finish preparing for `main` being the default branch name
      t5515: use `main` as the name of the main branch for testing (part =
1)
      t5515: use `main` as the name of the main branch for testing (part =
2)
      t5515: use `main` as the name of the main branch for testing (part =
3)
      t5515: use `main` as the name of the main branch for testing (concl=
usion)
      t2402: fix typo
      ci: make the whitespace checker more robust
      tests: consolidate the `file_size` function into `test-lib-function=
s.sh`
      ci: avoid using the deprecated `set-env` construct
      p4: respect init.defaultBranch
      t1004: insert missing "branch" in a message
      t3406: indent with tabs, not spaces
      t3427: adjust stale comment
      t5400,t5402: consistently indent with tabs, not with spaces
      t5570: remove trailing padding
      t9603: use tabs for indentation
      add -i (built-in): do show an error message for incorrect inputs
      add -i (built-in): send error messages to stderr
      add -p (built-in): imitate `xdl_format_hunk_hdr()` generating hunk =
headers
      add -i: use `reset_color` consistently
      add -i (built-in): prevent the `reset` "color" from being configure=
d
      add -i (built-in): use correct names to load color.diff.* config
      mergetools/bc: add `bc4` to the alias list for Beyond Compare
      mergetool: avoid letting `list_tool_variants` break user-defined se=
tups
      add -p (built-in): do not color the progress indicator separately
      add -i (built-in): use the same indentation as the Perl version
      add -i (Perl version): color header to match the C version
      add -p: prefer color.diff.context over color.diff.plain
      add -i: verify in the tests that colors can be overridden
      t2106: adjust style to the current conventions
      t2106: make test independent of the current main branch name
      t2106: ensure that the checkout fails for the expected reason
      t3040: remove stale note
      t1309: use a neutral branch name in the `onbranch` test cases
      t4015: let the test pass with any default branch name
      pull: colorize the hint about setting `pull.rebase`
      t3404: do not depend on any specific default branch name
      t5526: avoid depending on a specific default branch name
      t5526: drop the prereq expecting the default branch name `main`
      cmake: determine list of extra built-ins dynamically
      t6300: avoid using the default name of the initial branch
      t7064: avoid relying on a specific default branch name
      init: document `init.defaultBranch` better
      branch -m: allow renaming a yet-unborn branch
      get_default_branch_name(): prepare for showing some advice
      init: provide useful advice about init.defaultBranch

Jonathan Tan (3):
      apply: when -R, also reverse list of sections
      sequencer: tolerate abbreviated stopped-sha file
      usage: add trace2 entry upon warning()

Josh Steadmon (13):
      docs: new capability to advertise session IDs
      docs: new transfer.advertiseSID option
      trace2: add a public function for getting the SID
      upload-pack: advertise session ID in v0 capabilities
      receive-pack: advertise session ID in v0 capabilities
      serve: advertise session ID in v2 capabilities
      transport: log received server session ID
      fetch-pack: advertise session ID in capabilities
      upload-pack, serve: log received client session ID
      send-pack: advertise session ID in capabilities
      receive-pack: log received client session ID
      t7900: fix typo: "test_execpt_success"
      t7900: use --fixed-value in git-maintenance tests

Junio C Hamano (33):
      doc: preparatory clean-up of description on the sign-off option
      SubmittingPatches: clarify DCO is our --signoff rule
      Revert "test_cmp: diagnose incorrect arguments"
      t7102: prepare expected output inside test_expect_* block
      Git 2.29.1
      other small fixes for 2.29.2
      SubmittingPatches: clarify the purpose of the final resend
      First batch
      Git 2.29.2
      Second batch
      Makefile: enable -Wsparse-error for DEVELOPER build
      Third batch
      log: diagnose -L used with pathspec as an error
      doc: clarify that --abbrev=3D<n> is about the minimum length
      Fourth batch
      format-patch: make output filename configurable
      Fifth batch
      ci: avoid `set-env` construct in print-test-failures.sh
      Sixth batch
      Seventh batch
      MyFirstContribition: answering questions is not the end of the stor=
y
      config doc: value-pattern is not necessarily a regexp
      Eighth batch
      Ninth batch
      Revert "submodules: fix of regression on fetching of non-init subsu=
b-repo"
      Tenth batch
      Eleventh batch
      Git 2.30-rc0
      strmap: make callers of strmap_remove() to call it in void context
      compat-util: pretend that stub setitimer() always succeeds
      diff: correct interaction between --exit-code and -I<pattern>
      Another batch before 2.30-rc1
      Git 2.30-rc1

Konrad Borowski (1):
      userdiff: recognize 'macro_rules!' as starting a Rust function bloc=
k

Kyle Meyer (1):
      stash: add missing space to an error message

Marlon Rac Cambasis (1):
      doc: fixing two trivial typos in Documentation/

Martin Sch=C3=B6n (1):
      git-gui: use commit message template

Martin =C3=85gren (5):
      list-objects-filter-options: fix function name in BUG
      grep: don't set up a "default" repo for grep
      grep: use designated initializers for `grep_defaults`
      grep: copy struct in one fell swoop
      MyFirstObjectWalk: drop `init_walken_defaults()`

Matheus Tavares (2):
      worktree: fix order of arguments in error message
      apply: don't use core.sharedRepository to create working tree files

Micha=C5=82 K=C4=99pie=C5=84 (2):
      merge-base, xdiff: zero out xpparam_t structures
      diff: add -I<regex> that ignores matching changes

Nate Avers (2):
      notes.c: fix a segfault in notes_display_config()
      t3301: test proper exit response to no-value notes.displayRef.

Nicolas Morey-Chaisemartin (1):
      imap-send: parse default git config

Nipunn Koorapati (17):
      t/perf/README: elaborate on output format
      t/perf/p7519-fsmonitor.sh: warm cache on first git status
      t/perf: add fsmonitor perf test for git diff
      perf lint: add make test-lint to perf tests
      p7519-fsmonitor: refactor to avoid code duplication
      p7519-fsmonitor: add a git add benchmark
      t/perf/fsmonitor: separate one time repo initialization
      t/perf/fsmonitor: move watchman setup to one-time-repo-setup
      t/perf/fsmonitor: improve error message if typoing hook name
      t/perf/fsmonitor: factor description out for readability
      t/perf/fsmonitor: shorten DESC to basename
      t/perf/fsmonitor: silence initial git commit
      t/perf/fsmonitor: factor setup for fsmonitor into function
      t/perf/fsmonitor: initialize test with git reset
      t/perf/fsmonitor: perf comparison of multiple fsmonitor integration=
s
      t/perf/fsmonitor: add benchmark for dirty status
      perf/fsmonitor: use test_must_be_empty helper

Patrick Steinhardt (4):
      t1400: avoid touching refs on filesystem
      update-ref: allow creation of multiple transactions
      p1400: use `git-update-ref --stdin` to test multiple transactions
      update-ref: disallow "start" for ongoing transactions

Peter Kaestle (1):
      submodules: fix of regression on fetching of non-init subsub-repo

Philippe Blain (14):
      ref-filter: handle CRLF at end-of-line more gracefully
      log, show: add tests for messages containing CRLF
      doc: log, gitk: move '-L' description to 'line-range-options.txt'
      doc: line-range: improve formatting
      blame-options.txt: also mention 'funcname' in '-L' description
      doc: add more pointers to gitattributes(5) for userdiff
      line-log: mention both modes in 'blame' and 'log' short help
      blame: enable funcname blaming with userdiff driver
      blame: simplify 'setup_scoreboard' interface
      blame: simplify 'setup_blame_bloom_data' interface
      pull --rebase: compute rebase arguments in separate function
      t5572: add notes on a peculiar test
      t5572: describe '--rebase' tests a little more
      pull: check for local submodule modifications with the right range

Phillip Wood (4):
      rebase -i: stop overwriting ORIG_HEAD buffer
      rebase -i: use struct object_id rather than looking up commit
      rebase -i: use struct object_id when writing state
      rebase -i: simplify get_revision_ranges()

Pranit Bauva (7):
      bisect--helper: finish porting `bisect_start()` to C
      bisect--helper: retire `--bisect-clean-state` subcommand
      bisect--helper: retire `--next-all` subcommand
      bisect--helper: reimplement `bisect_state` & `bisect_head` shell fu=
nctions in C
      bisect--helper: retire `--check-expected-revs` subcommand
      bisect--helper: retire `--write-terms` subcommand
      bisect--helper: retire `--bisect-autostart` subcommand

Pratyush Yadav (1):
      git-gui: Only touch GITGUI_MSG when needed

Rafael Silva (2):
      worktree: teach `list` to annotate locked worktree
      maintenance: fix SEGFAULT when no repository

Ramsay Jones (6):
      Documentation/Makefile: conditionally include doc.dep
      Documentation/Makefile: conditionally include ../GIT-VERSION-FILE
      gitweb/Makefile: conditionally include ../GIT-VERSION-FILE
      Makefile: don't try to clean old debian build product
      Makefile: don't use a versioned temp distribution directory
      Makefile: conditionally include GIT-VERSION-FILE

Randall S. Becker (1):
      config.mak.uname: remove old NonStop compatibility settings

Ren=C3=A9 Scharfe (19):
      Makefile: use git init/add/commit/archive for dist-doc
      Makefile: remove the unused variable TAR_DIST_EXTRA_OPTS
      grep: handle deref_tag() returning NULL
      blame: handle deref_tag() returning NULL
      line-log: handle deref_tag() returning NULL
      object: allow clear_commit_marks_all to handle any repo
      bisect: clear flags in passed repository
      stash: simplify reflog emptiness check
      pack-write: use hashwrite_be32() instead of double-buffering array
      archive: support compression levels beyond 9
      blame: silently ignore invalid ignore file objects
      csum-file: add hashwrite_be64()
      midx: use hashwrite_be64()
      pack-write: use hashwrite_be64()
      diff-lib: plug minor memory leaks in do_diff_cache()
      archive: release refname after use
      gc: fix cast in compare_tasks_by_selection()
      fetch-pack: disregard invalid pack lockfiles
      gitignore: remove entry for git serve

Robert Karszniewicz (2):
      git-completion.bash: __git_diff_common_options: add --[no-]patch
      git-completion.bash: stash-show: complete $__git_diff_common_option=
s

SZEDER G=C3=A1bor (4):
      bisect: loosen halfway() check for a large number of commits
      t5310-pack-bitmaps: skip JGit tests with SHA256
      tests: make sure nested lazy prereqs work reliably
      tests: fix description of 'test_set_prereq'

Samuel =C4=8Cavoj (3):
      sequencer: fix gpg option passed to merge subcommand
      sequencer: pass explicit --no-gpg-sign to merge
      t3435: add tests for rebase -r GPG signing

Sean Barag (7):
      clone: add tests for --template and some disallowed option pairs
      clone: use more conventional config/option layering
      remote: add tests for add and rename with invalid names
      refs: consolidate remote name validation
      clone: validate --origin option before use
      clone: read new remote name from remote_name instead of option_orig=
in
      clone: allow configurable default for `-o`/`--origin`

Serg Tereshchenko (1):
      git-gui: Fix selected text colors

Sergey Organov (2):
      doc/diff-options: fix out of place mentions of '--patch/-p'
      glossary: improve "branch" definition

Sibo Dong (1):
      git-prompt.sh: localize `option` in __git_ps1_show_upstream

Sim=C3=A3o Afonso (1):
      crendential-store: use timeout when locking file

Sohom Datta (1):
      userdiff: expand detected chunk headers for css

Srinidhi Kaushik (3):
      push: add reflog check for "--force-if-includes"
      push: parse and set flag for "--force-if-includes"
      t, doc: update tests, reference for "--force-if-includes"

Stefan Haller (2):
      git-gui: fix colored label backgrounds when using themed widgets
      git-gui: use gray background for inactive text widgets

Taylor Blau (7):
      builtin/repack.c: keep track of what pack-objects wrote
      builtin/repack.c: don't move existing packs out of the way
      packfile.c: protect against disappearing indexes
      midx.c: protect against disappearing packs
      builtin/bugreport.c: use thread-safe localtime_r()
      builtin/clone.c: don't ignore transport_fetch_refs() errors
      upload-pack.c: don't free allowed_filters util pointers

Thomas Koutcher (1):
      credential: load default config

Victor Engmark (1):
      userdiff: support Bash

brian m. carlson (1):
      svn: use correct variable name for short OID

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (9):
      remote: add meaningful exit code on missing/existing
      config.mak.uname: remove unused the NO_R_TO_GCC_LINKER flag
      config.mak.uname: remove unused NEEDS_SSL_WITH_CURL flag
      submodule: use "fetch" logic instead of custom remote discovery
      submodule: remove sh function in favor of helper
      parse-remote: remove this now-unused library
      gc docs: change --keep-base-pack to --keep-largest-pack
      gc: rename keep_base_pack variable for --keep-largest-pack
      style: do not "break" in switch() after "return"

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh (1):
      doc: mention Python 3.x supports

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec (1):
      config.txt: fix a typo (backslash !=3D backquote)

