From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Nov 2014, #04; Wed, 26)
Date: Wed, 26 Nov 2014 15:09:45 -0800
Message-ID: <xmqqoarto8xy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 27 00:10:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xtlik-0006At-Gz
	for gcvg-git-2@plane.gmane.org; Thu, 27 Nov 2014 00:10:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973AbaKZXJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 18:09:52 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60485 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753828AbaKZXJs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 18:09:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A99EA211B3;
	Wed, 26 Nov 2014 18:09:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=o
	VYVtXulYKjlbvifRMCOAPy5LjY=; b=ebyoyhPdyGQkKo+RWDQ7DloijxE001qRU
	3nyk9/M4DDEGdsU2VlL2Gfp7wQQhsTjxKyAwjY2si6QkkYSee+qnU/+uffFRfQA9
	+DD/pOilDiZVbaNKhxg8xLBojVnsRxtkkT0eB6k5uERVBBSwTQ5XHIDLX2++27qo
	0uIXA60Pkk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=CyA
	31hNufpTG0lnGz6ZRYcYAhMtmsvFIpDbq+Zf3wYraih40VTpWNGKaPIpORmbCTfG
	Ngle4uYkI8V7b1dBZXgojiPA9KA+xDxBWgyfZihx7+xwLxlXG11tR43z7fxdMJ7H
	xne0Er4fm+xeU3MDJjWI7qILfL34rd3sV/P62rtc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A06C2211B2;
	Wed, 26 Nov 2014 18:09:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D1F87211B1;
	Wed, 26 Nov 2014 18:09:46 -0500 (EST)
X-master-at: b260d265e189728b26e50506ac6ffab6a7d588da
X-next-at: a0de725a8ff02c1f2a9452c2234bee819242395c
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 508F86A4-75C1-11E4-A28B-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260323>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

I haven't had time to write comments (they are essentially release
notes entries to be used when/if the topic graduates to 'master')
for new topics, but I am pushing this out to show the current state
of affairs.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* cc/interpret-trailers (2014-11-10) 2 commits
  (merged to 'next' on 2014-11-14 at fa0ccc6)
 + trailer: display a trailer without its trailing newline
 + trailer: ignore comment lines inside the trailers
 (this branch is used by cc/interpret-trailers-more.)

 Small fixes to a new experimental command already in 'master'.


* da/difftool (2014-11-14) 1 commit
  (merged to 'next' on 2014-11-17 at 231f559)
 + difftool: honor --trust-exit-code for builtin tools

 Fix-up to a new feature in 'master'.


* jc/doc-commit-only (2014-11-07) 1 commit
  (merged to 'next' on 2014-11-14 at 29c70d2)
 + Documentation/git-commit: clarify that --only/--include records the working tree contents


* mh/doc-remote-helper-xref (2014-11-11) 1 commit
  (merged to 'next' on 2014-11-14 at a7f6230)
 + doc: add some crossrefs between manual pages


* sn/tutorial-status-output-example (2014-11-13) 1 commit
  (merged to 'next' on 2014-11-14 at 0fe4930)
 + gittutorial: fix output of 'git status'


* sv/submitting-final-patch (2014-11-13) 1 commit
  (merged to 'next' on 2014-11-14 at 9e1220f)
 + SubmittingPatches: final submission is To: maintainer and CC: list


* ta/tutorial-modernize (2014-11-11) 1 commit
  (merged to 'next' on 2014-11-14 at c45f0ac)
 + gittutorial.txt: remove reference to ancient Git version


* tb/no-relative-file-url (2014-11-13) 1 commit
  (merged to 'next' on 2014-11-14 at 96e9227)
 + t5705: the file:// URL should be absolute

--------------------------------------------------
[New Topics]

* jc/unpack-trees-plug-leak (2014-11-17) 1 commit
 - unpack_trees: plug leakage of o->result


* js/windows-open-eisdir-error (2014-11-17) 1 commit
  (merged to 'next' on 2014-11-18 at 57b0d49)
 + Windows: correct detection of EISDIR in mingw_open()


