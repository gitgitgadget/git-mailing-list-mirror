From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2010, #03; Sun, 10)
Date: Sun, 10 Jan 2010 11:55:10 -0800
Message-ID: <7vocl1pwf5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 10 20:55:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NU3sr-0001Wj-Ct
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 20:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252Ab0AJTzU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Jan 2010 14:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249Ab0AJTzT
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 14:55:19 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40729 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab0AJTzS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jan 2010 14:55:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 412B38F7A4;
	Sun, 10 Jan 2010 14:55:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=EK7M8B6QIzRsS81Js6yp3WrjL
	+k=; b=iFOq2XHt3vQXmDBfbhGvQmsL1vtxhgCfxG518L3hQRatcUCBXqu/A+kjB
	8xYPwEM5ODhEKjAG5xxxFUGLnJfLH+vqLSxqQfxvR8HG5uz25W1PAhogzAhJVkeq
	1ZJIVjjhdbme9A17VGxoEi4n5qbyRichirwyE5tcRr+emHQCrg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=rv2RWjJQWWUhnhREvIT
	dQhwZh/7pwpBDtjMUMrmaUmVgoyZ3gdHQelXJvN70TrLdVwTwtaBrHikkyfNvfR+
	aYnH493sFEiLk9ZgNoefBJdqeRusqfzccy0K5Q4hbKGGlesuU30M0U529781MHDM
	vupUZSw//w2NJaPXlTePl+yw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E44F8F7A2;
	Sun, 10 Jan 2010 14:55:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E8A38F7A0; Sun, 10 Jan
 2010 14:55:11 -0500 (EST)
X-master-at: 637afcf4e07616d1dd15d33f56c6b72f90f39821
X-next-at: e295b7f76150bd2ee9a82c569ccbbde6b8fba391
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1160EC32-FE22-11DE-B1FC-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136584>

What's cooking in git.git (Jan 2010, #03; Sun, 10)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I=
 am
still holding onto them.

--------------------------------------------------
[Graduated to "master"]

* tr/http-updates (2009-12-28) 4 commits
  (merged to 'next' on 2010-01-02 at cf25698)
 + Remove http.authAny
 + Allow curl to rewind the RPC read buffer
 + Add an option for using any HTTP authentication scheme, not only bas=
ic
 + http: maintain curl sessions

* jk/maint-1.6.5-reset-hard (2009-12-30) 1 commit
  (merged to 'next' on 2010-01-02 at 190d63b)
 + reset: unbreak hard resets with GIT_WORK_TREE

* jk/push-to-delete (2009-12-30) 1 commit
  (merged to 'next' on 2010-01-03 at 9ee293b)
 + builtin-push: add --delete as syntactic sugar for :foo

* mm/config-path (2009-12-30) 1 commit
  (merged to 'next' on 2010-01-03 at 9c0e81a)
 + builtin-config: add --path option doing ~ and ~user expansion.

* pm/cvs-environ (2009-12-30) 1 commit
  (merged to 'next' on 2010-01-03 at 4c22932)
 + CVS Server: Support reading base and roots from environment

* tr/maint-1.6.5-bash-prompt-show-submodule-changes (2009-12-31) 1 comm=
it
  (merged to 'next' on 2010-01-03 at b785974)
 + bash completion: factor submodules into dirty state

* bg/maint-remote-update-default (2009-12-31) 1 commit
  (merged to 'next' on 2010-01-03 at 113009e)
 + Fix "git remote update" with remotes.defalt set

* mm/diag-path-in-treeish (2009-12-07) 1 commit
  (merged to 'next' on 2010-01-06 at 6b4201e)
 + Detailed diagnosis when parsing an object name fails.

* fc/opt-quiet-gc-reset (2009-12-02) 1 commit
  (merged to 'next' on 2010-01-06 at 03e00cd)
 + General --quiet improvements

--------------------------------------------------
[New Topics]

* bk/fix-relative-gitdir-file (2010-01-08) 2 commits
 - Handle relative paths in submodule .git files
 - Test update-index for a gitlink to a .git file

* jc/ident (2010-01-08) 3 commits
 - ident.c: treat $EMAIL as giving user.email identity explicitly
  (merged to 'next' on 2010-01-10 at f1f9ded)
 + ident.c: check explicit identity for name and email separately
 + ident.c: remove unused variables

