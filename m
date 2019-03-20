Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D92FB202BB
	for <e@80x24.org>; Wed, 20 Mar 2019 03:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfCTDN4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 23:13:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44592 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfCTDN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 23:13:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id w2so1011305wrt.11
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 20:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=tjgqvyHDxLXAca0MpoVSbrx456fWVgvJPw6Wys2+gLg=;
        b=qXTRaPc9F7Q9D5sOiVgumZ7c2Nmg/RsG0k9WOEVyRVu4WdxEwnH3emrVDL7Lv9E+wR
         KqEDIJ6StjuXZPPaqDbKPtL7pWVFET7A7Rol6zDx95NoUjzFUGWB1XXmJQ05CP9ibNCQ
         hfb6Uul9Hj9Azf2OU7LPh2JiY0C1+XOVoWFqX522yjsxvlAsq40LW4PEtUqAqdLGYZ7c
         sxKg9GmMqpPMSpGbyyq1QILC61JozfxpQyb4scGWV/71gZ/9pqUrtD/jPWrNp1bcntj+
         gQO3gbcQs4qFrJGN22c95yZAvbJwjlFyIkSCguNUP966J0YAxlXysYtCOiycbCCa9s12
         rcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=tjgqvyHDxLXAca0MpoVSbrx456fWVgvJPw6Wys2+gLg=;
        b=bhVErGdyZbyG5r7ssPN4bTomlii3oVQrSZQRuBdrr0JKycQuKw3zg7QHauh2pAFK2n
         TVtwTCwQcGkJHsWDAAaIWwJ3N3nCV9Ph62Gxs28ZcfA1nTADuy48qiqhwsInWCsx+HKF
         0BsY+dRt+BWA4a3uw8K+5+tHxuWCZwp+yhq4zXmNZTeYX7VDr4x6H4yhSea96eYdWvH8
         jHoBs3QjJQrHJajafI2NwpSo7Mkfg6lJlwim5Tgso+FiDJ1v17gxDRybEBfHYAu5qjXw
         YKhY2Obnd8xCpqLPc8XYkdurzkNsV3bvZuRhr8nxVVuHNYfZLoL1k+XaFsTX5H5nvnSP
         twew==
X-Gm-Message-State: APjAAAUnDgPM5qZ6TTcq3YyZgOiTIY2N+tdLBGYeKZ01ia6AgnSrxdpY
        8KhtGRXdDzBS430Rphw2v5UekMyW9/rUBoS3
X-Google-Smtp-Source: APXvYqxy3AwSpE0dS3wP74vpOvfe9TzYLd+6rmqDfE7gr2XxqFH/pdzZ6NrwXeQzoTN5uQ2tiKQfeQ==
X-Received: by 2002:adf:9103:: with SMTP id j3mr19570002wrj.236.1553051630204;
        Tue, 19 Mar 2019 20:13:50 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id s14sm803411wmc.7.2019.03.19.20.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 20:13:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Mar 2019, #04; Wed, 20)
X-master-at: 0e94f7aa730b108f7907cfab1b2a7fba965de442
X-next-at: fef4c6d200cf268f44767029c50f1b592040de2e
Date:   Wed, 20 Mar 2019 12:13:47 +0900
Message-ID: <xmqqa7hqw844.fsf@gitster-ct.c.googlers.com>
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

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* ms/worktree-add-atomic-mkdir (2019-03-12) 1 commit
 - worktree: fix worktree add race

 "git worktree add" used to do a "find an available name with stat
 and then mkdir", which is race-prone.  This has been fixed by using
 mkdir and reacting to EEXIST in a loop.

 Will merge to 'next'.


* tb/stash-in-c-unused-param-fix (2019-03-11) 1 commit
 - stash: drop unused parameter
 (this branch uses ps/stash-in-c; is tangled with js/stash-in-c-pathspec-fix and tg/stash-in-c-show-default-to-p-fix.)

 Code clean-up.

 Will merge to 'next'.


* dl/subtree-limit-to-one-rev (2019-03-12) 1 commit
 - contrib/subtree: ensure only one rev is provided

 "git subtree" (in contrib/) update.

 Will merge to 'next'.


* ar/t4150-remove-cruft (2019-03-13) 1 commit
 - t4150: remove unused variable

 Test cleanup.

 Will merge to 'next'.


* cb/doco-mono (2019-03-13) 2 commits
 - doc: format pathnames and URLs as monospace.
 - doc/CodingGuidelines: URLs and paths as monospace

 Clean-up markup in the documentation suite.

 Will merge to 'next'.


