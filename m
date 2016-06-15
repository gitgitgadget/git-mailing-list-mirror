From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jul 2013, #07; Sun, 21)
Date: Sun, 21 Jul 2013 23:57:43 -0700
Message-ID: <7vy58zozdk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 22 08:58:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1A4N-0000q5-BE
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 08:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756447Ab3GVG6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 02:58:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48421 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756437Ab3GVG54 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 02:57:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20C212CCD2;
	Mon, 22 Jul 2013 06:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=x
	Bav6jaf+WB/88yq8EZCUveluns=; b=exG1zl+3F0YuLjF8WiPSjGCLuaZUhK3z2
	Mhs5YVUM3rv6kdygWYq/E3nBxW7ozhKN7GVbt11O02gqrwZ4KAbStwaGzvLKYMHm
	O8F6NW01d9o6OJ/aTyyBMkMgUCE0rqDvaUNzX8H654kO42O/hjsXyMCXzgwUE1BQ
	dDMYYDT9+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=bcP
	JAZD4JkDSYVYi7ndLzn5xb95OK/2m13uSZ9BAhbVkBl66Gvfdi1IRjLvaCDxT6cc
	O5GwmeVvb2jbaD0v6eKs6UuvK4rA0EWkU4lcIa/m/XIFryMNHVF83k27IuewfYU2
	9i93A46JEDtAaza30B3FLj8Pug5vQHu391FEBKXk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 171082CCD1;
	Mon, 22 Jul 2013 06:57:56 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F04152CCC7;
	Mon, 22 Jul 2013 06:57:53 +0000 (UTC)
X-master-at: 805c5a578995db7594ad0751a683bc6422655c29
X-next-at: e2c9e63a26e9480ed73a4f2615121c69962087b4
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0823BFD8-F29C-11E2-8109-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230962>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

Quite a many documentation clean-up patches that are already in
'master' have been applied to 'maint'.  Hopefully 1.8.3.4 will be
the last of the 1.8.3.x maintenance series.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* mm/color-auto-default (2013-07-19) 1 commit
  (merged to 'next' on 2013-07-19 at 880d984)
 + git add -e: Explicitly specify that patch should have no color

 A finishing touch to fix breakage to "add -e" caused by defaulting
 ui.color to "auto".

 Will merge to 'master'.


* jc/simple-add-must-be-a-no-op (2013-07-19) 1 commit
  (merged to 'next' on 2013-07-19 at a1543ee)
 + t2202: make sure "git add" (no args) stays a no-op

 This detected a mismerge of one of "add-2.0" topics to the 'jch'
 and 'pu' branches.

 Will merge to 'master'.


* jm/doc-ref-prune (2013-07-18) 2 commits
 - Documentation: fix git-prune example usage
 - Documentation: remove --prune from pack-refs examples

 Will merge to 'next' and then 'master'.


* rj/sparse (2013-07-21) 1 commit
 - Revert "compat/unsetenv.c: Fix a sparse warning"

 Will merge to 'next' and then 'master'.


* sb/traverse-trees-bitmask-variable-name (2013-07-19) 1 commit
 - traverse_trees(): clarify return value of the callback

 Will merge to 'next' and then 'master'.

--------------------------------------------------
[Stalled]

* jk/fast-import-empty-ls (2013-06-23) 4 commits
 - fast-import: allow moving the root tree
 - fast-import: allow ls or filecopy of the root tree
 - fast-import: set valid mode on root tree in "ls"
 - t9300: document fast-import empty path issues

 Comments?


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


* jl/submodule-mv (2013-04-23) 5 commits
 . submodule.c: duplicate real_path's return value
 . rm: delete .gitmodules entry of submodules removed from the work tree
 . Teach mv to update the path entry in .gitmodules for moved submodules
 . Teach mv to move submodules using a gitfile
 . Teach mv to move submodules together with their work trees

 "git mv A B" when moving a submodule A does "the right thing",
 inclusing relocating its working tree and adjusting the paths in
 the .gitmodules file.

 Ejected from 'pu', as it conflicts with nd/magic-pathspec.


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

