Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73B121FF30
	for <e@80x24.org>; Mon, 22 May 2017 06:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752019AbdEVGLe (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 02:11:34 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32775 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbdEVGLc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 02:11:32 -0400
Received: by mail-pf0-f194.google.com with SMTP id f27so17694197pfe.0
        for <git@vger.kernel.org>; Sun, 21 May 2017 23:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=DOEwzAz29SbFOfXwL43F/H1jBiUG+RZzjeSXpZaQYqg=;
        b=hy3fs2D6YkUAAZxAvK0D+KBzzE5t1WTShnZNVSncVahFjCbVYNvTxKSrOnuH/yvCob
         xheBWFzRJiJtU8D9P2g5lPKi7KtMJ899csLralO+5WRnvY6BJZhjYkDcT+21d8GPLrWu
         3mwLsgyxDIQygNLHT8MiG6SomfLkbTSREDkZjT4QebZWFiC5KI7cLbJj5GbWhoLcGSlH
         ehp7ProIcBTsqILNF0l8ybVgYYidVjWqQu0F4MEk7H+dVS8azGOn7foZ2exSroWRmn30
         xK3V/kFLJJVUyl83X5+BT0ci96dYkWPYqUCNmjD2t1VloPTBgohwVVOxS3hBVIp9j3S+
         drQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=DOEwzAz29SbFOfXwL43F/H1jBiUG+RZzjeSXpZaQYqg=;
        b=iuCeBiFht7Fc8SPJqJtlIzzwsxMgw76oJwhD4jNPT7L0Lw4bgiiO4IkATvDln29QH2
         NvSkqjIAzAE1z7uAr5yWbrRx4xkRchoBnSFMiqbZKbVYzraOMAblf3UeWA7aLgCr4UmA
         9L2uBFPlLq5wWiEk4ZSisCAD2DbhWTReqhU1jKeB86CSjKsa5KelgPe82s/tyiSeh+8L
         easSc2F7i3tBowzb/8XFPo7rI4CuQLMp4MDR+SmBqYkVCqHGqP8twXptchMJfobsQJQ0
         Tkhgl81YW0WjQvnwrVXIiUvBlz6c3c32QQVAuduVHys7kkARiz/9tnzbdmtbn4uCQC0P
         evig==
X-Gm-Message-State: AODbwcAtkYRtB+vgczTByKvv6zpnGgpPK56U7s7Qk8L7miS0qMbzDXrV
        P+xuc4NHDiaXHw==
X-Received: by 10.84.129.65 with SMTP id 59mr26745316plb.166.1495433490457;
        Sun, 21 May 2017 23:11:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4439:f55c:c49b:d0dc])
        by smtp.gmail.com with ESMTPSA id s63sm28591290pgb.40.2017.05.21.23.11.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 21 May 2017 23:11:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (May 2017, #06; Mon, 22)
X-master-at: 10c78a162fa821ee85203165b805ff46be454091
X-next-at: 20371eebb69346345f908fea7f7cbd2909a91c2c
Date:   Mon, 22 May 2017 15:11:28 +0900
Message-ID: <xmqqo9ulo1yn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What's cooking in git.git (May 2017, #06; Mon, 22)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The tip of 'next' has been rewound, and the first batch of topics
for the next release have been merged to 'master'.  I tentatively
wrote doen that this cycle will last for 11 weeks, completing at the
end of July.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* ab/conditional-config-with-symlinks (2017-05-17) 1 commit
 - config: match both symlink & realpath versions in IncludeIf.gitdir:*

 The recently introduced "[includeIf "gitdir:$dir"] path=..."
 mechansim has further been taught to take symlinks into account.
 The directory "$dir" specified in "gitdir:$dir" may be a symlink to
 a real location, not something that $(getcwd) may return.  In such
 a case, a realpath of "$dir" is compared with the real path of the
 current repository to determine if the contents from the named path
 should be included.

 Will merge to 'next'.


* bm/interpret-trailers-cut-line-is-eom (2017-05-18) 1 commit
 - interpret-trailers: honor the cut line

 "git interpret-trailers", when used as GIT_EDITOR for "git commit
 -v", looked for and appended to a trailer block at the very end,
 i.e. at the end of the "diff" output.  The command has been
 corrected to pay attention to the cut-mark line "commit -v" adds to
 the buffer---the real trailer block should appear just before it.

 Will merge to 'next'.


* jc/skip-test-in-the-middle (2017-05-18) 2 commits
 - t5545: enhance test coverage when no http server is installed
 - test: allow skipping the remainder

 A recent update to t5545-push-options.sh started skipping all the
 tests in the script when a web server testing is disabled or
 unavailable, not just the ones that require a web server.  Non HTTP
 tests have been salvaged to always run in this script.

 Will merge to 'next'.


* jk/alternate-ref-optim (2017-05-18) 1 commit
 - t5400: avoid concurrent writes into a trace file

 A test allowed both "git push" and "git receive-pack" on the other
 end write their traces into the same file.  This is OK on platforms
 that allows atomically appending to a file opened with O_APPEND,
 but on other platforms led to a mangled output, causing
 intermittent test failures.  This has been fixed by disabling
 traces from "receive-pack" in the test.

 Will merge to 'next'.


* mh/packed-ref-store-prep (2017-05-18) 23 commits
 - cache_ref_iterator_begin(): avoid priming unneeded directories
 - ref-filter: limit traversal to prefix
 - create_ref_entry(): remove `check_name` option
 - refs_ref_iterator_begin(): handle `GIT_REF_PARANOIA`
 - read_packed_refs(): report unexpected fopen() failures
 - read_packed_refs(): do more of the work of reading packed refs
 - get_packed_ref_cache(): assume "packed-refs" won't change while locked
 - should_pack_ref(): new function, extracted from `files_pack_refs()`
 - ref_update_reject_duplicates(): add a sanity check
 - ref_update_reject_duplicates(): use `size_t` rather than `int`
 - ref_update_reject_duplicates(): expose function to whole refs module
 - ref_transaction_commit(): break into multiple functions
 - files_transaction_cleanup(): new helper function
 - files_ref_store: put the packed files lock directly in this struct
 - files-backend: move `lock` member to `files_ref_store`
 - lockfile: add a new method, is_lock_file_locked()
 - ref_store: take `logmsg` parameter when deleting references
 - refs: use `size_t` indexes when iterating over ref transaction updates
 - refs_ref_iterator_begin(): don't check prefixes redundantly
 - prefix_ref_iterator: don't trim too much
 - ref_iterator_begin_fn(): fix docstring
 - refs.h: clarify docstring for the ref_transaction_update()-related fns
 - t3600: clean up permissions test properly

 The implementation of "ref" API around the "packed refs" have been
 cleaned up, in preparation for further changes.

 Expecting a reroll.


* sl/clean-d-ignored-fix (2017-05-22) 7 commits
 - SQUASH????
 - clean: teach clean -d to skip dirs containing ignored files
 - dir: expose cmp_name() and check_contains()
 - dir: hide untracked contents of untracked dirs
 - dir: recurse into untracked dirs for ignored files
 - t7061: status --ignored should search untracked dirs
 - t7300: clean -d should skip dirs with ignored files

 "git clean -d" used to clean directories that has ignored files,
 even though the command should not lose ignored ones without "-x".
 This has been corrected.


* tg/stash-push-fixup (2017-05-17) 1 commit
 - completion: add git stash push

 The shell completion script (in contrib/) learned "git stash" has
 a new "push" subcommand.

 Will merge to 'next'.


* ab/sha1dc (2017-05-22) 3 commits
 - sha1collisiondetection: automatically enable when submodule is populated
 - sha1dc: optionally use sha1collisiondetection as a submodule
 - sha1dc: update from upstream

 The "collission-detecting" implementation of SHA-1 hash we borrowed
 from is replaced by directly binding the upstream project as our
 submodule.

 Will keep in 'pu' for a few CI cycles.
 Impact to the various build and release infrastructure of using
 submodule is not yet fully known, but this lets us dip our toes.


* bp/fsmonitor (2017-05-21) 10 commits
 - SQUASH???
 - SQUASH???
 - SQUASH???
 - fsmonitor: add a sample query-fsmonitor hook script for Watchman
 - fsmonitor: add documentation for the fsmonitor extension.
 - fsmonitor: add test cases for fsmonitor extension
 - SQUASH???
 - fsmonitor: teach git to optionally utilize a file system monitor to speed up detecting new or changed files.
 - dir: make lookup_untracked() available outside of dir.c
 - bswap: add 64 bit endianness helper get_be64

 Expecting reroll.


* dk/send-email-avoid-net-smtp-ssl-when-able (2017-05-20) 1 commit
 - send-email: Net::SMTP::SSL is obsolete, use only when necessary

 "git send-email" now uses Net::SMTP::SSL, which is obsolete, only
 when needed.  Recent versions of Net::SMTP can do TLS natively.

 Will merge to 'next'.


* jc/name-rev-lw-tag (2017-03-29) 2 commits
 - name-rev: favor describing with tags and use committer date to tiebreak
 - name-rev: refactor logic to see if a new candidate is a better name
 (this branch is used by mg/name-rev-debug.)

 "git describe --contains" penalized light-weight tags so much that
 they were almost never considered.  Instead, give them about the
 same chance to be considered as an annotated tag that is the same
 age as the underlying commit would.

 Will merge to 'next'.


* jk/diff-blob (2017-05-20) 15 commits
 - diff: use blob path for blob/file diffs
 - diff: use pending "path" if it is available
 - diff: use the word "path" instead of "name" for blobs
 - diff: pass whole pending entry in blobinfo
 - handle_revision_arg: record paths for pending objects
 - handle_revision_arg: record modes for "a..b" endpoints
 - t4063: add tests of direct blob diffs
 - get_sha1_with_context: dynamically allocate oc->path
 - get_sha1_with_context: always initialize oc->symlink_path
 - sha1_name: consistently refer to object_context as "oc"
 - handle_revision_arg: add handle_dotdot() helper
 - handle_revision_arg: hoist ".." check out of range parsing
 - handle_revision_arg: stop using "dotdot" as a generic pointer
 - handle_revision_arg: simplify commit reference lookups
 - handle_revision_arg: reset "dotdot" consistently

 The result from "git diff" that compares two blobs, e.g. "git diff
 $commit1:$path $commit2:$path", used to be shown with the full
 object name as given on the command line, but it is more natural to
 use the $path in the output and use it to look up .gitattributes.

 Needs review.


* jk/ignore-broken-tags-when-ignoring-missing-links (2017-05-20) 1 commit
 - revision.c: ignore broken tags with ignore_missing_links

 Tag objects, which are not reachable from any ref, that point at
 missing objects were mishandled by "git gc" and friends (they
 should silently be ignored instead)
 
 Will merge to 'next'.


* js/bs-is-a-dir-sep-on-windows (2017-05-20) 2 commits
 - Windows: do not treat a path with backslashes as a remote's nick name
 - mingw.h: permit arguments with side effects for is_dir_sep

 "foo\bar\baz" in "git fetch foo\bar\baz", even though there is no
 slashes in it, cannot be a nickname for a remote on Windows, as
 that is likely to be a pathname on a local filesystem.

 Will merge to 'next'.


* js/larger-timestamps (2017-05-20) 1 commit
 - name-rev: change a "long" variable to timestamp_t

 A follow-up hotfix for a topic already in 'master'.

 Will merge to 'next'.


* km/log-showsignature-doc (2017-05-20) 1 commit
 - config.txt: add an entry for log.showSignature

 Will merge to 'next'.


* kn/ref-filter-branch-list (2017-05-20) 1 commit
 - ref-filter: resolve HEAD when parsing %(HEAD) atom

 "git for-each-ref --format=..." with %(HEAD) in the format used to
 resolve the HEAD symref as many times as it had processed refs,
 which was wasteful, and "git branch" shared the same problem.

 Will merge to 'next'.


* pw/rebase-i-regression-fix (2017-05-20) 3 commits
 - rebase -i: add missing newline to end of message
 - rebase -i: silence stash apply
 - rebase -i: fix reflog message

 Regression fix to topic recently merged to 'master'.

 Will merge to 'next'.


* sb/diff-color-move (2017-05-20) 20 commits
 - diff.c: color moved lines differently
 - diff: buffer all output if asked to
 - diff.c: emit_line includes whitespace highlighting
 - diff.c: convert diff_summary to use emit_line_*
 - diff.c: convert diff_flush to use emit_line_*
 - diff.c: convert word diffing to use emit_line_*
 - diff.c: convert show_stats to use emit_line_*
 - diff.c: convert emit_binary_diff_body to use emit_line_*
 - submodule.c: convert show_submodule_summary to use emit_line_fmt
 - diff.c: convert emit_rewrite_lines to use emit_line_*
 - diff.c: convert emit_rewrite_diff to use emit_line_*
 - diff.c: convert builtin_diff to use emit_line_*
 - diff.c: convert fn_out_consume to use emit_line
 - diff.c: inline emit_line_0 into emit_line
 - diff.c: emit_line_0 takes parameter whether to output line prefix
 - diff.c: emit_line_0 can handle no color setting
 - diff.c: teach emit_line_0 to accept sign parameter
 - diff.c: factor out diff_flush_patch_all_file_pairs
 - diff: move line ending check into emit_hunk_header
 - diff: readability fix

 "git diff" has been taught to optionally paint new lines that are
 the same as deleted lines elsewhere differently from genuinely new
 lines.


* xz/send-email-batch-size (2017-05-22) 2 commits
 - SQUASH???
 - send-email: --batch-size to work around some SMTP server limit

 "git send-email" learned to overcome some SMTP server limitation
 that does not allow many pieces of e-mails to be sent over a single
 session.


--------------------------------------------------
[Stalled]

* mg/status-in-progress-info (2017-05-10) 2 commits
 - status --short --inprogress: spell it as --in-progress
 - status: show in-progress info for short status

 "git status" learns an option to report various operations
 (e.g. "merging") that the user is in the middle of.

 cf. <xmqqmvakcdqw.fsf@gitster.mtv.corp.google.com>


* mg/name-rev-debug (2017-03-31) 2 commits
 - describe: pass --debug down to name-rev
 - name-rev: provide debug output
 (this branch uses jc/name-rev-lw-tag.)

 "git describe --debug --contains" did not add any meaningful
 information, even though without "--contains" it did.


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


* df/dir-iter-remove-subtree (2017-04-19) 5 commits
 - remove_subtree(): reimplement using iterators
 - dir_iterator: rewrite state machine model
 - dir_iterator: refactor dir_iterator_advance
 - remove_subtree(): test removing nested directories
 - dir_iterator: add tests for dir_iterator API

 Update the dir-iterator API and use it to reimplement
 remove_subtree().

 A reroll exists that is based on the updated 'master', but I ran
 out of time trying to get it to work with other topics in flight
 in 'pu'.
 GSoC microproject.


* ls/filter-process-delayed (2017-03-06) 1 commit
 - convert: add "status=delayed" to filter process protocol

 Expecting a reroll.


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

--------------------------------------------------
[Cooking]

* ah/log-decorate-default-to-auto (2017-05-15) 1 commit
  (merged to 'next' on 2017-05-20 at 209614479c)
 + builtin/log: honor log.decorate

 Setting "log.decorate=false" in the configuration file did not take
 effect in v2.13, which has been corrected.

 Will merge to 'master'.


* jh/memihash-opt (2017-05-16) 5 commits
 - p0004: don't error out if test repo is too small
 - p0004: don't abort if multi-threaded is too slow
 - p0004: use test_perf
 - p0004: avoid using pipes
 - p0004: simplify calls of test-lazy-init-name-hash

 perf-test update.

 Will merge to 'next'.


* jk/bug-to-abort (2017-05-22) 4 commits
  (merged to 'next' on 2017-05-22 at 20371eebb6)
 + usage: add NORETURN to BUG() function definitions
  (merged to 'next' on 2017-05-20 at db65acc882)
 + config: complain about --local outside of a git repo
 + setup_git_env: convert die("BUG") to BUG()
 + usage.c: add BUG() function

 Introduce the BUG() macro to improve die("BUG: ...").

 Will merge to 'master'.


* jk/no-looking-at-dotgit-outside-repo (2017-05-15) 1 commit
 - config: complain about --local outside of a git repo

 Will discard.
 Superseded by jk/bug-to-abort.


* jk/update-links-in-docs (2017-05-15) 1 commit
 - doc: use https links to Wikipedia to avoid http redirects

 A few http:// links that are redirected to https:// in the
 documentation have been updated to https:// links.

 Will merge to 'next'.


* js/blame-lib (2017-05-15) 22 commits
 - blame: create entry prepend function in libgit
 - blame: create scoreboard setup function in libgit
 - blame: create scoreboard init function in libgit
 - blame: move scoreboard-related methods to libgit
 - blame: move fake-commit-related methods to libgit
 - blame: move origin-related methods to libgit
 - blame: rework methods that determine 'final' commit
 - blame: wrap blame_sort and compare_blame_final
 - blame: move progess updates to a scoreboard callback
 - blame: make sanity_check use a callback in scoreboard
 - blame: move no_whole_file_rename flag to scoreboard
 - blame: move xdl_opts flags to scoreboard
 - blame: move show_root flag to scoreboard
 - blame: move reverse flag to scoreboard
 - blame: move contents_from to scoreboard
 - blame: move copy/move thresholds to scoreboard
 - blame: move stat counters to scoreboard
 - blame: move scoreboard structure to header
 - blame: move origin and entry structures to header
 - blame: remove unused parameters
 - blame: move textconv_object with related functions
 - blame: remove unneeded dependency on blob.h

 The internal logic used in "git blame" has been libified to make it
 easier to use by cgit.


* jt/send-email-validate-hook (2017-05-16) 1 commit
 - send-email: support validate hook

 "git send-email" learned to run sendemail-validate hook to inspect
 and reject a message before sending it out.

 Will merge to 'next'.


* bw/pathspec-sans-the-index (2017-05-12) 6 commits
 - pathspec: convert find_pathspecs_matching_against_index to take an index
 - pathspec: remove PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP
 - ls-files: prevent prune_cache from overeagerly pruning submodules
 - pathspec: remove PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE flag
 - submodule: add die_in_unpopulated_submodule function
 - pathspec: provide a more descriptive die message

 Simplify parse_pathspec() codepath and stop it from looking at the
 default in-core index.

 Will merge to 'next'.


* jt/fetch-allow-tip-sha1-implicitly (2017-05-16) 1 commit
 - fetch-pack: always allow fetching of literal SHA1s

 There is no good reason why "git fetch $there $sha1" should fail
 when the $sha1 names an object at the tip of an advertised ref,
 even when the other side hasn't enabled allowTipSHA1InWant.

 Will merge to 'next'.


* jc/read-tree-empty-with-m (2017-05-10) 1 commit
  (merged to 'next' on 2017-05-20 at 7e86815364)
 + read-tree: "read-tree -m --empty" does not make sense

 "git read-tree -m" (no tree-ish) gave a nonsense suggestion "use
 --empty if you want to clear the index".  With "-m", such a request
 will still fail anyway, as you'd need to name at least one tree-ish
 to be merged.

 Will merge to 'master'.


* ab/perf-wildmatch (2017-05-12) 2 commits
 - perf: add test showing exponential growth in path globbing
 - perf: add function to setup a fresh test repo

 Add perf-test for wildmatch.

 Will merge to 'next'.


* jk/doc-config-include (2017-05-12) 4 commits
 - docs/config: consistify include.path examples
 - docs/config: avoid the term "expand" for includes
 - docs/config: give a relative includeIf example
 - docs/config: clarify include/includeIf relationship

 Clarify documentation for include.path and includeIf.<condition>.path
 configuration variables.

 Will merge to 'next'.


* js/retire-old-remote-spec (2017-05-12) 11 commits
 . PREVIEW: remove support for .git/remotes/ and .git/branches/
 . PREVIEW: t0060: stop testing support for .git/remotes/ and .git/branches/
 . PREVIEW: t5515: remove .git/remotes/ and .git/branches/ tests
 . PREVIEW: remote: remove support for migrating ancient remotes
 . PREVIEW: t5516: stop testing .git/branches/ functionality
 . PREVIEW: t5510: convert .git/remotes/ test to use a regular remote
 . Revert "Revert "Don't create the $GIT_DIR/branches directory on init""
 . remote: warn loud and clear when .git/remotes/ is *still* used
 . remote: warn loud and clear when .git/branches/ is *still* used
 . Documentation: really deprecate .git/remotes/ and .git/branches/
 . git-parse-remote: fix highly misleading man page

 Stop reading from .git/remotes/ and .git/branches/, two old ways
 that we have been supporting to configure short-hands for fetching
 from remote repositories.

 Will discard.
 The procedure of removing an old and unused feature is correctly
 followed by this series, but it is far from clear that the feature
 this attempts to remove is unused or useless.


* ab/grep-preparatory-cleanup (2017-05-21) 30 commits
 - grep: assert that threading is enabled when calling grep_{lock,unlock}
 - grep: given --threads with NO_PTHREADS=YesPlease, warn
 - pack-objects: fix buggy warning about threads
 - pack-objects & index-pack: add test for --threads warning
 - test-lib: add a PTHREADS prerequisite
 - grep: move is_fixed() earlier to avoid forward declaration
 - grep: change internal *pcre* variable & function names to be *pcre1*
 - grep: change the internal PCRE macro names to be PCRE1
 - grep: factor test for \0 in grep patterns into a function
 - grep: remove redundant regflags assignments
 - grep: catch a missing enum in switch statement
 - perf: add a comparison test of log --grep regex engines
 - perf: add a comparison test of grep regex engines with -F
 - perf: add a comparison test of grep regex engines
 - perf: emit progress output when unpacking & building
 - perf: add a GIT_PERF_MAKE_COMMAND for when *_MAKE_OPTS won't do
 - grep: add tests to fix blind spots with \0 patterns
 - grep: prepare for testing binary regexes containing rx metacharacters
 - grep: add a test helper function for less verbose -f \0 tests
 - grep: add tests for grep pattern types being passed to submodules
 - grep: amend submodule recursion test for regex engine testing
 - grep: add tests for --threads=N and grep.threads
 - grep: change non-ASCII -i test to stop using --debug
 - grep: add a test for backreferences in PCRE patterns
 - grep: add a test asserting that --perl-regexp dies when !PCRE
 - log: make --regexp-ignore-case work with --perl-regexp
 - log: add exhaustive tests for pattern style options & config
 - test-lib: rename the LIBPCRE prerequisite to PCRE
 - grep & rev-list doc: stop promising libpcre for --perl-regexp
 - Makefile & configure: reword inaccurate comment about PCRE

 The internal implementation of "git grep" has seen some clean-up.


* jt/push-options-doc (2017-05-10) 2 commits
  (merged to 'next' on 2017-05-20 at ca7f344111)
 + receive-pack: verify push options in cert
 + docs: correct receive.advertisePushOptions default

 The receive-pack program now makes sure that the push certificate
 records the same set of push options used for pushing.

 Will merge to 'master'.


* dt/unpack-save-untracked-cache-extension (2017-05-20) 1 commit
 - unpack-trees: preserve index extensions

 When "git checkout", "git merge", etc. manipulates the in-core
 index, various pieces of information in the index extensions are
 discarded from the original state, as it is usually not the case
 that they are kept up-to-date and in-sync with the operation on the
 main index.  The untracked cache extension is copied across these
 operations now, which would speed up "git status" (as long as the
 cache is properly invalidated).

 Will merge to 'next'.


* sg/clone-refspec-from-command-line-config (2017-05-16) 4 commits
 - clone: use free_refspec() to free refspec list
 - remote: drop free_refspecs() function
 - Documentation/clone: document ignored configuration variables
 - clone: respect additional configured fetch refspecs during initial fetch

 "git clone -c var=val" is a way to set configuration variables in
 the resulting repository, but it is more useful to also make these
 variables take effect while the initial clone is happening,
 e.g. these configuration variables could be fetch refspecs.


* sb/checkout-recurse-submodules (2017-05-04) 3 commits
  (merged to 'next' on 2017-05-20 at f972b2069f)
 + submodule: properly recurse for read-tree and checkout
 + submodule: avoid auto-discovery in new working tree manipulator code
 + submodule_move_head: reuse child_process structure for futher commands

 "git checkout --recurse-submodules" did not quite work with a
 submodule that itself has submodules.

 Will merge to 'master'.


* ja/do-not-ask-needless-questions (2017-05-12) 3 commits
 - git-filter-branch: be more direct in an error message
 - read-tree -m: make error message for merging 0 trees less smart aleck
 - usability: don't ask questions if no reply is required

 Git sometimes gives an advice in a rhetorical question that does
 not require an answer, which can confuse new users and non native
 speakers.  Attempt to rephrase them.

 Will merge to 'next'.


* ab/doc-replace-gmane-links (2017-05-09) 2 commits
  (merged to 'next' on 2017-05-20 at 2c4f96560c)
 + doc: replace more gmane links
 + doc: replace a couple of broken gmane links

 The Web interface to gmane news archive is long gone, even though
 the articles are still accessible via NTTP.  Replace the links with
 ones to public-inbox.org.  Because their message identification is
 based on the actual message-id, it is likely that it will be easier
 to migrate away from it if/when necessary.

 Will merge to 'master'.


* ab/fix-poison-tests (2017-05-11) 3 commits
  (merged to 'next' on 2017-05-20 at 5b13ba86bd)
 + travis-ci: add job to run tests with GETTEXT_POISON
 + travis-ci: setup "prove cache" in "script" step
 + tests: fix tests broken under GETTEXT_POISON=YesPlease

 Update tests to pass under GETTEXT_POISON (a mechanism to ensure
 that output strings that should not be translated are not
 translated by mistake), and tell TravisCI to run them.

 Will merge to 'master'.


* bw/dir-c-stops-relying-on-the-index (2017-05-06) 14 commits
  (merged to 'next' on 2017-05-20 at 1f1b764ec8)
 + dir: convert fill_directory to take an index
 + dir: convert read_directory to take an index
 + dir: convert read_directory_recursive to take an index
 + dir: convert open_cached_dir to take an index
 + dir: convert is_excluded to take an index
 + dir: convert prep_exclude to take an index
 + dir: convert add_excludes to take an index
 + dir: convert is_excluded_from_list to take an index
 + dir: convert last_exclude_matching_from_list to take an index
 + dir: convert dir_add* to take an index
 + dir: convert get_dtype to take index
 + dir: convert directory_exists_in_index to take index
 + dir: convert read_skip_worktree_file_from_index to take an index
 + dir: stop using the index compatibility macros

 API update.

 Will merge to 'master'.


* jk/diff-submodule-diff-inline (2017-05-08) 1 commit
  (merged to 'next' on 2017-05-20 at da7eb2626a)
 + diff: recurse into nested submodules for inline diff

 "git diff --submodule=diff" now recurses into nested submodules.

 Will merge to 'master'.


* jk/disable-pack-reuse-when-broken (2017-05-09) 2 commits
  (merged to 'next' on 2017-05-20 at 684e921273)
 + t5310: fix "; do" style
 + pack-objects: disable pack reuse for object-selection options

 "pack-objects" can stream a slice of an existing packfile out when
 the pack bitmap can tell that the reachable objects are all needed
 in the output, without inspecting individual objects.  This
 strategy however would not work well when "--local" and other
 options are in use, and need to be disabled.

 Will merge to 'master'.


* js/eol-on-ourselves (2017-05-10) 6 commits
  (merged to 'next' on 2017-05-20 at 8023c277d2)
 + t4051: mark supporting files as requiring LF-only line endings
 + Fix the remaining tests that failed with core.autocrlf=true
 + t3901: move supporting files into t/t3901/
 + completion: mark bash script as LF-only
 + git-new-workdir: mark script as LF-only
 + Fix build with core.autocrlf=true

 Make sure our tests would pass when the sources are checked out
 with "platform native" line ending convention by default on
 Windows.  Some "text" files out tests use and the test scripts
 themselves that are meant to be run with /bin/sh, ought to be
 checked out with eol=LF even on Windows.

 Will merge to 'master'.


* nd/split-index-unshare (2017-05-08) 2 commits
  (merged to 'next' on 2017-05-20 at 9048cdc2ce)
 + p3400: add perf tests for rebasing many changes
 + split-index: add and use unshare_split_index()

 Plug some leaks and updates internal API used to implement the
 split index feature to make it easier to avoid such a leak in the
 future.

 Will merge to 'master'.


* rs/checkout-am-fix-unborn (2017-05-08) 2 commits
  (merged to 'next' on 2017-05-20 at d4f1ee3ed7)
 + am: check return value of resolve_refdup before using hash
 + checkout: check return value of resolve_refdup before using hash

 A few codepaths in "checkout" and "am" working on an unborn branch
 tried to access an uninitialized piece of memory.

 Will merge to 'master'.


* bw/submodule-with-bs-path (2017-05-01) 1 commit
  (merged to 'next' on 2017-05-20 at b740f784cb)
 + t7400: add !CYGWIN prerequisite to 'add with \\ in path'

 A hotfix to a topic that is already in v2.13.

 Will merge to 'master'.


* js/plug-leaks (2017-05-09) 26 commits
  (merged to 'next' on 2017-05-20 at fb136ea2dc)
 + checkout: fix memory leak
 + submodule_uses_worktrees(): plug memory leak
 + show_worktree(): plug memory leak
 + name-rev: avoid leaking memory in the `deref` case
 + remote: plug memory leak in match_explicit()
 + add_reflog_for_walk: avoid memory leak
 + shallow: avoid memory leak
 + line-log: avoid memory leak
 + receive-pack: plug memory leak in update()
 + fast-export: avoid leaking memory in handle_tag()
 + mktree: plug memory leaks reported by Coverity
 + pack-redundant: plug memory leak
 + setup_discovered_git_dir(): plug memory leak
 + setup_bare_git_dir(): help static analysis
 + split_commit_in_progress(): simplify & fix memory leak
 + checkout: fix memory leak
 + cat-file: fix memory leak
 + mailinfo & mailsplit: check for EOF while parsing
 + status: close file descriptor after reading git-rebase-todo
 + difftool: address a couple of resource/memory leaks
 + get_mail_commit_oid(): avoid resource leak
 + git_config_rename_section_in_file(): avoid resource leak
 + add_commit_patch_id(): avoid allocating memory unnecessarily
 + winansi: avoid buffer overrun
 + winansi: avoid use of uninitialized value
 + mingw: avoid memory leak when splitting PATH

 Fix memory leaks pointed out by Coverity (and people).

 Will merge to 'master'.


* jh/close-index-before-stat (2017-04-28) 1 commit
  (merged to 'next' on 2017-05-16 at 0c0372eb02)
 + read-cache: close index.lock in do_write_index

 Originally merged to 'next' on 2017-04-30

 The timestamp of the index file is now taken after the file is
 closed, to help Windows, on which a stale timestamp is reported by
 fstat() on a file that is opened for writing and data was written
 but not yet closed.

 Will cook in 'next'.


* ls/travis-relays-for-windows-ci (2017-05-04) 2 commits
  (merged to 'next' on 2017-05-20 at 47f34b78e2)
 + travis-ci: retry if Git for Windows CI returns HTTP error 502 or 503
 + travis-ci: handle Git for Windows CI status "failed" explicitly

 Will merge to 'master'.


* mb/diff-default-to-indent-heuristics (2017-05-09) 4 commits
 - add--interactive: drop diff.indentHeuristic handling
 - diff: enable indent heuristic by default
 - diff: have the diff-* builtins configure diff before initializing revisions
 - diff: make the indent heuristic part of diff's basic configuration

 Make the "indent" heuristics the default in "diff" and diff.indentHeuristics
 configuration variable an escape hatch for those who do no want it.

 Kicked out of next; it seems it is still getting review suggestions?


* tb/dedup-crlf-tests (2017-05-10) 1 commit
  (merged to 'next' on 2017-05-20 at 0a7ffff154)
 + t0027: tests are not expensive; remove t0025

 Will merge to 'master'.


* jc/repack-threads (2017-04-27) 1 commit
  (merged to 'next' on 2017-05-20 at c1fd54a2a4)
 + repack: accept --threads=<n> and pass it down to pack-objects

 "git repack" learned to accept the --threads=<n> option and pass it
 to pack-objects.

 Will merge to 'master'.


* nd/fopen-errors (2017-05-09) 23 commits
 - t1308: add a test case on open a config directory
 - config.c: handle error on failing to fopen()
 - xdiff-interface.c: report errno on failure to stat() or fopen()
 - wt-status.c: report error on failure to fopen()
 - server-info: report error on failure to fopen()
 - sequencer.c: report error on failure to fopen()
 - rerere.c: report correct errno
 - rerere.c: report error on failure to fopen()
 - remote.c: report error on failure to fopen()
 - commit.c: report error on failure to fopen() the graft file
 - log: fix memory leak in open_next_file()
 - log: report errno on failure to fopen() a file
 - blame: report error on open if graft_file is a directory
 - bisect: report on fopen() error
 - ident.c: use fopen_or_warn()
 - attr.c: use fopen_or_warn()
 - wrapper.c: add fopen_or_warn()
 - wrapper.c: add warn_on_fopen_errors()
 - config.mak.uname: set FREAD_READS_DIRECTORIES for Darwin, too
 - config.mak.uname: set FREAD_READS_DIRECTORIES for Linux and FreeBSD
 - clone: use xfopen() instead of fopen()
 - Use xfopen() in more places
 - git_fopen: fix a sparse 'not declared' warning

 We often try to open a file for reading whose existence is
 optional, and silently ignore errors from open/fopen; report such
 errors if they are not due to missing files.


* bc/object-id (2017-05-08) 53 commits
  (merged to 'next' on 2017-05-20 at e7372733fb)
 + object: convert parse_object* to take struct object_id
 + tree: convert parse_tree_indirect to struct object_id
 + sequencer: convert do_recursive_merge to struct object_id
 + diff-lib: convert do_diff_cache to struct object_id
 + builtin/ls-tree: convert to struct object_id
 + merge: convert checkout_fast_forward to struct object_id
 + sequencer: convert fast_forward_to to struct object_id
 + builtin/ls-files: convert overlay_tree_on_cache to object_id
 + builtin/read-tree: convert to struct object_id
 + sha1_name: convert internals of peel_onion to object_id
 + upload-pack: convert remaining parse_object callers to object_id
 + revision: convert remaining parse_object callers to object_id
 + revision: rename add_pending_sha1 to add_pending_oid
 + http-push: convert process_ls_object and descendants to object_id
 + refs/files-backend: convert many internals to struct object_id
 + refs: convert struct ref_update to use struct object_id
 + ref-filter: convert some static functions to struct object_id
 + Convert struct ref_array_item to struct object_id
 + Convert the verify_pack callback to struct object_id
 + Convert lookup_tag to struct object_id
 + log-tree: convert to struct object_id
 + Convert lookup_tree to struct object_id
 + builtin/reflog: convert tree_is_complete to take struct object_id
 + tree: convert read_tree_1 to use struct object_id internally
 + Convert lookup_blob to struct object_id
 + Convert remaining callers of lookup_blob to object_id
 + builtin/unpack-objects: convert to struct object_id
 + pack: convert struct pack_idx_entry to struct object_id
 + Convert lookup_commit* to struct object_id
 + Convert remaining callers of lookup_commit_reference* to object_id
 + builtin/tag: convert to struct object_id
 + sequencer: convert some functions to struct object_id
 + shallow: convert shallow registration functions to object_id
 + revision: convert prepare_show_merge to struct object_id
 + notes-utils: convert internals to struct object_id
 + http-push: convert some static functions to struct object_id
 + tag: convert parse_tag_buffer to struct object_id
 + builtin/verify-commit: convert to struct object_id
 + reflog_expire: convert to struct object_id
 + parse-options-cb: convert to struct object_id
 + notes-cache: convert to struct object_id
 + submodule: convert merge_submodule to use struct object_id
 + fast-import: convert to struct object_id
 + fast-import: convert internal structs to struct object_id
 + builtin/rev-parse: convert to struct object_id
 + builtin/blame: convert static function to struct object_id
 + branch: convert to struct object_id
 + bundle: convert to struct object_id
 + builtin/prune: convert to struct object_id
 + builtin/name-rev: convert to struct object_id
 + Convert struct cache_tree to use struct object_id
 + Clean up outstanding object_id transforms.
 + fetch-pack: convert to struct object_id

 Conversion from uchar[20] to struct object_id continues.

 Will merge to 'master'.


* jc/checkout-working-tree-only (2017-04-27) 1 commit
 - checkout: add --working-tree-only option

 "git checkout <tree-ish> <pathspec>" learned a variant that does
 not update the index when doing its thing.

 This was more of "the world could have been like this" illustration
 rather than a "let's make this change" proposal.  Unless people
 really want it, I am inclined to discard this topic.  Opinions?


* js/rebase-i-final (2017-05-02) 10 commits
 - rebase -i: rearrange fixup/squash lines using the rebase--helper
 - t3415: test fixup with wrapped oneline
 - rebase -i: skip unnecessary picks using the rebase--helper
 - rebase -i: check for missing commits in the rebase--helper
 - t3404: relax rebase.missingCommitsCheck tests
 - rebase -i: also expand/collapse the SHA-1s via the rebase--helper
 - rebase -i: do not invent onelines when expanding/collapsing SHA-1s
 - rebase -i: remove useless indentation
 - rebase -i: generate the script via rebase--helper
 - t3415: verify that an empty instructionFormat is handled as before

 The final batch to "git rebase -i" updates to move more code from
 the shell script to C.

 Needs review.


* bw/forking-and-threading (2017-05-15) 14 commits
 - usage.c: drop set_error_handle()
 - run-command: restrict PATH search to executable files
 - run-command: expose is_executable function
 - run-command: block signals between fork and execve
 - run-command: add note about forking and threading
 - run-command: handle dup2 and close errors in child
 - run-command: eliminate calls to error handling functions in child
 - run-command: don't die in child when duping /dev/null
 - run-command: prepare child environment before forking
 - string-list: add string_list_remove function
 - run-command: use the async-signal-safe execv instead of execvp
 - run-command: prepare command before forking
 - t0061: run_command executes scripts without a #! line
 - t5550: use write_script to generate post-update hook

 The "run-command" API implementation has been made more robust
 against dead-locking in a threaded environment.

 Will merge to 'next'.


* sb/reset-recurse-submodules (2017-04-23) 4 commits
  (merged to 'next' on 2017-05-20 at 8adafdf1be)
 + builtin/reset: add --recurse-submodules switch
 + submodule.c: submodule_move_head works with broken submodules
 + submodule.c: uninitialized submodules are ignored in recursive commands
 + entry.c: submodule recursing: respect force flag correctly

 "git reset" learned "--recurse-submodules" option.

 Will merge to 'master'.


* bp/sub-process-convert-filter (2017-05-15) 11 commits
 - convert: update subprocess_read_status() to not die on EOF
 - sub-process: move sub-process functions into separate files
 - convert: rename reusable sub-process functions
 - convert: update generic functions to only use generic data structures
 - convert: separate generic structures and variables from the filter specific ones
 - convert: split start_multi_file_filter() into two separate functions
 - pkt-line: annotate packet_writel with LAST_ARG_MUST_BE_NULL
 - convert: move packet_write_line() into pkt-line as packet_writel()
 - pkt-line: add packet_read_line_gently()
 - pkt-line: fix packet_read_line() to handle len < 0 errors
 - convert: remove erroneous tests for errno == EPIPE

 Code from "conversion using external process" codepath has been
 extracted to a separate sub-process.[ch] module.

 Will merge to 'next'.


* nd/prune-in-worktree (2017-04-24) 12 commits
 - rev-list: expose and document --single-worktree
 - revision.c: --reflog add HEAD reflog from all worktrees
 - files-backend: make reflog iterator go through per-worktree reflog
 - revision.c: --all adds HEAD from all worktrees
 - refs: remove dead for_each_*_submodule()
 - revision.c: use refs_for_each*() instead of for_each_*_submodule()
 - refs: add refs_head_ref()
 - refs: move submodule slash stripping code to get_submodule_ref_store
 - refs.c: refactor get_submodule_ref_store(), share common free block
 - revision.c: --indexed-objects add objects from all worktrees
 - revision.c: refactor add_index_objects_to_pending()
 - revision.h: new flag in struct rev_info wrt. worktree-related refs

 "git gc" and friends when multiple worktrees are used off of a
 single repository did not consider the index and per-worktree refs
 of other worktrees as the root for reachability traversal, making
 objects that are in use only in other worktrees to be subject to
 garbage collection.

 Expecting a reroll.
 Has been waiting for nd/worktree-kill-parse-ref to settle.
 cf. <CACsJy8ADCVBiLoPg_Tz0L6CMdh_eFmK4RYzfQ-PmUgBK7w9e=A@mail.gmail.com>


--------------------------------------------------
[Discard]

* ab/compat-regex-update (2017-05-12) 3 commits
 . DONTMERGE compat/regex: make it compile with -Werror=int-to-pointer-cast
 . compat/regex: update the gawk regex engine from upstream
 . compat/regex: add a README with a maintenance guide

 Update compat/regex we borrowed from gawk.  It seems that some
 customizations we made to the older one were dropped by mistake.

 Will discard.
 cf. <CACBZZX4UUwzRQmyH8joYaqHnuVTjVtGBHp+iZKcnAnwoM_ZJhg@mail.gmail.com>


