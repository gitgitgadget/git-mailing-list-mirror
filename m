From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jul 2013, #10; Wed, 31)
Date: Wed, 31 Jul 2013 16:19:39 -0700
Message-ID: <7v7gg6tj04.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 01 01:19:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4fgL-00045w-5V
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 01:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906Ab3GaXTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 19:19:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56603 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863Ab3GaXTm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 19:19:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B52235A9B;
	Wed, 31 Jul 2013 23:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=0
	W0koFTaHOy2XSrIVz3KuN5Hqvs=; b=RSLTLT+xNysnISLE4HC0uZ5L96cogTaY5
	x8TCVplVNwOpqIvrDWXyDJqFhA/tGrjvNw3I62mgX8LyX9fR2QBvbjbMmumhGZQY
	Lb5pnCSTsB7/jSpJvjNExjrORv/7xV2q+ErQBR8YAQQNuTEelEG24CxAbtcXNjai
	3ruv0m1K3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=sMQ
	nxrCDzzhNjp4jHQDqPKQN3Jt1C0DYSvL5afGwPzcgBO4TBMmZl3ai3jFHX4Aw9fO
	BsAEgn511Nn/FqKmKFRzyBB54MHTyIaBnYjsWhKuJuHSA23TXiywHsckolkkrss+
	IIP2yvueZ+qxLSXxVwhhGbLhLI88LTgo1Nm5z8i4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F8BA35A9A;
	Wed, 31 Jul 2013 23:19:42 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95FAA35A98;
	Wed, 31 Jul 2013 23:19:40 +0000 (UTC)
X-master-at: 8dc84fdc48a79c70682e6c361a82d0f3e1db9a03
X-next-at: 025c443e44c008c3a3dd7b83658f4e9734343e53
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ACF267BA-FA37-11E2-B3C7-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231479>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

Hopefully the 1.8.4-rc1 tomorrow with topics marked for 'master'
in this issue of "What's cooking" report.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bc/completion-for-bash-3.0 (2013-07-24) 1 commit
  (merged to 'next' on 2013-07-24 at 913d89c)
 + git-completion.bash: replace zsh notation that breaks bash 3.X


* ds/doc-two-kinds-of-tags (2013-07-29) 1 commit
  (merged to 'next' on 2013-07-30 at 1201ca7)
 + docs/git-tag: explain lightweight versus annotated tags


* jk/capabilities-doc (2013-07-26) 5 commits
  (merged to 'next' on 2013-07-29 at cf3f07e)
 + document 'allow-tip-sha1-in-want' capability
  (merged to 'next' on 2013-07-24 at 5af9a33)
 + document 'quiet' receive-pack capability
 + document 'agent' protocol capability
 + docs: note that receive-pack knows side-band-64k capability
 + docs: fix 'report-status' protocol capability thinko


* jk/commit-how-to-abort-cherry-pick (2013-07-29) 1 commit
  (merged to 'next' on 2013-07-30 at 7b1c49c)
 + commit: tweak empty cherry pick advice for sequencer


* mh/packed-refs-do-one-ref-recursion (2013-07-17) 1 commit
  (merged to 'next' on 2013-07-30 at d8cc1ee)
 + do_one_ref(): save and restore value of current_ref

 Fix a NULL-pointer dereference during nested iterations over
 references (for example, when replace references are being used).


* rj/commit-slab-fix (2013-07-29) 1 commit
  (merged to 'next' on 2013-07-30 at 1914f37)
 + commit-slab.h: Fix memory allocation and addressing


* rr/maint-tilde-markup-in-doc (2013-07-26) 1 commit
  (merged to 'next' on 2013-07-30 at c8f83d5)
 + config doc: quote paths, fixing tilde-interpretation


* rr/rebase-autostash (2013-07-29) 1 commit
  (merged to 'next' on 2013-07-30 at 0095e2d)
 + git-rebase: fix typo


* sb/mailmap-updates (2013-07-24) 1 commit
  (merged to 'next' on 2013-07-24 at 9f8e681)
 + .mailmap: combine more (email, name) to individual persons

--------------------------------------------------
[New Topics]

* bc/unuse-packfile (2013-07-30) 1 commit
 - sha1_file: introduce close_one_pack() to close packs on fd pressure

 Will merge to and cook in 'next'.


* da/darwin (2013-07-30) 1 commit
 - imap-send: use Apple's Security framework for base64 encoding

 Will merge to and cook in 'next'.