* mh/multimail (2013-07-15) 2 commits
 - post-receive-email: deprecate script in favor of git-multimail
 - git-multimail: an improved replacement for post-receive-email

 An enhanced "post-receive" hook to send e-mail messages.

 I tend to agree that the wording of the tip one is a bit too
 strong.  An old script does not necessarily have to be avoided by
 its existing users only because it has not got updates for a long
 time.


* db/show-ref-head (2013-07-17) 1 commit
  (merged to 'next' on 2013-07-18 at 73797d0)
 + show-ref: make --head always show the HEAD ref

 The "--head" option to "git show-ref" was only to add "HEAD" to the
 list of candidate refs to be filtered by the usual rules
 (e.g. "--heads" that only show refs under refs/heads).  Change the
 meaning of the option to always show "HEAD" regardless of what
 filtering will be applied to any other ref (this is a backward
 incompatible change, so I may need to add an entry to the Release
 Notes).

 Will merge to 'master'.


* dw/request-pull-diag (2013-07-17) 1 commit
  (merged to 'next' on 2013-07-18 at d4406de)
 + request-pull: improve error message for invalid revision args

 Will merge to 'master'.


* es/blame-L-breakage (2013-07-17) 6 commits
  (merged to 'next' on 2013-07-18 at cfd871a)
 + blame-options.txt: explain that -L <start> and <end> are optional
 + blame-options.txt: place each -L option variation on its own line
 + t8001/t8002 (blame): add blame -L :funcname tests
 + t8001/t8002 (blame): add blame -L tests
 + t8001/t8002 (blame): modernize style
 + line-range: fix "blame -L X,-N" regression

 The refactoring made for parsing "-L" option recently to support
 "git log -L" seems to have broken "git blame -L X,-5" to show 5
 lines leading to X.

 Will merge to 'master'.


* jc/diff-filter-negation (2013-07-19) 6 commits
 - diff: deprecate -q option to diff-files
 - diff: allow lowercase letter to specify what change class to exclude
 - diff: reject unknown change class given to --diff-filter
 - diff: preparse --diff-filter string argument
 - diff: factor out match_filter()
 - diff: pass the whole diff_options to diffcore_apply_filter()
 (this branch is used by jc/hold-diff-remove-q-synonym-for-no-deletion.)

 Teach "git diff --diff-filter" to express "I do not want to see
 these classes of changes" more directly by listing only the
 unwanted ones in lowercase (e.g. "--diff-filter=d" will show
 everything but deletion) and deprecate "diff-files -q" which did
 the same thing as "--diff-filter=d".

 Will merge to 'next'.


* mh/packed-refs-do-one-ref-recursion (2013-07-17) 1 commit
 - do_one_ref(): save and restore value of current_ref

 Needs a bit better description to be placed in the Release Notes.


* ml/avoid-using-grep-on-crlf-files (2013-07-18) 1 commit
 - test-lib.sh - define and use GREP_STRIPS_CR

 On systems that understand a CRLF as a line ending, tests in this
 script that worked on files with CRLF line endings using "grep" to
 extract matching lines may lose the CR at the end of lines that
 match, causing the actual output not to match the expected output.

 Will merge to 'next'.


* ml/cygwin-updates (2013-07-21) 4 commits
 - cygwin: stop forcing core.filemode=false
 - Cygwin 1.7 supports mmap
 - Cygwin 1.7 has thread-safe pread
 - Cygwin 1.7 needs compat/regex

 The tip one does _not_ revert c869753e (Force core.filemode to
 false on Cygwin., 2006-12-30) on purpose, so that people can
 still retain the old behaviour if they wanted to.

 Will merge to 'next'.


* mm/diff-no-patch-synonym-to-s (2013-07-17) 6 commits
  (merged to 'next' on 2013-07-18 at 3b893d6)
 + Documentation/git-log.txt: capitalize section names
 + Documentation: move description of -s, --no-patch to diff-options.txt
 + Documentation/git-show.txt: include common diff options, like git-log.txt
 + diff: allow --patch & cie to override -s/--no-patch
 + diff: allow --no-patch as synonym for -s
 + t4000-diff-format.sh: modernize style

 "git show -s" was less discoverable than it should be.

 Will merge to 'master'.