* cc/multi-promisor (2019-03-14) 12 commits
 - promisor-remote.h: fix a 'hdr-check' warning
 - remote: add promisor and partial clone config to the doc
 - partial-clone: add multiple remotes in the doc
 - t0410: test fetching from many promisor remotes
 - builtin/fetch: remove unique promisor remote limitation
 - promisor-remote: parse remote.*.partialclonefilter
 - Use promisor_remote_get_direct() and has_promisor_remote()
 - promisor-remote: use repository_format_partial_clone
 - promisor-remote: add promisor_remote_reinit()
 - promisor-remote: implement promisor_remote_get_direct()
 - Add initial support for many promisor remotes
 - fetch-object: make functions return an error code


* jk/promote-ggg (2019-03-13) 1 commit
 - point pull requesters to GitGitGadget

 Swap submitGit with GitGitGadget as a way to submit patches based
 on GitHub PR to us.

 Will merge to 'next'.


* jk/sha1dc (2019-03-13) 1 commit
 - Makefile: fix unaligned loads in sha1dc with UBSan

 Build update for SHA-1 with collision detection.

 Will merge to 'next'.


* jt/submodule-fetch-errmsg (2019-03-14) 1 commit
 - submodule: explain first attempt failure clearly

 Error message update.

 Will merge to 'next'.
 cf. <20190313175738.252961-1-jonathantanmy@google.com> (v2)


* nd/switch-and-restore (2019-03-18) 38 commits
 - doc: promote "git restore"
 - completion: support restore
 - SQUASH??? move -p test to 2071 from 2070
 - t: add tests for restore
 - restore: support --patch
 - restore: default to --source=HEAD when only --index is specified
 - restore: add --worktree and --index
 - checkout: factor out worktree checkout code
 - restore: disable overlay mode by default
 - restore: make pathspec mandatory
 - restore: take tree-ish from --source option instead
 - checkout: split part of it to new command 'restore'
 - doc: promote "git switch"
 - completion: support switch
 - t: add tests for switch
 - switch: --orphan defaults to empty tree as HEAD
 - switch: reject if some operation is in progress
 - switch: no worktree status unless real branch switch happens
 - switch: implicit dwim, use --no-guess to disable it
 - switch: add short option for --detach
 - switch: only allow explicit detached HEAD
 - switch: reject "do nothing" case
 - switch: stop accepting pathspec
 - switch: remove -l
 - switch: add --discard-changes
 - switch: better names for -b and -B
 - checkout: split part of it to new command 'switch'
 - checkout: split options[] array in three pieces
 - checkout: move 'confict_style' and 'dwim_..' to checkout_opts
 - checkout: make "opts" in cmd_checkout() a pointer
 - checkout: factor out some code in parse_branchname_arg()
 - checkout: keep most #include sorted
 - checkout: advice how to get out of detached HEAD mode
 - t: rename t2014-switch.sh to t2014-checkout-switch.sh
 - git-checkout.txt: fix monospace typeset
 - doc: document --overwrite-ignore
 - git-checkout.txt: fix one syntax line
 - git-checkout.txt: spell out --no-option

 Two new commands "git switch" and "git restore" are introduced to
 split "checking out a branch to work on advancing its history" and
 "checking out paths out of the index and/or a tree-ish to work on
 advancing the current history" out of the single "git checkout"
 command.

 cf. <20190317124926.17137-1-pclouds@gmail.com> (switch v4)
 cf. <20190308101655.9767-1-pclouds@gmail.com> (restore v1)


* ab/doc-misc-typofixes (2019-03-18) 1 commit
 - doc: fix typos in man pages

 Typofixes.

 Will merge to 'next'.


* ab/drop-scripted-rebase (2019-03-20) 1 commit
 - rebase: remove the rebase.useBuiltin setting

 Retire scripted "git rebase" implementation.

 Will merge to 'next'.


* ab/gc-reflog (2019-03-18) 8 commits
 - reflog expire: don't assert the OID when locking refs
 - gc: handle & check gc.reflogExpire config
 - reflog tests: assert lack of early exit with expiry="never"
 - reflog tests: test for the "points nowhere" warning
 - reflog tests: make use of "test_config" idiom
 - gc: refactor a "call me once" pattern
 - gc: convert to using the_hash_algo
 - gc: remove redundant check for gc_auto_threshold

 Fix various glitches in "git gc" around reflog handling.

 cf. <20190315155959.12390-1-avarab@gmail.com> (v3)


* ew/repack-with-bitmaps-by-default (2019-03-18) 3 commits
 - pack-objects: default to writing bitmap hash-cache
 - t5310: correctly remove bitmaps for jgit test
 - repack: enable bitmaps by default on bare repos

 The connectivity bitmaps are created by default in bare
 repositories now; also the pathname hash-cache is created by
 default to avoid making crappy deltas when repacking.

 Will merge to 'next'.


