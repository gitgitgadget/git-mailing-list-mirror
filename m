Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EC591F404
	for <e@80x24.org>; Mon, 10 Sep 2018 20:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbeIKBH2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 21:07:28 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:42525 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbeIKBH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 21:07:28 -0400
Received: by mail-wr1-f41.google.com with SMTP id v17-v6so23254108wrr.9;
        Mon, 10 Sep 2018 13:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=02L2nImLrOa48BhuLLQpXuTFDiAJM7GboG4A/lgDmSc=;
        b=kVAg6hUarZYmD4+D8w23cv1jENuWtnzUE3Nwn8oNikH4rr9SUgv2JO6GCXdd9keDOv
         w9Etaa4nRBKGhleFllxKJjC9dV2Xdvby57PVMMPjdfgXyCe5EAW/V21ywYLk6oKm7Bft
         T+Y8tT7Dr9OIkOMxnS0K3ev1Yo3Tl7I5x5z5ypPxo6FdbqN3XHLlnw8qcVM1Mwv+t68O
         0kDbhvMvvj5cMXOoLcvLV1kbMnj8JsWc2bWTk3cMyLDGAIp0hCTuhEN73BJLyCgPOgpa
         Sc8zVleu02AsKKRGajsvcnWE4H1y+RzL1Rn516/YEzas3iOtHqQUmRNgh1o4fKP2eSHm
         +8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=02L2nImLrOa48BhuLLQpXuTFDiAJM7GboG4A/lgDmSc=;
        b=KkYbSx0ibkyxSsiVFh6yh5vf4a2t06HWotWlJeHfm+/AMmkZTq+QS4f8D4nJtUYvyS
         AGbqPpYl6f5M3C2F9kz9ayTOe+C81XtqDZHguUSVLECZ/lr3bx3dBqAHohFao/Zcfxmb
         THNNU0+RSLWvEi4VNseh71ymRhnoeGuUiST8oRc8D4q0g/k7eaWFAnQ4AUiXoX8X/v/s
         rOEtxVMLGGh8L52ZViAIBVA/w4p7HXwJZhCWEpSs8/6a7YanB9Vbjf2F3cECN8KLQfLZ
         p/yyniXUX/D9jJeLUaMzNeKpq+gjQfX5QjWuacn7F4mp1vzyCZuBm0S6kvkn4bpW4NHA
         jXfQ==
X-Gm-Message-State: APzg51CdtGZHzXuuZYPDTDv6WUOOceY5jmQF1SfgOSXzGyZiCS7wMdJ6
        TN84R3SGKHhIUz23lHzM6kaOrg0h
X-Google-Smtp-Source: ANB0VdaXV3hdaxm/GrJkE6xiwLW6l1TcPAWdLu3CYU8IIdKl2oOD2f8/h2lSuJB75PtBC0wgV4pt0A==
X-Received: by 2002:a5d:5685:: with SMTP id f5-v6mr17224784wrv.58.1536610298280;
        Mon, 10 Sep 2018 13:11:38 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j191-v6sm19736115wmb.37.2018.09.10.13.11.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 13:11:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.19.0
Date:   Mon, 10 Sep 2018 13:11:37 -0700
Message-ID: <xmqqin3dru2u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest feature release Git v2.19.0 is now available at the
usual places.  It is comprised of 769 non-merge commits since
v2.18.0, contributed by 72 people, 16 of which are new faces.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.19.0'
tag and the 'master' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

New contributors whose contributions weren't in v2.18.0 are as follows.
Welcome to the Git development community!

  Aleksandr Makarov, Andrei Rybak, Chen Bin, Henning Schild,
  Isabella Stephens, Josh Steadmon, Jules Maselbas, Kana Natsuno,
  Marc Strapetz, Masaya Suzuki, Nicholas Guriev, Raphaël Hertzog,
  Samuel Maftoul, Sebastian Kisela, Vladimir Parfinenko, and
  William Chargin.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Aaron Schrab, Ævar Arnfjörð Bjarmason, Alban Gruin, Alejandro
  R. Sedeño, Alexander Shopov, Anthony Sottile, Antonio Ospite,
  Beat Bolli, Ben Peart, Brandon Williams, brian m. carlson,
  Christian Couder, Christopher Díaz Riveros, Derrick Stolee,
  Dimitriy Ryazantcev, Elia Pinto, Elijah Newren, Eric Sunshine,
  Han-Wen Nienhuys, Jameson Miller, Jean-Noël Avila, Jeff
  Hostetler, Jeff King, Jiang Xin, Johannes Schindelin, Johannes
  Sixt, Jonathan Nieder, Jonathan Tan, Junio C Hamano, Kim Gybels,
  Kirill Smelkov, Kyle Meyer, Luis Marsano, Łukasz Stelmach,
  Luke Diamand, Martin Ågren, Max Kirillov, Michael Barabanov,
  Mike Hommey, Nguyễn Thái Ngọc Duy, Olga Telezhnaya, Peter
  Krefting, Phillip Wood, Prathamesh Chavan, Ralf Thielow, Ramsay
  Jones, René Scharfe, Stefan Beller, SZEDER Gábor, Taylor Blau,
  Thomas Rast, Tobias Klauser, Todd Zullinger, Trần Ngọc Quân,
  Ville Skyttä, and Xiaolong Ye.

----------------------------------------------------------------

Git 2.19 Release Notes
======================

Updates since v2.18
-------------------

UI, Workflows & Features

 * "git diff" compares the index and the working tree.  For paths
   added with intent-to-add bit, the command shows the full contents
   of them as added, but the paths themselves were not marked as new
   files.  They are now shown as new by default.

   "git apply" learned the "--intent-to-add" option so that an
   otherwise working-tree-only application of a patch will add new
   paths to the index marked with the "intent-to-add" bit.

 * "git grep" learned the "--column" option that gives not just the
   line number but the column number of the hit.

 * The "-l" option in "git branch -l" is an unfortunate short-hand for
   "--create-reflog", but many users, both old and new, somehow expect
   it to be something else, perhaps "--list".  This step warns when "-l"
   is used as a short-hand for "--create-reflog" and warns about the
   future repurposing of the it when it is used.

 * The userdiff pattern for .php has been updated.

 * The content-transfer-encoding of the message "git send-email" sends
   out by default was 8bit, which can cause trouble when there is an
   overlong line to bust RFC 5322/2822 limit.  A new option 'auto' to
   automatically switch to quoted-printable when there is such a line
   in the payload has been introduced and is made the default.

 * "git checkout" and "git worktree add" learned to honor
   checkout.defaultRemote when auto-vivifying a local branch out of a
   remote tracking branch in a repository with multiple remotes that
   have tracking branches that share the same names.
   (merge 8d7b558bae ab/checkout-default-remote later to maint).

 * "git grep" learned the "--only-matching" option.

 * "git rebase --rebase-merges" mode now handles octopus merges as
   well.

 * Add a server-side knob to skip commits in exponential/fibbonacci
   stride in an attempt to cover wider swath of history with a smaller
   number of iterations, potentially accepting a larger packfile
   transfer, instead of going back one commit a time during common
   ancestor discovery during the "git fetch" transaction.
   (merge 42cc7485a2 jt/fetch-negotiator-skipping later to maint).

 * A new configuration variable core.usereplacerefs has been added,
   primarily to help server installations that want to ignore the
   replace mechanism altogether.

 * Teach "git tag -s" etc. a few configuration variables (gpg.format
   that can be set to "openpgp" or "x509", and gpg.<format>.program
   that is used to specify what program to use to deal with the format)
   to allow x.509 certs with CMS via "gpgsm" to be used instead of
   openpgp via "gnupg".

 * Many more strings are prepared for l10n.

 * "git p4 submit" learns to ask its own pre-submit hook if it should
   continue with submitting.

 * The test performed at the receiving end of "git push" to prevent
   bad objects from entering repository can be customized via
   receive.fsck.* configuration variables; we now have gained a
   counterpart to do the same on the "git fetch" side, with
   fetch.fsck.* configuration variables.

 * "git pull --rebase=interactive" learned "i" as a short-hand for
   "interactive".

 * "git instaweb" has been adjusted to run better with newer Apache on
   RedHat based distros.

 * "git range-diff" is a reimplementation of "git tbdiff" that lets us
   compare individual patches in two iterations of a topic.

 * The sideband code learned to optionally paint selected keywords at
   the beginning of incoming lines on the receiving end.

 * "git branch --list" learned to take the default sort order from the
   'branch.sort' configuration variable, just like "git tag --list"
   pays attention to 'tag.sort'.

 * "git worktree" command learned "--quiet" option to make it less
   verbose.