* jc/rm-submodule-error-message (2013-07-25) 1 commit
 - builtin/rm.c: consolidate error reporting for removing submodules

 Consolidate two messages phrased subtly differently without a good
 reason.

 Will merge to 'next' and then to 'master', unless there is an objection.


* ms/subtree-install-fix (2013-07-30) 1 commit
 - contrib/subtree: Fix make install target

 Will merge to 'next' and then to 'master'.


* nd/sq-quote-buf (2013-07-30) 3 commits
 - quote: remove sq_quote_print()
 - tar-tree: remove dependency on sq_quote_print()
 - for-each-ref, quote: convert *_quote_print -> *_quote_buf

 Code simplification as a preparatory step to something larger.

 Will merge to and cook in 'next'.


* jc/url-match (2013-07-31) 6 commits
 - config: "git config --get-urlmatch" parses section.<url>.key
 - builtin/config: refactor collect_config()
 - config: parse http.<url>.<variable> using urlmatch
 - config: add generic callback wrapper to parse section.<url>.key
 - config: add helper to normalize and match URLs
 - http.c: fix parsing of http.sslCertPasswordProtected variable

 Reroll of km/http-curl-config-per-url topic.

 Will merge to and cook in 'next'

--------------------------------------------------
[Stalled]

* tr/log-full-diff-keep-true-parents (2013-07-29) 2 commits
 - SQUASH??? free saved-parents slab when done
 - [PERHAPS LIKE THIS] log: use true parents for diff even when rewriting


* tf/gitweb-ss-tweak (2013-07-15) 4 commits
 - gitweb: make search help link less ugly
 - gitweb: omit the repository owner when it is unset
 - gitweb: vertically centre contents of page footer
 - gitweb: ensure OPML text fits inside its box

 Comments?


* rj/read-default-config-in-show-ref-pack-refs (2013-06-17) 3 commits
 - ### DONTMERGE: needs better explanation on what config they need
 - pack-refs.c: Add missing call to git_config()
 - show-ref.c: Add missing call to git_config()

 The changes themselves are probably good, but it is unclear what
 basic setting needs to be read for which exact operation.

 Waiting for clarification.
 $gmane/228294


* jh/shorten-refname (2013-05-07) 4 commits
 - t1514: refname shortening is done after dereferencing symbolic refs
 - shorten_unambiguous_ref(): Fix shortening refs/remotes/origin/HEAD to origin
 - t1514: Demonstrate failure to correctly shorten "refs/remotes/origin/HEAD"
 - t1514: Add tests of shortening refnames in strict/loose mode

 When remotes/origin/HEAD is not a symbolic ref, "rev-parse
 --abbrev-ref remotes/origin/HEAD" ought to show "origin", not
 "origin/HEAD", which is fixed with this series (if it is a symbolic
 ref that points at remotes/origin/something, then it should show
 "origin/something" and it already does).

 Expecting a reroll, as an early part of a larger series.
 $gmane/225137


* jk/list-objects-sans-blobs (2013-06-06) 4 commits
 . archive: ignore blob objects when checking reachability
 . list-objects: optimize "revs->blob_objects = 0" case
 . upload-archive: restrict remote objects with reachability check
 . clear parsed flag when we free tree buffers

 Attempt to allow "archive --remote=$there $arbitrary_sha1" while
 keeping the reachability safety.

 Seems to break some tests in a trivial and obvious way.


* mg/more-textconv (2013-05-10) 7 commits
 - grep: honor --textconv for the case rev:path
 - grep: allow to use textconv filters
 - t7008: demonstrate behavior of grep with textconv
 - cat-file: do not die on --textconv without textconv filters
 - show: honor --textconv for blobs
 - diff_opt: track whether flags have been set explicitly
 - t4030: demonstrate behavior of show with textconv

 Make "git grep" and "git show" pay attention to --textconv when
 dealing with blob objects.

 I thought this was pretty well designed and executed, but it seems
 there are some doubts on the list; kicked back to 'pu'.


* jc/format-patch (2013-04-22) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.

 Not ready for inclusion.

 Will discard unless we hear from anybody who is interested in
 tying its loose ends.


* jk/gitweb-utf8 (2013-04-08) 4 commits
 - gitweb: Fix broken blob action parameters on blob/commitdiff pages
 - gitweb: Don't append ';js=(0|1)' to external links
 - gitweb: Make feed title valid utf8
 - gitweb: Fix utf8 encoding for blob_plain, blobdiff_plain, commitdiff_plain, and patch

 Various fixes to gitweb.

 Drew Northup volunteered to take a look into this.
 $gmane/226216


* jc/show-branch (2013-06-07) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary width
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit before sending it out.