* rs/maint-config-use-labs (2014-11-17) 1 commit
  (merged to 'next' on 2014-11-18 at 53c2404)
 + use labs() for variables of type long instead of abs()


* rs/receive-pack-use-labs (2014-11-17) 1 commit
  (merged to 'next' on 2014-11-18 at c6d2d94)
 + use labs() for variables of type long instead of abs()


* jk/colors (2014-11-20) 5 commits
 - diff-highlight: allow configurable colors
 - parse_color: recognize "no$foo" to clear the $foo attribute
 - parse_color: support 24-bit RGB values
 - parse_color: refactor color storage
 - Merge branch 'jn/parse-config-slot' into jk/colors
 (this branch uses jk/colors-fix.)


* jk/colors-fix (2014-11-20) 3 commits
 - t4026: test "normal" color
 - config: fix parsing of "git config --get-color some.key -1"
 - docs: describe ANSI 256-color mode
 (this branch is used by jk/colors.)


* jk/gitweb-with-newer-cgi-multi-param (2014-11-18) 1 commit
  (merged to 'next' on 2014-11-18 at 6ac61fe)
 + gitweb: hack around CGI's list-context param() handling


* jk/lock-ref-sha1-basic-return-errors (2014-11-20) 1 commit
 - lock_ref_sha1_basic: do not die on locking errors


* jk/no-perl-tests (2014-11-18) 2 commits
 - t960[34]: mark cvsimport tests as requiring perl
 - t0090: mark add-interactive test with PERL prerequisite


* jk/rebuild-perl-scripts-with-no-perl-seting-change (2014-11-18) 3 commits
 - Makefile: have python scripts depend on NO_PYTHON setting
 - Makefile: simplify by using SCRIPT_{PERL,SH}_GEN macros
 - Makefile: have perl scripts depend on NO_PERL setting


* mh/config-copy-string-from-git-path (2014-11-17) 1 commit
 - cmd_config(): make a copy of path obtained from git_path()


* mh/config-flip-xbit-back-after-checking (2014-11-18) 1 commit
  (merged to 'next' on 2014-11-18 at 45f7d71)
 + create_default_files(): don't set u+x bit on $GIT_DIR/config
 (this branch is used by tb/config-core-filemode-check-on-broken-fs.)


* po/everyday-doc (2014-11-17) 1 commit
 - Documentation: change "gitlink" typo in git-push


* ps/new-workdir-into-empty-directory (2014-11-20) 1 commit
 - git-new-workdir: Don't fail if the target directory is empty


* rt/push-recurse-submodule-usage-string (2014-11-18) 1 commit
 - builtin/push.c: fix description of --recurse-submodules option


* sb/copy-fd-errno (2014-11-17) 1 commit
 - copy.c: make copy_fd preserve meaningful errno


* sb/log-ref-write-fd (2014-11-20) 1 commit
 - refs.c: add a function to append a reflog entry to a fd


* sb/ref-transaction-unify-to-update (2014-11-20) 2 commits
 - refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
 - refs.c: make ref_transaction_create a wrapper for ref_transaction_update


* sv/doc-stripspace (2014-11-19) 1 commit
 - Documentation/git-stripspace: Update synopsis


* sv/typofix-apply-error-message (2014-11-17) 1 commit
 - apply: fix typo in an error message


* da/difftool-mergetool-simplify-reporting-status (2014-11-21) 5 commits
 - mergetools: stop setting $status in merge_cmd()
 - mergetool: simplify conditionals
 - difftool--helper: add explicit exit statement
 - mergetool--lib: remove use of $status global
 - mergetool--lib: remove no-op assignment to $status from setup_user_tool


* dw/shell-basename-dashdash-before-stripping-leading-dash-from-login (2014-11-25) 1 commit
 - git-sh-setup.sh: use dashdash with basename call


* jc/refer-to-t-readme-from-submitting-patches (2014-11-24) 2 commits
 - t/README: justify why "! grep foo" is sufficient
 - SubmittingPatches: refer to t/README for tests