Performance, Internal Implementation, Development Support etc.

 * The bulk of "git submodule foreach" has been rewritten in C.

 * The in-core "commit" object had an all-purpose "void *util" field,
   which was tricky to use especially in library-ish part of the
   code.  All of the existing uses of the field has been migrated to a
   more dedicated "commit-slab" mechanism and the field is eliminated.

 * A less often used command "git show-index" has been modernized.
   (merge fb3010c31f jk/show-index later to maint).

 * The conversion to pass "the_repository" and then "a_repository"
   throughout the object access API continues.

 * Continuing with the idea to programatically enumerate various
   pieces of data required for command line completion, teach the
   codebase to report the list of configuration variables
   subcommands care about to help complete them.

 * Separate "rebase -p" codepath out of "rebase -i" implementation to
   slim down the latter and make it easier to manage.

 * Make refspec parsing codepath more robust.

 * Some flaky tests have been fixed.

 * Continuing with the idea to programmatically enumerate various
   pieces of data required for command line completion, the codebase
   has been taught to enumerate options prefixed with "--no-" to
   negate them.

 * Build and test procedure for netrc credential helper (in contrib/)
   has been updated.

 * Remove unused function definitions and declarations from ewah
   bitmap subsystem.

 * Code preparation to make "git p4" closer to be usable with Python 3.

 * Tighten the API to make it harder to misuse in-tree .gitmodules
   file, even though it shares the same syntax with configuration
   files, to read random configuration items from it.

 * "git fast-import" has been updated to avoid attempting to create
   delta against a zero-byte-long string, which is pointless.

 * The codebase has been updated to compile cleanly with -pedantic
   option.
   (merge 2b647a05d7 bb/pedantic later to maint).

 * The character display width table has been updated to match the
   latest Unicode standard.
   (merge 570951eea2 bb/unicode-11-width later to maint).

 * test-lint now looks for broken use of "VAR=VAL shell_func" in test
   scripts.

 * Conversion from uchar[40] to struct object_id continues.

 * Recent "security fix" to pay attention to contents of ".gitmodules"
   while accepting "git push" was a bit overly strict than necessary,
   which has been adjusted.

 * "git fsck" learns to make sure the optional commit-graph file is in
   a sane state.

 * "git diff --color-moved" feature has further been tweaked.

 * Code restructuring and a small fix to transport protocol v2 during
   fetching.

 * Parsing of -L[<N>][,[<M>]] parameters "git blame" and "git log"
   take has been tweaked.

 * lookup_commit_reference() and friends have been updated to find
   in-core object for a specific in-core repository instance.

 * Various glitches in the heuristics of merge-recursive strategy have
   been documented in new tests.

 * "git fetch" learned a new option "--negotiation-tip" to limit the
   set of commits it tells the other end as "have", to reduce wasted
   bandwidth and cycles, which would be helpful when the receiving
   repository has a lot of refs that have little to do with the
   history at the remote it is fetching from.

 * For a large tree, the index needs to hold many cache entries
   allocated on heap.  These cache entries are now allocated out of a
   dedicated memory pool to amortize malloc(3) overhead.

 * Tests to cover various conflicting cases have been added for
   merge-recursive.

 * Tests to cover conflict cases that involve submodules have been
   added for merge-recursive.

 * Look for broken "&&" chains that are hidden in subshell, many of
   which have been found and corrected.

 * The singleton commit-graph in-core instance is made per in-core
   repository instance.

 * "make DEVELOPER=1 DEVOPTS=pedantic" allows developers to compile
   with -pedantic option, which may catch more problematic program
   constructs and potential bugs.

 * Preparatory code to later add json output for telemetry data has
   been added.

 * Update the way we use Coccinelle to find out-of-style code that
   need to be modernised.

 * It is too easy to misuse system API functions such as strcat();
   these selected functions are now forbidden in this codebase and
   will cause a compilation failure.

 * Add a script (in contrib/) to help users of VSCode work better with
   our codebase.

 * The Travis CI scripts were taught to ship back the test data from
   failed tests.
   (merge aea8879a6a sg/travis-retrieve-trash-upon-failure later to maint).

 * The parse-options machinery learned to refrain from enclosing
   placeholder string inside a "<bra" and "ket>" pair automatically
   without PARSE_OPT_LITERAL_ARGHELP.  Existing help text for option
   arguments that are not formatted correctly have been identified and
   fixed.
   (merge 5f0df44cd7 rs/parse-opt-lithelp later to maint).

 * Noiseword "extern" has been removed from function decls in the
   header files.

 * A few atoms like %(objecttype) and %(objectsize) in the format
   specifier of "for-each-ref --format=<format>" can be filled without
   getting the full contents of the object, but just with the object
   header.  These cases have been optimized by calling
   oid_object_info() API (instead of reading and inspecting the data).

 * The end result of documentation update has been made to be
   inspected more easily to help developers.

 * The API to iterate over all objects learned to optionally list
   objects in the order they appear in packfiles, which helps locality
   of access if the caller accesses these objects while as objects are
   enumerated.

 * Improve built-in facility to catch broken &&-chain in the tests.

 * The more library-ish parts of the codebase learned to work on the
   in-core index-state instance that is passed in by their callers,
   instead of always working on the singleton "the_index" instance.

 * A test prerequisite defined by various test scripts with slightly
   different semantics has been consolidated into a single copy and
   made into a lazily defined one.
   (merge 6ec633059a wc/make-funnynames-shared-lazy-prereq later to maint).

 * After a partial clone, repeated fetches from promisor remote would
   have accumulated many packfiles marked with .promisor bit without
   getting them coalesced into fewer packfiles, hurting performance.
   "git repack" now learned to repack them.

 * Partially revert the support for multiple hash functions to regain
   hash comparison performance; we'd think of a way to do this better
   in the next cycle.

 * "git help --config" (which is used in command line completion)
   missed the configuration variables not described in the main
   config.txt file but are described in another file that is included
   by it, which has been corrected.

 * The test linter code has learned that the end of here-doc mark
   "EOF" can be quoted in a double-quote pair, not just in a
   single-quote pair.