--------------------------------------------------
[Cooking]

* jl/submodule-mv (2013-07-30) 5 commits
 - rm: delete .gitmodules entry of submodules removed from the work tree
 - mv: update the path entry in .gitmodules for moved submodules
 - submodule.c: add .gitmodules staging helper functions
 - mv: move submodules using a gitfile
 - mv: move submodules together with their work trees
 (this branch uses nd/magic-pathspec.)

 "git mv A B" when moving a submodule A does "the right thing",
 inclusing relocating its working tree and adjusting the paths in
 the .gitmodules file.

 Waiting for a reroll.


* ob/typofixes (2013-07-29) 1 commit
  (merged to 'next' on 2013-07-30 at ec2c897)
 + many small typofixes

 Will merge to 'next'.


* ma/hg-to-git (2013-07-23) 1 commit
  (merged to 'next' on 2013-07-30 at 1dddc06)
 + hg-to-git: --allow-empty-message in git commit

 Will merge to 'master'.


* nd/clone-connectivity-shortcut (2013-07-23) 1 commit
  (merged to 'next' on 2013-07-30 at 8d16721)
 + smart http: use the same connectivity check on cloning

 Will cook in 'next'.


* jx/clean-interactive (2013-07-24) 2 commits
  (merged to 'next' on 2013-07-30 at b7fd474)
 + git-clean: implement partial matching for selection
  (merged to 'next' on 2013-07-24 at 1e63bb9)
 + Documentation/git-clean: fix description for range

 Will merge to 'master'.


* db/http-savecookies (2013-07-30) 1 commit
  (merged to 'next' on 2013-07-30 at d2ad6e5)
 + http: add http.savecookies option to write out HTTP cookies

 Will cook in 'next'.


* lf/echo-n-is-not-portable (2013-07-29) 1 commit
  (merged to 'next' on 2013-07-30 at e223ceb)
 + Avoid using `echo -n` anywhere

 Will merge to 'master'.


* sb/fsck-opt-bool (2013-07-29) 1 commit
  (merged to 'next' on 2013-07-30 at 8a9964c)
 + fsck: Replace deprecated OPT_BOOLEAN by OPT_BOOL

 Will cook in 'next'.


* rr/feed-real-path-to-editor (2013-07-29) 1 commit
  (merged to 'next' on 2013-07-30 at 72c9bcb)
 + editor: use canonicalized absolute path

 Will cook in 'next'.


* rj/doc-rev-parse (2013-07-22) 2 commits
  (merged to 'next' on 2013-07-22 at 8188667)
 + rev-parse(1): logically group options
 + rev-parse: remove restrictions on some options

 Will cook in 'next'.


* jk/fast-import-empty-ls (2013-06-23) 4 commits
  (merged to 'next' on 2013-07-22 at d26dab6)
 + fast-import: allow moving the root tree
 + fast-import: allow ls or filecopy of the root tree
 + fast-import: set valid mode on root tree in "ls"
 + t9300: document fast-import empty path issues

 Will cook in 'next'.


* jc/diff-filter-negation (2013-07-19) 6 commits
  (merged to 'next' on 2013-07-22 at 80d167d)
 + diff: deprecate -q option to diff-files
 + diff: allow lowercase letter to specify what change class to exclude
 + diff: reject unknown change class given to --diff-filter
 + diff: preparse --diff-filter string argument
 + diff: factor out match_filter()
 + diff: pass the whole diff_options to diffcore_apply_filter()
 (this branch is used by jc/hold-diff-remove-q-synonym-for-no-deletion.)

 Teach "git diff --diff-filter" to express "I do not want to see
 these classes of changes" more directly by listing only the
 unwanted ones in lowercase (e.g. "--diff-filter=d" will show
 everything but deletion) and deprecate "diff-files -q" which did
 the same thing as "--diff-filter=d".

 Will cook in 'next'.


