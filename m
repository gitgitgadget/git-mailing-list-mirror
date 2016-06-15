From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jul 2011, #01; Wed, 6)
Date: Wed, 06 Jul 2011 18:24:07 -0700
Message-ID: <7vpqlmhoi0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 07 03:24:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QedKI-0000iA-Un
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 03:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081Ab1GGBYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 21:24:12 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56703 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857Ab1GGBYL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 21:24:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4CB8B6356;
	Wed,  6 Jul 2011 21:24:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=F
	C3/WU7X5i9G2RPvcVYWl4piQNU=; b=usw8Y55VaIJU/e4pSUKFiP9QkmO9DhJkb
	c+JY23l4Ujm4ZKyoI5zF8+HT7LcP/Dw+9TA5h7XVjI0ZK0+17mW81StMnZHw3E/a
	kOh9ioVR2spUJeK7pRPKSLBaRhQ+VHs+edKW5oJG2ApRvr+9Fj/BvBU/U/lJVP0j
	zXfK/1qXwI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Wqe
	xEQUqNwr1Jj2fedlAGv7psFBpF3wORezM0gE5jGU+ZviXt8JhYBt6r9vzbT9N/NM
	EIV1eNHP9YH3mTXkKAaL8T0p3o+iyDZwdI6pTv5O7G+wSy/5xXmXqyNMkNjKxUUS
	in53SNqxIxliNBg1zZBWH/S9oFUpcH67zzdDdlcY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 43C866355;
	Wed,  6 Jul 2011 21:24:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CA19C6354; Wed,  6 Jul 2011
 21:24:08 -0400 (EDT)
X-master-at: cf13f6ca40529a33b66c5e1e7cc69947974b3648
X-next-at: 02b4229c523b5c12ecb6c426ad6edd106405518c
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D00DE21E-A837-11E0-A217-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176738>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

--------------------------------------------------
[New Topics]

* jc/maint-mergetool-read-fix (2011-07-01) 1 commit
 - mergetool: check return value from read

* nk/branch-v-abbrev (2011-07-01) 1 commit
 - branch -v: honor core.abbrev

Perhaps needs an updated commit log message?

* jc/checkout-reflog-fix (2011-07-06) 3 commits
 - Merge commit 'v1.7.6' into jc/checkout-reflog-fix
 - Merge commit 'v1.7.0' into jc/checkout-reflog-fix
 - Merge commit 'v1.6.0' into jc/checkout-reflog-fix
 (this branch uses jc/maint-checkout-reflog-fix.)

* jc/maint-checkout-reflog-fix (2011-07-06) 1 commit
 - checkout: do not write bogus reflog entry out
 (this branch is used by jc/checkout-reflog-fix.)

* js/ref-namespaces (2011-07-06) 4 commits
 - ref namespaces: documentation
 - ref namespaces: Support remote repositories via upload-pack and receive-pack
 - ref namespaces: infrastructure
 - Fix prefix handling in ref iteration functions

* mz/doc-synopsis-verse (2011-07-06) 1 commit
 - Documentation: use [verse] for SYNOPSIS sections

* rc/histogram-diff (2011-07-06) 4 commits
 - t4033-diff-patience: factor out tests
 - xdiff/xpatience: factor out fall-back-diff function
 - xdiff/xprepare: refactor abort cleanups
 - xdiff/xprepare: use memset()

--------------------------------------------------
[Graduated to "master"]

