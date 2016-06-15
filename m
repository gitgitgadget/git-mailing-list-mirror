From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Aug 2010, #01; Wed, 4)
Date: Wed, 04 Aug 2010 15:24:23 -0700
Message-ID: <7v62zqf23s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 05 00:24:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgmO6-0008J1-TP
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 00:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757316Ab0HDWYe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Aug 2010 18:24:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44077 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757135Ab0HDWYa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Aug 2010 18:24:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DE4C5CA8D1;
	Wed,  4 Aug 2010 18:24:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=YouBQ/07tZxrBNxiqgFxqpUvN
	LM=; b=iYmZqouoishZrhzOvFwXXoCyUEachO18avqL1GOURCWJYTYTJRZvjczeS
	Tm7VCrUc7jO/z3y7EUH60AHEQjDXTi5fMsiyuVyqRB1uqfZLmatFlh0KVzpk+wRs
	1YpnQy8uWv9MN4LZeeDM2r0X/S/2UBKnyDMcWTM9JdQ5BjduTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=WIHsuOPn23Vqk7MsvJS
	Q6qYp0oKpERxrWnwMklI9QJzxVnas4jBJQJTy7s9eGdt3IhzIjOUFvUy5vcV/r1e
	xiY3mNLlSSyLxzPMNDF7wwIB6Qe+jWKKFSlacdjbjoY+WQeDw6vGuMmc3WO+4JqI
	7axdwWcNa/gSDMZd9aKJao/I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C74DACA8D0;
	Wed,  4 Aug 2010 18:24:26 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ACAB9CA8CF; Wed,  4 Aug
 2010 18:24:24 -0400 (EDT)
X-master-at: 721e76cbfac650ce676fc789b717eb21e1daa46e
X-next-at: 7f78604dbfb7c90248f8142905329a97e26c8539
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0AA72612-A017-11DF-9562-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152607>

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I=
 am
still holding onto them.

The tip of 'next' has been rewound and rebuilt on top of v1.7.2; also a
few topics have been ejected as I've been warning to.  I'll start mergi=
ng
more stuff to 'next' in the next round after reading them over again.

--------------------------------------------------
[Graduated to "master"]

* gp/pack-refs-remove-empty-dirs (2010-07-06) 1 commit
  (merged to 'next' on 2010-07-14 at 7d25131)
 + pack-refs: remove newly empty directories

* pt/git-gui (2010-08-02) 13 commits
 + Merge git://repo.or.cz/git-gui into pt/git-gui
 + git-gui: fix size and position of window panes on startup
 + git-gui: mc cannot be used before msgcat has been loaded
 + git-gui: use textconv filter for diff and blame
 + git-gui: Avoid using the <<Copy>> binding as a menu accelerator on w=
in32
 + git-gui: fix shortcut creation on cygwin
 + git-gui: fix PATH environment for mingw development environment
 + git-gui: fix usage of _gitworktree when creating shortcut for window=
s
 + git-gui: fix "Explore Working Copy" for Windows again
 + git-gui: fix usage of themed widgets variable
 + git-gui: Handle failure of core.worktree to identify the working dir=
ectory.
 + Merge branch 'maint'
 + git-gui: check whether systems nice command works or disable it

* rr/svn-fe (2010-07-29) 2 commits
 + contrib/svn-fe: Add the svn-fe target to .gitignore
 + contrib/svn-fe: Fix IncludePath

* sv/maint-diff-q-clear-fix (2010-08-02) 1 commit
 + Fix DIFF_QUEUE_CLEAR refactoring

--------------------------------------------------
[New Topics]

* jc/sha1-name-find-fix (2010-08-02) 1 commit
 - sha1_name.c: fix parsing of ":/token" syntax

* jn/doc-pull (2010-08-02) 1 commit
 - Documentation: flesh out =E2=80=9Cgit pull=E2=80=9D description

* jn/maint-gitweb-dynconf (2010-07-30) 1 commit
 - gitweb: allow configurations that change with each request

* sr/local-config (2010-08-03) 1 commit
 - config: add --local option

--------------------------------------------------
[Stalled]

* zl/mailinfo-recode-patch (2010-06-14) 2 commits
 - add --recode-patch option to git-am
 - add --recode-patch option to git-mailinfo

I recall there was another round of re-roll planned for this one.

* jk/tag-contains (2010-07-05) 4 commits
 - Why is "git tag --contains" so slow?
 - default core.clockskew variable to one day
 - limit "contains" traversals based on commit timestamp
 - tag: speed up --contains calculation

--------------------------------------------------
[Cooking]