* jk/perf-lib-tee (2019-03-18) 1 commit
 - perf-lib.sh: rely on test-lib.sh for --tee handling

 Code cleanup in the test framework.

 Will merge to 'next'.


* js/check-docs-exe (2019-03-14) 1 commit
 - check-docs: fix for setups where executables have an extension

 Dev support update.

 Will merge to 'next'.


* js/difftool-no-index (2019-03-18) 3 commits
 - difftool: allow running outside Git worktrees with --no-index
 - parse-options: make OPT_ARGUMENT() more useful
 - difftool: remove obsolete (and misleading) comment

 "git difftool" can now run outside a repository.

 Will merge to 'next'.


* js/get-short-oid-drop-cache (2019-03-14) 4 commits
 - get_oid(): when an object was not found, try harder
 - sequencer: move stale comment into correct location
 - sequencer: improve error message when an OID could not be parsed
 - rebase -i: demonstrate obscure loose object cache bug

 A corner-case object name ambiguity while the sequencer machinery
 is working (e.g. "rebase -i -x") has been (half) fixed.

 Will merge to 'next'.


* ma/doc-diff-doc-vs-doctor-comparison (2019-03-18) 4 commits
 - doc-diff: add `--cut-header-footer`
 - doc-diff: support diffing from/to AsciiDoc(tor)
 - doc-diff: let `render_tree()` take an explicit directory name
 - Doc: auto-detect changed build flags

 Dev support update to make it easier to compare two formatted
 results from our documentation.

 Will merge to 'next'.
 cf. <20190319031412.GC6173@sigill.intra.peff.net>


* mh/pack-protocol-doc-fix (2019-03-18) 1 commit
 - fix pack protocol example client/server communication

 Docfix.

 Will merge to 'next'.


* nd/checkout-f-while-conflicted-fix (2019-03-19) 1 commit
 - unpack-trees: fix oneway_merge accidentally carry over stage index

 "git checkout -f <branch>" while the index has an unmerged path
 incorrectly left some paths in an unmerged state, which has been
 corrected.

 Will merge to 'next'.


* pw/cherry-pick-continue (2019-03-18) 3 commits
 - cherry-pick --continue: remember options
 - cherry-pick: demonstrate option amnesia
 - sequencer: break some long lines

 "git cherry-pick --options A..B", after giving control back to the
 user to ask help resolving a conflicted step, did not honor the
 options it originally received, which has been corrected.

 Will merge to 'next'.


* pw/rerere-autoupdate (2019-03-18) 2 commits
 - merge: tweak --rerere-autoupdate documentation
 - am/cherry-pick/rebase/revert: document --rerere-autoupdate

 Doc updates.

 Will merge to 'next'.


* sg/test-atexit (2019-03-14) 11 commits
 - t9811-git-p4-label-import: fix pipeline negation
 - git p4 test: disable '-x' tracing in the p4d watchdog loop
 - git p4 test: simplify timeout handling
 - git p4 test: clean up the p4d cleanup functions
 - git p4 test: use 'test_atexit' to kill p4d and the watchdog process
 - t0301-credential-cache: use 'test_atexit' to stop the credentials helper
 - tests: use 'test_atexit' to stop httpd
 - git-daemon: use 'test_atexit` to stop 'git-daemon'
 - test-lib: introduce 'test_atexit'
 - t/lib-git-daemon: make sure to kill the 'git-daemon' process
 - test-lib: fix interrupt handling with 'dash' and '--verbose-log -x'

 Test framework update to more robustly clean up leftover files and
 processes after tests are done.

 Will merge to 'next'.


* tb/trace2-va-list-fix (2019-03-20) 1 commit
 - trace2: NULL is not allowed for va_list

 Fix some code that passed a NULL when a va_list was expected.

 Will merge to 'next'.


* tg/glossary-overlay (2019-03-18) 1 commit
 - glossary: add definition for overlay

 Doc update.

 Will merge to 'next'.


* tg/stash-in-c-show-default-to-p-fix (2019-03-20) 1 commit
 - stash: setup default diff output format if necessary
 (this branch uses ps/stash-in-c; is tangled with js/stash-in-c-pathspec-fix and tb/stash-in-c-unused-param-fix.)

 A regression fix.

 Will merge to 'next'.


* tz/completion (2019-03-18) 4 commits
 - completion: use __git when calling --list-cmds
 - completion: fix multiple command removals
 - t9902: test multiple removals via completion.commands
 - git: read local config in --list-cmds

 The completion helper code now pays attention to repository-local
 configuration (when available), which allows --list-cmds to honour
 a repository specific setting of completion.commands, for example.

 Getting there...
 cf. <20190317181620.26727-1-tmz@pobox.com> (v2)
 cf. <CACsJy8DiQwmAKMruOAO4roPbiRTvt5TESBTd682hTwkZjcoj2Q@mail.gmail.com>


