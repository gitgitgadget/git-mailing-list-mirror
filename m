From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2011, #06; Sun, 27)
Date: Sun, 27 Feb 2011 22:48:32 -0800
Message-ID: <7vy650k62n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 28 07:48:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtwuS-0000BT-Qs
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 07:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581Ab1B1Gsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 01:48:39 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40573 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179Ab1B1Gsi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 01:48:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 89F982A11;
	Mon, 28 Feb 2011 01:49:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=3cP6
	1pWNdHqAIUY8SzRMM/6Hk3Y=; b=mQcmi3PVmYg7AAdXU5/SoTWei7SCNmbDFTgf
	9h4s1rzIFvwIs4gJGY9M8YIO+9BoswuLWqp7x8A2+H9z7GmGfKWn355fy6a2NZQB
	60hOMziSjpn/zmC+6+A3+2BgUbkqajA22pjPAdMHr1oali7ICluf7XubD3bmBgy7
	j75KJdE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Si3
	cvQanyqwEQlxd4Pvuy/DH1WQTT29YWJGSj1hWchHBZ9j18zc8M2AzlRfg0QwyPg2
	0ZJtdIavGnhNx/3IEKSqlfmxd7EIyEsfIufmaQdLQ5R+0WrEUU+tXjxQ7ZjKLF2d
	VPgHxGwaIjojsz2LZG3VMy2u/8sacMTZ4TQBbtU0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7860B2A10;
	Mon, 28 Feb 2011 01:49:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 358D82A0F; Mon, 28 Feb 2011
 01:49:51 -0500 (EST)
X-master-at: 8978166e531e0941811099d4117574ebbbcf35d8
X-next-at: 4aa7278540f2c67a375cee26edfb39164695d3e8
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F2DCEFBA-4306-11E0-B1B9-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168070>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

--------------------------------------------------
[Graduated to "master"]

* en/object-list-with-pathspec (2010-09-20) 2 commits
  (merged to 'next' on 2011-02-09 at ccf6c6a)
 + Add testcases showing how pathspecs are handled with rev-list --objects
 + Make rev-list --objects work together with pathspecs
 (this branch uses nd/struct-pathspec; is tangled with jc/grep--no-index-pathspec-fix.)

* hv/mingw-fs-funnies (2011-02-07) 5 commits
  (merged to 'next' on 2011-02-09 at 3d0bb1a)
 + mingw_rmdir: set errno=ENOTEMPTY when appropriate
 + mingw: add fallback for rmdir in case directory is in use
 + mingw: make failures to unlink or move raise a question
 + mingw: work around irregular failures of unlink on windows
 + mingw: move unlink wrapper to mingw.c

* jh/push-default-upstream-configname (2011-02-16) 1 commit
  (merged to 'next' on 2011-02-23 at b5c25fa)
 + push.default: Rename 'tracking' to 'upstream'

* js/detach-doc (2011-02-20) 1 commit
  (merged to 'next' on 2011-02-21 at c384c3c)
 + git-checkout.txt: improve detached HEAD documentation

* js/maint-merge-use-prepare-commit-msg-hook (2011-02-14) 1 commit
  (merged to 'next' on 2011-02-22 at 6458c4b)
 + merge: honor prepare-commit-msg hook

* lp/config-vername-check (2011-02-01) 2 commits
  (merged to 'next' on 2011-02-23 at 426d48d)
 + Disallow empty section and variable names
 + Sanity-check config variable names

* mg/patch-id (2011-02-17) 2 commits
  (merged to 'next' on 2011-02-22 at 6f4acd8)
 + git-patch-id: do not trip over "no newline" markers
 + git-patch-id: test for "no newline" markers

* mg/placeholders-are-lowercase (2011-02-17) 5 commits
  (merged to 'next' on 2011-02-22 at 2754e21)
 + Make <identifier> lowercase in Documentation
 + Make <identifier> lowercase as per CodingGuidelines
 + Make <identifier> lowercase as per CodingGuidelines
 + Make <identifier> lowercase as per CodingGuidelines
 + CodingGuidelines: downcase placeholders in usage messages

* mo/perl-bidi-pipe-envfix (2011-02-15) 1 commit
  (merged to 'next' on 2011-02-15 at c36e816)
 + perl: command_bidi_pipe() method should set-up git environmens

