From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Nov 2011, #03; Sun, 13)
Date: Sun, 13 Nov 2011 20:01:50 -0800
Message-ID: <7vmxbzl5ch.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 05:02:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPnk8-0006EI-FU
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 05:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477Ab1KNEBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Nov 2011 23:01:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55349 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432Ab1KNEBx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2011 23:01:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB2BA59F0;
	Sun, 13 Nov 2011 23:01:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=x
	m0qKncOIVTjsYxhemx8J7TMYW4=; b=SfwYAuGuXS3lyO/vc/i/lw5h3rAl4v1Fa
	nH24skp2uftdSkp0HRZXKrvp68fyJ1BNPhsI7O7JA201e5fsb02vJHabnP06T0Vd
	kmw0VfuW+fYzy2022MKtHIYwEBcbkU2seDqo5Uka/3PWrY0ryiz7NBQoEKN8Kiz6
	I5KSfr5qT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=KF+
	ZLTs8JsOMXrk+K1fchfduwB5KcYYCF8t8LlS1trPIpqNRJaUlT/rH8eKgAGW+TdA
	Z4Cf3SzLzQvHQt6jJXEEfn50LB4fqgEDbUSY+W9T3Ij6x/4onJl68mmJR1Aa9mHi
	Ce/7GlpLvq6hM7yF2o8/r567jcZGi2AMUfY4QZlA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C26F159EF;
	Sun, 13 Nov 2011 23:01:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7C5959EE; Sun, 13 Nov 2011
 23:01:51 -0500 (EST)
X-master-at: bc1bbe0c19a6ff39522b4fa3259f34150e308e1f
X-next-at: 72bb2d5b6710462dbf2e8d479ac63e2a74695332
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 62196630-0E75-11E1-BE6C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185362>

What's cooking in git.git (Nov 2011, #03; Sun, 13)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

Here are the repositories that have my integration branches:

With maint, master, next, pu, todo:

        git://git.kernel.org/pub/scm/git/git.git
        git://repo.or.cz/alt-git.git
        https://code.google.com/p/git-core/
        https://github.com/git/git

With only maint and master:

        git://git.sourceforge.jp/gitroot/git-core/git.git
        git://git-core.git.sourceforge.net/gitroot/git-core/git-core

With all the topics and integration branches:

        https://github.com/gitster/git

The preformatted documentation in HTML and man format are found in:

        git://git.kernel.org/pub/scm/git/git-{htmldocs,manpages}.git/
        git://repo.or.cz/git-{htmldocs,manpages}.git/
        https://code.google.com/p/git-{htmldocs,manpages}.git/
        https://github.com/gitster/git-{htmldocs,manpages}.git/

--------------------------------------------------
[New Topics]

* jc/commit-tree-extra (2011-11-12) 2 commits
 - commit-tree: teach -C <extra-commit>
 - commit-tree: teach -x <extra>
 (this branch uses jc/pull-signed-tag; is tangled with jc/signed-commit.)

* nd/resolve-ref (2011-11-13) 2 commits
 - Copy resolve_ref() return value for longer use
 - Convert many resolve_ref() calls to read_ref*() and ref_exists()

--------------------------------------------------
[Graduated to "master"]

* ab/i18n-test-fix (2011-11-05) 2 commits
  (merged to 'next' on 2011-11-06 at f1de9a6)
 + t/t7508-status.sh: use test_i18ncmp
 + t/t6030-bisect-porcelain.sh: use test_i18ngrep

* fc/remote-seturl-usage-fix (2011-11-06) 1 commit
  (merged to 'next' on 2011-11-06 at 6c8328c)
 + remote: fix remote set-url usage

* jc/remote-setbranches-usage-fix (2011-11-06) 1 commit
  (merged to 'next' on 2011-11-06 at 017606d)
 + remote: fix set-branches usage

* pw/p4-appledouble-fix (2011-11-05) 1 commit
  (merged to 'next' on 2011-11-06 at 2ec0af3)
 + git-p4: ignore apple filetype

Regression fix for the upcoming release.

* sn/http-auth-with-netrc-fix (2011-11-04) 1 commit
  (merged to 'next' on 2011-11-06 at 60b7f96)
 + http: don't always prompt for password

Regression fix for the upcoming release.

--------------------------------------------------
[Stalled]