* jc/t9001-modernise (2014-11-25) 5 commits
 - t9001: style modernisation phase #5
 - t9001: style modernisation phase #4
 - t9001: style modernisation phase #3
 - t9001: style modernisation phase #2
 - t9001: style modernisation phase #1
 (this branch uses pb/send-email-te.)


* js/t5000-dont-copy-bin-sh (2014-11-24) 1 commit
 - t5000 on Windows: do not mistake "sh.exe" as "sh"


* mg/add-ignore-errors (2014-11-21) 1 commit
 - add: ignore only ignored files


* mh/find-uniq-abbrev (2014-11-26) 1 commit
 - sha1_name: avoid unnecessary sha1 lookup in find_unique_abbrev


* mh/simplify-repack-without-refs (2014-11-25) 7 commits
 - sort_string_list(): rename to string_list_sort()
 - prune_remote(): iterate using for_each_string_list_item()
 - prune_remote(): rename local variable
 - repack_without_refs(): make the refnames argument a string_list
 - prune_remote(): sort delete_refs_list references en masse
 - prune_remote(): initialize both delete_refs lists in a single loop
 - prune_remote(): exit early if there are no stale references


* pb/am-message-id-footer (2014-11-25) 2 commits
 - git-am: add --message-id/--no-message-id
 - git-mailinfo: add --message-id


* pb/send-email-te (2014-11-25) 2 commits
 - git-send-email: add --transfer-encoding option
 - git-send-email: delay creation of MIME headers
 (this branch is used by jc/t9001-modernise.)


* pw/remote-set-url-fetch (2014-11-26) 1 commit
 - remote: add --fetch and --both options to set-url


* rj/no-xopen-source-for-cygwin (2014-11-24) 1 commit
 - git-compat-util.h: don't define _XOPEN_SOURCE on cygwin


* sb/string-list (2014-11-25) 3 commits
 - string_list: remove string_list_insert_at_index() from its API
 - mailmap: use higher level string list functions
 - string_list: document string_list_(insert,lookup)


* sb/write-sha1-update-reflog (2014-11-24) 1 commit
 - refs.c: move reflog updates into its own function


* tb/config-core-filemode-check-on-broken-fs (2014-11-21) 1 commit
 - init-db: improve the filemode trustability check
 (this branch uses mh/config-flip-xbit-back-after-checking.)

--------------------------------------------------
[Stalled]

* je/quiltimport-no-fuzz (2014-10-21) 2 commits
 - git-quiltimport: flip the default not to allow fuzz
 - git-quiltimport.sh: allow declining fuzz with --exact option

 "quiltimport" drove "git apply" always with -C1 option to reduce
 context of the patch in order to give more chance to somewhat stale
 patches to apply.  Add an "--exact" option to disable, and also
 "-C$n" option to customize this behaviour.  The top patch
 optionally flips the default to "--exact".

 Waiting for an Ack.


* jc/push-cert-hmac-optim (2014-09-25) 2 commits
 - receive-pack: truncate hmac early and convert only necessary bytes
 - sha1_to_hex: split out "hex-format n bytes" helper and use it

 This is "we could do this if we wanted to", not "we measured and it
 improves performance critical codepath".

 Will perhaps drop.


