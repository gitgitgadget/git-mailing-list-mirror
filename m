Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82BEE20372
	for <e@80x24.org>; Wed, 11 Oct 2017 06:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932623AbdJKGj3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 02:39:29 -0400
Received: from pb-sasl-trial2.pobox.com ([64.147.108.86]:50420 "EHLO
        pb-sasl-trial2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932617AbdJKGjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 02:39:25 -0400
Received: from pb-sasl-trial2.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id AFF8316B0F;
        Wed, 11 Oct 2017 02:39:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=XOJGfst7YkuWBpPcFFXEou1r0
        FM=; b=BAyXwoPgxadbkmZHphys0gi+k2pNA0qHc6AGnBgDzwzDZp2FUV6jjbiLm
        XE51G9CBDg5sml2JSgHLkgMroqZYBjf9MFdfs8nK8BKOZGu7rUAOHCl8bmTPYwmK
        3X3bWUtvmLVg44vc28tSgk+MqQuae7ctpItwMmYgsWCU5O9lK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=UDZciwQEwBqJSyuNbpj
        oRkntTnBJa9rxBmxqrRZlFVNVQL3pZM0IQJeoGJHfyMQacf9HTNzLzCwsFA7Cj4r
        8eBgVsXI2IrhSmjI4voV4qEGsV7D9Rqlcpf/oSn1nOrtl/PEOVsJLekDYCG6YeOi
        omdXnTTWbraxHLGFYgVnA36o=
Received: from pb-smtp2.nyi.icgroup.com (pb-smtp2.pobox.com [10.90.30.54])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 9A3C016B0E;
        Wed, 11 Oct 2017 02:39:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B6CE4A9A62;
        Wed, 11 Oct 2017 02:39:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2017, #02; Wed, 11)
X-master-at: 111ef79afe185f8731920569450f6a65320f5d5f
X-next-at: 92ea9504509327dacaba929d631d198e57533c14
Date:   Wed, 11 Oct 2017 15:39:19 +0900
Message-ID: <xmqqd15umbmw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E99FEA96-AE4E-11E7-AD8E-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

2.15-rc1 has been tagged.  Some of the topic marked "Will merge to
'master'" below might still become part of 2.15 final, while others
may be left to be merged after the final, to become part of the
release after that one (2.16?).

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ar/request-pull-phrasofix (2017-10-03) 1 commit
  (merged to 'next' on 2017-10-03 at 07807bba90)
 + request-pull: capitalise "Git" to make it a proper noun

 Spell the name of our system as "Git" in the output from
 request-pull script.


* ds/avoid-overflow-in-midpoint-computation (2017-10-10) 1 commit
  (merged to 'next' on 2017-10-10 at 6279867a5d)
 + cleanup: fix possible overflow errors in binary search

 Code clean-up.


* er/fast-import-dump-refs-on-checkpoint (2017-09-29) 1 commit
  (merged to 'next' on 2017-10-03 at 4e7b0e7ec1)
 + fast-import: checkpoint: dump branches/tags/marks even if object_count=
=3D=3D0

 The checkpoint command "git fast-import" did not flush updates to
 refs and marks unless at least one object was created since the
 last checkpoint, which has been corrected, as these things can
 happen without any new object getting created.


* hn/string-list-doc (2017-10-06) 1 commit
  (merged to 'next' on 2017-10-10 at d214a7c369)
 + api-argv-array.txt: remove broken link to string-list API

 Docfix.


* jk/refs-df-conflict (2017-10-07) 2 commits
  (merged to 'next' on 2017-10-10 at d5953a1ced)
 + refs_resolve_ref_unsafe: handle d/f conflicts for writes
 + t3308: create a real ref directory/file conflict

 An ancient bug that made Git misbehave with creation/renaming of
 refs has been fixed.


* jk/sha1-loose-object-info-fix (2017-10-06) 1 commit
  (merged to 'next' on 2017-10-10 at bcfd9c4e3f)
 + sha1_loose_object_info: handle errors from unpack_sha1_rest

 Leakfix and futureproofing.


* jk/ui-color-always-to-auto (2017-10-04) 3 commits
  (merged to 'next' on 2017-10-05 at 792ae936cf)
 + Merge branch 'jk/ui-color-always-to-auto-maint' into jk/ui-color-alway=
s-to-auto
 + t7301: use test_terminal to check color
 + t4015: use --color with --color-moved
 (this branch uses jk/ui-color-always-to-auto-maint.)

 Fix regression of "git add -p" for users with "color.ui =3D always"
 in their configuration, by merging the topic below and adjusting it
 for the 'master' front.


* jk/ui-color-always-to-auto-maint (2017-10-04) 10 commits
 + color: make "always" the same as "auto" in config
 + provide --color option for all ref-filter users
 + t3205: use --color instead of color.branch=3Dalways
 + t3203: drop "always" color test
 + t6006: drop "always" color config tests
 + t7502: use diff.noprefix for --verbose test
 + t7508: use test_terminal for color output
 + t3701: use test-terminal to collect color output
 + t4015: prefer --color to -c color.diff=3Dalways
 + test-terminal: set TERM=3Dvt100
 (this branch is used by jk/ui-color-always-to-auto.)

 Users with "color.ui =3D always" in their configuration were broken
 by a recent change that made plumbing commands to pay attention to
 them as the patch created internally by "git add -p" were colored
 (heh) and made unusable.  Fix this regression by redefining
 'always' to mean the same thing as 'auto'.


* jn/strbuf-doc-re-reuse (2017-10-04) 1 commit
  (merged to 'next' on 2017-10-04 at 5940d412d9)
 + strbuf doc: reuse after strbuf_release is fine


* jr/hash-migration-plan-doc (2017-09-28) 1 commit
  (merged to 'next' on 2017-10-04 at b47b3bb656)
 + technical doc: add a design doc for hash function transition

 Lay out plans for weaning us off of SHA-1.


* jt/oidmap (2017-10-01) 1 commit
  (merged to 'next' on 2017-10-05 at e41445fc33)
 + oidmap: map with OID as key

 Introduce a new "oidmap" API and rewrite oidset to use it.


* ks/branch-tweak-error-message-for-extra-args (2017-10-04) 1 commit
  (merged to 'next' on 2017-10-05 at aa0b656bf0)
 + branch: change the error messages to be more meaningful

 Error message tweak.


* ks/verify-filename-non-option-error-message-tweak (2017-10-04) 1 commit
  (merged to 'next' on 2017-10-05 at 2a7030f6fe)
 + setup: update error message to be more meaningful

 Error message tweak.


* ls/filter-process-delayed (2017-10-10) 5 commits
  (merged to 'next' on 2017-10-10 at 7b26d72991)
 + write_entry: untangle symlink and regular-file cases
 + write_entry: avoid reading blobs in CE_RETRY case
 + write_entry: fix leak when retrying delayed filter
 + entry.c: check if file exists after checkout
 + entry.c: update cache entry only for existing files

 Bugfixes to an already graduated series.


* ma/builtin-unleak (2017-10-02) 1 commit
  (merged to 'next' on 2017-10-05 at 380cb74320)
 + builtin/: add UNLEAKs

 Many variables that points at a region of memory that will live
 throughout the life of the program have been marked with UNLEAK
 marker to help the leak checkers concentrate on real leaks..


* rb/compat-poll-fix (2017-09-29) 1 commit
  (merged to 'next' on 2017-10-05 at c31029202d)
 + poll.c: always set revents, even if to zero

 Backports a moral equivalent of 2015 fix to the poll emulation from
 the upstream gnulib to fix occasional breakages on HPE NonStop.


* rs/cleanup-strbuf-users (2017-10-02) 3 commits
  (merged to 'next' on 2017-10-03 at 322ec33ad8)
 + graph: use strbuf_addchars() to add spaces
 + use strbuf_addstr() for adding strings to strbufs
 + path: use strbuf_add_real_path()

 Code clean-up.


* rs/cocci-de-paren-call-params (2017-10-02) 1 commit
  (merged to 'next' on 2017-10-03 at ee97fe5c24)
 + coccinelle: remove parentheses that become unnecessary

 Code clean-up.


* rs/fsck-null-return-from-lookup (2017-10-06) 1 commit
  (merged to 'next' on 2017-10-10 at 32dfa424cf)
 + fsck: handle NULL return of lookup_blob() and lookup_tree()

 Improve behaviour of "git fsck" upon finding a missing object.


* rs/qsort-s (2017-10-04) 1 commit
  (merged to 'next' on 2017-10-04 at 5f10a6e263)
 + test-stringlist: avoid buffer underrun when sorting nothing


* rs/resolve-ref-optional-result (2017-10-01) 2 commits
  (merged to 'next' on 2017-10-03 at f129d4b0e9)
 + refs: pass NULL to resolve_refdup() if hash is not needed
 + refs: pass NULL to refs_resolve_refdup() if hash is not needed

 Code clean-up.


* rs/rs-mailmap (2017-10-06) 1 commit
  (merged to 'next' on 2017-10-10 at 020d29b68c)
 + .mailmap: normalize name for Ren=C3=A9 Scharfe


* rs/run-command-use-alloc-array (2017-10-03) 1 commit
  (merged to 'next' on 2017-10-03 at e3869b6c32)
 + run-command: use ALLOC_ARRAY

 Code clean-up.


* rs/tag-null-pointer-arith-fix (2017-10-02) 1 commit
  (merged to 'next' on 2017-10-03 at e05d92fec9)
 + tag: avoid NULL pointer arithmetic

 Code clean-up.


* rs/use-free-and-null (2017-10-02) 1 commit
  (merged to 'next' on 2017-10-03 at 6340234d67)
 + repository: use FREE_AND_NULL

 Code clean-up.


* sb/branch-avoid-repeated-strbuf-release (2017-10-04) 1 commit
  (merged to 'next' on 2017-10-04 at bd86ef77fc)
 + branch: reset instead of release a strbuf


* sb/git-clang-format (2017-10-02) 1 commit
  (merged to 'next' on 2017-10-03 at b40d47b9d5)
 + clang-format: add a comment about the meaning/status of the

 Add comment to clarify that the style file is meant to be used with
 clang-5 and the rules are still work in progress.


* sb/test-cmp-expect-actual (2017-10-07) 1 commit
  (merged to 'next' on 2017-10-10 at c47a4dcc72)
 + tests: fix diff order arguments in test_cmp

 Test tweak.


* tb/complete-describe (2017-10-07) 1 commit
  (merged to 'next' on 2017-10-10 at 2607253946)
 + completion: add --broken and --dirty to describe

 Docfix.


* tb/delimit-pretty-trailers-args-with-comma (2017-10-02) 1 commit
  (merged to 'next' on 2017-10-04 at de5446a01c)
 + pretty.c: delimit "%(trailers)" arguments with ","
 (this branch is used by tb/show-trailers-in-ref-filter.)

 The feature that allows --pretty=3D'%(trailers)' to take modifiers
 like "fold" and "only" used to separate these modifiers with a
 comma, i.e. "%(trailers:fold:only)", but we changed our mind and
 use a comma, i.e. "%(trailers:fold,only)".  Fast track this change
 before this new feature becomes part of any official release.


* tb/ref-filter-empty-modifier (2017-10-05) 1 commit
  (merged to 'next' on 2017-10-05 at 62cb67688a)
 + ref-filter.c: pass empty-string as NULL to atom parsers

 In the "--format=3D..." option of the "git for-each-ref" command (and
 its friends, i.e. the listing mode of "git branch/tag"), "%(atom:)"
 (e.g. "%(refname:)", "%(body:)" used to error out.  Instead, treat
 them as if the colon and an empty string that follows it were not
 there.


* tb/show-trailers-in-ref-filter (2017-10-02) 6 commits
  (merged to 'next' on 2017-10-05 at c7a697f15d)
 + ref-filter.c: parse trailers arguments with %(contents) atom
 + ref-filter.c: use trailer_opts to format trailers
 + t6300: refactor %(trailers) tests
 + doc: use "`<literal>`"-style quoting for literal strings
 + doc: 'trailers' is the preferred way to format trailers
 + t4205: unfold across multiple lines

 "git for-each-ref --format=3D..." learned a new format element,
 %(trailers), to show only the commit log trailer part of the log
 message.


* tg/memfixes (2017-10-04) 3 commits
  (merged to 'next' on 2017-10-04 at fb338a5531)
 + sub-process: use child_process.args instead of child_process.argv
 + http-push: fix construction of hex value from path
 + path.c: fix uninitialized memory access

 Fixes for a handful memory access issues identified by valgrind.

--------------------------------------------------
[New Topics]

* dm/run-command-ignored-hook-advise (2017-10-10) 1 commit
  (merged to 'next' on 2017-10-10 at 0827814922)
 + run-command: add hint when a hook is ignored

 A hook script that is set unexecutable is simply ignored.  Git
 notifies when such a file is ignored, unless the message is
 squelched via advice.ignoredHook configuration.

 Will cook in 'next'.


* hv/fetch-moved-submodules-on-demand (2017-10-08) 5 commits
 - DONTMERGE: mark failing tests for now
 - submodule: simplify decision tree whether to or not to fetch
 - implement fetching of moved submodules
 - change submodule push test to use proper repository setup
 - fetch: add test to make sure we stay backwards compatible

 WIP.


* js/for-each-ref-remote-name-and-ref (2017-10-11) 3 commits
 - for-each-ref: test :remotename and :remoteref
 - for-each-ref: let upstream/push optionally report the remote ref name
 - for-each-ref: let upstream/push optionally report the remote name

 The "--format=3D..." option "git for-each-ref" takes learned to show
 the name of the 'remote' repository and the ref at the remote side
 that is affected for 'upstream' and 'push' via "%(push:remotename)"
 and friends.


* pb/bisect-helper (2017-10-06) 6 commits
 - bisect--helper: `is_expected_rev` & `check_expected_revs` shell functi=
on in C
 - t6030: explicitly test for bisection cleanup
 - bisect--helper: `bisect_clean_state` shell function in C
 - bisect--helper: `write_terms` shell function in C
 - bisect--helper: rewrite `check_term_format` shell function in C
 - bisect--helper: use OPT_CMDMODE instead of OPT_BOOL

 An early part of piece-by-piece rewrite of "git bisect".

 Will merge to 'next'.


* bc/object-id (2017-10-09) 24 commits
 - refs/files-backend: convert static functions to object_id
 - refs: convert read_raw_ref backends to struct object_id
 - refs: convert peel_object to struct object_id
 - refs: convert resolve_ref_unsafe to struct object_id
 - worktree: convert struct worktree to object_id
 - refs: convert resolve_gitlink_ref to struct object_id
 - resolve_gitlink_ref(): convert remaining callers to object_id
 - sha1_file: convert index_path and index_fd to struct object_id
 - refs: convert reflog_expire parameter to struct object_id
 - refs: convert read_ref_at to struct object_id
 - refs: convert peel_ref to struct object_id
 - builtin/pack-objects: convert to struct object_id
 - pack-bitmap: convert traverse_bitmap_commit_list to object_id
 - refs: convert dwim_log to struct object_id
 - builtin/reflog: convert remaining unsigned char uses to object_id
 - refs: convert dwim_ref and expand_ref to struct object_id
 - refs: convert read_ref and read_ref_full to object_id
 - refs: convert resolve_refdup and refs_resolve_refdup to struct object_=
id
 - check_connected(): use struct object_id
 - refs: update ref transactions to use struct object_id
 - refs: convert update_ref and refs_update_ref to use struct object_id
 - refs: convert delete_ref and refs_delete_ref to struct object_id
 - refs/files-backend: convert struct ref_to_prune to object_id
 - walker: convert to struct object_id


* jc/no-cmd-as-subroutine (2017-10-11) 2 commits
 - merge-ours: do not use cmd_*() as a subroutine
 - describe: do not use cmd_*() as a subroutine

 Calling cmd_foo() as if it is a general purpose helper function is
 a no-no.  Correct two instances of such to set an example.


* jc/doc-checkout (2017-10-11) 1 commit
 - checkout doc: clarify command line args for "checkout paths" mode

 Doc update.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* mk/use-size-t-in-zlib (2017-08-10) 1 commit
 . zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

 Needs resurrecting by making sure the fix is good and still applies
 (or adjusted to today's codebase).


* mg/status-in-progress-info (2017-05-10) 2 commits
 - status --short --inprogress: spell it as --in-progress
 - status: show in-progress info for short status

 "git status" learns an option to report various operations
 (e.g. "merging") that the user is in the middle of.

 cf. <xmqqmvakcdqw.fsf@gitster.mtv.corp.google.com>


* nd/worktree-move (2017-04-20) 6 commits
 - worktree remove: new command
 - worktree move: refuse to move worktrees with submodules
 - worktree move: accept destination as directory
 - worktree move: new command
 - worktree.c: add update_worktree_location()
 - worktree.c: add validate_worktree()

 "git worktree" learned move and remove subcommands.

 Expecting a reroll.
 cf. <20170420101024.7593-1-pclouds@gmail.com>
 cf. <20170421145916.mknekgqzhxffu7di@sigill.intra.peff.net>
 cf. <d0e81b1e-5869-299e-f462-4d43dc997bd1@ramsayjones.plus.com>


* sg/clone-refspec-from-command-line-config (2017-06-16) 2 commits
 - Documentation/clone: document ignored configuration variables
 - clone: respect additional configured fetch refspecs during initial fet=
ch
 (this branch is used by sg/remote-no-string-refspecs.)

 "git clone -c var=3Dval" is a way to set configuration variables in
 the resulting repository, but it is more useful to also make these
 variables take effect while the initial clone is happening,
 e.g. these configuration variables could be fetch refspecs.

 Waiting for a response.
 cf. <20170617112228.vugswym4o4owf6wj@sigill.intra.peff.net>
 cf. <xmqqmv8zhdap.fsf@gitster.mtv.corp.google.com>

--------------------------------------------------
[Cooking]

* jc/merge-symlink-ours-theirs (2017-09-26) 1 commit
 - merge: teach -Xours/-Xtheirs to symbolic link merge

 "git merge -Xours/-Xtheirs" learned to use our/their version when
 resolving a conflicting updates to a symbolic link.

 Needs review.


* jt/partial-clone-lazy-fetch (2017-10-02) 18 commits
 - fetch-pack: restore save_commit_buffer after use
 - unpack-trees: batch fetching of missing blobs
 - clone: configure blobmaxbytes in created repos
 - clone: support excluding large blobs
 - fetch: support excluding large blobs
 - fetch: refactor calculation of remote list
 - fetch-pack: support excluding large blobs
 - pack-objects: support --blob-max-bytes
 - pack-objects: rename want_.* to ignore_.*
 - gc: do not repack promisor packfiles
 - rev-list: support termination at promisor objects
 - sha1_file: support lazily fetching missing objects
 - introduce fetch-object: fetch one promisor object
 - index-pack: refactor writing of .keep files
 - fsck: support promisor objects as CLI argument
 - fsck: support referenced promisor objects
 - fsck: support refs pointing to promisor objects
 - fsck: introduce partialclone extension

 A journey for "git clone" and "git fetch" to become "lazier" by
 depending more on its remote repository---this is the beginning of
 it.

 Needs review.


* ma/lockfile-fixes (2017-10-07) 12 commits
 - read_cache: roll back lock in `update_index_if_able()`
 - read-cache: leave lock in right state in `write_locked_index()`
 - read-cache: drop explicit `CLOSE_LOCK`-flag
 - cache.h: document `write_locked_index()`
 - apply: remove `newfd` from `struct apply_state`
 - apply: move lockfile into `apply_state`
 - cache-tree: simplify locking logic
 - checkout-index: simplify locking logic
 - tempfile: fix documentation on `delete_tempfile()`
 - lockfile: fix documentation on `close_lock_file_gently()`
 - treewide: prefer lockfiles on the stack
 - sha1_file: do not leak `lock_file`

 An earlier update made it possible to use an on-stack in-core
 lockfile structure (as opposed to having to deliberately leak an
 on-heap one).  Many codepaths have been updated to take advantage
 of this new facility.

 Looking good.  Is this ready for 'next'?


* ot/mru-on-list (2017-10-01) 1 commit
  (merged to 'next' on 2017-10-07 at e6ad4a16a2)
 + mru: use double-linked list from list.h

 The first step to getting rid of mru API and using the
 doubly-linked list API directly instead.

 Will cook in 'next'.


* jm/svn-pushmergeinfo-fix (2017-09-17) 1 commit
 - git-svn: fix svn.pushmergeinfo handling of svn+ssh usernames.

 "git svn dcommit" did not take into account the fact that a
 svn+ssh:// URL with a username@ (typically used for pushing) refers
 to the same SVN repository without the username@ and failed when
 svn.pushmergeinfo option is set.

 Needs a test, perhaps as a follow-up patch.


* mg/merge-base-fork-point (2017-09-17) 3 commits
 - merge-base: find fork-point outside partial reflog
 - merge-base: return fork-point outside reflog
 - t6010: test actual test output

 "merge-base --fork-point $branch $commit" is used to guess on which
 commit among the commits that were once at the tip of the $branch the
 $commit was built on top of, and it learns these historical tips from
 the reflog of the $branch.  When the true fork-point is lost due to
 pruning of old reflog entries, the command does not give any output,
 because it has no way to guess correctly and does not want to mislead
 the user with a wrong guess.

 The command has been updated to give the best but not known to be
 correct guess, based on a hope that a merge-base between $commit and a
 virtual merge across all the reflog entries that still are available
 for $branch may still be a closer to the true fork-point than the
 merge-base between $commit and the current tip of the $branch.

 This may have to be offered by an additional option, to allow the
 users that are prepared to see a potentially incorrect guess to opt
 into the feature, without affecting the current callers that may not
 be prepared to accept a guess that is not known to be correct.

 What's the doneness of this one?


* ds/find-unique-abbrev-optim (2017-10-09) 4 commits
 - sha1_name: minimize OID comparisons during disambiguation
 - sha1_name: parse less while finding common prefix
 - sha1_name: unroll len loop in find_unique_abbrev_r()
 - p4211-line-log.sh: add log --online --raw --parents perf test

 Optimize the code to find shortest unique prefix of object names.

 Almost there.
 cf. <20171009134933.vmba67adelqbkx4y@sigill.intra.peff.net>


* cc/perf-run-config (2017-09-24) 9 commits
 - perf: store subsection results in "test-results/$GIT_PERF_SUBSECTION/"
 - perf/run: show name of rev being built
 - perf/run: add run_subsection()
 - perf/run: update get_var_from_env_or_config() for subsections
 - perf/run: add get_subsections()
 - perf/run: add calls to get_var_from_env_or_config()
 - perf/run: add GIT_PERF_DIRS_OR_REVS
 - perf/run: add get_var_from_env_or_config()
 - perf/run: add '--config' option to the 'run' script

 Needs review.


* mg/merge-pre-merge-hook (2017-09-24) 4 commits
 - t7503: add tests for pre-merge-hook
 - merge: --no-verify to bypass pre-merge hook
 - merge: do no-verify like commit
 - git-merge: honor pre-merge hook

 "git merge" learned a 'pre-merge' hook, that would be triggered
 before the merge commit is created by a clean auto-merge.

 Waiting for review to conclude.


* bp/fsmonitor (2017-10-05) 15 commits
  (merged to 'next' on 2017-10-05 at 964a029d13)
 + fsmonitor: preserve utf8 filenames in fsmonitor-watchman log
 + fsmonitor: read entirety of watchman output
 + fsmonitor: MINGW support for watchman integration
  (merged to 'next' on 2017-10-02 at cf0c67979c)
 + fsmonitor: add a performance test
 + fsmonitor: add a sample integration script for Watchman
 + fsmonitor: add test cases for fsmonitor extension
 + split-index: disable the fsmonitor extension when running the split in=
dex test
 + fsmonitor: add a test tool to dump the index extension
 + update-index: add fsmonitor support to update-index
 + ls-files: Add support in ls-files to display the fsmonitor valid bit
 + fsmonitor: add documentation for the fsmonitor extension.
 + fsmonitor: teach git to optionally utilize a file system monitor to sp=
eed up detecting new or changed files.
 + update-index: add a new --force-write-index option
 + preload-index: add override to enable testing preload-index
 + bswap: add 64 bit endianness helper get_be64

 We learned to talk to watchman to speed up "git status" and other
 operations that need to see which paths have been modified.

 Will cook in 'next'.


* bw/protocol-v1 (2017-10-04) 10 commits
 - ssh: introduce a 'simple' ssh variant
 - i5700: add interop test for protocol transition
 - http: tell server that the client understands v1
 - connect: tell server that the client understands v1
 - connect: teach client to recognize v1 server response
 - upload-pack, receive-pack: introduce protocol version 1
 - daemon: recognize hidden request arguments
 - protocol: introduce protocol extention mechanisms
 - pkt-line: add packet_write function
 - connect: in ref advertisement, shallows are last

 A new mechanism to upgrade the wire protocol in place is proposed
 and demonstrated that it works with the older versions of Git
 without harming them.

 Expecting a reroll.
 cf. <20171003214206.GY19555@aiede.mtv.corp.google.com>
 The tip one needs to clarify that it is not just '-o' but also '-p'
 option in the documentation.  Other than that, the approach taken
 by the series basically seems sane and well received.


* pc/submodule-helper (2017-10-07) 3 commits
 - submodule: port submodule subcommand 'status' from shell to C
 - submodule--helper: introduce for_each_listed_submodule()
 - submodule--helper: introduce get_submodule_displaypath()

 GSoC.
 Is this ready for 'next'?


* bc/hash-algo (2017-10-04) 6 commits
 - fixup! hash-algo: integrate hash algorithm support with repo setup
 - hash-algo: switch empty tree and blob lookups to use hash abstraction
 - hash-algo: integrate hash algorithm support with repo setup
 - hash-algo: add structure representing hash algorithm
 - setup: expose enumerated repo info
 - Merge branch 'bc/vcs-svn-cleanup' into bc/hash-algo

 RFC
 cf. <20170821000022.26729-1-sandals@crustytoothpaste.net>


* jk/drop-ancient-curl (2017-08-09) 5 commits
 - http: #error on too-old curl
 - curl: remove ifdef'd code never used with curl >=3D7.19.4
 - http: drop support for curl < 7.19.4
 - http: drop support for curl < 7.16.0
 - http: drop support for curl < 7.11.1

 Some code in http.c that has bitrot is being removed.

 Will be rerolled after tc/curl-with-backports stabilizes.


* sb/submodule-recursive-checkout-detach-head (2017-07-28) 2 commits
 - Documentation/checkout: clarify submodule HEADs to be detached
 - recursive submodules: detach HEAD from new state

 "git checkout --recursive" may overwrite and rewind the history of
 the branch that happens to be checked out in submodule
 repositories, which might not be desirable.  Detach the HEAD but
 still allow the recursive checkout to succeed in such a case.

 Undecided.
 This needs justification in a larger picture; it is unclear why
 this is better than rejecting recursive checkout, for example.


* jk/check-ref-format-oor-fix (2017-07-14) 1 commit
 - check-ref-format: require a repository for --branch

 Discussion slowly continues...
 cf. <20170717172709.GL93855@aiede.mtv.corp.google.com>
 cf. <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net>


* rs/sha1-file-micro-optim (2017-07-09) 2 commits
 - SQUASH???
 - sha1_file: add slash once in for_each_file_in_obj_subdir()

 Code cleanup.

 Perhaps drop.
 cf. <f59c8256-716b-9305-2a4f-d4fe49f666ff@web.de>


* ex/deprecate-empty-pathspec-as-match-all (2017-06-23) 2 commits
  (merged to 'next' on 2017-08-14 at 24db08a6e8)
 + pathspec: die on empty strings as pathspec
 + t0027: do not use an empty string as a pathspec element

 The final step to make an empty string as a pathspec element
 illegal.  We started this by first deprecating and warning a
 pathspec that has such an element in 2.11 (Nov 2016).

 Hopefully we can merge this down to the 'master' by the end of the
 year?  A deprecation warning period that is about 1 year does not
 sound too bad.

 Will cook in 'next'.
 As the draft RelNotes says, let's merge this to 'master' after
 this release cycle.

--------------------------------------------------
[Discarded]

* jc/ref-filter-colors-fix (2017-10-03) 2 commits
 . colors: git_default_config() does not read color.ui
 . Revert "color: check color.ui in git_default_config()"

 Recent tip of 'master' and 'maint' (at least as of v2.14.2) has a
 regression in "git add -p" for those who set ui.color=3Dalways in
 their configuration, caused by us being overly aggressive in
 allowing plumbing commands to honor the configuration to fix a
 fallout from an earlier change that made everybody, even the
 plumbing commands, to automatically color its output by default.
 Revert it for now from the released version (and to be released
 one) until we come up with a different fix to the problem.


* jc/allow-lazy-cas (2017-07-06) 1 commit
 . push: disable lazy --force-with-lease by default

 Because "git push --force-with-lease[=3D<ref>]" that relies on the
 stability of remote-tracking branches is unsafe when something
 fetches into the repository behind user's back, it is now disabled
 by default.  A new configuration variable can be used to enable it
 by users who know what they are doing.  This would pave the way to
 possibly turn `--force` into `--force-with-lease`.

 Will discard.
 Independent from disabling the feature by default, this stirred up
 a discussion to replace the DWIM heuristics with a better one, which
 deserves to be its own topic.
 cf. <alpine.DEB.2.21.1.1707131435220.4193@virtualbox>
