Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6637720305
	for <e@80x24.org>; Tue,  9 Apr 2019 18:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfDISIR (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 14:08:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35078 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfDISIR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 14:08:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so4438121wmd.0
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 11:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=PJKfLR7QKJXGSSmEvWLDwGZ89r1emLmT/+/e59tSk8o=;
        b=FxyPO0Vh3eUQcgxZOMyT9qfwRQ9rGnTAKt+PJQTGNw2gHLP0jdIYfPZ2/d+jlNta9C
         ysUwLVzXT6PU8OpKeCUZIhV/ftQFAsz2b19ENvbNTsogicZ9YcX4dnO24oEi0h01J4uH
         yVn6HzAeRSf/zD/1dC0ePVW9B54E4Km03mWatGrMtOHCx0jrb3uSzRhp+ccXk/wVayq0
         nIgF7xOtvr7uMzM8JHoMRcwaTe8Wz71vFXN9tBVssgC7Eg5uHO47/ubARaSunzdMgruo
         Ue4JKkx8vs19FLuPY3+8K97/dIsN6AcG8jpqRQnO0o2h72OMoCH5d57n486Xio5P8slb
         2uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=PJKfLR7QKJXGSSmEvWLDwGZ89r1emLmT/+/e59tSk8o=;
        b=QwyNMW+Z6FT6dKo6frOi/H5auG9IcP5hjzmdYz+mobfvsL5Dun/S0MiPwHGQRJAokT
         LnFf8u29CgbXFu/K57fO1pnxiwDVo/90NTRnJsZYV1z+6ykPxCj1eMw8gWygRDbkZeXm
         ITuyBs0Nvn+rIxax2oTxUFi43pja3Jic0CfFYG5YtkGUsI9em7skwk8lu1vYG1hXPmTT
         DlaYJH4aeR04Y3uRSWDqBzzr7B0bOweP3ZZo9TKVwN8E9IgDwaw3YFPx+VIrjvm/j9E+
         wrfv2VY3dlvJmuJz9+b/OXNidcb/Qgyi7Uao/DM5W1EjVs2Qf6kH0IH7UUASfKlsXwPv
         jKlw==
X-Gm-Message-State: APjAAAWeJKCiTdfzc5KgU+KVho3A8kbHRfFTnm+nOwpbyeiPye6LDaDm
        D24IbhltCQZ7TJQp9/Zov5HFNfLjHJKt2rQM
X-Google-Smtp-Source: APXvYqwtrMR0s2oMv2ITNyyFcgeAupKu64vStZ7NKi0OpODS2/vcBGU2PkZ8/31QfAoSpV/q6qW5cQ==
X-Received: by 2002:a1c:6c09:: with SMTP id h9mr3034054wmc.130.1554833291642;
        Tue, 09 Apr 2019 11:08:11 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id o5sm12994137wmc.16.2019.04.09.11.08.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 11:08:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Apr 2019, #02; Wed, 10)
X-master-at: e35b8cb8e212e3557efc565157ceb5cbaaf0d87f
X-next-at: 511ec345e18b91bfc070cff61e34b433cb3e5a41
Date:   Wed, 10 Apr 2019 03:08:09 +0900
Message-ID: <xmqqr2ab2gs6.fsf@gitster-ct.c.googlers.com>
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

Sorry for keeping a rather huge backlog for the past few weeks.  As
the result, tonight's pushout is a rather large one, merging 30+
topics to 'next' and a dozen or so to 'master'.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ar/t4150-remove-cruft (2019-03-13) 1 commit
  (merged to 'next' on 2019-03-20 at a0106a8d5c)
 + t4150: remove unused variable

 Test cleanup.


* dl/ignore-docs (2019-03-08) 2 commits
  (merged to 'next' on 2019-03-20 at f1f50c07ef)
 + docs: move core.excludesFile from git-add to gitignore
 + git-clean.txt: clarify ignore pattern files

 Doc update.


* dl/reset-doc-no-wrt-abbrev (2019-03-06) 1 commit
  (merged to 'next' on 2019-03-20 at 984b4586c7)
 + git-reset.txt: clarify documentation

 Doc update.


* ja/dir-rename-doc-markup-fix (2019-03-06) 1 commit
  (merged to 'next' on 2019-03-20 at f3238df381)
 + Doc: fix misleading asciidoc formating

 Doc update.


* jh/resize-convert-scratch-buffer (2019-03-08) 1 commit
  (merged to 'next' on 2019-03-20 at 92a24b29ed)
 + convert: avoid malloc of original file size

 When the "clean" filter can reduce the size of a huge file in the
 working tree down to a small "token" (a la Git LFS), there is no
 point in allocating a huge scratch area upfront, but the buffer is
 sized based on the original file size.  The convert mechanism now
 allocates very minimum and reallocates as it receives the output
 from the clean filter process.


* jk/line-log-with-patch (2019-03-11) 2 commits
  (merged to 'next' on 2019-03-20 at 21afea908c)
 + line-log: detect unsupported formats
 + line-log: suppress diff output with "-s"

 "git log -L<from>,<to>:<path>" with "-s" did not suppress the patch
 output as it should.  This has been corrected.


* jk/promote-ggg (2019-03-13) 1 commit
  (merged to 'next' on 2019-03-20 at 3db7d2566d)
 + point pull requesters to GitGitGadget

 Suggest GitGitGadget instead of submitGit as a way to submit
 patches based on GitHub PR to us.


* jk/sha1dc (2019-03-13) 1 commit
  (merged to 'next' on 2019-03-20 at 969280e8e5)
 + Makefile: fix unaligned loads in sha1dc with UBSan

 Build update for SHA-1 with collision detection.


* js/rebase-deprecate-preserve-merges (2019-03-12) 1 commit
  (merged to 'next' on 2019-03-20 at 32baac3acd)
 + rebase: deprecate --preserve-merges

 "git rebase --rebase-merges" replaces its old "--preserve-merges"
 option; the latter is now marked as deprecated.


* jt/submodule-fetch-errmsg (2019-03-14) 1 commit
  (merged to 'next' on 2019-03-20 at a6b0efa76f)
 + submodule: explain first attempt failure clearly

 Error message update.
 cf. <20190313175738.252961-1-jonathantanmy@google.com> (v2)


* ms/worktree-add-atomic-mkdir (2019-03-12) 1 commit
  (merged to 'next' on 2019-03-20 at ded442ed02)
 + worktree: fix worktree add race

 "git worktree add" used to do a "find an available name with stat
 and then mkdir", which is race-prone.  This has been fixed by using
 mkdir and reacting to EEXIST in a loop.


* nd/rewritten-ref-is-per-worktree (2019-03-08) 3 commits
  (merged to 'next' on 2019-03-20 at 5369a2e1f6)
 + Make sure refs/rewritten/ is per-worktree
 + files-backend.c: reduce duplication in add_per_worktree_entries_to_dir()
 + files-backend.c: factor out per-worktree code in loose_fill_ref_dir()

 "git rebase" uses the refs/rewritten/ hierarchy to store its
 intermediate states, which inherently makes the hierarchy per
 worktree, but it didn't quite work well.


* ra/t3600-test-path-funcs (2019-03-08) 3 commits
  (merged to 'next' on 2019-03-20 at 404110d291)
 + t3600: use helpers to replace test -d/f/e/s <path>
 + t3600: modernize style
 + test functions: add function `test_file_not_empty`

 A GSoC micro.
 cf. <20190304120801.28763-1-rohit.ashiwal265@gmail.com> (v3)

--------------------------------------------------
[New Topics]

* bs/sendemail-tighten-anything-by (2019-04-04) 1 commit
 - send-email: don't cc *-by lines with '-' prefix

 The recently added feature to add addresses that are on
 anything-by: trailers in 'git send-email' was found to be way too
 eager and considered nonsense strings as if they can be legitimate
 beginning of *-by: trailer.  This has been tightened.

 Will merge to 'next'.


* da/smerge (2019-04-04) 2 commits
 - contrib/completion: add smerge to the mergetool completion candidates
 - mergetools: add support for smerge (Sublime Merge)

 "git mergetool" learned to offer Sublime Merge (smerge) as one of
 its backends.

 Will merge to 'next'.


* dl/flex-str-cocci (2019-04-04) 2 commits
 - cocci: FLEX_ALLOC_MEM to FLEX_ALLOC_STR
 - midx.c: convert FLEX_ALLOC_MEM to FLEX_ALLOC_STR

 Code clean-up.

 Will merge to 'next'.


* dl/warn-tagging-a-tag (2019-04-09) 2 commits
 - tag: advise on nested tags
 - tag: fix formatting

 "git tag" learned to give an advice suggesting it might be a
 mistake when creating an annotated or signed tag that points at
 another tag.

 Will merge to 'next'.


* jc/format-patch-delay-message-id (2019-04-05) 1 commit
 - format-patch: move message-id and related headers to the end

 The location "git format-patch --thread" adds the Message-Id:
 header in the series of header fields has been moved down, which
 may help working around a suspected bug in GMail MSA, reported at
 <CAHk-=whP1stFZNAaJiMi5eZ9rj0MRt20Y_yHVczZPH+O01d+sA@mail.gmail.com>

 Waiting for feedback to see if it truly helps.
 Needs tests.


* jk/revision-rewritten-parents-in-prio-queue (2019-04-04) 1 commit
 - revision: use a prio_queue to hold rewritten parents

 Performance fix for "rev-list --parents -- pathspec".

 Will merge to 'next'.


* tb/unexpected (2019-04-05) 7 commits
 - rev-list: detect broken root trees
 - rev-list: let traversal die when --missing is not in use
 - get_commit_tree(): return NULL for broken tree
 - list-objects.c: handle unexpected non-tree entries
 - list-objects.c: handle unexpected non-blob entries
 - t: introduce tests for unexpected object types
 - t: move 'hex2oct' into test-lib-functions.sh

 Code tightening against a "wrong" object appearing where an object
 of a different type is expected, instead of blindly assuming that
 the connection between objects are correctly made.

 Waiting for a reroll.
 cf. <20190406053308.GC37216@Taylors-MBP.hsd1.wa.comcast.net>


* en/merge-directory-renames (2019-04-08) 15 commits
 - merge-recursive: switch directory rename detection default
 - merge-recursive: give callers of handle_content_merge() access to contents
 - merge-recursive: track information associated with directory renames
 - t6043: fix copied test description to match its purpose
 - merge-recursive: switch from (oid,mode) pairs to a diff_filespec
 - merge-recursive: cleanup handle_rename_* function signatures
 - merge-recursive: track branch where rename occurred in rename struct
 - merge-recursive: remove ren[12]_other fields from rename_conflict_info
 - merge-recursive: shrink rename_conflict_info
 - merge-recursive: move some struct declarations together
 - merge-recursive: use 'ci' for rename_conflict_info variable name
 - merge-recursive: rename locals 'o' and 'a' to 'obuf' and 'abuf'
 - merge-recursive: rename diff_filespec 'one' to 'o'
 - merge-recursive: rename merge_options argument from 'o' to 'opt'
 - Use 'unsigned short' for mode, like diff_filespec does

 "git merge-recursive" backend recently learned a new heuristics to
 infer file movement based on how other files in the same directory
 moved.  As this is inherently less robust heuristics than the one
 based on the content similarity of the file itself (rather than
 based on what its neighbours are doing), it sometimes gives an
 outcome unexpected by the end users.  This has been toned down to
 leave the renamed paths in higher/conflicted stages in the index so
 that the user can examine and confirm the result.

 Will merge to 'next'.


* jk/server-info-rabbit-hole (2019-04-08) 14 commits
 - update_info_refs(): drop unused force parameter
 - server-info: drop objdirlen pointer arithmetic
 - server-info: drop nr_alloc struct member
 - server-info: use strbuf to read old info/packs file
 - server-info: simplify cleanup in parse_pack_def()
 - server-info: fix blind pointer arithmetic
 - http: simplify parsing of remote objects/info/packs
 - packfile: fix pack basename computation
 - midx: check both pack and index names for containment
 - t5319: drop useless --buffer from cat-file
 - t5319: fix bogus cat-file argument
 - pack-revindex: open index if necessary
 - SQUASH???
 - packfile.h: drop extern from function declarations

 Code clean-up around a much-less-important-than-it-used-to-be
 update_server_info() funtion.

 Will merge to 'next' after squashing the SQUASH?? in.


* js/rev-list-exclude-promisor-objects (2019-04-09) 1 commit
 - rev-list: exclude promisor objects at walk time

 "git rev-list --exclude-promisor-objects" learned not to bother
 enumerating all promisor objects, and instead filter these objects
 at walk time for performance.

 Getting there.
 cf. <xmqqo95f43dq.fsf@gitster-ct.c.googlers.com>


* jt/clone-server-option (2019-04-09) 1 commit
 - clone: send server options when using protocol v2

 "git clone" learned a new --server-option option when talking over
 the protocol version 2.

 Getting there.
 cf. <xmqqk1g342xi.fsf@gitster-ct.c.googlers.com>
 cf. <20190406115728.GB219876@google.com>


* po/describe-not-necessarily-7 (2019-04-08) 1 commit
 - describe doc: remove '7-char' abbreviation reference

 Docfix.

 Will merge to 'next'.


* po/rerere-doc-fmt (2019-04-08) 1 commit
 - rerere doc: quote `rerere.enabled`

 Docfix.

 Will merge to 'next'.


* sg/blame-in-bare-start-at-head (2019-04-08) 1 commit
 - blame: default to HEAD in a bare repo when no start commit is given

 "git blame -- path" in a non-bare repository starts blaming from
 the working tree, and the same command in a bare repository errors
 out because there is no working tree by definition.  The command
 has been taught to instead start blaming from the commit at HEAD,
 which is more useful.

 Will merge to 'next'.


* tg/ls-files-debug-format-fix (2019-04-08) 1 commit
 - ls-files: use correct format string

 Debugging code fix.

 Will merge to 'next'.


* tz/doc-apostrophe-no-longer-needed (2019-04-08) 1 commit
 - Documentation/git-show-branch: drop last use of {apostrophe}

 Doc formatting fix.

 Will merge to 'next'.


* tz/git-svn-doc-markup-fix (2019-04-08) 1 commit
 - Documentation/git-svn: improve asciidoctor compatibility

 Doc formatting fix.

 Needs a better description.
 cf. <CAN0heSpL_pQMtDaEdDgcsC_Sso45owHjRttrdp7cQdYOb7i9BA@mail.gmail.com>


* js/t3301-unbreak-notes-test (2019-04-09) 1 commit
 - t3301: fix false negative

 Test fix.

 Will merge to 'next'.


* ss/msvc-path-utils-fix (2019-04-09) 1 commit
 - MSVC: include compat/win32/path-utils.h for MSVC, too, for real_path()

 An earlier update for MinGW and Cygwin accidentally broke MSVC build,
 which has been fixed.

 May want to clarify the log message?
 cf. <af640e82-ca1a-9c96-da47-62aaea1cc18e@web.de>

--------------------------------------------------
[Stalled]

* nb/branch-show-other-worktrees-head (2019-03-18) 3 commits
 - branch: add worktree info on verbose output
 - branch: update output to include worktree info
 - ref-filter: add worktreepath atom

 "git branch --list" learned to show branches that are checked out
 in other worktrees connected to the same repository prefixed with
 '+', similar to the way the currently checked out branch is shown
 with '*' in front.

 Getting there...
 cf. <20190316013807.38756-1-nbelakovski@gmail.com> (v9)
 cf. <20190318121054.GC24175@szeder.dev>


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

 Waiting for the final version.


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

--------------------------------------------------
[Cooking]

* tb/stash-in-c-unused-param-fix (2019-03-11) 1 commit
  (merged to 'next' on 2019-03-20 at 5ccac5f80d)
 + stash: drop unused parameter
 (this branch uses ps/stash-in-c; is tangled with js/stash-in-c-pathspec-fix and tg/stash-in-c-show-default-to-p-fix.)

 Code clean-up.

 Will cook in 'next'.


* dl/subtree-limit-to-one-rev (2019-03-12) 1 commit
  (merged to 'next' on 2019-04-10 at 8631f869c5)
 + contrib/subtree: ensure only one rev is provided

 "git subtree" (in contrib/) update.

 Will merge to 'master'.


* cb/doco-mono (2019-03-13) 2 commits
 - doc: format pathnames and URLs as monospace.
 - doc/CodingGuidelines: URLs and paths as monospace

 Clean-up markup in the documentation suite.

 Will merge to 'next'.


* cc/multi-promisor (2019-04-08) 13 commits
 - SQUASH??? do not include fetch-objects.h
 - SQUASH??? r->name[] is a flexarray that cannot be NULL
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

 Expecting a reroll.

 An earlier breakage on 'pu' due to incorrect semantic conflict
 resolution has been corrected.


* nd/switch-and-restore (2019-04-02) 39 commits
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
 - switch: make --orphan switch to an empty tree
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
 - checkout: inform the user when removing branch state
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

 cf. <20190329103919.15642-1-pclouds@gmail.com> (switch v6)
 cf. <20190308101655.9767-1-pclouds@gmail.com> (restore v1)


* ab/doc-misc-typofixes (2019-03-18) 1 commit
  (merged to 'next' on 2019-04-10 at 06d19acd7e)
 + doc: fix typos in man pages

 Typofixes.

 Will merge to 'master'.


* ab/drop-scripted-rebase (2019-03-20) 1 commit
  (merged to 'next' on 2019-04-10 at ff8abf36ae)
 + rebase: remove the rebase.useBuiltin setting

 Retire scripted "git rebase" implementation.

 Will merge to 'master'.


* ab/gc-reflog (2019-04-01) 7 commits
 - gc: handle & check gc.reflogExpire config
 - reflog tests: assert lack of early exit with expiry="never"
 - reflog tests: test for the "points nowhere" warning
 - reflog tests: make use of "test_config" idiom
 - gc: refactor a "call me once" pattern
 - gc: convert to using the_hash_algo
 - gc: remove redundant check for gc_auto_threshold

 Fix various glitches in "git gc" around reflog handling.

 Will merge to 'next'.


* ew/repack-with-bitmaps-by-default (2019-03-18) 3 commits
 - pack-objects: default to writing bitmap hash-cache
 - t5310: correctly remove bitmaps for jgit test
 - repack: enable bitmaps by default on bare repos

 The connectivity bitmaps are created by default in bare
 repositories now; also the pathname hash-cache is created by
 default to avoid making crappy deltas when repacking.

 Will merge to 'next'.


* jk/perf-lib-tee (2019-03-18) 1 commit
  (merged to 'next' on 2019-04-10 at de18327138)
 + perf-lib.sh: rely on test-lib.sh for --tee handling

 Code cleanup in the test framework.

 Will merge to 'master'.


* js/check-docs-exe (2019-04-01) 5 commits
 - check-docs: fix for setups where executables have an extension
 - check-docs: do not expect guide pages to correspond to commands
 - check-docs: really look at the documented commands again
 - docs: do not document the `git remote-testgit` command
 - docs: move gitremote-helpers into section 7

 Dev support update.

 Will merge to 'next'.


* js/difftool-no-index (2019-03-18) 3 commits
 - difftool: allow running outside Git worktrees with --no-index
 - parse-options: make OPT_ARGUMENT() more useful
 - difftool: remove obsolete (and misleading) comment

 "git difftool" can now run outside a repository.

 Will merge to 'next'.


* js/get-short-oid-drop-cache (2019-03-14) 4 commits
  (merged to 'next' on 2019-04-10 at 5c77e39722)
 + get_oid(): when an object was not found, try harder
 + sequencer: move stale comment into correct location
 + sequencer: improve error message when an OID could not be parsed
 + rebase -i: demonstrate obscure loose object cache bug

 A corner-case object name ambiguity while the sequencer machinery
 is working (e.g. "rebase -i -x") has been (half) fixed.

 Will merge to 'master'.


* ma/doc-diff-doc-vs-doctor-comparison (2019-03-18) 4 commits
  (merged to 'next' on 2019-04-10 at af08a97ab9)
 + doc-diff: add `--cut-header-footer`
 + doc-diff: support diffing from/to AsciiDoc(tor)
 + doc-diff: let `render_tree()` take an explicit directory name
 + Doc: auto-detect changed build flags

 Dev support update to make it easier to compare two formatted
 results from our documentation.

 Will merge to 'master'.
 cf. <20190319031412.GC6173@sigill.intra.peff.net>


* mh/pack-protocol-doc-fix (2019-03-18) 1 commit
  (merged to 'next' on 2019-04-10 at 037673d71c)
 + fix pack protocol example client/server communication

 Docfix.

 Will merge to 'master'.


* nd/checkout-f-while-conflicted-fix (2019-03-21) 1 commit
  (merged to 'next' on 2019-04-10 at 1afc977435)
 + unpack-trees: fix oneway_merge accidentally carry over stage index

 "git checkout -f <branch>" while the index has an unmerged path
 incorrectly left some paths in an unmerged state, which has been
 corrected.

 Will merge to 'master'.


* pw/cherry-pick-continue (2019-03-18) 3 commits
 - cherry-pick --continue: remember options
 - cherry-pick: demonstrate option amnesia
 - sequencer: break some long lines

 "git cherry-pick --options A..B", after giving control back to the
 user to ask help resolving a conflicted step, did not honor the
 options it originally received, which has been corrected.

 Will merge to 'next'.


* pw/rerere-autoupdate (2019-03-18) 2 commits
  (merged to 'next' on 2019-04-10 at cf79e86682)
 + merge: tweak --rerere-autoupdate documentation
 + am/cherry-pick/rebase/revert: document --rerere-autoupdate

 Doc updates.

 Will merge to 'master'.


* sg/test-atexit (2019-03-14) 11 commits
  (merged to 'next' on 2019-04-10 at 7839135291)
 + t9811-git-p4-label-import: fix pipeline negation
 + git p4 test: disable '-x' tracing in the p4d watchdog loop
 + git p4 test: simplify timeout handling
 + git p4 test: clean up the p4d cleanup functions
 + git p4 test: use 'test_atexit' to kill p4d and the watchdog process
 + t0301-credential-cache: use 'test_atexit' to stop the credentials helper
 + tests: use 'test_atexit' to stop httpd
 + git-daemon: use 'test_atexit` to stop 'git-daemon'
 + test-lib: introduce 'test_atexit'
 + t/lib-git-daemon: make sure to kill the 'git-daemon' process
 + test-lib: fix interrupt handling with 'dash' and '--verbose-log -x'

 Test framework update to more robustly clean up leftover files and
 processes after tests are done.

 Will merge to 'master'.


* tb/trace2-va-list-fix (2019-03-20) 1 commit
  (merged to 'next' on 2019-04-10 at 94fe0f66d8)
 + trace2: NULL is not allowed for va_list

 Fix some code that passed a NULL when a va_list was expected.

 Will merge to 'master'.


* tg/glossary-overlay (2019-03-18) 1 commit
  (merged to 'next' on 2019-04-10 at f5415c65cc)
 + glossary: add definition for overlay

 Doc update.

 Will merge to 'master'.


* tg/stash-in-c-show-default-to-p-fix (2019-03-21) 1 commit
  (merged to 'next' on 2019-04-10 at 9489a31a36)
 + stash: setup default diff output format if necessary
 (this branch uses ps/stash-in-c; is tangled with js/stash-in-c-pathspec-fix and tb/stash-in-c-unused-param-fix.)

 A regression fix.

 Will merge to 'master'.


* tz/completion (2019-03-21) 4 commits
  (merged to 'next' on 2019-04-10 at a26ec8420f)
 + completion: use __git when calling --list-cmds
 + completion: fix multiple command removals
 + t9902: test multiple removals via completion.commands
 + git: read local config in --list-cmds

 The completion helper code now pays attention to repository-local
 configuration (when available), which allows --list-cmds to honour
 a repository specific setting of completion.commands, for example.

 Will merge to 'master'.
 cf. <20190320180329.22280-1-tmz@pobox.com> (v3)


* tz/t4038-bash-redirect-target-workaround (2019-03-18) 1 commit
  (merged to 'next' on 2019-04-10 at 9845123f19)
 + t4038-diff-combined: quote paths with whitespace

 Work-around extra warning from bash in our tests.

 Will merge to 'master'.


* jc/format-patch-noclobber (2019-02-22) 1 commit
 - format-patch: --no-clobber refrains from overwriting output files
 (this branch uses jc/format-patch-error-check.)


* jk/unused-params-even-more (2019-03-21) 13 commits
  (merged to 'next' on 2019-04-10 at 12edf8872f)
 + parse_opt_ref_sorting: always use with NONEG flag
 + pretty: drop unused strbuf from parse_padding_placeholder()
 + pretty: drop unused "type" parameter in needs_rfc2047_encoding()
 + parse-options: drop unused ctx parameter from show_gitcomp()
 + fetch_pack(): drop unused parameters
 + report_path_error(): drop unused prefix parameter
 + unpack-trees: drop unused error_type parameters
 + unpack-trees: drop name_entry from traverse_by_cache_tree()
 + test-date: drop unused "now" parameter from parse_dates()
 + update-index: drop unused prefix_length parameter from do_reupdate()
 + log: drop unused "len" from show_tagger()
 + log: drop unused rev_info from early output
 + revision: drop some unused "revs" parameters

 Code cleanup.

 Will merge to 'master'.


* ab/commit-graph-fixes (2019-04-01) 8 commits
 - commit-graph: improve & i18n error messages
 - commit-graph write: don't die if the existing graph is corrupt
 - commit-graph verify: detect inability to read the graph
 - commit-graph: don't pass filename to load_commit_graph_one_fd_st()
 - commit-graph: don't early exit(1) on e.g. "git status"
 - commit-graph: fix segfault on e.g. "git status"
 - commit-graph tests: test a graph that's too small
 - commit-graph tests: split up corrupt_graph_and_verify()

 Code cleanup with more careful error checking before using data
 read from the commit-graph file.

 Will merge to 'next'.


* ab/gc-docs (2019-04-08) 11 commits
 - gc docs: remove incorrect reference to gc.auto=0
 - gc docs: clarify that "gc" doesn't throw away referenced objects
 - gc docs: note "gc --aggressive" in "fast-import"
 - gc docs: downplay the usefulness of --aggressive
 - gc docs: note how --aggressive impacts --window & --depth
 - gc docs: fix formatting for "gc.writeCommitGraph"
 - gc docs: re-flow the "gc.*" section in "config"
 - gc docs: include the "gc.*" section from "config" in "gc"
 - gc docs: clean grammar for "gc.bigPackThreshold"
 - gc docs: stop noting "repack" flags
 - gc docs: modernize the advice for manually running "gc"

 Update docs around "gc".

 Will merge to 'next'.


* ab/test-lib-pass-trace2-env (2019-04-01) 1 commit
 - test-lib: whitelist GIT_TR2_* in the environment

 Allow tracing of Git executable while running out tests.

 Will merge to 'next'.


* am/p4-branches-excludes (2019-04-02) 8 commits
 - git-p4: respect excluded paths when detecting branches
 - git-p4: add failing test for "git-p4: respect excluded paths when detecting branches"
 - git-p4: don't exclude other files with same prefix
 - git-p4: add failing test for "don't exclude other files with same prefix"
 - git-p4: don't groom exclude path list on every commit
 - git-p4: match branches case insensitively if configured
 - git-p4: add failing test for "git-p4: match branches case insensitively if configured"
 - git-p4: detect/prevent infinite loop in gitCommitByP4Change()

 "git p4" update.

 Is this ready for 'next'?


* bb/unicode-12 (2019-03-22) 1 commit
  (merged to 'next' on 2019-04-10 at b0dfa1001e)
 + unicode: update the width tables to Unicode 12

 Unicode update.

 Will merge to 'master'.


* bc/hash-transition-16 (2019-04-01) 35 commits
 - gitweb: make hash size independent
 - Git.pm: make hash size independent
 - read-cache: read data in a hash-independent way
 - dir: make untracked cache extension hash size independent
 - builtin/difftool: use parse_oid_hex
 - refspec: make hash size independent
 - archive: convert struct archiver_args to object_id
 - builtin/get-tar-commit-id: make hash size independent
 - get-tar-commit-id: parse comment record
 - hash: add a function to lookup hash algorithm by length
 - remote-curl: make hash size independent
 - http: replace sha1_to_hex
 - http: compute hash of downloaded objects using the_hash_algo
 - http: replace hard-coded constant with the_hash_algo
 - http-walker: replace sha1_to_hex
 - http-push: remove remaining uses of sha1_to_hex
 - http-backend: allow 64-character hex names
 - http-push: convert to use the_hash_algo
 - builtin/pull: make hash-size independent
 - builtin/am: make hash size independent
 - fast-import: replace sha1_to_hex
 - fast-import: make hash-size independent
 - builtin/name-rev: make hash-size independent
 - object-store: rename and expand packed_git's sha1 member
 - notes: replace sha1_to_hex
 - notes: make hash size independent
 - notes-merge: switch to use the_hash_algo
 - submodule: avoid hard-coded constants
 - pack-bitmap: switch hash tables to use struct object_id
 - pack-bitmap: switch hard-coded constants to the_hash_algo
 - pack-bitmap: replace sha1_to_hex
 - pack-bitmap: convert struct stored_bitmap to object_id
 - pack-bitmap: make bitmap header handling hash agnostic
 - khash: move oid hash table definition
 - t/lib-submodule-update: use appropriate length constant

 Conversion from unsigned char[20] to struct object_id continues.

 Will merge to 'next'.


* cc/replace-graft-peel-tags (2019-04-01) 4 commits
 - replace: fix --graft when passing a tag first
 - replace: fix --graft when passing a tag as parent
 - t6050: redirect expected error output to a file
 - t6050: use test_line_count instead of wc -l

 When given a tag that points at a commit-ish, "git replace --graft"
 failed to peel the tag before writing a replace ref, which did not
 make sense because the old graft mechanism the feature wants to
 mimick only allowed to replace one commit object with another.
 This has been fixed.

 The title of the top two commits are fairly useless and does not
 say how the issue was fixed, but the fix is to peel the given tag
 ourselves down to the underlying commit object.

 Will merge to 'next'.


* dk/blame-keep-origin-blob (2019-04-03) 1 commit
 - blame.c: don't drop origin blobs as eagerly

 Performance fix around "git blame", especially in a linear history
 (which is the norm we should optimize for).

 Will merge to 'next'.


* dl/rebase-i-keep-base (2019-04-08) 5 commits
 - rebase: teach rebase --keep-base
 - rebase: fast-forward --onto in more cases
 - t3432: test rebase fast-forward behavior
 - t3431: add rebase --fork-point tests
 - tests (rebase): spell out the `--keep-empty` option
 (this branch is tangled with js/spell-out-options-in-tests.)

 "git rebase --keep-base <upstream>" tries to find the original base
 of the topic being rebased and rebase on top of that same base, which
 is useful when running the "git rebase -i" (and its limited variant
 "git rebase -x").

 Will merge to 'next'.


* en/fast-import-parsing-fix (2019-04-01) 5 commits
 - fast-import: fix erroneous handling of get-mark with empty orphan commits
 - fast-import: only allow cat-blob requests where it makes sense
 - fast-import: check most prominent commands first
 - git-fast-import.txt: fix wording about where ls command can appear
 - t9300: demonstrate bug with get-mark and empty orphan commits

 "git fast-import" update.

 Will merge to 'next'.


* jh/midx-verify-too-many-packs (2019-03-22) 4 commits
  (merged to 'next' on 2019-04-10 at 2ac6c933d4)
 + midx: during verify group objects by packfile to speed verification
 + midx: add progress indicators in multi-pack-index verify
 + trace2:data: add trace2 data to midx
 + progress: add sparse mode to force 100% complete message

 "git multi-pack-index verify" did not scale well with the number of
 packfiles, which is being improved.

 Will merge to 'master'.


* jh/trace2-sid-fix (2019-04-01) 7 commits
 - trace2: make SIDs more unique
 - trace2: clarify UTC datetime formatting
 - trace2: report peak memory usage of the process
 - trace2: use system config for default trace2 settings
 - trace2: find exec-dir before trace2 initialization
 - trace2: add absolute elapsed time to start event
 - trace2: refactor setting process starting time

 Polishing of the new trace2 facility continues.  The system-level
 configuration can specify site-wide trace2 settings (which would be
 loved by big-brother types ;-).

 Getting closer but still being discussed.
 cf. <20190403000032.GA190454@google.com>


* jk/http-walker-status-fix (2019-03-24) 3 commits
  (merged to 'next' on 2019-04-10 at d49336dd3b)
 + http: use normalize_curl_result() instead of manual conversion
 + http: normalize curl results for dumb loose and alternates fetches
 + http: factor out curl result code normalization

 dumb-http walker has been updated to share more error recovery
 strategy with the normal codepath.

 Will merge to 'master'.


* jk/refs-double-abort (2019-03-22) 2 commits
  (merged to 'next' on 2019-04-10 at e160d4a5b0)
 + refs/files-backend: don't look at an aborted transaction
 + refs/files-backend: handle packed transaction prepare failure

 A corner case bug in the refs API has been corrected.

 Will merge to 'master'.


* js/spell-out-options-in-tests (2019-04-02) 8 commits
 - tests: disallow the use of abbreviated options (by default)
 - tests (pack-objects): use the full, unabbreviated `--revs` option
 - tests (status): spell out the `--find-renames` option in full
 - tests (push): do not abbreviate the `--follow-tags` option
 - t5531: avoid using an abbreviated option
 - t7810: do not abbreviate `--no-exclude-standard` nor `--invert-match`
 - tests (rebase): spell out the `--force-rebase` option
 - tests (rebase): spell out the `--keep-empty` option
 (this branch is tangled with dl/rebase-i-keep-base.)

 The tests have been updated not to rely on the abbreviated option
 names the parse-options API offers, to protect us from an
 abbreviated form of an option that used to be unique within the
 command getting non-unique when a new option that share the same
 prefix is added.

 Will merge to 'next'.


* js/trace2-to-directory (2019-03-22) 1 commit
 - trace2: write to directory targets

 The trace2 tracing facility learned to auto-generate a filename
 when told to log to a directory.

 Ready for 'next'; giving the last chance to be intercepted.
 cf. <20190408211850.GJ60888@google.com>


* jt/batch-fetch-blobs-in-diff (2019-04-08) 2 commits
 - diff: batch fetching of missing blobs
 - sha1-file: support OBJECT_INFO_FOR_PREFETCH

 While running "git diff" in a lazy clone, we can upfront know which
 missing blobs we will need, instead of waiting for the on-demand
 machinery to discover them one by one.  Aim to achieve better
 performance by batching the request for these promised blobs.

 Will merge to 'next'.


* jt/fetch-no-update-shallow-in-proto-v2 (2019-04-01) 3 commits
 - fetch-pack: respect --no-update-shallow in v2
 - fetch-pack: call prepare_shallow_info only if v0
 - Merge branch 'jt/test-protocol-version' into jt/fetch-no-update-shallow-in-proto-v2
 (this branch uses jt/test-protocol-version.)

 Fix for protocol v2 support in "git fetch-pack" of shallow clones.

 Will merge to 'next'.


* jt/fetch-pack-wanted-refs-optim (2019-04-01) 1 commit
 - fetch-pack: binary search when storing wanted-refs

 Performance fix around "git fetch" that grabs many refs.

 Will merge to 'next'.


* jt/t5551-protocol-v2-does-not-have-half-auth (2019-03-24) 1 commit
  (merged to 'next' on 2019-04-10 at 86ca3ebf33)
 + t5551: mark half-auth no-op fetch test as v0-only

 Test update.

 Will merge to 'master'.


* km/empty-repo-is-still-a-repo (2019-04-03) 4 commits
 - dir: do not traverse repositories with no commits
 - t3009: test that ls-files -o traverses bogus repo
 - t3000: move non-submodule repo test to separate file
 - submodule: refuse to add repository with no commits

 Running "git add" on a repository created inside the current
 repository is an explicit indication that the user wants to add it
 as a submodule, but when the HEAD of the inner repository is on an
 unborn branch, it cannot be added as a submodule.  Worse, the files
 in its working tree can be added as if they are a part of the outer
 repository, which is not what the user wants.  These problems are
 being addressed.

 Expecting a reroll.
 cf. <87bm1mbua4.fsf@kyleam.com>


* nd/checkout-m (2019-03-24) 4 commits
 - checkout: prevent losing staged changes with --merge
 - read-tree: add --quiet
 - unpack-trees: rename "gently" flag to "quiet"
 - unpack-trees: keep gently check inside add_rejected_path

 "git checkout -m <other>" was about carrying the differences
 between HEAD and the working-tree files forward while checking out
 another branch, and ignored the differences between HEAD and the
 index.  The command has been taught to abort when the index and the
 HEAD are different.

 Will merge to 'next'.


* nd/checkout-m-doc-update (2019-03-21) 1 commit
  (merged to 'next' on 2019-04-10 at cdda4e833e)
 + checkout.txt: note about losing staged changes with --merge

 Doc about the above.

 Will merge to 'master'.


* nd/commit-a-with-paths-msg-update (2019-03-22) 1 commit
 - commit: improve error message in "-a <paths>" case

 The message given when "git commit -a <paths>" errors out has been
 updated.

 Will merge to 'next'.


* nd/diff-parseopt-4 (2019-03-24) 20 commits
  (merged to 'next' on 2019-04-10 at 893b135f10)
 + am: avoid diff_opt_parse()
 + diff --no-index: use parse_options() instead of diff_opt_parse()
 + range-diff: use parse_options() instead of diff_opt_parse()
 + diff.c: allow --no-color-moved-ws
 + diff-parseopt: convert --color-moved-ws
 + diff-parseopt: convert --[no-]color-moved
 + diff-parseopt: convert --inter-hunk-context
 + diff-parseopt: convert --no-prefix
 + diff-parseopt: convert --line-prefix
 + diff-parseopt: convert --[src|dst]-prefix
 + diff-parseopt: convert --[no-]abbrev
 + diff-parseopt: convert --diff-filter
 + diff-parseopt: convert --find-object
 + diff-parseopt: convert -O
 + diff-parseopt: convert --pickaxe-all|--pickaxe-regex
 + diff-parseopt: convert -S|-G
 + diff-parseopt: convert -l
 + diff-parseopt: convert -z
 + diff-parseopt: convert --ita-[in]visible-in-index
 + diff-parseopt: convert --ws-error-highlight
 (this branch uses nd/diff-parseopt-3.)

 Fourth batch to teach the diff machinery to use the parse-options
 API.

 Will merge to 'master'.


* nd/include-if-wildmatch (2019-04-01) 1 commit
 - config: correct '**' matching in includeIf patterns

 A buglet in configuration parser has been fixed.

 Will merge to 'next'.


* nd/interpret-trailers-docfix (2019-04-01) 1 commit
 - interpret-trailers.txt: start the desc line with a capital letter

 Doc update.

 Will merge to 'next'.


* nd/precious (2019-04-09) 1 commit
 - Introduce "precious" file concept

 "git clean" learned to pay attention to the 'precious' attributes
 and keep untracked paths with the attribute instead of removing
 when the "--keep-precious" is given.

 Will merge to 'next'.


* nd/read-tree-reset-doc (2019-04-02) 1 commit
 - read-tree.txt: clarify --reset and worktree changes

 The documentation for "git read-tree --reset -u" has been updated.

 Will merge to 'next'.


* nd/sha1-name-c-wo-the-repository (2019-04-08) 33 commits
 - sha1-name.c: remove the_repo from get_oid_mb()
 - sha1-name.c: remove the_repo from other get_oid_*
 - sha1-name.c: remove the_repo from maybe_die_on_misspelt_object_name
 - submodule-config.c: use repo_get_oid for reading .gitmodules
 - sha1-name.c: add repo_get_oid()
 - sha1-name.c: remove the_repo from get_oid_with_context_1()
 - sha1-name.c: remove the_repo from resolve_relative_path()
 - sha1-name.c: remove the_repo from diagnose_invalid_index_path()
 - sha1-name.c: remove the_repo from handle_one_ref()
 - sha1-name.c: remove the_repo from get_oid_1()
 - sha1-name.c: remove the_repo from get_oid_basic()
 - sha1-name.c: remove the_repo from get_describe_name()
 - sha1-name.c: remove the_repo from get_oid_oneline()
 - sha1-name.c: add repo_interpret_branch_name()
 - sha1-name.c: remove the_repo from interpret_branch_mark()
 - sha1-name.c: remove the_repo from interpret_nth_prior_checkout()
 - sha1-name.c: remove the_repo from get_short_oid()
 - sha1-name.c: add repo_for_each_abbrev()
 - sha1-name.c: store and use repo in struct disambiguate_state
 - sha1-name.c: add repo_find_unique_abbrev_r()
 - sha1-name.c: remove the_repo from find_abbrev_len_packed()
 - sha1-name.c: remove the_repo from sort_ambiguous()
 - commit.c: add repo_get_commit_tree()
 - refs.c: remove the_repo from read_ref_at()
 - refs.c: add repo_dwim_log()
 - refs.c: add repo_dwim_ref()
 - refs.c: remove the_repo from expand_ref()
 - refs.c: remove the_repo from substitute_branch_name()
 - refs.c: add refs_shorten_unambiguous_ref()
 - refs.c: add refs_ref_exists()
 - packfile.c: add repo_approximate_object_count()
 - builtin rebase: use oideq()
 - builtin rebase: use FREE_AND_NULL

 Further code clean-up to allow the lowest level of name-to-object
 mapping layer to work with a passed-in repository other than the
 default one.

 Will merge to 'next'.


* pw/rebase-i-internal-rfc (2019-03-21) 12 commits
 - rebase -i: run without forking rebase--interactive
 - rebase: use a common action enum
 - rebase -i: use struct rebase_options in do_interactive_rebase()
 - rebase -i: use struct rebase_options to parse args
 - rebase -i: use struct object_id for squash_onto
 - rebase -i: use struct commit when parsing options
 - rebase -i: remove duplication
 - rebase -i: combine rebase--interactive.c with rebase.c
 - rebase: use OPT_RERERE_AUTOUPDATE()
 - rebase: rename write_basic_state()
 - sequencer: always discard index after checkout
 - Merge branch 'ag/sequencer-reduce-rewriting-todo' into pw/rebase-i-internal-rfc
 (this branch uses ag/sequencer-reduce-rewriting-todo.)

 The internal implementation of "git rebase -i" has been updated to
 avoid forking a separate "rebase--interactive" process.

 Comments?  Is this ready?


* sg/asciidoctor-in-ci (2019-04-05) 6 commits
 - ci: fix AsciiDoc/Asciidoctor stderr check in the documentation build job
 - ci: stick with Asciidoctor v1.5.8 for now
 - ci: install Asciidoctor in 'ci/install-dependencies.sh'
 - Documentation/technical/protocol-v2.txt: fix formatting
 - Documentation/technical/api-config.txt: fix formatting
 - Documentation/git-diff-tree.txt: fix formatting

 Update our support to format documentation in the CI environment,
 either with AsciiDoc ro Asciidoctor.

 Will merge to 'next'.


* sg/index-pack-progress (2019-04-01) 1 commit
 - index-pack: show progress while checking objects

 A progress indicator has been added to the "index-pack" step, which
 often makes users wait for completion during "git clone".

 Will merge to 'next'.


* sg/overlong-progress-fix (2019-04-05) 4 commits
 - progress: break too long progress bar lines
 - progress: clear previous progress update dynamically
 - progress: assemble percentage and counters in a strbuf before printing
 - progress: make display_progress() return void

 Updating the display with progress message has been cleaned up to
 deal better with overlong messages.

 Will merge to 'next'.


* sg/t5318-cleanup (2019-03-24) 1 commit
  (merged to 'next' on 2019-04-10 at 787b1b5073)
 + t5318-commit-graph: remove unused variable

 Code cleanup.

 Will merge to 'master'.


* tz/asciidoctor-fixes (2019-04-01) 2 commits
 - Documentation/git-status: fix titles in porcelain v2 section
 - Documentation/rev-list-options: wrap --date=<format> block with "--"

 Doc updates.

 Will merge to 'next'.


* js/init-db-update-for-mingw (2019-03-12) 1 commit
  (merged to 'next' on 2019-04-10 at 1d5768849f)
 + mingw: respect core.hidedotfiles = false in git-init again

 "git init" forgot to read platform-specific repository
 configuration, which made Windows port to ignore settings of
 core.hidedotfiles, for example.

 Will merge to 'master'.


* js/stash-in-c-pathspec-fix (2019-03-12) 3 commits
  (merged to 'next' on 2019-03-20 at e81d08af7a)
 + stash: pass pathspec as pointer
 + built-in stash: handle :(glob) pathspecs again
 + legacy stash: fix "rudimentary backport of -q"
 (this branch uses ps/stash-in-c; is tangled with tb/stash-in-c-unused-param-fix and tg/stash-in-c-show-default-to-p-fix.)

 Further fixes to "git stash" reimplemented in C.

 Will cook in 'next'.


* js/remote-curl-i18n (2019-03-06) 1 commit
  (merged to 'next' on 2019-04-10 at 4814acf6c8)
 + remote-curl: mark all error messages for translation
 (this branch uses js/anonymize-remote-curl-diag.)

 Error messages given from the http transport have been updated so
 that they can be localized.

 Will merge to 'master'.


* ma/asciidoctor-fixes-more (2019-03-07) 5 commits
  (merged to 'next' on 2019-04-10 at 77cf886e7e)
 + Documentation: turn middle-of-line tabs into spaces
 + git-svn.txt: drop escaping '\' that ends up being rendered
 + git.txt: remove empty line before list continuation
 + config/fsck.txt: avoid starting line with dash
 + config/diff.txt: drop spurious backtick

 Documentation mark-up fixes.

 Will merge to 'master'.


* nd/diff-parseopt-3 (2019-03-07) 20 commits
  (merged to 'next' on 2019-03-20 at ee79d4924b)
 + diff-parseopt: convert --submodule
 + diff-parseopt: convert --ignore-submodules
 + diff-parseopt: convert --textconv
 + diff-parseopt: convert --ext-diff
 + diff-parseopt: convert --quiet
 + diff-parseopt: convert --exit-code
 + diff-parseopt: convert --color-words
 + diff-parseopt: convert --word-diff-regex
 + diff-parseopt: convert --word-diff
 + diff-parseopt: convert --[no-]color
 + diff-parseopt: convert --[no-]follow
 + diff-parseopt: convert -R
 + diff-parseopt: convert -a|--text
 + diff-parseopt: convert --full-index
 + diff-parseopt: convert --binary
 + diff-parseopt: convert --anchored
 + diff-parseopt: convert --diff-algorithm
 + diff-parseopt: convert --histogram
 + diff-parseopt: convert --patience
 + diff-parseopt: convert --[no-]indent-heuristic
 (this branch is used by nd/diff-parseopt-4.)

 Third batch to teach the diff machinery to use the parse-options
 API.

 Will merge to 'master'.
 cf. <20190305123026.7266-1-pclouds@gmail.com>


* jt/test-protocol-version (2019-03-07) 8 commits
  (merged to 'next' on 2019-03-20 at 0c97907bdb)
 + t5552: compensate for v2 filtering ref adv.
 + tests: fix protocol version for overspecifications
 + t5700: only run with protocol version 1
 + t5512: compensate for v0 only sending HEAD symrefs
 + t5503: fix overspecification of trace expectation
 + tests: always test fetch of unreachable with v0
 + t5601: check ssh command only with protocol v0
 + tests: define GIT_TEST_PROTOCOL_VERSION
 (this branch is used by jt/fetch-no-update-shallow-in-proto-v2.)

 Help developers by making it easier to run most of the tests under
 different versions of over-the-wire protocols.

 Will merge to 'master'.
 cf. <cover.1551131153.git.jonathantanmy@google.com>


* js/anonymize-remote-curl-diag (2019-03-05) 1 commit
  (merged to 'next' on 2019-04-10 at 137a191021)
 + curl: anonymize URLs in error messages and warnings
 (this branch is used by js/remote-curl-i18n.)

 remote-http transport did not anonymize URLs reported in its error
 messages at places.

 Will merge to 'master'.


* ma/asciidoctor-fixes (2019-03-11) 3 commits
  (merged to 'next' on 2019-04-10 at 41a7f51003)
 + asciidoctor-extensions: fix spurious space after linkgit
 + Documentation/Makefile: add missing dependency on asciidoctor-extensions
 + Documentation/Makefile: add missing xsl dependencies for manpages

 Build fix around use of asciidoctor instead of asciidoc

 Will merge to 'master'.


* nd/worktree-name-sanitization (2019-03-20) 2 commits
 - SQUASH???
 - worktree add: sanitize worktree names

 In recent versions of Git, per-worktree refs are exposed in
 refs/worktrees/<wtname>/ hierarchy, which means that worktree names
 must be a valid refname component.  The code now sanitizes the names
 given to worktrees, to make sure these refs are well-formed.


* bp/post-index-change-hook (2019-02-15) 1 commit
  (merged to 'next' on 2019-03-11 at cb96d1d7c4)
 + read-cache: add post-index-change hook

 Originally merged to 'next' on 2019-02-23

 A new hook "post-index-change" is called when the on-disk index
 file changes, which can help e.g. a virtualized working tree
 implementation.

 Will cook in 'next'.


* jc/format-patch-error-check (2019-02-22) 2 commits
  (merged to 'next' on 2019-04-10 at 6ca358b7ef)
 + format-patch: notice failure to open cover letter for writing
 + builtin/log: downcase the beginning of error messages
 (this branch is used by jc/format-patch-noclobber.)

 "git format-patch" used overwrite an existing patch/cover-letter
 file.  A new "--no-clobber" option stops it.

 Will merge to 'master'.


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


* br/blame-ignore (2019-04-04) 6 commits
 - RFC blame: use a fingerprint heuristic to match ignored lines
 - blame: add a config option to mark ignored lines
 - blame: add the ability to ignore commits and their changes
 - blame: optionally track the line starts during fill_blame_origin()
 - blame: use a helper function in blame_chunk()
 - Move init_skiplist() outside of fsck

 "git blame" learned to "ignore" commits in the history, whose
 effects (as well as their presence) get ignored.

 Expecting a reroll.
 cf. <8736mtqy9n.fsf@fencepost.gnu.org>
 cf. <6752a735-2e7b-7d13-799f-a42e6995498c@google.com>


* nd/config-move-to (2019-01-14) 7 commits
 - config.h: fix hdr-check warnings
 - config: add --move-to
 - config: factor out set_config_source_file()
 - config: use OPT_FILENAME()
 - config.c: add repo_config_set_worktree_gently()
 - worktree.c: add get_worktree_config()
 - config.c: avoid git_path() in do_git_config_sequence()

 Needs review.


* dl/merge-cleanup-scissors-fix (2019-03-21) 11 commits
 - cherry-pick/revert: add scissors line on merge conflict
 - sequencer.c: define describe_cleanup_mode
 - merge: add scissors line on merge conflict
 - merge: cleanup messages like commit
 - sequencer.c: remove duplicate code
 - parse-options.h: extract common --cleanup option
 - commit: extract cleanup_mode functions to sequencer
 - t7502: clean up style
 - t7604: clean up style
 - t3507: clean up style
 - t7600: clean up style

 The list of conflicted paths shown in the editor while concluding a
 conflicted merge was shown above the scissors line when the
 clean-up mode is set to "scissors", even though it was commented
 out just like the list of updated paths and other information to
 help the user explain the merge better.

 Needs review.
 cf. <cover.1553150827.git.liu.denton@gmail.com> (v9)


* jn/unknown-index-extensions (2018-11-21) 2 commits
 - index: offer advice for unknown index extensions
 - index: do not warn about unrecognized extensions

 A bit too alarming warning given when unknown index extensions
 exist is getting revamped.

 Expecting a reroll.


* ag/sequencer-reduce-rewriting-todo (2019-03-07) 18 commits
  (merged to 'next' on 2019-04-10 at 7eab7c7800)
 + rebase--interactive: move transform_todo_file()
 + sequencer: use edit_todo_list() in complete_action()
 + rebase-interactive: rewrite edit_todo_list() to handle the initial edit
 + rebase-interactive: append_todo_help() changes
 + rebase-interactive: use todo_list_write_to_file() in edit_todo_list()
 + sequencer: refactor skip_unnecessary_picks() to work on a todo_list
 + rebase--interactive: move rearrange_squash_in_todo_file()
 + rebase--interactive: move sequencer_add_exec_commands()
 + sequencer: change complete_action() to use the refactored functions
 + sequencer: make sequencer_make_script() write its script to a strbuf
 + sequencer: refactor rearrange_squash() to work on a todo_list
 + sequencer: refactor sequencer_add_exec_commands() to work on a todo_list
 + sequencer: refactor check_todo_list() to work on a todo_list
 + sequencer: introduce todo_list_write_to_file()
 + sequencer: refactor transform_todos() to work on a todo_list
 + sequencer: remove the 'arg' field from todo_item
 + sequencer: make the todo_list structure public
 + sequencer: changes in parse_insn_buffer()
 (this branch is used by pw/rebase-i-internal-rfc.)

 The scripted version of "git rebase -i" wrote and rewrote the todo
 list many times during a single step of its operation, and the
 recent C-rewrite made a faithful conversion of the logic to C.  The
 implementation has been updated to carry necessary information
 around in-core to avoid rewriting the same file over and over
 unnecessarily.

 Will merge to 'master'.
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