Fixes since v2.18
-----------------

 * "git remote update" can take both a single remote nickname and a
   nickname for remote groups, and the completion script (in contrib/)
   has been taught about it.
   (merge 9cd4382ad5 ls/complete-remote-update-names later to maint).

 * "git fetch --shallow-since=<cutoff>" that specifies the cut-off
   point that is newer than the existing history used to end up
   grabbing the entire history.  Such a request now errors out.
   (merge e34de73c56 nd/reject-empty-shallow-request later to maint).

 * Fix for 2.17-era regression around `core.safecrlf`.
   (merge 6cb09125be as/safecrlf-quiet-fix later to maint).

 * The recent addition of "partial clone" experimental feature kicked
   in when it shouldn't, namely, when there is no partial-clone filter
   defined even if extensions.partialclone is set.
   (merge cac1137dc4 jh/partial-clone later to maint).

 * "git send-pack --signed" (hence "git push --signed" over the http
   transport) did not read user ident from the config mechanism to
   determine whom to sign the push certificate as, which has been
   corrected.
   (merge d067d98887 ms/send-pack-honor-config later to maint).

 * "git fetch-pack --all" used to unnecessarily fail upon seeing an
   annotated tag that points at an object other than a commit.
   (merge c12c9df527 jk/fetch-all-peeled-fix later to maint).

 * When user edits the patch in "git add -p" and the user's editor is
   set to strip trailing whitespaces indiscriminately, an empty line
   that is unchanged in the patch would become completely empty
   (instead of a line with a sole SP on it).  The code introduced in
   Git 2.17 timeframe failed to parse such a patch, but now it learned
   to notice the situation and cope with it.
   (merge f4d35a6b49 pw/add-p-recount later to maint).

 * The code to try seeing if a fetch is necessary in a submodule
   during a fetch with --recurse-submodules got confused when the path
   to the submodule was changed in the range of commits in the
   superproject, sometimes showing "(null)".  This has been corrected.

 * Bugfix for "rebase -i" corner case regression.
   (merge a9279c6785 pw/rebase-i-keep-reword-after-conflict later to maint).

 * Recently added "--base" option to "git format-patch" command did
   not correctly generate prereq patch ids.
   (merge 15b76c1fb3 xy/format-patch-prereq-patch-id-fix later to maint).

 * POSIX portability fix in Makefile to fix a glitch introduced a few
   releases ago.
   (merge 6600054e9b dj/runtime-prefix later to maint).

 * "git filter-branch" when used with the "--state-branch" option
   still attempted to rewrite the commits whose filtered result is
   known from the previous attempt (which is recorded on the state
   branch); the command has been corrected not to waste cycles doing
   so.
   (merge 709cfe848a mb/filter-branch-optim later to maint).

 * Clarify that setting core.ignoreCase to deviate from reality would
   not turn a case-incapable filesystem into a case-capable one.
   (merge 48294b512a ms/core-icase-doc later to maint).

 * "fsck.skipList" did not prevent a blob object listed there from
   being inspected for is contents (e.g. we recently started to
   inspect the contents of ".gitmodules" for certain malicious
   patterns), which has been corrected.
   (merge fb16287719 rj/submodule-fsck-skip later to maint).

 * "git checkout --recurse-submodules another-branch" did not report
   in which submodule it failed to update the working tree, which
   resulted in an unhelpful error message.
   (merge ba95d4e4bd sb/submodule-move-head-error-msg later to maint).

 * "git rebase" behaved slightly differently depending on which one of
   the three backends gets used; this has been documented and an
   effort to make them more uniform has begun.
   (merge b00bf1c9a8 en/rebase-consistency later to maint).

 * The "--ignore-case" option of "git for-each-ref" (and its friends)
   did not work correctly, which has been fixed.
   (merge e674eb2528 jk/for-each-ref-icase later to maint).

 * "git fetch" failed to correctly validate the set of objects it
   received when making a shallow history deeper, which has been
   corrected.
   (merge cf1e7c0770 jt/connectivity-check-after-unshallow later to maint).

 * Partial clone support of "git clone" has been updated to correctly
   validate the objects it receives from the other side.  The server
   side has been corrected to send objects that are directly
   requested, even if they may match the filtering criteria (e.g. when
   doing a "lazy blob" partial clone).
   (merge a7e67c11b8 jt/partial-clone-fsck-connectivity later to maint).

 * Handling of an empty range by "git cherry-pick" was inconsistent
   depending on how the range ended up to be empty, which has been
   corrected.
   (merge c5e358d073 jk/empty-pick-fix later to maint).

 * "git reset --merge" (hence "git merge ---abort") and "git reset --hard"
   had trouble working correctly in a sparsely checked out working
   tree after a conflict, which has been corrected.
   (merge b33fdfc34c mk/merge-in-sparse-checkout later to maint).

 * Correct a broken use of "VAR=VAL shell_func" in a test.
   (merge 650161a277 jc/t3404-one-shot-export-fix later to maint).

 * "git rev-parse ':/substring'" did not consider the history leading
   only to HEAD when looking for a commit with the given substring,
   when the HEAD is detached.  This has been fixed.
   (merge 6b3351e799 wc/find-commit-with-pattern-on-detached-head later to maint).

 * Build doc update for Windows.
   (merge ede8d89bb1 nd/command-list later to maint).

 * core.commentchar is now honored when preparing the list of commits
   to replay in "rebase -i".

 * "git pull --rebase" on a corrupt HEAD caused a segfault.  In
   general we substitute an empty tree object when running the in-core
   equivalent of the diff-index command, and the codepath has been
   corrected to do so as well to fix this issue.
   (merge 3506dc9445 jk/has-uncommitted-changes-fix later to maint).

 * httpd tests saw occasional breakage due to the way its access log
   gets inspected by the tests, which has been updated to make them
   less flaky.
   (merge e8b3b2e275 sg/httpd-test-unflake later to maint).

 * Tests to cover more D/F conflict cases have been added for
   merge-recursive.

 * "git gc --auto" opens file descriptors for the packfiles before
   spawning "git repack/prune", which would upset Windows that does
   not want a process to work on a file that is open by another
   process.  The issue has been worked around.
   (merge 12e73a3ce4 kg/gc-auto-windows-workaround later to maint).

 * The recursive merge strategy did not properly ensure there was no
   change between HEAD and the index before performing its operation,
   which has been corrected.
   (merge 55f39cf755 en/dirty-merge-fixes later to maint).

 * "git rebase" started exporting GIT_DIR environment variable and
   exposing it to hook scripts when part of it got rewritten in C.
   Instead of matching the old scripted Porcelains' behaviour,
   compensate by also exporting GIT_WORK_TREE environment as well to
   lessen the damage.  This can harm existing hooks that want to
   operate on different repository, but the current behaviour is
   already broken for them anyway.
   (merge ab5e67d751 bc/sequencer-export-work-tree-as-well later to maint).

 * "git send-email" when using in a batched mode that limits the
   number of messages sent in a single SMTP session lost the contents
   of the variable used to choose between tls/ssl, unable to send the
   second and later batches, which has been fixed.
   (merge 636f3d7ac5 jm/send-email-tls-auth-on-batch later to maint).

 * The lazy clone support had a few places where missing but promised
   objects were not correctly tolerated, which have been fixed.

 * One of the "diff --color-moved" mode "dimmed_zebra" that was named
   in an unusual way has been deprecated and replaced by
   "dimmed-zebra".
   (merge e3f2f5f9cd es/diff-color-moved-fix later to maint).

 * The wire-protocol v2 relies on the client to send "ref prefixes" to
   limit the bandwidth spent on the initial ref advertisement.  "git
   clone" when learned to speak v2 forgot to do so, which has been
   corrected.
   (merge 402c47d939 bw/clone-ref-prefixes later to maint).

 * "git diff --histogram" had a bad memory usage pattern, which has
   been rearranged to reduce the peak usage.
   (merge 79cb2ebb92 sb/histogram-less-memory later to maint).

 * Code clean-up to use size_t/ssize_t when they are the right type.
   (merge 7726d360b5 jk/size-t later to maint).

 * The wire-protocol v2 relies on the client to send "ref prefixes" to
   limit the bandwidth spent on the initial ref advertisement.  "git
   fetch $remote branch:branch" that asks tags that point into the
   history leading to the "branch" automatically followed sent to
   narrow prefix and broke the tag following, which has been fixed.
   (merge 2b554353a5 jt/tag-following-with-proto-v2-fix later to maint).

 * When the sparse checkout feature is in use, "git cherry-pick" and
   other mergy operations lost the skip_worktree bit when a path that
   is excluded from checkout requires content level merge, which is
   resolved as the same as the HEAD version, without materializing the
   merge result in the working tree, which made the path appear as
   deleted.  This has been corrected by preserving the skip_worktree
   bit (and not materializing the file in the working tree).
   (merge 2b75fb601c en/merge-recursive-skip-fix later to maint).

 * The "author-script" file "git rebase -i" creates got broken when
   we started to move the command away from shell script, which is
   getting fixed now.
   (merge 5522bbac20 es/rebase-i-author-script-fix later to maint).

 * The automatic tree-matching in "git merge -s subtree" was broken 5
   years ago and nobody has noticed since then, which is now fixed.
   (merge 2ec4150713 jk/merge-subtree-heuristics later to maint).

 * "git fetch $there refs/heads/s" ought to fetch the tip of the
   branch 's', but when "refs/heads/refs/heads/s", i.e. a branch whose
   name is "refs/heads/s" exists at the same time, fetched that one
   instead by mistake.  This has been corrected to honor the usual
   disambiguation rules for abbreviated refnames.
   (merge 60650a48c0 jt/refspec-dwim-precedence-fix later to maint).

 * Futureproofing a helper function that can easily be misused.
   (merge 65bb21e77e es/want-color-fd-defensive later to maint).

 * The http-backend (used for smart-http transport) used to slurp the
   whole input until EOF, without paying attention to CONTENT_LENGTH
   that is supplied in the environment and instead expecting the Web
   server to close the input stream.  This has been fixed.
   (merge eebfe40962 mk/http-backend-content-length later to maint).

 * "git merge --abort" etc. did not clean things up properly when
   there were conflicted entries in the index in certain order that
   are involved in D/F conflicts.  This has been corrected.
   (merge ad3762042a en/abort-df-conflict-fixes later to maint).

 * "git diff --indent-heuristic" had a bad corner case performance.
   (merge 301ef85401 sb/indent-heuristic-optim later to maint).

 * The "--exec" option to "git rebase --rebase-merges" placed the exec
   commands at wrong places, which has been corrected.

 * "git verify-tag" and "git verify-commit" have been taught to use
   the exit status of underlying "gpg --verify" to signal bad or
   untrusted signature they found.
   (merge 4e5dc9ca17 jc/gpg-status later to maint).

 * "git mergetool" stopped and gave an extra prompt to continue after
   the last path has been handled, which did not make much sense.
   (merge d651a54b8a ng/mergetool-lose-final-prompt later to maint).

 * Among the three codepaths we use O_APPEND to open a file for
   appending, one used for writing GIT_TRACE output requires O_APPEND
   implementation that behaves sensibly when multiple processes are
   writing to the same file.  POSIX emulation used in the Windows port
   has been updated to improve in this area.
   (merge d641097589 js/mingw-o-append later to maint).

 * "git pull --rebase -v" in a repository with a submodule barfed as
   an intermediate process did not understand what "-v(erbose)" flag
   meant, which has been fixed.
   (merge e84c3cf3dc sb/pull-rebase-submodule later to maint).

 * Recent update to "git config" broke updating variable in a
   subsection, which has been corrected.
   (merge bff7df7a87 sb/config-write-fix later to maint).

 * When "git rebase -i" is told to squash two or more commits into
   one, it labeled the log message for each commit with its number.
   It correctly called the first one "1st commit", but the next one
   was "commit #1", which was off-by-one.  This has been corrected.
   (merge dd2e36ebac pw/rebase-i-squash-number-fix later to maint).

 * "git rebase -i", when a 'merge <branch>' insn in its todo list
   fails, segfaulted, which has been (minimally) corrected.
   (merge bc9238bb09 pw/rebase-i-merge-segv-fix later to maint).

 * "git cherry-pick --quit" failed to remove CHERRY_PICK_HEAD even
   though we won't be in a cherry-pick session after it returns, which
   has been corrected.
   (merge 3e7dd99208 nd/cherry-pick-quit-fix later to maint).

 * In a recent update in 2.18 era, "git pack-objects" started
   producing a larger than necessary packfiles by missing
   opportunities to use large deltas.  This has been corrected.

 * The meaning of the possible values the "core.checkStat"
   configuration variable can take were not adequately documented,
   which has been fixed.
   (merge 9bf5d4c4e2 nd/config-core-checkstat-doc later to maint).

 * Recent "git rebase -i" update started to write bogusly formatted
   author-script, with a matching broken reading code.  These are
   fixed.

 * Recent addition of "directory rename" heuristics to the
   merge-recursive backend makes the command susceptible to false
   positives and false negatives.  In the context of "git am -3",
   which does not know about surrounding unmodified paths and thus
   cannot inform the merge machinery about the full trees involved,
   this risk is particularly severe.  As such, the heuristic is
   disabled for "git am -3" to keep the machinery "more stupid but
   predictable".

 * "git merge-base" in 2.19-rc1 has performance regression when the
   (experimental) commit-graph feature is in use, which has been
   mitigated.

 * Code cleanup, docfix, build fix, etc.
   (merge aee9be2ebe sg/update-ref-stdin-cleanup later to maint).
   (merge 037714252f jc/clean-after-sanity-tests later to maint).
   (merge 5b26c3c941 en/merge-recursive-cleanup later to maint).
   (merge 0dcbc0392e bw/config-refer-to-gitsubmodules-doc later to maint).
   (merge bb4d000e87 bw/protocol-v2 later to maint).
   (merge 928f0ab4ba vs/typofixes later to maint).
   (merge d7f590be84 en/rebase-i-microfixes later to maint).
   (merge 81d395cc85 js/rebase-recreate-merge later to maint).
   (merge 51d1863168 tz/exclude-doc-smallfixes later to maint).
   (merge a9aa3c0927 ds/commit-graph later to maint).
   (merge 5cf8e06474 js/enhanced-version-info later to maint).
   (merge 6aaded5509 tb/config-default later to maint).
   (merge 022d2ac1f3 sb/blame-color later to maint).
   (merge 5a06a20e0c bp/test-drop-caches-for-windows later to maint).
   (merge dd61cc1c2e jk/ui-color-always-to-auto later to maint).
   (merge 1e83b9bfdd sb/trailers-docfix later to maint).
   (merge ab29f1b329 sg/fast-import-dump-refs-on-checkpoint-fix later to maint).
   (merge 6a8ad880f0 jn/subtree-test-fixes later to maint).
   (merge ffbd51cc60 nd/pack-objects-threading-doc later to maint).
   (merge e9dac7be60 es/mw-to-git-chain-fix later to maint).
   (merge fe583c6c7a rs/remote-mv-leakfix later to maint).
   (merge 69885ab015 en/t3031-title-fix later to maint).
   (merge 8578037bed nd/config-blame-sort later to maint).
   (merge 8ad169c4ba hn/config-in-code-comment later to maint).
   (merge b7446fcfdf ar/t4150-am-scissors-test-fix later to maint).
   (merge a8132410ee js/typofixes later to maint).
   (merge 388d0ff6e5 en/update-index-doc later to maint).
   (merge e05aa688dd jc/update-index-doc later to maint).
   (merge 10c600172c sg/t5310-empty-input-fix later to maint).
   (merge 5641eb9465 jh/partial-clone-doc later to maint).
   (merge 2711b1ad5e ab/submodule-relative-url-tests later to maint).
   (merge ce528de023 ab/unconditional-free-and-null later to maint).
   (merge bbc072f5d8 rs/opt-updates later to maint).
   (merge 69d846f053 jk/use-compat-util-in-test-tool later to maint).
   (merge 1820703045 js/larger-timestamps later to maint).
   (merge c8b35b95e1 sg/t4051-fix later to maint).
   (merge 30612cb670 sg/t0020-conversion-fix later to maint).
   (merge 15da753709 sg/t7501-thinkofix later to maint).
   (merge 79b04f9b60 sg/t3903-missing-fix later to maint).
   (merge 2745817028 sg/t3420-autostash-fix later to maint).
   (merge 7afb0d6777 sg/test-rebase-editor-fix later to maint).
   (merge 6c6ce21baa es/freebsd-iconv-portability later to maint).