* nd/magic-pathspec (2013-07-23) 48 commits
  (merged to 'next' on 2013-07-23 at 784c3a1)
 + rm: do not set a variable twice without intermediate reading.
  (merged to 'next' on 2013-07-22 at 39f7194)
 + t6131 - skip tests if on case-insensitive file system
 + parse_pathspec: accept :(icase)path syntax
 + pathspec: support :(glob) syntax
 + pathspec: make --literal-pathspecs disable pathspec magic
 + pathspec: support :(literal) syntax for noglob pathspec
 + kill limit_pathspec_to_literal() as it's only used by parse_pathspec()
 + parse_pathspec: preserve prefix length via PATHSPEC_PREFIX_ORIGIN
 + parse_pathspec: make sure the prefix part is wildcard-free
 + rename field "raw" to "_raw" in struct pathspec
 + tree-diff: remove the use of pathspec's raw[] in follow-rename codepath
 + remove match_pathspec() in favor of match_pathspec_depth()
 + remove init_pathspec() in favor of parse_pathspec()
 + remove diff_tree_{setup,release}_paths
 + convert common_prefix() to use struct pathspec
 + convert add_files_to_cache to take struct pathspec
 + convert {read,fill}_directory to take struct pathspec
 + convert refresh_index to take struct pathspec
 + convert report_path_error to take struct pathspec
 + checkout: convert read_tree_some to take struct pathspec
 + convert unmerge_cache to take struct pathspec
 + convert run_add_interactive to use struct pathspec
 + convert read_cache_preload() to take struct pathspec
 + line-log: convert to use parse_pathspec
 + reset: convert to use parse_pathspec
 + add: convert to use parse_pathspec
 + check-ignore: convert to use parse_pathspec
 + archive: convert to use parse_pathspec
 + ls-files: convert to use parse_pathspec
 + rm: convert to use parse_pathspec
 + checkout: convert to use parse_pathspec
 + rerere: convert to use parse_pathspec
 + status: convert to use parse_pathspec
 + commit: convert to use parse_pathspec
 + clean: convert to use parse_pathspec
 + guard against new pathspec magic in pathspec matching code
 + parse_pathspec: support prefixing original patterns
 + parse_pathspec: support stripping/checking submodule paths
 + parse_pathspec: support stripping submodule trailing slashes
 + parse_pathspec: add special flag for max_depth feature
 + convert some get_pathspec() calls to parse_pathspec()
 + parse_pathspec: add PATHSPEC_PREFER_{CWD,FULL} flags
 + parse_pathspec: save original pathspec for reporting
 + add parse_pathspec() that converts cmdline args to struct pathspec
 + pathspec: add copy_pathspec
 + pathspec: i18n-ize error strings in pathspec parsing code
 + move struct pathspec and related functions to pathspec.[ch]
 + clean: remove unused variable "seen"
 (this branch is used by jl/submodule-mv.)

 Use "struct pathspec" interface in more places, instead of array of
 characters, the latter of which cannot express magic pathspecs
 (e.g. ":(icase)makefile" that matches both Makefile and makefile).

 Will cook in 'next'.


* jc/check-x-z (2013-07-11) 4 commits
  (merged to 'next' on 2013-07-15 at 62751bc)
 + check-attr -z: a single -z should apply to both input and output
 + check-ignore -z: a single -z should apply to both input and output
 + check-attr: the name of the character is NUL, not NULL
 + check-ignore: the name of the character is NUL, not NULL

 "git check-ignore -z" applied the NUL termination to both its input
 (with --stdin) and its output, but "git check-attr -z" ignored the
 option on the output side.

 This is potentially a backward incompatible fix.  I am tempted to
 merge this to and keep it in 'next' for a while to see if anybody
 screams before deciding if we want to do anything to help existing
 users (there may be none).

 Will cook in 'next'.


* ms/fetch-prune-configuration (2013-07-18) 1 commit
  (merged to 'next' on 2013-07-21 at 7ffb690)
 + fetch: make --prune configurable

 Allow fetch.prune and remote.*.prune configuration variables to be set,
 and "git fetch" to behave as if "--prune" is given.

 "git fetch" that honors remote.*.prune is fine, but I wonder if we
 should somehow make "git push" aware of it as well.  Perhaps
 remote.*.prune should not be just a boolean, but a 4-way "none",
 "push", "fetch", "both"?

 Will cook in 'next'.


* km/svn-1.8-serf-only (2013-07-18) 3 commits
  (merged to 'next' on 2013-07-19 at ab8d034)
 + Git.pm: revert _temp_cache use of temp_is_locked
  (merged to 'next' on 2013-07-12 at 70e0b95)
 + git-svn: allow git-svn fetching to work using serf
 + Git.pm: add new temp_is_locked function

 Subversion 1.8.0 that was recently released breaks older subversion
 clients coming over http/https in various ways.

 Will cook in 'next'.


* tr/merge-recursive-index-only (2013-07-07) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: untangle double meaning of o->call_depth
 - merge-recursive: remove dead conditional in update_stages()

 Will hold, until we get any user.