* jc/ls-files-ignored-pathspec (2010-01-08) 4 commits
 - ls-files: fix overeager pathspec optimization
 - read_directory(): further split treat_path()
 - read_directory_recursive(): refactor handling of a single path into =
a separate function
 - t3001: test ls-files -o ignored/dir

* js/exec-error-report (2010-01-10) 4 commits
 - Improve error message when a transport helper was not found
 - start_command: detect execvp failures early
 - run-command: move wait_or_whine earlier
 - start_command: report child process setup errors to the parent's std=
err
 (this branch uses il/vcs-helper.)

--------------------------------------------------
[Stalled]

* ap/merge-backend-opts (2008-07-18) 6 commits
 - Document that merge strategies can now take their own options
 - Extend merge-subtree tests to test -Xsubtree=3Ddir.
 - Make "subtree" part more orthogonal to the rest of merge-recursive.
 - Teach git-pull to pass -X<option> to git-merge
 - git merge -X<option>
 - git-merge-file --ours, --theirs

"git pull" patch needs sq-then-eval fix to protect it from $IFS
but otherwise seemed good.

* jh/commit-status (2009-12-07) 1 commit
 - [test?] Add commit.status, --status, and --no-status

Needs tests.

* mh/rebase-fixup (2009-12-07) 2 commits
  (merged to 'next' on 2010-01-06 at c4779a7)
 + Add a command "fixup" to rebase --interactive
 + t3404: Use test_commit to set up test repository
 (this branch is used by ns/rebase-auto-squash.)

Expecting further improvements to skip opening the editor if a pick is
followed only by "fixup" and no "squash".

* ns/rebase-auto-squash (2009-12-08) 1 commit
  (merged to 'next' on 2010-01-06 at da4e2f5)
 + rebase -i --autosquash: auto-squash commits
 (this branch uses mh/rebase-fixup.)

Blocked by the above.

* jh/notes (2009-12-07) 11 commits
 - Refactor notes concatenation into a flexible interface for combining=
 notes
 - Notes API: Allow multiple concurrent notes trees with new struct not=
es_tree
 - Notes API: for_each_note(): Traverse the entire notes tree with a ca=
llback
 - Notes API: get_note(): Return the note annotating the given object
 - Notes API: add_note(): Add note objects to the internal notes tree s=
tructure
 - Notes API: init_notes(): Initialize the notes tree from the given no=
tes ref
 - Notes API: get_commit_notes() -> format_note() + remove the commit r=
estriction
 - Minor style fixes to notes.c
  (merged to 'next' on 2010-01-02 at ae42130)
 + Add more testcases to test fast-import of notes
 + Rename t9301 to t9350, to make room for more fast-import tests
 + fast-import: Proper notes tree manipulation

http://thread.gmane.org/gmane.comp.version-control.git/134738

What's the status of the fourth and later patches on this topic?  Overa=
ll
it looked reasonable, if I recall correctly what I thought when I revie=
wed
it last time, and I am tempted to merge it to 'next' soonish.  Please
file complaints before I do so if people have objections.

Hold: JH on 2010-01-05, http://article.gmane.org/gmane.comp.version-con=
trol.git/136183

--------------------------------------------------
[Will graduate after a bit more cooking]

* nd/sparse (2010-01-04) 25 commits
  (merged to 'next' on 2010-01-10 at fa73d6e)
 + t7002: test for not using external grep on skip-worktree paths
 + t7002: set test prerequisite "external-grep" if supported
  (merged to 'next' on 2010-01-02 at 5499bbe)
 + grep: do not do external grep on skip-worktree entries
 + commit: correctly respect skip-worktree bit
 + ie_match_stat(): do not ignore skip-worktree bit with CE_MATCH_IGNOR=
E_VALID
 + tests: rename duplicate t1009
 + sparse checkout: inhibit empty worktree
 + Add tests for sparse checkout
 + read-tree: add --no-sparse-checkout to disable sparse checkout suppo=
rt
 + unpack-trees(): ignore worktree check outside checkout area
 + unpack_trees(): apply $GIT_DIR/info/sparse-checkout to the final ind=
ex
 + unpack-trees(): "enable" sparse checkout and load $GIT_DIR/info/spar=