----------------------------------------------------------------

Changes since v2.18.0 are as follows:

Aaron Schrab (1):
      sequencer: use configured comment character

Alban Gruin (4):
      rebase: introduce a dedicated backend for --preserve-merges
      rebase: strip unused code in git-rebase--preserve-merges.sh
      rebase: use the new git-rebase--preserve-merges.sh
      rebase: remove -p code from git-rebase--interactive.sh

Alejandro R. Sedeño (1):
      Makefile: tweak sed invocation

Aleksandr Makarov (1):
      for-each-ref: consistently pass WM_IGNORECASE flag

Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (3958t)

Andrei Rybak (2):
      Documentation: fix --color option formatting
      t4150: fix broken test for am --scissors

Anthony Sottile (1):
      config.c: fix regression for core.safecrlf false

Antonio Ospite (6):
      config: move config_from_gitmodules to submodule-config.c
      submodule-config: add helper function to get 'fetch' config from .gitmodules
      submodule-config: add helper to get 'update-clone' config from .gitmodules
      submodule-config: make 'config_from_gitmodules' private
      submodule-config: pass repository as argument to config_from_gitmodules
      submodule-config: reuse config_from_gitmodules in repo_read_gitmodules

Beat Bolli (10):
      builtin/config: work around an unsized array forward declaration
      unicode: update the width tables to Unicode 11
      connect.h: avoid forward declaration of an enum
      refs/refs-internal.h: avoid forward declaration of an enum
      convert.c: replace "\e" escapes with "\033".
      sequencer.c: avoid empty statements at top level
      string-list.c: avoid conversion from void * to function pointer
      utf8.c: avoid char overflow
      Makefile: add a DEVOPTS flag to get pedantic compilation
      packfile: ensure that enum object_type is defined

Ben Peart (3):
      convert log_ref_write_fd() to use strbuf
      handle lower case drive letters on Windows
      t3507: add a testcase showing failure with sparse checkout

Brandon Williams (15):
      commit: convert commit_graft_pos() to handle arbitrary repositories
      commit: convert register_commit_graft to handle arbitrary repositories
      commit: convert read_graft_file to handle arbitrary repositories
      test-pkt-line: add unpack-sideband subcommand
      docs: link to gitsubmodules
      upload-pack: implement ref-in-want
      upload-pack: test negotiation with changing repository
      fetch: refactor the population of peer ref OIDs
      fetch: refactor fetch_refs into two functions
      fetch: refactor to make function args narrower
      fetch-pack: put shallow info in output parameter
      fetch-pack: implement ref-in-want
      clone: send ref-prefixes when using protocol v2
      fetch-pack: mark die strings for translation
      pack-protocol: mention and point to docs for protocol v2

Chen Bin (1):
      git-p4: add the `p4-pre-submit` hook

Christian Couder (1):
      t9104: kosherly remove remote refs

Christopher Díaz Riveros (1):
      l10n: es.po v2.19.0 round 2

Derrick Stolee (46):
      ref-filter: fix outdated comment on in_commit_list
      commit: add generation number to struct commit
      commit-graph: compute generation numbers
      commit: use generations in paint_down_to_common()
      commit-graph: always load commit-graph information
      ref-filter: use generation number for --contains
      commit: use generation numbers for in_merge_bases()
      commit: add short-circuit to paint_down_to_common()
      commit: use generation number in remove_redundant()
      merge: check config before loading commits
      commit-graph.txt: update design document
      commit-graph: fix UX issue when .lock file exists
      ewah/bitmap.c: delete unused 'bitmap_clear()'
      ewah/bitmap.c: delete unused 'bitmap_each_bit()'
      ewah_bitmap: delete unused 'ewah_and()'
      ewah_bitmap: delete unused 'ewah_and_not()'
      ewah_bitmap: delete unused 'ewah_not()'
      ewah_bitmap: delete unused 'ewah_or()'
      ewah_io: delete unused 'ewah_serialize()'
      t5318-commit-graph.sh: use core.commitGraph
      commit-graph: UNLEAK before die()
      commit-graph: fix GRAPH_MIN_SIZE
      commit-graph: parse commit from chosen graph
      commit: force commit to parse from object database
      commit-graph: load a root tree from specific graph
      commit-graph: add 'verify' subcommand
      commit-graph: verify catches corrupt signature
      commit-graph: verify required chunks are present
      commit-graph: verify corrupt OID fanout and lookup
      commit-graph: verify objects exist
      commit-graph: verify root tree OIDs
      commit-graph: verify parent list
      commit-graph: verify generation number
      commit-graph: verify commit date
      commit-graph: test for corrupted octopus edge
      commit-graph: verify contents match checksum
      fsck: verify commit-graph
      commit-graph: use string-list API for input
      commit-graph: add '--reachable' option
      gc: automatically write commit-graph files
      commit-graph: update design document
      commit-graph: fix documentation inconsistencies
      coccinelle: update commit.cocci
      commit: use timestamp_t for author_date_slab
      config: fix commit-graph related config docs
      commit: don't use generation numbers if not needed

