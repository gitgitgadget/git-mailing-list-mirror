Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4957120951
	for <e@80x24.org>; Fri, 17 Mar 2017 21:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbdCQVic (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 17:38:32 -0400
Received: from pb-sasl-trial2.pobox.com ([64.147.108.86]:55913 "EHLO
        pb-sasl-trial2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbdCQVia (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 17:38:30 -0400
Received: from pb-sasl-trial2.pobox.com (ro.sql.pobox.com [127.0.0.1])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 646DF1041B;
        Fri, 17 Mar 2017 17:15:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=K
        DRka/Nl7Z4XyG0iCwNMWvsJS94=; b=mt9SAC8YHkSH1pHkkktyTOcv0IQ10rr/S
        ZVGVE7qVGnkCsyghfWzAn1vgh4oXEITYjyt8Zj+BaMO2fthunhrMxmWoe9GH0UhY
        7fWYvHXTrY0rk22rT0RgurxZBRLw6Ry04rK3YgbsSwCjKG+Ot9Qn5rv6AkWPZX6b
        t469BuEbe4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=dBH
        ATbaVPxSi2ggPxM3XxFf58DeFH7x+F9R06/GSuGctn1KkqB3K1PUyqQKbjirxDkd
        JNuBD128wCCQhAGlhBtzpWulATadR+OB4S3yCKmN/ur9yhWdQrA9DQ9ojkOIN9Ev
        D5F/xJsagPuaTl8DkcN2YG7CtDzHNdZ5w70X8my4=
Received: from pb-smtp1.nyi.icgroup.com (pb-smtp1.pobox.com [10.90.30.53])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 43F461041A;
        Fri, 17 Mar 2017 17:15:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 600D87B8C6;
        Fri, 17 Mar 2017 17:15:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Mar 2017, #07; Fri, 17)
X-master-at: 9d77b0405ce6b471cb5ce3a904368fc25e55643d
X-next-at: ad415229794d1880faab8b9fdd535ab7cc736444
Date:   Fri, 17 Mar 2017 14:15:10 -0700
Message-ID: <xmqqr31v61wh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE529E64-0B56-11E7-910F-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

Quite a few topics have graduated to 'master' this week.  We now
have +300 non-merge commits spanning +70 topics since v2.12.0.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bc/object-id (2017-02-22) 19 commits
  (merged to 'next' on 2017-03-14 at 0b3ec5a05e)
 + wt-status: convert to struct object_id
 + builtin/merge-base: convert to struct object_id
 + Convert object iteration callbacks to struct object_id
 + sha1_file: introduce an nth_packed_object_oid function
 + refs: simplify parsing of reflog entries
 + refs: convert each_reflog_ent_fn to struct object_id
 + reflog-walk: convert struct reflog_info to struct object_id
 + builtin/replace: convert to struct object_id
 + Convert remaining callers of resolve_refdup to object_id
 + builtin/merge: convert to struct object_id
 + builtin/clone: convert to struct object_id
 + builtin/branch: convert to struct object_id
 + builtin/grep: convert to struct object_id
 + builtin/fmt-merge-message: convert to struct object_id
 + builtin/fast-export: convert to struct object_id
 + builtin/describe: convert to struct object_id
 + builtin/diff-tree: convert to struct object_id
 + builtin/commit: convert to struct object_id
 + hex: introduce parse_oid_hex

 "uchar [40]" to "struct object_id" conversion continues.


* bc/sha1-header-selection-with-cpp-macros (2017-03-15) 1 commit
  (merged to 'next' on 2017-03-15 at 71c3a4f4ba)
 + hash.h: move SHA-1 implementation selection into a header file
 (this branch is used by jk/sha1dc.)

 Our source code has used the SHA1_HEADER cpp macro after "#include"
 in the C code to switch among the SHA-1 implementations. Instead,
 list the exact header file names and switch among implementations
 using "#ifdef BLK_SHA1/#include "block-sha1/sha1.h"/.../#endif";
 this helps some IDE tools.


* bw/attr-pathspec (2017-03-13) 2 commits
  (merged to 'next' on 2017-03-14 at 3af5d6c1fc)
 + pathspec: allow escaped query values
 + pathspec: allow querying for attributes

 The pathspec mechanism learned to further limit the paths that
 match the pattern to those that have specified attributes attached
 via the gitattributes mechanism.


* cc/split-index-config (2017-03-06) 22 commits
  (merged to 'next' on 2017-03-12 at 53cdc2016d)
 + Documentation/git-update-index: explain splitIndex.*
 + Documentation/config: add splitIndex.sharedIndexExpire
 + read-cache: use freshen_shared_index() in read_index_from()
 + read-cache: refactor read_index_from()
 + t1700: test shared index file expiration
 + read-cache: unlink old sharedindex files
 + config: add git_config_get_expiry() from gc.c
 + read-cache: touch shared index files when used
 + sha1_file: make check_and_freshen_file() non static
 + Documentation/config: add splitIndex.maxPercentChange
 + t1700: add tests for splitIndex.maxPercentChange
 + read-cache: regenerate shared index if necessary
 + config: add git_config_get_max_percent_split_change()
 + Documentation/git-update-index: talk about core.splitIndex config var
 + Documentation/config: add information for core.splitIndex
 + t1700: add tests for core.splitIndex
 + update-index: warn in case of split-index incoherency
 + read-cache: add and then use tweak_split_index()
 + split-index: add {add,remove}_split_index() functions
 + config: add git_config_get_split_index()
 + t1700: change here document style
 + config: mark an error message up for translation

 The experimental "split index" feature has gained a few
 configuration variables to make it easier to use.


* jk/add-i-use-pathspecs (2017-03-14) 1 commit
  (merged to 'next' on 2017-03-14 at 13ce4d91e1)
 + add--interactive: do not expand pathspecs with ls-files

 "git add -p <pathspec>" unnecessarily expanded the pathspec to a
 list of individual files that matches the pathspec by running "git
 ls-files <pathspec>", before feeding it to "git diff-index" to see
 which paths have changes, because historically the pathspec
 language supported by "diff-index" was weaker.  These days they are
 equivalent and there is no reason to internally expand it.  This
 helps both performance and avoids command line argument limit on
 some platforms.


* jk/cherry-pick-0-mainline (2017-03-15) 1 commit
  (merged to 'next' on 2017-03-16 at e9a888e5c4)
 + cherry-pick: detect bogus arguments to --mainline

 "git revert -m 0 $merge_commit" complained that reverting a merge
 needs to say relative to which parent the reversion needs to
 happen, as if "-m 0" weren't given.  The correct diagnosis is that
 "-m 0" does not refer to the first parent ("-m 1" does).  This has
 been fixed.


* jk/http-walker-buffer-underflow-fix (2017-03-13) 1 commit
  (merged to 'next' on 2017-03-14 at 02020b475d)
 + http-walker: fix buffer underflow processing remote alternates

 "Dumb http" transport used to misparse a nonsense http-alternates
 response, which has been fixed.


* jk/interop-test (2017-03-10) 2 commits
  (merged to 'next' on 2017-03-12 at 704b328022)
 + t/interop: add test of old clients against modern git-daemon
 + t: add an interoperability test harness

 Picking two versions of Git and running tests to make sure the
 older one and the newer one interoperate happily has now become
 possible.


* jk/ref-filter-flags-cleanup (2017-03-10) 4 commits
  (merged to 'next' on 2017-03-14 at c335c9cf6e)
 + ref-filter: use separate cache for contains_tag_algo
 + ref-filter: die on parse_commit errors
 + ref-filter: use contains_result enum consistently
 + ref-filter: move ref_cbdata definition into ref-filter.c
 (this branch is used by ab/ref-filter-no-contains.)

 "git tag --contains" used to (ab)use the object bits to keep track
 of the state of object reachability without clearing them after
 use; this has been cleaned up and made to use the newer commit-slab
 facility.


* js/early-config (2017-03-14) 12 commits
  (merged to 'next' on 2017-03-14 at ce43b4a309)
 + setup.c: mention unresolved problems
 + t1309: document cases where we would want early config not to die()
 + setup_git_directory_gently_1(): avoid die()ing
 + t1309: test read_early_config()
 + read_early_config(): really discover .git/
 + read_early_config(): avoid .git/config hack when unneeded
 + setup: make read_early_config() reusable
 + setup: introduce the discover_git_directory() function
 + setup_git_directory_1(): avoid changing global state
 + setup: prepare setup_discovered_git_dir() for the root directory
 + setup_git_directory(): use is_dir_sep() helper
 + t7006: replace dubious test

 The start-up sequence of "git" needs to figure out some configured
 settings before it finds and set itself up in the location of the
 repository and was quite messy due to its "chicken-and-egg" nature.
 The code has been restructured.


* mg/status-porcelain-no-i18n (2017-03-14) 1 commit
  (merged to 'next' on 2017-03-14 at 0955895825)
 + git-status: make porcelain more robust

 "git status --porcelain" is supposed to give a stable output, but a
 few strings were left as translatable by mistake.


* rs/blame-code-cleanup (2017-03-11) 1 commit
  (merged to 'next' on 2017-03-12 at 8fd4bf325a)
 + blame: move blame_entry duplication to add_blame_entry()

 Code clean-up.


* sb/rev-parse-show-superproject-root (2017-03-08) 1 commit
  (merged to 'next' on 2017-03-14 at 537c299db6)
 + rev-parse: add --show-superproject-working-tree

 From a working tree of a repository, a new option of "rev-parse"
 lets you ask if the repository is used as a submodule of another
 project, and where the root level of the working tree of that
 project (i.e. your superproject) is.

--------------------------------------------------
[New Topics]

* jc/name-rev (2017-03-16) 2 commits
 - name-rev: favor describing with tags and use committer date to tiebreak
 - name-rev: refactor logic to see if a new candidate is a better name

 "git name-rev" penalized lightweight tags too much, making them
 almost useless especially when the command is run with "--tags".
 Give the same precedence to lightweight tags as annotated tags as
 the base for naming a commit.


* jk/pack-name-cleanups (2017-03-16) 5 commits
  (merged to 'next' on 2017-03-16 at 6aa72195f5)
 + index-pack: make pointer-alias fallbacks safer
 + replace snprintf with odb_pack_name()
 + odb_pack_keep(): stop generating keepfile name
 + sha1_file.c: make pack-name helper globally accessible
 + move odb_* declarations out of git-compat-util.h

 Code clean-up.

 Will merge to 'master'.


* jk/rev-parse-cleanup (2017-03-15) 3 commits
  (merged to 'next' on 2017-03-16 at 2799b37404)
 + rev-parse: simplify parsing of ref options
 + rev-parse: add helper for parsing "--foo/--foo="
 + rev-parse: use skip_prefix when parsing options

 Code clean-up.

 Will merge to 'master'.


* js/difftool-builtin (2017-03-15) 3 commits
  (merged to 'next' on 2017-03-16 at 3fccb60a07)
 + difftool: handle modified symlinks in dir-diff mode
 + t7800: cleanup cruft left behind by tests
 + t7800: remove whitespace before redirect

 "git difftool --dir-diff" used to die a controlled death giving a
 "fatal" message when encountering a locally modified symbolic link,
 but it started segfaulting since v2.12.  This has been fixed.

 Will merge to 'master'.


* mg/prompt-describe-tags (2017-03-15) 1 commit
  (merged to 'next' on 2017-03-16 at 4de192caf4)
 + git-prompt: add a describe style for any tags

 The command line prompt (in contrib/) learned a new 'tag' style
 that can be specified with GIT_PS1_DESCRIBE_STYLE, to describe a
 detached HEAD with "git describe --tags".

 Will merge to 'master'.


* sb/submodule-config-parse-ignore-fix (2017-03-15) 1 commit
  (merged to 'next' on 2017-03-16 at 99d2524abd)
 + submodule-config: correct error reporting for invalid ignore value

 Code to read submodule.<name>.ignore config did not state the
 variable name correctly when giving an error message diagnosing
 misconfiguration.

 Will merge to 'master'.


* bw/recurse-submodules-relative-fix (2017-03-17) 5 commits
 - ls-files: fix bug when recursing with relative pathspec
 - ls-files: fix typo in variable name
 - grep: fix bug when recursing with relative pathspec
 - setup: allow for prefix to be passed to git commands
 - grep: fix help text typo

 A few commands that recently learned the "--recurse-submodule"
 option misbehaved when started from a subdirectory of the
 superproject.


* jc/p4-current-branch-fix (2017-03-17) 1 commit
 - DONTMERGE git-p4: "name-rev HEAD" is not a way to find the current branch

 "git p4" used "name-rev HEAD" when it wants to learn what branch is
 checked out; it should use "symbolic-ref HEAD".

 Waiting for git-p4 folks to send a finished patch.


* js/rebase-helper (2017-03-17) 1 commit
 - sequencer: drop "warning:" when stopping for edit

 Recent update to "rebase -i" started showing a message that is not
 a warning with "warning:" prefix by mistake.  This has been fixed.

 Will merge to 'next'.


* sb/wt-status-cleanup (2017-03-17) 1 commit
 - wt-status: simplify by using for_each_string_list_item

 Code clean-up.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* sg/clone-refspec-from-command-line-config (2017-02-27) 1 commit
 - clone: respect configured fetch respecs during initial fetch

 Expecting a reroll.
 cf. <20170227211217.73gydlxb2qu2sp3m@sigill.intra.peff.net>
 cf. <CAM0VKj=rsAfKvVccOMOoo5==Q1yW1U0zJBbUV=faKppWFm-u+g@mail.gmail.com>


* sk/dash-is-previous (2017-03-01) 5 commits
 - revert.c: delegate handling of "-" shorthand to setup_revisions
 - sha1_name.c: teach get_sha1_1 "-" shorthand for "@{-1}"
 - revision.c: args starting with "-" might be a revision
 - revision.c: swap if/else blocks
 - revision.c: do not update argv with unknown option

 A dash "-" can be written to mean "the branch that was previously
 checked out" in more places.

 Needs review.
 cf. <1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com>


* jh/memihash-opt (2017-02-17) 5 commits
 - name-hash: remember previous dir_entry during lazy_init_name_hash
 - name-hash: specify initial size for istate.dir_hash table
 - name-hash: precompute hash values during preload-index
 - hashmap: allow memihash computation to be continued
 - name-hash: eliminate duplicate memihash call

 Expecting an update for perf.
 cf. <MWHPR03MB29581B0EDDEDCA7D51EC396F8A280@MWHPR03MB2958.namprd03.prod.outlook.com>


* ls/filter-process-delayed (2017-03-06) 1 commit
 - convert: add "status=delayed" to filter process protocol

 What's the status of this one???
 cf. <xmqq60jmnmef.fsf@junio-linux.mtv.corp.google.com>


* ab/ref-filter-no-contains (2017-03-11) 1 commit
 - ref-filter: add --no-contains option to tag/branch/for-each-ref

 "git tag/branch/for-each-ref" family of commands long allowed to
 filter the refs by "--contains X" (show only the refs that are
 descendants of X), "--merged X" (show only the refs that are
 ancestors of X), "--no-merged X" (show only the refs that are not
 ancestors of X).  One curious omission, "--no-contains X" (show
 only the refs that are not descendants of X) has been added to
 them.

 Expecting a reroll.
 cf. <CACBZZX4v49zfyGVpcxGSKsxbMfVaUcGHtitpfaZMUtG82YzW-g@mail.gmail.com>
 The topic is almost there.


* sg/completion-refs-speedup (2017-02-13) 13 commits
 - squash! completion: fill COMPREPLY directly when completing refs
 - completion: fill COMPREPLY directly when completing refs
 - completion: list only matching symbolic and pseudorefs when completing refs
 - completion: let 'for-each-ref' sort remote branches for 'checkout' DWIMery
 - completion: let 'for-each-ref' filter remote branches for 'checkout' DWIMery
 - completion: let 'for-each-ref' strip the remote name from remote branches
 - completion: let 'for-each-ref' and 'ls-remote' filter matching refs
 - completion: don't disambiguate short refs
 - completion: don't disambiguate tags and branches
 - completion: support excluding full refs
 - completion: support completing full refs after '--option=refs/<TAB>'
 - completion: wrap __git_refs() for better option parsing
 - completion: remove redundant __gitcomp_nl() options from _git_commit()

 The refs completion for large number of refs has been sped up,
 partly by giving up disambiguating ambiguous refs and partly by
 eliminating most of the shell processing between 'git for-each-ref'
 and 'ls-remote' and Bash's completion facility.

 What's the donness of this topic?


* nd/prune-in-worktree (2017-02-19) 15 commits
 . rev-list: expose and document --single-worktree
 . revision.c: --reflog add HEAD reflog from all worktrees
 . files-backend: make reflog iterator go through per-worktree reflog
 . refs: add refs_for_each_reflog[_ent]()
 . revision.c: --all adds HEAD from all worktrees
 . refs: remove dead for_each_*_submodule()
 . revision.c: use refs_for_each*() instead of for_each_*_submodule()
 . refs: add a refs_for_each_in() and friends
 . refs: add refs_for_each_ref()
 . refs: add refs_head_ref()
 . refs: add refs_read_ref[_full]()
 . refs: move submodule slash stripping code to get_submodule_ref_store
 . revision.c: --indexed-objects add objects from all worktrees
 . revision.c: refactor add_index_objects_to_pending()
 . revision.h: new flag in struct rev_info wrt. worktree-related refs
 (this branch uses nd/worktree-kill-parse-ref; is tangled with nd/files-backend-git-dir.)

 "git gc" and friends when multiple worktrees are used off of a
 single repository did not consider the index and per-worktree refs
 of other worktrees as the root for reachability traversal, making
 objects that are in use only in other worktrees to be subject to
 garbage collection.


* nd/worktree-kill-parse-ref (2017-02-19) 22 commits
 . refs: kill set_worktree_head_symref()
 . refs: add refs_create_symref()
 . worktree.c: kill parse_ref() in favor of refs_resolve_ref_unsafe()
 . refs.c: add refs_resolve_ref_unsafe()
 . refs: introduce get_worktree_ref_store()
 . refs: rename get_ref_store() to get_submodule_ref_store() and make it public
 . files-backend: remove submodule_allowed from files_downcast()
 . refs: move submodule code out of files-backend.c
 . path.c: move some code out of strbuf_git_path_submodule()
 . refs.c: make get_main_ref_store() public and use it
 . refs.c: kill register_ref_store(), add register_submodule_ref_store()
 . refs.c: flatten get_ref_store() a bit
 . refs: rename lookup_ref_store() to lookup_submodule_ref_store()
 . refs.c: introduce get_main_ref_store()
 . files-backend: remove the use of git_path()
 . refs.c: share is_per_worktree_ref() to files-backend.c
 . files-backend: replace *git_path*() with files_path()
 . files-backend: add files_path()
 . files-backend: convert git_path() to strbuf_git_path()
 . refs-internal.c: make files_log_ref_write() static
 . Merge branch 'mh/ref-remove-empty-directory' into nd/files-backend-git-dir
 . Merge branch 'mh/submodule-hash' into nd/files-backend-git-dir
 (this branch is used by nd/prune-in-worktree; is tangled with nd/files-backend-git-dir.)

 (hopefully) a beginning of safer "git worktree" that is resistant
 to "gc".

 Waiting for nd/files-backend-git-dir to settle.


* nd/files-backend-git-dir (2017-02-22) 26 commits
 . t1406: new tests for submodule ref store
 . t1405: some basic tests on main ref store
 . t/helper: add test-ref-store to test ref-store functions
 . refs: delete pack_refs() in favor of refs_pack_refs()
 . files-backend: avoid ref api targetting main ref store
 . refs: new transaction related ref-store api
 . refs: add new ref-store api
 . refs: rename get_ref_store() to get_submodule_ref_store() and make it public
 . files-backend: replace submodule_allowed check in files_downcast()
 . refs: move submodule code out of files-backend.c
 . path.c: move some code out of strbuf_git_path_submodule()
 . refs.c: make get_main_ref_store() public and use it
 . refs.c: kill register_ref_store(), add register_submodule_ref_store()
 . refs.c: flatten get_ref_store() a bit
 . refs: rename lookup_ref_store() to lookup_submodule_ref_store()
 . refs.c: introduce get_main_ref_store()
 . files-backend: remove the use of git_path()
 . files-backend: add and use files_refname_path()
 . files-backend: add and use files_reflog_path()
 . files-backend: move "logs/" out of TMP_RENAMED_LOG
 . files-backend: convert git_path() to strbuf_git_path()
 . files-backend: add and use files_packed_refs_path()
 . files-backend: make files_log_ref_write() static
 . refs.h: add forward declaration for structs used in this file
 . Merge branch 'mh/ref-remove-empty-directory' into nd/files-backend-git-dir
 . Merge branch 'mh/submodule-hash' into nd/files-backend-git-dir
 (this branch is tangled with nd/prune-in-worktree and nd/worktree-kill-parse-ref.)

 The "submodule" specific field in the ref_store structure is
 replaced with a more generic "gitdir" that can later be used also
 when dealing with ref_store that represents the set of refs visible
 from the other worktrees.


* nd/worktree-move (2017-01-27) 7 commits
 . fixup! worktree move: new command
 . worktree remove: new command
 . worktree move: refuse to move worktrees with submodules
 . worktree move: accept destination as directory
 . worktree move: new command
 . worktree.c: add update_worktree_location()
 . worktree.c: add validate_worktree()

 "git worktree" learned move and remove subcommands.

 Tentatively ejected as it seems to break 'pu' when merged.


* pb/bisect (2017-02-18) 28 commits
 - fixup! bisect--helper: `bisect_next_check` & bisect_voc shell function in C
 - bisect--helper: remove the dequote in bisect_start()
 - bisect--helper: retire `--bisect-auto-next` subcommand
 - bisect--helper: retire `--bisect-autostart` subcommand
 - bisect--helper: retire `--bisect-write` subcommand
 - bisect--helper: `bisect_replay` shell function in C
 - bisect--helper: `bisect_log` shell function in C
 - bisect--helper: retire `--write-terms` subcommand
 - bisect--helper: retire `--check-expected-revs` subcommand
 - bisect--helper: `bisect_state` & `bisect_head` shell function in C
 - bisect--helper: `bisect_autostart` shell function in C
 - bisect--helper: retire `--next-all` subcommand
 - bisect--helper: retire `--bisect-clean-state` subcommand
 - bisect--helper: `bisect_next` and `bisect_auto_next` shell function in C
 - t6030: no cleanup with bad merge base
 - bisect--helper: `bisect_start` shell function partially in C
 - bisect--helper: `get_terms` & `bisect_terms` shell function in C
 - bisect--helper: `bisect_next_check` & bisect_voc shell function in C
 - bisect--helper: `check_and_set_terms` shell function in C
 - bisect--helper: `bisect_write` shell function in C
 - bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
 - bisect--helper: `bisect_reset` shell function in C
 - wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
 - t6030: explicitly test for bisection cleanup
 - bisect--helper: `bisect_clean_state` shell function in C
 - bisect--helper: `write_terms` shell function in C
 - bisect: rewrite `check_term_format` shell function in C
 - bisect--helper: use OPT_CMDMODE instead of OPT_BOOL

 Move more parts of "git bisect" to C.

 Expecting a reroll.
 cf. <CAFZEwPPXPPHi8KiEGS9ggzNHDCGhuqMgH9Z8-Pf9GLshg8+LPA@mail.gmail.com>
 cf. <CAFZEwPM9RSTGN54dzaw9gO9iZmsYjJ_d1SjUD4EzSDDbmh-XuA@mail.gmail.com>
 cf. <CAFZEwPNUXcNY9Qdz=_B7q2kQuaecPzJtTMGdv8YMUPEz2vnp8A@mail.gmail.com>


* sh/grep-tree-obj-tweak-output (2017-01-20) 2 commits
 - grep: use '/' delimiter for paths
 - grep: only add delimiter if there isn't one already

 "git grep", when fed a tree-ish as an input, shows each hit
 prefixed with "<tree-ish>:<path>:<lineno>:".  As <tree-ish> is
 almost always either a commit or a tag that points at a commit, the
 early part of the output "<tree-ish>:<path>" can be used as the
 name of the blob and given to "git show".  When <tree-ish> is a
 tree given in the extended SHA-1 syntax (e.g. "<commit>:", or
 "<commit>:<dir>"), however, this results in a string that does not
 name a blob (e.g. "<commit>::<path>" or "<commit>:<dir>:<path>").
 "git grep" has been taught to be a bit more intelligent about these
 cases and omit a colon (in the former case) or use slash (in the
 latter case) to produce "<commit>:<path>" and
 "<commit>:<dir>/<path>" that can be used as the name of a blob.

 Expecting a reroll?  Is this good enough with known limitations?


* jc/diff-b-m (2015-02-23) 5 commits
 . WIPWIP
 . WIP: diff-b-m
 - diffcore-rename: allow easier debugging
 - diffcore-rename.c: add locate_rename_src()
 - diffcore-break: allow debugging

 "git diff -B -M" produced incorrect patch when the postimage of a
 completely rewritten file is similar to the preimage of a removed
 file; such a resulting file must not be expressed as a rename from
 other place.

 The fix in this patch is broken, unfortunately.

 Will discard.

--------------------------------------------------
[Cooking]

* bw/submodule-is-active (2017-03-17) 10 commits
 - submodule add: respect submodule.active and submodule.<name>.active
 - submodule--helper init: set submodule.<name>.active
 - clone: teach --recurse-submodules to optionally take a pathspec
 - submodule init: initialize active submodules
 - submodule: decouple url and submodule interest
 - submodule--helper clone: check for configured submodules using helper
 - submodule sync: use submodule--helper is-active
 - submodule sync: skip work for inactive submodules
 - submodule status: use submodule--helper is-active
 - submodule--helper: add is-active subcommand

 "what URL do we want to update this submodule?" and "are we
 interested in this submodule?" are split into two distinct
 concepts, and then the way used to express the latter got extended,
 paving a way to make it easier to manage a project with many
 submodules and make it possible to later extend use of multiple
 worktrees for a project with submodules.

 This looks almost ready for 'next'.  Any more comments?


* dl/credential-cache-socket-in-xdg-cache (2017-03-17) 3 commits
 - credential-cache: add tests for XDG functionality
 - credential-cache: use XDG_CACHE_HOME for socket
 - path.c: add xdg_cache_home

 The default location "~/.git-credential-cache/socket" for the
 socket used to communicate with the credential-cache daemon has
 been moved to "~/.cache/git/credential/socket".

 Will merge to 'next'.


* jk/sha1dc (2017-03-17) 6 commits
 - Makefile: make DC_SHA1 the default
 - t0013: add a basic sha1 collision detection test
 - Makefile: add DC_SHA1 knob
 - sha1dc: disable safe_hash feature
 - sha1dc: adjust header includes for git
 - sha1dc: add collision-detecting sha1 implementation

 Borrow "detect attempt to create collisions" variant of SHA-1
 implementation by Marc Stevens (CWI) and Dan Shumow (Microsoft).

 This looks almost ready for 'next'.  Any more comments?


* nd/conditional-config-include (2017-03-11) 3 commits
  (merged to 'next' on 2017-03-17 at 788a931e39)
 + config: add conditional include
 + config.txt: reflow the second include.path paragraph
 + config.txt: clarify multiple key values in include.path

 The configuration file learned a new "includeIf.<condition>.path"
 that includes the contents of the given path only when the
 condition holds.  This allows you to say "include this work-related
 bit only in the repositories under my ~/work/ directory".

 Will merge to 'master'.


* sb/checkout-recurse-submodules (2017-03-16) 19 commits
 - builtin/read-tree: add --recurse-submodules switch
 - builtin/checkout: add --recurse-submodules switch
 - entry.c: create submodules when interesting
 - unpack-trees: check if we can perform the operation for submodules
 - unpack-trees: pass old oid to verify_clean_submodule
 - update submodules: add submodule_move_head
 - submodule.c: get_super_prefix_or_empty
 - update submodules: move up prepare_submodule_repo_env
 - submodules: introduce check to see whether to touch a submodule
 - update submodules: add a config option to determine if submodules are updated
 - update submodules: add submodule config parsing
 - make is_submodule_populated gently
 - lib-submodule-update.sh: define tests for recursing into submodules
 - lib-submodule-update.sh: replace sha1 by hash
 - lib-submodule-update: teach test_submodule_content the -C <dir> flag
 - lib-submodule-update.sh: do not use ./. as submodule remote
 - lib-submodule-update.sh: reorder create_lib_submodule_repo
 - submodule--helper.c: remove duplicate code
 - connect_work_tree_and_git_dir: safely create leading directories

 "git checkout" is taught --recurse-submodules option.

 This looks almost ready for 'next'.  Any more comments?


* jk/no-looking-at-dotgit-outside-repo-final (2016-10-26) 1 commit
  (merged to 'next' on 2017-02-27 at 7373a1b73d)
 + setup_git_env: avoid blind fall-back to ".git"

 This is the endgame of the topic to avoid blindly falling back to
 ".git" when the setup sequence said we are _not_ in Git repository.
 A corner case that happens to work right now may be broken by a
 call to die("BUG").

 Will cook in 'next'.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
  (merged to 'next' on 2017-02-27 at 2c0f5f73d8)
 + merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007, and issues a deprecation
 warning message since v2.5.0.

 Will cook in 'next'.


* jc/bundle (2016-03-03) 6 commits
 - index-pack: --clone-bundle option
 - Merge branch 'jc/index-pack' into jc/bundle
 - bundle v3: the beginning
 - bundle: keep a copy of bundle file name in the in-core bundle header
 - bundle: plug resource leak
 - bundle doc: 'verify' is not about verifying the bundle

 The beginning of "split bundle", which could be one of the
 ingredients to allow "git clone" traffic off of the core server
 network to CDN.
