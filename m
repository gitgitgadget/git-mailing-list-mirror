From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2016, #04; Fri, 12)
Date: Fri, 12 Feb 2016 15:50:25 -0800
Message-ID: <xmqqfuwxtrni.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 00:50:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUNTt-00081D-Vs
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 00:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbcBLXua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 18:50:30 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56964 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751320AbcBLXu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 18:50:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4F2CE437AF;
	Fri, 12 Feb 2016 18:50:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=Y
	qG7FsGHWt7piedRasf5xAdSpx8=; b=UQ+rG/l1txBPE1WFD94R1jp4oojo6qdAT
	pVNJkzUibFqbItFVNkPs95FkXuubNPCbViQNhez6EP3na5/Kmm3Hs4vND0L7KILe
	oeW7m1tRImDWH8K/0kmz5rsiEQg7LwCLkLqBhy43xamlRctHz8jpVMY1NUv7sEQB
	zQsXAm+eeo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=gKf
	ypUtCGErXSpzO6WzfX62O/D88KkhXPVbQA/SoW6Ygrb+DQgXmwNSE1RBPEUwb2aD
	E4R55sCh2hZDxwaPFYx806Wj/kEDSmf4/GQCZh3BkN3Zsz3zyz7GRBky3oiJFZEx
	YnplYO+T/nkAIXuUeBt6CNvJdZ2r2Ywp2otRI6ag=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 445D0437AE;
	Fri, 12 Feb 2016 18:50:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8C610437AD;
	Fri, 12 Feb 2016 18:50:26 -0500 (EST)
X-master-at: 494398473714dcbedb38b1ac79b531c7384b3bc4
X-next-at: 6faf27b4ff26804a07363078b238b5cfd3dfa976
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 63BE756C-D1E3-11E5-9369-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286099>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* ep/format-printf (2016-02-11) 22 commits
 - wt-status.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - utf8.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - transport-helper.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - trace.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - strbuf.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - remote.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - pkt-line.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - merge-recursive.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - imap-send.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - http-backend.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - fsck.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - daemon.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - config.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - color.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - cache.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - builtin/upload-archive.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - builtin/update-index.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - builtin/receive-pack.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - builtin/index-pack.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - argv-array.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - advice.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - git-compat-util.h: add the FORMAT_PRINTF macro

 Undecided.


* ew/force-ipv4 (2016-02-12) 1 commit
 - connect & http: support -4 and -6 switches for remote operations

 "git fetch" and friends that make network connections can now be
 told to only use ipv4 (or ipv6).

 Will merge to 'next'.


* jk/lose-name-path (2016-02-12) 5 commits
 - list-objects: pass full pathname to callbacks
 - list-objects: drop name_path entirely
 - list-objects: convert name_path to a strbuf
 - show_object_with_name: simplify by using path_name()
 - http-push: stop using name_path

 The "name_path" API was an attempt to reduce the need to construct
 the full path out of a series of path components while walking a
 tree hierarchy, but over time made less efficient because the path
 needs to be flattened, e.g. to be compared with another path that
 is already flat.  Remove the API and rewrite its users to simplify
 overall code complexity.

 Will merge to 'next'.

--------------------------------------------------
[Graduated to "master"]

* aw/push-force-with-lease-reporting (2016-02-01) 1 commit
  (merged to 'next' on 2016-02-03 at facd28f)
 + push: fix ref status reporting for --force-with-lease

 "git push --force-with-lease" has been taught to report if the push
 needed to force (or fast-forwarded).


* cc/untracked (2016-01-27) 11 commits
  (merged to 'next' on 2016-02-01 at 8203631)
 + t7063: add tests for core.untrackedCache
 + test-dump-untracked-cache: don't modify the untracked cache
 + config: add core.untrackedCache
 + dir: simplify untracked cache "ident" field
 + dir: add remove_untracked_cache()
 + dir: add {new,add}_untracked_cache()
 + update-index: move 'uc' var declaration
 + update-index: add untracked cache notifications
 + update-index: add --test-untracked-cache
 + update-index: use enum for untracked cache options
 + dir: free untracked cache when removing it

 Update the untracked cache subsystem and change its primary UI from
 "git update-index" to "git config".