* hv/submodule-merge-search (2011-10-13) 4 commits
 - submodule.c: make two functions static
 - allow multiple calls to submodule merge search for the same path
 - push: Don't push a repository with unpushed submodules
 - push: teach --recurse-submodules the on-demand option

What the topic aims to achieve may make sense, but the implementation
looked somewhat suboptimal.

* sr/transport-helper-fix-rfc (2011-07-19) 2 commits
 - t5800: point out that deleting branches does not work
 - t5800: document inability to push new branch with old content

See comments on sr/fix-fast-export-tips topic.

* sr/fix-fast-export-tips (2011-11-05) 3 commits
 - fast-export: output reset command for commandline revs
 - fast-export: do not refer to non-existing marks
 - t9350: point out that refs are not updated correctly

The bottom commit from the stalled sr/transport-helper-fix-rfc topic is
fixed with this. It may make sense to drop the other topic and include
that commit in this series.

The command line parser is still too lax and accepts malformed input, but
this is a step in the right direction and tightening the command line now
should be doable without a low level surgery that touches codepaths that
are unrelated to the command line processing like the previous attempt
used to do.

* jc/lookup-object-hash (2011-08-11) 6 commits
 - object hash: replace linear probing with 4-way cuckoo hashing
 - object hash: we know the table size is a power of two
 - object hash: next_size() helper for readability
 - pack-objects --count-only
 - object.c: remove duplicated code for object hashing
 - object.c: code movement for readability

I do not think there is anything fundamentally wrong with this series, but
the risk of breakage far outweighs observed performance gain in one
particular workload.

* jc/verbose-checkout (2011-10-16) 2 commits
 - checkout -v: give full status output after switching branches
 - checkout: move the local changes report to the end

This is just to leave a record that the reason why we do not do this not
because we are incapable of coding this, but because it is not a good idea
to do this. I suspect people who are new to git that might think they need
it would soon realize the don't.

Will keep in 'pu' as a showcase for a while and then will drop.

* eh/grep-scale-to-cpunum (2011-11-05) 1 commit
 - grep: detect number of CPUs for thread spawning

Kills I/O parallelism and needs to be improved or discarded.

* vr/msvc (2011-10-31) 3 commits
 - MSVC: Remove unneeded header stubs
 - Compile fix for MSVC: Include <io.h>
 - Compile fix for MSVC: Do not include sys/resources.h

It seems this needs to be rehashed with msysgit folks.

* na/strtoimax (2011-11-05) 3 commits
 - Support sizes >=2G in various config options accepting 'g' sizes.
 - Compatibility: declare strtoimax() under NO_STRTOUMAX
 - Add strtoimax() compatibility function.

It seems this needs to be rehashed with msysgit folks.

--------------------------------------------------
[Cooking]

* jc/signed-commit (2011-11-12) 4 commits
 - pretty: %G[?GS] placeholders
 - test "commit -S" and "log --show-signature"
 - log: --show-signature
 - commit: teach --gpg-sign option
 (this branch uses jc/pull-signed-tag; is tangled with jc/commit-tree-extra.)

Rebased on top of jc/pull-signed-tag topic, after reverting the old one
out of 'next'.

* jc/pull-signed-tag (2011-11-12) 15 commits
 - commit-tree: teach -m/-F options to read logs from elsewhere
 - commit-tree: update the command line parsing
 - commit: teach --amend to carry forward extra headers
 - merge: force edit and no-ff mode when merging a tag object
 - commit: copy merged signed tags to headers of merge commit
 - merge: record tag objects without peeling in MERGE_HEAD
 - merge: make usage of commit->util more extensible
 - fmt-merge-msg: Add contents of merged tag in the merge message
 - fmt-merge-msg: package options into a structure
 - fmt-merge-msg: avoid early returns
 - refs DWIMmery: use the same rule for both "git fetch" and others
 - fetch: allow "git fetch $there v1.0" to fetch a tag
 - merge: notice local merging of tags and keep it unwrapped
 - fetch: do not store peeled tag object names in FETCH_HEAD
 - Split GPG interface into its own helper library
 (this branch is used by jc/commit-tree-extra and jc/signed-commit.)

Further updated to allow "commit --amend" to retain the mergetag
headers. I think this is ready for the cycle after upcoming 1.7.8.