* mz/rerere-remaining (2011-02-16) 2 commits
  (merged to 'next' on 2011-02-22 at fa2d5ab)
 + mergetool: don't skip modify/remove conflicts
 + rerere "remaining"

* nd/hash-object-sanity (2011-02-05) 1 commit
  (merged to 'next' on 2011-02-22 at 09acf6f)
 + Make hash-object more robust against malformed objects

* nd/sorted-builtin-command-list (2011-02-15) 1 commit
  (merged to 'next' on 2011-02-22 at 91fccd1)
 + git.c: reorder builtin command list

* nd/struct-pathspec (2011-01-31) 22 commits
  (merged to 'next' on 2011-02-09 at b1e64ee)
 + t6004: add pathspec globbing test for log family
 + t7810: overlapping pathspecs and depth limit
 + grep: drop pathspec_matches() in favor of tree_entry_interesting()
 + grep: use writable strbuf from caller for grep_tree()
 + grep: use match_pathspec_depth() for cache/worktree grepping
 + grep: convert to use struct pathspec
 + Convert ce_path_match() to use match_pathspec_depth()
 + Convert ce_path_match() to use struct pathspec
 + struct rev_info: convert prune_data to struct pathspec
 + pathspec: add match_pathspec_depth()
 + tree_entry_interesting(): optimize wildcard matching when base is matched
 + tree_entry_interesting(): support wildcard matching
 + tree_entry_interesting(): fix depth limit with overlapping pathspecs
 + tree_entry_interesting(): support depth limit
 + tree_entry_interesting(): refactor into separate smaller functions
 + diff-tree: convert base+baselen to writable strbuf
 + glossary: define pathspec
 + Move tree_entry_interesting() to tree-walk.c and export it
 + tree_entry_interesting(): remove dependency on struct diff_options
 + Convert struct diff_options to use struct pathspec
 + diff-no-index: use diff_tree_setup_paths()
 + Add struct pathspec
 (this branch is used by en/object-list-with-pathspec and jc/grep--no-index-pathspec-fix.)

* pw/p4 (2011-02-19) 8 commits
  (merged to 'next' on 2011-02-21 at 1a7b7d2)
 + git-p4: support clone --bare
 + git-p4: decode p4 wildcard characters
 + git-p4: better message for "git-p4 sync" when not cloned
 + git-p4: reinterpret confusing p4 message
 + git-p4: accommodate new move/delete type in p4
 + git-p4: add missing newline in initial import message
 + git-p4: fix key error for p4 problem
 + git-p4: test script

* sp/maint-smart-http-sans-100-continue (2011-02-15) 1 commit
  (merged to 'next' on 2011-02-15 at 553e3e5)
 + smart-http: Don't use Expect: 100-Continue

* uk/checkout-ambiguous-ref (2011-02-15) 5 commits
  (merged to 'next' on 2011-02-15 at 645dad6)
 + Rename t2019 with typo "amiguous" that meant "ambiguous"
 + checkout: rearrange update_refs_for_switch for clarity
 + checkout: introduce --detach synonym for "git checkout foo^{commit}"
 + checkout: split off a function to peel away branchname arg
  (merged to 'next' on 2011-02-03 at 9044724)
 + checkout: fix bug with ambiguous refs

* va/p4 (2011-02-20) 2 commits
  (merged to 'next' on 2011-02-21 at d981b23)
 + git-p4: Add copy detection support
 + git-p4: Improve rename detection support

--------------------------------------------------
[New Topics]

* jn/maint-commit-missing-template (2011-02-25) 1 commit
  (merged to 'next' on 2011-02-25 at c95589d)
 + commit: error out for missing commit message template

* mg/maint-difftool-vim-readonly (2011-02-25) 1 commit
  (merged to 'next' on 2011-02-25 at 990579c)
 + mergetool-lib: call vim in readonly mode for diffs

* fk/maint-cvsimport-early-failure (2011-01-31) 1 commit
 - git-cvsimport.perl: Bail out right away when reading from the server fails

* jk/strbuf-vaddf (2011-02-25) 2 commits
 - strbuf: add strbuf_vaddf
 - compat: provide a fallback va_copy definition
 (this branch is used by ab/i18n-st, jk/trace-sifter and jn/status-translatable.)

