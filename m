Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DC071F597
	for <e@80x24.org>; Wed, 25 Jul 2018 22:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731313AbeGYX10 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 19:27:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34170 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731174AbeGYX10 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 19:27:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id c13-v6so8793881wrt.1
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 15:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=r//6YuT+TSymatXDRY90j+8OGMxbeZha+zWApU3ydzE=;
        b=Ch8D00gLnjuC7SBFtF3L/5iLneE/D9CfsiZN1r+fbfYY20cCzX6lwfamFAlc6+9bts
         T+ad2ZMPIIQx7BjMGQKR4mgp8HC5Fq8LBkdDE4ZKl2HWl/XxQvOXkIXWCweQPI9OoJn3
         aTPRbkb3zyh9LtylzlSKIDZQq23JDHWsKhAJhuuHBmFjRlXPTPqk+2MPu3LIyuCmQCqx
         BQuaVJGgi8HpK4XUyc3gMOClKyGTR8Phr1ksIMh/LcgAvTzoh6WoQ1ZIGzjQDOlHLPdm
         /OUthY4of7gkz8K8p5jeYeSakz85zF2RqBCwSWDnUbpzH/PeKIu6+O3GXcF1n+ZhGVRN
         Zpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=r//6YuT+TSymatXDRY90j+8OGMxbeZha+zWApU3ydzE=;
        b=nYk3FCTyW9/1Muatpu70lZn30nQt3JrvFaRetbvdBQS3S7DbjoSCs4C+Eb5z8KbxzG
         lAfpxAUA6xNp408e1b+oZOG9amKEKm/gGe0YU5W+0dQBZo7QMHve3BAwuwtrsuwBMaDr
         OQELv3gZxv+OIXejrj9zcgcHpmSYI0gj69JHP/pbUgXmc+dIi0ccv7KiL7lSjfZmW4TH
         VfDc/JWPtRV4NdtdIlxgMticcIRC06S+DfWaDHehYHz50KAe9QKZ7REteA6yapn/aWv2
         0pUsh58KLLhcVGimes+PJyMLTUDrKPWFZ6cyYAOW9p8zbcYsCTD4SXK6FEYjwHy0WZad
         8ZGg==
X-Gm-Message-State: AOUpUlH1r/uizf9hv3he863AvQPQL1SrqUqsWumi4V8W274fK3LxWvKd
        1S+GFWLhSiMAqtJpM9JXH+iwduHOYbB+vA==
X-Google-Smtp-Source: AAOMgpf4WFa435aAUI9tHIVX+Nq6Iy3M8i81QGL2c9QtYTaXrDlGmlxsl7FO//8xRPuZlLlew0gA4A==
X-Received: by 2002:adf:9c12:: with SMTP id f18-v6mr15911316wrc.93.1532556818544;
        Wed, 25 Jul 2018 15:13:38 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i2-v6sm14616117wri.53.2018.07.25.15.13.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 15:13:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jul 2018, #03; Wed, 25)
X-master-at: ffc6fa0e396238de3a30623912980263b4f283ab
X-next-at: a71716f1adea8665ad1231d8d929021f562d287b
Date:   Wed, 25 Jul 2018 15:13:37 -0700
Message-ID: <xmqqd0vbt14e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

Many topics have moved to 'master' and 'next' from 'next' to 'pu'
respectively.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ag/rebase-p (2018-07-06) 1 commit
  (merged to 'next' on 2018-07-18 at c36ebba99b)
 + git-rebase--preserve-merges: fix formatting of todo help message

 The help message shown in the editor to edit todo list in "rebase -p"
 has regressed recently, which has been corrected.


* as/sequencer-customizable-comment-char (2018-07-16) 1 commit
  (merged to 'next' on 2018-07-18 at 4163e23f29)
 + sequencer: use configured comment character

 Honor core.commentchar when preparing the list of commits to replay
 in "rebase -i".


* bb/pedantic (2018-07-09) 8 commits
  (merged to 'next' on 2018-07-18 at e9d075e8ed)
 + utf8.c: avoid char overflow
 + string-list.c: avoid conversion from void * to function pointer
 + sequencer.c: avoid empty statements at top level
 + convert.c: replace "\e" escapes with "\033".
 + fixup! refs/refs-internal.h: avoid forward declaration of an enum
 + refs/refs-internal.h: avoid forward declaration of an enum
 + fixup! connect.h: avoid forward declaration of an enum
 + connect.h: avoid forward declaration of an enum
 (this branch is used by bb/make-developer-pedantic.)

 The codebase has been updated to compile cleanly with -pedantic
 option.


* bb/unicode-11-width (2018-07-09) 1 commit
  (merged to 'next' on 2018-07-18 at 075648ed37)
 + unicode: update the width tables to Unicode 11

 The character display width table has been updated to match the
 latest Unicode standard.


* bc/send-email-auto-cte (2018-07-09) 4 commits
  (merged to 'next' on 2018-07-18 at d16c2a301a)
 + docs: correct RFC specifying email line length
 + send-email: automatically determine transfer-encoding
 + send-email: accept long lines with suitable transfer encoding
 + send-email: add an auto option for transfer encoding

 The content-transfer-encoding of the message "git send-email" sends
 out by default was 8bit, which can cause trouble when there is an
 overlong line to bust RFC 5322/2822 limit.  A new option 'auto' to
 automatically switch to quoted-printable when there is such a line
 in the payload has been introduced and is made the default.


* bp/log-ref-write-fd-with-strbuf (2018-07-10) 1 commit
  (merged to 'next' on 2018-07-18 at 25a3a99528)
 + convert log_ref_write_fd() to use strbuf

 Code clean-up.


* bw/ref-in-want (2018-06-28) 8 commits
  (merged to 'next' on 2018-07-18 at 7e9f8db37c)
 + fetch-pack: implement ref-in-want
 + fetch-pack: put shallow info in output parameter
 + fetch: refactor to make function args narrower
 + fetch: refactor fetch_refs into two functions
 + fetch: refactor the population of peer ref OIDs
 + upload-pack: test negotiation with changing repository
 + upload-pack: implement ref-in-want
 + test-pkt-line: add unpack-sideband subcommand
 (this branch is used by bw/fetch-pack-i18n, jt/connectivity-check-after-unshallow, jt/partial-clone-fsck-connectivity and jt/tags-to-promised-blobs-fix.)

 Protocol v2 has been updated to allow slightly out-of-sync set of
 servers to work together to serve a single client, which would be
 useful with load-balanced servers that talk smart HTTP transport.


* en/apply-comment-fix (2018-06-28) 1 commit
  (merged to 'next' on 2018-07-18 at 31d818f17d)
 + apply: fix grammar error in comment


* en/rebase-consistency (2018-06-27) 9 commits
  (merged to 'next' on 2018-07-18 at d597206c79)
 + git-rebase: make --allow-empty-message the default
 + t3401: add directory rename testcases for rebase and am
 + git-rebase.txt: document behavioral differences between modes
 + directory-rename-detection.txt: technical docs on abilities and limitations
 + git-rebase.txt: address confusion between --no-ff vs --force-rebase
 + git-rebase: error out when incompatible options passed
 + t3422: new testcases for checking when incompatible options passed
 + git-rebase.sh: update help messages a bit
 + git-rebase.txt: document incompatible options

 "git rebase" behaved slightly differently depending on which one of
 the three backends gets used; this has been documented and an
 effort to make them more uniform has begun.


* en/t5407-rebase-m-fix (2018-06-28) 1 commit
  (merged to 'next' on 2018-07-18 at 459875daeb)
 + t5407: fix test to cover intended arguments