* ew/connect-verbose (2016-01-28) 1 commit
  (merged to 'next' on 2016-02-03 at ceac37e)
 + pass transport verbosity down to git_connect

 There were a few "now I am doing this thing" progress messages in
 the TCP connection code that can be triggered by setting a verbose
 option internally in the code, but "git fetch -v" and friends never
 passed the verbose option down to that codepath.

 There was a brief discussion about the impact on the end-user
 experience by not limiting this to "fetch -v -v", but I think the
 conclusion is that this is OK to enable with a single "-v" as it is
 not too noisy.


* jk/options-cleanup (2016-02-01) 6 commits
  (merged to 'next' on 2016-02-03 at a78d89d)
 + apply, ls-files: simplify "-z" parsing
 + checkout-index: disallow "--no-stage" option
 + checkout-index: handle "--no-index" option
 + checkout-index: handle "--no-prefix" option
 + checkout-index: simplify "-z" option parsing
 + give "nbuf" strbuf a more meaningful name

 Various clean-ups to the command line option parsing.


* js/test-lib-windows-emulated-yes (2016-02-02) 1 commit
  (merged to 'next' on 2016-02-03 at bf6b42c)
 + test-lib: limit the output of the yes utility

 The emulated "yes" command used in our test scripts has been
 tweaked not to spend too much time generating unnecessary output
 that is not used, to help those who test on Windows where it would
 not stop until it fills the pipe buffer due to lack of SIGPIPE.


* js/xmerge-marker-eol (2016-01-27) 2 commits
  (merged to 'next' on 2016-02-01 at 05d91a4)
 + merge-file: ensure that conflict sections match eol style
 + merge-file: let conflict markers match end-of-line style of the context

 The low-level merge machinery has been taught to use CRLF line
 termination when inserting conflict markers to merged contents that
 are themselves CRLF line-terminated.


* ls/clean-smudge-override-in-config (2016-01-29) 1 commit
  (merged to 'next' on 2016-02-03 at 5962354)
 + convert: treat an empty string for clean/smudge filters as "cat"

 Clean/smudge filters defined in a configuration file of lower
 precedence can now be overridden to be a pass-through no-op by
 setting the variable to an empty string.


* nd/do-not-move-worktree-manually (2016-01-22) 2 commits
  (merged to 'next' on 2016-01-26 at c539221)
 + worktree: stop supporting moving worktrees manually
 + worktree.c: fix indentation

 "git worktree" had a broken code that attempted to auto-fix
 possible inconsistency that results from end-users moving a
 worktree to different places without telling Git (the original
 repository needs to maintain backpointers to its worktrees, but
 "mv" run by end-users who are not familiar with that fact will
 obviously not adjust them), which actually made things worse
 when triggered.


* sb/submodule-init (2016-01-28) 2 commits
 - submodule: port init from shell to C
 - submodule: port resolve_relative_url from shell to C
 (this branch uses sb/submodule-parallel-update; is tangled with dt/refs-backend-lmdb.)

 Major part of "git submodule init" has been ported to C.

 Will have to wait for 'sb/submodule-parallel-update'.


* wp/sha1-name-negative-match (2016-02-01) 2 commits
  (merged to 'next' on 2016-02-03 at 89fa5ef)
 + object name: introduce '^{/!-<negative pattern>}' notation
 + test for '!' handling in rev-parse's named commits

 A new "<branch>^{/!-<pattern>}" notation can be used to name a
 commit that is reachable from <branch> that does not match the
 given <pattern>.

--------------------------------------------------
[Stalled]

* ec/annotate-deleted (2015-11-20) 1 commit
 - annotate: skip checking working tree if a revision is provided

 Usability fix for annotate-specific "<file> <rev>" syntax with deleted
 files.

 Waiting for review.


* dg/subtree-rebase-test (2016-01-19) 1 commit
 - contrib/subtree: Add a test for subtree rebase that loses commits

 Reviewed up to v5.
 Will be rerolled.
 ($gmane/284426)


