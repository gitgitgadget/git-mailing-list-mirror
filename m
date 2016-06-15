From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Aug 2010, #06; Thu, 26)
Date: Thu, 26 Aug 2010 21:37:20 -0700
Message-ID: <7vzkw8k6wv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 27 06:37:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ooqh7-0005lu-0H
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 06:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587Ab0H0Ehb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Aug 2010 00:37:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57163 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109Ab0H0Eh2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Aug 2010 00:37:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F08DD1526;
	Fri, 27 Aug 2010 00:37:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=3/kIuy/gV1YjZ5q+80Es3RCce
	7I=; b=fS37DKwkhIA8JGXAdij8F9NgBH6k97cqjX/uYwMdnYXmj0ezN00gCRm+6
	p4ZTTyzPzD1meMo85rqe4EoXFwjk7rPFnL+4wUkz2UYq/ybFb1YwGGneam7SqFga
	yGgb11GJHYICnUn7Qj/ww0xgbXY3erNvxvakPTDkQc/5kGijHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=oShJP2vh/ukSHAwM6TZ
	bndelDvsyR354Mr6b/5wYw7S138kzyfO7BzAAjSBUeIIYAb3ubUKWSRXe8A0/M6J
	oKLD23Mm16vLBaqhNlxlOf8OUWRE+bEHLZ/j4EC+E/4yb9uHWFYr+aA2IVK3gtjJ
	VABCqO9cDoamaTAhaD/Jb/Hs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5508ED1525;
	Fri, 27 Aug 2010 00:37:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7859DD1523; Fri, 27 Aug
 2010 00:37:22 -0400 (EDT)
X-master-at: 515cc0101943b766fde7aa894827119e332ec033
X-next-at: 7180a87c9a993afee64514d82f1e85dbacc8e120
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CA62A39E-B194-11DF-81C3-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154580>

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I=
 am
still holding onto them.

--------------------------------------------------
[New Topics]

* mg/doc-bundle (2010-08-23) 3 commits
  (merged to 'next' on 2010-08-23 at 2251a51)
 + git-bundle.txt: Clarify rev-list-args restrictions
 + git-bundle.txt: whitespace cleanup
 + git-bundle.txt: Cleanup

* bc/maint-fetch-url-only (2010-08-25) 2 commits
 - builtin/fetch.c: ignore merge config when not fetching from branch's=
 remote
 - t/t5510: demonstrate failure to fetch when current branch has merge =
ref

* jc/maint-doc-em-dash (2010-08-23) 1 commit
  (merged to 'next' on 2010-08-24 at 2e4d30b)
 + Work around em-dash handling in newer AsciiDoc

* jf/merge-ignore-ws (2010-08-26) 4 commits
 - merge-recursive: options to ignore whitespace changes
 - merge-recursive --patience
 - ll-merge: replace flag argument with options struct
 - merge-recursive: expose merge options for builtin merge
 (this branch uses eb/double-convert-before-merge, jn/merge-renormalize=
 and jn/merge-renormalize.)

* jk/maint-pass-c-config-in-env (2010-08-24) 2 commits
 - do not pass "git -c foo=3Dbar" params to transport helpers
 - pass "git -c foo=3Dbar" params through environment

* jl/submodule-ignore-diff (2010-08-25) 1 commit
  (merged to 'next' on 2010-08-26 at af1c819)
 + checkout: respect diff.ignoreSubmodules setting