* es/test-lint-one-shot-export (2018-07-16) 5 commits
  (merged to 'next' on 2018-07-18 at 26a6124963)
 + t/check-non-portable-shell: detect "FOO=bar shell_func"
 + t/check-non-portable-shell: make error messages more compact
 + t/check-non-portable-shell: stop being so polite
 + t6046/t9833: fix use of "VAR=VAL cmd" with a shell function
 + Merge branch 'jc/t3404-one-shot-export-fix' into es/test-lint-one-shot-export
 (this branch uses jc/t3404-one-shot-export-fix.)

 Look for broken use of "VAR=VAL shell_func" in test scripts as part
 of test-lint.


* hs/push-cert-check-cleanup (2018-07-11) 2 commits
  (merged to 'next' on 2018-07-18 at 1ed25fbd77)
 + gpg-interface: make parse_gpg_output static and remove from interface header
 + builtin/receive-pack: use check_signature from gpg-interface
 (this branch is used by hs/gpgsm.)

 Code clean-up.


* jc/t3404-one-shot-export-fix (2018-07-12) 1 commit
  (merged to 'next' on 2018-07-18 at e15a79dca7)
 + t3404: fix use of "VAR=VAL cmd" with a shell function
 (this branch is used by es/test-lint-one-shot-export.)

 Correct a broken use of "VAR=VAL shell_func" in a test.


* jk/empty-pick-fix (2018-07-11) 2 commits
  (merged to 'next' on 2018-07-18 at 43bfa862f2)
 + sequencer: don't say BUG on bogus input
 + sequencer: handle empty-set cases consistently

 Handling of an empty range by "git cherry-pick" was inconsistent
 depending on how the range ended up to be empty, which has been
 corrected.


* jk/fetch-all-peeled-fix (2018-07-06) 1 commit
  (merged to 'next' on 2018-07-18 at d06c6f1665)
 + t5500: prettify non-commit tag tests

 Test modernization.


* jk/for-each-ref-icase (2018-07-03) 3 commits
  (merged to 'next' on 2018-07-18 at 4c86d62adb)
 + ref-filter: avoid backend filtering with --ignore-case
 + for-each-ref: consistently pass WM_IGNORECASE flag
 + t6300: add a test for --ignore-case

 The "--ignore-case" option of "git for-each-ref" (and its friends)
 did not work correctly, which has been fixed.


* jt/connectivity-check-after-unshallow (2018-07-03) 1 commit
  (merged to 'next' on 2018-07-18 at 8e7ee889c3)
 + fetch-pack: write shallow, then check connectivity
 (this branch is used by jt/partial-clone-fsck-connectivity and jt/tags-to-promised-blobs-fix; uses bw/ref-in-want; is tangled with bw/fetch-pack-i18n.)

 "git fetch" failed to correctly validate the set of objects it
 received when making a shallow history deeper, which has been
 corrected.


* jt/partial-clone-fsck-connectivity (2018-07-09) 2 commits
  (merged to 'next' on 2018-07-18 at 968fd9c9f0)
 + clone: check connectivity even if clone is partial
 + upload-pack: send refs' objects despite "filter"
 (this branch is used by jt/tags-to-promised-blobs-fix; uses bw/ref-in-want and jt/connectivity-check-after-unshallow; is tangled with bw/fetch-pack-i18n.)

 Partial clone support of "git clone" has been updated to correctly
 validate the objects it receives from the other side.  The server
 side has been corrected to send objects that are directly
 requested, even if they may match the filtering criteria (e.g. when
 doing a "lazy blob" partial clone).


* kn/userdiff-php (2018-07-06) 2 commits
  (merged to 'next' on 2018-07-18 at 9a533dc33a)
 + userdiff: support new keywords in PHP hunk header
 + t4018: add missing test cases for PHP

 The userdiff pattern for .php has been updated.


* mh/fast-import-no-diff-delta-empty (2018-07-06) 1 commit
  (merged to 'next' on 2018-07-18 at eb393871f4)
 + fast-import: do not call diff_delta() with empty buffer

 "git fast-import" has been updated to avoid attempting to create
 delta against a zero-byte-long string, which is pointless.


* mk/merge-in-sparse-checkout (2018-07-11) 1 commit
  (merged to 'next' on 2018-07-18 at d2a6d2684d)
 + unpack-trees: do not fail reset because of unmerged skipped entry

 "git reset --merge" (hence "git merge ---abort") and "git reset --hard"
 had trouble working correctly in a sparsely checked out working
 tree after a conflict, which has been corrected.


* nd/command-list (2018-07-16) 1 commit
  (merged to 'next' on 2018-07-18 at 77ed2a3914)
 + vcbuild/README: update to accommodate for missing common-cmds.h

 Build doc update for Windows.


* rj/submodule-fsck-skip (2018-07-03) 1 commit
  (merged to 'next' on 2018-07-11 at 985f88cf7e)
 + fsck: check skiplist for object in fsck_blob()

 "fsck.skipList" did not prevent a blob object listed there from
 being inspected for is contents (e.g. we recently started to
 inspect the contents of ".gitmodules" for certain malicious
 patterns), which has been corrected.


* sb/blame-color (2018-07-16) 1 commit
  (merged to 'next' on 2018-07-18 at c319268502)
 + blame: prefer xsnprintf to strcpy for colors
 (this branch is used by jk/banned-function.)

 Code clean-up.


* sb/submodule-move-head-error-msg (2018-06-25) 1 commit
  (merged to 'next' on 2018-07-18 at 9e213ad1aa)
 + submodule.c: report the submodule that an error occurs in

 "git checkout --recurse-submodules another-branch" did not report
 in which submodule it failed to update the working tree, which
 resulted in an unhelpful error message.


* tb/config-default (2018-07-06) 1 commit
  (merged to 'next' on 2018-07-18 at 7994476f6f)
 + builtin/config: work around an unsized array forward declaration

 Compilation fix.


* wc/find-commit-with-pattern-on-detached-head (2018-07-12) 1 commit
  (merged to 'next' on 2018-07-18 at 334d2420c0)
 + sha1-name.c: for ":/", find detached HEAD commits

 "git rev-parse ':/substring'" did not consider the history leading
 only to HEAD when looking for a commit with the given substring,
 when the HEAD is detached.  This has been fixed.

--------------------------------------------------
[New Topics]

* ds/commit-graph-with-grafts (2018-07-19) 8 commits
 - commit-graph: close_commit_graph before shallow walk
 - commit-graph: not compatible with uninitialized repo
 - commit-graph: not compatible with grafts
 - commit-graph: not compatible with replace objects
 - test-repository: properly init repo
 - commit-graph: update design document
 - refs.c: upgrade for_each_replace_ref to be a each_repo_ref_fn callback
 - refs.c: migrate internal ref iteration to pass thru repository argument
 (this branch uses ds/commit-graph-fsck, jt/commit-graph-per-object-store and sb/object-store-lookup; is tangled with ds/reachable.)

 The recently introduced commit-graph auxiliary data is incompatible
 with mechanisms such as replace & grafts that "breaks" immutable
 nature of the object reference relationship.  Disable optimizations
 based on its use (and updating existing commit-graph) when these
 incompatible features are in use in the repository.

 Will merge to 'next'.


* jk/core-use-replace-refs (2018-07-18) 3 commits
 - add core.usereplacerefs config option
 - check_replace_refs: rename to read_replace_refs
 - check_replace_refs: fix outdated comment

 A new configuration variable core.usereplacerefs has been added,
 primarily to help server installations that want to ignore the
 replace mechanism altogether.

 Will merge to 'next'.