* nd/magic-pathspec (2013-07-17) 47 commits
 - t6131 - skip tests if on case-insensitive file system
 - parse_pathspec: accept :(icase)path syntax
 - pathspec: support :(glob) syntax
 - pathspec: make --literal-pathspecs disable pathspec magic
 - pathspec: support :(literal) syntax for noglob pathspec
 - kill limit_pathspec_to_literal() as it's only used by parse_pathspec()
 - parse_pathspec: preserve prefix length via PATHSPEC_PREFIX_ORIGIN
 - parse_pathspec: make sure the prefix part is wildcard-free
 - rename field "raw" to "_raw" in struct pathspec
 - tree-diff: remove the use of pathspec's raw[] in follow-rename codepath
 - remove match_pathspec() in favor of match_pathspec_depth()
 - remove init_pathspec() in favor of parse_pathspec()
 - remove diff_tree_{setup,release}_paths
 - convert common_prefix() to use struct pathspec
 - convert add_files_to_cache to take struct pathspec
 - convert {read,fill}_directory to take struct pathspec
 - convert refresh_index to take struct pathspec
 - convert report_path_error to take struct pathspec
 - checkout: convert read_tree_some to take struct pathspec
 - convert unmerge_cache to take struct pathspec
 - convert run_add_interactive to use struct pathspec
 - convert read_cache_preload() to take struct pathspec
 - line-log: convert to use parse_pathspec
 - reset: convert to use parse_pathspec
 - add: convert to use parse_pathspec
 - check-ignore: convert to use parse_pathspec
 - archive: convert to use parse_pathspec
 - ls-files: convert to use parse_pathspec
 - rm: convert to use parse_pathspec
 - checkout: convert to use parse_pathspec
 - rerere: convert to use parse_pathspec
 - status: convert to use parse_pathspec
 - commit: convert to use parse_pathspec
 - clean: convert to use parse_pathspec
 - guard against new pathspec magic in pathspec matching code
 - parse_pathspec: support prefixing original patterns
 - parse_pathspec: support stripping/checking submodule paths
 - parse_pathspec: support stripping submodule trailing slashes
 - parse_pathspec: add special flag for max_depth feature
 - convert some get_pathspec() calls to parse_pathspec()
 - parse_pathspec: add PATHSPEC_PREFER_{CWD,FULL} flags
 - parse_pathspec: save original pathspec for reporting
 - add parse_pathspec() that converts cmdline args to struct pathspec
 - pathspec: add copy_pathspec
 - pathspec: i18n-ize error strings in pathspec parsing code
 - move struct pathspec and related functions to pathspec.[ch]
 - clean: remove unused variable "seen"

 Use "struct pathspec" interface in more places, instead of array of
 characters, the latter of which cannot express magic pathspecs
 (e.g. ":(icase)makefile" that matches both Makefile and makefile).

 Will merge to 'next'.


* rh/template-updates (2013-07-15) 3 commits
 - templates: spell ASCII in uppercase in pre-commit hook
 - templates: Reformat pre-commit hook's message
 - templates: Use heredoc in pre-commit hook

 This is an earlier part of a 6 patch series, with log message
 corrected.

 Will merge to 'next'.


* sb/misc-fixes (2013-07-15) 3 commits
  (merged to 'next' on 2013-07-21 at 880b08c)
 + diff.c: Do not initialize a variable, which gets reassigned anyway.
 + commit: Fix a memory leak in determine_author_info
 + daemon.c:handle: Remove unneeded check for null pointer.

 Assorted code cleanups and a minor fix.

 Will merge to 'master'.


* sb/parse-object-buffer-eaten (2013-07-17) 1 commit
  (merged to 'next' on 2013-07-18 at 364689c)
 + parse_object_buffer: correct freeing the buffer

 Will merge to 'master'.


