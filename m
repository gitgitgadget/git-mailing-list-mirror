From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2014, #02; Wed, 5)
Date: Wed, 05 Feb 2014 15:01:45 -0800
Message-ID: <xmqqa9e517vq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 06 00:02:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBBTl-0000M1-QM
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 00:02:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747AbaBEXB5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Feb 2014 18:01:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63843 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753721AbaBEXBy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Feb 2014 18:01:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 885CF67FC0;
	Wed,  5 Feb 2014 18:01:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=1FR4tkOYC0wp0v3pWazByO2h9
	1Y=; b=q0ITpsFJWYMyA/SKmncq0s6CffwnigRz/APfIc/mDHP3LHMP/9sSeh2pG
	ON+ypebYrtWP9m7Jgwb+Lwk9d1O4cvbHpXPnB+tKOhIrftM68f1Gw0CU19dt//pW
	sQkPtGw/rHMuUuECTiKIBUxyj/Jk1zTaINLOwOTbRPAFyExJMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=c5cWGb/B8pE9o17xGhQ
	LjrIsK2s+CAPo4y3aDz+2E+VaB3PR2iSakqMWge+WviAmsGN98DlQYVirYyGrE/L
	523aNlaIxMvZ357uUoEHjfegeReoDmUtzlfcYOYvwzMd+gps8C1vex0u7+1Qj9ec
	/ON//kMyPlAKhM8xGDX28eW8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA36D67FB9;
	Wed,  5 Feb 2014 18:01:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7C5167FB3;
	Wed,  5 Feb 2014 18:01:46 -0500 (EST)
X-master-at: 89ba81dc7643f5b126b15b15a8dcd3893d05ee47
X-next-at: ed4ee9f6d9847e9cfc1ea6faeea20ae612ccbcfb
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7CF2AA54-8EB9-11E3-9ED4-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241674>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

v1.9.0-rc3 is expected to happen this weekend or early next week.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* aj/ada-diff-word-pattern (2014-02-05) 1 commit
 - userdiff: update Ada patterns

 Will merge to 'next' and then to 'master'.


* jk/makefile (2014-02-05) 16 commits
 - FIXUP
 - move LESS/LV pager environment to Makefile
 - Makefile: teach scripts to include make variables
 - FIXUP
 - Makefile: auto-build C strings from make variables
 - Makefile: drop *_SQ variables
 - FIXUP
 - Makefile: add c-quote helper function
 - Makefile: introduce sq function for shell-quoting
 - Makefile: always create files via make-var
 - Makefile: store GIT-* sentinel files in MAKE/
 - Makefile: prefer printf to echo for GIT-*
 - Makefile: use tempfile/mv strategy for GIT-*
 - Makefile: introduce make-var helper function
 - Makefile: fix git-instaweb dependency on gitweb
 - Makefile: drop USE_GETTEXT_SCHEME from GIT-CFLAGS


* ks/tree-diff-walk (2014-02-05) 4 commits
 - revision: convert to using diff_tree_sha1()
 - line-log: convert to using diff_tree_sha1()
 - tree-diff: convert diff_root_tree_sha1() to just call diff_tree_sha1=
 with old=3DNULL
 - tree-diff: allow diff_tree_sha1 to accept NULL sha1

 Will merge to 'next'.


* nd/reset-intent-to-add (2014-02-05) 1 commit
 - reset: support "--mixed --intent-to-add" mode

 Will merge to 'next'.


* nd/tag-doc (2014-02-04) 1 commit
 - git-tag.txt: <commit> for --contains is optional

 Will merge to 'next' and then to 'master'.


* nd/test-rename-reset (2014-02-04) 1 commit
 - t7101, t7014: rename test files to indicate what that file is for

 Will merge to 'next'.


* tb/repack-fix-renames (2014-02-05) 1 commit
 - repack.c: rename a few variables

 Perhaps unneeded, as the longer-term plan is to drop the codeblock
 this change touches.

 Will discard.


* tr/remerge-diff (2014-02-05) 6 commits
 - log --remerge-diff: show what the conflict resolution changed
 - merge-recursive: allow storing conflict hunks in index
 - Fold all merge diff variants into an enum
 - combine-diff: do not pass revs->dense_combined_merges redundantly
 - log: add a merge base inspection option
 - pretty: refactor add_merge_info() into parts
 (this branch uses tr/merge-recursive-index-only.)

 "log -p" output learns a new way to let users inspect a merge
 commit by showing the differences between the automerged result
 with conflicts the person who recorded the merge would have seen
 and the final conflict resolution that was recorded in the merge.

 RFC.