* tz/t4038-bash-redirect-target-workaround (2019-03-18) 1 commit
 - t4038-diff-combined: quote paths with whitespace

 Work-around extra warning from bash in our tests.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* js/add-i-coalesce-after-editing-hunk (2018-08-28) 1 commit
 - add -p: coalesce hunks before testing applicability

 Applicability check after a patch is edited in a "git add -i/p"
 session has been improved.

 Will hold.
 cf. <e5b2900a-0558-d3bf-8ea1-d526b078bbc2@talktalk.net>


* ds/midx-expire-repack (2019-01-27) 10 commits
 - midx: add test that 'expire' respects .keep files
 - multi-pack-index: test expire while adding packs
 - midx: implement midx_repack()
 - multi-pack-index: prepare 'repack' subcommand
 - multi-pack-index: implement 'expire' subcommand
 - midx: refactor permutation logic and pack sorting
 - midx: simplify computation of pack name lengths
 - multi-pack-index: prepare for 'expire' subcommand
 - Docs: rearrange subcommands for multi-pack-index
 - repack: refactor pack deletion for future use

 "git multi-pack-index expire/repack" are new subcommands that
 consult midx file and are used to drop unused pack files and
 coalesce small pack files that are still in use.

 Comments?


* js/protocol-advertise-multi (2018-12-28) 1 commit
 - protocol: advertise multiple supported versions

 The transport layer has been updated so that the protocol version
 used can be negotiated between the parties, by the initiator
 listing the protocol versions it is willing to talk, and the other
 side choosing from one of them.

 Expecting a reroll.
 cf. <CANq=j3u-zdb_FvNJGPCmygNMScseav63GhVvBX3NcVS4f7TejA@mail.gmail.com>


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".


* dl/remote-save-to-push (2018-12-11) 1 commit
 - remote: add --save-to-push option to git remote set-url

 "git remote set-url" learned a new option that moves existing value
 of the URL field to pushURL field of the remote before replacing
 the URL field with a new value.

 Anybody who wants to champion this topic?
 I am personally not yet quite convinced if this is worth pursuing.


* pw/add-p-select (2018-07-26) 4 commits
 - add -p: optimize line selection for short hunks
 - add -p: allow line selection to be inverted
 - add -p: select modified lines correctly
 - add -p: select individual hunk lines

 "git add -p" interactive interface learned to let users choose
 individual added/removed lines to be used in the operation, instead
 of accepting or rejecting a whole hunk.

 Will discard.
 No further feedbacks on the topic for quite some time.

 cf. <d622a95b-7302-43d4-4ec9-b2cf3388c653@talktalk.net>
 I found the feature to be hard to explain, and may result in more
 end-user complaints, but let's see.


* nb/branch-show-other-worktrees-head (2019-03-18) 3 commits
 - branch: add worktree info on verbose output
 - branch: update output to include worktree info
 - ref-filter: add worktreepath atom

 "git branch --list" learned to show branches that are checked out
 in other worktrees connected to the same repository prefixed with
 '+', similar to the way the currently checked out branch is shown
 with '*' in front.

 The top one probably deserves retitling.
 The second one is of dubious value, but if we are keeping it,
 it should also be retitled.

--------------------------------------------------
[Cooking]

* dl/ignore-docs (2019-03-08) 2 commits
 - docs: move core.excludesFile from git-add to gitignore
 - git-clean.txt: clarify ignore pattern files

 Doc update.

 Will merge to 'next'.


* jh/resize-convert-scratch-buffer (2019-03-08) 1 commit
 - convert: avoid malloc of original file size

 When the "clean" filter can reduce the size of a huge file in the
 working tree down to a small "token" (a la Git LFS), there is no
 point in allocating a huge scratch area upfront, but the buffer is
 sized based on the original file size.  The convert mechanism now
 allocates very minimum and reallocates as it receives the output
 from the clean filter process.

 Will merge to 'next'.


* jk/line-log-with-patch (2019-03-11) 2 commits
 - line-log: detect unsupported formats
 - line-log: suppress diff output with "-s"

 "git log -L<from>,<to>:<path>" with "-s" did not suppress the patch
 output as it should.  This has been corrected.

 Will merge to 'next'.


* js/rebase-deprecate-preserve-merges (2019-03-12) 1 commit
 - rebase: deprecate --preserve-merges

 "git rebase --rebase-merges" replaces its old "--preserve-merges"
 option; the latter is now marked as deprecated.

 Will merge to 'next'.


* js/init-db-update-for-mingw (2019-03-12) 1 commit
 - mingw: respect core.hidedotfiles = false in git-init again

 "git init" forgot to read platform-specific repository
 configuration, which made Windows port to ignore settings of
 core.hidedotfiles, for example.

 Will merge to 'next'.