se-checkout
 + unpack-trees.c: generalize verify_* functions
 + unpack-trees(): add CE_WT_REMOVE to remove on worktree alone
 + Introduce "sparse checkout"
 + dir.c: export excluded_1() and add_excludes_from_file_1()
 + excluded_1(): support exclude files in index
 + unpack-trees(): carry skip-worktree bit over in merged_entry()
 + Read .gitignore from index if it is skip-worktree
 + Avoid writing to buffer in add_excludes_from_file_1()
 + Teach Git to respect skip-worktree bit (writing part)
 + Teach Git to respect skip-worktree bit (reading part)
 + Introduce "skip-worktree" bit in index, teach Git to get/set this bi=
t
 + Add test-index-version
 + update-index: refactor mark_valid() in preparation for new options

I've queued the (close to) original tests for external grep, but as a b=
elt
and suspender measure Nguy=E1=BB=85n may also want to add the whitebox =
test
in the review thread.

* cc/reset-more (2010-01-08) 8 commits
  (merged to 'next' on 2010-01-10 at 84730de)
 + t7111: check that reset options work as described in the tables
  (merged to 'next' on 2010-01-06 at 96639cb)
 + Documentation: reset: add some missing tables
  (merged to 'next' on 2010-01-04 at 8802c2c)
 + Fix bit assignment for CE_CONFLICTED
  (merged to 'next' on 2010-01-03 at f83d4c6)
 + "reset --merge": fix unmerged case
 + reset: use "unpack_trees()" directly instead of "git read-tree"
 + reset: add a few tests for "git reset --merge"
 + Documentation: reset: add some tables to describe the different opti=
ons
 + reset: improve mixed reset error message when in a bare repo

* rs/maint-archive-match-pathspec (2009-12-12) 1 commit
  (merged to 'next' on 2010-01-03 at 92d7d15)
 + archive: complain about path specs that don't match anything

* il/vcs-helper (2010-01-09) 9 commits
  (merged to 'next' on 2010-01-10 at 11e448e)
 + Reset possible helper before reusing remote structure
  (merged to 'next' on 2010-01-06 at 7c79f42)
 + Remove special casing of http, https and ftp
 + Support remote archive from all smart transports
 + Support remote helpers implementing smart transports
 + Support taking over transports
 + Refactor git transport options parsing
 + Pass unknown protocols to external protocol handlers
 + Support mandatory capabilities
 + Add remote helper debug mode
 (this branch is used by js/exec-error-report.)

--------------------------------------------------
[Cooking]

* jc/maint-1.6.1-checkout-m-custom-merge (2010-01-06) 1 commit
  (merged to 'next' on 2010-01-10 at df14116)
 + checkout -m path: fix recreating conflicts

* jn/makefile (2010-01-06) 4 commits
  (merged to 'next' on 2010-01-10 at f5a5d42)
 + Makefile: consolidate .FORCE-* targets
 + Makefile: learn to generate listings for targets requiring special f=
lags
 + Makefile: use target-specific variable to pass flags to cc
 + Makefile: regenerate assembler listings when asked

* da/difftool (2010-01-09) 6 commits
  (merged to 'next' on 2010-01-10 at 749c870)
 + git-diff.txt: Link to git-difftool
 + difftool: Allow specifying unconfigured commands with --extcmd
 + difftool--helper: Remove use of the GIT_MERGE_TOOL variable
 + difftool--helper: Update copyright and remove distracting comments
  (merged to 'next' on 2010-01-06 at e957395)
 + git-difftool: Add '--gui' for selecting a GUI tool
 + t7800-difftool: Set a bogus tool for use by tests

* jh/gitweb-cached (2010-01-03) 4 commits
 - gitweb: Makefile improvements
 - gitweb: Optionally add "git" links in project list page
 - gitweb: Add option to force version match
 - gitweb: Load checking

Hold: Warthog on 2010-01-06, http://article.gmane.org/gmane.comp.versio=
n-control.git/136306

* tc/test-locate-httpd (2010-01-02) 1 commit
  (merged to 'next' on 2010-01-06 at 9d913e5)
 + t/lib-http.sh: Restructure finding of default httpd location