* ow/manpages-typofix (2014-02-05) 1 commit
 - Documentation: fix typos in man pages

 Various typofixes, all looked correct.

 Will merge to 'next' and then to 'master'.

--------------------------------------------------
[Stalled]

* po/everyday-doc (2014-01-27) 1 commit
 - Make 'git help everyday' work

 This may make the said command to emit something, but the source is
 not meant to be formatted into a manual pages to begin with, and
 also its contents are a bit stale.  It may be a good first step in
 the right direction, but needs more work to at least get the
 mark-up right before public consumption.

 Will hold.


* jk/branch-at-publish-rebased (2014-01-17) 5 commits
 - t1507 (rev-parse-upstream): fix typo in test title
 - implement @{publish} shorthand
 - branch_get: provide per-branch pushremote pointers
 - branch_get: return early on error
 - sha1_name: refactor upstream_mark

 Give an easier access to the tracking branches from "other" side in
 a triangular workflow by introducing B@{publish} that works in a
 similar way to how B@{upstream} does.

 Will hold.


* rb/merge-prepare-commit-msg-hook (2014-01-10) 4 commits
 - merge: drop unused arg from abort_commit method signature
 - merge: make prepare_to_commit responsible for write_merge_state
 - t7505: ensure cleanup after hook blocks merge
 - t7505: add missing &&

 Expose more merge states (e.g. $GIT_DIR/MERGE_MODE) to hooks that
 run during "git merge".  The log message stresses too much on one
 hook, prepare-commit-msg, but it would equally apply to other hooks
 like post-merge, I think.

 Waiting for a reroll.


* jl/submodule-recursive-checkout (2013-12-26) 5 commits
 - Teach checkout to recursively checkout submodules
 - submodule: teach unpack_trees() to update submodules
 - submodule: teach unpack_trees() to repopulate submodules
 - submodule: teach unpack_trees() to remove submodule contents
 - submodule: prepare for recursive checkout of submodules

 Expecting a reroll.


* jc/graph-post-root-gap (2013-12-30) 3 commits
 - WIP: document what we want at the end
 - graph: remove unused code a bit
 - graph: stuff the current commit into graph->columns[]

 This was primarily a RFH ($gmane/239580).


* fc/transport-helper-fixes (2013-12-09) 6 commits
 - remote-bzr: support the new 'force' option
 - test-hg.sh: tests are now expected to pass
 - transport-helper: check for 'forced update' message
 - transport-helper: add 'force' to 'export' helpers
 - transport-helper: don't update refs in dry-run
 - transport-helper: mismerge fix

 Updates transport-helper, fast-import and fast-export to allow the
 ref mapping and ref deletion in a way similar to the natively
 supported transports.

 Reported to break t5541.
 Will hold.


* fc/completion (2013-12-09) 1 commit
 - completion: fix completion of certain aliases

 SZEDER G=C3=A1bor noticed that this breaks "git -c var=3Dval alias" an=
d
 also suggested a better description of the change.

 Will hold.


* mo/subtree-split-updates (2013-12-10) 3 commits
 - subtree: add --edit option
 - subtree: allow --squash and --message with push
 - subtree: support split --rejoin --squash

 Comments?


* hv/submodule-ignore-fix (2013-12-06) 4 commits
 - disable complete ignorance of submodules for index <-> HEAD diff
 - always show committed submodules in summary after commit
 - teach add -f option for ignored submodules
 - fix 'git add' to skip submodules configured as ignored

 Teach "git add" to be consistent with "git status" when changes to
 submodules are set to be ignored, to avoid surprises after checking
 with "git status" to see there isn't any change to be further added
 and then see that "git add ." adds changes to them.

 I think a reroll is coming, so this may need to be replaced, but I
 needed some practice with heavy conflict resolution.  It conflicts
 with two changes to "git add" that have been scheduled for Git 2.0
 quite badly, and I think I got the resolution right this time.

 Waiting for a reroll.