* js/stash-in-c-pathspec-fix (2019-03-12) 3 commits
 - stash: pass pathspec as pointer
 - built-in stash: handle :(glob) pathspecs again
 - legacy stash: fix "rudimentary backport of -q"
 (this branch uses ps/stash-in-c; is tangled with tb/stash-in-c-unused-param-fix and tg/stash-in-c-show-default-to-p-fix.)

 Further fixes to "git stash" reimplemented in C.

 Will merge to 'next'.


* nd/rewritten-ref-is-per-worktree (2019-03-08) 3 commits
 - Make sure refs/rewritten/ is per-worktree
 - files-backend.c: reduce duplication in add_per_worktree_entries_to_dir()
 - files-backend.c: factor out per-worktree code in loose_fill_ref_dir()

 "git rebase" uses the refs/rewritten/ hierarchy to store its
 intermediate states, which inherently makes the hierarchy per
 worktree, but it didn't quite work well.

 Will merge to 'next'.


* br/commit-tree-parseopt (2019-03-08) 1 commit
  (merged to 'next' on 2019-03-11 at e1228ef04f)
 + commit-tree: utilize parse-options api

 Originally merged to 'next' on 2019-03-08

 The command line parser of "git commit-tree" has been rewritten to
 use the parse-options API.

 Will merge to 'master'.


* jk/config-type-color-ends-with-lf (2019-03-07) 1 commit
  (merged to 'next' on 2019-03-11 at 810b269d1a)
 + config: document --type=color output is a complete line

 Originally merged to 'next' on 2019-03-07

 "git config --type=color ..." is meant to replace "git config --get-color"
 but there is a slight difference that wasn't documented, which is
 now fixed.

 Will merge to 'master'.


* js/remote-curl-i18n (2019-03-06) 1 commit
 - remote-curl: mark all error messages for translation
 (this branch uses js/anonymize-remote-curl-diag.)

 Error messages given from the http transport have been updated so
 that they can be localized.

 Will merge to 'next'.


* ma/asciidoctor-fixes-more (2019-03-07) 5 commits
 - Documentation: turn middle-of-line tabs into spaces
 - git-svn.txt: drop escaping '\' that ends up being rendered
 - git.txt: remove empty line before list continuation
 - config/fsck.txt: avoid starting line with dash
 - config/diff.txt: drop spurious backtick

 Documentation mark-up fixes.

 Will merge to 'next'.


* nd/diff-parseopt-3 (2019-03-07) 20 commits
 - diff-parseopt: convert --submodule
 - diff-parseopt: convert --ignore-submodules
 - diff-parseopt: convert --textconv
 - diff-parseopt: convert --ext-diff
 - diff-parseopt: convert --quiet
 - diff-parseopt: convert --exit-code
 - diff-parseopt: convert --color-words
 - diff-parseopt: convert --word-diff-regex
 - diff-parseopt: convert --word-diff
 - diff-parseopt: convert --[no-]color
 - diff-parseopt: convert --[no-]follow
 - diff-parseopt: convert -R
 - diff-parseopt: convert -a|--text
 - diff-parseopt: convert --full-index
 - diff-parseopt: convert --binary
 - diff-parseopt: convert --anchored
 - diff-parseopt: convert --diff-algorithm
 - diff-parseopt: convert --histogram
 - diff-parseopt: convert --patience
 - diff-parseopt: convert --[no-]indent-heuristic

 Third batch to teach the diff machinery to use the parse-options
 API.

 Will merge to 'next'.
 cf. <20190305123026.7266-1-pclouds@gmail.com>


* jt/test-protocol-version (2019-03-07) 8 commits
 - t5552: compensate for v2 filtering ref adv.
 - tests: fix protocol version for overspecifications
 - t5700: only run with protocol version 1
 - t5512: compensate for v0 only sending HEAD symrefs
 - t5503: fix overspecification of trace expectation
 - tests: always test fetch of unreachable with v0
 - t5601: check ssh command only with protocol v0
 - tests: define GIT_TEST_PROTOCOL_VERSION

 Help developers by making it easier to run most of the tests under
 different versions of over-the-wire protocols.

 Will merge to 'next'.
 cf. <cover.1551131153.git.jonathantanmy@google.com>


* jk/bisect-final-output (2019-03-01) 3 commits
  (merged to 'next' on 2019-03-11 at dea599eb04)
 + bisect: make diff-tree output prettier
 + bisect: fix internal diff-tree config loading
 + bisect: use string arguments to feed internal diff-tree

 Originally merged to 'next' on 2019-03-07

 The final report from "git bisect" used to show the suspected
 culprit using a raw "diff-tree", with which there is no output for
 a merge commit.  This has been updated to use a more modern and
 human readable output that still is concise enough.

 Will merge to 'master'.