* tr/do-not-call-submodules-subprojects (2013-07-18) 2 commits
  (merged to 'next' on 2013-07-18 at 6386fd5)
 + show-branch: fix description of --date-order
 + apply, entry: speak of submodules instead of subprojects

 Will merge to 'master'.


* tr/protect-low-3-fds (2013-07-17) 2 commits
  (merged to 'next' on 2013-07-18 at 504d972)
 + git: ensure 0/1/2 are open in main()
 + daemon/shell: refactor redirection of 0/1/2 from /dev/null

 When "git" is spawned in such a way that any of the low 3 file
 descriptors is closed, our first open() may yield file descriptor 2,
 and writing error message to it would screw things up in a big way.

 Will merge to 'master'.


* rr/send-email-ssl-verify (2013-07-18) 1 commit
  (merged to 'next' on 2013-07-21 at 62099ff)
 + send-email: be explicit with SSL certificate verification

 Newer Net::SMTP::SSL module does not want the user programs to use
 the default behaviour to let server certificate go without
 verification, so by default enable the verification with a
 mechanism to turn it off if needed.

 Will merge to 'master'.


* es/check-mailmap (2013-07-13) 2 commits
  (merged to 'next' on 2013-07-21 at 23c5363)
 + t4203: test check-mailmap command invocation
 + builtin: add git-check-mailmap command
 (this branch is used by es/contacts.)

 A new command to allow scripts to query the mailmap information.

 Will merge to 'master'.


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

 Waiting for failure reports ;-)


* jk/cat-file-batch-optim (2013-07-18) 9 commits
 - Fix some sparse warnings
 - sha1_object_info_extended: pass object_info to helpers
 - sha1_object_info_extended: make type calculation optional
 - packed_object_info: make type lookup optional
 - packed_object_info: hoist delta type resolution to helper
 - sha1_loose_object_info: make type lookup optional
 - sha1_object_info_extended: rename "status" to "type"
 - cat-file: disable object/refname ambiguity check for batch mode
 - Merge branch 'nd/warn-ambiguous-object-name' into jk/cat-file-batch-optim

 If somebody wants to only know on-disk footprint of an object
 without having to know its type or payload size, we can bypass a
 lot of code to cheaply learn it.

 Will merge to 'next'.


* jk/t0008-sigpipe-fix (2013-07-12) 1 commit
  (merged to 'next' on 2013-07-15 at cead4b2)
 + t0008: avoid SIGPIPE race condition on fifo

 Fix for recent test breakage on 'master'.

 Will merge to 'master'.


* mk/upload-pack-off-by-one-dead-code-removal (2013-07-15) 1 commit
  (merged to 'next' on 2013-07-15 at a8f55a2)
 + upload-pack: remove a piece of dead code

 Will merge to 'master'.


* tr/fd-gotcha-fixes (2013-07-12) 2 commits
  (merged to 'next' on 2013-07-18 at 30f4fdf)
 + run-command: dup_devnull(): guard against syscalls failing
 + git_mkstemps: correctly test return value of open()

 Two places we did not check return value (expected to be a file
 descriptor) correctly.

 Will merge to 'master'.


* jc/mailmap-case-insensitivity (2013-07-15) 9 commits
  (merged to 'next' on 2013-07-18 at 83341ac)
 + mailmap: style fixes
 + mailmap: debug: avoid passing NULL to fprintf() '%s' conversion specification
 + mailmap: debug: eliminate -Wformat field precision type warning
 + mailmap: debug: fix malformed fprintf() format conversion specification
 + mailmap: debug: fix out-of-order fprintf() arguments
 + mailmap: do not downcase mailmap entries
 + t4203: demonstrate loss of uppercase characters in canonical email
 + mailmap: do not lose single-letter names
 + t4203: demonstrate loss of single-character name in mailmap entry

 The mailmap mechanism unnecessarily downcased the e-mail addresses
 in the output, and also ignored the human name when it is a single
 character name.

 This now has become Eric Sunshine's series, even though it still is
 under jc/ hierarchy.

 Will merge to 'master'.