Dimitriy Ryazantcev (1):
      l10n: ru.po: update Russian translation

Elia Pinto (1):
      worktree: add --quiet option

Elijah Newren (66):
      t6036, t6042: use test_create_repo to keep tests independent
      t6036, t6042: use test_line_count instead of wc -l
      t6036, t6042: prefer test_path_is_file, test_path_is_missing
      t6036, t6042: prefer test_cmp to sequences of test
      t6036: prefer test_when_finished to manual cleanup in following test
      merge-recursive: fix miscellaneous grammar error in comment
      merge-recursive: fix numerous argument alignment issues
      merge-recursive: align labels with their respective code blocks
      merge-recursive: clarify the rename_dir/RENAME_DIR meaning
      merge-recursive: rename conflict_rename_*() family of functions
      merge-recursive: add pointer about unduly complex looking code
      git-rebase.txt: document incompatible options
      git-rebase.sh: update help messages a bit
      t3422: new testcases for checking when incompatible options passed
      git-rebase: error out when incompatible options passed
      git-rebase.txt: address confusion between --no-ff vs --force-rebase
      directory-rename-detection.txt: technical docs on abilities and limitations
      git-rebase.txt: document behavioral differences between modes
      t3401: add directory rename testcases for rebase and am
      git-rebase: make --allow-empty-message the default
      t3418: add testcase showing problems with rebase -i and strategy options
      Fix use of strategy options with interactive rebases
      git-rebase--merge: modernize "git-$cmd" to "git $cmd"
      apply: fix grammar error in comment
      t5407: fix test to cover intended arguments
      read-cache.c: move index_has_changes() from merge.c
      index_has_changes(): avoid assuming operating on the_index
      t6044: verify that merges expected to abort actually abort
      t6036: add a failed conflict detection case with symlink modify/modify
      t6036: add a failed conflict detection case with symlink add/add
      t6036: add a failed conflict detection case with submodule modify/modify
      t6036: add a failed conflict detection case with submodule add/add
      t6036: add a failed conflict detection case with conflicting types
      t6042: add testcase covering rename/add/delete conflict type
      t6042: add testcase covering rename/rename(2to1)/delete/delete conflict
      t6042: add testcase covering long chains of rename conflicts
      t6036: add lots of detail for directory/file conflicts in recursive case
      t6036: add a failed conflict detection case: regular files, different modes
      t6044: add a testcase for index matching head, when head doesn't match HEAD
      merge-recursive: make sure when we say we abort that we actually abort
      merge-recursive: fix assumption that head tree being merged is HEAD
      t6044: add more testcases with staged changes before a merge is invoked
      merge-recursive: enforce rule that index matches head before merging
      merge: fix misleading pre-merge check documentation
      t7405: add a file/submodule conflict
      t7405: add a directory/submodule conflict
      t7405: verify 'merge --abort' works after submodule/path conflicts
      merge-recursive: preserve skip_worktree bit when necessary
      t1015: demonstrate directory/file conflict recovery failures
      read-cache: fix directory/file conflict handling in read_index_unmerged()
      t3031: update test description to mention desired behavior
      t7406: fix call that was failing for the wrong reason
      t7406: simplify by using diff --name-only instead of diff --raw
      t7406: avoid having git commands upstream of a pipe
      t7406: prefer test_* helper functions to test -[feds]
      t7406: avoid using test_must_fail for commands other than git
      git-update-index.txt: reword possibly confusing example
      Add missing includes and forward declarations
      alloc: make allocate_alloc_state and clear_alloc_state more consistent
      Move definition of enum branch_track from cache.h to branch.h
      urlmatch.h: fix include guard
      compat/precompose_utf8.h: use more common include guard style
      Remove forward declaration of an enum
      t3401: add another directory rename testcase for rebase and am
      merge-recursive: add ability to turn off directory rename detection
      am: avoid directory rename detection when calling recursive merge machinery

Eric Sunshine (55):
      t: use test_might_fail() instead of manipulating exit code manually
      t: use test_write_lines() instead of series of 'echo' commands
      t: use sane_unset() rather than 'unset' with broken &&-chain
      t: drop unnecessary terminating semicolon in subshell
      t/lib-submodule-update: fix "absorbing" test
      t5405: use test_must_fail() instead of checking exit code manually
      t5406: use write_script() instead of birthing shell script manually
      t5505: modernize and simplify hard-to-digest test
      t6036: fix broken "merge fails but has appropriate contents" tests
      t7201: drop pointless "exit 0" at end of subshell
      t7400: fix broken "submodule add/reconfigure --force" test
      t7810: use test_expect_code() instead of hand-rolled comparison
      t9001: fix broken "invoke hook" test
      t9814: simplify convoluted check that command correctly errors out
      t0000-t0999: fix broken &&-chains
      t1000-t1999: fix broken &&-chains
      t2000-t2999: fix broken &&-chains
      t3000-t3999: fix broken &&-chains
      t3030: fix broken &&-chains
      t4000-t4999: fix broken &&-chains
      t5000-t5999: fix broken &&-chains
      t6000-t6999: fix broken &&-chains
      t7000-t7999: fix broken &&-chains
      t9000-t9999: fix broken &&-chains
      t9119: fix broken &&-chains
      t6046/t9833: fix use of "VAR=VAL cmd" with a shell function
      t/check-non-portable-shell: stop being so polite
      t/check-non-portable-shell: make error messages more compact
      t/check-non-portable-shell: detect "FOO=bar shell_func"
      t/test-lib: teach --chain-lint to detect broken &&-chains in subshells
      t/Makefile: add machinery to check correctness of chainlint.sed
      t/chainlint: add chainlint "basic" test cases
      t/chainlint: add chainlint "whitespace" test cases
      t/chainlint: add chainlint "one-liner" test cases
      t/chainlint: add chainlint "nested subshell" test cases
      t/chainlint: add chainlint "loop" and "conditional" test cases
      t/chainlint: add chainlint "cuddled" test cases
      t/chainlint: add chainlint "complex" test cases
      t/chainlint: add chainlint "specialized" test cases
      diff: --color-moved: rename "dimmed_zebra" to "dimmed-zebra"
      mw-to-git/t9360: fix broken &&-chain
      t/chainlint.sed: drop extra spaces from regex character class
      sequencer: fix "rebase -i --root" corrupting author header
      sequencer: fix "rebase -i --root" corrupting author header timezone
      sequencer: fix "rebase -i --root" corrupting author header timestamp
      sequencer: don't die() on bogus user-edited timestamp
      color: protect against out-of-bounds reads and writes
      chainlint: match arbitrary here-docs tags rather than hard-coded names
      chainlint: match 'quoted' here-doc tags
      chainlint: recognize multi-line $(...) when command cuddled with "$("
      chainlint: let here-doc and multi-line string commence on same line
      chainlint: recognize multi-line quoted strings more robustly
      chainlint: add test of pathological case which triggered false positive
      chainlint: match "quoted" here-doc tags
      config.mak.uname: resolve FreeBSD iconv-related compilation warning

Han-Wen Nienhuys (2):
      config: document git config getter return value
      sideband: highlight keywords in remote sideband output

Henning Schild (9):
      builtin/receive-pack: use check_signature from gpg-interface
      gpg-interface: make parse_gpg_output static and remove from interface header
      gpg-interface: add new config to select how to sign a commit
      t/t7510: check the validation of the new config gpg.format
      gpg-interface: introduce an abstraction for multiple gpg formats
      gpg-interface: do not hardcode the key string len anymore
      gpg-interface: introduce new config to select per gpg format program
      gpg-interface: introduce new signature format "x509" using gpgsm
      gpg-interface t: extend the existing GPG tests with GPGSM

Isabella Stephens (2):
      blame: prevent error if range ends past end of file
      log: prevent error if line range ends past end of file

Jameson Miller (8):
      read-cache: teach refresh_cache_entry to take istate
      read-cache: teach make_cache_entry to take object_id
      block alloc: add lifecycle APIs for cache_entry structs
      mem-pool: only search head block for available space
      mem-pool: add life cycle management functions
      mem-pool: fill out functionality
      block alloc: allocate cache entries from mem_pool
      block alloc: add validations around cache_entry lifecyle

Jean-Noël Avila (3):
      i18n: fix mistakes in translated strings
      l10n: fr.po v2.19.0 rnd 1
      l10n: fr.po v2.19.0 rnd 2

Jeff Hostetler (1):
      json_writer: new routines to create JSON data