* ab/i18n-scripts (2011-05-21) 48 commits
  (merged to 'next' on 2011-06-29 at 61f4472)
 + i18n: git-bisect bisect_next_check "You need to" message
 + i18n: git-bisect [Y/n] messages
 + i18n: git-bisect bisect_replay + $1 messages
 + i18n: git-bisect bisect_reset + $1 messages
 + i18n: git-bisect bisect_run + $@ messages
 + i18n: git-bisect die + eval_gettext messages
 + i18n: git-bisect die + gettext messages
 + i18n: git-bisect echo + eval_gettext message
 + i18n: git-bisect echo + gettext messages
 + i18n: git-bisect gettext + echo message
 + i18n: git-bisect add git-sh-i18n
 + i18n: git-stash drop_stash say/die messages
 + i18n: git-stash "unknown option" message
 + i18n: git-stash die + eval_gettext $1 messages
 + i18n: git-stash die + eval_gettext $* messages
 + i18n: git-stash die + eval_gettext messages
 + i18n: git-stash die + gettext messages
 + i18n: git-stash say + gettext messages
 + i18n: git-stash echo + gettext message
 + i18n: git-stash add git-sh-i18n
 + i18n: git-submodule "blob" and "submodule" messages
 + i18n: git-submodule "path not initialized" message
 + i18n: git-submodule "[...] path is ignored" message
 + i18n: git-submodule "Entering [...]" message
 + i18n: git-submodule $errmsg messages
 + i18n: git-submodule "Submodule change[...]" messages
 + i18n: git-submodule "cached cannot be used" message
 + i18n: git-submodule $update_module say + die messages
 + i18n: git-submodule die + eval_gettext messages
 + i18n: git-submodule say + eval_gettext messages
 + i18n: git-submodule echo + eval_gettext messages
 + i18n: git-submodule add git-sh-i18n
 + i18n: git-pull eval_gettext + warning message
 + i18n: git-pull eval_gettext + die message
 + i18n: git-pull die messages
 + i18n: git-pull add git-sh-i18n
 + i18n: git-am printf(1) message to eval_gettext
 + i18n: git-am core say messages
 + i18n: git-am "Falling back" say message
 + i18n: git-am "Apply?" message
 + i18n: git-am clean_abort messages
 + i18n: git-am cannot_fallback messages
 + i18n: git-am die messages
 + i18n: git-am gettext + gettext to stderr message
 + i18n: git-am eval_gettext messages
 + i18n: git-am multi-line getttext $msg; echo
 + i18n: git-am one-line gettext $msg; echo
 + i18n: git-am add git-sh-i18n

* da/git-prefix-everywhere (2011-06-02) 4 commits
  (merged to 'next' on 2011-06-29 at 4ed5461)
 + t/t7503-pre-commit-hook.sh: Add GIT_PREFIX tests
 + git-mergetool--lib: Make vimdiff retain the current directory
 + git: Remove handling for GIT_PREFIX
 + setup: Provide GIT_PREFIX to built-ins

* jc/streaming (2011-05-26) 14 commits
  (merged to 'next' on 2011-06-29 at 55ac692)
 + sha1_file: use the correct type (ssize_t, not size_t) for read-style function
 + streaming: read loose objects incrementally
 + sha1_file.c: expose helpers to read loose objects
 + streaming: read non-delta incrementally from a pack
 + streaming_write_entry(): support files with holes
 + convert: CRLF_INPUT is a no-op in the output codepath
 + streaming_write_entry(): use streaming API in write_entry()
 + streaming: a new API to read from the object store
 + write_entry(): separate two helper functions out
 + unpack_object_header(): make it public
 + sha1_object_info_extended(): hint about objects in delta-base cache
 + sha1_object_info_extended(): expose a bit more info
 + packed_object_info_detail(): do not return a string
 + Merge branches 'jc/convert', 'jc/bigfile' and 'jc/replacing' into jc/streaming
 (this branch is used by jc/streaming-filter.)

* jc/streaming-filter (2011-05-26) 8 commits
  (merged to 'next' on 2011-06-29 at 9901923)
 + t0021: test application of both crlf and ident
 + t0021-conversion.sh: fix NoTerminatingSymbolAtEOF test
 + streaming: filter cascading
 + streaming filter: ident filter
 + Add LF-to-CRLF streaming conversion
 + stream filter: add "no more input" to the filters
 + Add streaming filter API
 + convert.h: move declarations for conversion from cache.h
 (this branch uses jc/streaming.)

* jn/gitweb-js-blame (2011-05-27) 3 commits
  (merged to 'next' on 2011-06-29 at cce347d)
 + gitweb.js: use setTimeout rather than setInterval in blame_incremental.js
 + gitweb.js: No need for loop in blame_incremental's handleResponse()
 + gitweb.js: No need for inProgress in blame_incremental.js