* jc/fix-tree-walk (2009-09-14) 7 commits
 - read-tree --debug-unpack
 - unpack-trees.c: look ahead in the index
 - unpack-trees.c: prepare for looking ahead in the index
 - Aggressive three-way merge: fix D/F case
 - traverse_trees(): handle D/F conflict case sanely
 - more D/F conflict tests
 - tests: move convenience regexp to match object names to test-lib.sh

Resurrected from "Ejected" category.  This is fix for a tricky codepath
and testing and improving before it hits 'next' by brave souls is great=
ly
appreciated (I am using this in my private build).

* jc/branch-d (2009-12-29) 1 commit
  (merged to 'next' on 2010-01-10 at 61a14b7)
 + branch -d: base the "already-merged" safety on the branch it merges =
with

* jc/rerere (2009-12-04) 1 commit
  (merged to 'next' on 2010-01-10 at e295b7f)
 + Teach --[no-]rerere-autoupdate option to merge, revert and friends

* jk/run-command-use-shell (2010-01-01) 8 commits
  (merged to 'next' on 2010-01-10 at 7479e2a)
 + t4030, t4031: work around bogus MSYS bash path conversion
 + diff: run external diff helper with shell
 + textconv: use shell to run helper
 + editor: use run_command's shell feature
 + run-command: optimize out useless shell calls
 + run-command: convert simple callsites to use_shell
 + t0021: use $SHELL_PATH for the filter script
 + run-command: add "use shell" option

Shuffled the commits in the topic, following J6t's suggestion in
http://thread.gmane.org/gmane.comp.version-control.git/136128

* tc/clone-v-progress (2009-12-26) 4 commits
  (merged to 'next' on 2010-01-10 at ec2bfd7)
 + clone: use --progress to force progress reporting
 + clone: set transport->verbose when -v/--verbose is used
 + git-clone.txt: reword description of progress behaviour
 + check stderr with isatty() instead of stdout when deciding to show p=
rogress

Perhaps needs an entry in the Release Notes, but otherwise looked Ok.

* tc/smart-http-restrict (2010-01-02) 4 commits
  (merged to 'next' on 2010-01-06 at 82736cb)
 + Smart-http tests: Test http-backend without curl or a webserver
 + Smart-http tests: Break test t5560-http-backend into pieces
 + Smart-http tests: Improve coverage in test t5560
 + Smart-http: check if repository is OK to export before serving it

* jc/cache-unmerge (2009-12-25) 9 commits
 - rerere forget path: forget recorded resolution
 - rerere: refactor rerere logic to make it independent from I/O
 - rerere: remove silly 1024-byte line limit
 - resolve-undo: teach "update-index --unresolve" to use resolve-undo i=
nfo
 - resolve-undo: "checkout -m path" uses resolve-undo information
 - resolve-undo: allow plumbing to clear the information
 - resolve-undo: basic tests
 - resolve-undo: record resolved conflicts in a new index extension sec=
tion
 - builtin-merge.c: use standard active_cache macros

Will wait a bit more before moving it to 'next'.  J6t spotted an issue
with "rerere forget" and has a test script.

* jc/checkout-merge-base (2010-01-07) 4 commits
  (merged to 'next' on 2010-01-07 at 5229608)
 + rebase -i: teach --onto A...B syntax
 + rebase: fix --onto A...B parsing and add tests
  (merged to 'next' on 2010-01-02 at 6a8f6fc)
 + "rebase --onto A...B" replays history on the merge base between A an=
d B
 + "checkout A...B" switches to the merge base between A and B

* tr/http-push-ref-status (2010-01-08) 6 commits
 - transport-helper.c::push_refs(): emit "no refs" error message
 - transport-helper.c::push_refs(): ignore helper-reported status if re=
f is not to be pushed
 - transport.c::transport_push(): make ref status affect return value
 - refactor ref status logic for pushing
 - t5541-http-push.sh: add test for unmatched, non-fast-forwarded refs
 - t5541-http-push.sh: add tests for non-fast-forward pushes

Rerolled.

* sr/gfi-options (2009-12-04) 7 commits
  (merged to 'next' on 2010-01-10 at 8b305fb)
 + fast-import: add (non-)relative-marks feature
 + fast-import: allow for multiple --import-marks=3D arguments
 + fast-import: test the new option command
 + fast-import: add option command
 + fast-import: add feature command
 + fast-import: put marks reading in its own function
 + fast-import: put option parsing code in separate functions
