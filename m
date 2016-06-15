From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Aug 2011, #02; Mon, 8)
Date: Mon, 08 Aug 2011 15:59:16 -0700
Message-ID: <7v8vr3v7az.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 00:59:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqYn7-00027L-Kr
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 00:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090Ab1HHW7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 18:59:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39586 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751610Ab1HHW7T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 18:59:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83BC14224;
	Mon,  8 Aug 2011 18:59:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=y
	apL4Bhmxw49VZ7VcI1YR1PddcM=; b=fKCn0FmAQNGEPnhrA5W08Vuuzv892TY9d
	Z594mzxHJBHZJxLtJ0/+e6Ggot5eo0cyPz6VSOz8GkGZkL8FS/rfMAvisETDqxNv
	i+AwJ3pTM7oFEIRo55JawhdZbGs7/HUx2WjDHrifG97fjHywfXWD9/ROo9T0Abk6
	KQ7MIkEbYg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=B8h
	xRB+V/bWsW3QrQoxUT5Xcia0tjhjdpFxR8GEtW1LkzqecETvgSPHTINF+F5IyDqz
	eyGoZsGdUJzsEUviAQsRuyMv74rTvJntIX9//+WmGCLRxv5DnMiX6wv7gsqQ9WIs
	VmgNtuXle4gmei7ZZceyK4yaAQX+JjMl83UhJ4bk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 798194223;
	Mon,  8 Aug 2011 18:59:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7BAB44222; Mon,  8 Aug 2011
 18:59:17 -0400 (EDT)
X-master-at: 1421fd9df4f1e3ed232bd1c683c6e264a464a41e
X-next-at: 917d73bc85e756fc5d627c398a3b2aaebc3cf157
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0B41A61A-C212-11E0-88C2-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179003>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

There are a few 'fixup!' commits queued in topics still in 'pu', so that
authors have a choice to just say "that fix looks good, squash it in!"
instead of going through an extra round.

--------------------------------------------------
[Graduated to "master"]

* jc/diff-index-refactor (2011-07-13) 2 commits
  (merged to 'next' on 2011-08-01 at 98d8b08)
 + diff-lib: refactor run_diff_index() and do_diff_cache()
 + diff-lib: simplify do_diff_cache()

* jc/pack-order-tweak (2011-07-08) 2 commits
  (merged to 'next' on 2011-07-25 at 1460c31)
 + pack-objects: optimize "recency order"
 + core: log offset pack data accesses happened

* jk/reset-reflog-message-fix (2011-07-22) 1 commit
  (merged to 'next' on 2011-08-01 at 6c88837)
 + reset: give better reflog messages

* jl/submodule-status-summary-doc (2011-08-01) 1 commit
  (merged to 'next' on 2011-08-03 at 88f97a9)
 + Documentation/submodule: add command references and update options

* jl/submodule-update-quiet (2011-07-28) 1 commit
  (merged to 'next' on 2011-08-01 at c611587)
 + submodule: update and add must honor --quiet flag

* jn/gitweb-config-list-case (2011-07-31) 1 commit
  (merged to 'next' on 2011-08-01 at 9268738)
 + gitweb: Git config keys are case insensitive, make config search too

* jn/gitweb-system-config (2011-07-24) 1 commit
  (merged to 'next' on 2011-08-01 at 4941e45)
 + gitweb: Introduce common system-wide settings for convenience

* js/ls-tree-error (2011-07-25) 2 commits
  (merged to 'next' on 2011-08-01 at 61bae55)
 + Ensure git ls-tree exits with a non-zero exit code if read_tree_recursive fails.
 + Add a test to check that git ls-tree sets non-zero exit code on error.

* ms/reflog-show-is-default (2011-08-01) 1 commit
  (merged to 'next' on 2011-08-03 at ae9cf6f)
 + reflog: actually default to subcommand 'show'

* oa/pull-reflog (2011-08-01) 1 commit
  (merged to 'next' on 2011-08-03 at faeff94)
 + pull: remove extra space from reflog message

