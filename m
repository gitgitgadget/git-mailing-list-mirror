Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A24C01F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 06:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504388AbfJRGaE (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 02:30:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58693 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392981AbfJRGaE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 02:30:04 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C1ADC28817;
        Fri, 18 Oct 2019 02:29:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=7
        SC2nrj+iDJ8aIHJBCgaTN2hqsc=; b=IvKHD8eBTqwidFipQZ2zGxBhtXttTnKTR
        SCVa5hX1HfWmINBQOBUxxFEDUi2Z5KX80cEyG75zBkHOrJhofGTBZ6kNUEmuYmUl
        2gYCxFLHfxfDNrhzyV5FyjIkY300o88E2nXg2C3ZwqomBWKd0RRFchOFwmri7pcb
        Lx6TKSZVig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=Mb7
        TCOPv1bbBZb+lWeM6z6AjB0z48LFkKVTSNptHIlPy+LKmDyUIXQBEkzdYjio82wH
        uyRsb/9++4VtTannVUA0X6KlJF2z/wSFTLnmDDtmP0qLx7nDIWCKMi/5UKWVHpjM
        cBBPZudqhlm1QKaPZ3V0lpHF/1IemFw+ZYnR8Jus=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B89E428816;
        Fri, 18 Oct 2019 02:29:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1DD0628815;
        Fri, 18 Oct 2019 02:29:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2019, #05; Fri, 18)
X-master-at: d966095db01190a2196e31195ea6fa0c722aa732
X-next-at: 954a862665455a25876e1113bd865d43a26facce
Date:   Fri, 18 Oct 2019 15:29:51 +0900
Message-ID: <xmqqblue5zxc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B11A0974-F170-11E9-A3DF-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

A preview release 2.24-rc0 has been tagged.  There still are a few
topics in 'next' that we'd like to see in the upcoming release, but
the tip of 'master' should otherwise be pretty close to the final
already.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bb/compat-util-comment-fix (2019-10-12) 1 commit
  (merged to 'next' on 2019-10-15 at c15e45fe28)
 + git-compat-util: fix documentation syntax

 Code cleanup.


* bb/utf8-wcwidth-cleanup (2019-10-12) 1 commit
  (merged to 'next' on 2019-10-15 at 92ba59e1d6)
 + utf8: use ARRAY_SIZE() in git_wcwidth()

 Code cleanup.


* bw/format-patch-o-create-leading-dirs (2019-10-12) 1 commit
  (merged to 'next' on 2019-10-15 at 93c9949b6a)
 + format-patch: create leading components of output directory

 "git format-patch -o <outdir>" did an equivalent of "mkdir <outdir>"
 not "mkdir -p <outdir>", which got corrected.


* dl/allow-running-cocci-verbosely (2019-10-12) 1 commit
  (merged to 'next' on 2019-10-15 at 474dc9f86e)
 + Makefile: respect $(V) in %.cocci.patch target

 Dev support update.


* dl/compat-cleanup (2019-10-11) 1 commit
  (merged to 'next' on 2019-10-15 at 1ed99770ba)
 + pthread.h: manually align parameter lists

 Code formatting micronit fix.


* jj/stash-reset-only-toplevel (2019-10-15) 1 commit
  (merged to 'next' on 2019-10-15 at 28f398daab)
 + stash: avoid recursive hard reset on submodules

 "git stash save" lost local changes to submodules, which has been
 corrected.


* js/doc-stash-save (2019-10-11) 1 commit
  (merged to 'next' on 2019-10-15 at e588bff32c)
 + doc(stash): clarify the description of `save`

 Doc clarification.


* rs/column-use-utf8-strnwidth (2019-10-15) 1 commit
  (merged to 'next' on 2019-10-15 at 3be15b4478)
 + column: use utf8_strnwidth() to strip out ANSI color escapes

 Code cleanup.


* rs/http-push-simplify (2019-10-15) 1 commit
  (merged to 'next' on 2019-10-15 at 4abc29286c)
 + http-push: simplify deleting a list item

 Code cleanup.


* rs/remote-curl-use-argv-array (2019-10-15) 1 commit
  (merged to 'next' on 2019-10-15 at 8d0375a874)
 + remote-curl: use argv_array in parse_push()

 Code cleanup.


* ta/t1308-typofix (2019-10-11) 1 commit
  (merged to 'next' on 2019-10-15 at 0228b44688)
 + t1308-config-set: fix a test that has a typo

 Test fix.

--------------------------------------------------
[New Topics]

* dd/notes-copy-default-dst-to-head (2019-10-18) 2 commits
  (merged to 'next' on 2019-10-18 at 2588a175ec)
 + notes: fix minimum number of parameters to "copy" subcommand
 + t3301: test diagnose messages for too few/many paramters

 "git notes copy $original" ought to copy the notes attached to the
 original object to HEAD, but a mistaken tightening to command line
 parameter validation made earlier disabled that feature by mistake.

 Will cook in 'next'.
 No need for rush, as this is a fix for an ancient regression.


* jc/log-graph-simplify (2019-10-16) 13 commits
 - graph: fix coloring of octopus dashes
 - graph: flatten edges that fuse with their right neighbor
 - graph: smooth appearance of collapsing edges on commit lines
 - graph: rename `new_mapping` to `old_mapping`
 - graph: commit and post-merge lines for left-skewed merges
 - graph: tidy up display of left-skewed merges
 - graph: example of graph output that can be simplified
 - graph: extract logic for moving to GRAPH_PRE_COMMIT state
 - graph: remove `mapping_idx` and `graph_update_width()`
 - graph: reduce duplication in `graph_insert_into_new_columns()`
 - graph: reuse `find_new_column_by_commit()`
 - graph: handle line padding in `graph_next_line()`
 - graph: automatically track display width of graph lines

 The implementation of "git log --graph" got refactored and then its
 output got simplified.

 Will merge to 'next'.


* js/azure-ci-osx-fix (2019-10-18) 1 commit
  (merged to 'next' on 2019-10-18 at bc6a502f6e)
 + ci(osx): use new location of the `perforce` cask

 Update installation procedure for Perforce on MacOS in the CI jobs
 running on Azure pipelines, which was failing.

 Will merge to 'master'.


* js/git-path-head-dot-lock-fix (2019-10-18) 2 commits
 - git_path(): handle `.lock` files correctly
 - t1400: wrap setup code in test case

 "git rev-parse --git-path HEAD.lock" did not give the right path
 when run in a secondary worktree.


* pw/post-commit-from-sequencer (2019-10-16) 6 commits
  (merged to 'next' on 2019-10-18 at 15b41a097d)
 + sequencer: run post-commit hook
 + move run_commit_hook() to libgit and use it there
 + sequencer.h fix placement of #endif
 + t3404: remove uneeded calls to set_fake_editor
 + t3404: set $EDITOR in subshell
 + t3404: remove unnecessary subshell

 "rebase -i" ceased to run post-commit hook by mistake in an earlier
 update, which has been corrected.

 Will merge to 'master'.

--------------------------------------------------
[Stalled]

* ra/rebase-i-more-options (2019-09-09) 6 commits
 - rebase: add --reset-author-date
 - rebase -i: support --ignore-date
 - sequencer: rename amend_author to author_to_rename
 - rebase -i: support --committer-date-is-author-date
 - sequencer: allow callers of read_author_script() to ignore fields
 - rebase -i: add --ignore-whitespace flag

 "git rebase -i" learned a few options that are known by "git
 rebase" proper.

 Needs to consider existing GIT_COMMITTER_DATE environment, etc.
 cf. <5adde732-173b-d24d-d23f-bb4d043076d7@gmail.com>


* vn/reset-deleted-ita (2019-07-26) 1 commit
 - reset: unstage empty deleted ita files

 "git reset HEAD [<pathspec>]" did not reset an empty file that was
 added with the intent-to-add bit.

 Expecting a reroll.


* jn/unknown-index-extensions (2018-11-21) 2 commits
 - index: offer advice for unknown index extensions
 - index: do not warn about unrecognized extensions

 A bit too alarming warning given when unknown index extensions
 exist is getting revamped.

 Expecting a reroll.


* jc/format-patch-delay-message-id (2019-04-05) 1 commit
 - format-patch: move message-id and related headers to the end

 The location "git format-patch --thread" adds the Message-Id:
 header in the series of header fields has been moved down, which
 may help working around a suspected bug in GMail MSA, reported at
 <CAHk-=whP1stFZNAaJiMi5eZ9rj0MRt20Y_yHVczZPH+O01d+sA@mail.gmail.com>

 Waiting for feedback to see if it truly helps.
 Needs tests.


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

--------------------------------------------------
[Cooking]

* cb/pcre2-chartables-leakfix (2019-10-18) 3 commits
  (merged to 'next' on 2019-10-18 at 5bc67c64fd)
 + grep: avoid leak of chartables in PCRE2
 + grep: make PCRE2 aware of custom allocator
 + grep: make PCRE1 aware of custom allocator

 Leakfix.

 Will merge to 'master'.


* ds/sparse-cone (2019-10-16) 17 commits
 - sparse-checkout: cone mode should not interact with .gitignore
 - sparse-checkout: write using lockfile
 - sparse-checkout: update working directory in-process
 - sparse-checkout: sanitize for nested folders
 - read-tree: show progress by default
 - unpack-trees: add progress to clear_ce_flags()
 - unpack-trees: hash less in cone mode
 - sparse-checkout: init and set in cone mode
 - sparse-checkout: use hashmaps for cone patterns
 - sparse-checkout: add 'cone' mode
 - trace2: add region in clear_ce_flags
 - sparse-checkout: create 'disable' subcommand
 - sparse-checkout: add '--stdin' option to set subcommand
 - sparse-checkout: 'set' subcommand
 - clone: add --sparse mode
 - sparse-checkout: create 'init' subcommand
 - sparse-checkout: create builtin with 'list' subcommand

 Management of sparsely checked-out working tree has gained a
 dedicated "sparse-checkout" command.

 Will merge to 'next'.


* wb/fsmonitor-bitmap-fix (2019-10-12) 1 commit
  (merged to 'next' on 2019-10-15 at 1cc4091346)
 + fsmonitor: don't fill bitmap with entries to be removed

 A segfault fix.

 Will merge to 'master'.


* bc/smart-http-atomic-push (2019-10-17) 1 commit
  (merged to 'next' on 2019-10-18 at 7729d13f51)
 + remote-curl: pass on atomic capability to remote side

 The atomic push over smart HTTP transport did not work, which has
 been corrected.

 Will merge to 'master'.


* dl/format-patch-cover-from-desc (2019-10-16) 3 commits
  (merged to 'next' on 2019-10-18 at 40e992b6f5)
 + format-patch: teach --cover-from-description option
 + format-patch: use enum variables
 + format-patch: replace erroneous and condition

 The branch description ("git branch --edit-description") has been
 used to fill the body of the cover letters by the format-patch
 command; this has been enhanced so that the subject can also be
 filled.

 Will cook in 'next'.
 No need for rush, as this is a new feature.


* en/merge-recursive-directory-rename-fixes (2019-10-12) 2 commits
  (merged to 'next' on 2019-10-15 at ebfdc3ff7b)
 + merge-recursive: fix merging a subdirectory into the root directory
 + merge-recursive: clean up get_renamed_dir_portion()

 When all files from some subdirectory were renamed to the root
 directory, the directory rename heuristics would fail to detect that
 as a rename/merge of the subdirectory to the root directory, which has
 been corrected.

 Will merge to 'master'.


* jt/fetch-pack-record-refs-in-the-dot-promisor (2019-10-16) 1 commit
  (merged to 'next' on 2019-10-18 at 4ead52e59a)
 + fetch-pack: write fetched refs to .promisor

 Debugging support for lazy cloning has been a bit improved.

 Will cook in 'next'.
 No need for rush, as this is a new feature.


* mb/clarify-zsh-completion-doc (2019-10-12) 1 commit
 - completion: clarify installation instruction for zsh

 The installation instruction for zsh completion script (in
 contrib/) has been a bit improved.

 Will merge to 'next' and then to 'master'.


* nr/diff-highlight-indent-fix (2019-10-15) 1 commit
 - diff-highlight: fix a whitespace nit

 Code cleanup.

 Will merge to 'next' and then to 'master'.


* es/walken-tutorial (2019-10-12) 1 commit
  (merged to 'next' on 2019-10-18 at 59160e59e9)
 + documentation: add tutorial for object walking

 A tutorial on object enumeration.

 Will cook in 'next'.


* bc/hash-independent-tests-part-6 (2019-10-06) 15 commits
 - t4048: abstract away SHA-1-specific constants
 - t4045: make hash-size independent
 - t4044: update test to work with SHA-256
 - t4039: abstract away SHA-1-specific constants
 - t4038: abstract away SHA-1 specific constants
 - t4034: abstract away SHA-1-specific constants
 - t4027: make hash-size independent
 - t4015: abstract away SHA-1-specific constants
 - t4011: abstract away SHA-1-specific constants
 - t4010: abstract away SHA-1-specific constants
 - t3429: remove SHA1 annotation
 - t1305: avoid comparing extensions
 - rev-parse: add an --object-format option
 - t/oid-info: add empty tree and empty blob values
 - t/oid-info: allow looking up hash algorithm name

 Test updates to prepare for SHA-2 transition continues.

 May be rerolled.
 cf. <20191008194012.4s35pbwbh25rblhb@camp.crustytoothpaste.net>


* ag/sequencer-todo-updates (2019-10-08) 5 commits
  (merged to 'next' on 2019-10-18 at 8dac803e49)
 + sequencer: directly call pick_commits() from complete_action()
 + rebase: fill `squash_onto' in get_replay_opts()
 + sequencer: move the code writing total_nr on the disk to a new function
 + sequencer: update `done_nr' when skipping commands in a todo list
 + sequencer: update `total_nr' when adding an item to a todo list

 Reduce unnecessary reading of state variables back from the disk
 during sequener operation.

 Will cook in 'next'.
 No need for rush, as this does not fix anything nor adds any new feature.


* mt/threaded-grep-in-object-store (2019-10-02) 11 commits
 - grep: move driver pre-load out of critical section
 - grep: re-enable threads in non-worktree case
 - grep: protect packed_git [re-]initialization
 - grep: allow submodule functions to run in parallel
 - submodule-config: add skip_if_read option to repo_read_gitmodules()
 - grep: replace grep_read_mutex by internal obj read lock
 - object-store: allow threaded access to object reading
 - replace-object: make replace operations thread-safe
 - grep: fix racy calls in grep_objects()
 - grep: fix race conditions at grep_submodule()
 - grep: fix race conditions on userdiff calls

 Traditionally, we avoided threaded grep while searching in objects
 (as opposed to files in the working tree) as accesses to the object
 layer is not thread-safe.  This limitation is getting lifted.


* jk/packfile-reuse-cleanup (2019-09-13) 10 commits
  (merged to 'next' on 2019-09-30 at dc60b31833)
 + pack-objects: improve partial packfile reuse
 + builtin/pack-objects: introduce obj_is_packed()
 + pack-objects: introduce pack.allowPackReuse
 + csum-file: introduce hashfile_total()
 + pack-bitmap: introduce bitmap_walk_contains()
 + pack-bitmap: don't rely on bitmap_git->reuse_objects
 + ewah/bitmap: always allocate 2 more words
 + ewah/bitmap: introduce bitmap_word_alloc()
 + packfile: expose get_delta_base()
 + builtin/pack-objects: report reused packfile objects

 The way "git pack-objects" reuses objects stored in existing pack
 to generate its result has been improved.

 On hold until we give it a more thorough review.
 cf. <20191002155721.GD6116@sigill.intra.peff.net>


* js/builtin-add-i (2019-08-30) 11 commits
 . built-in add -i: implement the `help` command
 . built-in add -i: use color in the main loop
 . built-in add -i: support `?` (prompt help)
 . built-in add -i: show unique prefixes of the commands
 . Add a function to determine unique prefixes for a list of strings
 . built-in add -i: implement the main loop
 . built-in add -i: color the header in the `status` command
 . built-in add -i: refresh the index before running `status`
 . built-in add -i: implement the `status` command
 . diff: export diffstat interface
 . Start to implement a built-in version of `git add --interactive`

 The beginning of rewriting "git add -i" in C.

 Expecting a reroll on top of a base with the tg/stash-refresh-index
 topic that defines an updated repo_refresh_and_write_index() helper.
 cf. <20190911175201.GA11444@cat>

--------------------------------------------------
[Discarded]

* dl/remote-save-to-push (2018-12-11) 1 commit
 . remote: add --save-to-push option to git remote set-url

 "git remote set-url" learned a new option that moves existing value
 of the URL field to pushURL field of the remote before replacing
 the URL field with a new value.

 Anybody who wants to champion this topic?
 I am personally not yet quite convinced if this is worth pursuing.


* js/trace2-json-schema (2019-07-25) 3 commits
 . ci: run trace2 schema validation in the CI suite
 . trace2: add a schema validator for trace2 events
 . trace2: add a JSON schema for trace2 events

 The JSON output produced by "trace2" subsystem now has JSON schema
 defined on it, to allow us validate the output and catch deviation.

 Abandoned, at least for now.
 cf. <20190910182305.GA11186@google.com>


* pd/fetch-jobs (2019-08-13) 5 commits
 . fetch: make --jobs control submodules and remotes
 . fetch: add the --submodule-fetch-jobs option
 . fetch: add the fetch.jobs config key
 . fetch: add the "--fetch-jobs" option
 . fetch: rename max_children to max_children_for_submodules

 "git fetch --jobs" is getting taught to also run fetch jobs in
 parallel when fetching from multiple remote repositories.

 cf. <nycvar.QRO.7.76.6.1909111359150.5377@tvgsbejvaqbjf.bet>


* js/honor-cflags-in-hdr-check (2019-08-26) 1 commit
  (merged to 'next' on 2019-09-09 at fcd9ee9f1b)
 + hdr-check: make it work on Windows

 Build fix to make sure hdr-check is run with the same preprocessor
 macros predefined by the $(MAKE) procedure.

 Superseded by dl/honor-cflags-in-hdr-check series.


* dl/format-patch-cover-letter-subject (2019-09-05) 1 commit
 . format-patch: learn --infer-cover-subject option

 "git format-patch --cover-letter" learned to optionally use the
 first paragraph (typically a single-liner) of branch.*.description
 as the subject of the cover letter.

 Superseded by the dl/format-patch-cover-from desc topic.


* jt/fetch-cdn-offload (2019-03-12) 9 commits
 . SQUASH???
 . upload-pack: send part of packfile response as uri
 . fetch-pack: support more than one pack lockfile
 . upload-pack: refactor reading of pack-objects out
 . Documentation: add Packfile URIs design doc
 . Documentation: order protocol v2 sections
 . http-fetch: support fetching packfiles by URL
 . http: improve documentation of http_pack_request
 . http: use --stdin when getting dumb HTTP pack

 WIP for allowing a response to "git fetch" to instruct the bulk of
 the pack contents to be instead taken from elsewhere (aka CDN).


* jc/format-patch-noclobber (2019-02-22) 1 commit
 . format-patch: --no-clobber refrains from overwriting output files

 "git format-patch" used to overwrite an existing patch/cover-letter
 file.  A new "--no-clobber" option stops it.