* ab/clang-lints (2011-11-06) 2 commits
  (merged to 'next' on 2011-11-13 at a573aec)
 + cast variable in call to free() in builtin/diff.c and submodule.c
 + apply: get rid of useless x < 0 comparison on a size_t type

Will keep in 'next' during this cycle.

* ab/pull-rebase-config (2011-11-07) 1 commit
  (merged to 'next' on 2011-11-13 at 72bb2d5)
 + pull: introduce a pull.rebase option to enable --rebase

Will keep in 'next' during this cycle.

* nd/fsck-progress (2011-11-06) 4 commits
  (merged to 'next' on 2011-11-13 at 8831811)
 + fsck: print progress
 + fsck: avoid reading every object twice
 + verify_packfile(): check as many object as possible in a pack
 + fsck: return error code when verify_pack() goes wrong

Will keep in 'next' during this cycle.

* nd/prune-progress (2011-11-07) 3 commits
  (merged to 'next' on 2011-11-13 at c5722ac)
 + reachable: per-object progress
 + prune: handle --progress/no-progress
 + prune: show progress while marking reachable objects

Will keep in 'next' during this cycle.

* jc/stream-to-pack (2011-11-03) 4 commits
 - Bulk check-in
 - finish_tmp_packfile(): a helper function
 - create_tmp_packfile(): a helper function
 - write_pack_header(): a helper function

Teaches "git add" to send large-ish blob data straight to a packfile.
This is a continuation to the "large file support" topic. I think this
codepath to move data from worktree to repository needs to become aware of
streaming, just like the checkout codepath that goes the other way, which
was done in the previous "large file support" topic in the 1.7.7 cycle.

* jn/gitweb-side-by-side-diff (2011-10-31) 8 commits
 - gitweb: Add navigation to select side-by-side diff
 - gitweb: Use href(-replay=>1,...) for formats links in "commitdiff"
 - t9500: Add basic sanity tests for side-by-side diff in gitweb
 - t9500: Add test for handling incomplete lines in diff by gitweb
 - gitweb: Give side-by-side diff extra CSS styling
 - gitweb: Add a feature to show side-by-side diff
 - gitweb: Extract formatting of diff chunk header
 - gitweb: Refactor diff body line classification

Replaces a series from Kato Kazuyoshi on the same topic.

* mf/curl-select-fdset (2011-11-04) 4 commits
  (merged to 'next' on 2011-11-06 at a49516f)
 + http: drop "local" member from request struct
 + http.c: Rely on select instead of tracking whether data was received
 + http.c: Use timeout suggested by curl instead of fixed 50ms timeout
 + http.c: Use curl_multi_fdset to select on curl fds instead of just sleeping

Reduces unnecessary waits.

* nd/misc-cleanups (2011-10-27) 6 commits
  (merged to 'next' on 2011-10-28 at 2527a49)
 + unpack_object_header_buffer(): clear the size field upon error
 + tree_entry_interesting: make use of local pointer "item"
 + tree_entry_interesting(): give meaningful names to return values
 + read_directory_recursive: reduce one indentation level
 + get_tree_entry(): do not call find_tree_entry() on an empty tree
 + tree-walk.c: do not leak internal structure in tree_entry_len()

These are unquestionably good parts taken out of a larger series, so that
we can focus more on the other changes in later rounds of review.

Will keep in 'next' during this cycle.

* rs/allocate-cache-entry-individually (2011-10-26) 2 commits
  (merged to 'next' on 2011-10-27 at 2e4acd6)
 + cache.h: put single NUL at end of struct cache_entry
 + read-cache.c: allocate index entries individually

Will keep in 'next' during this cycle.

* mh/ref-api-3 (2011-10-19) 11 commits
  (merged to 'next' on 2011-10-23 at 92e2d35)
 + is_refname_available(): reimplement using do_for_each_ref_in_array()
 + names_conflict(): simplify implementation
 + names_conflict(): new function, extracted from is_refname_available()
 + repack_without_ref(): reimplement using do_for_each_ref_in_array()
 + do_for_each_ref_in_array(): new function
 + do_for_each_ref(): correctly terminate while processesing extra_refs
 + add_ref(): take a (struct ref_entry *) parameter
 + create_ref_entry(): extract function from add_ref()
 + parse_ref_line(): add a check that the refname is properly formatted
 + repack_without_ref(): remove temporary
 + Rename another local variable name -> refname
 (this branch uses mh/ref-api-2.)