* tc/minix (2011-07-20) 1 commit
  (merged to 'next' on 2011-07-25 at 36ad29f)
 + Makefile: add Minix configuration options.

--------------------------------------------------
[New Topics]

* jc/maint-combined-diff-work-tree (2011-08-04) 1 commit
  (merged to 'next' on 2011-08-05 at 976a4d4)
 + diff -c/--cc: do not mistake "resolved as deletion" as "use working tree"

Will merge to "master" after cooking for a bit more.

* jk/fast-export-quote-path (2011-08-05) 1 commit
  (merged to 'next' on 2011-08-05 at a80e5f5)
 + fast-export: quote paths in output

Will merge to "master".

* js/sh-style (2011-08-05) 2 commits
 - filter-branch.sh: de-dent usage string
 - misc-sh: fix up whitespace in some other .sh files.

Will merge to "next".

* ma/am-exclude (2011-08-03) 1 commit
  (merged to 'next' on 2011-08-05 at 658e57c)
 + am: pass exclude down to apply

Will merge to "master" after cooking for a bit more.

* po/cygwin-backslash (2011-08-05) 2 commits
 - On Cygwin support both UNIX and DOS style path-names
 - git-compat-util: add generic find_last_dir_sep that respects is_dir_sep

I think a further refactoring (no, not my suggestion) was offered?

* rc/maint-http-wrong-free (2011-08-03) 2 commits
  (merged to 'next' on 2011-08-05 at cea08ed)
 + Makefile: some changes for http-related flag documentation
 + http.c: fix an invalid free()

Will merge to "master".

* db/am-skip-blank-at-the-beginning (2011-08-08) 2 commits
 - RE: [PATCH v2] am: ignore leading whitespace before patch
 - am: ignore leading whitespace before patch

Hmmm, perhaps mailinfo should consider [Rr][Ee]: instead of [Rr]e:
as a known noise?

Will merge to "next" after squashing them into one.

* jc/maint-smart-http-race-upload-pack (2011-08-08) 1 commit
 - helping smart-http/stateless-rpc fetch race

Will merge to "next".

* jn/maint-test-return (2011-08-08) 2 commits
 - test: cope better with use of return for errors
 - test: simplify return value of test_run_

Will merge to "next".

* rt/zlib-smaller-window (2011-08-08) 3 commits
 - test: consolidate definition of $LF
 - fixup! Tolerate zlib deflation with window
 - Tolerate zlib deflation with window size < 32Kb

Will merge to "next" after squashing the second one into the bottom one.

* fg/submodule-git-file-git-dir (2011-08-08) 3 commits
 - Move git-dir for submodules
 - fixup! rev-parse: add option --is-well-formed-git-dir
 - rev-parse: add option --is-well-formed-git-dir <path>

--------------------------------------------------
[Stalled]

* jc/merge-reword (2011-05-25) 2 commits
 - merge: mark the final "Merge made by..." message for l10n
 - merge: reword the final message

Probably the topmost commit should be dropped.

* cb/maint-ls-files-error-report (2011-08-01) 2 commits
 - squash! ls-files: fix pathspec display on error
 - ls-files: fix pathspec display on error

Will merge to "next" after getting an Ack for the fix-up and squashing it.

* ac/describe-dirty-refresh (2011-08-01) 2 commits
 - fixup! describe: Refresh the index when run with --dirty
 - describe: Refresh the index when run with --dirty

Will merge to "next" after squashing the fixup into the bottom one.

* nk/branch-v-abbrev (2011-07-01) 1 commit
 - branch -v: honor core.abbrev

Perhaps needs an updated commit log message?

* di/fast-import-doc (2011-07-13) 2 commits
 - doc/fast-import: document feature import-marks-if-exists
 - doc/fast-import: clarify notemodify command

Comments from fast-import folks?

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

* jm/mergetool-pathspec (2011-06-22) 2 commits
 - mergetool: Don't assume paths are unmerged
 - mergetool: Add tests for filename with whitespace