* nd/multiple-work-trees (2014-09-27) 32 commits
 . t2025: add a test to make sure grafts is working from a linked checkout
 . checkout: don't require a work tree when checking out into a new one
 . git_path(): keep "info/sparse-checkout" per work-tree
 . count-objects: report unused files in $GIT_DIR/worktrees/...
 . gc: support prune --worktrees
 . gc: factor out gc.pruneexpire parsing code
 . gc: style change -- no SP before closing parenthesis
 . checkout: clean up half-prepared directories in --to mode
 . checkout: reject if the branch is already checked out elsewhere
 . prune: strategies for linked checkouts
 . checkout: support checking out into a new working directory
 . use new wrapper write_file() for simple file writing
 . wrapper.c: wrapper to open a file, fprintf then close
 . setup.c: support multi-checkout repo setup
 . setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
 . setup.c: convert check_repository_format_gently to use strbuf
 . setup.c: detect $GIT_COMMON_DIR in is_git_directory()
 . setup.c: convert is_git_directory() to use strbuf
 . git-stash: avoid hardcoding $GIT_DIR/logs/....
 . *.sh: avoid hardcoding $GIT_DIR/hooks/...
 . git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
 . $GIT_COMMON_DIR: a new environment variable
 . commit: use SEQ_DIR instead of hardcoding "sequencer"
 . fast-import: use git_path() for accessing .git dir instead of get_git_dir()
 . reflog: avoid constructing .lock path with git_path
 . *.sh: respect $GIT_INDEX_FILE
 . git_path(): be aware of file relocation in $GIT_DIR
 . path.c: group git_path(), git_pathdup() and strbuf_git_path() together
 . path.c: rename vsnpath() to do_git_path()
 . git_snpath(): retire and replace with strbuf_git_path()
 . path.c: make get_pathname() call sites return const char *
 . path.c: make get_pathname() return strbuf instead of static buffer

 A replacement for contrib/workdir/git-new-workdir that does not
 rely on symbolic links and make sharing of objects and refs safer
 by making the borrowee and borrowers aware of each other.

 A few tests need some tweaks for MinGW ($gmane/{257756,257757}).
 Conflicts with rs/ref-transaction so ejected for now, waiting for a
 reroll.


* mt/patch-id-stable (2014-06-10) 1 commit
 - patch-id: change default to stable

 Teaches "git patch-id" to compute the patch ID that does not change
 when the files in a single patch is reordered. As this new algorithm
 is backward incompatible, the last bit to flip it to be the default
 is left out of 'master' for now.

 Nobody seems to be jumping up & down requesting this last step,
 which makes the result somewhat backward incompatible.
 Will perhaps drop.


* tr/remerge-diff (2014-11-10) 9 commits
 - t4213: avoid "|" in sed regexp
 - log --remerge-diff: show what the conflict resolution changed
 - name-hash: allow dir hashing even when !ignore_case
 - merge-recursive: allow storing conflict hunks in index
 - merge_diff_mode: fold all merge diff variants into an enum
 - combine-diff: do not pass revs->dense_combined_merges redundantly
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: internal flag to avoid touching the worktree
 - merge-recursive: remove dead conditional in update_stages()

 "log -p" output learns a new way to let users inspect a merge
 commit by showing the differences between the automerged result
 with conflicts the person who recorded the merge would have seen
 and the final conflict resolution that was recorded in the merge.

 Waiting for a reroll ($gmane/256591).


* hv/submodule-config (2014-11-11) 4 commits
 - do not die on error of parsing fetchrecursesubmodules option
 - use new config API for worktree configurations of submodules
 - extract functions for submodule config set and lookup
 - implement submodule config cache for lookup of submodule names

 Kicked back to 'pu' per request ($gmane/255610).


* jk/pack-bitmap (2014-08-04) 1 commit
 - pack-bitmap: do not use gcc packed attribute

 Hold, waiting for Karsten's replacement.


* ab/add-interactive-show-diff-func-name (2014-05-12) 2 commits
 - SQUASH??? git-add--interactive: Preserve diff heading when splitting hunks
 - git-add--interactive: Preserve diff heading when splitting hunks

 Waiting for a reroll.


* jn/gitweb-utf8-in-links (2014-05-27) 1 commit
 - gitweb: Harden UTF-8 handling in generated links

 $gmane/250758?


* ss/userdiff-update-csharp-java (2014-06-02) 2 commits
 - userdiff: support Java try keyword
 - userdiff: support C# async methods and correct C# keywords

 Reviews sent; waiting for a response.


* bg/rebase-off-of-previous-branch (2014-04-16) 1 commit
 - git-rebase: print name of rev when using shorthand

 Teach "git rebase -" to report the concrete name of the branch
 (i.e. the previous one).

 But it stops short and does not do the same for "git rebase @{-1}".
 Expecting a reroll.


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


* jc/graph-post-root-gap (2013-12-30) 3 commits
 - WIP: document what we want at the end
 - graph: remove unused code a bit
 - graph: stuff the current commit into graph->columns[]

 This was primarily a RFH ($gmane/239580).


* tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
 - perf-lib: add test_perf_cleanup target
 - perf-lib: split starting the test from the execution

 Add test_perf_cleanup shell function to the perf suite, that allows
 the script writers to define a test with a clean-up action.

 Will hold.


* jc/show-branch (2014-03-24) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary width
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit before sending it out.

--------------------------------------------------
[Cooking]

* jk/approxidate-avoid-y-d-m-over-future-dates (2014-11-13) 2 commits
  (merged to 'next' on 2014-11-14 at 3c11a1b)
 + approxidate: allow ISO-like dates far in the future
 + pass TIME_DATE_NOW to approxidate future-check

 Traditionally we tried to avoid interpreting date strings given by
 the user as future dates, e.g. GIT_COMMITTER_DATE=2014-12-10 when
 used early November 2014 was taken as "October 12, 2014" because it
 is likely that a date in the future, December 10, is a mistake.

 Loosen this and do not tiebreak by future-ness of the date when

 (1) ISO-like format is used, and
 (2) the string can make sense interpreted as both y-m-d and y-d-m.

 Will cook in 'next' throughout the remainder of the cycle.


* jk/checkout-from-tree (2014-11-13) 1 commit
  (merged to 'next' on 2014-11-14 at ddbffb0)
 + checkout $tree: do not throw away unchanged index entries

 Will merge to 'master'.


* mb/enable-lib-terminal-test-on-newer-darwin (2014-11-14) 1 commit
  (merged to 'next' on 2014-11-14 at b2aae27)
 + t/lib-terminal: allow TTY tests to run under recent Mac OS

 Will cook in 'next' throughout the remainder of the cycle.

 We probably should drop this, though. ($gmane/259609).


* sv/get-builtin (2014-11-13) 1 commit
  (merged to 'next' on 2014-11-14 at 9497e17)
 + builtin: move builtin retrieval to get_builtin()

 Will merge to 'master'.


* br/imap-send-verbosity (2014-11-05) 1 commit
  (merged to 'next' on 2014-11-12 at d9e58ec)
 + imap-send: use parse options API to determine verbosity
 (this branch is used by br/imap-send-via-libcurl.)

 Will cook in 'next' throughout the remainder of the cycle.


* br/imap-send-via-libcurl (2014-11-10) 1 commit
  (merged to 'next' on 2014-11-12 at 5327ab4)
 + git-imap-send: use libcurl for implementation
 (this branch uses br/imap-send-verbosity.)

 Will cook in 'next' throughout the remainder of the cycle.


* cc/interpret-trailers-more (2014-11-10) 4 commits
 - trailer: add test with an old style conflict block
 - trailer: reuse ignore_non_trailer() to ignore conflict lines
 - commit: make ignore_non_trailer() non static
 - Merge branch 'jc/conflict-hint' into cc/interpret-trailers-more
 (this branch uses jc/conflict-hint.)


* js/push-to-update (2014-11-13) 1 commit
 - Add another option for receive.denyCurrentBranch

 Still being discussed but we seem to have agreed what the desired
 semantics should be.


* rs/env-array-in-child-process (2014-11-10) 1 commit
  (merged to 'next' on 2014-11-14 at 3f6ba07)
 + use args member of struct child_process

 Will merge to 'master'.


* tq/git-ssh-command (2014-11-10) 1 commit
  (merged to 'next' on 2014-11-14 at 83f5dae)
 + git_connect: set ssh shell command in GIT_SSH_COMMAND

 Allow passing extra set of arguments when ssh is invoked to create
 an encrypted & authenticated connection, which is not possible with
 existing GIT_SSH mechanism, which was designed more to match what
 other programs with similar variables did, not necessarily to be
 more useful.

 Will merge to 'master'.


* ms/submodule-update-config-doc (2014-11-03) 1 commit
 - submodule: clarify documentation for update subcommand

 Needs a reroll ($gmane/259037).


* nd/lockfile-absolute (2014-11-03) 1 commit
  (merged to 'next' on 2014-11-06 at 68722a9)
 + lockfile.c: store absolute path

 The lockfile API can get confused which file to clean up when the
 process moved the $cwd after creating a lockfile.

 Will cook in 'next' throughout the remainder of the cycle.