* kb/fast-hashmap (2014-01-03) 19 commits
 - hashmap.h: make sure map entries are tightly packed
  (merged to 'next' on 2014-01-03 at dc85001)
 + name-hash: retire unused index_name_exists()
 + hashmap.h: Use 'unsigned int' for hash-codes everywhere
  (merged to 'next' on 2013-12-16 at bff99b1)
 + Drop unnecessary #includes from test-hashmap
 + Add test-hashmap to .gitignore
  (merged to 'next' on 2013-12-06 at f90be3d)
 + read-cache.c: fix memory leaks caused by removed cache entries
 + builtin/update-index.c: cleanup update_one
 + fix 'git update-index --verbose --again' output
 + remove old hash.[ch] implementation
 + name-hash.c: remove cache entries instead of marking them CE_UNHASHE=
D
 + name-hash.c: use new hash map implementation for cache entries
 + name-hash.c: remove unreferenced directory entries
 + name-hash.c: use new hash map implementation for directories
 + diffcore-rename.c: use new hash map implementation
 + diffcore-rename.c: simplify finding exact renames
 + diffcore-rename.c: move code around to prepare for the next patch
 + buitin/describe.c: use new hash map implementation
 + add a hashtable implementation that supports O(1) removal
 + submodule: don't access the .gitmodules cache entry after removing i=
t

 Improvements to our hash table to get it to meet the needs of the
 msysgit fscache project, with some nice performance improvements.

 The tip one does not seem to have reached concensus (yet).

 Will hold.


* jc/create-directories-microopt (2013-11-11) 1 commit
 - checkout: most of the time we have good leading directories

 Of unknown value until tested on non-Linux platforms (especially
 Windows).

 Will hold.