* js/maint-reflog-beyond-horizon (2010-08-24) 3 commits
  (merged to 'next' on 2010-08-26 at 4281562)
 + rev-parse: tests git rev-parse --verify master@{n}, for various n
 + sha1_name.c: use warning in preference to fprintf(stderr
 + rev-parse: exit with non-zero status if ref@{n} is not valid.

* rr/fmt-merge-msg (2010-08-25) 3 commits
 - merge: Make 'merge.log' an integer or boolean option
 - merge: Make '--log' an integer option for number of shortlog entries
 - fmt_merge_msg: Change fmt_merge_msg API to accept shortlog_len
 (this branch uses jn/update-contrib-example-merge.)

* tr/merge-unborn-clobber (2010-08-22) 1 commit
 - Exhibit merge bug that clobbers index&WT

* en/object-list-with-pathspec (2010-08-26) 2 commits
 - Make rev-list --objects work together with pathspecs
 - Add testcases showing how pathspecs are ignored with rev-list --obje=
cts

* en/tree-walk-optim (2010-08-26) 4 commits
 - diff_tree(): Skip skip_uninteresting() when all remaining paths inte=
resting
 - tree_entry_interesting(): Make return value more specific
 - tree-walk: Correct bitrotted comment about tree_entry()
 - Document pre-condition for tree_entry_interesting

--------------------------------------------------
[Stalled]

* jc/log-grep (2010-08-23) 1 commit
 - git log: add -G<regexp> that greps in the patch text

This is broken, but haven't found any time to revisit it yet.

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

* jn/maint-doc-user-manual-html-doctype (2010-08-21) 2 commits
  (merged to 'next' on 2010-08-26 at e9084af)
 + docs: fix Makefile dependency for user manual
 + Documentation: set a !DOCTYPE for user manual

* cb/maint-mergetool-no-tty (2010-08-20) 1 commit
  (merged to 'next' on 2010-08-26 at b14989a)
 + mergetool: Remove explicit references to /dev/tty

* jn/doc-backslash (2010-08-20) 17 commits
  (merged to 'next' on 2010-08-23 at 8c364b2)
 + Documentation: remove stray backslash in show-branch discussion
 + Documentation: remove stray backslashes from "Fighting regressions" =
article
 + Documentation: do not convert ... operator to ellipses
 + Documentation: avoid stray backslash in user manual
 + Documentation: avoid stray backslashes in core tutorial
 + Documentation: remove stray backslashes in rev-parse manual
 + Documentation: remove backslash before ~ in fast-import manual
 + Documentation: remove stray backslash from "git bundle" manual
 + Documentation/technical: avoid stray backslash in parse-options API =
docs
 + Documentation: remove backslashes in manpage synopses
 + Documentation: clarify quoting in gitignore docs
 + Documentation: clarify quoting in "git rm" example
 + Documentation: add missing quotes to "git grep" examples
 + Documentation: clarify quoting in "git add" example
 + Documentation: unbreak regex in show-ref manual
 + Documentation: quoting trouble in "git rm" discussion
 + Documentation: tweak description of log.date

* nd/clone-depth-zero (2010-08-23) 1 commit
  (merged to 'next' on 2010-08-26 at b4491c3)
 + clone: warn users --depth is ignored in local clones

* cb/ignored-paths-are-precious (2010-08-21) 1 commit
 - checkout/merge: optionally fail operation when ignored files need to=
 be overwritten

I fixed up a trivial error in the configuration parser (which didn't
return immediately after parsing), and while at it flipped the default=20
value of the configuration and the command line option to false.

This probably needs tests; also we know of longstanding bugs in related
area that needs to be addressed---they do not have to be part of this
series but their reproduction recipe would belong to the test script fo=
r
this topic.

* np/maint-huge-delta-generation (2010-08-21) 1 commit
  (merged to 'next' on 2010-08-21 at 5af7003)
 + fix >4GiB source delta assertion failure

Will merge to 'master' shortly.

* jn/apply-filename-with-sp (2010-08-18) 3 commits
  (merged to 'next' on 2010-08-26 at 4f60840)
 + apply: handle traditional patches with space in filename
 + tests: exercise "git apply" with weird filenames
 + apply: split quoted filename handling into new function

* ab/maint-reset-mixed-w-pathspec-advice (2010-08-15) 1 commit
  (merged to 'next' on 2010-08-21 at b09ee46)
 + reset: suggest what to do upon "git reset --mixed <paths>"

Will merge to 'master' shortly.

* cb/binary-patch-id (2010-08-15) 1 commit
  (merged to 'next' on 2010-08-21 at ff38c3e)
 + hash binary sha1 into patch id

Will merge to 'master' shortly.

* jj/icase-directory (2010-08-16) 6 commits
  (merged to 'next' on 2010-08-26 at 9d8e1bc)
 + Support case folding in git fast-import when core.ignorecase=3Dtrue
 + Support case folding for git add when core.ignorecase=3Dtrue
 + Add case insensitivity support when using git ls-files
 + Add case insensitivity support for directories when using git status
 + Case insensitivity support for .gitignore via core.ignorecase
 + Add string comparison functions that respect the ignore_case variabl=
e.

* jn/cherry-revert-message-clean-up (2010-08-18) 5 commits
  (merged to 'next' on 2010-08-21 at 09b123c)
 + tests: fix syntax error in "Use advise() for hints" test
 + cherry-pick/revert: Use advise() for hints
 + cherry-pick/revert: Use error() for failure message
 + Introduce advise() to print hints
 + Eliminate =E2=80=9CFinished cherry-pick/revert=E2=80=9D message
 (this branch uses cc/revert.)

Will merge to 'master' shortly.

* jn/merge-custom-no-trivial (2010-08-23) 3 commits
  (merged to 'next' on 2010-08-24 at d9e5b2d)
 + t7606: Avoid using head as a file name
  (merged to 'next' on 2010-08-21 at 674498b)
 + merge: let custom strategies intervene in trivial merges
 + t7606 (merge-theirs): modernize style

* po/etc-gitattributes (2010-08-16) 1 commit
 - Add global and system-wide gitattributes

* ab/compat-regex (2010-08-26) 9 commits
  (merged to 'next' on 2010-08-26 at c5cc9d2)
 + Fix compat/regex ANSIfication on MinGW
  (merged to 'next' on 2010-08-22 at 40bce7c)
 + autoconf: regex library detection typofix
  (merged to 'next' on 2010-08-21 at 632d60f)
 + autoconf: don't use platform regex if it lacks REG_STARTEND
 + t/t7008-grep-binary.sh: un-TODO a test that needs REG_STARTEND
 + compat/regex: get rid of old-style definition
 + compat/regex: define out variables only used under RE_ENABLE_I18N
 + Change regerror() declaration from K&R style to ANSI C (C89)
 + compat/regex: get the gawk regex engine to compile within git
 + compat/regex: use the regex engine from gawk for compat

* da/fix-submodule-sync-superproject-config (2010-08-18) 1 commit
  (merged to 'next' on 2010-08-21 at e96772a)
 + submodule sync: Update "submodule.<name>.url"

Will merge to 'master' shortly.

* jn/update-contrib-example-merge (2010-08-17) 24 commits
  (merged to 'next' on 2010-08-21 at 41b5c4d)
 + merge script: learn --[no-]rerere-autoupdate
 + merge script: notice @{-1} shorthand
 + merge script: handle --no-ff --no-commit correctly
 + merge script: --ff-only to disallow true merge
 + merge script: handle many-way octopus
 + merge script: handle -m --log correctly
 + merge script: forbid merge -s index
 + merge script: allow custom strategies
 + merge script: merge -X<option>
 + merge script: improve log message subject
 + merge script: refuse to merge during merge
 + merge script: tweak unmerged files message to match builtin
 + merge script: --squash, --ff from unborn branch are errors
 + fmt-merge-msg -m to override merge title
 + merge-base --independent to print reduced parent list in a merge
 + merge-base --octopus to mimic show-branch --merge-base
 + Documentation: add a SEE ALSO section for merge-base
 + t6200 (fmt-merge-msg): style nitpicks
 + t6010 (merge-base): modernize style
 + t7600 (merge): test merge from branch yet to be born
 + t7600 (merge): check reflog entry
 + t7600 (merge): do not launch gitk for --debug
 + t7600 (merge): modernize style
 + merge: do not mistake (ancestor of) tag for branch
 (this branch is used by rr/fmt-merge-msg.)

* ab/test (2010-08-24) 49 commits
  (merged to 'next' on 2010-08-26 at fb6a7cf)
 + tests: simplify "missing PREREQ" message
 + t/t0000-basic.sh: Run the passing TODO test inside its own test-lib
 + test-lib: Allow overriding of TEST_DIRECTORY
 + test-lib: Use "$GIT_BUILD_DIR" instead of "$TEST_DIRECTORY"/../
 + test-lib: Use $TEST_DIRECTORY or $GIT_BUILD_DIR instead of $(pwd) an=
d ../
 + Merge branch 'ab/i18n' into ab/test-1
  (merged to 'next' on 2010-08-18 at f88bdb1)
 + cvs tests: do not touch test CVS repositories shipped with source
 + t/t9602-cvsimport-branches-tags.sh: Add a PERL prerequisite
 + t/t9601-cvsimport-vendor-branch.sh: Add a PERL prerequisite
 + t/t7105-reset-patch.sh: Add a PERL prerequisite
 + t/t9001-send-email.sh: convert setup code to tests
 + t/t9001-send-email.sh: change from skip_all=3D* to prereq skip
 + t/t9001-send-email.sh: Remove needless PROG=3D* assignment
 + t/t9600-cvsimport.sh: change from skip_all=3D* to prereq skip
 + lib-patch-mode tests: change from skip_all=3D* to prereq skip
 + t/t3701-add-interactive.sh: change from skip_all=3D* to prereq skip
 + tests: Move FILEMODE prerequisite to lib-prereq-FILEMODE.sh
 + t/Makefile: Create test-results dir for smoke target
 + git-notes: Run partial expensive test everywhere
 + t/t3300-funny-names: change from skip_all=3D* to prereq skip
 + t/t3902-quoted: change from skip_all=3D* to prereq skip
 + t/t4016-diff-quote: change from skip_all=3D* to prereq skip
 + t/t5503-tagfollow: change from skip_all=3D* to prereq skip
 + t/t7005-editor: change from skip_all=3D* to prereq skip
 + t/t5705-clone-2gb: change from skip_all=3D* to prereq skip
 + t/t1304-default-acl: change from skip_all=3D* to prereq skip
 + t/README: Update "Skipping tests" to align with best practices
 + t/t7800-difftool.sh: Skip with prereq on no PERL
 + t/t5800-remote-helpers.sh: Skip with prereq on python <2.4
 + t/t4004-diff-rename-symlink.sh: use three-arg <prereq>
 + tests: implicitly skip SYMLINKS tests using <prereq>
 + Makefile: make gcov invocation configurable
 + t/README: Add a note about the dangers of coverage chasing
 + t/README: A new section about test coverage
 + Makefile: Add cover_db_html target
 + Makefile: Add cover_db target
 + Makefile: Split out the untested functions target
 + Makefile: Include subdirectories in "make cover" reports
 + gitignore: Ignore files generated by "make coverage"
 + t/README: Add SMOKE_{COMMENT,TAGS}=3D to smoke_report target
 + t/Makefile: Can't include GIT-BUILD-OPTIONS, it's a .sh
 + t/README: Document the Smoke testing
 + tests: Infrastructure for Git smoke testing
 + test-lib: Multi-prereq support only checked the last prereq
 + tests: A SANITY test prereq for testing if we're root
 + t/README: Document the predefined test prerequisites
 + test-lib: Print missing prerequisites in test output
 + test-lib: Add support for multiple test prerequisites
 + test-lib: Don't write test-results when HARNESS_ACTIVE
 (this branch uses ab/i18n.)

* dj/fetch-tagopt (2010-08-11) 1 commit
  (merged to 'next' on 2010-08-21 at 737dfec)
 + fetch: allow command line --tags to override config

Will merge to 'master' shortly.

* jn/paginate-fix (2010-08-16) 14 commits
  (merged to 'next' on 2010-08-18 at bb04a13)
 + t7006 (pager): add missing TTY prerequisites
 + merge-file: run setup_git_directory_gently() sooner
 + var: run setup_git_directory_gently() sooner
 + ls-remote: run setup_git_directory_gently() sooner
 + index-pack: run setup_git_directory_gently() sooner
 + Merge branch 'jn/maint-setup-fix' (early part) into jn/paginate-fix
 + config: run setup_git_directory_gently() sooner
 + bundle: run setup_git_directory_gently() sooner
 + apply: run setup_git_directory_gently() sooner
 + grep: run setup_git_directory_gently() sooner
 + shortlog: run setup_git_directory_gently() sooner
 + git wrapper: allow setup_git_directory_gently() be called earlier
 + setup: remember whether repository was found
 + git wrapper: introduce startup_info struct
 (this branch uses jn/maint-setup-fix.)

Will merge to 'master' shortly.

* jn/merge-renormalize (2010-08-05) 12 commits
  (merged to 'next' on 2010-08-18 at d9aa77b)
 + merge-recursive --renormalize
 + rerere: never renormalize
 + rerere: migrate to parse-options API
 + t4200 (rerere): modernize style
 + ll-merge: let caller decide whether to renormalize
 + ll-merge: make flag easier to populate
 + Documentation/technical: document ll_merge
 + merge-trees: let caller decide whether to renormalize
 + merge-trees: push choice to renormalize away from low level
 + t6038 (merge.renormalize): check that it can be turned off
 + t6038 (merge.renormalize): try checkout -m and cherry-pick
 + t6038 (merge.renormalize): style nitpicks
 (this branch is used by jf/merge-ignore-ws and jf/merge-ignore-ws; use=
s eb/double-convert-before-merge.)

* eb/double-convert-before-merge (2010-07-02) 3 commits
 + Don't expand CRLFs when normalizing text during merge
 + Try normalizing files to avoid delete/modify conflicts when merging
 + Avoid conflicts when merging branches with mixed normalization
 (this branch is used by jf/merge-ignore-ws and jn/merge-renormalize.)

* by/line-log (2010-08-11) 17 commits
  (merged to 'next' on 2010-08-26 at a160ff1)
 + Document line history browser
 + Add tests for line history browser
 + Add --full-line-diff option
 + Add --graph prefix before line history output
 + Add parent rewriting to line history browser
 + Make graph_next_line external to other part of git
 + Make rewrite_parents public to other part of git
 + Hook line history into cmd_log, ensuring a topo-ordered walk
 + Print the line log
 + map/take range to the parent of commits
 + Add range clone functions
 + Export three functions from diff.c
 + Parse the -L options
 + Refactor parse_loc
 + Add the basic data structure for line level history
 + parse-options: add two helper functions
 + parse-options: enhance STOP_AT_NON_OPTION

Not entirely happy with the command line parser, but will merge to 'nex=
t'
after giving the series another look.

* jn/svn-fe (2010-08-19) 17 commits
  (merged to 'next' on 2010-08-19 at b1a242a)
 + t/t9010-svn-fe.sh: add an +x bit to this test
  (merged to 'next' on 2010-08-18 at 24ab19e)
 + t9010 (svn-fe): avoid symlinks in test
 + t9010 (svn-fe): use Unix-style path in URI
 + vcs-svn: Avoid %z in format string
 + vcs-svn: Rename dirent pool to build on Windows
 + compat: add strtok_r()
 + treap: style fix
 + vcs-svn: remove build artifacts on "make clean"
 + svn-fe manual: Clarify warning about deltas in dump files
 + Update svn-fe manual
 + SVN dump parser
 + Infrastructure to write revisions in fast-export format
 + Add stream helper library
 + Add string-specific memory pool
 + Add treap implementation
 + Add memory pool library
 + Introduce vcs-svn lib

Will merge to 'master' shortly.

* js/detached-stash (2010-08-21) 9 commits
  (merged to 'next' on 2010-08-26 at 7180a87)
 + detached-stash: update Documentation
 + detached-stash: tests of git stash with stash-like arguments
 + detached-stash: simplify git stash show
 + detached-stash: simplify git stash branch
 + detached-stash: refactor git stash pop implementation
 + detached-stash: simplify stash_drop
 + detached-stash: simplify stash_apply
 + detached-stash: work around git rev-parse failure to detect bad log =
refs
 + detached-stash: introduce parse_flags_and_revs function

* gb/shell-ext (2010-08-24) 4 commits
  (merged to 'next' on 2010-08-24 at 49ea7b8)
 + shell: Rewrite documentation and improve error message
 + Add sample commands for git-shell
 + Add interactive mode to git-shell for user-friendliness
 + Allow creation of arbitrary git-shell commands

I am not very happy about adding these backdoors to git-shell, which is
primarily a security mechanism, and obviously security and backdoor do =
not
mix well.

* jn/maint-setup-fix (2010-07-24) 11 commits
  (merged to 'next' on 2010-08-18 at ded5f4d)
 + setup: split off a function to handle ordinary .git directories
 + Revert "rehabilitate 'git index-pack' inside the object store"
 + setup: do not forget working dir from subdir of gitdir
 + t4111 (apply): refresh index before applying patches to it
 + setup: split off get_device_or_die helper
 + setup: split off a function to handle hitting ceiling in repo search
 + setup: split off code to handle stumbling upon a repository
 + setup: split off a function to checks working dir for .git file
 + setup: split off $GIT_DIR-set case from setup_git_directory_gently
 + tests: try git apply from subdir of toplevel
 + t1501 (rev-parse): clarify
 (this branch is used by jn/paginate-fix.)

Will merge to 'master' shortly.

* tr/maint-no-unquote-plus (2010-07-24) 1 commit
  (merged to 'next' on 2010-08-18 at b811248)
 + Do not unquote + into ' ' in URLs

I think this one is safe in the context of git (namely smart-http
interface).

Will merge to 'master' shortly.

* cc/revert (2010-07-21) 5 commits
  (merged to 'next' on 2010-08-14 at a910d5a)
 + t3508: add check_head_differs_from() helper function and use it
 + revert: improve success message by adding abbreviated commit sha1
 + revert: don't print "Finished one cherry-pick." if commit failed
 + revert: refactor commit code into a new run_git_commit() function
 + revert: report success when using option --strategy
 (this branch is used by jn/cherry-revert-message-clean-up.)

* en/fast-export-fix (2010-07-17) 2 commits
  (merged to 'next' on 2010-08-18 at 9fdaf27)
 + fast-export: Add a --full-tree option
 + fast-export: Fix dropping of files with --import-marks and path limi=
ting

Will merge to 'master' shortly.

* hv/autosquash-config (2010-07-14) 1 commit
  (merged to 'next' on 2010-08-18 at 03a8eec)
 + add configuration variable for --autosquash option of interactive re=
base

Will merge to 'master' shortly.

* il/rfc-remote-fd-ext (2010-08-14) 6 commits
 - Fix build on Windows
 - Simplify send_git_request()
 - Rewrite bidirectional traffic loop
 - gitignore: Ignore the new /git-remote-{ext,fd} helpers
 - New remote helper: git-remote-ext
 - New remote helper git-remote-fd

* sg/rerere-gc-old-still-used (2010-07-13) 2 commits
  (merged to 'next' on 2010-08-18 at 8bc4635)
 + rerere: fix overeager gc
 + mingw_utime(): handle NULL times parameter

Will merge to 'master' shortly.

* en/d-f-conflict-fix (2010-08-20) 12 commits
  (merged to 'next' on 2010-08-20 at af7f2b0)
 + merge-recursive: Avoid excessive output for and reprocessing of rena=
mes
  (merged to 'next' on 2010-08-18 at 6be0f13)
 + merge-recursive: Fix multiple file rename across D/F conflict
 + t6031: Add a testcase covering multiple renames across a D/F conflic=
t
 + merge-recursive: Fix typo
  (merged to 'next' on 2010-08-14 at 1c9b0f5)
 + Mark tests that use symlinks as needing SYMLINKS prerequisite
  (merged to 'next' on 2010-08-03 at 7f78604)
 + t/t6035-merge-dir-to-symlink.sh: Remove TODO on passing test
 + fast-import: Improve robustness when D->F changes provided in wrong =
order
 + fast-export: Fix output order of D/F changes
 + merge_recursive: Fix renames across paths below D/F conflicts
 + merge-recursive: Fix D/F conflicts
 + Add a rename + D/F conflict testcase
 + Add additional testcases for D/F conflicts

Will merge to 'master' shortly.

* ab/i18n (2010-07-25) 4 commits
 + tests: locate i18n lib&data correctly under --valgrind
 + gettext: setlocale(LC_CTYPE, "") breaks Git's C function assumptions
 + tests: rename test to work around GNU gettext bug
 + Add infrastructure for translating Git with gettext
 (this branch is used by ab/test.)