* ab/test-coverage (2010-07-26) 8 commits
 - Makefile: make gcov invocation configurable
 - t/README: Add a note about the dangers of coverage chasing
 - t/README: A new section about test coverage
 - Makefile: Add cover_db_html target
 - Makefile: Add cover_db target
 - Makefile: Split out the untested functions target
 - Makefile: Include subdirectories in "make cover" reports
 - gitignore: Ignore files generated by "make coverage"

* ab/test-no-skip (2010-07-28) 5 commits
 - t/README: Update "Skipping tests" to align with best practices
 - t/t7800-difftool.sh: Skip with prereq on no PERL
 - t/t5800-remote-helpers.sh: Skip with prereq on python <2.4
 - t/t4004-diff-rename-symlink.sh: use three-arg <prereq>
 - tests: implicitly skip SYMLINKS tests using <prereq>

* bc/use-more-hardlinks-in-install (2010-07-23) 2 commits
 - Makefile: make hard/symbolic links for non-builtins too
 - Makefile: link builtins residing in bin directory to main git binary=
 too

* cc/find-commit-subject (2010-07-22) 6 commits
 - blame: use find_commit_subject() instead of custom code
 - merge-recursive: use find_commit_subject() instead of custom code
 - bisect: use find_commit_subject() instead of custom code
 - revert: rename variables related to subject in get_message()
 - revert: refactor code to find commit subject in find_commit_subject(=
)
 - revert: fix off by one read when searching the end of a commit subje=
ct

* gb/shell-ext (2010-07-28) 3 commits
 - Add sample commands for git-shell
 - Add interactive mode to git-shell for user-friendliness
 - Allow creation of arbitrary git-shell commands

* jc/log-grep (2010-07-19) 1 commit
 - git log: add -G<regexp> that greps in the patch text

* jh/clean-exclude (2010-07-20) 2 commits
 - Add test for git clean -e.
 - Add -e/--exclude to git-clean.

* jh/use-test-must-fail (2010-07-20) 1 commit
 - Convert "! git" to "test_must_fail git"

* jn/apply-filename-with-sp (2010-07-23) 4 commits
 - apply: Handle traditional patches with space in filename
 - t4135 (apply): use expand instead of pr for portability
 - tests: Test how well "git apply" copes with weird filenames
 - apply: Split quoted filename handling into new function

* jn/fix-abbrev (2010-07-27) 3 commits
 - examples/commit: use --abbrev for commit summary
 - checkout, commit: remove confusing assignments to rev.abbrev
 - archive: abbreviate substituted commit ids again

* jn/maint-setup-fix (2010-07-24) 11 commits
 - setup: split off a function to handle ordinary .git directories
 - Revert "rehabilitate 'git index-pack' inside the object store"
 - setup: do not forget working dir from subdir of gitdir
 - t4111 (apply): refresh index before applying patches to it
 - setup: split off get_device_or_die helper
 - setup: split off a function to handle hitting ceiling in repo search
 - setup: split off code to handle stumbling upon a repository
 - setup: split off a function to checks working dir for .git file
 - setup: split off $GIT_DIR-set case from setup_git_directory_gently
 - tests: try git apply from subdir of toplevel
 - t1501 (rev-parse): clarify

* jn/rebase-rename-am (2008-11-10) 5 commits
 - rebase: protect against diff.renames configuration
 - t3400 (rebase): whitespace cleanup
 - Teach "apply --index-info" to handle rename patches
 - t4150 (am): futureproof against failing tests
 - t4150 (am): style fix

* ml/rebase-x-strategy (2010-07-29) 1 commit
 - rebase: support -X to pass through strategy options

* mm/shortopt-detached (2010-07-30) 5 commits
 - log: parse detached option for --glob
 - log: parse detached options like git log --grep foo
 - diff: parse detached options --stat-width n, --stat-name-width n
 - diff: split off a function for --stat-* option parsing
 - diff: parse detached options like -S foo

* nd/fix-sparse-checkout (2010-07-31) 5 commits
 - unpack-trees: mark new entries skip-worktree appropriately
 - unpack-trees: do not check for conflict entries too early
 - unpack-trees: let read-tree -u remove index entries outside sparse a=
rea
 - unpack-trees: only clear CE_UPDATE|CE_REMOVE when skip-worktree is a=
lways set
 - t1011 (sparse checkout): style nitpicks

* tr/ab-i18n-fix (2010-07-25) 1 commit
 - tests: locate i18n lib&data correctly under --valgrind
 (this branch uses ab/i18n.)

* tr/maint-no-unquote-plus (2010-07-24) 1 commit
 - Do not unquote + into ' ' in URLs