--------------------------------------------------
[Stalled]

* jh/receive-count-limit (2011-05-23) 10 commits
 - receive-pack: Allow server to refuse pushes with too many objects
 - pack-objects: Estimate pack size; abort early if pack size limit is exceeded
 - send-pack/receive-pack: Allow server to refuse pushing too large packs
 - pack-objects: Allow --max-pack-size to be used together with --stdout
 - send-pack/receive-pack: Allow server to refuse pushes with too many commits
 - pack-objects: Teach new option --max-commit-count, limiting #commits in pack
 - receive-pack: Prepare for addition of the new 'limit-*' family of capabilities
 - Tighten rules for matching server capabilities in server_supports()
 - send-pack: Attempt to retrieve remote status even if pack-objects fails
 - Update technical docs to reflect side-band-64k capability in receive-pack

Would need another round to separate per-pack and per-session limits.
Not urgent. Will not merge before 1.7.6.

* sr/transport-helper-fix (2011-06-19) 20 commits
 - transport-helper: implement marks location as capability
 - transport-helper: Use capname for gitdir capability too
 - transport-helper: export is no longer always the last command
 - transport-helper: change import semantics
 - transport-helper: update ref status after push with export
 - transport-helper: use the new done feature where possible
 - transport-helper: check status code of finish_command
 - transport-helper: factor out push_update_refs_status
 - fast-export: support done feature
 - fast-import: introduce 'done' command
 - git-remote-testgit: fix error handling
 - git-remote-testgit: only push for non-local repositories
 - remote-curl: accept empty line as terminator
 - git_remote_helpers: push all refs during a non-local export
 - transport-helper: don't feed bogus refs to export push
 - teach remote-testgit to import non-HEAD refs
 - t5800: document some non-functional parts of remote helpers
 - t5800: use skip_all instead of prereq
 - t5800: factor out some ref tests
 - transport-helper: fix minor leak in push_refs_with_export

At least Patch 10/20 (git-remote-testgit: fix error handling) and Patch
15/20 (transport-helper: use the new done feature where possible) need a
reroll.

* jm/mergetool-pathspec (2011-06-22) 2 commits
 - mergetool: Don't assume paths are unmerged
 - mergetool: Add tests for filename with whitespace

I think this is a good idea, but it probably needs a re-roll.

--------------------------------------------------
[Cooking]

* rr/revert-cherry-pick-continue (2011-07-06) 14 commits
 - revert: Change insn sheet format
 - revert: Introduce --continue to continue the operation
 - revert: Introduce --reset to cleanup sequencer data
 - revert: Introduce a layer of indirection over pick_commits
 - revert: Persist data for continuation
 - revert: Don't create invalid replay_opts in parse_args
 - revert: Separate cmdline parsing from functional code
 - revert: Introduce struct to keep command-line options
 - revert: Eliminate global "commit" variable
 - revert: Propagate errors upwards from do_pick_commit
 - revert: Rename no_replay to record_origin
 - revert: Don't check lone argument in get_encoding
 - revert: Inline add_message_to_msg function
 - advice: Introduce error_resolve_conflict

* bc/submodule-foreach-stdin-fix-1.7.4 (2011-06-29) 2 commits
  (merged to 'next' on 2011-07-01 at 4651925)
 + git-submodule.sh: preserve stdin for the command spawned by foreach
 + t/t7407: demonstrate that the command called by 'submodule foreach' loses stdin

Will merge to "master".

* dc/stash-con-untracked (2011-06-26) 1 commit
 - stash: Add --include-untracked option to stash and remove all untracked files

Will merge to "next".

* jn/doc-dashdash (2011-06-29) 2 commits
  (merged to 'next' on 2011-07-01 at 5d51929)
 + Documentation/i18n: quote double-dash for AsciiDoc
 + Merge branch 'jn/maint-doc-dashdash' into jn/doc-dashdash
 (this branch uses jn/maint-doc-dashdash.)

Will merge to "master".

* jn/maint-doc-dashdash (2011-06-29) 1 commit
  (merged to 'next' on 2011-07-01 at 55ab98d)
 + Documentation: quote double-dash for AsciiDoc
 (this branch is used by jn/doc-dashdash.)