* jk/trace-sifter (2011-02-24) 6 commits
 - trace: give repo_setup trace its own key
 - add packet tracing debug code
 - trace: add trace_strbuf
 - trace: factor out "do we want to trace" logic
 - trace: refactor to support multiple env variables
 - trace: add trace_vprintf
 (this branch uses jk/strbuf-vaddf; is tangled with ab/i18n-st and jn/status-translatable.)

* jn/maint-instaweb-plack-fix (2011-02-26) 1 commit
 - git-instaweb: Change how gitweb.psgi is made runnable as standalone app

* jn/status-translatable (2011-02-25) 3 commits
 - commit, status: use status_printf{,_ln,_more} helpers
 - commit: refer to commit template as s->fp
 - wt-status: add helpers for printing wt-status lines
 (this branch is used by ab/i18n-st and ab/i18n-st; uses jk/strbuf-vaddf; is tangled with jk/trace-sifter.)

* mh/p4 (2011-02-25) 1 commit
  (merged to 'next' on 2011-02-26 at 1693331)
 + git-p4 submit: prevent 'Jobs' section from being removed from p4 change log

* nd/rfc-add-u-full-tree (2011-02-07) 1 commit
 - add: make "add -u" update full tree without pathspec

* ss/git-gui-mergetool (2011-02-26) 2 commits
 - mergetool--lib: Add Beyond Compare 3 as a tool
 - mergetool--lib: Sort tools alphabetically for easier lookup

* ss/mergetool--lib (2011-02-27) 2 commits
 - mergetool--lib: Add Beyond Compare 3 as a tool
 - mergetool--lib: Sort tools alphabetically for easier lookup

--------------------------------------------------
[Stalled]

* jh/merge-sans-branch (2011-02-10) 4 commits
 . merge: add support for merging from upstream by default
 - merge: introduce per-branch-configuration helper function
 - merge: introduce setup_merge_commit helper function
 - merge: update the usage information to be more modern

There was an objection to the tip one that determines the upstream in a
wrong way?

* jk/tag-contains (2010-07-05) 4 commits
 - Why is "git tag --contains" so slow?
 - default core.clockskew variable to one day
 - limit "contains" traversals based on commit timestamp
 - tag: speed up --contains calculation

The idea of the bottom one is probably Ok, except that the use of object
flags needs to be rethought, or at least the helper needs to be moved to
builtin/tag.c to make it clear that it should not be used outside the
current usage context.

* jc/rename-degrade-cc-to-c (2011-01-06) 3 commits
 . diffcore-rename: fall back to -C when -C -C busts the rename limit
 . diffcore-rename: record filepair for rename src
 . diffcore-rename: refactor "too many candidates" logic

--------------------------------------------------
[Cooking]

* nd/index-doc (2010-09-06) 1 commit
 - doc: technical details about the index file format