Jeff King (50):
      make show-index a builtin
      show-index: update documentation for index v2
      fetch-pack: don't try to fetch peel values with --all
      ewah: drop ewah_deserialize function
      ewah: drop ewah_serialize_native function
      t3200: unset core.logallrefupdates when testing reflog creation
      t: switch "branch -l" to "branch --create-reflog"
      branch: deprecate "-l" option
      config: turn die_on_error into caller-facing enum
      config: add CONFIG_ERROR_SILENT handler
      config: add options parameter to git_config_from_mem
      fsck: silence stderr when parsing .gitmodules
      t6300: add a test for --ignore-case
      ref-filter: avoid backend filtering with --ignore-case
      t5500: prettify non-commit tag tests
      sequencer: handle empty-set cases consistently
      sequencer: don't say BUG on bogus input
      has_uncommitted_changes(): fall back to empty tree
      fsck: split ".gitmodules too large" error from parse failure
      fsck: downgrade gitmodulesParse default to "info"
      blame: prefer xsnprintf to strcpy for colors
      check_replace_refs: fix outdated comment
      check_replace_refs: rename to read_replace_refs
      add core.usereplacerefs config option
      reencode_string: use st_add/st_mult helpers
      reencode_string: use size_t for string lengths
      strbuf: use size_t for length in intermediate variables
      strbuf_readlink: use ssize_t
      pass st.st_size as hint for strbuf_readlink()
      strbuf_humanise: use unsigned variables
      automatically ban strcpy()
      banned.h: mark strcat() as banned
      banned.h: mark sprintf() as banned
      banned.h: mark strncpy() as banned
      score_trees(): fix iteration over trees with missing entries
      add a script to diff rendered documentation
      t5552: suppress upload-pack trace output
      for_each_*_object: store flag definitions in a single location
      for_each_*_object: take flag arguments as enum
      for_each_*_object: give more comprehensive docstrings
      for_each_packed_object: support iterating in pack-order
      t1006: test cat-file --batch-all-objects with duplicates
      cat-file: rename batch_{loose,packed}_object callbacks
      cat-file: support "unordered" output for --batch-all-objects
      cat-file: use oidset check-and-insert
      cat-file: split batch "buf" into two variables
      cat-file: use a single strbuf for all output
      for_each_*_object: move declarations to object-store.h
      test-tool.h: include git-compat-util.h
      hashcmp: assert constant hash size

Jiang Xin (4):
      l10n: zh_CN: review for git 2.18.0
      l10n: git.pot: v2.19.0 round 1 (382 new, 30 removed)
      l10n: git.pot: v2.19.0 round 2 (3 new, 5 removed)
      l10n: zh_CN: for git v2.19.0 l10n round 1 to 2

Johannes Schindelin (41):
      Makefile: fix the "built from commit" code
      merge: allow reading the merge commit message from a file
      rebase --rebase-merges: add support for octopus merges
      rebase --rebase-merges: adjust man page for octopus support
      vcbuild/README: update to accommodate for missing common-cmds.h
      t7406: avoid failures solely due to timing issues
      contrib: add a script to initialize VS Code configuration
      vscode: hard-code a couple defines
      cache.h: extract enum declaration from inside a struct declaration
      mingw: define WIN32 explicitly
      vscode: only overwrite C/C++ settings
      vscode: wrap commit messages at column 72 by default
      vscode: use 8-space tabs, no trailing ws, etc for Git's source code
      vscode: add a dictionary for cSpell
      vscode: let cSpell work on commit messages, too
      pull --rebase=<type>: allow single-letter abbreviations for the type
      t3430: demonstrate what -r, --autosquash & --exec should do
      git-compat-util.h: fix typo
      remote-curl: remove spurious period
      rebase --exec: make it work with --rebase-merges
      linear-assignment: a function to solve least-cost assignment problems
      Introduce `range-diff` to compare iterations of a topic branch
      range-diff: first rudimentary implementation
      range-diff: improve the order of the shown commits
      range-diff: also show the diff between patches
      range-diff: right-trim commit messages
      range-diff: indent the diffs just like tbdiff
      range-diff: suppress the diff headers
      range-diff: adjust the output of the commit pairs
      range-diff: do not show "function names" in hunk headers
      range-diff: use color for the commit pairs
      color: add the meta color GIT_COLOR_REVERSE
      diff: add an internal option to dual-color diffs of diffs
      range-diff: offer to dual-color the diffs
      range-diff --dual-color: skip white-space warnings
      range-diff: populate the man page
      completion: support `git range-diff`
      range-diff: left-pad patch numbers
      range-diff: make --dual-color the default mode
      range-diff: use dim/bold cues to improve dual color mode
      chainlint: fix for core.autocrlf=true

Johannes Sixt (1):
      mingw: enable atomic O_APPEND

Jonathan Nieder (12):
      object: add repository argument to grow_object_hash
      object: move grafts to object parser
      commit: add repository argument to commit_graft_pos
      commit: add repository argument to register_commit_graft
      commit: add repository argument to read_graft_file
      commit: add repository argument to prepare_commit_graft
      commit: add repository argument to lookup_commit_graft
      subtree test: add missing && to &&-chain
      subtree test: simplify preparation of expected results
      doc hash-function-transition: pick SHA-256 as NewHash
      partial-clone: render design doc using asciidoc
      Revert "Merge branch 'sb/submodule-core-worktree'"

Jonathan Tan (28):
      list-objects: check if filter is NULL before using
      fetch-pack: split up everything_local()
      fetch-pack: clear marks before re-marking
      fetch-pack: directly end negotiation if ACK ready
      fetch-pack: use ref adv. to prune "have" sent
      fetch-pack: make negotiation-related vars local
      fetch-pack: move common check and marking together
      fetch-pack: introduce negotiator API
      pack-bitmap: remove bitmap_git global variable
      pack-bitmap: add free function
      fetch-pack: write shallow, then check connectivity
      fetch-pack: support negotiation tip whitelist
      upload-pack: send refs' objects despite "filter"
      clone: check connectivity even if clone is partial
      revision: tolerate promised targets of tags
      tag: don't warn if target is missing but promised
      negotiator/skipping: skip commits during fetch
      commit-graph: refactor preparing commit graph
      object-store: add missing include
      commit-graph: add missing forward declaration
      commit-graph: add free_commit_graph
      commit-graph: store graph in struct object_store
      commit-graph: add repo arg to graph readers
      t5702: test fetch with multiple refspecs at a time
      fetch: send "refs/tags/" prefix upon CLI refspecs
      fetch-pack: unify ref in and out param
      repack: refactor setup of pack-objects cmd
      repack: repack promisor objects if -a or -A is set

Josh Steadmon (1):
      protocol-v2 doc: put HTTP headers after request

Jules Maselbas (1):
      send-email: fix tls AUTH when sending batch

Junio C Hamano (23):
      tests: clean after SANITY tests
      ewah: delete unused 'rlwit_discharge_empty()'
      Prepare to start 2.19 cycle
      First batch for 2.19 cycle
      Second batch for 2.19 cycle
      fixup! connect.h: avoid forward declaration of an enum
      fixup! refs/refs-internal.h: avoid forward declaration of an enum
      t3404: fix use of "VAR=VAL cmd" with a shell function
      Third batch for 2.19 cycle
      Fourth batch for 2.19 cycle
      remote: make refspec follow the same disambiguation rule as local refs
      Fifth batch for 2.19 cycle
      update-index: there no longer is `apply --index-info`
      gpg-interface: propagate exit status from gpg back to the callers
      Sixth batch for 2.19 cycle
      config.txt: clarify core.checkStat
      Seventh batch for 2.19 cycle
      sideband: do not read beyond the end of input
      Git 2.19-rc0
      Getting ready for -rc1
      Git 2.19-rc1
      Git 2.19-rc2
      Git 2.19

Kana Natsuno (2):
      t4018: add missing test cases for PHP
      userdiff: support new keywords in PHP hunk header

Kim Gybels (1):
      gc --auto: release pack files before auto packing

Kirill Smelkov (1):
      fetch-pack: test explicitly that --all can fetch tag references pointing to non-commits

Kyle Meyer (1):
      range-diff: update stale summary of --no-dual-color

Luis Marsano (2):
      git-credential-netrc: use in-tree Git.pm for tests
      git-credential-netrc: fix exit status when tests fail

Luke Diamand (6):
      git-p4: python3: replace <> with !=
      git-p4: python3: replace dict.has_key(k) with "k in dict"
      git-p4: python3: remove backticks
      git-p4: python3: basestring workaround
      git-p4: python3: use print() function
      git-p4: python3: fix octal constants

Marc Strapetz (1):
      Documentation: declare "core.ignoreCase" as internal variable

Martin Ågren (1):
      refspec: initalize `refspec_item` in `valid_fetch_refspec()`

Masaya Suzuki (2):
      builtin/send-pack: populate the default configs
      doc: fix want-capability separator

Max Kirillov (5):
      http-backend: cleanup writing to child process
      http-backend: respect CONTENT_LENGTH as specified by rfc3875
      unpack-trees: do not fail reset because of unmerged skipped entry
      http-backend: respect CONTENT_LENGTH for receive-pack
      http-backend: allow empty CONTENT_LENGTH

Michael Barabanov (1):
      filter-branch: skip commits present on --state-branch

Mike Hommey (1):
      fast-import: do not call diff_delta() with empty buffer