* nd/i18n (2018-07-23) 23 commits
 - transport-helper.c: mark more strings for translation
 - transport.c: mark more strings for translation
 - sha1-file.c: mark more strings for translation
 - sequencer.c: mark more strings for translation
 - replace-object.c: mark more strings for translation
 - refspec.c: mark more strings for translation
 - refs.c: mark more strings for translation
 - pkt-line.c: mark more strings for translation
 - object.c: mark more strings for translation
 - exec-cmd.c: mark more strings for translation
 - environment.c: mark more strings for translation
 - dir.c: mark more strings for translation
 - convert.c: mark more strings for translation
 - connect.c: mark more strings for translation
 - config.c: mark more strings for translation
 - commit-graph.c: mark more strings for translation
 - builtin/replace.c: mark more strings for translation
 - builtin/pack-objects.c: mark more strings for translation
 - builtin/grep.c: mark strings for translation
 - builtin/config.c: mark more strings for translation
 - archive-zip.c: mark more strings for translation
 - archive-tar.c: mark more strings for translation
 - Update messages in preparation for i18n

 Many more strings are prepared for l10n.

 Will merge to 'next'.


* sb/histogram-less-memory (2018-07-23) 4 commits
 - xdiff/histogram: remove tail recursion
 - xdiff/xhistogram: move index allocation into find_lcs
 - xdiff/xhistogram: factor out memory cleanup into free_index()
 - xdiff/xhistogram: pass arguments directly to fall_back_to_classic_diff

 "git diff --histogram" had a bad memory usage pattern, which has
 been rearranged to reduce the peak usage.

 Will merge to 'next'.


* bb/make-developer-pedantic (2018-07-25) 1 commit
 - Makefile: add a DEVOPTS flag to get pedantic compilation

 "make DEVELOPER=1 DEVOPTS=pedantic" allows developers to compile
 with -pedantic option, which may catch more problematic program
 constructs and potential bugs.

 Will merge to 'next' and then to 'master'.


* bw/clone-ref-prefixes (2018-07-20) 1 commit
 - clone: send ref-prefixes when using protocol v2

 The wire-protocol v2 relies on the client to send "ref prefixes" to
 limit the bandwidth spent on the initial ref advertisement.  "git
 clone" when learned to speak v2 forgot to do so, which has been
 corrected.

 Will merge to 'next'.


* bw/fetch-pack-i18n (2018-07-23) 1 commit
 - fetch-pack: mark die strings for translation

 i18n updates.

 Will merge to 'next' and then to 'master'.


* bw/protocol-v2 (2018-07-24) 1 commit
 - pack-protocol: mention and point to docs for protocol v2

 Doc update.

 Will merge to 'next' and then to 'master'.


* ds/reachable (2018-07-20) 18 commits
 - commit-reach: use can_all_from_reach
 - commit-reach: make can_all_from_reach... linear
 - commit-reach: replace ref_newer logic
 - test-reach: test commit_contains
 - test-reach: test can_all_from_reach_with_flags
 - test-reach: test reduce_heads
 - test-reach: test get_merge_bases_many
 - test-reach: test is_descendant_of
 - test-reach: test in_merge_bases
 - test-reach: create new test tool for ref_newer
 - commit-reach: move can_all_from_reach_with_flags
 - upload-pack: generalize commit date cutoff
 - upload-pack: refactor ok_to_give_up()
 - upload-pack: make reachable() more generic
 - commit-reach: move commit_contains from ref-filter
 - commit-reach: move ref_newer from remote.c
 - commit.h: remove method declarations
 - commit-reach: move walk methods from commit.c
 (this branch uses ds/commit-graph-fsck, jt/commit-graph-per-object-store and sb/object-store-lookup; is tangled with ds/commit-graph-with-grafts.)

 The code for computing history reachability has been shuffled,
 obtained a bunch of new tests to cover them, and then being
 improved.

 Stuck in review?
 cf. <20180723203500.231932-1-jonathantanmy@google.com>
 cf. <20180723204112.233274-1-jonathantanmy@google.com>
 cf. <CAGZ79kb7tWV=cmboA+nsChAUaiC+fVVM-GBCuWfsypC+-wyaVg@mail.gmail.com>


* en/merge-recursive-skip-fix (2018-07-23) 2 commits
 - merge-recursive: preserve skip_worktree bit when necessary
 - t3507: add a testcase showing failure with sparse checkout

 When the sparse checkout feature is in use, "git cherry-pick" and
 other mergy operations lost the skip_worktree bit when a path that
 is excluded from checkout requires content level merge, which is
 resolved as the same as the HEAD version, without materializing the
 merge result in the working tree, which made the path appear as
 deleted.  This has been corrected by preserving the skip_worktree
 bit (and not materializing the file in the working tree).

 Stuck in review?
 cf. <75aa297e-4857-d92a-7041-618ff3b0b77a@gmail.com>


* es/format-patch-interdiff (2018-07-23) 6 commits
 - format-patch: allow --interdiff to apply to a lone-patch
 - log-tree: show_log: make commentary block delimiting reusable
 - interdiff: teach show_interdiff() to indent interdiff
 - format-patch: teach --interdiff to respect -v/--reroll-count
 - format-patch: add --interdiff option to embed diff in cover letter
 - format-patch: allow additional generated content in make_cover_letter()
 (this branch is used by es/format-patch-rangediff.)

 "git format-patch" learned a new "--interdiff" option to explain
 the difference between this version and the previous atttempt in
 the cover letter (or after the tree-dashes as a comment).

 Stuck in review?
 cf. <CAPig+cSuYUYSPTuKx08wcmQM-G12_-W2T4BS07fA=6grM1b8Gw@mail.gmail.com>


* es/format-patch-rangediff (2018-07-25) 10 commits
 - format-patch: allow --range-diff to apply to a lone-patch
 - format-patch: add --creation-factor tweak for --range-diff
 - format-patch: teach --range-diff to respect -v/--reroll-count
 - format-patch: extend --range-diff to accept revision range
 - format-patch: add --range-diff option to embed diff in cover letter
 - range-diff: relieve callers of low-level configuration burden
 - range-diff: publish default creation factor
 - range-diff: respect diff_option.file rather than assuming 'stdout'
 - Merge branch 'es/format-patch-interdiff' into es/format-patch-rangediff
 - Merge branch 'js/range-diff' into es/format-patch-rangediff
 (this branch uses es/format-patch-interdiff and js/range-diff.)

 "git format-patch" learned a new "--range-diff" option to explain
 the difference between this version and the previous atttempt in
 the cover letter (or after the tree-dashes as a comment).

 Need to wait for the prereq topics to solidify a bit more.


* jk/banned-function (2018-07-24) 5 commits
 - banned.h: mark strncpy() as banned
 - banned.h: mark sprintf() as banned
 - banned.h: mark strcat() as banned
 - automatically ban strcpy()
 - Merge branch 'sb/blame-color' into jk/banned-function

 It is too easy to misuse system API functions such as strcat();
 these selected functions are now forbidden in this codebase and
 will cause a compilation failure.

 Will merge to 'next'.


* jk/size-t (2018-07-24) 6 commits
 - strbuf_humanise: use unsigned variables
 - pass st.st_size as hint for strbuf_readlink()
 - strbuf_readlink: use ssize_t
 - strbuf: use size_t for length in intermediate variables
 - reencode_string: use size_t for string lengths
 - reencode_string: use st_add/st_mult helpers

 Code clean-up to use size_t/ssize_t when they are the right type.

 Will merge to 'next'.


* js/t7406-recursive-submodule-update-order-fix (2018-07-23) 1 commit
 - t7406: avoid failures solely due to timing issues

 Test fix.

 Will merge to 'next' and then to 'master'.


* js/vscode (2018-07-23) 9 commits
 - vscode: let cSpell work on commit messages, too
 - vscode: add a dictionary for cSpell
 - vscode: use 8-space tabs, no trailing ws, etc for Git's source code
 - vscode: wrap commit messages at column 72 by default
 - vscode: only overwrite C/C++ settings
 - mingw: define WIN32 explicitly
 - cache.h: extract enum declaration from inside a struct declaration
 - vscode: hard-code a couple defines
 - contrib: add a script to initialize VS Code configuration

 Add a script (in contrib/) to help users of VSCode work better with
 our codebase.

 Stuck in review?
 cf. <20180723165719.GA16420@aiede.svl.corp.google.com>
 cf. <20180723174108.GA9285@aiede.svl.corp.google.com>