* jk/fsck-doc (2019-03-05) 2 commits
  (merged to 'next' on 2019-03-11 at 5cd610f73e)
 + fsck: always compute USED flags for unreachable objects
 + doc/fsck: clarify --connectivity-only behavior

 Originally merged to 'next' on 2019-03-07

 "git fsck --connectivity-only" omits computation necessary to sift
 the objects that are not reachable from any of the refs into
 unreachable and dangling.  This is now enabled when dangling
 objects are requested (which is done by default, but can be
 overridden with the "--no-dangling" option).

 Will merge to 'master'.


* jk/no-sigpipe-during-network-transport (2019-03-05) 2 commits
  (merged to 'next' on 2019-03-11 at 25900acd0d)
 + fetch: ignore SIGPIPE during network operation
 + fetch: avoid calling write_or_die()

 Originally merged to 'next' on 2019-03-07

 On platforms where "git fetch" is killed with SIGPIPE (e.g. OSX),
 the upload-pack that runs on the other end that hangs up after
 detecting an error could cause "git fetch" to die with a signal,
 which led to a flakey test.  "git fetch" now ignores SIGPIPE during
 the network portion of its operation (this is not a problem as we
 check the return status from our write(2)s).

 Will merge to 'master'.


* jk/virtual-objects-do-exist (2019-03-05) 1 commit
  (merged to 'next' on 2019-03-11 at 748c79a1f0)
 + rev-list: allow cached objects in existence check

 Originally merged to 'next' on 2019-03-07

 A recent update broke "is this object available to us?" check for
 well-known objects like an empty tree (which should yield "yes",
 even when there is no on-disk object for an empty tree), which has
 been corrected.

 Will merge to 'master'.


* js/anonymize-remote-curl-diag (2019-03-05) 1 commit
 - curl: anonymize URLs in error messages and warnings
 (this branch is used by js/remote-curl-i18n.)

 remote-http transport did not anonymize URLs reported in its error
 messages at places.

 Will merge to 'next'.


* js/rebase-orig-head-fix (2019-03-04) 4 commits
  (merged to 'next' on 2019-03-11 at 4b1b19d391)
 + built-in rebase: set ORIG_HEAD just once, before the rebase
 + built-in rebase: demonstrate that ORIG_HEAD is not set correctly
 + built-in rebase: use the correct reflog when switching branches
 + built-in rebase: no need to check out `onto` twice

 Originally merged to 'next' on 2019-03-07

 "git rebase" that was reimplemented in C did not set ORIG_HEAD
 correctly, which has been corrected.

 Will merge to 'master'.


* js/stress-test-ui-tweak (2019-03-04) 2 commits
  (merged to 'next' on 2019-03-11 at 223afded1c)
 + tests: introduce --stress-jobs=<N>
 + tests: let --stress-limit=<N> imply --stress

 Originally merged to 'next' on 2019-03-07

 Dev support.

 Will merge to 'master'.


* ma/asciidoctor-fixes (2019-03-11) 3 commits
 - asciidoctor-extensions: fix spurious space after linkgit
 - Documentation/Makefile: add missing dependency on asciidoctor-extensions
 - Documentation/Makefile: add missing xsl dependencies for manpages

 Build fix around use of asciidoctor instead of asciidoc

 Will merge to 'next'.


* nd/worktree-name-sanitization (2019-03-11) 2 commits
 - SQUASH???
 - worktree add: sanitize worktree names

 In recent versions of Git, per-worktree refs are exposed in
 refs/worktrees/<wtname>/ hierarchy, which means that worktree names
 must be a valid refname component.  The code now sanitizes the names
 given to worktrees, to make sure these refs are not malforked.


* ra/t3600-test-path-funcs (2019-03-08) 3 commits
 - t3600: use helpers to replace test -d/f/e/s <path>
 - t3600: modernize style
 - test functions: add function `test_file_not_empty`

 A GSoC micro.

 Will merge to 'next'.
 cf. <20190304120801.28763-1-rohit.ashiwal265@gmail.com> (v3)


* dl/reset-doc-no-wrt-abbrev (2019-03-06) 1 commit
 - git-reset.txt: clarify documentation

 Doc update.

 Will merge to 'next'.


* ja/dir-rename-doc-markup-fix (2019-03-06) 1 commit
 - Doc: fix misleading asciidoc formating

 Doc update.

 Will merge to 'next'.


* bp/post-index-change-hook (2019-02-15) 1 commit
  (merged to 'next' on 2019-03-11 at cb96d1d7c4)
 + read-cache: add post-index-change hook

 Originally merged to 'next' on 2019-02-23

 A new hook "post-index-change" is called when the on-disk index
 file changes, which can help e.g. a virtualized working tree
 implementation.

 Will cook in 'next'.