Nguyễn Thái Ngọc Duy (100):
      commit-slab.h: code split
      commit-slab: support shared commit-slab
      blame: use commit-slab for blame suspects instead of commit->util
      describe: use commit-slab for commit names instead of commit->util
      shallow.c: use commit-slab for commit depth instead of commit->util
      sequencer.c: use commit-slab to mark seen commits
      sequencer.c: use commit-slab to associate todo items to commits
      revision.c: use commit-slab for show_source
      bisect.c: use commit-slab for commit weight instead of commit->util
      name-rev: use commit-slab for rev-name instead of commit->util
      show-branch: use commit-slab for commit-name instead of commit->util
      show-branch: note about its object flags usage
      log: use commit-slab in prepare_bases() instead of commit->util
      merge: use commit-slab in merge remote desc instead of commit->util
      commit.h: delete 'util' field in struct commit
      diff: ignore --ita-[in]visible-in-index when diffing worktree-to-tree
      diff: turn --ita-invisible-in-index on by default
      t2203: add a test about "diff HEAD" case
      apply: add --intent-to-add
      parse-options: option to let --git-completion-helper show negative form
      completion: suppress some -no- options
      Add and use generic name->id mapping code for color slot parsing
      grep: keep all colors in an array
      fsck: factor out msg_id_info[] lazy initialization code
      help: add --config to list all available config
      fsck: produce camelCase config key names
      advice: keep config name in camelCase in advice_config[]
      am: move advice.amWorkDir parsing back to advice.c
      completion: drop the hard coded list of config vars
      completion: keep other config var completion in camelCase
      completion: support case-insensitive config vars
      log-tree: allow to customize 'grafted' color
      completion: complete general config vars in two steps
      upload-pack: reject shallow requests that would return nothing
      completion: collapse extra --no-.. options
      pack-objects: fix performance issues on packing large deltas
      Update messages in preparation for i18n
      archive-tar.c: mark more strings for translation
      archive-zip.c: mark more strings for translation
      builtin/config.c: mark more strings for translation
      builtin/grep.c: mark strings for translation
      builtin/pack-objects.c: mark more strings for translation
      builtin/replace.c: mark more strings for translation
      commit-graph.c: mark more strings for translation
      config.c: mark more strings for translation
      connect.c: mark more strings for translation
      convert.c: mark more strings for translation
      dir.c: mark more strings for translation
      environment.c: mark more strings for translation
      exec-cmd.c: mark more strings for translation
      object.c: mark more strings for translation
      pkt-line.c: mark more strings for translation
      refs.c: mark more strings for translation
      refspec.c: mark more strings for translation
      replace-object.c: mark more strings for translation
      sequencer.c: mark more strings for translation
      sha1-file.c: mark more strings for translation
      transport.c: mark more strings for translation
      transport-helper.c: mark more strings for translation
      pack-objects: document about thread synchronization
      apply.h: drop extern on func declaration
      attr.h: drop extern from function declaration
      blame.h: drop extern on func declaration
      cache-tree.h: drop extern from function declaration
      convert.h: drop 'extern' from function declaration
      diffcore.h: drop extern from function declaration
      diff.h: remove extern from function declaration
      line-range.h: drop extern from function declaration
      rerere.h: drop extern from function declaration
      repository.h: drop extern from function declaration
      revision.h: drop extern from function declaration
      submodule.h: drop extern from function declaration
      config.txt: reorder blame stuff to keep config keys sorted
      Makefile: add missing dependency for command-list.h
      diff.c: move read_index() code back to the caller
      cache-tree: wrap the_index based wrappers with #ifdef
      attr: remove an implicit dependency on the_index
      convert.c: remove an implicit dependency on the_index
      dir.c: remove an implicit dependency on the_index in pathspec code
      preload-index.c: use the right index instead of the_index
      ls-files: correct index argument to get_convert_attr_ascii()
      unpack-trees: remove 'extern' on function declaration
      unpack-trees: add a note about path invalidation
      unpack-trees: don't shadow global var the_index
      unpack-trees: convert clear_ce_flags* to avoid the_index
      unpack-trees: avoid the_index in verify_absent()
      pathspec.c: use the right index instead of the_index
      submodule.c: use the right index instead of the_index
      entry.c: use the right index instead of the_index
      attr: remove index from git_attr_set_direction()
      grep: use the right index instead of the_index
      archive.c: avoid access to the_index
      archive-*.c: use the right repository
      resolve-undo.c: use the right index instead of the_index
      apply.c: pass struct apply_state to more functions
      apply.c: make init_apply_state() take a struct repository
      apply.c: remove implicit dependency on the_index
      blame.c: remove implicit dependency on the_index
      cherry-pick: fix --quit not deleting CHERRY_PICK_HEAD
      generate-cmdlist.sh: collect config from all config.txt files

Nicholas Guriev (1):
      mergetool: don't suggest to continue after last file

Olga Telezhnaya (5):
      ref-filter: add info_source to valid_atom
      ref-filter: fill empty fields with empty values
      ref-filter: initialize eaten variable
      ref-filter: merge get_obj and get_object
      ref-filter: use oid_object_info() to get object

Peter Krefting (2):
      l10n: sv.po: Update Swedish translation(3608t0f0u)
      l10n: sv.po: Update Swedish translation (3958t0f0u)

Phillip Wood (7):
      add -p: fix counting empty context lines in edited patches
      sequencer: do not squash 'reword' commits when we hit conflicts
      sequencer: handle errors from read_author_ident()
      sequencer: fix quoting in write_author_script
      rebase -i: fix numbering in squash message
      t3430: add conflicting commit
      rebase -i: fix SIGSEGV when 'merge <branch>' fails

Prathamesh Chavan (4):
      submodule foreach: correct '$path' in nested submodules from a subdirectory
      submodule foreach: document '$sm_path' instead of '$path'
      submodule foreach: document variable '$displaypath'
      submodule: port submodule subcommand 'foreach' from shell to C

Ralf Thielow (1):
      l10n: de.po: translate 108 new messages

Ramsay Jones (3):
      fsck: check skiplist for object in fsck_blob()
      t6036: fix broken && chain in sub-shell
      t5562: avoid non-portable "export FOO=bar" construct

Raphaël Hertzog (1):
      l10n: fr: fix a message seen in git bisect

René Scharfe (10):
      remote: clear string_list after use in mv()
      add, update-index: fix --chmod argument help
      difftool: remove angular brackets from argument help
      pack-objects: specify --index-version argument help explicitly
      send-pack: specify --force-with-lease argument help explicitly
      shortlog: correct option help for -w
      parse-options: automatically infer PARSE_OPT_LITERAL_ARGHELP
      checkout-index: improve argument help for --stage
      remote: improve argument help for add --mirror
      parseopt: group literal string alternatives in argument help

SZEDER Gábor (30):
      update-ref --stdin: use skip_prefix()
      t7510-signed-commit: use 'test_must_fail'
      tests: make forging GPG signed commits and tags more robust
      t5541: clean up truncating access log
      t/lib-httpd: add the strip_access_log() helper function
      t/lib-httpd: avoid occasional failures when checking access.log
      t5608: fix broken &&-chain
      t9300: wait for background fast-import process to die after killing it
      travis-ci: run Coccinelle static analysis with two parallel jobs
      travis-ci: fail if Coccinelle static analysis found something to transform
      coccinelle: mark the 'coccicheck' make target as .PHONY
      coccinelle: use $(addsuffix) in 'coccicheck' make target
      coccinelle: exclude sha1dc source files from static analysis
      coccinelle: put sane filenames into output patches
      coccinelle: extract dedicated make target to clean Coccinelle's results
      travis-ci: include the trash directories of failed tests in the trace log
      t5318: use 'test_cmp_bin' to compare commit-graph files
      t5318: avoid unnecessary command substitutions
      t5310-pack-bitmaps: fix bogus 'pack-objects to file can use bitmap' test
      tests: use 'test_must_be_empty' instead of '! test -s'
      tests: use 'test_must_be_empty' instead of 'test ! -s'
      tests: use 'test_must_be_empty' instead of 'test_cmp /dev/null <out>'
      tests: use 'test_must_be_empty' instead of 'test_cmp <empty> <out>'
      t7501-commit: drop silly command substitution
      t0020-crlf: check the right file
      t4051-diff-function-context: read the right file
      t6018-rev-list-glob: fix 'empty stdin' test
      t3903-stash: don't try to grep non-existing file
      t3420-rebase-autostash: don't try to grep non-existing files
      t/lib-rebase.sh: support explicit 'pick' commands in 'fake_editor.sh'

Samuel Maftoul (1):
      branch: support configuring --sort via .gitconfig

Sebastian Kisela (2):
      git-instaweb: support Fedora/Red Hat apache module path
      git-instaweb: fix apache2 config with apache >= 2.4