* jh/empty-notes (2014-11-14) 9 commits
  (merged to 'next' on 2014-11-18 at 9eeb338)
 + t3301: modernize style
 + notes: empty notes should be shown by 'git log'
 + builtin/notes: add --allow-empty, to allow storing empty notes
 + builtin/notes: split create_note() to clarify add vs. remove logic
 + builtin/notes: simplify early exit code in add()
 + builtin/notes: refactor note file path into struct note_data
 + builtin/notes: improve naming
 + t3301: verify that 'git notes' removes empty notes by default
 + builtin/notes: fix premature failure when trying to add the empty blob

 A request to store an empty note via "git notes" meant to remove
 note from the object but with --allow-empty we will store a (surprise!)
 note that is empty.  In the longer run, we might want to deprecate
 the somewhat unintuitive "emptying means deletion" behaviour.


* jc/merge-bases (2014-10-30) 2 commits
  (merged to 'next' on 2014-11-06 at 491e576)
 + get_merge_bases(): always clean-up object flags
 + bisect: clean flags after checking merge bases

 Will cook in 'next' throughout the remainder of the cycle.


* jc/strbuf-add-lines-avoid-sp-ht-sequence (2014-10-27) 1 commit
  (merged to 'next' on 2014-10-29 at 9167582)
 + strbuf_add_commented_lines(): avoid SP-HT sequence in commented lines

 The commented output used to blindly add a SP before the payload
 line, resulting in "# \t<indented text>\n" when the payload began
 with a HT.  Instead, produce "#\t<indented text>\n".

 Will cook in 'next' throughout the remainder of the cycle.


* nd/untracked-cache (2014-10-27) 19 commits
 - t7063: tests for untracked cache
 - update-index: test the system before enabling untracked cache
 - update-index: manually enable or disable untracked cache
 - status: enable untracked cache
 - untracked cache: mark index dirty if untracked cache is updated
 - untracked cache: print stats with $GIT_TRACE_UNTRACKED_STATS
 - untracked cache: avoid racy timestamps
 - read-cache.c: split racy stat test to a separate function
 - untracked cache: invalidate at index addition or removal
 - untracked cache: load from UNTR index extension
 - untracked cache: save to an index extension
 - untracked cache: don't open non-existent .gitignore
 - untracked cache: mark what dirs should be recursed/saved
 - untracked cache: record/validate dir mtime and reuse cached output
 - untracked cache: make a wrapper around {open,read,close}dir()
 - untracked cache: invalidate dirs recursively if .gitignore changes
 - untracked cache: initial untracked cache validation
 - untracked cache: record .gitignore information and dir hierarchy
 - dir.c: optionally compute sha-1 of a .gitignore file


* zk/grep-color-words (2014-10-27) 2 commits
  (merged to 'next' on 2014-10-28 at 4d0457c)
 + Revert "grep: fix match highlighting for combined patterns with context lines"
  (merged to 'next' on 2014-10-24 at 2d2f8f8)
 + grep: fix match highlighting for combined patterns with context lines

 rs/grep-color-words topic solves it in a different way.

 Will discard.


* jc/conflict-hint (2014-10-28) 4 commits
  (merged to 'next' on 2014-10-29 at 693250f)
 + merge & sequencer: turn "Conflicts:" hint into a comment
 + builtin/commit.c: extract ignore_non_trailer() helper function
 + merge & sequencer: unify codepaths that write "Conflicts:" hint
 + builtin/merge.c: drop a parameter that is never used
 (this branch is used by cc/interpret-trailers-more.)

 Unlike all the other hints given in the commit log editor, the list
 of conflicted paths were appended at the end without commented out.

 Will cook in 'next' throughout the remainder of the cycle.


* jc/diff-b-m (2014-10-23) 1 commit
  (merged to 'next' on 2014-10-28 at 4daedb1)
 + diff -B -M: fix output for "copy and then rewrite" case

 Fix long-standing bug in "diff -B -M" output.

 Will cook in 'next' throughout the remainder of the cycle.