* jt/tag-following-with-proto-v2-fix (2018-07-24) 2 commits
 - fetch: send "refs/tags/" prefix upon CLI refspecs
 - t5702: test fetch with multiple refspecs at a time

 The wire-protocol v2 relies on the client to send "ref prefixes" to
 limit the bandwidth spent on the initial ref advertisement.  "git
 fetch $remote branch:branch" that asks tags that point into the
 history leading to the "branch" automatically followed sent to
 narrow prefix and broke the tag following, which has been fixed.

 Will merge to 'next'.


* nd/pack-deltify-regression-fix (2018-07-23) 1 commit
 - pack-objects: fix performance issues on packing large deltas

 In a recent update in 2.18 era, "git pack-objects" started
 producing a larger than necessary packfiles by missing
 opportunities to use large deltas.

 Will merge to and cook in 'next'.


* sb/trailers-docfix (2018-07-20) 1 commit
 - Documentation/git-interpret-trailers: explain possible values

 Doc update.

 Will merge to 'next' and then to 'master'.


* sg/coccicheck-updates (2018-07-23) 5 commits
 - coccinelle: extract dedicated make target to clean Coccinelle's results
 - coccinelle: put sane filenames into output patches
 - coccinelle: exclude sha1dc source files from static analysis
 - coccinelle: use $(addsuffix) in 'coccicheck' make target
 - coccinelle: mark the 'coccicheck' make target as .PHONY

 Update the way we use Coccinelle to find out-of-style code that
 need to be modernised.

 Will merge to 'next'.


* sg/fast-import-dump-refs-on-checkpoint-fix (2018-07-20) 1 commit
 - t9300: wait for background fast-import process to die after killing it

 Test update.

 Will merge to 'next' and then to 'master'.


* sg/travis-cocci-diagnose-failure (2018-07-23) 2 commits
 - travis-ci: fail if Coccinelle static analysis found something to transform
 - travis-ci: run Coccinelle static analysis with two parallel jobs

 Update the way we run static analysis tool at TravisCI to make it
 easier to use its findings.

 Will merge to 'next' and then to 'master'.


* ab/newhash-is-sha256 (2018-07-25) 1 commit
 - doc hash-function-transition: note the lack of a changelog

 Documentation update.

 Waiting for another attempt for the second part.


* bb/redecl-enum-fix (2018-07-25) 1 commit
 - packfile: drop a repeated enum declaration

 Compilation fix.


* es/diff-color-move-fix (2018-07-25) 1 commit
 - diff: --color-moved: rename "dimmed_zebra" to "dimmed-zebra"

 One of the "diff --color-moved" mode "dimmed_zebra" that was named
 in an unusual way has been deprecated and replaced by
 "dimmed-zebra".

 Will merge to 'next' and then to 'master'.


* jh/structured-logging (2018-07-25) 25 commits
 - structured-logging: add config data facility
 - structured-logging: t0420 tests for interacitve child_summary
 - structured-logging: t0420 tests for child process detail events
 - structured-logging: add child process classification
 - structured-logging: add detail-events for child processes
 - structured-logging: add structured logging to remote-curl
 - structured-logging: t0420 tests for aux-data
 - structured-logging: add aux-data for size of sparse-checkout file
 - structured-logging: add aux-data for index size
 - structured-logging: add aux-data facility
 - structured-logging: t0420 tests for timers
 - structured-logging: add timer around preload_index
 - structured-logging: add timer around wt-status functions
 - structured-logging: add timer around do_write_index
 - structured-logging: add timer around do_read_index
 - structured-logging: add timer facility
 - structured-logging: add detail-event for lazy_init_name_hash
 - structured-logging: add detail-event facility
 - structured-logging: t0420 basic tests
 - structured-logging: set sub_command field for checkout command
 - structured-logging: set sub_command field for branch command
 - structured-logging: add session-id to log events
 - structured-logging: add structured logging framework
 - structured-logging: add STRUCTURED_LOGGING=1 to Makefile
 - structured-logging: design document
 (this branch uses jh/json-writer.)

 X-Gah.

--------------------------------------------------
[Stalled]

* pw/add-p-select (2018-03-16) 3 commits
 - add -p: optimize line selection for short hunks
 - add -p: allow line selection to be inverted
 - add -p: select individual hunk lines

 "git add -p" interactive interface learned to let users choose
 individual added/removed lines to be used in the operation, instead
 of accepting or rejecting a whole hunk.

 Expecting a reroll to reignite the discussion.
 cf. <9895c7b7-eac4-28c1-90c6-443acd1131b7@talktalk.net>


* hn/bisect-first-parent (2018-04-21) 1 commit
 - bisect: create 'bisect_flags' parameter in find_bisection()

 Preliminary code update to allow passing more flags down the
 bisection codepath in the future.

 We do not add random code that does not have real users to our
 codebase, so let's have it wait until such a real code materializes
 before too long.


* av/fsmonitor-updates (2018-01-04) 6 commits
 - fsmonitor: use fsmonitor data in `git diff`
 - fsmonitor: remove debugging lines from t/t7519-status-fsmonitor.sh
 - fsmonitor: make output of test-dump-fsmonitor more concise
 - fsmonitor: update helper tool, now that flags are filled later
 - fsmonitor: stop inline'ing mark_fsmonitor_valid / _invalid
 - dir.c: update comments to match argument name

 Code clean-up on fsmonitor integration, plus optional utilization
 of the fsmonitor data in diff-files.

 Waiting for an update.
 cf. <alpine.DEB.2.21.1.1801042335130.32@MININT-6BKU6QN.europe.corp.microsoft.com>


* pb/bisect-helper-2 (2018-07-23) 8 commits
 - t6030: make various test to pass GETTEXT_POISON tests
 - bisect--helper: `bisect_start` shell function partially in C
 - bisect--helper: `get_terms` & `bisect_terms` shell function in C
 - bisect--helper: `bisect_next_check` shell function in C
 - bisect--helper: `check_and_set_terms` shell function in C
 - wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
 - bisect--helper: `bisect_write` shell function in C
 - bisect--helper: `bisect_reset` shell function in C

 Expecting a reroll.
 cf. <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>

 I just rebased the topic to a newer base as it did not build
 standalone with the base I originally queued the topic on, but
 otherwise there is no update to address any of the review comments
 in the thread above---we are still waiting for a reroll.


* mk/http-backend-content-length (2018-06-11) 3 commits
 - http-backend: respect CONTENT_LENGTH for receive-pack
 - http-backend: respect CONTENT_LENGTH as specified by rfc3875
 - http-backend: cleanup writing to child process

 The http-backend (used for smart-http transport) used to slurp the
 whole input until EOF, without paying attention to CONTENT_LENGTH
 that is supplied in the environment and instead expecting the Web
 server to close the input stream.  This has been fixed.


* jk/drop-ancient-curl (2017-08-09) 5 commits
 - http: #error on too-old curl
 - curl: remove ifdef'd code never used with curl >=7.19.4
 - http: drop support for curl < 7.19.4
 - http: drop support for curl < 7.16.0
 - http: drop support for curl < 7.11.1

 Some code in http.c that has bitrot is being removed.

 Expecting a reroll.