* js/am-3-merge-recursive-direct (2015-10-12) 2 commits
 - am: make a direct call to merge_recursive
 - merge_recursive_options: introduce the "gently" flag

 The merge_recursive_generic() function has been made a bit safer to
 call from inside a process.  "git am -3" was taught to make a direct
 call to the function when falling back to three-way merge.

 Being able to make a direct call would be good in general, but as a
 performance thing, the change needs to be backed up by numbers.

 Needs review.

 I haven't gone through the "gently" change with fine toothed comb;
 I can see that the change avoids calling die(), but I haven't made
 sure that the program states (e.g. what's in the in-core index) are
 adjusted sensibly when it returns to the caller instead of dying,
 or the codepaths that used to die() are free of resource leaks.
 The original code certainly did not care the program states at the
 point of dying exactly because it knew it is going to exit, but now
 they have to care, and they need to be audited.


* dk/gc-more-wo-pack (2016-01-13) 4 commits
 - gc: clean garbage .bitmap files from pack dir
 - t5304: ensure non-garbage files are not deleted
 - t5304: test .bitmap garbage files
 - prepare_packed_git(): find more garbage

 Follow-on to dk/gc-idx-wo-pack topic, to clean up stale
 .bitmap and .keep files.

 Waiting for a reroll.
 ($gmane/284368).


* mg/httpd-tests-update-for-apache-2.4 (2015-04-08) 2 commits
 - t/lib-git-svn: check same httpd module dirs as lib-httpd
 - t/lib-httpd: load mod_unixd

 This is the first two commits in a three-patch series $gmane/266962

 Becoming tired of waiting for a reroll.
 with updated log message ($gmane/268061).
 Will discard.


* jc/diff-b-m (2015-02-23) 5 commits
 . WIPWIP
 . WIP: diff-b-m
 - diffcore-rename: allow easier debugging
 - diffcore-rename.c: add locate_rename_src()
 - diffcore-break: allow debugging

 "git diff -B -M" produced incorrect patch when the postimage of a
 completely rewritten file is similar to the preimage of a removed
 file; such a resulting file must not be expressed as a rename from
 other place.

 The fix in this patch is broken, unfortunately.
 Will discard.

--------------------------------------------------
[Cooking]

* jk/rerere-xsnprintf (2016-02-08) 1 commit
  (merged to 'next' on 2016-02-09 at ff9ade3)
 + rerere: replace strcpy with xsnprintf
 (this branch is used by jc/rerere-multi.)

 Some calls to strcpy(3) triggers a false warning from static
 analysers that are less intelligent than humans, and reducing the
 number of these false hits helps us notice real issues.  A few
 calls to strcpy(3) in "git rerere" that are already safe has been
 rewritten to avoid false wanings.

 Will merge to 'master'.


* jk/test-path-utils-xsnprintf (2016-02-08) 1 commit
  (merged to 'next' on 2016-02-09 at 931f70b)
 + test-path-utils: use xsnprintf in favor of strcpy

 Some calls to strcpy(3) triggers a false warning from static
 analysers that are less intelligent than humans, and reducing the
 number of these false hits helps us notice real issues.  A few
 calls to strcpy(3) in test-path-utils that are already safe has
 been rewritten to avoid false wanings.

 Will merge to 'master'.


* mm/clean-doc-fix (2016-02-09) 1 commit
  (merged to 'next' on 2016-02-09 at ced8555)
 + Documentation/git-clean.txt: don't mention deletion of .git/modules/*

 The documentation for "git clean" has been corrected; it mentioned
 that .git/modules/* are removed by giving two "-f", which has never
 been the case.

 Will merge to 'master'.


* nd/icase (2016-02-09) 11 commits
 - diffcore-pickaxe: support case insensitive match on non-ascii
 - diffcore-pickaxe: "share" regex error handling code
 - grep/pcre: support utf-8
 - gettext: add is_utf8_locale()
 - grep/pcre: prepare locale-dependent tables for icase matching
 - grep/icase: avoid kwsset when -F is specified
 - grep/icase: avoid kwsset on literal non-ascii strings
 - test-regex: expose full regcomp() to the command line
 - test-regex: isolate the bug test code
 - grep: break down an "if" stmt in preparation for next changes
 - grep: allow -F -i combination

 "git grep -i" has been taught to fold case in non-ascii locales.

 ($gmane/285666)


* tb/conversion (2016-02-10) 6 commits
  (merged to 'next' on 2016-02-12 at 6faf27b)
 + convert.c: simplify text_stat
 + convert.c: refactor crlf_action
 + convert.c: use text_eol_is_crlf()
 + convert.c: remove input_crlf_action()
 + convert.c: remove unused parameter 'path'
 + t0027: add tests for get_stream_filter()

 Simplication of eol conversion codepath.


* da/user-useconfigonly (2016-02-08) 2 commits
  (merged to 'next' on 2016-02-09 at 8b303ce)
 + ident: add user.useConfigOnly boolean for when ident shouldn't be guessed
 + fmt_ident: refactor strictness checks

 The "user.useConfigOnly" configuration variable can be used to
 force the user to always set user.email & user.name configuration
 variables, serving as a reminder for those who work on multiple
 projects and do not want to put these in their $HOME/.gitconfig.

 Will merge to 'master'.


* ah/stripspace-optstring (2016-01-29) 1 commit
  (merged to 'next' on 2016-02-12 at cd021aa)
 + stripspace: call U+0020 a "space" instead of a "blank"

 Will merge to 'master'.


* dw/mergetool-vim-window-shuffle (2016-02-12) 1 commit
  (merged to 'next' on 2016-02-12 at 2a2e8bd)
 + mergetool: reorder vim/gvim buffers in three-way diffs

 The vimdiff backend for "git mergetool" has been tweaked to arrange
 and number buffers in the order that would match the expectation of
 majority of people who read left to right, then top down and assign
 buffers 1 2 3 4 "mentally" to local base remote merge windows based
 on that order.

 Will merge to 'master'.


* jk/drop-rsync-transport (2016-02-01) 1 commit
  (merged to 'next' on 2016-02-03 at 08be402)
 + transport: drop support for git-over-rsync

 It turns out "git clone" over rsync transport has been broken when
 the source repository has packed references for a long time, and
 nobody noticed nor complained about it.

 Will merge to 'master'.


* dv/http-try-negotiate-at-least-once (2016-02-02) 1 commit
 - remote-curl: don't fall back to Basic auth if we haven't tried Negotiate

 Will be rerolled.
 A solution with a different approach may be a better one.
 ($gmane/285633)


* sb/submodule-parallel-update (2016-02-12) 7 commits
 - clone: allow an explicit argument for parallel submodule clones
 - submodule update: expose parallelism to the user
 - git submodule update: have a dedicated helper for cloning
 - submodule update: direct error message to stderr
 - fetching submodules: respect `submodule.fetchJobs` config option
 - submodule-config: drop check against NULL
 - submodule-config: keep update strategy around
 (this branch is used by dt/refs-backend-lmdb.)

 A major part of "git submodule update" has been ported to C to take
 advantage of the recently added framework to run download tasks in
 parallel.


* dt/refs-backend-lmdb (2016-02-12) 22 commits
 - refs: tests for lmdb backend
 - refs: add LMDB refs storage backend
 - refs: add register_ref_storage_backends()
 - svn: learn ref-storage argument
 - clone: allow ref storage backend to be set for clone
 - refs: check submodules ref storage config
 - init: allow alternate ref strorage to be set for new repos
 - refs: always handle non-normal refs in files backend
 - refs: resolve symbolic refs first
 - refs: allow log-only updates
 - refs: move duplicate check to common code
 - refs: make lock generic
 - refs: add method to rename refs
 - refs: add methods to init refs db
 - refs: add method for delete_refs
 - refs: add method for initial ref transaction commit
 - refs: add methods for reflog
 - refs: add do_for_each_per_worktree_ref
 - refs: add methods for the ref iterators
 - refs: add methods for misc ref operations
 - refs: add a backend method structure with transaction functions
 - Merge branch 'sb/submodule-parallel-update' into dt/refs/backend-lmdb
 (this branch uses sb/submodule-parallel-update.)

 Building on top of a few refs-backend preparatory series, LMDB
 based refs backend has been plugged into the system.

 Will be rerolled.
 ($gmane/285604)


* js/mingw-tests (2016-02-08) 21 commits
  (merged to 'next' on 2016-02-08 at 417e555)
 + gitignore: ignore generated test-fake-ssh executable
  (merged to 'next' on 2016-02-03 at ace7624)
 + mingw: do not bother to test funny file names
 + mingw: skip a test in t9130 that cannot pass on Windows
 + mingw: handle the missing POSIXPERM prereq in t9124
 + mingw: avoid illegal filename in t9118
 + mingw: mark t9100's test cases with appropriate prereqs
 + t0008: avoid absolute path
 + mingw: work around pwd issues in the tests
 + mingw: fix t9700's assumption about directory separators
 + mingw: skip test in t1508 that fails due to path conversion
 + tests: turn off git-daemon tests if FIFOs are not available
 + mingw: disable mkfifo-based tests
 + mingw: accomodate t0060-path-utils for MSYS2
 + mingw: fix t5601-clone.sh
 + mingw: let lstat() fail with errno == ENOTDIR when appropriate
 + mingw: try to delete target directory before renaming
 + mingw: prepare the TMPDIR environment variable for shell scripts
 + mingw: factor out Windows specific environment setup
 + Git.pm: stop assuming that absolute paths start with a slash
 + mingw: do not trust MSYS2's MinGW gettext.sh
 + mingw: let's use gettext with MSYS2
 (this branch is used by mg/mingw-test-fix.)

 Test scripts have been updated to remove assumptions that are not
 portable between Git for POSIX and Git for Windows, or to skip ones
 with expectations that are not satisfiable on Git for Windows.

 Will merge to 'master'.


* mg/mingw-test-fix (2016-02-08) 1 commit
  (merged to 'next' on 2016-02-12 at df77956)
 + t9100: fix breakage when SHELL_PATH is not /bin/sh
 (this branch uses js/mingw-tests.)

 An earlier adjustment of test mistakenly used write_script
 to prepare a file whose exact content matters for the test;
 reverting that part fixes the breakage for those who use
 SHELL_PATH that is different from /bin/sh.

 Will merge to 'master'.


* nd/clear-gitenv-upon-use-of-alias (2016-02-02) 4 commits
  (merged to 'next' on 2016-02-09 at 2c441b4)
 + restore_env(): free the saved environment variable once we are done
 + git: simplify environment save/restore logic
 + git: protect against unbalanced calls to {save,restore}_env()
 + git: remove an early return from save_env_before_alias()

 The automatic typo correction applied to an alias was broken
 with a recent change already in 'master'.

 Will merge to 'master'.


* kn/ref-filter-atom-parsing (2016-02-02) 12 commits
 - ref-filter: introduce objectname_atom_parser()
 - ref-filter: introduce contents_atom_parser()
 - ref-filter: introduce remote_ref_atom_parser()
 - ref-filter: align: introduce long-form syntax
 - ref-filter: introduce align_atom_parser()
 - ref-filter: introduce parse_align_position()
 - ref-filter: introduce color_atom_parser()
 - ref-filter: introduce parsing functions for each valid atom
 - ref-filter: introduce struct used_atom
 - ref-filter: bump 'used_atom' and related code to the top
 - ref-filter: use strbuf_split_str_omit_term()
 - strbuf: introduce strbuf_split_str_omit_term()

 Refactoring of ref-filter's format-parsing code, in preparation
 for "branch --format" and friends.

 ($gmane/285158)


* ad/cygwin-wants-rename (2015-08-07) 1 commit
 - config.mak.uname: Cygwin needs OBJECT_CREATION_USES_RENAMES

 Will hold.
 ($gmane/275680).


* jc/rerere-multi (2016-02-08) 7 commits
 - rerere: do use multiple variants
 - t4200: rerere a merge with two identical conflicts
 - rerere: allow multiple variants to exist
 - rerere: delay the recording of preimage
 - rerere: handle leftover rr-cache/$ID directory and postimage files
 - rerere: scan $GIT_DIR/rr-cache/$ID when instantiating a rerere_id
 - rerere: split conflict ID further
 (this branch uses jk/rerere-xsnprintf.)

 "git rerere" can encounter two or more files with the same conflict
 signature that have to be resolved in different ways, but there was
 no way to record these separate resolutions.

 Needs further work on forget/gc.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
 - merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007.  It has been reported that
 git-gui still uses the deprecated syntax, which needs to be fixed
 before this final step can proceed.
 ($gmane/282594)