* ab/i18n-st (2011-02-22) 74 commits
 - i18n: git-shortlog basic messages
 - i18n: git-revert split up "could not revert/apply" message
 - i18n: git-revert literal "me" messages
 - i18n: git-revert "Your local changes" message
 - i18n: git-revert basic messages
 - i18n: git-notes GIT_NOTES_REWRITE_MODE error message
 - i18n: git-notes basic commands
 - i18n: git-gc "Auto packing the repository" message
 - i18n: git-gc basic messages
 - i18n: git-describe basic messages
 - i18n: git-clean clean.requireForce messages
 - i18n: git-clean basic messages
 - i18n: git-bundle basic messages
 - i18n: git-archive basic messages
 - i18n: git-status "renamed: " message
 - i18n: git-status "Initial commit" message
 - i18n: git-status "Changes to be committed" message
 - i18n: git-status shortstatus messages
 - i18n: git-status "nothing to commit" messages
 - i18n: git-status basic messages
 - i18n: git-push "prevent you from losing" message
 - i18n: git-push basic messages
 - i18n: git-tag tag_template message
 - i18n: git-tag basic messages
 - i18n: git-reset "Unstaged changes after reset" message
 - i18n: git-reset reset_type_names messages
 - i18n: git-reset basic messages
 - i18n: git-rm basic messages
 - i18n: git-mv "bad" messages
 - i18n: git-mv basic messages
 - i18n: git-merge "Wonderful" message
 - i18n: git-merge "You have not concluded your merge" messages
 - i18n: git-merge "Updating %s..%s" message
 - i18n: git-merge basic messages
 - i18n: git-log "--OPT does not make sense" messages
 - i18n: git-log basic messages
 - i18n: git-grep "--open-files-in-pager" message
 - i18n: git-grep basic messages
 - i18n: git-fetch split up "(non-fast-forward)" message
 - i18n: git-fetch update_local_ref messages
 - i18n: git-fetch formatting messages
 - i18n: git-fetch basic messages
 - i18n: git-diff basic messages
 - i18n: git-commit advice messages
 - i18n: git-commit "enter the commit message" message
 - i18n: git-commit print_summary messages
 - i18n: git-commit formatting messages
 - i18n: git-commit "middle of a merge" message
 - i18n: git-commit basic messages
 - i18n: git-checkout "Switched to a .. branch" message
 - i18n: git-checkout "HEAD is now at" message
 - i18n: git-checkout describe_detached_head messages
 - i18n: git-checkout: our/their version message
 - i18n: git-checkout basic messages
 - i18n: git-branch "(no branch)" message
 - i18n: git-branch "git branch -v" messages
 - i18n: git-branch "Deleted branch [...]" message
 - i18n: git-branch "remote branch '%s' not found" message
 - i18n: git-branch basic messages
 - i18n: git-add "Unstaged changes" message
 - i18n: git-add "remove '%s'" message
 - i18n: git-add "did not match any files" message
 - i18n: git-add "The following paths are ignored" message
 - i18n: git-add basic messages
 - i18n: git-clone "Cloning into" message
 - i18n: git-clone "Cloning into" message
 - i18n: git-clone basic messages
 - i18n: git-init "Initialized [...] repository" message
 - i18n: git-init basic messages
 - i18n: "make distclean" should clean up after "make pot"
 - i18n: Makefile: "pot" target to extract messages marked for translation
 - i18n: do not poison translations unless GIT_GETTEXT_POISON envvar is set
 - i18n: add GETTEXT_POISON to simulate unfriendly translator
 - i18n: add no-op _() and N_() wrappers
 (this branch uses jk/strbuf-vaddf, jn/status-translatable and jn/status-translatable; is tangled with jk/trace-sifter.)

Rebased on other infrastructure adjustments (tentatively renamed the
branch).  I'd like to fast-track the basics (especially the bottom 3
patches), and am even tempted to rebase other patches on 'pu' that are not
yet in 'next' on top of them, to make the transition easier.

* gr/cvsimport-alternative-cvspass-location (2011-02-18) 1 commit
 - Look for password in both CVS and CVSNT password files.

* jc/checkout-orphan-warning (2011-02-18) 1 commit
 - commit: give final warning when reattaching HEAD to leave commits behind

Likes, dislikes?

* jh/maint-do-not-track-non-branches (2011-02-17) 1 commit
 - branch/checkout --track: Ensure that upstream branch is indeed a branch

* jk/diffstat-binary (2011-02-19) 2 commits
  (merged to 'next' on 2011-02-23 at 49da967)
 + diff: don't retrieve binary blobs for diffstat
 + diff: handle diffstat of rewritten binary files

* jk/fail-null-clone (2011-02-17) 1 commit
  (merged to 'next' on 2011-02-23 at a4217f5)
 + clone: die when trying to clone missing local path

* jk/merge-rename-ux (2011-02-20) 6 commits
 - pull: propagate --progress to merge
 - merge: enable progress reporting for rename detection
 - add inexact rename detection progress infrastructure
 - commit: stop setting rename limit
 - bump rename limit defaults (again)
 - merge: improve inexact rename limit warning

The above three all seemed sensible improvements.

* jn/test-terminal-punt-on-osx-breakage (2011-02-17) 1 commit
  (merged to 'next' on 2011-02-23 at d754139)
 + tests: skip terminal output tests on OS X

* js/cherry-pick-usability (2011-02-19) 4 commits
  (merged to 'next' on 2011-02-23 at 95db30e)
 + Teach commit about CHERRY_PICK_HEAD
 + bash: teach __git_ps1 about CHERRY_PICK_HEAD
 + Introduce CHERRY_PICK_HEAD
 + t3507: introduce pristine-detach helper