* jt/commit-fixes-footer (2013-10-30) 1 commit
 - commit: Add -f, --fixes <commit> option to add Fixes: line

 There is an ongoing discussion around this topic; in general I am
 fairly negative on a new feature that is too narrow and prefer a
 more generic solution that can be tailored for specific needs, as
 many people stated in the thread.

 cc/interpret-trailers could be such a generic solution (although
 there don't seem to be much concensus yet).

 Will discard.


* np/pack-v4 (2013-09-18) 90 commits
 . packv4-parse.c: add tree offset caching
 . t1050: replace one instance of show-index with verify-pack
 . index-pack, pack-objects: allow creating .idx v2 with .pack v4
 . unpack-objects: decode v4 trees
 . unpack-objects: allow to save processed bytes to a buffer
 - ...

 Nico and Duy advancing the eternal vaporware pack-v4.  This is here
 primarily for wider distribution of the preview edition.

 Temporarily ejected from 'pu', to try out jk/pack-bitmap, which
 this topic conflicts with.


* mf/graph-show-root (2013-10-25) 1 commit
 . graph.c: mark root commit differently

 In a repository with multiple-roots, "log --graph", especially with
 "--oneline", does not give the reader enough visual cue to see
 where one line of history ended and a separate history began.

 This is the version that marks the roots 'x' when they would have
 been marked as '*'; Keshav Kini suggested an alternative of giving
 an extra blank line after every root, which I tend to think is a
 better approach to the problem.

 Will discard.


* tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
 - perf-lib: add test_perf_cleanup target
 - perf-lib: split starting the test from the execution

 Add test_perf_cleanup shell function to the perf suite, that allows
 the script writers to define a test with a clean-up action.

 Will hold.


* yt/shortened-rename (2013-10-18) 2 commits
 - SQUASH??? style fixes and s/omit/shorten/ where appropriate
 - diff.c: keep arrow(=3D>) on show_stats()'s shortened filename part t=
o make rename visible

 Attempts to give more weight on the fact that a filepair represents
 a rename than showing substring of the actual path when diffstat
 lines are not wide enough.

 I am not sure if that is solving a right problem, though.


* rv/send-email-cache-generated-mid (2013-08-21) 2 commits
 - git-send-email: Cache generated message-ids, use them when prompting
 - git-send-email: add optional 'choices' parameter to the ask sub

 Will discard.


* rj/read-default-config-in-show-ref-pack-refs (2013-06-17) 3 commits
 - ### DONTMERGE: needs better explanation on what config they need
 - pack-refs.c: Add missing call to git_config()
 - show-ref.c: Add missing call to git_config()

 The changes themselves are probably good, but it is unclear what
 basic setting needs to be read for which exact operation.

 Waiting for clarification.
 $gmane/228294


* jc/format-patch (2013-04-22) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.


* jk/gitweb-utf8 (2013-04-08) 4 commits
 - gitweb: Fix broken blob action parameters on blob/commitdiff pages
 - gitweb: Don't append ';js=3D(0|1)' to external links
 - gitweb: Make feed title valid utf8
 - gitweb: Fix utf8 encoding for blob_plain, blobdiff_plain, commitdiff=
_plain, and patch

 Various fixes to gitweb.

 Drew Northup volunteered to take a look into this.
 $gmane/226216


* jc/show-branch (2013-06-07) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary widt=
h
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit before sending it ou=
t.

--------------------------------------------------
[Cooking]

* bs/stdio-undef-before-redef (2014-01-31) 1 commit
  (merged to 'next' on 2014-01-31 at 9874918)
 + git-compat-util.h: #undef (v)snprintf before #define them

 When we replace broken macros from stdio.h in git-compat-util.h,
 #undef them to avoid re-definition warnings from the C
 preprocessor.

 Will cook in 'next'.


* ep/varscope (2014-01-31) 7 commits
  (merged to 'next' on 2014-01-31 at d198f5d)
 + builtin/gc.c: reduce scope of variables
 + builtin/fetch.c: reduce scope of variable
 + builtin/commit.c: reduce scope of variables
 + builtin/clean.c: reduce scope of variable
 + builtin/blame.c: reduce scope of variables
 + builtin/apply.c: reduce scope of variables
 + bisect.c: reduce scope of variable

 Shrink lifetime of variables by moving their definitions to an
 inner scope where appropriate.

 Will cook in 'next'.


* mw/symlinks (2014-02-04) 6 commits
 - setup: don't dereference in-tree symlinks for absolute paths
 - setup: add abspath_part_inside_repo() function
 - t0060: add tests for prefix_path when path begins with work tree
 - t0060: add test for prefix_path when path =3D=3D work tree
 - t0060: add test for prefix_path on symlinks via absolute paths
 - t3004: add test for ls-files on symlinks via absolute paths

 All subcommands that take pathspecs mishandled an in-tree symbolic
 link when given it as a full path from the root (which arguably is
 a sick way to use pathspecs).  "git ls-files -s $(pwd)/RelNotes" in
 our tree is an easy reproduction recipe.

 We may want to add tests to illustrate symptoms that are visible to
 the end user, but the updated code looked reasonable.

 Will merge to 'next'.


* ks/diff-c-with-diff-order-more (2014-02-05) 5 commits
 - combine-diff: move changed-paths scanning logic into its own functio=
n
 - combine-diff: move show_log_first logic/action out of paths scanning
 - tree-diff: no need to pass match to skip_uninteresting()
 - tree-diff: no need to manually verify that there is no mode change f=
or a path
 - tests: add checking that combine-diff emits only correct paths
 (this branch uses ks/diff-c-with-diff-order.)

 By avoiding running full two-way diff between the resulting
 revision and each of its N parents, combine-diff can be sped up
 significantly.

 Not quite sure if we want another custom tree walker for it, or it
 should be written by using existing two-way diff with the result of
 earlier intersect_path() as pathspec.


* bc/gpg-sign-everywhere (2014-02-03) 9 commits
 - pull: add the --gpg-sign option.
 - rebase: add the --gpg-sign option
 - rebase: parse options in stuck-long mode
 - rebase: don't try to match -M option
 - rebase: remove useless arguments check
 - am: add the --gpg-sign option
 - am: parse options in stuck-long mode
 - git-sh-setup.sh: add variable to use the stuck-long mode
 - cherry-pick, revert: add the --gpg-sign option

 Teach "--gpg-sign" option to many commands that create commits.

 Changes to some scripted Porcelains use unsafe variable
 substitutions and still need to be tightened.

 Waiting for a reroll.


* ds/rev-parse-required-args (2014-01-28) 1 commit
  (merged to 'next' on 2014-01-31 at 73b7514)
 + rev-parse: check i before using argv[i] against argc

 "git rev-parse --default" without the required option argument did
 not diagnose it as an error.

 Will cook in 'next'.


* jk/config-path-include-fix (2014-01-28) 2 commits
  (merged to 'next' on 2014-01-31 at 8550a9e)
 + handle_path_include: don't look at NULL value
 + expand_user_path: do not look at NULL path

 include.path variable (or any variable that expects a path that can
 use ~username expansion) in the configuration file is not a
 boolean, but the code failed to check it.

 Will cook in 'next'.


* jk/repack-honor-pack-keep (2014-01-28) 1 commit
 - repack: add `repack.honorpackkeep` config var
 (this branch uses jk/pack-bitmap.)

 Optionally allow "git repack" to include objects that exist in kept
 packs in newly created packfiles.

 Waiting for response to review comments.


* nd/submodule-pathspec-ending-with-slash (2014-01-27) 8 commits
  (merged to 'next' on 2014-01-31 at cfddaa5)
 + clean: use cache_name_is_other()
 + clean: replace match_pathspec() with dir_path_match()
 + Pass directory indicator to match_pathspec_item()
 + match_pathspec: match pathspec "foo/" against directory "foo"
 + dir.c: prepare match_pathspec_item for taking more flags
 + Rename match_pathspec_depth() to match_pathspec()
 + Convert some match_pathspec_depth() to dir_path_match()
 + Convert some match_pathspec_depth() to ce_path_match()

 Allow "git cmd path/", when the 'path' is where a submodule is
 bound to the top-level working tree, to match 'path', despite the
 extra and unnecessary trailing slash.

 Will cook in 'next'.


* lt/request-pull (2014-01-31) 4 commits
 - pull-request: test updates
 - request-pull: pick up tag message as before
 - Make request-pull able to take a refspec of form local:remote
 - Make 'git request-pull' more strict about matching

 Waiting for the updates to settle.


* bk/refresh-missing-ok-in-merge-recursive (2014-01-27) 4 commits
  (merged to 'next' on 2014-01-29 at 614c158)
 + merge-recursive.c: Tolerate missing files while refreshing index
 + read-cache.c: Extend make_cache_entry refresh flag with options
 + read-cache.c: Refactor --ignore-missing implementation
 + t3030-merge-recursive: Test known breakage with empty work tree

 Allows "merge-recursive" to work in an empty (temporary) working
 tree again when there are renames involved, correcting an old
 regression in 1.7.7 era.

 Will cook in 'next'.


* nd/diff-quiet-stat-dirty (2014-01-27) 2 commits
  (merged to 'next' on 2014-01-31 at 8b6e35d)
 + diff: do not quit early on stat-dirty files
 + Move diffcore_skip_stat_unmatch core logic out for reuse later

 "git diff --quiet -- pathspec1 pathspec2" sometimes did not return
 correct status value.

 Will cook in 'next'.


* cc/interpret-trailers (2014-01-27) 17 commits
 - Documentation: add documentation for 'git interpret-trailers'
 - trailer: add tests for commands using env variables
 - trailer: set author and committer env variables
 - trailer: add tests for trailer command
 - trailer: execute command from 'trailer.<name>.command'
 - strbuf: add strbuf_replace()
 - trailer: add new_trailer_item() function
 - trailer: if no input file is passed, read from stdin
 - trailer: add tests for "git interpret-trailers"
 - trailer: add interpret-trailers command
 - trailer: put all the processing together and print
 - trailer: parse trailers from input file
 - strbuf: add strbuf_isspace()
 - trailer: process command line trailer arguments
 - trailer: read and process config information
 - trailer: process trailers from file and arguments
 - Add data structures and basic functions for commit trailers

 Waiting for a reroll.


* dk/blame-janitorial (2014-01-22) 2 commits
  (merged to 'next' on 2014-01-29 at 0b7ea97)
 + Eliminate same_suspect function in builtin/blame.c
 + builtin/blame.c: struct blame_entry does not need a prev link

 Code clean-up.

 Will cook in 'next'.


* ks/diff-c-with-diff-order (2014-02-03) 5 commits
  (merged to 'next' on 2014-02-04 at 24a8b2e)
 + combine-diff: simplify intersect_paths() further
 + combine-diff: combine_diff_path.len is not needed anymore
 + combine-diff: optimize combine_diff_path sets intersection
 + diff test: add tests for combine-diff with orderfile
 + diffcore-order: export generic ordering interface
 (this branch is used by ks/diff-c-with-diff-order-more.)

 Teach combine-diff to honour the path-output-order imposed by
 diffcore-order.

 Will cook in 'next'.


* bl/blame-full-history (2014-01-14) 1 commit
 - blame: new option --prefer-first to better handle merged cherry-pick=
s

 By disabling the tree-same optimization (which is consistent with
 the default behaviour of "git log"-family of commands), make "git
 blame" sometimes produce different result from the original code.

 Because the "git blame" output can give result for each line from
 only one lineage of the history, however, this can be only useful
 when you are lucky---unlike "--full-history" of "git log"-family,
 where we can show commits from both lineages of histories with an
 equal weight.  See $gmane/240392 for more detailed discussion.

 Will discard.


* da/pull-ff-configuration (2014-01-15) 2 commits
  (merged to 'next' on 2014-01-22 at 2686b09)
 + pull: add --ff-only to the help text
 + pull: add pull.ff configuration

 "git pull" learned to pay attention to pull.ff configuration
 variable.

 Will cook in 'next'.


* wk/submodule-on-branch (2014-01-27) 4 commits
 - Documentation: Describe 'submodule update --remote' use case
 - submodule: Explicit local branch creation in module_clone
 - submodule: Document module_clone arguments in comments
 - submodule: Make 'checkout' update_module explicit

 Makes sure 'submodule update' modes that do not detach HEADs can
 be used more pleasantly by checking out a concrete branch when
 cloning them to prime the well.

 Will merge to 'next'.


* jk/warn-on-object-refname-ambiguity (2014-01-09) 6 commits
 - get_sha1: drop object/refname ambiguity flag
 - get_sha1: speed up ambiguous 40-hex test
 - FIXUP: teach DO_FOR_EACH_NO_RECURSE to prime_ref_dir()
 - refs: teach for_each_ref a flag to avoid recursion
 - cat-file: fix a minor memory leak in batch_objects
 - cat-file: refactor error handling of batch_objects

 Expecting a reroll.


* ap/remote-hg-skip-null-bookmarks (2014-01-02) 1 commit
 - remote-hg: do not fail on invalid bookmarks

 Reported to break tests ($gmane/240005)
 Expecting a reroll.


* jk/pack-bitmap (2014-01-23) 25 commits
  (merged to 'next' on 2014-01-27 at 0b1dcb5)
 + ewah: support platforms that require aligned reads
 + read-cache: use get_be32 instead of hand-rolled ntoh_l
 + block-sha1: factor out get_be and put_be wrappers
  (merged to 'next' on 2014-01-16 at ddac2d2)
 + do not discard revindex when re-preparing packfiles
  (merged to 'next' on 2014-01-10 at bdbe0a4)
 + pack-bitmap: implement optional name_hash cache
 + t/perf: add tests for pack bitmaps
 + t: add basic bitmap functionality tests
 + count-objects: recognize .bitmap in garbage-checking
 + repack: consider bitmaps when performing repacks
 + repack: handle optional files created by pack-objects
 + repack: turn exts array into array-of-struct
 + repack: stop using magic number for ARRAY_SIZE(exts)
 + pack-objects: implement bitmap writing
 + rev-list: add bitmap mode to speed up object lists
 + pack-objects: use bitmaps when packing objects
 + pack-objects: split add_object_entry
 + pack-bitmap: add support for bitmap indexes
 + documentation: add documentation for the bitmap format
 + ewah: compressed bitmap implementation
 + compat: add endianness helpers
 + sha1_file: export `git_open_noatime`
 + revision: allow setting custom limiter function
 + pack-objects: factor out name_hash
 + pack-objects: refactor the packing list
 + revindex: export new APIs
 (this branch is used by jk/repack-honor-pack-keep.)

 Borrows the bitmap index into packfiles from JGit to speed up
 enumeration of objects involved in a commit range without having to
 fully traverse the history.

 Will cook in 'next'.


* nv/commit-gpgsign-config (2013-12-17) 3 commits
  (merged to 'next' on 2014-01-03 at 9780cbb)
 + test the commit.gpgsign config option
 + commit-tree: add and document --no-gpg-sign
 + Add the commit.gpgsign option to sign all commits

 Introduce commit.gpgsign configuration variable to force every
 commit to be GPG signed.  The variable cannot be overriden from the
 command line of some of the commands that create commits except for
 "git commit" and "git commit-tree", but I am not convinced that it
 is a good idea to sprinkle support for --no-gpg-sign everywhere.

 Will cook in 'next'.


* cc/starts-n-ends-with-endgame (2013-12-05) 1 commit
  (merged to 'next' on 2014-01-07 at 4cdf8d0)
 + strbuf: remove prefixcmp() and suffixcmp()

 Endgame for the cc/starts-n-ends-with topic; this needs to be
 evil-merged with other topics that introduce new uses of
 prefix/suffix-cmp functions.

 Will cook in 'next' until Git 2.0.


* gj/push-more-verbose-advice (2013-11-13) 1 commit
  (merged to 'next' on 2013-12-06 at 574b18a)
 + push: switch default from "matching" to "simple"

 Originally merged to 'next' on 2013-11-21

 Explain 'simple' and 'matching' in "git push" advice message; the
 topmost patch is a rebase of jc/push-2.0-default-to-simple on top
 of it.

 Will cook in 'next' until Git 2.0.


* tr/merge-recursive-index-only (2014-02-05) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: internal flag to avoid touching the worktree
 - merge-recursive: remove dead conditional in update_stages()
 (this branch is used by tr/remerge-diff.)

 Will hold.


* jn/add-2.0-u-A-sans-pathspec (2013-04-26) 1 commit
  (merged to 'next' on 2013-12-06 at ead2ec8)
 + git add: -u/-A now affects the entire working tree

 Will cook in 'next' until Git 2.0.


* jc/core-checkstat-2.0 (2013-05-06) 1 commit
  (merged to 'next' on 2013-12-06 at ae18007)
 + core.statinfo: remove as promised in Git 2.0

 Will cook in 'next' until Git 2.0.


* jc/push-2.0-default-to-simple (2013-06-18) 1 commit
  (merged to 'next' on 2013-12-06 at 6fad61c)
 + push: switch default from "matching" to "simple"

 Will cook in 'next' until Git 2.0.


* jc/add-2.0-ignore-removal (2013-04-22) 1 commit
  (merged to 'next' on 2013-12-06 at fbaa75a)
 + git add <pathspec>... defaults to "-A"

 Updated endgame for "git add <pathspec>" that defaults to "--all"
 aka "--no-ignore-removal".

 Will cook in 'next' until Git 2.0.


* jc/hold-diff-remove-q-synonym-for-no-deletion (2013-07-19) 1 commit
  (merged to 'next' on 2013-12-06 at 083d67c)
 + diff: remove "diff-files -q" in a version of Git in a distant future

 Will cook in 'next' until a distant future.

--------------------------------------------------
[Discarded]

* jk/branch-at-publish (2014-01-23) 6 commits
 . t1507 (rev-parse-upstream): fix typo in test title
 . implement @{publish} shorthand
 . branch_get: provide per-branch pushremote pointers
 . branch_get: return early on error
 . interpret_branch_name: factor out upstream handling
 . sha1_name: refactor upstream_mark

 Rebased to be jk/branch-at-publish-rebased to share the same change
 with the jk/interpret-branch-name-fix topic.


* jn/git-gui-chmod+x (2013-11-25) 1 commit
 . git-gui: chmod +x po2msg, windows/git-gui.sh

 Now in 'master' from the upstream git-gui repository.


* jn/gitk-chmod+x (2013-11-25) 1 commit
 . gitk: chmod +x po2msg

 Now in 'master' from the upstream gitk repository.


* jc/parse-options-humint (2014-01-22) 1 commit
 . parse-options: refactor human-friendly-integer parser out of pack-ob=
jects

 Teach parse-options machinery to optionally parse numbers with a
 unit suffix, e.g. 8g, 4m, 128k.


* jk/color-for-more-pagers (2014-01-17) 4 commits
 . pager: disable colors for some known-bad configurations
 . DONOTMERGE: needs matching change to git-sh-setup
 . setup_pager: set MORE=3DR
 . setup_pager: refactor LESS/LV environment setting

 'more' implementation of BSD wants to be told with MORE=3DR
 environment before it shows colored output, while 'more' on some
 other platforms will die when seeing MORE=3DR environment.  But the
 consensus is that trying to be too intimately knowledgeable about
 quirks of various pager implementations on different platforms is a
 losing proposition.

 Will be superseded by jk/makefile series when it matures.