* mk/use-size-t-in-zlib (2017-08-10) 1 commit
 . zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

 Needs resurrecting by making sure the fix is good and still applies
 (or adjusted to today's codebase).

--------------------------------------------------
[Cooking]

* am/sequencer-author-script-fix (2018-07-18) 1 commit
 - sequencer.c: terminate the last line of author-script properly

 The author-script that records the author information created by
 the sequencer machinery lacked the closing single quote on the last
 entry.

 Fixing this alone may or may not break the reader that may have
 been compensating for this bogus writer.  I think I saw another fix
 to the same source file posted today---if we are fixing, we should
 fix them all at the same time to keep the reader and the writer in
 sync.


* bc/sequencer-export-work-tree-as-well (2018-07-16) 1 commit
  (merged to 'next' on 2018-07-24 at 0b83ade721)
 + sequencer: pass absolute GIT_WORK_TREE to exec commands

 "git rebase" started exporting GIT_DIR environment variable and
 exposing it to hook scripts when part of it got rewritten in C.
 Instead of matching the old scripted Porcelains' behaviour,
 compensate by also exporting GIT_WORK_TREE environment as well to
 lessen the damage.  This can harm existing hooks that want to
 operate on different repository, but the current behaviour is
 already broken for them anyway.

 Will merge to 'master'.


* bp/test-drop-caches-for-windows (2018-07-12) 1 commit
  (merged to 'next' on 2018-07-24 at 257bb336c6)
 + handle lower case drive letters on Windows

 A test helper update for Windows.

 Will merge to 'master'.


* en/abort-df-conflict-fixes (2018-07-16) 2 commits
 - read-cache: fix directory/file conflict handling in read_index_unmerged()
 - t1015: demonstrate directory/file conflict recovery failures

 "git merge --abort" etc. did not clean things up properly when
 there were conflicted entries in certain order that are involved
 in D/F conflicts.  This has been corrected.

 This may have to be rebased on an older maintenance track before
 moving forward.


* es/chain-lint-in-subshell (2018-07-17) 10 commits
  (merged to 'next' on 2018-07-24 at 9370bbdfaf)
 + t/chainlint: add chainlint "specialized" test cases
 + t/chainlint: add chainlint "complex" test cases
 + t/chainlint: add chainlint "cuddled" test cases
 + t/chainlint: add chainlint "loop" and "conditional" test cases
 + t/chainlint: add chainlint "nested subshell" test cases
 + t/chainlint: add chainlint "one-liner" test cases
 + t/chainlint: add chainlint "whitespace" test cases
 + t/chainlint: add chainlint "basic" test cases
 + t/Makefile: add machinery to check correctness of chainlint.sed
 + t/test-lib: teach --chain-lint to detect broken &&-chains in subshells
 (this branch uses es/test-fixes.)

 Look for broken "&&" chains that are hidden in subshell, many of
 which have been found and corrected.

 Will merge to 'master'.


* hs/gpgsm (2018-07-20) 7 commits
 - gpg-interface t: extend the existing GPG tests with GPGSM
 - gpg-interface: introduce new signature format "x509" using gpgsm
 - gpg-interface: introduce new config to select per gpg format program
 - gpg-interface: do not hardcode the key string len anymore
 - gpg-interface: introduce an abstraction for multiple gpg formats
 - t/t7510: check the validation of the new config gpg.format
 - gpg-interface: add new config to select how to sign a commit

 Teach "git tag -s" etc. a few configuration varaibles (gpg.format
 that can be set to "openpgp" or "x509", and gpg.<format>.program
 that is used to specify what program to use to deal with the format)
 to allow x.509 certs with CMS via "gpgsm" to be used instead of
 openpgp via "gnupg".

 Will merge to 'next'.


* jk/has-uncommitted-changes-fix (2018-07-11) 1 commit
  (merged to 'next' on 2018-07-24 at 2ea14c0afb)
 + has_uncommitted_changes(): fall back to empty tree

 "git pull --rebase" on a corrupt HEAD caused a segfault.  In
 general we substitute an empty tree object when running the in-core
 equivalent of the diff-index command, and the codepath has been
 corrected to do so as well to fix this issue.

 Will merge to 'master'.


* jm/send-email-tls-auth-on-batch (2018-07-16) 1 commit
  (merged to 'next' on 2018-07-24 at fb3e653f44)
 + send-email: fix tls AUTH when sending batch

 "git send-email" when using in a batched mode that limits the
 number of messages sent in a single SMTP session lost the contents
 of the variable used to choose between tls/ssl, unable to send the
 second and later batches, which has been fixed.

 Will merge to 'master'.

 This is marked to be merged to 'next' already, but I do not mind
 getting an updated version with an improved log message before that
 happens.


* jn/gc-auto (2018-07-17) 3 commits
 - gc: do not return error for prior errors in daemonized mode
 - gc: exit with status 128 on failure
 - gc: improve handling of errors reading gc.log

 "gc --auto" ended up calling exit(-1) upon error, which has been
 corrected to use exit(1).  Also the error reporting behaviour when
 daemonized has been updated to exit with zero status when stopping
 due to a previously discovered error (which implies there is no
 point running gc to improve the situation); we used to exit with
 failure in such a case.

 Stuck in review?
 cf. <20180717201348.GD26218@sigill.intra.peff.net>


* js/rebase-merge-octopus (2018-07-11) 3 commits
  (merged to 'next' on 2018-07-24 at 14ad8699de)
 + rebase --rebase-merges: adjust man page for octopus support
 + rebase --rebase-merges: add support for octopus merges
 + merge: allow reading the merge commit message from a file

 "git rebase --rebase-merges" mode now handles octopus merges as
 well.

 Will merge to 'master'.


* jt/fetch-negotiator-skipping (2018-07-16) 1 commit
  (merged to 'next' on 2018-07-24 at 8e25a49405)
 + negotiator/skipping: skip commits during fetch
 (this branch uses jt/fetch-pack-negotiator; is tangled with jt/fetch-nego-tip.)

 Add a server-side knob to skip commits in exponential/fibbonacci
 stride in an attempt to cover wider swath of history with a smaller
 number of iterations, potentially accepting a larger packfile
 transfer, instead of going back one commit a time during common
 ancestor discovery during the "git fetch" transaction.

 Will merge to 'master'.


* jt/tags-to-promised-blobs-fix (2018-07-16) 2 commits
  (merged to 'next' on 2018-07-24 at 8d7e78a671)
 + tag: don't warn if target is missing but promised
 + revision: tolerate promised targets of tags

 The lazy clone support had a few places where missing but promised
 objects were not correctly tolerated, which have been fixed.

 Will merge to 'master'.


* sb/submodule-update-in-c (2018-07-18) 6 commits
 - submodule--helper: introduce new update-module-mode helper
 - builtin/submodule--helper: factor out method to update a single submodule
 - builtin/submodule--helper: store update_clone information in a struct
 - builtin/submodule--helper: factor out submodule updating
 - git-submodule.sh: rename unused variables
 - git-submodule.sh: align error reporting for update mode to use path

 "git submodule update" is getting rewritten piece-by-piece into C.

 It seems to pass its own self-tests standalone, but seems to break
 horribly when merged to 'pu'.


* sg/httpd-test-unflake (2018-07-12) 3 commits
  (merged to 'next' on 2018-07-24 at b7df820256)
 + t/lib-httpd: avoid occasional failures when checking access.log
 + t/lib-httpd: add the strip_access_log() helper function
 + t5541: clean up truncating access log

 httpd tests saw occasional breakage due to the way its access log
 gets inspected by the tests, which has been updated to make them
 less flaky.

 Will merge to 'master'.


* sl/commit-dry-run-with-short-output-fix (2018-07-17) 3 commits
 - commit: fix exit code for --short/--porcelain
 - wt-status: teach wt_status_collect about merges in progress
 - t7501: add merge conflict tests for dry run

 "git commit --dry-run" gave a correct exit status even during a
 conflict resolution toward a merge, but it did not with the
 "--short" option, which has been corrected.

 Will merge to 'next'.


* tg/rerere (2018-07-16) 11 commits
 - rerere: recalculate conflict ID when unresolved conflict is committed
 - rerere: teach rerere to handle nested conflicts
 - rerere: return strbuf from handle path
 - rerere: factor out handle_conflict function
 - rerere: only return whether a path has conflicts or not
 - rerere: fix crash when conflict goes unresolved
 - rerere: add documentation for conflict normalization
 - rerere: mark strings for translation
 - rerere: wrap paths in output in sq
 - rerere: lowercase error messages
 - rerere: unify error messages when read_cache fails


* jk/ui-color-always-to-auto (2018-07-18) 1 commit
 - Documentation: fix --color option formatting

 Doc formatting fix.

 Will merge to 'next' and then to 'master'.


* jh/json-writer (2018-07-16) 1 commit
 - json_writer: new routines to create JSON data
 (this branch is used by jh/structured-logging.)

 Preparatory code to later add json output for telemetry data.

 Will merge to 'next'.


* ag/rebase-i-in-c (2018-07-10) 13 commits
 - rebase -i: rewrite the rest of init_revisions_and_shortrevisions in C
 - rebase -i: implement the logic to initialize the variable $revision in C
 - rebase--interactive: remove unused modes and functions
 - rebase--interactive: rewrite complete_action() in C
 - sequencer: change the way skip_unnecessary_picks() returns its result
 - sequencer: refactor append_todo_help() to write its message to a buffer
 - rebase -i: rewrite checkout_onto() in C
 - rebase -i: rewrite setup_reflog_action() in C
 - sequencer: add a new function to silence a command, except if it fails
 - rebase-interactive: rewrite the edit-todo functionality in C
 - editor: add a function to launch the sequence editor
 - rebase--interactive: rewrite append_todo_help() in C
 - sequencer: make two functions and an enum from sequencer.c public

 Piecemeal rewrite of the remaining "rebase -i" machinery in C.

 A reroll (which is rumored to be quite good) exists, but hasn't
 been picked up yet.


* sb/object-store-lookup (2018-06-29) 33 commits
  (merged to 'next' on 2018-07-24 at dd96e29376)
 + commit.c: allow lookup_commit_reference to handle arbitrary repositories
 + commit.c: allow lookup_commit_reference_gently to handle arbitrary repositories
 + tag.c: allow deref_tag to handle arbitrary repositories
 + object.c: allow parse_object to handle arbitrary repositories
 + object.c: allow parse_object_buffer to handle arbitrary repositories
 + commit.c: allow get_cached_commit_buffer to handle arbitrary repositories
 + commit.c: allow set_commit_buffer to handle arbitrary repositories
 + commit.c: migrate the commit buffer to the parsed object store
 + commit-slabs: remove realloc counter outside of slab struct
 + commit.c: allow parse_commit_buffer to handle arbitrary repositories
 + tag: allow parse_tag_buffer to handle arbitrary repositories
 + tag: allow lookup_tag to handle arbitrary repositories
 + commit: allow lookup_commit to handle arbitrary repositories
 + tree: allow lookup_tree to handle arbitrary repositories
 + blob: allow lookup_blob to handle arbitrary repositories
 + object: allow lookup_object to handle arbitrary repositories
 + object: allow object_as_type to handle arbitrary repositories
 + tag: add repository argument to deref_tag
 + tag: add repository argument to parse_tag_buffer
 + tag: add repository argument to lookup_tag
 + commit: add repository argument to get_cached_commit_buffer
 + commit: add repository argument to set_commit_buffer
 + commit: add repository argument to parse_commit_buffer
 + commit: add repository argument to lookup_commit
 + commit: add repository argument to lookup_commit_reference
 + commit: add repository argument to lookup_commit_reference_gently
 + tree: add repository argument to lookup_tree
 + blob: add repository argument to lookup_blob
 + object: add repository argument to object_as_type
 + object: add repository argument to parse_object_buffer
 + object: add repository argument to lookup_object
 + object: add repository argument to parse_object
 + Merge branch 'sb/object-store-grafts' into sb/object-store-lookup
 (this branch is used by ds/commit-graph-with-grafts, ds/reachable and jt/commit-graph-per-object-store.)

 lookup_commit_reference() and friends have been updated to find
 in-core object for a specific in-core repository instance.

 Will merge to 'master'.


* bc/object-id (2018-07-16) 16 commits
  (merged to 'next' on 2018-07-24 at 23680778a9)
 + pretty: switch hard-coded constants to the_hash_algo
 + sha1-file: convert constants to uses of the_hash_algo
 + log-tree: switch GIT_SHA1_HEXSZ to the_hash_algo->hexsz
 + diff: switch GIT_SHA1_HEXSZ to use the_hash_algo
 + builtin/merge-recursive: make hash independent
 + builtin/merge: switch to use the_hash_algo
 + builtin/fmt-merge-msg: make hash independent
 + builtin/update-index: simplify parsing of cacheinfo
 + builtin/update-index: convert to using the_hash_algo
 + refs/files-backend: use the_hash_algo for writing refs
 + sha1-name: use the_hash_algo when parsing object names
 + strbuf: allocate space with GIT_MAX_HEXSZ
 + commit: express tree entry constants in terms of the_hash_algo
 + hex: switch to using the_hash_algo
 + tree-walk: replace hard-coded constants with the_hash_algo
 + cache: update object ID functions for the_hash_algo

 Conversion from uchar[40] to struct object_id continues.

 Will merge to 'master'.


* en/dirty-merge-fixes (2018-07-11) 9 commits
  (merged to 'next' on 2018-07-24 at 7b6ca3507c)
 + merge: fix misleading pre-merge check documentation
 + merge-recursive: enforce rule that index matches head before merging
 + t6044: add more testcases with staged changes before a merge is invoked
 + merge-recursive: fix assumption that head tree being merged is HEAD
 + merge-recursive: make sure when we say we abort that we actually abort
 + t6044: add a testcase for index matching head, when head doesn't match HEAD
 + t6044: verify that merges expected to abort actually abort
 + index_has_changes(): avoid assuming operating on the_index
 + read-cache.c: move index_has_changes() from merge.c

 The recursive merge strategy did not properly ensure there was no
 change between HEAD and the index before performing its operation,
 which has been corrected.

 Will merge to 'master'.


* en/t6036-merge-recursive-tests (2018-07-11) 6 commits
  (merged to 'next' on 2018-07-24 at 75055cb6e1)
 + t6036: add a failed conflict detection case: regular files, different modes
 + t6036: add a failed conflict detection case with conflicting types
 + t6036: add a failed conflict detection case with submodule add/add
 + t6036: add a failed conflict detection case with submodule modify/modify
 + t6036: add a failed conflict detection case with symlink add/add
 + t6036: add a failed conflict detection case with symlink modify/modify

 Tests to cover various conflicting cases have been added for
 merge-recursive.

 Will merge to 'master'.


* en/t6036-recursive-corner-cases (2018-07-12) 2 commits
  (merged to 'next' on 2018-07-24 at b7b3514ef4)
 + t6036: fix broken && chain in sub-shell
 + t6036: add lots of detail for directory/file conflicts in recursive case

 Tests to cover more D/F conflict cases have been added for
 merge-recursive.

 Will merge to 'master'.


* en/t6042-insane-merge-rename-testcases (2018-07-03) 3 commits
  (merged to 'next' on 2018-07-24 at 65c80f72da)
 + t6042: add testcase covering long chains of rename conflicts
 + t6042: add testcase covering rename/rename(2to1)/delete/delete conflict
 + t6042: add testcase covering rename/add/delete conflict type

 Various glitches in the heuristics of merge-recursive strategy have
 been documented in new tests.

 Will merge to 'master'.

 I am not sure if there is a single "correct" answer everybody can
 agree on for each of these "insane" cases, though.


* en/t7405-recursive-submodule-conflicts (2018-07-11) 3 commits
  (merged to 'next' on 2018-07-24 at 6cb7d02298)
 + t7405: verify 'merge --abort' works after submodule/path conflicts
 + t7405: add a directory/submodule conflict
 + t7405: add a file/submodule conflict

 Tests to cover conflict cases that involve submodules have been
 added for merge-recursive.

 Will merge to 'master'.


* es/test-fixes (2018-07-17) 26 commits
  (merged to 'next' on 2018-07-24 at fd6796a3ef)
 + t5608: fix broken &&-chain
 + t9119: fix broken &&-chains
 + t9000-t9999: fix broken &&-chains
 + t7000-t7999: fix broken &&-chains
 + t6000-t6999: fix broken &&-chains
 + t5000-t5999: fix broken &&-chains
 + t4000-t4999: fix broken &&-chains
 + t3030: fix broken &&-chains
 + t3000-t3999: fix broken &&-chains
 + t2000-t2999: fix broken &&-chains
 + t1000-t1999: fix broken &&-chains
 + t0000-t0999: fix broken &&-chains
 + t9814: simplify convoluted check that command correctly errors out
 + t9001: fix broken "invoke hook" test
 + t7810: use test_expect_code() instead of hand-rolled comparison
 + t7400: fix broken "submodule add/reconfigure --force" test
 + t7201: drop pointless "exit 0" at end of subshell
 + t6036: fix broken "merge fails but has appropriate contents" tests
 + t5505: modernize and simplify hard-to-digest test
 + t5406: use write_script() instead of birthing shell script manually
 + t5405: use test_must_fail() instead of checking exit code manually
 + t/lib-submodule-update: fix "absorbing" test
 + t: drop unnecessary terminating semicolon in subshell
 + t: use sane_unset() rather than 'unset' with broken &&-chain
 + t: use test_write_lines() instead of series of 'echo' commands
 + t: use test_might_fail() instead of manipulating exit code manually
 (this branch is used by es/chain-lint-in-subshell.)

 Test clean-up and corrections.

 Will merge to 'master'.


* jk/fsck-gitmodules-gently (2018-07-16) 6 commits
  (merged to 'next' on 2018-07-24 at 5b15c800db)
 + fsck: downgrade gitmodulesParse default to "info"
 + fsck: split ".gitmodules too large" error from parse failure
 + fsck: silence stderr when parsing .gitmodules
 + config: add options parameter to git_config_from_mem
 + config: add CONFIG_ERROR_SILENT handler
 + config: turn die_on_error into caller-facing enum

 Recent "security fix" to pay attention to contents of ".gitmodules"
 while accepting "git push" was a bit overly strict than necessary,
 which has been adjusted.

 Will merge to 'master'.


* js/range-diff (2018-07-25) 21 commits
 - range-diff: use dim/bold cues to improve dual color mode
 - range-diff: make --dual-color the default mode
 - range-diff: left-pad patch numbers
 - completion: support `git range-diff`
 - range-diff: populate the man page
 - range-diff --dual-color: fix bogus white-space warning
 - range-diff: offer to dual-color the diffs
 - diff: add an internal option to dual-color diffs of diffs
 - color: add the meta color GIT_COLOR_REVERSE
 - range-diff: use color for the commit pairs
 - range-diff: add tests
 - range-diff: do not show "function names" in hunk headers
 - range-diff: adjust the output of the commit pairs
 - range-diff: suppress the diff headers
 - range-diff: indent the diffs just like tbdiff
 - range-diff: right-trim commit messages
 - range-diff: also show the diff between patches
 - range-diff: improve the order of the shown commits
 - range-diff: first rudimentary implementation
 - Introduce `range-diff` to compare iterations of a topic branch
 - linear-assignment: a function to solve least-cost assignment problems
 (this branch is used by es/format-patch-rangediff.)

 "git tbdiff" that lets us compare individual patches in two
 iterations of a topic has been rewritten and made into a built-in
 command.

 Undecided.  

 Many "The feature is useful" comments without much real review; we
 know the feature is great as this mimicks tbdiff already so that is
 not news.

 I've squashed an obvious documentation fix in before rebasing the
 other topic that depends on it.  I _think_ we would probably be
 better off to _disable_ whitespace-error coloring altogether when
 showing diff-of-diff, and get rid of the workaround that only is
 applicable to the context lines of the outer diff (unless we first
 define how whitespace errors in diff-of-diff should be colored and
 implement it correctly, that is, but after seeing these two
 attempts, it seems that is harder than it is worth).


* jt/commit-graph-per-object-store (2018-07-17) 7 commits
  (merged to 'next' on 2018-07-24 at 090d1a4d59)
 + commit-graph: add repo arg to graph readers
 + commit-graph: store graph in struct object_store
 + commit-graph: add free_commit_graph
 + commit-graph: add missing forward declaration
 + object-store: add missing include
 + commit-graph: refactor preparing commit graph
 + Merge branch 'ds/commit-graph-fsck' into jt/commit-graph-per-object-store
 (this branch is used by ds/commit-graph-with-grafts and ds/reachable; uses ds/commit-graph-fsck and sb/object-store-lookup.)

 The singleton commit-graph in-core instance is made per in-core
 repository instance.

 Will merge to 'master'.


* kg/gc-auto-windows-workaround (2018-07-09) 1 commit
  (merged to 'next' on 2018-07-24 at 71c05d27b6)
 + gc --auto: release pack files before auto packing

 "git gc --auto" opens file descriptors for the packfiles before
 spawning "git repack/prune", which would upset Windows that does
 not want a process to work on a file that is open by another
 process.  The issue has been worked around.

 Will merge to 'master'.


* lt/date-human (2018-07-09) 1 commit
 - Add 'human' date format

 A new date format "--date=human" that morphs its output depending
 on how far the time is from the current time has been introduced.
 "--date=auto" can be used to use this new format when the output is
 goint to the pager or to the terminal and otherwise the default
 format.


* ot/ref-filter-object-info (2018-07-17) 5 commits
 - ref-filter: use oid_object_info() to get object
 - ref-filter: merge get_obj and get_object
 - ref-filter: initialize eaten variable
 - ref-filter: fill empty fields with empty values
 - ref-filter: add info_source to valid_atom

 A few atoms like %(objecttype) and %(objectsize) in the format
 specifier of "for-each-ref --format=<format>" can be filled without
 getting the full contents of the object, but just with the object
 header.  These cases have been optimzied by calling
 oid_object_info() API.

 What's the doneness of this one?


* pk/rebase-in-c (2018-07-23) 4 commits
 - builtin/rebase: support running "git rebase <upstream>"
 - sequencer: refactor the code to detach HEAD to checkout.c
 - rebase: refactor common shell functions into their own file
 - rebase: start implementing it as a builtin

 Piecemeal rewrite of the "rebase" machinery in C.
 Expecting a reroll, but it seems that this is getting quite close.
 cf. <CAOZc8M8YmLwJOzG-1jyz8ft4W_tJMwNs6kSV8inX1q_zmDW8Sg@mail.gmail.com>


* jt/fetch-nego-tip (2018-07-03) 1 commit
  (merged to 'next' on 2018-07-24 at a9e299006d)
 + fetch-pack: support negotiation tip whitelist
 (this branch uses jt/fetch-pack-negotiator; is tangled with jt/fetch-negotiator-skipping.)

 "git fetch" learned a new option "--negotiation-tip" to limit the
 set of commits it tells the other end as "have", to reduce wasted
 bandwidth and cycles, which would be helpful when the receiving
 repository has a lot of refs that have little to do with the
 history at the remote it is fetching from.

 Will merge to 'master'.


* tb/grep-only-matching (2018-07-09) 2 commits
  (merged to 'next' on 2018-07-24 at 7e878b9d95)
 + grep.c: teach 'git grep --only-matching'
 + grep.c: extract show_line_header()

 "git grep" learned the "--only-matching" option.

 Will merge to 'master'.


* jk/branch-l-1-repurpose (2018-06-22) 1 commit
 - branch: make "-l" a synonym for "--list"

 Updated plan to repurpose the "-l" option to "git branch".

 Will hold in 'pu' until jk/branch-l-0-deprecation progresses sufficiently.


* cc/remote-odb (2018-07-16) 9 commits
 - Documentation/config: add odb.<name>.promisorRemote
 - t0410: test fetching from many promisor remotes
 - Use odb.origin.partialclonefilter instead of core.partialclonefilter
 - Use remote_odb_get_direct() and has_remote_odb()
 - remote-odb: add remote_odb_reinit()
 - remote-odb: implement remote_odb_get_many_direct()
 - remote-odb: implement remote_odb_get_direct()
 - Add initial remote odb support
 - fetch-object: make functions return an error code


* ds/multi-pack-index (2018-07-20) 23 commits
 - midx: clear midx on repack
 - packfile: skip loading index if in multi-pack-index
 - midx: prevent duplicate packfile loads
 - midx: use midx in approximate_object_count
 - midx: use existing midx when writing new one
 - midx: use midx in abbreviation calculations
 - midx: read objects from multi-pack-index
 - config: create core.multiPackIndex setting
 - midx: write object offsets
 - midx: write object id fanout chunk
 - midx: write object ids in a chunk
 - midx: sort and deduplicate objects from packfiles
 - midx: read pack names into array
 - multi-pack-index: write pack names in chunk
 - multi-pack-index: read packfile list
 - packfile: generalize pack directory list
 - t5319: expand test data
 - multi-pack-index: load into memory
 - midx: write header information to lockfile
 - multi-pack-index: add 'write' verb
 - multi-pack-index: add builtin
 - multi-pack-index: add format details
 - multi-pack-index: add design document

 When there are too many packfiles in a repository (which is not
 recommended), looking up an object in these would require
 consulting many pack .idx files; a new mechanism to have a single
 file that consolidates all of these .idx files is introduced.

 Ready to move to 'next', with some known issues to be followed up?
 cf. <xmqqefg8uplg.fsf@gitster-ct.c.googlers.com>
 cf. <CAPig+cTU--KrGcv4C_CwBZEuec4dgm_tJqL=CFWKT6vxxR016w@mail.gmail.com>


* jt/fetch-pack-negotiator (2018-06-15) 7 commits
  (merged to 'next' on 2018-07-24 at 438efcd6b1)
 + fetch-pack: introduce negotiator API
 + fetch-pack: move common check and marking together
 + fetch-pack: make negotiation-related vars local
 + fetch-pack: use ref adv. to prune "have" sent
 + fetch-pack: directly end negotiation if ACK ready
 + fetch-pack: clear marks before re-marking
 + fetch-pack: split up everything_local()
 (this branch is used by jt/fetch-nego-tip and jt/fetch-negotiator-skipping.)

 Code restructuring and a small fix to transport protocol v2 during
 fetching.

 Will merge to 'master'.


* is/parsing-line-range (2018-06-15) 2 commits
  (merged to 'next' on 2018-07-24 at a06b453f32)
 + log: prevent error if line range ends past end of file
 + blame: prevent error if range ends past end of file

 Parsing of -L[<N>][,[<M>]] parameters "git blame" and "git log"
 take has been tweaked.

 Will merge to 'master'.


* ab/checkout-default-remote (2018-06-11) 8 commits
  (merged to 'next' on 2018-07-24 at 6ef645f485)
 + checkout & worktree: introduce checkout.defaultRemote
 + checkout: add advice for ambiguous "checkout <branch>"
 + builtin/checkout.c: use "ret" variable for return
 + checkout: pass the "num_matches" up to callers
 + checkout.c: change "unique" member to "num_matches"
 + checkout.c: introduce an *_INIT macro
 + checkout.h: wrap the arguments to unique_tracking_name()
 + checkout tests: index should be clean after dwim checkout

 "git checkout" and "git worktree add" learned to honor
 checkout.defaultRemote when auto-vivifying a local branch out of a
 remote tracking branch in a repository with multiple remotes that
 have tracking branches that share the same names.

 Will merge to 'master'.


* ds/commit-graph-fsck (2018-07-16) 23 commits
  (merged to 'next' on 2018-07-24 at 6a802adc7a)
 + coccinelle: update commit.cocci
 + commit-graph: update design document
 + gc: automatically write commit-graph files
 + commit-graph: add '--reachable' option
 + commit-graph: use string-list API for input
 + fsck: verify commit-graph
 + commit-graph: verify contents match checksum
 + commit-graph: test for corrupted octopus edge
 + commit-graph: verify commit date
 + commit-graph: verify generation number
 + commit-graph: verify parent list
 + commit-graph: verify root tree OIDs
 + commit-graph: verify objects exist
 + commit-graph: verify corrupt OID fanout and lookup
 + commit-graph: verify required chunks are present
 + commit-graph: verify catches corrupt signature
 + commit-graph: add 'verify' subcommand
 + commit-graph: load a root tree from specific graph
 + commit: force commit to parse from object database
 + commit-graph: parse commit from chosen graph
 + commit-graph: fix GRAPH_MIN_SIZE
 + commit-graph: UNLEAK before die()
 + t5318-commit-graph.sh: use core.commitGraph
 (this branch is used by ds/commit-graph-with-grafts, ds/reachable and jt/commit-graph-per-object-store.)

 "git fsck" learns to make sure the optional commit-graph file is in
 a sane state.

 Will merge to 'master'.


* ma/wrapped-info (2018-05-28) 2 commits
 - usage: prefix all lines in `vreportf()`, not just the first
 - usage: extract `prefix_suffix_lines()` from `advise()`

 An attempt to help making multi-line messages fed to warning(),
 error(), and friends more easily translatable.

 Will discard and wait for a cleaned-up rewrite.
 cf. <20180529213957.GF7964@sigill.intra.peff.net>


* jm/cache-entry-from-mem-pool (2018-07-03) 8 commits
  (merged to 'next' on 2018-07-24 at 9be51a88dc)
 + block alloc: add validations around cache_entry lifecyle
 + block alloc: allocate cache entries from mem_pool
 + mem-pool: fill out functionality
 + mem-pool: add life cycle management functions
 + mem-pool: only search head block for available space
 + block alloc: add lifecycle APIs for cache_entry structs
 + read-cache: teach make_cache_entry to take object_id
 + read-cache: teach refresh_cache_entry to take istate

 For a large tree, the index needs to hold many cache entries
 allocated on heap.  These cache entries are now allocated out of a
 dedicated memory pool to amortize malloc(3) overhead.

 Will merge to 'master'.

 This makes each cache-entry larger by either 4 or 8 bytes, which is
 a bit sad, though.


* sb/diff-color-move-more (2018-07-19) 10 commits
  (merged to 'next' on 2018-07-24 at 89c893cab2)
 + diff.c: offer config option to control ws handling in move detection
 + diff.c: add white space mode to move detection that allows indent changes
 + diff.c: factor advance_or_nullify out of mark_color_as_moved
 + diff.c: decouple white space treatment from move detection algorithm
 + diff.c: add a blocks mode for moved code detection
 + diff.c: adjust hash function signature to match hashmap expectation
 + diff.c: do not pass diff options as keydata to hashmap
 + t4015: avoid git as a pipe input
 + xdiff/xdiffi.c: remove unneeded function declarations
 + xdiff/xdiff.h: remove unused flags

 "git diff --color-moved" feature has further been tweaked.

 Will merge to 'master'.