Will merge to "master" as part of jn/doc-dashdash and later to "maint".

* js/rebase-typo-branch-squelch-usage (2011-06-29) 1 commit
  (merged to 'next' on 2011-07-01 at b5b4c03)
 + rebase: do not print lots of usage hints after an obvious error message

Will merge to "master".

* nk/ref-doc (2011-06-23) 7 commits
  (merged to 'next' on 2011-07-01 at 9ff278d)
 + glossary: clarify description of HEAD
 + glossary: update description of head and ref
 + glossary: update description of "tag"
 + git.txt: de-emphasize the implementation detail of a ref
 + check-ref-format doc: de-emphasize the implementation detail of a ref
 + git-remote.txt: avoid sounding as if loose refs are the only ones in the world
 + git-remote.txt: fix wrong remote refspec

Will merge to "master".

* jc/submodule-sync-no-auto-vivify (2011-06-26) 2 commits
  (merged to 'next' on 2011-07-05 at b207ba3)
 + submodule add: always initialize .git/config entry
 + submodule sync: do not auto-vivify uninteresting submodule

* jn/gitweb-search (2011-06-22) 4 commits
 - gitweb: Make git_search_* subroutines render whole pages
 - gitweb: Clean up code in git_search_* subroutines
 - gitweb: Split body of git_search into subroutines
 - gitweb: Check permissions first in git_search

Will merge to "next".

* ak/gcc46-profile-feedback (2011-06-20) 3 commits
  (merged to 'next' on 2011-07-01 at 81bc0a7)
 + Add explanation of the profile feedback build to the README
 + Add profile feedback build to git
 + Add option to disable NORETURN

* jc/maint-cygwin-trust-executable-bit-default (2011-06-20) 1 commit
  (merged to 'next' on 2011-07-01 at d85aa04)
 + cygwin: trust executable bit by default

Fix for an ancient regression.
Will merge to "master".

* jk/tag-list-multiple-patterns (2011-06-20) 1 commit
  (merged to 'next' on 2011-07-05 at 8db1bf0)
 + tag: accept multiple patterns for --list

* jl/maint-fetch-recursive-fix (2011-06-20) 1 commit
  (merged to 'next' on 2011-07-01 at 476eee4)
 + fetch: Also fetch submodules in subdirectories in on-demand mode

Will merge to "master".

* fk/relink-upon-ldflags-update (2011-06-22) 1 commit
  (merged to 'next' on 2011-07-01 at 69b57d0)
 + Makefile: Track changes to LDFLAGS and relink when necessary

Will merge to "master".

* jk/maint-config-param (2011-06-22) 6 commits
  (merged to 'next' on 2011-07-05 at 2dce181)
 + config: use strbuf_split_str instead of a temporary strbuf
 + strbuf: allow strbuf_split to work on non-strbufs
 + config: avoid segfault when parsing command-line config
 + config: die on error in command-line config
 + fix "git -c" parsing of values with equals signs
 + strbuf_split: add a max parameter
 (this branch is used by jk/clone-cmdline-config.)

Separated earlier parts of jk/clone-cmdline-config for maint.

* jn/gitweb-split-header-html (2011-06-22) 1 commit
  (merged to 'next' on 2011-07-05 at c60d9dc)
 + gitweb: Refactor git_header_html

* aw/rebase-i-p (2011-06-19) 1 commit
  (merged to 'next' on 2011-07-01 at df3f3d8)
 + rebase -i -p: include non-first-parent commits in todo list

Rerolled with a minor tweak.
Will merge to "master".