* tr/xsize-bits (2010-07-28) 1 commit
 - xsize_t: check whether we lose bits

* vs/doc-spell (2010-07-20) 1 commit
 - Documentation: spelling fixes

* ab/report-corrupt-object-with-type (2010-06-10) 1 commit
 - sha1_file: Show the the type and path to corrupt objects

* cc/revert (2010-07-21) 5 commits
 - t3508: add check_head_differs_from() helper function and use it
 - revert: improve success message by adding abbreviated commit sha1
 - revert: don't print "Finished one cherry-pick." if commit failed
 - revert: refactor commit code into a new run_git_commit() function
 - revert: report success when using option --strategy

* en/fast-export-fix (2010-07-17) 2 commits
 - fast-export: Add a --full-tree option
 - fast-export: Fix dropping of files with --import-marks and path limi=
ting

* jn/parse-date-basic (2010-07-15) 1 commit
 - Export parse_date_basic() to convert a date string to timestamp
 (this branch is used by rr/svn-export.)

* kf/post-receive-sample-hook (2010-07-16) 1 commit
 - post-receive-email: optional message line count limit

* tr/rfc-reset-doc (2010-07-18) 5 commits
 - Documentation/reset: move "undo permanently" example behind "make to=
pic"
 - Documentation/reset: reorder examples to match description
 - Documentation/reset: promote 'examples' one section up
 - Documentation/reset: separate options by mode
 - Documentation/git-reset: reorder modes for soft-mixed-hard progressi=
on

* rr/svn-export (2010-07-29) 9 commits
 - vcs-svn: Remove stray calls to removed functions
 - Add SVN dump parser
 - Add infrastructure to write revisions in fast-export format
 - Add stream helper library
 - Add string-specific memory pool
 - vcs-svn: treap_search should return NULL for missing items
 - Add treap implementation
 - Add memory pool library
 - Introduce vcs-svn lib
 (this branch uses jn/parse-date-basic.)

* hv/autosquash-config (2010-07-14) 1 commit
 - add configuration variable for --autosquash option of interactive re=
base

* jh/graph-next-line (2010-07-13) 2 commits
 - Enable custom schemes for column colors in the graph API
 - Make graph_next_line() available in the graph.h API

* ar/string-list-foreach (2010-07-03) 2 commits
 - Convert the users of for_each_string_list to for_each_string_list_it=
em macro
 - Add a for_each_string_list_item macro
 (this branch is used by tf/string-list-init.)

* il/rfc-remote-fd-ext (2010-07-31) 4 commits
 - Rewrite bidirectional traffic loop
 - gitignore: Ignore the new /git-remote-{ext,fd} helpers
 - New remote helper: git-remote-ext
 - New remote helper git-remote-fd

* hv/submodule-find-ff-merge (2010-07-07) 3 commits
 - Implement automatic fast-forward merge for submodules
 - setup_revisions(): Allow walking history in a submodule
 - Teach ref iteration module about submodules

* jn/fast-import-subtree (2010-06-30) 1 commit
 - Teach fast-import to import subtrees named by tree id

* sg/rerere-gc-old-still-used (2010-07-13) 2 commits
 - rerere: fix overeager gc
 - mingw_utime(): handle NULL times parameter

* tf/string-list-init (2010-07-04) 1 commit
 - string_list: Add STRING_LIST_INIT macro and make use of it.
 (this branch uses ar/string-list-foreach.)

* en/d-f-conflict-fix (2010-07-27) 7 commits
  (merged to 'next' on 2010-08-03 at 7f78604)
 + t/t6035-merge-dir-to-symlink.sh: Remove TODO on passing test
 + fast-import: Improve robustness when D->F changes provided in wrong =
order
 + fast-export: Fix output order of D/F changes
 + merge_recursive: Fix renames across paths below D/F conflicts
 + merge-recursive: Fix D/F conflicts
 + Add a rename + D/F conflict testcase
 + Add additional testcases for D/F conflicts

* ab/i18n (2010-07-19) 2 commits
 - tests: rename test to work around GNU gettext bug
 - Add infrastructure for translating Git with gettext
 (this branch is used by tr/ab-i18n-fix.)

* tc/checkout-B (2010-06-24) 3 commits
 - builtin/checkout: learn -B
 - builtin/checkout: reword hint for -b
 - add tests for checkout -b

* eb/double-convert-before-merge (2010-07-02) 3 commits
 - Don't expand CRLFs when normalizing text during merge
 - Try normalizing files to avoid delete/modify conflicts when merging
 - Avoid conflicts when merging branches with mixed normalization