* jc/push-cas (2013-07-22) 6 commits
  (merged to 'next' on 2013-07-23 at 72371b0)
 + t5533: test "push --force-with-lease"
 + push --force-with-lease: tie it all together
 + push --force-with-lease: implement logic to populate old_sha1_expect[]
 + remote.c: add command line option parser for "--force-with-lease"
 + builtin/push.c: use OPT_BOOL, not OPT_BOOLEAN
 + cache.h: move remote/connect API out of it

 Allow a safer "rewind of the remote tip" push than blind "--force",
 by requiring that the overwritten remote ref to be unchanged since
 the new history to replace it was prepared.

 The machinery is more or less ready.  The "--force" option is again
 the big red button to override any safety, thanks to J6t's sanity
 (the original round allowed --lockref to defeat --force).

 The logic to choose the default implemented here is fragile
 (e.g. "git fetch" after seeing a failure will update the
 remote-tracking branch and will make the next "push" pass,
 defeating the safety pretty easily).  It is suitable only for the
 simplest workflows, and it may hurt users more than it helps them.

 Will cook in 'next'.


* jc/pull-training-wheel (2013-07-19) 1 commit
  (merged to 'next' on 2013-07-22 at 748180e)
 + pull: require choice between rebase/merge on non-fast-forward pull

 Make "git pull" (without arguments that say what branch to
 integrate from where) refuse with "it does not fast forward; choose
 between 'pull --merge' and 'pull --rebase'".

 See

 http://thread.gmane.org/gmane.comp.version-control.git/225146/focus=225326
 http://thread.gmane.org/gmane.comp.version-control.git/225146/focus=229221

 for full discussion.

 Will cook in 'next'.


* rj/cygwin-clarify-use-of-cheating-lstat (2013-07-18) 1 commit
 - cygwin: Remove the Win32 l/stat() implementation

 Cygwin port added a "not quite correct but a lot faster and good
 enough for many lstat() calls that are only used to see if the
 working tree entity matches the index entry" lstat() emulation some
 time ago, and it started biting us in places.  This removes it and
 uses the standard lstat() that comes with Cygwin.

 Will merge to and cook in 'next'.


* jc/reflog-doc (2013-06-19) 1 commit
 - setup_reflog_action: document the rules for using GIT_REFLOG_ACTION

 Document rules to use GIT_REFLOG_ACTION variable in the scripted
 Porcelain.  git-rebase--interactive locally violates this, but it
 is a leaf user that does not call out to or dot-sources other
 scripts, so fixing it is not all that urgent.


* jn/add-2.0-u-A-sans-pathspec (2013-04-26) 1 commit
 - git add: -u/-A now affects the entire working tree

 Will cook in 'next' until Git 2.0.


* jc/core-checkstat-2.0 (2013-05-06) 1 commit
 - core.statinfo: remove as promised in Git 2.0

 Will cook in 'next' until Git 2.0.


* jc/push-2.0-default-to-simple (2013-06-18) 1 commit
 - push: switch default from "matching" to "simple"

 Will cook in 'next' until Git 2.0.


* jc/add-2.0-ignore-removal (2013-04-22) 1 commit
 - git add <pathspec>... defaults to "-A"

 Updated endgame for "git add <pathspec>" that defaults to "--all"
 aka "--no-ignore-removal".

 Will cook in 'next' until Git 2.0.


* jc/hold-diff-remove-q-synonym-for-no-deletion (2013-07-19) 1 commit
 - diff: remove "diff-files -q" in a version of Git in a distant future
 (this branch uses jc/diff-filter-negation.)

 Will cook in 'next' until a distant future.

--------------------------------------------------
[Discarded]

* jh/remote-hg-fetch-fix (2013-07-25) 2 commits
  (merged to 'next' on 2013-07-25 at 33161ad)
 + Revert "remotes-hg: bugfix for fetching non local remotes"
  (merged to 'next' on 2013-07-24 at 9c96641)
 + remotes-hg: bugfix for fetching non local remotes

 Reverted.

 Waiting for the final patch to replace, after discussion settles.


* km/http-curl-config-per-url (2013-07-31) 7 commits
  (merged to 'next' on 2013-07-31 at e88aad5)
 + Revert km/http-curl-config-per-url in its entirety
  (merged to 'next' on 2013-07-25 at 531e8cb)
 + docs: update http.<url>.* options documentation
  (merged to 'next' on 2013-07-23 at f84689b)
 + config: allow http.<url>.* any user matching
 + tests: add new test for the url_normalize function
 + config: improve support for http.<url>.* settings
 + config: add support for http.<url>.* settings
 + http.c: fix parsing of http.sslCertPasswordProtected variable

 Reverted to be replaced with a reroll (jc/url-match topic).