* en/merge-recursive (2011-06-13) 49 commits
 - t3030: fix accidental success in symlink rename
 - merge-recursive: Fix working copy handling for rename/rename/add/add
 - merge-recursive: add handling for rename/rename/add-dest/add-dest
 - merge-recursive: Have conflict_rename_delete reuse modify/delete code
 - merge-recursive: Make modify/delete handling code reusable
 - merge-recursive: Consider modifications in rename/rename(2to1) conflicts
 - merge-recursive: Create function for merging with branchname:file markers
 - merge-recursive: Record more data needed for merging with dual renames
 - merge-recursive: Defer rename/rename(2to1) handling until process_entry
 - merge-recursive: Small cleanups for conflict_rename_rename_1to2
 - merge-recursive: Fix rename/rename(1to2) resolution for virtual merge base
 - merge-recursive: Introduce a merge_file convenience function
 - merge-recursive: Fix modify/delete resolution in the recursive case
 - merge-recursive: Provide more info in conflict markers with file renames
 - merge-recursive: Cleanup and consolidation of rename_conflict_info
 - merge-recursive: Consolidate process_entry() and process_df_entry()
 - merge-recursive: Improve handling of rename target vs. directory addition
 - merge-recursive: Add comments about handling rename/add-source cases
 - merge-recursive: Make dead code for rename/rename(2to1) conflicts undead
 - merge-recursive: Fix deletion of untracked file in rename/delete conflicts
 - merge-recursive: When we detect we can skip an update, actually skip it
 - merge-recursive: Split update_stages_and_entry; only update stages at end
 - merge-recursive: Consolidate different update_stages functions
 - merge-recursive: Allow make_room_for_path() to remove D/F entries
 - merge-recursive: Split was_tracked() out of would_lose_untracked()
 - merge-recursive: Save D/F conflict filenames instead of unlinking them
 - merge-recursive: Fix code checking for D/F conflicts still being present
 - merge-recursive: Fix sorting order and directory change assumptions
 - merge-recursive: Fix recursive case with D/F conflict via add/add conflict
 - merge-recursive: Avoid working directory changes during recursive case
 - merge-recursive: Remember to free generated unique path names
 - merge-recursive: Mark some diff_filespec struct arguments const
 - merge-recursive: Correct a comment
 - merge-recursive: Make BUG message more legible by adding a newline
 - t6022: Add testcase for merging a renamed file with a simple change
 - t6022: New tests checking for unnecessary updates of files
 - t6022: Remove unnecessary untracked files to make test cleaner
 - t6036: criss-cross + rename/rename(1to2)/add-source + modify/modify
 - t6036: criss-cross w/ rename/rename(1to2)/modify+rename/rename(2to1)/modify
 - t6036: tests for criss-cross merges with various directory/file conflicts
 - t6036: criss-cross with weird content can fool git into clean merge
 - t6036: Add differently resolved modify/delete conflict in criss-cross test
 - t6042: Ensure rename/rename conflicts leave index and workdir in sane state
 - t6042: Add failing testcases for rename/rename/add-{source,dest} conflicts
 - t6042: Add tests for content issues with modify/rename/directory conflicts
 - t6042: Add a testcase where undetected rename causes silent file deletion
 - t6042: Add a pair of cases where undetected renames cause issues
 - t6042: Add failing testcase for rename/modify/add-source conflict
 - t6042: Add a testcase where git deletes an untracked file

Haven't looked at the whole series yet.

* fg/submodule-keep-updating (2011-06-13) 3 commits
  (merged to 'next' on 2011-07-01 at 227827c)
 + git-submodule.sh: clarify the "should we die now" logic
 + submodule update: continue when a checkout fails
 + git-sh-setup: add die_with_status

Will merge to "master".

* jc/no-gitweb-test-without-cgi-etc (2011-06-15) 1 commit
  (merged to 'next' on 2011-07-01 at 1db3fa4)
 + t/gitweb-lib.sh: skip gitweb tests when perl dependencies are not met

Will merge to "master".