* lt/rename-no-extra-copy-detection (2011-02-18) 3 commits
  (merged to 'next' on 2011-02-23 at 2c1f271)
 + diffcore-rename: improve estimate_similarity() heuristics
 + diffcore-rename: properly honor the difference between -M and -C
 + for_each_hash: allow passing a 'void *data' pointer to callback

* mg/rev-list-one-side-only (2011-02-22) 6 commits
 - t6007: test rev-list --cherry
 - log --cherry: a synonym
 - rev-list: --left/right-only are mutually exclusive
 - rev-list: documentation and test for --left/right-only
 - t6007: Make sure we test --cherry-pick
 - revlist.c: introduce --left/right-only for unsymmetric picking

* so/submodule-no-update-first-time (2011-02-17) 2 commits
  (merged to 'next' on 2011-02-23 at 2c6e8c9)
 + t7406: "git submodule update {--merge|--rebase]" with new submodules
 + submodule: no [--merge|--rebase] when newly cloned

* jc/complete-symmetric-diff (2011-02-23) 1 commit
 - completion: complete "git diff ...branc<TAB>"

* jh/submodule-fetch-on-demand (2011-02-23) 6 commits
 - submodule update: Don't fetch when the submodule commit is already present
 - fetch/pull: Don't recurse into a submodule when commits are already present
 - Submodules: Add 'on-demand' value for the 'fetchRecurseSubmodule' option
 - config: teach the fetch.recurseSubmodules option the 'on-demand' value
 - fetch/pull: Add the 'on-demand' value to the --recurse-submodules option
 - fetch/pull: recurse into submodules when necessary

* jk/format-patch-multiline-header (2011-02-23) 3 commits
 - format-patch: rfc2047-encode newlines in headers
 - format-patch: wrap long header lines
 - strbuf: add fixed-length version of add_wrapped_text

* js/checkout-untracked-symlink (2011-02-20) 2 commits
  (merged to 'next' on 2011-02-23 at 52a35ce)
 + do not overwrite untracked symlinks
 + Demonstrate breakage: checkout overwrites untracked symlink with directory

* jc/grep--no-index-pathspec-fix (2011-02-16) 1 commit
  (merged to 'next' on 2011-02-23 at 58b03b1)
 + grep --no-index: honor pathspecs correctly

* mz/rebase (2011-02-24) 33 commits
  (merged to 'next' on 2011-02-25 at 52caa7a)
 + Makefile: do not install sourced rebase scripts
  (merged to 'next' on 2011-02-22 at 3219155)
 + rebase: use @{upstream} if no upstream specified
 + rebase -i: remove unnecessary state rebase-root
 + rebase -i: don't read unused variable preserve_merges
 + git-rebase--am: remove unnecessary --3way option
 + rebase -m: don't print exit code 2 when merge fails
 + rebase -m: remember allow_rerere_autoupdate option
 + rebase: remember strategy and strategy options
 + rebase: remember verbose option
 + rebase: extract code for writing basic state
 + rebase: factor out sub command handling
 + rebase: make -v a tiny bit more verbose
 + rebase -i: align variable names
 + rebase: show consistent conflict resolution hint
 + rebase: extract am code to new source file
 + rebase: extract merge code to new source file
 + rebase: remove $branch as synonym for $orig_head
 + rebase -i: support --stat
 + rebase: factor out call to pre-rebase hook
 + rebase: factor out clean work tree check
 + rebase: factor out reference parsing
 + rebase: reorder validation steps
 + rebase -i: remove now unnecessary directory checks
 + rebase: factor out command line option processing
 + rebase: align variable content
 + rebase: align variable names
 + rebase: stricter check of standalone sub command
 + rebase: act on command line outside parsing loop
 + rebase: improve detection of rebase in progress
 + rebase: remove unused rebase state 'prev_head'
 + rebase: read state outside loop
 + rebase: refactor reading of state
 + rebase: clearer names for directory variables

Minor UI regression was reported but otherwise it looked like that the
topic is in a good shape.

--------------------------------------------------
[Discarded]

* cp/mergetool-beyondcompare (2011-02-18) 1 commit
 . mergetool--lib: add support for beyond compare

ss/mergetool--lib replaces this.