* ms/fetch-prune-configuration (2013-07-18) 1 commit
  (merged to 'next' on 2013-07-21 at 7ffb690)
 + fetch: make --prune configurable

 Allow fetch.prune and remote.*.prune configuration variables to be set,
 and "git fetch" to behave as if "--prune" is given.

 Will merge to 'master'.


* jk/gcc-function-attributes (2013-07-19) 4 commits
  (merged to 'next' on 2013-07-19 at 5f6ad91)
 + Add the LAST_ARG_MUST_BE_NULL macro
  (merged to 'next' on 2013-07-12 at 5a7081f)
 + wt-status: use "format" function attribute for status_printf
 + use "sentinel" function attribute for variadic lists
 + add missing "format" function attributes

 Use the function attributes extension to catch mistakes in use of
 our own variadic functions that use NULL sentinel at the end
 (i.e. like execl(3)) and format strings (i.e. like printf(3)).

 Will merge to 'master'.


* km/http-curl-config-per-url (2013-07-21) 5 commits
 . config: allow http.<url>.* any user matching
 . tests: add new test for the url_normalize function
 . config: improve support for http.<url>.* settings
 . config: add support for http.<url>.* settings
 . http.c: fix parsing of http.sslCertPasswordProtected variable

 Allows custom curl configuration per URL when talking over http.
 Tentatively ejected as I did not seem to have received some binary
 files correctly.


* hv/config-from-blob (2013-07-12) 5 commits
  (merged to 'next' on 2013-07-15 at 9ab7f3f)
 + do not die when error in config parsing of buf occurs
 + teach config --blob option to parse config from database
 + config: make parsing stack struct independent from actual data source
 + config: drop cf validity check in get_next_char()
 + config: factor out config file stack management

 Allow configuration data to be read from in-tree blob objects,
 which would help working in a bare repository and submodule
 updates.

 Will merge to 'master'.


* jc/name-rev-exact-ref (2013-07-18) 5 commits
  (merged to 'next' on 2013-07-18 at c8bc00c)
 + describe: fix --contains when a tag is given as input
 + name-rev: differentiate between tags and commits they point at
  (merged to 'next' on 2013-07-11 at fd5b30c)
 + describe: use argv-array
 + name-rev: allow converting the exact object name at the tip of a ref
 + name-ref: factor out name shortening logic from name_ref()

 Corrects the longstanding sloppiness in the implementation of
 name-rev that conflated "we take commit-ish" and "differences
 between tags and commits do not matter".

 Will merge to 'master'.


* km/svn-1.8-serf-only (2013-07-18) 3 commits
  (merged to 'next' on 2013-07-19 at ab8d034)
 + Git.pm: revert _temp_cache use of temp_is_locked
  (merged to 'next' on 2013-07-12 at 70e0b95)
 + git-svn: allow git-svn fetching to work using serf
 + Git.pm: add new temp_is_locked function

 Subversion 1.8.0 that was recently released breaks older subversion
 clients coming over http/https in various ways.

 Will cook for a while.


* tr/merge-recursive-index-only (2013-07-07) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: untangle double meaning of o->call_depth
 - merge-recursive: remove dead conditional in update_stages()

 What's the status of this one?

 I am not particularly fond of the second patch that conceptually
 allows updating working tree during a virtual merge (i.e. addition
 of o->no_worktree is fine, but there needs a way to make sure it is
 never set to false when o->depth is not zero).


* jc/push-cas (2013-07-17) 6 commits
 - t5533: test "push --lockref"
 - push --lockref: tie it all together
 - push --lockref: implement logic to populate old_sha1_expect[]
 - remote.c: add command line option parser for "--lockref"
 - builtin/push.c: use OPT_BOOL, not OPT_BOOLEAN
 - cache.h: move remote/connect API out of it

 Allow a safer "rewind of the remote tip" push than blind "--force",
 by requiring that the overwritten remote ref to be unchanged since
 the new history to replace it was prepared.

 The machinery is more or less ready.  The "--force" option is again
 the big red button to override any safety, thanks to J6t's sanity
 (the original round allowed --lockref to defeat --force).

 I have strong doubts on the merit of the logic to choose the
 default for "--lockref" implemented here.  It is suitable only for
 the simplest workflows, and it may hurt users more than it helps
 them.

 Also the option may be called something with "--force" prefix, as
 it is a weaker and more controlled form of "--force" that is used
 to defeat the usual "must fast-forward" safety.