* jc/checkout-local-track-report (2014-10-14) 1 commit
  (merged to 'next' on 2014-10-21 at f636a00)
 + checkout: report upstream correctly even with loosely defined branch.*.merge

 The report from "git checkout" on a branch that builds on another
 local branch by setting its branch.*.merge to branch name (not a
 full refname) incorrectly said that the upstream is gone.

 Will cook in 'next' throughout the remainder of the cycle.


* jc/clone-borrow (2014-10-15) 1 commit
  (merged to 'next' on 2014-10-21 at b76ea34)
 + clone: --dissociate option to mark that reference is only temporary

 Allow "git clone --reference" to be used more safely.

 Will cook in 'next' throughout the remainder of the cycle.

--------------------------------------------------
[Discarded]

* jt/timer-settime (2014-08-29) 6 commits
 . use timer_settime() for new platforms
 . autoconf: check for timer_settime()
 . autoconf: check for struct itimerspec
 . autoconf: check for struct sigevent
 . autoconf: check for struct timespec
 . autoconf: check for timer_t

 Was wanting for a reroll.


* rs/ref-transaction-reflog (2014-11-03) 15 commits
 . refs.c: allow deleting refs with a broken sha1
 . refs.c: remove lock_any_ref_for_update
 . refs.c: make unlock_ref/close_ref/commit_ref static
 . refs.c: rename log_ref_setup to create_reflog
 . reflog.c: use a reflog transaction when writing during expire
 . refs.c: allow multiple reflog updates during a single transaction
 . refs.c: only write reflog update if msg is non-NULL
 . refs.c: add a flag to allow reflog updates to truncate the log
 . refs.c: add a transaction function to append a reflog entry
 . copy.c: make copy_fd preserve meaningful errno
 . refs.c: add a function to append a reflog entry to a fd
 . refs.c: add a new update_type field to ref_update
 . refs.c: rename the transaction functions
 . refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
 . refs.c make ref_transaction_create a wrapper to ref_transaction_update
 (this branch is used by rs/ref-transaction-rename and rs/ref-transaction-send-pack.)

 Stefan Beller started working on reorganizing these three series,
 which unfortunately did not see much reviews.


* rs/ref-transaction-rename (2014-11-07) 16 commits
 . refs.c: add an err argument to pack_refs
 . refs.c: make lock_packed_refs take an err argument
 . refs.c: make add_packed_ref return an error instead of calling die
 . refs.c: replace the onerr argument in update_ref with a strbuf err
 . refs.c: make the *_packed_refs functions static
 . refs.c: make repack_without_refs static
 . remote.c: use a transaction for deleting refs
 . refs.c: write updates to packed refs when a transaction has more than one ref
 . refs.c: move reflog updates into its own function
 . refs.c: rollback the lockfile before we die() in repack_without_refs
 . refs.c: update rename_ref to use a transaction
 . refs.c: add transaction support for renaming a reflog
 . refs.c: use a stringlist for repack_without_refs
 . refs.c: use packed refs when deleting refs during a transaction
 . refs.c: return error instead of dying when locking fails during transaction
 . refs.c: allow passing raw git_committer_info as email to _update_reflog
 (this branch is used by rs/ref-transaction-send-pack; uses rs/ref-transaction-reflog.)

 Stefan Beller started working on reorganizing these three series,
 which unfortunately did not see much reviews.


* rs/ref-transaction-send-pack (2014-11-07) 7 commits
 . refs.c: add an err argument to create_symref
 . refs.c: add an err argument to create_reflog
 . t5543-atomic-push.sh: add basic tests for atomic pushes
 . push.c: add an --atomic-push argument
 . receive-pack.c: use a single transaction when atomic-push is negotiated
 . send-pack.c: add an --atomic-push command line argument
 . receive-pack.c: add protocol support to negotiate atomic-push
 (this branch uses rs/ref-transaction-reflog and rs/ref-transaction-rename.)

 Stefan Beller started working on reorganizing these three series,
 which unfortunately did not see much reviews.


* sb/simplify-repack-without-refs (2014-11-20) 1 commit
 . refs.c: use a string_list for repack_without_refs