Stefan Beller (87):
      repository: introduce parsed objects field
      object: add repository argument to create_object
      alloc: add repository argument to alloc_blob_node
      alloc: add repository argument to alloc_tree_node
      alloc: add repository argument to alloc_commit_node
      alloc: add repository argument to alloc_tag_node
      alloc: add repository argument to alloc_object_node
      alloc: add repository argument to alloc_report
      alloc: add repository argument to alloc_commit_index
      object: allow grow_object_hash to handle arbitrary repositories
      object: allow create_object to handle arbitrary repositories
      alloc: allow arbitrary repositories for alloc functions
      object-store: move object access functions to object-store.h
      shallow: add repository argument to set_alternate_shallow_file
      shallow: add repository argument to register_shallow
      shallow: add repository argument to check_shallow_file_for_update
      shallow: add repository argument to is_repository_shallow
      cache: convert get_graft_file to handle arbitrary repositories
      path.c: migrate global git_path_* to take a repository argument
      shallow: migrate shallow information into the object parser
      commit: allow prepare_commit_graft to handle arbitrary repositories
      commit: allow lookup_commit_graft to handle arbitrary repositories
      refs/packed-backend.c: close fd of empty file
      submodule--helper: plug mem leak in print_default_remote
      sequencer.c: plug leaks in do_pick_commit
      submodule: fix NULL correctness in renamed broken submodules
      t5526: test recursive submodules when fetching moved submodules
      submodule: unset core.worktree if no working tree is present
      submodule: ensure core.worktree is set after update
      submodule deinit: unset core.worktree
      submodule.c: report the submodule that an error occurs in
      sequencer.c: plug mem leak in git_sequencer_config
      .mailmap: merge different spellings of names
      object: add repository argument to parse_object
      object: add repository argument to lookup_object
      object: add repository argument to parse_object_buffer
      object: add repository argument to object_as_type
      blob: add repository argument to lookup_blob
      tree: add repository argument to lookup_tree
      commit: add repository argument to lookup_commit_reference_gently
      commit: add repository argument to lookup_commit_reference
      commit: add repository argument to lookup_commit
      commit: add repository argument to parse_commit_buffer
      commit: add repository argument to set_commit_buffer
      commit: add repository argument to get_cached_commit_buffer
      tag: add repository argument to lookup_tag
      tag: add repository argument to parse_tag_buffer
      tag: add repository argument to deref_tag
      object: allow object_as_type to handle arbitrary repositories
      object: allow lookup_object to handle arbitrary repositories
      blob: allow lookup_blob to handle arbitrary repositories
      tree: allow lookup_tree to handle arbitrary repositories
      commit: allow lookup_commit to handle arbitrary repositories
      tag: allow lookup_tag to handle arbitrary repositories
      tag: allow parse_tag_buffer to handle arbitrary repositories
      commit.c: allow parse_commit_buffer to handle arbitrary repositories
      commit-slabs: remove realloc counter outside of slab struct
      commit.c: migrate the commit buffer to the parsed object store
      commit.c: allow set_commit_buffer to handle arbitrary repositories
      commit.c: allow get_cached_commit_buffer to handle arbitrary repositories
      object.c: allow parse_object_buffer to handle arbitrary repositories
      object.c: allow parse_object to handle arbitrary repositories
      tag.c: allow deref_tag to handle arbitrary repositories
      commit.c: allow lookup_commit_reference_gently to handle arbitrary repositories
      commit.c: allow lookup_commit_reference to handle arbitrary repositories
      xdiff/xdiff.h: remove unused flags
      xdiff/xdiffi.c: remove unneeded function declarations
      t4015: avoid git as a pipe input
      diff.c: do not pass diff options as keydata to hashmap
      diff.c: adjust hash function signature to match hashmap expectation
      diff.c: add a blocks mode for moved code detection
      diff.c: decouple white space treatment from move detection algorithm
      diff.c: factor advance_or_nullify out of mark_color_as_moved
      diff.c: add white space mode to move detection that allows indent changes
      diff.c: offer config option to control ws handling in move detection
      xdiff/xhistogram: pass arguments directly to fall_back_to_classic_diff
      xdiff/xhistogram: factor out memory cleanup into free_index()
      xdiff/xhistogram: move index allocation into find_lcs
      Documentation/git-interpret-trailers: explain possible values
      xdiff/histogram: remove tail recursion
      t1300: document current behavior of setting options
      xdiff: reduce indent heuristic overhead
      config: fix case sensitive subsection names on writing
      git-config: document accidental multi-line setting in deprecated syntax
      git-submodule.sh: accept verbose flag in cmd_update to be non-quiet
      t7410: update to new style
      builtin/submodule--helper: remove stray new line

Taylor Blau (9):
      Documentation/config.txt: camel-case lineNumber for consistency
      grep.c: expose {,inverted} match column in match_line()
      grep.[ch]: extend grep_opt to allow showing matched column
      grep.c: display column number of first match
      builtin/grep.c: add '--column' option to 'git-grep(1)'
      grep.c: add configuration variables to show matched option
      contrib/git-jump/git-jump: jump to exact location
      grep.c: extract show_line_header()
      grep.c: teach 'git grep --only-matching'

Thomas Rast (1):
      range-diff: add tests

Tobias Klauser (1):
      git-rebase--preserve-merges: fix formatting of todo help message

Todd Zullinger (4):
      git-credential-netrc: minor whitespace cleanup in test script
      git-credential-netrc: make "all" default target of Makefile
      gitignore.txt: clarify default core.excludesfile path
      dir.c: fix typos in core.excludesfile comment

Trần Ngọc Quân (1):
      l10n: vi.po(3958t): updated Vietnamese translation v2.19.0 round 2

Ville Skyttä (1):
      Documentation: spelling and grammar fixes

Vladimir Parfinenko (1):
      rebase: fix documentation formatting

William Chargin (2):
      sha1-name.c: for ":/", find detached HEAD commits
      t: factor out FUNNYNAMES as shared lazy prereq

Xiaolong Ye (1):
      format-patch: clear UNINTERESTING flag before prepare_bases

brian m. carlson (21):
      send-email: add an auto option for transfer encoding
      send-email: accept long lines with suitable transfer encoding
      send-email: automatically determine transfer-encoding
      docs: correct RFC specifying email line length
      sequencer: pass absolute GIT_WORK_TREE to exec commands
      cache: update object ID functions for the_hash_algo
      tree-walk: replace hard-coded constants with the_hash_algo
      hex: switch to using the_hash_algo
      commit: express tree entry constants in terms of the_hash_algo
      strbuf: allocate space with GIT_MAX_HEXSZ
      sha1-name: use the_hash_algo when parsing object names
      refs/files-backend: use the_hash_algo for writing refs
      builtin/update-index: convert to using the_hash_algo
      builtin/update-index: simplify parsing of cacheinfo
      builtin/fmt-merge-msg: make hash independent
      builtin/merge: switch to use the_hash_algo
      builtin/merge-recursive: make hash independent
      diff: switch GIT_SHA1_HEXSZ to use the_hash_algo
      log-tree: switch GIT_SHA1_HEXSZ to the_hash_algo->hexsz
      sha1-file: convert constants to uses of the_hash_algo
      pretty: switch hard-coded constants to the_hash_algo

Ævar Arnfjörð Bjarmason (45):
      checkout tests: index should be clean after dwim checkout
      checkout.h: wrap the arguments to unique_tracking_name()
      checkout.c: introduce an *_INIT macro
      checkout.c: change "unique" member to "num_matches"
      checkout: pass the "num_matches" up to callers
      builtin/checkout.c: use "ret" variable for return
      checkout: add advice for ambiguous "checkout <branch>"
      checkout & worktree: introduce checkout.defaultRemote
      refspec: s/refspec_item_init/&_or_die/g
      refspec: add back a refspec_item_init() function
      doc hash-function-transition: note the lack of a changelog
      receive.fsck.<msg-id> tests: remove dead code
      config doc: don't describe *.fetchObjects twice
      config doc: unify the description of fsck.* and receive.fsck.*
      config doc: elaborate on what transfer.fsckObjects does
      config doc: elaborate on fetch.fsckObjects security
      transfer.fsckObjects tests: untangle confusing setup
      fetch: implement fetch.fsck.*
      fsck: test & document {fetch,receive}.fsck.* config fallback
      fsck: add stress tests for fsck.skipList
      fsck: test and document unknown fsck.<msg-id> values
      tests: make use of the test_must_be_empty function
      tests: make use of the test_must_be_empty function
      fetch tests: change "Tag" test tag to "testTag"
      push tests: remove redundant 'git push' invocation
      push tests: fix logic error in "push" test assertion
      push tests: add more testing for forced tag pushing
      push tests: assert re-pushing annotated tags
      negotiator: unknown fetch.negotiationAlgorithm should error out
      fetch doc: cross-link two new negotiation options
      sha1dc: update from upstream
      push: use PARSE_OPT_LITERAL_ARGHELP instead of unbalanced brackets
      fetch tests: correct a comment "remove it" -> "remove them"
      pull doc: fix a long-standing grammar error
      submodule: add more exhaustive up-path testing
      refactor various if (x) FREE_AND_NULL(x) to just FREE_AND_NULL(x)
      t2024: mark test using "checkout -p" with PERL prerequisite
      tests: fix and add lint for non-portable head -c N
      tests: fix and add lint for non-portable seq
      tests: fix comment syntax in chainlint.sed for AIX sed
      tests: use shorter labels in chainlint.sed for AIX sed
      tests: fix version-specific portability issue in Perl JSON
      tests: fix and add lint for non-portable grep --file
      tests: fix non-portable "${var:-"str"}" construct
      tests: fix non-portable iconv invocation

Łukasz Stelmach (1):
      completion: complete remote names too

