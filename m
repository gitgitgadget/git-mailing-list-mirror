Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC6CA1F454
	for <e@80x24.org>; Mon,  4 Nov 2019 05:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfKDFhL (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 00:37:11 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55121 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfKDFhL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 00:37:11 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 20C67AF2E5;
        Mon,  4 Nov 2019 00:36:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=vPDfFZhMPLvePE1sA4HOYGwus
        fY=; b=YG+UV9p8Lu3NplAFdMOOU02YnKKoRnaA0SfLMuD0yVpnGr7e1sPBYCYzv
        +RkmSr12DZBUKcVLpPm1R6zQkVr/nYRM+R6Cw1MbpZStPvwg6sm46wev42EazvTX
        qOxWzPJJGm/BnZvb9vwzfwaOyDdeg41RNyL9QMDrbUloz7umY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=AK8ZMETMUhuiFQk3Bv6
        BS4N0sLyow/02CDnhDV3vJ1MxGrPmRJLMOILecEej7K9Bq8vHkcvF2SxJABCxABF
        qaLVUlw8J5dZQfx6W3/dd3ydq4UbAywsLg9GtIdRk+TTtJTFOCyhVNfX5Vr7lo2A
        TogNhYWKPBc0bE1TL30wagZE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 16F75AF2E4;
        Mon,  4 Nov 2019 00:36:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E294FAF2E2;
        Mon,  4 Nov 2019 00:36:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.24.0
Date:   Mon, 04 Nov 2019 14:36:50 +0900
Message-ID: <xmqq7e4gyzgt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1B2C617A-FEC5-11E9-A1D1-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest feature release Git v2.24.0 is now available at the
usual places.  It is comprised of 544 non-merge commits since
v2.23.0, contributed by 78 people, 21 of which are new faces.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.24.0'
tag and the 'master' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.23.0 are as follows.
Welcome to the Git development community!

  Alexandr Miloslavskiy, Ali Utku Selen, Ben Milman, Cameron
  Steffen, CB Bailey, Christopher Diaz Riveros, Garima Singh,
  Herv=C3=A9 Beraud, Jakob Jarmar, kdnakt, Kunal Tyagi, Maxim
  Belsky, Max Rothman, Norman Rasmussen, Paul Wise, Pedro Sousa,
  Philip.McGraw, Pratyush Yadav, Thomas Klaeger, William Baker,
  and YanKe.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Adam Roben, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, Alessandro Menti,
  Alexander Shopov, Alex Henrie, Andrey Mazo, Beat Bolli, Ben
  Wijen, Bert Wesarg, Birger Skogeng Pedersen, brian m. carlson,
  Carlo Marcelo Arenas Bel=C3=B3n, Christian Couder, Cl=C3=A9ment Chigot,
  Corentin BOMPARD, David Turner, Denton Liu, Derrick Stolee,
  Elijah Newren, Emily Shaffer, Eric Wong, Gabriele Mazzotta,
  Jean-No=C3=ABl Avila, Jeff Hostetler, Jeff King, Jiang Xin, Johannes
  Schindelin, Johannes Sixt, Jonathan Tan, Jon Simons, Jordi Mas,
  Josh Steadmon, Junio C Hamano, Martin =C3=85gren, Masaya Suzuki,
  Matheus Tavares, Matthew DeVore, Matthias R=C3=BCster, Michael
  J Gruber, Mike Hommey, Mischa POSLAWSKY, Paul Mackerras,
  Peter Krefting, Phillip Wood, Ren=C3=A9 Scharfe, Robert Luberda,
  Stephen Boyd, Stephen P. Smith, Sun Chao, SZEDER G=C3=A1bor,
  Tanay Abhra, Taylor Blau, Thomas Gummerer, Tobias Klauser,
  Torsten B=C3=B6gershausen, Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n, and Var=
un Naik.

----------------------------------------------------------------

Git 2.24 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Updates since v2.23
-------------------

Backward compatibility note

 * "filter-branch" is showing its age and alternatives are available.
   From this release, we started to discourage its use and hint
   people about filter-repo.

UI, Workflows & Features

 * We now have an active interim maintainer for the Git-Gui part of
   the system.  Praise and thank Pratyush Yadav for volunteering.

 * The command line parser learned "--end-of-options" notation; the
   standard convention for scripters to have hardcoded set of options
   first on the command line, and force the command to treat end-user
   input as non-options, has been to use "--" as the delimiter, but
   that would not work for commands that use "--" as a delimiter
   between revs and pathspec.

 * A mechanism to affect the default setting for a (related) group of
   configuration variables is introduced.

 * "git fetch" learned "--set-upstream" option to help those who first
   clone from their private fork they intend to push to, add the true
   upstream via "git remote add" and then "git fetch" from it.

 * Device-tree files learned their own userdiff patterns.
   (merge 3c81760bc6 sb/userdiff-dts later to maint).

 * "git rebase --rebase-merges" learned to drive different merge
   strategies and pass strategy specific options to them.

 * A new "pre-merge-commit" hook has been introduced.

 * Command line completion updates for "git -c var.name=3Dval" have been
   added.

 * The lazy clone machinery has been taught that there can be more
   than one promisor remote and consult them in order when downloading
   missing objects on demand.

 * The list-objects-filter API (used to create a sparse/lazy clone)
   learned to take a combined filter specification.

 * The documentation and tests for "git format-patch" have been
   cleaned up.

 * On Windows, the root level of UNC share is now allowed to be used
   just like any other directory.

 * The command line completion support (in contrib/) learned about the
   "--skip" option of "git revert" and "git cherry-pick".

 * "git rebase --keep-base <upstream>" tries to find the original base
   of the topic being rebased and rebase on top of that same base,
   which is useful when running the "git rebase -i" (and its limited
   variant "git rebase -x").

   The command also has learned to fast-forward in more cases where it
   can instead of replaying to recreate identical commits.

 * A configuration variable tells "git fetch" to write the commit
   graph after finishing.

 * "git add -i" has been taught to show the total number of hunks and
   the hunks that has been processed so far when showing prompts.

 * "git fetch --jobs=3D<n>" allowed <n> parallel jobs when fetching
   submodules, but this did not apply to "git fetch --multiple" that
   fetches from multiple remote repositories.  It now does.

 * The installation instruction for zsh completion script (in
   contrib/) has been a bit improved.


Performance, Internal Implementation, Development Support etc.

 * The code to write commit-graph over given commit object names has
   been made a bit more robust.

 * The first line of verbose output from each test piece now carries
   the test name and number to help scanning with eyeballs.

 * Further clean-up of the initialization code.

 * xmalloc() used to have a mechanism to ditch memory and address
   space resources as the last resort upon seeing an allocation
   failure from the underlying malloc(), which made the code complex
   and thread-unsafe with dubious benefit, as major memory resource
   users already do limit their uses with various other mechanisms.
   It has been simplified away.

 * Unnecessary full-tree diff in "git log -L" machinery has been
   optimized away.

 * The http transport lacked some optimization the native transports
   learned to avoid unnecessary ref advertisement, which has been
   corrected.

 * Preparation for SHA-256 upgrade continues in the test department.
   (merge 0c37c41d13 bc/hash-independent-tests-part-5 later to maint).

 * The memory ownership model of the "git fast-import" got
   straightened out.

 * Output from trace2 subsystem is formatted more prettily now.

 * The internal code originally invented for ".gitignore" processing
   got reshuffled and renamed to make it less tied to "excluding" and
   stress more that it is about "matching", as it has been reused for
   things like sparse checkout specification that want to check if a
   path is "included".

 * "git stash" learned to write refreshed index back to disk.

 * Coccinelle checks are done on more source files than before now.

 * The cache-tree code has been taught to be less aggressive in
   attempting to see if a tree object it computed already exists in
   the repository.

 * The code to parse and use the commit-graph file has been made more
   robust against corrupted input.

 * The hg-to-git script (in contrib/) has been updated to work with
   Python 3.

 * Update the way build artifacts in t/helper/ directory are ignored.

 * Preparation for SHA-256 upgrade continues.

 * "git log --graph" for an octopus merge is sometimes colored
   incorrectly, which is demonstrated and documented but not yet
   fixed.

 * The trace2 output, when sending them to files in a designated
   directory, can populate the directory with too many files; a
   mechanism is introduced to set the maximum number of files and
   discard further logs when the maximum is reached.

 * We have adopted a Code-of-conduct document.
   (merge 3f9ef874a7 jk/coc later to maint).


Fixes since v2.23
-----------------

 * "git grep --recurse-submodules" that looks at the working tree
   files looked at the contents in the index in submodules, instead of
   files in the working tree.
   (merge 6a289d45c0 mt/grep-submodules-working-tree later to maint).

 * Codepaths to walk tree objects have been audited for integer
   overflows and hardened.
   (merge 5aa02f9868 jk/tree-walk-overflow later to maint).

 * "git pack-refs" can lose refs that are created while running, which
   is getting corrected.
   (merge a613d4f817 sc/pack-refs-deletion-racefix later to maint).

 * "git checkout" and "git restore" to re-populate the index from a
   tree-ish (typically HEAD) did not work correctly for a path that
   was removed and then added again with the intent-to-add bit, when
   the corresponding working tree file was empty.  This has been
   corrected.

 * Compilation fix.
   (merge 70597e8386 rs/nedalloc-fixlets later to maint).

 * "git gui" learned to call the clean-up procedure before exiting.
   (merge 0d88f3d2c5 py/git-gui-do-quit later to maint).

 * We promoted the "indent heuristics" that decides where to split
   diff hunks from experimental to the default a few years ago, but
   some stale documentation still marked it as experimental, which has
   been corrected.
   (merge 64e5e1fba1 sg/diff-indent-heuristic-non-experimental later to m=
aint).

 * Fix a mismerge that happened in 2.22 timeframe.
   (merge acb7da05ac en/checkout-mismerge-fix later to maint).

 * "git archive" recorded incorrect length in extended pax header in
   some corner cases, which has been corrected.
   (merge 71d41ff651 rs/pax-extended-header-length-fix later to maint).

 * On-demand object fetching in lazy clone incorrectly tried to fetch
   commits from submodule projects, while still working in the
   superproject, which has been corrected.
   (merge a63694f523 jt/diff-lazy-fetch-submodule-fix later to maint).

 * Prepare get_short_oid() codepath to be thread-safe.
   (merge 7cfcb16b0e rs/sort-oid-array-thread-safe later to maint).

 * "for-each-ref" and friends that show refs did not protect themselves
   against ancient tags that did not record tagger names when asked to
   show "%(taggername)", which have been corrected.
   (merge 8b3f33ef11 mp/for-each-ref-missing-name-or-email later to maint=
).

 * The "git am" based backend of "git rebase" ignored the result of
   updating ".gitattributes" done in one step when replaying
   subsequent steps.
   (merge 2c65d90f75 bc/reread-attributes-during-rebase later to maint).

 * Tell cURL library to use the same malloc() implementation, with the
   xmalloc() wrapper, as the rest of the system, for consistency.
   (merge 93b980e58f cb/curl-use-xmalloc later to maint).

 * Build fix to adjust .gitignore to unignore a path that we started to t=
rack.
   (merge aac6ff7b5b js/visual-studio later to maint).

 * A few implementation fixes in the notes API.
   (merge 60fe477a0b mh/notes-duplicate-entries later to maint).

 * Fix an earlier regression to "git push --all" which should have
   been forbidden when the target remote repository is set to be a
   mirror.
   (merge 8e4c8af058 tg/push-all-in-mirror-forbidden later to maint).

 * Fix an earlier regression in the test suite, which mistakenly
   stopped running HTTPD tests.
   (merge 3960290675 sg/git-test-boolean later to maint).

 * "git rebase --autostash <upstream> <branch>", when <branch> is
   different from the current branch, incorrectly moved the tip of the
   current branch, which has been corrected.
   (merge bf1e28e0ad bw/rebase-autostash-keep-current-branch later to mai=
nt).

 * Update support for Asciidoctor documentation toolchain.
   (merge 83b0b8953e ma/asciidoctor-refmiscinfo later to maint).

 * Start using DocBook 5 (instead of DocBook 4.5) as Asciidoctor 2.0
   no longer works with the older one.
   (merge f6461b82b9 bc/doc-use-docbook-5 later to maint).

 * The markup used in user-manual has been updated to work better with
   asciidoctor.
   (merge c4d2f6143a ma/user-manual-markup-update later to maint).

 * Make sure the grep machinery does not abort when seeing a payload
   that is not UTF-8 even when JIT is not in use with PCRE1.
   (merge ad7c543e3b cb/skip-utf8-check-with-pcre1 later to maint).

 * The name of the blob object that stores the filter specification
   for sparse cloning/fetching was interpreted in a wrong place in the
   code, causing Git to abort.

 * "git log --decorate-refs-exclude=3D<pattern>" was incorrectly
   overruled when the "--simplify-by-decoration" option is used, which
   has been corrected.
   (merge 0cc7380d88 rs/simplify-by-deco-with-deco-refs-exclude later to =
maint).

 * The "upload-pack" (the counterpart of "git fetch") needs to disable
   commit-graph when responding to a shallow clone/fetch request, but
   the way this was done made Git panic, which has been corrected.

 * The object traversal machinery has been optimized not to load tree
   objects when we are only interested in commit history.
   (merge 72ed80c784 jk/list-objects-optim-wo-trees later to maint).

 * The object name parser for "Nth parent" syntax has been made more
   robust against integer overflows.
   (merge 59fa5f5a25 rs/nth-parent-parse later to maint).

 * The code used in following tags in "git fetch" has been optimized.
   (merge b7e2d8bca5 ms/fetch-follow-tag-optim later to maint).

 * Regression fix for progress output.
   (merge 2bb74b53a4 sg/progress-fix later to maint).

 * A bug in merge-recursive code that triggers when a branch with a
   symbolic link is merged with a branch that replaces it with a
   directory has been fixed.
   (merge 83e3ad3b12 jt/merge-recursive-symlink-is-not-a-dir-in-way later=
 to maint).

 * The rename detection logic sorts a list of rename source candidates
   by similarity to pick the best candidate, which means that a tie
   between sources with the same similarity is broken by the original
   location in the original candidate list (which is sorted by path).
   Force the sorting by similarity done with a stable sort, which is
   not promised by system supplied qsort(3), to ensure consistent
   results across platforms.
   (merge 2049b8dc65 js/diff-rename-force-stable-sort later to maint).

 * The code to skip "UTF" and "UTF-" prefix, when computing an advice
   message, did not work correctly when the prefix was "UTF", which
   has been fixed.
   (merge b181676ce9 rs/convert-fix-utf-without-dash later to maint).

 * The author names taken from SVN repositories may have extra leading
   or trailing whitespaces, which are now munged away.
   (merge 4ddd4bddb1 tk/git-svn-trim-author-name later to maint).

 * "git rebase -i" showed a wrong HEAD while "reword" open the editor.
   (merge b0a3186140 pw/rebase-i-show-HEAD-to-reword later to maint).

 * A few simplification and bugfixes to PCRE interface.
   (merge c581e4a749 ab/pcre-jit-fixes later to maint).

 * PCRE fixes.
   (merge ff61681b46 cb/pcre1-cleanup later to maint).

 * "git range-diff" segfaulted when diff.noprefix configuration was
   used, as it blindly expected the patch it internally generates to
   have the standard a/ and b/ prefixes.  The command now forces the
   internal patch to be built without any prefix, not to be affected
   by any end-user configuration.
   (merge 937b76ed49 js/range-diff-noprefix later to maint).

 * "git stash apply" in a subdirectory of a secondary worktree failed
   to access the worktree correctly, which has been corrected.
   (merge dfd557c978 js/stash-apply-in-secondary-worktree later to maint)=
.

 * The merge-recursive machinery is one of the most complex parts of
   the system that accumulated cruft over time.  This large series
   cleans up the implementation quite a bit.
   (merge b657047719 en/merge-recursive-cleanup later to maint).

 * Pretty-printed command line formatter (used in e.g. reporting the
   command being run by the tracing API) had a bug that lost an
   argument that is an empty string, which has been corrected.
   (merge ce2d7ed2fd gs/sq-quote-buf-pretty later to maint).

 * "git range-diff" failed to handle mode-only change, which has been
   corrected.
   (merge 2b6a9b13ca tg/range-diff-output-update later to maint).

 * Dev support update.
   (merge 4f3c1dc5d6 dl/allow-running-cocci-verbosely later to maint).

 * "git format-patch -o <outdir>" did an equivalent of "mkdir <outdir>"
   not "mkdir -p <outdir>", which was corrected.

 * "git stash save" lost local changes to submodules, which has been
   corrected.
   (merge 556895d0c8 jj/stash-reset-only-toplevel later to maint).

 * The atomic push over smart HTTP transport did not work, which has
   been corrected.
   (merge 6f1194246a bc/smart-http-atomic-push later to maint).

 * Other code cleanup, docfix, build fix, etc.
   (merge d1387d3895 en/fast-import-merge-doc later to maint).
   (merge 1c24a54ea4 bm/repository-layout-typofix later to maint).
   (merge 415b770b88 ds/midx-expire-repack later to maint).
   (merge 19800bdc3f nd/diff-parseopt later to maint).
   (merge 58166c2e9d tg/t0021-racefix later to maint).
   (merge 7027f508c7 dl/compat-cleanup later to maint).
   (merge e770fbfeff jc/test-cleanup later to maint).
   (merge 1fd881d404 rs/trace2-dst-warning later to maint).
   (merge 7e92756751 mh/http-urlmatch-cleanup later to maint).
   (merge 9784f97321 mh/release-commit-memory-fix later to maint).
   (merge 60d198d022 tb/banned-vsprintf-namefix later to maint).
   (merge 80e3658647 rs/help-unknown-ref-does-not-return later to maint).
   (merge 0a8bc7068f dt/remote-helper-doc-re-lock-option later to maint).
   (merge 27fd1e4ea7 en/merge-options-ff-and-friends later to maint).
   (merge 502c386ff9 sg/clean-nested-repo-with-ignored later to maint).
   (merge 26e3d1cbea am/mailmap-andrey-mazo later to maint).
   (merge 47b27c96fa ss/get-time-cleanup later to maint).
   (merge dd2e50a84e jk/commit-graph-cleanup later to maint).
   (merge 4fd39c76e6 cs/pretty-formats-doc-typofix later to maint).
   (merge 40e747e89d dl/submodule-set-branch later to maint).
   (merge 689a146c91 rs/commit-graph-use-list-count later to maint).
   (merge 0eb7c37a8a js/doc-patch-text later to maint).
   (merge 4b3aa170d1 rs/nth-switch-code-simplification later to maint).
   (merge 0d4304c124 ah/doc-submodule-ignore-submodules later to maint).
   (merge af78249463 cc/svn-fe-py-shebang later to maint).
   (merge 7bd97d6dff rs/alias-use-copy-array later to maint).
   (merge c46ebc2496 sg/travis-help-debug later to maint).
   (merge 24c681794f ps/my-first-contribution-alphasort later to maint).
   (merge 75b2c15435 cb/do-not-use-test-cmp-with-a later to maint).
   (merge cda0d497e3 bw/submodule-helper-usage-fix later to maint).
   (merge fe0ed5d5e9 am/visual-studio-config-fix later to maint).
   (merge 2e09c01232 sg/name-rev-cutoff-underflow-fix later to maint).
   (merge ddb3c856f3 as/shallow-slab-use-fix later to maint).
   (merge 71f4960b91 js/mingw-spawn-with-spaces-in-path later to maint).
   (merge 53d687bf5f ah/cleanups later to maint).
   (merge f537485fa5 rs/test-remove-useless-debugging-cat later to maint)=
.
   (merge 11a3d3aadd dl/rev-list-doc-cleanup later to maint).
   (merge d928a8388a am/t0028-utf16-tests later to maint).
   (merge b05b40930e dl/t0000-skip-test-test later to maint).
   (merge 03d3b1297c js/xdiffi-comment-updates later to maint).
   (merge 57d8f4b4c7 js/doc-stash-save later to maint).
   (merge 8c1cfd58e3 ta/t1308-typofix later to maint).
   (merge fa364ad790 bb/utf8-wcwidth-cleanup later to maint).
   (merge 68b69211b2 bb/compat-util-comment-fix later to maint).
   (merge 5cc6a4be11 rs/http-push-simplify later to maint).
   (merge a81e42d235 rs/column-use-utf8-strnwidth later to maint).
   (merge 062a309d36 rs/remote-curl-use-argv-array later to maint).
   (merge 3b3c79f6c9 nr/diff-highlight-indent-fix later to maint).
   (merge 3444ec2eb2 wb/fsmonitor-bitmap-fix later to maint).
   (merge 10da030ab7 cb/pcre2-chartables-leakfix later to maint).
   (merge 60e6569a12 js/mingw-needs-hiding-fix later to maint).
   (merge 52bd3e4657 rl/gitweb-blame-prev-fix later to maint).

----------------------------------------------------------------

Changes since v2.23.0 are as follows:

Adam Roben (1):
      mingw: fix launching of externals from Unicode paths

Alessandro Menti (2):
      l10n: it.po: update the Italian translation for Git 2.24.0
      l10n: it.po: update the Italian translation for Git 2.24.0 round #2

Alex Henrie (4):
      doc: fix reference to --ignore-submodules
      commit-graph: remove a duplicate assignment
      diffcore-break: use a goto instead of a redundant if statement
      wrapper: use a loop instead of repetitive statements

Alexander Shopov (2):
      l10n: bg.po: Updated Bulgarian translation (4693)
      l10n: bg.po: Updated Bulgarian translation (4694)

Alexandr Miloslavskiy (4):
      contrib/buildsystems: fix Visual Studio Debug configuration
      t0028: fix test for UTF-16-LE-BOM
      t0028: add more tests
      t0061: fix test for argv[0] with spaces (MINGW only)

Ali Utku Selen (1):
      shallow.c: don't free unallocated slabs

Andrey Mazo (1):
      .mailmap: update email address of Andrey Mazo

Beat Bolli (3):
      grep: under --debug, show whether PCRE JIT is enabled
      utf8: use ARRAY_SIZE() in git_wcwidth()
      git-compat-util: fix documentation syntax

Ben Milman (1):
      repository-layout.txt: correct pluralization of 'object'

Ben Wijen (2):
      builtin/rebase.c: make sure the active branch isn't moved when auto=
stashing
      builtin/rebase.c: Remove pointless message

Bert Wesarg (7):
      git-gui: convert new/amend commit radiobutton to checkbutton
      git-gui: add horizontal scrollbar to commit buffer
      builtin/submodule--helper: fix usage string for 'update-clone'
      git-gui: use existing interface to query a path's attribute
      git-gui: support for diff3 conflict style
      format-patch: create leading components of output directory
      t4014: make output-directory tests self-contained

Birger Skogeng Pedersen (2):
      git-gui: add hotkeys to set widget focus
      git-gui: add hotkey to toggle "Amend Last Commit"

CB Bailey (1):
      t4038: Remove non-portable '-a' option passed to test_cmp

Cameron Steffen (1):
      doc: minor formatting fix

Carlo Marcelo Arenas Bel=C3=B3n (7):
      http: use xmalloc with cURL
      grep: make sure NO_LIBPCRE1_JIT disable JIT in PCRE1
      grep: refactor and simplify PCRE1 support
      grep: skip UTF8 checks explicitly
      grep: make PCRE1 aware of custom allocator
      grep: make PCRE2 aware of custom allocator
      grep: avoid leak of chartables in PCRE2

Christian Couder (15):
      t0410: remove pipes after git commands
      fetch-object: make functions return an error code
      Add initial support for many promisor remotes
      promisor-remote: implement promisor_remote_get_direct()
      promisor-remote: add promisor_remote_reinit()
      promisor-remote: use repository_format_partial_clone
      Use promisor_remote_get_direct() and has_promisor_remote()
      promisor-remote: parse remote.*.partialclonefilter
      builtin/fetch: remove unique promisor remote limitation
      t0410: test fetching from many promisor remotes
      partial-clone: add multiple remotes in the doc
      remote: add promisor and partial clone config to the doc
      Remove fetch-object.{c,h} in favor of promisor-remote.{c,h}
      Move repository_format_partial_clone to promisor-remote.c
      Move core_partial_clone_filter_default to promisor-remote.c

Christopher Diaz Riveros (1):
      l10n: es: 2.24.0 round 2

Cl=C3=A9ment Chigot (1):
      contrib/svn-fe: fix shebang for svnrdump_sim.py

Corentin BOMPARD (1):
      pull, fetch: add --set-upstream option

David Turner (1):
      clarify documentation for remote helpers

Denton Liu (50):
      packfile.h: drop extern from function declaration
      t4014: drop unnecessary blank lines from test cases
      t3431: add rebase --fork-point tests
      t3432: test rebase fast-forward behavior
      completion: merge options for cherry-pick and revert
      completion: add --skip for cherry-pick and revert
      status: mention --skip for revert and cherry-pick
      rebase: refactor can_fast_forward into goto tower
      rebase: fast-forward --onto in more cases
      rebase: fast-forward --fork-point in more cases
      rebase: teach rebase --keep-base
      mingw: apply array.cocci rule
      compat/*.[ch]: remove extern from function declarations using spatc=
h
      t4014: s/expected/expect/
      t4014: move closing sq onto its own line
      t4014: use sq for test case names
      t4014: remove spaces after redirect operators
      t4014: use indentable here-docs
      t4014: drop redirections to /dev/null
      t4014: let sed open its own files
      t4014: use test_line_count() where possible
      t4014: remove confusing pipe in check_threading()
      t4014: stop losing return codes of git commands
      Doc: add more detail for git-format-patch
      config/format.txt: specify default value of format.coverLetter
      t: use common $SQ variable
      completion: teach rebase to use __gitcomp_builtin
      completion: teach archive to use __gitcomp_builtin
      git-submodule.txt: fix AsciiDoc formatting error
      Makefile: strip leading ./ in $(LIB_H)
      Makefile: define THIRD_PARTY_SOURCES
      Makefile: strip leading ./ in $(FIND_SOURCE_FILES)
      Makefile: run coccicheck on more source files
      gitk: rename zh_CN.po to zh_cn.po
      promisor-remote.h: drop extern from function declaration
      apply.h: include missing header
      promisor-remote.h: include missing header
      pack-bitmap.h: remove magic number
      Makefile: emulate compile in $(HCO) target better
      test-lib: let test_merge() perform octopus merges
      t4214: use test_merge
      t4214: generate expect in their own test cases
      t4214: explicitly list tags in log
      t4214: demonstrate octopus graph coloring failure
      git-rev-list.txt: prune options in synopsis
      t4014: treat rev-list output as the expected value
      t0000: cover GIT_SKIP_TESTS blindspots
      pthread.h: manually align parameter lists
      Makefile: respect $(V) in %.cocci.patch target
      t7419: change test_must_fail to ! for grep

Derrick Stolee (17):
      repo-settings: consolidate some config settings
      t6501: use 'git gc' in quiet mode
      commit-graph: turn on commit-graph by default
      repo-settings: parse core.untrackedCache
      repo-settings: create feature.manyFiles setting
      repo-settings: create feature.experimental setting
      merge-recursive: introduce an enum for detect_directory_renames val=
ues
      checkout: add simple check for 'git checkout -b'
      fetch: add fetch.writeCommitGraph config setting
      treewide: rename 'struct exclude' to 'struct path_pattern'
      treewide: rename 'struct exclude_list' to 'struct pattern_list'
      treewide: rename 'EXCL_FLAG_' to 'PATTERN_FLAG_'
      treewide: rename 'exclude' methods to 'pattern'
      unpack-trees: rename 'is_excluded_from_list()'
      repo-settings: read an int for index.version
      t5510-fetch.sh: demonstrate fetch.writeCommitGraph bug
      commit-graph: fix writing first commit-graph during fetch

Elijah Newren (55):
      git-fast-import.txt: clarify that multiple merge commits are allowe=
d
      checkout: remove duplicate code
      merge-recursive: be consistent with assert
      checkout: provide better conflict hunk description with detached HE=
AD
      merge-recursive: enforce opt->ancestor !=3D NULL when calling merge=
_trees()
      merge-recursive: provide a better label for diff3 common ancestor
      merge-recursive: future-proof update_file_flags() against memory le=
aks
      merge-recursive: remove another implicit dependency on the_reposito=
ry
      Ensure index matches head before invoking merge machinery, round N
      merge-recursive: exit early if index !=3D head
      merge-recursive: remove useless parameter in merge_trees()
      merge-recursive: don't force external callers to do our logging
      cache-tree: share code between functions writing an index as a tree
      merge-recursive: fix some overly long lines
      merge-recursive: use common name for ancestors/common/base_list
      merge-recursive: rename 'mrtree' to 'result_tree', for clarity
      merge-recursive: rename merge_options argument to opt in header
      merge-recursive: move some definitions around to clean up the heade=
r
      merge-recursive: consolidate unnecessary fields in merge_options
      merge-recursive: comment and reorder the merge_options fields
      merge-recursive: avoid losing output and leaking memory holding tha=
t output
      merge-recursive: split internal fields into a separate struct
      merge-recursive: rename MERGE_RECURSIVE_* to MERGE_VARIANT_*
      merge-recursive: add sanity checks for relevant merge_options
      merge-recursive: alphabetize include list
      merge-options.txt: clarify meaning of various ff-related options
      t3427: accelerate this test by using fast-export and fast-import
      t6006: simplify, fix, and optimize empty message test
      Recommend git-filter-repo instead of git-filter-branch
      t9902: use a non-deprecated command for testing
      t7300: add testcases showing failure to clean specified pathspecs
      dir: fix typo in comment
      dir: fix off-by-one error in match_pathspec_item
      dir: also check directories for matching pathspecs
      dir: make the DO_MATCH_SUBMODULE code reusable for a non-submodule =
case
      dir: if our pathspec might match files under a dir, recurse into it
      dir: add commentary explaining match_pathspec_item's return value
      git-clean.txt: do not claim we will delete files with -n/--dry-run
      clean: disambiguate the definition of -d
      clean: avoid removing untracked files in a nested git repository
      clean: rewrap overly long line
      clean: fix theoretical path corruption
      fast-export: fix exporting a tag and nothing else
      dir: special case check for the possibility that pathspec is NULL
      merge-recursive: fix the diff3 common ancestor label for virtual co=
mmits
      fast-import: fix handling of deleted tags
      fast-import: allow tags to be identified by mark labels
      fast-import: add support for new 'alias' command
      fast-export: add support for --import-marks-if-exists
      fast-export: allow user to request tags be marked with --mark-tags
      t9350: add tests for tags of things other than a commit
      fast-export: handle nested tags
      merge-recursive: fix the fix to the diff3 common ancestor label
      RelNotes/2.24.0: typofix
      RelNotes/2.24.0: fix self-contradictory note

Emily Shaffer (1):
      promisor-remote: skip move_to_tail when no-op

Eric Wong (20):
      diff: use hashmap_entry_init on moved_entry.ent
      coccicheck: detect hashmap_entry.hash assignment
      packfile: use hashmap_entry in delta_base_cache_entry
      hashmap_entry_init takes "struct hashmap_entry *"
      hashmap_get_next takes "const struct hashmap_entry *"
      hashmap_add takes "struct hashmap_entry *"
      hashmap_get takes "const struct hashmap_entry *"
      hashmap_remove takes "const struct hashmap_entry *"
      hashmap_put takes "struct hashmap_entry *"
      introduce container_of macro
      hashmap_get_next returns "struct hashmap_entry *"
      hashmap: use *_entry APIs to wrap container_of
      hashmap_get{,_from_hash} return "struct hashmap_entry *"
      hashmap_cmp_fn takes hashmap_entry params
      hashmap: use *_entry APIs for iteration
      hashmap: hashmap_{put,remove} return hashmap_entry *
      hashmap: introduce hashmap_free_entries
      OFFSETOF_VAR macro to simplify hashmap iterators
      hashmap: remove type arg from hashmap_{get,put,remove}_entry
      hashmap_entry: remove first member requirement from docs

Gabriele Mazzotta (1):
      gitk: Do not mistake unchanged lines for submodule changes

Garima Singh (3):
      commit-graph: add --[no-]progress to write and verify
      commit-graph: emit trace2 cmd_mode for each sub-command
      sq_quote_buf_pretty: don't drop empty arguments

Herv=C3=A9 Beraud (1):
      hg-to-git: make it compatible with both python3 and python2

Jakob Jarmar (1):
      stash: avoid recursive hard reset on submodules

Jean-No=C3=ABl Avila (2):
      l10n: fr 2.24.0 rnd 1
      l10n: fr v2.24.0 rnd2

Jeff Hostetler (7):
      trace2: cleanup column alignment in perf target format
      trace2: trim whitespace in region messages in perf target format
      trace2: remove dead code in maybe_add_string_va()
      trace2: trim trailing whitespace in normal format error message
      quote: add sq_append_quote_argv_pretty()
      trace2: cleanup whitespace in normal format
      trace2: cleanup whitespace in perf format

Jeff King (32):
      setup_traverse_info(): stop copying oid
      tree-walk: drop oid from traverse_info
      tree-walk: use size_t consistently
      tree-walk: accept a raw length for traverse_path_len()
      tree-walk: add a strbuf wrapper for make_traverse_path()
      tree-walk: harden make_traverse_path() length computations
      revision: allow --end-of-options to end option parsing
      parse-options: allow --end-of-options as a synonym for "--"
      gitcli: document --end-of-options
      t1309: use short branch name in includeIf.onbranch test
      common-main: delay trace2 initialization
      config: stop checking whether the_repository is NULL
      t/perf: rename duplicate-numbered test script
      packfile: drop release_pack_memory()
      notes: avoid potential use-after-free during insertion
      fast-import: duplicate parsed encoding string
      fast-import: duplicate into history rather than passing ownership
      git-am: handle missing "author" when parsing commit
      pack-objects: use object_id in packlist_alloc()
      bulk-checkin: zero-initialize hashfile_checkpoint
      diff-delta: set size out-parameter to 0 for NULL delta
      test-read-cache: drop namelen variable
      pack-objects: drop packlist index_pos optimization
      commit-graph: turn off save_commit_buffer
      list-objects: don't queue root trees unless revs->tree_objects is s=
et
      commit-graph: bump DIE_ON_LOAD check to actual load-time
      upload-pack: disable commit graph more gently for shallow traversal
      list-objects-filter: delay parsing of sparse oid
      list-objects-filter: use empty string instead of NULL for sparse "b=
ase"
      git_mkstemps_mode(): replace magic numbers with computed value
      add a Code of Conduct document
      CODE_OF_CONDUCT: mention individual project-leader emails

Jiang Xin (3):
      l10n: git.pot: v2.24.0 round 1 (35 new, 16 removed)
      l10n: git.pot: v2.24.0 round 2 (1 new)
      l10n: zh_CN: for git v2.24.0 l10n round 1~2

Johannes Schindelin (46):
      Drop unused git-rebase--am.sh
      t3400: stop referring to the scripted rebase
      .gitignore: there is no longer a built-in `git-rebase--interactive`
      sequencer: the `am` and `rebase--interactive` scripts are gone
      rebase: fold git-rebase--common into the -p backend
      t3427: add a clarifying comment
      t3427: simplify the `setup` test case significantly
      t3427: move the `filter-branch` invocation into the `setup` case
      t3427: condense the unnecessarily repetitive test cases into three
      t3427: fix erroneous assumption
      t3427: accommodate for the `rebase --merge` backend having been rep=
laced
      t3427: fix another incorrect assumption
      rebase -r: support merge strategies other than `recursive`
      t/lib-rebase: prepare for testing `git rebase --rebase-merges`
      t3418: test `rebase -r` with merge strategies
      rebase -r: do not (re-)generate root commits with `--root` *and* `-=
-onto`
      setup_git_directory(): handle UNC paths correctly
      Fix .git/ discovery at the root of UNC shares
      setup_git_directory(): handle UNC root paths correctly
      .gitignore: stop ignoring `.manifest` files
      Fix build with core.autocrlf=3Dtrue
      Move git_sort(), a stable sort, into into libgit.a
      diffcore_rename(): use a stable sort
      ci: run `hdr-check` as part of the `Static Analysis` job
      range-diff: internally force `diff.noprefix=3Dtrue`
      push: do not pretend to return `int` from `die_push_simple()`
      fetch: let --jobs=3D<n> parallelize --multiple, too
      stash apply: report status correctly even in a worktree's subdirect=
ory
      msvc: avoid using minus operator on unsigned types
      winansi: use FLEX_ARRAY to avoid compiler warning
      compat/win32/path-utils.h: add #include guards
      msvc: ignore some libraries when linking
      msvc: handle DEVELOPER=3D1
      msvc: work around a bug in GetEnvironmentVariable()
      vcxproj: only copy `git-remote-http.exe` once it was built
      vcxproj: include more generated files
      test-tool run-command: learn to run (parts of) the testsuite
      tests: let --immediate and --write-junit-xml play well together
      ci: really use shallow clones on Azure Pipelines
      ci: also build and test with MS Visual Studio on Azure Pipelines
      xdiffi: fix typos and touch up comments
      doc(stash): clarify the description of `save`
      ci(visual-studio): use strict compile flags, and optimization
      ci(visual-studio): actually run the tests in parallel
      ci(osx): use new location of the `perforce` cask
      mingw: avoid a buffer overrun in `needs_hiding()`

Johannes Sixt (2):
      diff, log doc: say "patch text" instead of "patches"
      diff, log doc: small grammer, format, and language fixes

Jon Simons (2):
      t5616: test cloning/fetching with sparse:oid=3D<oid> filter
      list-objects-filter: give a more specific error sparse parsing erro=
r

Jonathan Tan (7):
      diff: skip GITLINK when lazy fetching missing objs
      transport-helper: skip ls-refs if unnecessary
      transport: teach all vtables to allow fetch first
      cache-tree: do not lazy-fetch tentative tree
      merge-recursive: symlink's descendants not in way
      send-pack: never fetch when checking exclusions
      fetch: delay fetch_if_missing=3D0 until after config

Jordi Mas (1):
      l10n: Update Catalan translation

Josh Steadmon (7):
      t7503: verify proper hook execution
      fetch: add trace2 instrumentation
      push: add trace2 instrumentation
      docs: mention trace2 target-dir mode in git-config
      docs: clarify trace2 version invariants
      trace2: discard new traces if target directory has too many files
      trace2: write discard message to sentinel files

Junio C Hamano (18):
      First batch after Git 2.23
      t: use LF variable defined in the test harness
      t3005: remove unused variable
      Second batch
      Third batch
      SubmittingPatches: git-gui has a new maintainer
      Fourth batch
      Fifth batch
      Sixth batch
      transport: push codepath can take arbitrary repository
      Seventh batch
      Eighth batch
      Ninth batch
      Git 2.24-rc0
      Eleventh batch
      Git 2.24-rc1
      Git 2.24-rc2
      Git 2.24

Kunal Tyagi (1):
      add -i: show progress counter in the prompt

Martin =C3=85gren (16):
      Documentation: wrap blocks with "--"
      git-merge-base.txt: render indentations correctly under Asciidoctor
      Documentation: wrap config listings in "----"
      git-ls-remote.txt: wrap shell listing in "----"
      git-receive-pack.txt: wrap shell [script] listing in "----"
      git-merge-index.txt: wrap shell listing in "----"
      gitweb.conf.txt: switch pluses to backticks to help Asciidoctor
      Doc/Makefile: give mansource/-version/-manual attributes
      asciidoctor-extensions: provide `<refmiscinfo/>`
      doc-diff: replace --cut-header-footer with --cut-footer
      treewide: correct several "up-to-date" to "up to date"
      user-manual.txt: add missing section label
      user-manual.txt: change header notation
      asciidoctor-extensions.rb: handle "book" doctype in linkgit
      user-manual.txt: render ASCII art correctly under Asciidoctor
      manpage-bold-literal.xsl: match for namespaced "d:literal" in templ=
ate

Masaya Suzuki (1):
      fetch: use oidset to keep the want OIDs for faster lookup

Matheus Tavares (1):
      grep: fix worktree case in submodules

Matthew DeVore (10):
      list-objects-filter: encapsulate filter components
      list-objects-filter: put omits set in filter struct
      list-objects-filter-options: always supply *errbuf
      list-objects-filter: implement composite filters
      list-objects-filter-options: move error check up
      list-objects-filter-options: make filter_spec a string_list
      strbuf: give URL-encoding API a char predicate fn
      list-objects-filter-options: allow mult. --filter
      list-objects-filter-options: clean up use of ALLOC_GROW
      list-objects-filter-options: make parser void

Matthias R=C3=BCster (1):
      l10n: de.po: Update German translation

Max Rothman (1):
      completion: add missing completions for log, diff, show

Maxim Belsky (1):
      completion: clarify installation instruction for zsh

Michael J Gruber (3):
      merge: do no-verify like commit
      git-merge: honor pre-merge-commit hook
      merge: --no-verify to bypass pre-merge-commit hook

Mike Hommey (3):
      notes: avoid leaking duplicate entries
      commit: free the right buffer in release_commit_memory
      http: don't leak urlmatch_config.vars

Mischa POSLAWSKY (1):
      ref-filter: initialize empty name or email fields

Norman Rasmussen (1):
      diff-highlight: fix a whitespace nit

Paul Mackerras (1):
      gitk: Make web links clickable

Paul Wise (1):
      gitk: Use right colour for remote refs in the "Tags and heads" dial=
og

Pedro Sousa (1):
      doc: MyFirstContribution: fix cmd placement instructions

Peter Krefting (2):
      l10n: sv.po: Update Swedish translation (4674t0f0u)
      l10n: sv.po: Update Swedish translation (4695t0f0u)

Philip.McGraw (1):
      git-p4: auto-delete named temporary file

Phillip Wood (3):
      rebase -i: always update HEAD before rewording
      rebase -i: check for updated todo after squash and reword
      sequencer: simplify root commit creation

Pratyush Yadav (7):
      git-gui: call do_quit before destroying the main window
      git-gui: allow reverting selected lines
      git-gui: allow reverting selected hunk
      git-gui: return early when patch fails to apply
      git-gui: allow undoing last revert
      Documentation: update the location of the git-gui repo
      git-gui: add a readme

Ren=C3=A9 Scharfe (28):
      nedmalloc: do assignments only after the declaration section
      nedmalloc: avoid compiler warning about unused value
      archive-tar: report wrong pax extended header length
      archive-tar: fix pax extended header length calculation
      archive-tar: use size_t in strbuf_append_ext_header()
      archive-tar: turn length miscalculation warning into BUG
      parseopt: move definition of enum parse_opt_result up
      sha1-name: make sort_ambiguous_oid_array() thread-safe
      log-tree: always use return value of strbuf_detach()
      grep: use return value of strbuf_detach()
      trace2: use warning() directly in tr2_dst_malformed_warning()
      help: make help_unknown_ref() NORETURN
      tree: simplify parse_tree_indirect()
      tag: factor out get_tagged_oid()
      use get_tagged_oid()
      log: test --decorate-refs-exclude with --simplify-by-decoration
      log-tree: call load_ref_decorations() in get_name_decoration()
      rev-parse: demonstrate overflow of N for "foo^N" and "foo~N"
      sha1-name: check for overflow of N in "foo^N" and "foo~N"
      commit-graph: use commit_list_count()
      sha1_name: simplify strbuf handling in interpret_nth_prior_checkout=
()
      git: use COPY_ARRAY and MOVE_ARRAY in handle_alias()
      treewide: remove duplicate #include directives
      convert: fix handling of dashless UTF prefix in validate_encoding()
      tests: remove "cat foo" before "test_i18ngrep bar foo"
      http-push: simplify deleting a list item
      column: use utf8_strnwidth() to strip out ANSI color escapes
      remote-curl: use argv_array in parse_push()

Robert Luberda (1):
      gitweb: correctly store previous rev in javascript-actions mode

SZEDER G=C3=A1bor (35):
      t5510-fetch: fix negated 'test_i18ngrep' invocation
      t5510-fetch: run non-httpd-specific test before sourcing 'lib-httpd=
.sh'
      t5703: run all non-httpd-specific tests before sourcing 'lib-httpd.=
sh'
      t: warn against adding non-httpd-specific tests after sourcing 'lib=
-httpd'
      t5318-commit-graph: use 'test_expect_code'
      commit-graph: turn a group of write-related macro flags into an enu=
m
      commit-graph: error out on invalid commit oids in 'write --stdin-co=
mmits'
      t0000-basic: use realistic test script names in the verbose tests
      tests: show the test name and number at the start of verbose output
      completion: fix a typo in a comment
      completion: complete more values of more 'color.*' configuration va=
riables
      completion: add tests for 'git config' completion
      completion: deduplicate configuration sections
      completion: use 'sort -u' to deduplicate config variable names
      completion: simplify inner 'case' pattern in __gitcomp()
      completion: split _git_config()
      completion: complete configuration sections and variable names for =
'git -c'
      completion: complete values of configuration variables after 'git -=
c var=3D'
      completion: complete config variables names and values for 'git clo=
ne -c'
      completion: complete config variables and values for 'git clone --c=
onfig=3D'
      worktree remove: clarify error message on dirty worktree
      diff: 'diff.indentHeuristic' is no longer experimental
      line-log: extract pathspec parsing from line ranges into a helper f=
unction
      line-log: avoid unnecessary full tree diffs
      t7300-clean: demonstrate deleting nested repo with an ignored file =
breakage
      t/lib-git-svn.sh: check GIT_TEST_SVN_HTTPD when running SVN HTTP te=
sts
      ci: restore running httpd tests
      commit-graph: don't show progress percentages while expanding reach=
able commits
      Revert "progress: use term_clear_line()"
      Test the progress display
      t/helper: ignore only executable files
      travis-ci: do not skip successfully tested trees in debug mode
      name-rev: avoid cutoff timestamp underflow
      test-progress: fix test failures on big-endian systems
      ci: fix GCC install in the Travis CI GCC OSX job

Stephen Boyd (2):
      userdiff: add a builtin pattern for dts files
      userdiff: fix some corner cases in dts regex

Stephen P. Smith (2):
      Quit passing 'now' to date code
      test_date.c: remove reference to GIT_TEST_DATE_NOW

Sun Chao (1):
      pack-refs: always refresh after taking the lock file

Tanay Abhra (1):
      t1308-config-set: fix a test that has a typo

Taylor Blau (4):
      banned.h: fix vsprintf()'s ban message
      t/t5318: introduce failing 'git commit-graph write' tests
      commit-graph.c: handle commit parsing errors
      commit-graph.c: handle corrupt/missing trees

Thomas Gummerer (6):
      t0021: make sure clean filter runs
      push: disallow --all and refspecs when remote.<name>.mirror is set
      factor out refresh_and_write_cache function
      merge: use refresh_and_write_cache
      stash: make sure to write refreshed cache
      range-diff: don't segfault with mode-only changes

Thomas Klaeger (1):
      git-gui (Windows): use git-bash.exe if it is available

Tobias Klauser (1):
      git-svn: trim leading and trailing whitespaces in author name

Torsten B=C3=B6gershausen (1):
      mingw: support UNC in git clone file://server/share/repo

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (1):
      l10n: vi(4694t): Updated translation for v2.24.0

Varun Naik (2):
      checkout.c: unstage empty deleted ita files
      restore: add test for deleted ita files

William Baker (2):
      fsmonitor: don't fill bitmap with entries to be removed
      t7519-status-fsmonitor: improve comments

YanKe (1):
      gitk: Add Chinese (zh_CN) translation

brian m. carlson (44):
      builtin/replace: make hash size independent
      patch-id: convert to use the_hash_algo
      fetch-pack: use parse_oid_hex
      builtin/receive-pack: switch to use the_hash_algo
      builtin/blame: switch uses of GIT_SHA1_HEXSZ to the_hash_algo
      builtin/rev-parse: switch to use the_hash_algo
      blame: remove needless comparison with GIT_SHA1_HEXSZ
      show-index: switch hard-coded constants to the_hash_algo
      connected: switch GIT_SHA1_HEXSZ to the_hash_algo
      bundle: switch to use the_hash_algo
      combine-diff: replace GIT_SHA1_HEXSZ with the_hash_algo
      config: use the_hash_algo in abbrev comparison
      sha1-lookup: switch hard-coded constants to the_hash_algo
      bisect: switch to using the_hash_algo
      sequencer: convert to use the_hash_algo
      pack-write: use hash_to_hex when writing checksums
      builtin/repack: write object IDs of the proper length
      builtin/worktree: switch null_sha1 to null_oid
      cache: remove null_sha1
      wt-status: convert struct wt_status to object_id
      packfile: replace sha1_to_hex
      builtin/index-pack: replace sha1_to_hex
      builtin/receive-pack: replace sha1_to_hex
      rerere: replace sha1_to_hex
      builtin/show-index: replace sha1_to_hex
      midx: switch to using the_hash_algo
      t3201: abstract away SHA-1-specific constants
      t3206: abstract away hash size constants
      t3301: abstract away SHA-1-specific constants
      t3305: make hash size independent
      t3306: abstract away SHA-1-specific constants
      t3404: abstract away SHA-1-specific constants
      t3430: avoid hard-coded object IDs
      t3506: make hash independent
      t3600: make hash size independent
      t3800: make hash-size independent
      t3903: abstract away SHA-1-specific constants
      t4000: make hash size independent
      t4002: make hash independent
      t4009: make hash size independent
      path: add a function to check for path suffix
      am: reload .gitattributes after patching it
      Documentation: fix build with Asciidoctor 2
      remote-curl: pass on atomic capability to remote side

kdnakt (1):
      git-gui: improve Japanese translation

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (20):
      log tests: test regex backends in "--encode=3D<enc>" tests
      grep: don't use PCRE2?_UTF8 with "log --encoding=3D<non-utf8>"
      t4210: skip more command-line encoding tests on MinGW
      grep: inline the return value of a function call used only once
      grep tests: move "grep binary" alongside the rest
      grep tests: move binary pattern tests into their own file
      grep: make the behavior for NUL-byte in patterns sane
      grep: drop support for \0 in --fixed-strings <pattern>
      grep: remove the kwset optimization
      grep: use PCRE v2 for optimized fixed-string search
      grep: remove overly paranoid BUG(...) code
      grep: stop "using" a custom JIT stack with PCRE v2
      grep: stop using a custom JIT stack with PCRE v1
      grep: consistently use "p->fixed" in compile_regexp()
      grep: create a "is_fixed" member in "grep_pat"
      grep: stess test PCRE v2 on invalid UTF-8 data
      grep: do not enter PCRE2_UTF mode on fixed matching
      t3432: distinguish "noop-same" v.s. "work-same" in "same head" test=
s
      t3432: test for --no-ff's interaction with fast-forward
      rebase tests: test linear branch topology