* jc/format-patch-error-check (2019-02-22) 3 commits
 - format-patch: --no-clobber refrains from overwriting output files
 - format-patch: notice failure to open cover letter for writing
 - builtin/log: downcase the beginning of error messages

 "git format-patch" used overwrite an existing patch/cover-letter
 file.  A new "--no-clobber" option stops it.

 Will merge to 'next' after dropping the tip commit.
 I think the bottom two were indenendently good changes; the top one
 was met with "Meh" by reviewer(s), and I tend to agree.


* ab/makefile-help-devs-more (2019-02-24) 6 commits
  (merged to 'next' on 2019-03-11 at 898f5f44bc)
 + Makefile: allow for combining DEVELOPER=1 and CFLAGS="..."
 + Makefile: move the setting of *FLAGS closer to "include"
 + Makefile: Move *_LIBS assignment into its own section
 + Makefile: add/remove comments at top and tweak whitespace
 + Makefile: move "strip" assignment down from flags
 + Makefile: remove an out-of-date comment

 Originally merged to 'next' on 2019-03-07

 CFLAGS now can be tweaked when invoking Make while using
 DEVELOPER=YesPlease; this did not work well before.

 Will merge to 'master'.


* jt/fetch-cdn-offload (2019-03-12) 9 commits
 - SQUASH???
 - upload-pack: send part of packfile response as uri
 - fetch-pack: support more than one pack lockfile
 - upload-pack: refactor reading of pack-objects out
 - Documentation: add Packfile URIs design doc
 - Documentation: order protocol v2 sections
 - http-fetch: support fetching packfiles by URL
 - http: improve documentation of http_pack_request
 - http: use --stdin when getting dumb HTTP pack

 WIP for allowing a response to "git fetch" to instruct the bulk of
 the pack contents to be instead taken from elsewhere (aka CDN).


* dl/submodule-set-branch (2019-02-08) 3 commits
 - submodule: teach set-branch subcommand
 - submodule--helper: teach config subcommand --unset
 - git-submodule.txt: "--branch <branch>" option defaults to 'master'

 "git submodule" learns "set-branch" subcommand that allows the
 submodule.*.branch settings to be modified.

 Needs sign-off on the tip commit; other than that it seems OK to be in 'next'.


* dm/some-stdio-functions-are-macro-on-freebsd (2019-02-01) 1 commit
 - http: cast result to FILE *

 Variants of BSD define fileno(fh) as a macro, breaking a program
 that passes a "void *" to it.

 Expecting a reroll.
 cf. <49B9198C-53E5-42BD-8834-B1EDEB3332CB@usask.ca>


* ds/commit-graph-format-v2 (2019-01-29) 8 commits
 - SQUASH : misnamed variables and style fix
 - commit-graph: test verifying a corrupt v2 header
 - commit-graph: implement file format version 2
 - commit-graph: add --version=<n> option
 - commit-graph: create new version flags
 - commit-graph: collapse parameters into flags
 - commit-graph: return with errors during write
 - Merge branch 'bc/sha-256' into ds/commit-graph-format-v2

 Introduce version 2 of the commit-graph format to correct
 deficiency in the initial version.

 Needs update before merging to 'next'.


* sx/evolve (2019-02-15) 8 commits
 . evolve: add the git change list command
 . evolve: implement the git change command
 . evolve: add support for writing metacommits
 . evolve: add the change-table structure
 . evolve: add support for parsing metacommits
 . ref-filter: add the metas namespace to ref-filter
 . sha1-array: implement oid_array_readonly_contains
 . technical doc: add a design doc for the evolve command

 The beginning of "hg evolve" mimicry.


* br/blame-ignore (2019-02-13) 6 commits
 - SQUASH???
 - blame: add tests for ignoring revisions
 - blame: add a config option to mark ignored lines
 - blame: add the ability to ignore commits and their changes
 - blame: use a helper function in blame_chunk()
 - Move init_skiplist() outside of fsck

 "git blame" learned to "ignore" commits in the history, whose
 effects (as well as their presence) get ignored.

 Needs update before merging to 'next'.


* nd/config-move-to (2019-01-14) 7 commits
 - config.h: fix hdr-check warnings
 - config: add --move-to
 - config: factor out set_config_source_file()
 - config: use OPT_FILENAME()
 - config.c: add repo_config_set_worktree_gently()
 - worktree.c: add get_worktree_config()
 - config.c: avoid git_path() in do_git_config_sequence()

 Needs review.