* nd/const-struct-cache-entry (2013-07-09) 1 commit
  (merged to 'next' on 2013-07-15 at 9ce0122)
 + Convert "struct cache_entry *" to "const ..." wherever possible

 Will merge to 'master'.


* es/contacts (2013-07-21) 5 commits
 - contrib: contacts: add documentation
 - contrib: contacts: add mailmap support
 - contrib: contacts: interpret committish akin to format-patch
 - contrib: contacts: add ability to parse from committish
 - contrib: add git-contacts helper
 (this branch uses es/check-mailmap.)

 A helper to read from a set of format-patch output files or a range
 of commits and find those who may have insights to the code that
 the changes touch by running a series of "git blame" commands.

 Still needs to add mailmap support and other niceties but the
 basics already look sound, and the enhancements can be done
 in-tree. Assuming that "git contact" is something we may want to
 have as a member of the official set of commands someday, that is.

 Will merge to 'next'.


* jc/pull-training-wheel (2013-07-19) 1 commit
 - pull: require choice between rebase/merge on non-fast-forward pull

 Make "git pull" (without arguments that say what branch to
 integrate from where) refuse with "it does not fast forward; choose
 between 'pull --merge' and 'pull --rebase'".

 See

 http://thread.gmane.org/gmane.comp.version-control.git/225146/focus=225326
 http://thread.gmane.org/gmane.comp.version-control.git/225146/focus=229221

 for full discussion.

 Will merge to 'next'.


* rj/cygwin-clarify-use-of-cheating-lstat (2013-07-18) 1 commit
 - cygwin: Remove the Win32 l/stat() implementation

 Cygwin port added a "not quite correct but a lot faster and good
 enough for many lstat() calls that are only used to see if the
 working tree entity matches the index entry" lstat() emulation some
 time ago, and it started biting us in places.  This removes it and
 uses the standard lstat() that comes with Cygwin.

 I am personally in favor of this simpler solution.  Comments?


* jc/reflog-doc (2013-06-19) 1 commit
 - setup_reflog_action: document the rules for using GIT_REFLOG_ACTION

 Document rules to use GIT_REFLOG_ACTION variable in the scripted
 Porcelain.  git-rebase--interactive locally violates this, but it
 is a leaf user that does not call out to or dot-sources other
 scripts, so fixing it is not all that urgent.


* mh/ref-races-optim-invalidate-cached (2013-06-20) 1 commit
 - refs: do not invalidate the packed-refs cache unnecessarily

 This requires the platform lstat() to be correct to avoid false
 negatives.

 Will merge to 'next'.


* jx/clean-interactive (2013-06-26) 16 commits
  (merged to 'next' on 2013-07-12 at 61dd42d)
 + test: run testcases with POSIX absolute paths on Windows
 + test: add t7301 for git-clean--interactive
 + git-clean: add documentation for interactive git-clean
 + git-clean: add ask each interactive action
 + git-clean: add select by numbers interactive action
 + git-clean: add filter by pattern interactive action
 + git-clean: use a git-add-interactive compatible UI
 + git-clean: add colors to interactive git-clean
 + git-clean: show items of del_list in columns
 + git-clean: add support for -i/--interactive
  (merged to 'next' on 2013-06-26 at f7be2d8)
 + git-clean: refactor git-clean into two phases
 + write_name{_quoted_relative,}(): remove redundant parameters
 + quote_path_relative(): remove redundant parameter
 + quote.c: substitute path_relative with relative_path
 + path.c: refactor relative_path(), not only strip prefix
 + test: add test cases for relative_path

 Add "interactive" mode to "git clean".

 The early part to refactor relative path related helper functions
 looked sensible.

 Will merge to 'master'.


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

 This obviously has to wait until a distant future.