I think this is a good idea, but it probably needs a re-roll.
Cf. $gmane/176254, 176255, 166256

* jk/generation-numbers (2011-07-14) 7 commits
 - limit "contains" traversals based on commit generation
 - check commit generation cache validity against grafts
 - pretty: support %G to show the generation number of a commit
 - commit: add commit_generation function
 - add metadata-cache infrastructure
 - decorate: allow storing values instead of pointers
 - Merge branch 'jk/tag-contains-ab' (early part) into HEAD

The initial "tag --contains" de-pessimization without need for generation
numbers is already in; backburnered.

* en/merge-recursive (2011-08-04) 49 commits
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

Re-roll being worked on.

* sr/transport-helper-fix-rfc (2011-07-19) 2 commits
 - t5800: point out that deleting branches does not work
 - t5800: document inability to push new branch with old content

--------------------------------------------------
[Cooking]

* ef/ipv4-connect-error-report (2011-08-01) 2 commits
  (merged to 'next' on 2011-08-03 at ea4842b)
 + connect: only log if all attempts failed (ipv4)
 + Merge branch 'maint' into ef/ipv4-connect-error-report

Will merge to "master".

* js/bisect-no-checkout (2011-08-05) 10 commits
 - bisect: further style nitpicks
 - bisect: replace "; then" with "\n<tab>*then"
 - bisect: cleanup whitespace errors in git-bisect.sh.
 - bisect: add documentation for --no-checkout option.
 - bisect: add tests for the --no-checkout option.
 - bisect: introduce --no-checkout support into porcelain.
 - bisect: introduce support for --no-checkout option.
 - bisect: add tests to document expected behaviour in presence of broken trees.
 - bisect: use && to connect statements that are deferred with eval.
 - bisect: move argument parsing before state modification.

Will merge to "next".

* rs/grep-function-context (2011-08-01) 2 commits
  (merged to 'next' on 2011-08-05 at 8d63a8c)
 + grep: long context options
 + grep: add option to show whole function as context

Will merge to "master".

* cb/partial-commit-relative-pathspec (2011-08-02) 1 commit
  (merged to 'next' on 2011-08-03 at 6918f69)
 + commit: allow partial commits with relative paths

Ideally the pathspec-prefix helper should be renamed to something more
sensible, but we could live with it for now.

* cb/maint-exec-error-report (2011-08-01) 2 commits
  (merged to 'next' on 2011-08-05 at 2764424)
 + notice error exit from pager
 + error_routine: use parent's stderr if exec fails

Will merge to "master" after cooking for a bit more.

* cb/maint-quiet-push (2011-08-08) 2 commits
  (merged to 'next' on 2011-08-08 at 917d73b)
 + receive-pack: do not overstep command line argument array
  (merged to 'next' on 2011-08-01 at 87df938)
 + propagate --quiet to send-pack/receive-pack

Will merge to "master" after cooking for a bit more.

* jk/add-i-hunk-filter (2011-07-27) 5 commits
 - add--interactive: add option to autosplit hunks
 - add--interactive: allow negatation of hunk filters
 - add--interactive: allow hunk filtering on command line
 - add--interactive: factor out regex error handling
 - add--interactive: refactor patch mode argument processing

Will merge to "next".

* mh/check-attr-listing (2011-08-04) 23 commits
 - Rename git_checkattr() to git_check_attr()
 - git-check-attr: Fix command-line handling to match docs
 - git-check-attr: Drive two tests using the same raw data
 - git-check-attr: Add an --all option to show all attributes
 - git-check-attr: Error out if no pathnames are specified
 - git-check-attr: Process command-line args more systematically
 - git-check-attr: Handle each error separately
 - git-check-attr: Extract a function error_with_usage()
 - git-check-attr: Introduce a new variable
 - git-check-attr: Extract a function output_attr()
 - Allow querying all attributes on a file
 - Remove redundant check
 - Remove redundant call to bootstrap_attr_stack()
 - Extract a function collect_all_attrs()
 - Teach prepare_attr_stack() to figure out dirlen itself
 - git-check-attr: Use git_attr_name()
 - Provide access to the name attribute of git_attr
 - git-check-attr: Add tests of command-line parsing
 - git-check-attr: Add missing "&&"
 - Disallow the empty string as an attribute name
 - Remove anachronism from comment
 - doc: Correct git_attr() calls in example code
 - doc: Add a link from gitattributes(5) to git-check-attr(1)
 (this branch is used by mh/check-attr-relative.)