* ma/clear-repository-format (2019-03-01) 2 commits
  (merged to 'next' on 2019-03-11 at f3db1c278f)
 + setup: fix memory leaks with `struct repository_format`
 + setup: free old value before setting `work_tree`

 Originally merged to 'next' on 2019-03-07

 The setup code has been cleaned up to avoid leaks around the
 repository_format structure.

 Will merge to 'master'.


* dl/merge-cleanup-scissors-fix (2019-03-18) 11 commits
 - cherry-pick/revert: add scissors line on merge conflict
 - sequencer.c: define describe_cleanup_mode
 - merge: add scissors line on merge conflict
 - merge: cleanup messages like commit
 - sequencer.c: remove duplicate code
 - parse-options.h: extract common --cleanup option
 - commit: extract cleanup_mode functions to sequencer
 - t7502: clean up test style
 - t7604: refactor out Git commands upstream of pipe
 - t3507: cleanup space after redirection operators
 - t7600: clean up style

 The list of conflicted paths shown in the editor while concluding a
 conflicted merge was shown above the scissors line when the
 clean-up mode is set to "scissors", even though it was commented
 out just like the list of updated paths and other information to
 help the user explain the merge better.

 Getting there ;-)
 cf. <cover.1552275703.git.liu.denton@gmail.com> (v7)
 Expecting v9.


* jn/unknown-index-extensions (2018-11-21) 2 commits
 - index: offer advice for unknown index extensions
 - index: do not warn about unrecognized extensions

 A bit too alarming warning given when unknown index extensions
 exist is getting revamped.

 Expecting a reroll.


* ag/sequencer-reduce-rewriting-todo (2019-03-07) 18 commits
 - rebase--interactive: move transform_todo_file()
 - sequencer: use edit_todo_list() in complete_action()
 - rebase-interactive: rewrite edit_todo_list() to handle the initial edit
 - rebase-interactive: append_todo_help() changes
 - rebase-interactive: use todo_list_write_to_file() in edit_todo_list()
 - sequencer: refactor skip_unnecessary_picks() to work on a todo_list
 - rebase--interactive: move rearrange_squash_in_todo_file()
 - rebase--interactive: move sequencer_add_exec_commands()
 - sequencer: change complete_action() to use the refactored functions
 - sequencer: make sequencer_make_script() write its script to a strbuf
 - sequencer: refactor rearrange_squash() to work on a todo_list
 - sequencer: refactor sequencer_add_exec_commands() to work on a todo_list
 - sequencer: refactor check_todo_list() to work on a todo_list
 - sequencer: introduce todo_list_write_to_file()
 - sequencer: refactor transform_todos() to work on a todo_list
 - sequencer: remove the 'arg' field from todo_item
 - sequencer: make the todo_list structure public
 - sequencer: changes in parse_insn_buffer()

 The scripted version of "git rebase -i" wrote and rewrote the todo
 list many times during a single step of its operation, and the
 recent C-rewrite made a faithful conversion of the logic to C.  The
 implementation has been updated to carry necessary information
 around in-core to avoid rewriting the same file over and over
 unnecessarily.

 Will merge to 'next'.
 cf. <20190305191805.13561-1-alban.gruin@gmail.com> (v8)


* ps/stash-in-c (2019-03-07) 29 commits
  (merged to 'next' on 2019-03-11 at f568e3be72)
 + tests: add a special setup where stash.useBuiltin is off
 + stash: optionally use the scripted version again
 + stash: add back the original, scripted `git stash`
 + stash: convert `stash--helper.c` into `stash.c`
 + stash: replace all `write-tree` child processes with API calls
 + stash: optimize `get_untracked_files()` and `check_changes()`
 + stash: convert save to builtin
 + stash: make push -q quiet
 + stash: convert push to builtin
 + stash: convert create to builtin
 + stash: convert store to builtin
 + stash: convert show to builtin
 + stash: convert list to builtin
 + stash: convert pop to builtin
 + stash: convert branch to builtin
 + stash: convert drop and clear to builtin
 + stash: convert apply to builtin
 + stash: mention options in `show` synopsis
 + stash: add tests for `git stash show` config
 + stash: rename test cases to be more descriptive
 + t3903: add test for --intent-to-add file
 + t3903: modernize style
 + stash: improve option parsing test coverage
 + ident: don't require calling prepare_fallback_ident first
 + ident: add the ability to provide a "fallback identity"
 + strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`
 + strbuf.c: add `strbuf_join_argv()`
 + sha1-name.c: add `get_oidf()` which acts like `get_oid()`
 + Merge branch 'sd/stash-wo-user-name'
 (this branch is used by js/stash-in-c-pathspec-fix, tb/stash-in-c-unused-param-fix and tg/stash-in-c-show-default-to-p-fix.)

 Originally merged to 'next' on 2019-03-07

 "git stash" rewritten in C.

 Will cook in 'next'.