Will keep in 'next' during this cycle.

* rr/revert-cherry-pick (2011-10-23) 5 commits
  (merged to 'next' on 2011-10-26 at 27b7496)
 + revert: simplify communicating command-line arguments
 + revert: allow mixed pick and revert instructions
 + revert: make commit subjects in insn sheet optional
 + revert: simplify getting commit subject in format_todo()
 + revert: free msg in format_todo()

The internals of "git revert/cherry-pick" has been further refactored to
serve as the basis for the sequencer.

Will keep in 'next' during this cycle.

* cb/daemon-permission-errors (2011-10-17) 2 commits
 - daemon: report permission denied error to clients
 - daemon: add tests

The tip commit might be loosening things a bit too much.
Will keep in 'pu' until hearing a convincing argument for the patch.

* mh/ref-api-2 (2011-10-17) 14 commits
  (merged to 'next' on 2011-10-19 at cc89f0e)
 + resolve_gitlink_ref_recursive(): change to work with struct ref_cache
 + Pass a (ref_cache *) to the resolve_gitlink_*() helper functions
 + resolve_gitlink_ref(): improve docstring
 + get_ref_dir(): change signature
 + refs: change signatures of get_packed_refs() and get_loose_refs()
 + is_dup_ref(): extract function from sort_ref_array()
 + add_ref(): add docstring
 + parse_ref_line(): add docstring
 + is_refname_available(): remove the "quiet" argument
 + clear_ref_array(): rename from free_ref_array()
 + refs: rename parameters result -> sha1
 + refs: rename "refname" variables
 + struct ref_entry: document name member
 + cache.h: add comments for git_path() and git_path_submodule()
 (this branch is used by mh/ref-api-3.)

Will keep in 'next' during this cycle.

* sg/complete-refs (2011-10-21) 9 commits
  (merged to 'next' on 2011-10-26 at d65e2b4)
 + completion: remove broken dead code from __git_heads() and __git_tags()
 + completion: fast initial completion for config 'remote.*.fetch' value
 + completion: improve ls-remote output filtering in __git_refs_remotes()
 + completion: query only refs/heads/ in __git_refs_remotes()
 + completion: support full refs from remote repositories
 + completion: improve ls-remote output filtering in __git_refs()
 + completion: make refs completion consistent for local and remote repos
 + completion: optimize refs completion
 + completion: document __gitcomp()

Will keep in 'next' until an Ack or two from completion folks.

* jc/request-pull-show-head-4 (2011-11-09) 12 commits
  (merged to 'next' on 2011-11-13 at e473fd2)
 + request-pull: use the annotated tag contents
  (merged to 'next' on 2011-10-15 at 7e340ff)
 + fmt-merge-msg.c: Fix an "dubious one-bit signed bitfield" sparse error
  (merged to 'next' on 2011-10-10 at 092175e)
 + environment.c: Fix an sparse "symbol not declared" warning
 + builtin/log.c: Fix an "Using plain integer as NULL pointer" warning
  (merged to 'next' on 2011-10-07 at fcaeca0)
 + fmt-merge-msg: use branch.$name.description
  (merged to 'next' on 2011-10-06 at fa5e0fe)
 + request-pull: use the branch description
 + request-pull: state what commit to expect
 + request-pull: modernize style
 + branch: teach --edit-description option
 + format-patch: use branch description in cover letter
 + branch: add read_branch_desc() helper function
 + Merge branch 'bk/ancestry-path' into jc/branch-desc

Allow setting "description" for branches and use it to help communications
between humans in various workflow elements. It also allows requesting for
a signed tag to be pulled and shows the tag message in the generated message.

Will keep in 'next' during this cycle.

--------------------------------------------------
[Discarded]

* kk/gitweb-side-by-side-diff (2011-10-17) 2 commits
 . gitweb: add a feature to show side-by-side diff
 . gitweb: change format_diff_line() to remove leading SP from $diff_class

* jc/check-ref-format-fixup (2011-10-19) 2 commits
  (merged to 'next' on 2011-10-19 at 98981be)
 + Revert "Restrict ref-like names immediately below $GIT_DIR"
  (merged to 'next' on 2011-10-15 at 8e89bc5)
 + Restrict ref-like names immediately below $GIT_DIR

This became a no-op except for the bottom one which is part of the other
topic now.