Will merge to "next".

* mh/check-attr-relative (2011-08-04) 6 commits
 - test-path-utils: Add subcommand "prefix_path"
 - test-path-utils: Add subcommand "absolute_path"
 - git-check-attr: Normalize paths
 - git-check-attr: Demonstrate problems with relative paths
 - git-check-attr: Demonstrate problems with unnormalized paths
 - git-check-attr: test that no output is written to stderr
 (this branch uses mh/check-attr-listing.)

Will merge to "next".

* jk/http-auth-keyring (2011-08-03) 13 commits
  (merged to 'next' on 2011-08-03 at b06e80e)
 + credentials: add "getpass" helper
 + credentials: add "store" helper
 + credentials: add "cache" helper
 + docs: end-user documentation for the credential subsystem
 + http: use hostname in credential description
 + allow the user to configure credential helpers
 + look for credentials in config before prompting
 + http: use credential API to get passwords
 + introduce credentials API
 + http: retry authentication failures for all http requests
 + remote-curl: don't retry auth failures with dumb protocol
 + improve httpd auth tests
 + url: decode buffers that are not NUL-terminated

Looked mostly reasonable except for the limitation that it is not clear
how to deal with a site at which a user needs to use different passwords 
for different repositories.

* js/ref-namespaces (2011-07-21) 5 commits
  (merged to 'next' on 2011-07-25 at 5b7dcfe)
 + ref namespaces: tests
 + ref namespaces: documentation
 + ref namespaces: Support remote repositories via upload-pack and receive-pack
 + ref namespaces: infrastructure
 + Fix prefix handling in ref iteration functions

* rc/histogram-diff (2011-08-08) 12 commits
 - xdiff/xhistogram: drop need for additional variable
 - xdiff/xhistogram: rely on xdl_trim_ends()
 - xdiff/xhistogram: rework handling of recursed results
 - xdiff: do away with xdl_mmfile_next()
  (merged to 'next' on 2011-08-03 at f9e2328)
 + Make test number unique
  (merged to 'next' on 2011-07-25 at 3351028)
 + xdiff/xprepare: use a smaller sample size for histogram diff
 + xdiff/xprepare: skip classification
 + teach --histogram to diff
 + t4033-diff-patience: factor out tests
 + xdiff/xpatience: factor out fall-back-diff function
 + xdiff/xprepare: refactor abort cleanups
 + xdiff/xprepare: use memset()

Will merge to "next".

* rr/revert-cherry-pick-continue (2011-08-08) 18 commits
 - revert: Propagate errors upwards from do_pick_commit
 - revert: Introduce --continue to continue the operation
 - revert: Don't implicitly stomp pending sequencer operation
 - revert: Remove sequencer state when no commits are pending
 - reset: Make reset remove the sequencer state
 - revert: Introduce --reset to remove sequencer state
 - revert: Make pick_commits functionally act on a commit list
 - revert: Save command-line options for continuing operation
 - revert: Save data for continuing after conflict resolution
 - revert: Don't create invalid replay_opts in parse_args
 - revert: Separate cmdline parsing from functional code
 - revert: Introduce struct to keep command-line options
 - revert: Eliminate global "commit" variable
 - revert: Rename no_replay to record_origin
 - revert: Don't check lone argument in get_encoding
 - revert: Simplify and inline add_message_to_msg
 - config: Introduce functions to write non-standard file
 - advice: Introduce error_resolve_conflict

Getting into a reasonable shape. Is another round of re-roll coming?