* jn/mime-type-with-params (2011-06-30) 2 commits
  (merged to 'next' on 2011-07-05 at 7caaf3b)
 + gitweb: Serve */*+xml 'blob_plain' as text/plain with $prevent_xss
 + gitweb: Serve text/* 'blob_plain' as text/plain with $prevent_xss

* ln/gitweb-mime-types-split-at-blank (2011-06-15) 1 commit
  (merged to 'next' on 2011-07-01 at 765aa1e)
 + gitweb: allow space as delimiter in mime.types

Will merge to "master".

* md/interix-update (2011-06-15) 1 commit
  (merged to 'next' on 2011-07-01 at 0bc327d)
 + Update the Interix default build configuration.

Will merge to "master".

* rj/config-cygwin (2011-06-16) 3 commits
  (merged to 'next' on 2011-07-01 at 6da4aa5)
 + config.c: Make git_config() work correctly when called recursively
 + t1301-*.sh: Fix the 'forced modes' test on cygwin
 + help.c: Fix detection of custom merge strategy on cygwin

Will merge to "master".

* jk/archive-tar-filter (2011-06-22) 9 commits
  (merged to 'next' on 2011-07-05 at add3e7f)
 + upload-archive: allow user to turn off filters
 + archive: provide builtin .tar.gz filter
 + archive: implement configurable tar filters
 + archive: refactor file extension format-guessing
 + archive: move file extension format-guessing lower
 + archive: pass archiver struct to write_archive callback
 + archive: refactor list of archive formats
 + archive-tar: don't reload default config options
 + archive: reorder option parsing and config reading

Rerolled.

* jc/index-pack (2011-06-05) 9 commits
  (merged to 'next' on 2011-07-05 at 5062ba9)
 + verify-pack: use index-pack --verify
 + index-pack: show histogram when emulating "verify-pack -v"
 + index-pack: start learning to emulate "verify-pack -v"
 + index-pack: a miniscule refactor
 + index-pack --verify: read anomalous offsets from v2 idx file
 + write_idx_file: need_large_offset() helper function
 + index-pack: --verify
 + write_idx_file: introduce a struct to hold idx customization options
 + index-pack: group the delta-base array entries also by type

Killed "verify-pack" ;-) The next will be to update fsck, which would be a
bigger task.

* an/shallow-doc (2011-06-08) 2 commits
  (merged to 'next' on 2011-07-01 at 6ba80ef)
 + Document the underlying protocol used by shallow repositories and --depth commands.
 + Fix documentation of fetch-pack that implies that the client can disconnect after sending wants.

Will merge to "master".

* jc/legacy-loose-object (2011-06-08) 1 commit
  (merged to 'next' on 2011-07-01 at 5561971)
 + sha1_file.c: "legacy" is really the current format

Will merge to "master".

* jc/zlib-wrap (2011-06-10) 7 commits
  (merged to 'next' on 2011-07-05 at 77bcbdc)
 + zlib: allow feeding more than 4GB in one go
 + zlib: zlib can only process 4GB at a time
 + zlib: wrap deflateBound() too
 + zlib: wrap deflate side of the API
 + zlib: wrap inflateInit2 used to accept only for gzip format
 + zlib: wrap remaining calls to direct inflate/inflateEnd
 + zlib wrapper: refactor error message formatter

This replaces the earlier attempt to deal with the mismatch between our
expectation and what zlib API actually offers piecemeal.

* jk/clone-cmdline-config (2011-06-22) 4 commits
  (merged to 'next' on 2011-07-05 at a022613)
 + clone: accept config options on the command line
 + config: make git_config_parse_parameter a public function
 + remote: use new OPT_STRING_LIST
 + parse-options: add OPT_STRING_LIST helper
 (this branch uses jk/maint-config-param.)

Separated the earlier parts out to make it mergeable to the maintenance
track.

* jk/tag-contains-ab (2011-06-30) 4 commits
 - git skew: a tool to find how big a clock skew exists in the history
  (merged to 'next' on 2011-07-05 at f9cf575)
 + default core.clockskew variable to one day
 + limit "contains" traversals based on commit timestamp
 + tag: speed up --contains calculation

* jk/clone-detached (2011-06-07) 4 commits
 - clone: always fetch remote HEAD
 - make copy_ref globally available
 - consider only branches in guess_remote_head
 - t: add tests for cloning remotes with detached HEAD

Somewhat involved bugfix.
Will merge to "next".

* jl/submodule-add-relurl-wo-upstream (2011-06-06) 3 commits
 - submodule add: clean up duplicated code
 - submodule add: allow relative repository path even when no url is set
 - submodule add: test failure when url is not configured in superproject

Will merge to "next".
