Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D500E1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 22:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754697AbeFYWrI (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 18:47:08 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45406 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755016AbeFYWrE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 18:47:04 -0400
Received: by mail-wr0-f196.google.com with SMTP id o9-v6so999377wrs.12
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 15:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=uqMt6uz8OkYIIuFEzB3KUC0YzMJNF0z0q2RQY9dAQAQ=;
        b=q2HBQKXCrA5jZhxYdSywFgFfmEHr8U1UizcfkMwsW+MGYrDvlzOlxGA3yAeL5tfjY/
         zAzrGEx4GxGYnC8f/kM1ZNZLT4iyQuP+vjgpydHiDRSIOh8UrqVZVjyzUhVkF+Sv8SZQ
         OH2pTqAacEY6sSp1YzbNpL9nkhu8MITisHufKZWiV+KRC5tuL5qcYzpbYXCAmAK2/KHB
         VOdp5ftxkE98I9DP7Qv/kB5dYRhHsLspsWLvKqvKSy4ZSd3mLjVbQVEkVf9/hfCQo/5f
         iDV4oyT52sQtIL0fVbUeNzDJD9+Qcdh/qspd2iqMuXVDC8L9jX2Y8FRCDstlH5K+hIDc
         FpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=uqMt6uz8OkYIIuFEzB3KUC0YzMJNF0z0q2RQY9dAQAQ=;
        b=K0AxhnIK7Mw2vzVHcBNN0BpkZAZWwouF6NSOmriWwp9QQki5P4aavsCXCcIo2r2sHo
         /mmEXyPAtf0iocaQwtHK65RQfctxApMv5ZUPNgpCGGWFQSIyOj9kJ1EvyMsT+DEENpOx
         kkyXBU5YjoMLy3PV32FvNbxSeTWtyBp5ReoykxWc/5crnVTbyEHbXIl7HFp6vlSNkgKo
         OHzUwk7RDtAc/t6jIItHx926+wAEPfTOf0B1GWT6pekmFdkxXxGgNBvAGNmet5vm9Vqu
         MP4PI0yg40Y3ywGATxRJ4xMgrJ+SQl5EXMVOQRynjrg/hFPYMewM2UXTRNaNFsZx2Fxn
         gf5w==
X-Gm-Message-State: APt69E2WO5X/4DQF/1JZ08FCV+r0QSOSghBGztU23JJ8CDc9WFjC2WQe
        p9BmtYeuMhez0F7rR4uowcK3eb2mnjegtw==
X-Google-Smtp-Source: AAOMgpcFkdY97Y2bE53SoOaI0WC8JB9KWqG+CbpL0+I+8WJ/79SKmMvt9XPzek9OJXyOSKZ7A0iHyA==
X-Received: by 2002:a5d:4a92:: with SMTP id o18-v6mr10654918wrq.132.1529966822514;
        Mon, 25 Jun 2018 15:47:02 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c18-v6sm199515wrq.17.2018.06.25.15.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 15:47:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jun 2018, #06; Mon, 25)
X-master-at: ed843436dd4924c10669820cc73daf50f0b4dabd
X-next-at: fe4b3013947290a493c4417c35793593612e592c
Date:   Mon, 25 Jun 2018 15:47:01 -0700
Message-ID: <xmqqin66mql6.fsf@gitster-ct.c.googlers.com>
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

Git 2.18 turned out to be an unusually large release in the recent
history, with 900+ individual changes, compared to ~500 for a few
releases before that.  Thanks, everybody who participated.

The tip of 'next' hasn't been rewound yet, but I've already reverted
merges of a few topics from there to give them a fresh restart.  

I haven't annotated many topics still in 'pu' with short-term plans
and my assessment on their done-ness.  Comments and review summaries
to help deciding are appreciated.  I'd like to start accepting new
topics only after getting the classification more-or-less right for
the topics already in flight.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ag/rebase-p (2018-06-01) 4 commits
  (merged to 'next' on 2018-06-13 at dd6f8a51d7)
 + rebase: remove -p code from git-rebase--interactive.sh
 + rebase: use the new git-rebase--preserve-merges.sh
 + rebase: strip unused code in git-rebase--preserve-merges.sh
 + rebase: introduce a dedicated backend for --preserve-merges
 (this branch is used by ag/rebase-i-append-todo-help and ag/rebase-i-rewrite-todo.)

 Separate "rebase -p" codepath out of "rebase -i" implementation to
 slim down the latter and make it easier to manage.


* cc/tests-without-assuming-ref-files-backend (2018-06-04) 1 commit
  (merged to 'next' on 2018-06-13 at 7e2f74431c)
 + t9104: kosherly remove remote refs

 Instead of mucking with filesystem directly, use plumbing commands
 update-ref etc. to manipulate the refs in the tests.


* ds/commit-graph-lockfile-fix (2018-05-22) 1 commit
  (merged to 'next' on 2018-05-24 at 3d12a02b0c)
 + commit-graph: fix UX issue when .lock file exists
 (this branch is used by ds/commit-graph-fsck; uses ds/generation-numbers.)

 Update to ds/generation-numbers topic.


* ds/generation-numbers (2018-05-22) 11 commits
  (merged to 'next' on 2018-05-24 at 56fc38a1b6)
 + commit-graph.txt: update design document
 + merge: check config before loading commits
 + commit: use generation number in remove_redundant()
 + commit: add short-circuit to paint_down_to_common()
 + commit: use generation numbers for in_merge_bases()
 + ref-filter: use generation number for --contains
 + commit-graph: always load commit-graph information
 + commit: use generations in paint_down_to_common()
 + commit-graph: compute generation numbers
 + commit: add generation number to struct commit
 + ref-filter: fix outdated comment on in_commit_list
 (this branch is used by ds/commit-graph-fsck and ds/commit-graph-lockfile-fix.)

 A recently added "commit-graph" datafile has learned to store
 pre-computed generation numbers to speed up the decisions to stop
 history traversal.


* en/merge-recursive-tests (2018-05-28) 5 commits
  (merged to 'next' on 2018-06-01 at 8490b560b4)
 + t6036: prefer test_when_finished to manual cleanup in following test
 + t6036, t6042: prefer test_cmp to sequences of test
 + t6036, t6042: prefer test_path_is_file, test_path_is_missing
 + t6036, t6042: use test_line_count instead of wc -l
 + t6036, t6042: use test_create_repo to keep tests independent

 Clean up tests in t6xxx series about 'merge' command.


* en/rename-directory-detection-reboot (2018-06-18) 1 commit
  (merged to 'next' on 2018-06-18 at 95c454d3f4)
 + merge-recursive: use xstrdup() instead of fixed buffer

 Newly added codepath in merge-recursive had potential buffer
 overrun, which has been fixed.


* jk/show-index (2018-05-29) 2 commits
  (merged to 'next' on 2018-06-01 at 4b3382d994)
 + show-index: update documentation for index v2
 + make show-index a builtin

 Modernize a less often used command.


* ls/complete-remote-update-names (2018-06-01) 1 commit
  (merged to 'next' on 2018-06-13 at 86b4d23278)
 + completion: complete remote names too

 "git remote update" can take both a single remote nickname and a
 nickname for remote groups, and the completion script (in contrib/)
 has been taught about it.


* nd/commit-util-to-slab (2018-05-21) 15 commits
  (merged to 'next' on 2018-05-24 at bb5643d75c)
 + commit.h: delete 'util' field in struct commit
 + merge: use commit-slab in merge remote desc instead of commit->util
 + log: use commit-slab in prepare_bases() instead of commit->util
 + show-branch: note about its object flags usage
 + show-branch: use commit-slab for commit-name instead of commit->util
 + name-rev: use commit-slab for rev-name instead of commit->util
 + bisect.c: use commit-slab for commit weight instead of commit->util
 + revision.c: use commit-slab for show_source
 + sequencer.c: use commit-slab to associate todo items to commits
 + sequencer.c: use commit-slab to mark seen commits
 + shallow.c: use commit-slab for commit depth instead of commit->util
 + describe: use commit-slab for commit names instead of commit->util
 + blame: use commit-slab for blame suspects instead of commit->util
 + commit-slab: support shared commit-slab
 + commit-slab.h: code split

 The in-core "commit" object had an all-purpose "void *util" field,
 which was tricky to use especially in library-ish part of the
 code.  All of the existing uses of the field has been migrated to a
 more dedicated "commit-slab" mechanism and the field is eliminated.


* nd/complete-config-vars (2018-05-29) 13 commits
  (merged to 'next' on 2018-06-13 at c2dd5546d0)
 + completion: complete general config vars in two steps
 + log-tree: allow to customize 'grafted' color
 + completion: support case-insensitive config vars
 + completion: keep other config var completion in camelCase
 + completion: drop the hard coded list of config vars
 + am: move advice.amWorkDir parsing back to advice.c
 + advice: keep config name in camelCase in advice_config[]
 + fsck: produce camelCase config key names
 + help: add --config to list all available config
 + fsck: factor out msg_id_info[] lazy initialization code
 + grep: keep all colors in an array
 + Add and use generic name->id mapping code for color slot parsing
 + Merge branch 'nd/command-list' into nd/complete-config-vars

 Continuing with the idea to programatically enumerate various
 pieces of data required for command line completion, teach the
 codebase to report the list of configuration variables
 subcommands care about to help complete them.


* nd/diff-apply-ita (2018-05-29) 4 commits
  (merged to 'next' on 2018-05-30 at f98728de81)
 + apply: add --intent-to-add
 + t2203: add a test about "diff HEAD" case
 + diff: turn --ita-invisible-in-index on by default
 + diff: ignore --ita-[in]visible-in-index when diffing worktree-to-tree

 "git diff" compares the index and the working tree.  For paths
 added with intent-to-add bit, the command shows the full contents
 of them as added, but the paths themselves were not marked as new
 files.  They are now shown as new by default.

 "git apply" learned the "--intent-to-add" option so that an
 otherwise working-tree-only application of a patch will add new
 paths to the index marked with the "intent-to-add" bit.


* nd/reject-empty-shallow-request (2018-06-04) 1 commit
  (merged to 'next' on 2018-06-13 at d6b6a1c3a7)
 + upload-pack: reject shallow requests that would return nothing

 "git fetch --shallow-since=<cutoff>" that specifies the cut-off
 point that is newer than the existing history used to end up
 grabbing the entire history.  Such a request now errors out.


* pc/submodule-helper-foreach (2018-05-11) 4 commits
  (merged to 'next' on 2018-05-22 at f22659ad46)
 + submodule: port submodule subcommand 'foreach' from shell to C
 + submodule foreach: document variable '$displaypath'
 + submodule foreach: document '$sm_path' instead of '$path'
 + submodule foreach: correct '$path' in nested submodules from a subdirectory

 The bulk of "git submodule foreach" has been rewritten in C.


* sb/object-store-alloc (2018-05-16) 13 commits
  (merged to 'next' on 2018-06-13 at 2868c2db9d)
 + alloc: allow arbitrary repositories for alloc functions
 + object: allow create_object to handle arbitrary repositories
 + object: allow grow_object_hash to handle arbitrary repositories
 + alloc: add repository argument to alloc_commit_index
 + alloc: add repository argument to alloc_report
 + alloc: add repository argument to alloc_object_node
 + alloc: add repository argument to alloc_tag_node
 + alloc: add repository argument to alloc_commit_node
 + alloc: add repository argument to alloc_tree_node
 + alloc: add repository argument to alloc_blob_node
 + object: add repository argument to grow_object_hash
 + object: add repository argument to create_object
 + repository: introduce parsed objects field
 (this branch is used by sb/object-store-grafts.)

 The conversion to pass "the_repository" and then "a_repository"
 throughout the object access API continues.


* sb/plug-misc-leaks (2018-06-04) 5 commits
  (merged to 'next' on 2018-06-13 at bf68cabe28)
 + SQUASH: tentatively cast const-ness away when calling free()
 + sequencer.c: plug mem leak in git_sequencer_config
  (merged to 'next' on 2018-06-04 at fbefac1c7a)
 + sequencer.c: plug leaks in do_pick_commit
 + submodule--helper: plug mem leak in print_default_remote
 + refs/packed-backend.c: close fd of empty file

 Misc leak plugging.


* sg/update-ref-stdin-cleanup (2018-06-04) 1 commit
  (merged to 'next' on 2018-06-13 at 2b9924760d)
 + update-ref --stdin: use skip_prefix()

 Code cleanup.

--------------------------------------------------
[New Topics]

* ld/p423 (2018-06-19) 6 commits
 - git-p4: python3: fix octal constants
 - git-p4: python3: use print() function
 - git-p4: python3: basestring workaround
 - git-p4: python3: remove backticks
 - git-p4: python3: replace dict.has_key(k) with "k in dict"
 - git-p4: python3: replace <> with !=

 Code preparation to make "git p4" closer to be usable with Python 3.

 Will merge to 'next'.


* pw/rebase-i-keep-reword-after-conflict (2018-06-19) 1 commit
 - sequencer: do not squash 'reword' commits when we hit conflicts

 Bugfix for "rebase -i" corner case regression.

 Will merge to 'next'.


* xy/format-patch-prereq-patch-id-fix (2018-06-19) 1 commit
 - format-patch: clear UNINTERESTING flag before prepare_bases

 Recently added "--base" option to "git format-patch" command did
 not correctly generate prereq patch ids.

 Will merge to 'next'.


* bw/config-refer-to-gitsubmodules-doc (2018-06-21) 1 commit
 - docs: link to gitsubmodules

 Docfix.

 Will merge to 'next'.


* bw/ref-in-want (2018-06-21) 8 commits
 - fetch-pack: implement ref-in-want
 - fetch-pack: put shallow info in output parameter
 - fetch: refactor to make function args narrower
 - fetch: refactor fetch_refs into two functions
 - fetch: refactor the population of peer ref OIDs
 - upload-pack: test negotiation with changing repository
 - upload-pack: implement ref-in-want
 - test-pkt-line: add unpack-sideband subcommand


* en/rebase-consistency (2018-06-21) 7 commits
 - git-rebase: make --allow-empty-message the default
 - git-rebase.txt: address confusion between --no-ff vs --force-rebase
 - git-rebase.txt: document behavioral inconsistencies between modes
 - git-rebase: error out when incompatible options passed
 - t3422: new testcases for checking when incompatible options passed
 - git-rebase.sh: update help messages a bit
 - git-rebase.txt: document incompatible options


* jt/remove-pack-bitmap-global (2018-06-21) 2 commits
 - pack-bitmap: add free function
 - pack-bitmap: remove bitmap_git global variable


* sb/submodule-move-head-error-msg (2018-06-25) 1 commit
 - submodule.c: report the submodule that an error occurs in

 Needs a reroll.
 cf. <20180622081713.5360-1-szeder.dev@gmail.com>


* bw/protocol-v2 (2018-06-22) 1 commit
 - protocol-v2 doc: put HTTP headers after request

 Doc fix.

 Will merge to 'next'.


* jk/branch-l-1-repurpose (2018-06-22) 1 commit
 - branch: make "-l" a synonym for "--list"
 (this branch uses jk/branch-l-0-deprecation.)

 Updated plan to repurpose the "-l" option to "git branch".

 Will hold in 'pu' until jk/branch-l-0-deprecation progresses sufficiently.


* vs/typofixes (2018-06-22) 1 commit
 - Documentation: spelling and grammar fixes

 Doc fix.

 Will merge to 'next'.


* cc/remote-odb (2018-06-25) 9 commits
 - Documentation/config: add odb.<name>.promisorRemote
 - t0410: test fetching from many promisor remotes
 - Use odb.origin.partialclonefilter instead of core.partialclonefilter
 - Use remote_odb_get_direct() and has_remote_odb()
 - remote-odb: add remote_odb_reinit()
 - remote-odb: implement remote_odb_get_many_direct()
 - remote-odb: implement remote_odb_get_direct()
 - Add initial remote odb support
 - fetch-object: make functions return an error code


* ds/multi-pack-index (2018-06-25) 24 commits
 - midx: clear midx on repack
 - packfile: skip loading index if in multi-pack-index
 - midx: prevent duplicate packfile loads
 - midx: use midx in approximate_object_count
 - midx: use existing midx when writing new one
 - midx: use midx in abbreviation calculations
 - midx: read objects from multi-pack-index
 - midx: prepare midxed_git struct
 - config: create core.multiPackIndex setting
 - midx: write object offsets
 - midx: write object id fanout chunk
 - midx: write object ids in a chunk
 - midx: sort and deduplicate objects from packfiles
 - midx: read pack names into array
 - multi-pack-index: write pack names in chunk
 - multi-pack-index: read packfile list
 - packfile: generalize pack directory list
 - multi-pack-index: expand test data
 - multi-pack-index: load into memory
 - midx: write header information to lockfile
 - multi-pack-index: add 'write' verb
 - multi-pack-index: add builtin
 - multi-pack-index: add format details
 - multi-pack-index: add design document


* nd/use-the-index-compat-less (2018-06-25) 13 commits
 - wt-status.c: stop using index compat macros
 - sha1-name.c: stop using index compat macros
 - sequencer.c: stop using index compat macros
 - revision.c: stop using index compat macros
 - rerere.c: stop using index compat macros
 - merge.c: stop using index compat macros
 - merge-recursive.c: stop using index compat macros
 - entry.c: stop using index compat macros
 - diff.c: stop using index compat macros
 - diff-lib.c: stop using index compat macros
 - check-racy.c: stop using index compat macros
 - blame.c: stop using index compat macros
 - apply.c: stop using index compat macros

--------------------------------------------------
[Stalled]

* ab/fetch-tags-noclobber (2018-05-16) 9 commits
 - fixup! push tests: assert re-pushing annotated tags
 - fetch: stop clobbering existing tags without --force
 - fetch tests: add a test clobbering tag behavior
 - fetch tests: correct a comment "remove it" -> "remove them"
 - push doc: correct lies about how push refspecs work
 - push tests: assert re-pushing annotated tags
 - push tests: add more testing for forced tag pushing
 - push tests: fix logic error in "push" test assertion
 - push tests: remove redundant 'git push' invocation

 Expecting a reboot of the discussion to take it to some conclusion
 and then a reroll.
 cf. <f3b891c3-381f-de42-51d8-24fdfbca91d2@gmail.com>
 cf. <xmqq603yn50l.fsf@gitster-ct.c.googlers.com>
 cf. <xmqqzi1alodz.fsf@gitster-ct.c.googlers.com>
 cf. <xmqqvabylnbi.fsf@gitster-ct.c.googlers.com>


* pw/add-p-select (2018-03-16) 3 commits
 - add -p: optimize line selection for short hunks
 - add -p: allow line selection to be inverted
 - add -p: select individual hunk lines

 "git add -p" interactive interface learned to let users choose
 individual added/removed lines to be used in the operation, instead
 of accepting or rejecting a whole hunk.

 Expecting a reroll to reignite the discussion.
 cf. <9895c7b7-eac4-28c1-90c6-443acd1131b7@talktalk.net>


* jh/json-writer (2018-06-13) 1 commit
 - json_writer: new routines to create JSON data

 Preparatory code to later add json output for unspecified telemetry
 data.

 We do not add random code that does not have real users to our
 codebase, so let's have it wait until such a real code materializes
 before too long.


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


* pb/bisect-helper-2 (2018-06-13) 8 commits
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

* tb/grep-column (2018-06-22) 7 commits
 - contrib/git-jump/git-jump: jump to exact location
 - grep.c: add configuration variables to show matched option
 - builtin/grep.c: add '--column' option to 'git-grep(1)'
 - grep.c: display column number of first match
 - grep.[ch]: extend grep_opt to allow showing matched column
 - grep.c: expose {,inverted} match column in match_line()
 - Documentation/config.txt: camel-case lineNumber for consistency

 "git grep" learned the "--column" option that gives not just the
 line number but the column number of the hit.


* tz/cred-netrc-cleanup (2018-06-18) 4 commits
  (merged to 'next' on 2018-06-22 at a471dd714c)
 + git-credential-netrc: make "all" default target of Makefile
 + git-credential-netrc: fix exit status when tests fail
 + git-credential-netrc: use in-tree Git.pm for tests
 + git-credential-netrc: minor whitespace cleanup in test script

 Build and test procedure for netrc credential helper (in contrib/)
 has been updated.

 Will merge to 'master'.


* jt/fetch-pack-negotiator (2018-06-15) 7 commits
 - fetch-pack: introduce negotiator API
 - fetch-pack: move common check and marking together
 - fetch-pack: make negotiation-related vars local
 - fetch-pack: use ref adv. to prune "have" sent
 - fetch-pack: directly end negotiation if ACK ready
 - fetch-pack: clear marks before re-marking
 - fetch-pack: split up everything_local()

 Code restructuring and a small fix to transport protocol v2 during
 fetching.


* ag/rebase-i-append-todo-help (2018-06-14) 2 commits
 - rebase--interactive: rewrite append_todo_help() in C
 - Merge branch 'ag/rebase-p' into ag/rebase-i-append-todo-help
 (this branch is used by ag/rebase-i-rewrite-todo.)

 Stepwise rewriting of the machinery of "rebase -i" into C continues.


* ag/rebase-i-rewrite-todo (2018-06-15) 3 commits
 - rebase--interactive: rewrite the edit-todo functionality in C
 - editor: add a function to launch the sequence editor
 - Merge branch 'bc/t3430-fixup' into ag/rebase-i-rewrite-todo
 (this branch uses ag/rebase-i-append-todo-help.)

 Stepwise rewriting of the machinery of "rebase -i" into C continues.


* sb/fix-fetching-moved-submodules (2018-06-14) 2 commits
  (merged to 'next' on 2018-06-22 at 16039dc62a)
 + t5526: test recursive submodules when fetching moved submodules
 + submodule: fix NULL correctness in renamed broken submodules

 The code to try seeing if a fetch is necessary in a submodule
 during a fetch with --recurse-submodules got confused when the path
 to the submodule was changed in the range of commits in the
 superproject, sometimes showing "(null)".  This has been corrected.

 Will merge to 'master'.


* sb/submodule-core-worktree (2018-06-19) 3 commits
  (merged to 'next' on 2018-06-22 at 2f7f263b30)
 + submodule deinit: unset core.worktree
 + submodule: ensure core.worktree is set after update
 + submodule: unset core.worktree if no working tree is present

 "git submodule" did not correctly adjust core.worktree setting that
 indicates whether/where a submodule repository has its associated
 working tree across various state transitions, which has been
 corrected.

 Will merge to 'master'.


* ds/ewah-cleanup (2018-06-21) 10 commits
  (merged to 'next' on 2018-06-22 at ad0ab374a1)
 + ewah: delete unused 'rlwit_discharge_empty()'
 + ewah: drop ewah_serialize_native function
 + ewah: drop ewah_deserialize function
 + ewah_io: delete unused 'ewah_serialize()'
 + ewah_bitmap: delete unused 'ewah_or()'
 + ewah_bitmap: delete unused 'ewah_not()'
 + ewah_bitmap: delete unused 'ewah_and_not()'
 + ewah_bitmap: delete unused 'ewah_and()'
 + ewah/bitmap.c: delete unused 'bitmap_each_bit()'
 + ewah/bitmap.c: delete unused 'bitmap_clear()'

 Remove unused function definitions and declarations from ewah
 bitmap subsystem.

 Will merge to 'master'.


* jc/clean-after-sanity-tests (2018-06-15) 1 commit
  (merged to 'next' on 2018-06-22 at 2df77b8af9)
 + tests: clean after SANITY tests

 test cleanup.

 Will merge to 'master'.


* is/parsing-line-range (2018-06-15) 2 commits
 - log: prevent error if line range ends past end of file
 - blame: prevent error if range ends past end of file

 Parsing of -L[<N>][,[<M>]] parameters "git blame" and "git log"
 take has been tweaked.


* ab/refspec-init-fix (2018-06-11) 3 commits
  (merged to 'next' on 2018-06-13 at 91d71d8435)
 + refspec: initalize `refspec_item` in `valid_fetch_refspec()`
 + refspec: add back a refspec_item_init() function
 + refspec: s/refspec_item_init/&_or_die/g

 Make refspec parsing codepath more robust.

 Will merge to 'master'.


* as/safecrlf-quiet-fix (2018-06-11) 1 commit
  (merged to 'next' on 2018-06-13 at b163674843)
 + config.c: fix regression for core.safecrlf false

 Fix for 2.17-era regression.

 Will merge to 'master'.


* sg/gpg-tests-fix (2018-06-11) 2 commits
  (merged to 'next' on 2018-06-13 at f3a05f1c41)
 + tests: make forging GPG signed commits and tags more robust
 + t7510-signed-commit: use 'test_must_fail'

 Some flaky tests have been fixed.

 Will merge to 'master'.


* jk/fetch-all-peeled-fix (2018-06-13) 2 commits
  (merged to 'next' on 2018-06-13 at 1333bb9d90)
 + fetch-pack: test explicitly that --all can fetch tag references pointing to non-commits
 + fetch-pack: don't try to fetch peel values with --all

 "git fetch-pack --all" used to unnecessarily fail upon seeing an
 annotated tag that points at an object other than a commit.

 Will merge to 'master'.


* en/merge-recursive-cleanup (2018-06-12) 6 commits
  (merged to 'next' on 2018-06-19 at d175cea416)
 + merge-recursive: add pointer about unduly complex looking code
 + merge-recursive: rename conflict_rename_*() family of functions
 + merge-recursive: clarify the rename_dir/RENAME_DIR meaning
 + merge-recursive: align labels with their respective code blocks
 + merge-recursive: fix numerous argument alignment issues
 + merge-recursive: fix miscellaneous grammar error in comment

 Code cleanup.

 Will merge to 'master'.


* jh/partial-clone (2018-06-12) 1 commit
  (merged to 'next' on 2018-06-13 at 818f864b0c)
 + list-objects: check if filter is NULL before using

 The recent addition of "partial clone" experimental feature kicked
 in when it shouldn't, namely, when there is no partial-clone filter
 defined even if extensions.partialclone is set.

 Will merge to 'master'.


* ms/send-pack-honor-config (2018-06-12) 1 commit
  (merged to 'next' on 2018-06-13 at e2cd933715)
 + builtin/send-pack: populate the default configs

 "git send-pack --signed" (hence "git push --signed" over the http
 transport) did not read user ident from the config mechanism to
 determine whom to sign the push certificate as, which has been
 corrected.

 Will merge to 'master'.


* ab/checkout-default-remote (2018-06-11) 8 commits
 - checkout & worktree: introduce checkout.defaultRemote
 - checkout: add advice for ambiguous "checkout <branch>"
 - builtin/checkout.c: use "ret" variable for return
 - checkout: pass the "num_matches" up to callers
 - checkout.c: change "unique" member to "num_matches"
 - checkout.c: introduce an *_INIT macro
 - checkout.h: wrap the arguments to unique_tracking_name()
 - checkout tests: index should be clean after dwim checkout


* pw/add-p-recount (2018-06-11) 1 commit
  (merged to 'next' on 2018-06-19 at 1880ecc3f1)
 + add -p: fix counting empty context lines in edited patches

 When user edits the patch in "git add -p" and the user's editor is
 set to strip trailing whitespaces indiscriminately, an empty line
 that is unchanged in the patch would become completely empty
 (instead of a line with a sole SP on it).  The code introduced in
 Git 2.17 timeframe failed to parse such a patch, but now it learned
 to notice the situation and cope with it.

 Will merge to 'master'.


* ds/commit-graph-fsck (2018-05-29) 20 commits
 - commit-graph: update design document
 - gc: automatically write commit-graph files
 - commit-graph: add '--reachable' option
 - fsck: verify commit-graph
 - commit-graph: verify contents match checksum
 - commit-graph: test for corrupted octopus edge
 - commit-graph: verify commit date
 - commit-graph: verify generation number
 - commit-graph: verify parent list
 - commit-graph: verify root tree OIDs
 - commit-graph: verify objects exist
 - commit-graph: verify corrupt OID fanout and lookup
 - commit-graph: verify required chunks are present
 - commit-graph: verify catches corrupt signature
 - commit-graph: add 'verify' subcommand
 - commit-graph: load a root tree from specific graph
 - commit: force commit to parse from object database
 - commit-graph: parse commit from chosen graph
 - commit-graph: fix GRAPH_MIN_SIZE
 - commit-graph: UNLEAK before die()

 Expecting a reroll.
 cf. <ba3b8e06-b5e1-99a1-0fe4-ff97d6da8f15@gmail.com>


* ma/wrapped-info (2018-05-28) 2 commits
 - usage: prefix all lines in `vreportf()`, not just the first
 - usage: extract `prefix_suffix_lines()` from `advise()`

 An attempt to help making multi-line messages fed to warning(),
 error(), and friends more easily translatable.

 Waiting for the discussion to settle.
 cf. <20180529213957.GF7964@sigill.intra.peff.net>


* nd/completion-negation (2018-06-11) 3 commits
  (merged to 'next' on 2018-06-19 at a3be59b450)
 + completion: collapse extra --no-.. options
 + completion: suppress some -no- options
 + parse-options: option to let --git-completion-helper show negative form

 Continuing with the idea to programatically enumerate various
 pieces of data required for command line completion, the codebase
 has been taught to enumerate options prefixed with "--no-" to
 negate them.

 Will merge to 'master'.


* jm/cache-entry-from-mem-pool (2018-06-21) 8 commits
 - block alloc: add validations around cache_entry lifecyle
 - block alloc: allocate cache entries from mem_pool
 - mem-pool: fill out functionality
 - mem-pool: add lifecycle management functions
 - mem-pool: tweak math on mp_block allocation size
 - mem-pool: only search head block for available space
 - block alloc: add lifecycle APIs for cache_entry structs
 - read-cache: teach refresh_cache_entry() to take istate

 For a large tree, the index needs to hold many cache entries
 allocated on heap.  These cache entries are now allocated out of a
 dedicated memory pool to amortize malloc(3) overhead.

 Kicked back to 'pu' with a rerolled one.
 cf. <20180620201557.77155-1-jamill@microsoft.com>


* sb/object-store-grafts (2018-05-18) 19 commits
  (merged to 'next' on 2018-06-22 at 386a6cc66a)
 + commit: allow lookup_commit_graft to handle arbitrary repositories
 + commit: allow prepare_commit_graft to handle arbitrary repositories
 + shallow: migrate shallow information into the object parser
 + path.c: migrate global git_path_* to take a repository argument
 + cache: convert get_graft_file to handle arbitrary repositories
 + commit: convert read_graft_file to handle arbitrary repositories
 + commit: convert register_commit_graft to handle arbitrary repositories
 + commit: convert commit_graft_pos() to handle arbitrary repositories
 + shallow: add repository argument to is_repository_shallow
 + shallow: add repository argument to check_shallow_file_for_update
 + shallow: add repository argument to register_shallow
 + shallow: add repository argument to set_alternate_shallow_file
 + commit: add repository argument to lookup_commit_graft
 + commit: add repository argument to prepare_commit_graft
 + commit: add repository argument to read_graft_file
 + commit: add repository argument to register_commit_graft
 + commit: add repository argument to commit_graft_pos
 + object: move grafts to object parser
 + object-store: move object access functions to object-store.h

 The conversion to pass "the_repository" and then "a_repository"
 throughout the object access API continues.

 Will merge to 'master'.


* js/branch-diff (2018-05-16) 19 commits
 - fixup! Add a function to solve least-cost assignment problems
 - completion: support branch-diff
 - branch-diff: add a man page
 - branch-diff --dual-color: work around bogus white-space warning
 - branch-diff: offer to dual-color the diffs
 - diff: add an internal option to dual-color diffs of diffs
 - color: provide inverted colors, too
 - branch-diff: use color for the commit pairs
 - branch-diff: add tests
 - branch-diff: do not show "function names" in hunk headers
 - branch-diff: adjust the output of the commit pairs
 - branch-diff: suppress the diff headers
 - branch-diff: indent the diffs just like tbdiff
 - branch-diff: right-trim commit messages
 - branch-diff: also show the diff between patches
 - branch-diff: improve the order of the shown commits
 - branch-diff: first rudimentary implementation
 - Add a new builtin: branch-diff
 - Add a function to solve least-cost assignment problems

 "git tbdiff" that lets us compare individual patches in two
 iterations of a topic has been rewritten and made into a built-in
 command.

 Expecting a reroll.
 cf. <nycvar.QRO.7.76.6.1805052351560.77@tvgsbejvaqbjf.bet>


* sb/diff-color-move-more (2018-06-25) 11 commits
 - diff: fix a sparse 'dubious one-bit signed bitfield' error
 - SQUASH??? t/4015 GETTEXT_POISON emergency fix
 - SQUASH????? Documentation breakage emergency fix
 - diff.c: add white space mode to move detection that allows indent changes
 - diff.c: factor advance_or_nullify out of mark_color_as_moved
 - diff.c: decouple white space treatment from move detection algorithm
 - diff.c: add a blocks mode for moved code detection
 - diff.c: adjust hash function signature to match hashmap expectation
 - diff.c: do not pass diff options as keydata to hashmap
 - xdiff/xdiffi.c: remove unneeded function declarations
 - xdiff/xdiff.h: remove unused flags

 "git diff --color-moved" feature has further been tweaked.

 Needs to be cleaned-up with various fix-up bits applied inline.


* jk/branch-l-0-deprecation (2018-06-22) 3 commits
 - branch: deprecate "-l" option
 - t: switch "branch -l" to "branch --create-reflog"
 - t3200: unset core.logallrefupdates when testing reflog creation
 (this branch is used by jk/branch-l-1-repurpose.)

 The "-l" option in "git branch -l" is an unfortunate short-hand for
 "--create-reflog", but many users, both old and new, somehow expect
 it to be something else, perhaps "--list".  This step warns when "-l"
 is used as a short-hand for "--create-reflog" and warns about the
 future repurposing of the it when it is used.

 Will merge to 'next'.
