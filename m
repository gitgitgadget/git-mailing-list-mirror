From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.9-rc0
Date: Fri, 06 Jan 2012 13:55:15 -0800
Message-ID: <7vr4zciji4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 06 22:55:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjHkz-00048K-9b
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 22:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759164Ab2AFVzU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Jan 2012 16:55:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33383 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759061Ab2AFVzS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jan 2012 16:55:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC7FA52F9;
	Fri,  6 Jan 2012 16:55:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=EOAEn8vx/6fbNm4kfYKE3r02k
	38=; b=MK3kALBkLKNAMuZtMe0L2Bq3JDkysXmu6pSEMgv63MKqNWevzB0BJAu1P
	FfnYZcy9Qs9NK5IPMnRuvTrX+jopeDEw0ehskQi2wfdw/t3cMRl8tYiKPqcX3n1R
	85v6xReSF9rt9eyGuk6jneBL7HIaVALhp/h0Pkv8JldD0xRcbY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=IKyr/BI57gOUBaUd1sQ
	OhjN1xbHRSgQ3HtVthHginclWbw6hboENavWmMwmV681zahMG7A4FEBbplkhADWM
	sZh4cJZmbIMXKX5yWYuxsybd2t5NiPMCtbJF0y8WK0Jdd5yC/nZKziNUnB5QP6xC
	XK8LRM0WTL+eJKLpf/Un9Vvg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2A8C52F8;
	Fri,  6 Jan 2012 16:55:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9202352F7; Fri,  6 Jan 2012
 16:55:16 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1E45BB3C-38B1-11E1-B266-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188049>

A release candidate Git 1.7.9-rc0 is available for testing. This is
supposed to be almost feature-complete for the final release.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

c4a04c92ce9a501ba11cfd0032b1f8371aa6536e  git-1.7.9.rc0.tar.gz
60593473ab1111e1bf5af5e491e370ff6a9e9e10  git-htmldocs-1.7.9.rc0.tar.gz
834eff04341ef5bf475654c7a9588d29ae15937c  git-manpages-1.7.9.rc0.tar.gz

Also the following public repositories all have a copy of the v1.7.9-rc=
0
tag and the master branch that the tag points at:

  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git v1.7.9 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Updates since v1.7.8
--------------------

 * gitk updates accumulated since early 2011.

 * git-gui updated to 0.16.0.

 * git-p4 (in contrib/) updates.

 * Git uses gettext to translate its most common interface messages
   into the user's language if translations are available and the
   locale is appropriately set. Distributors can drop in new PO files
   in po/ to add new translations.

 * The code to handle username/password for HTTP transaction used in
   "git push" & "git fetch" learned to talk "credential API" to
   external programs to cache or store them, to allow integration with
   platform native keychain mechanisms.

 * The prompted input in the terminal use our own getpass() replacement
   when possible. HTTP transactions used to ask username without echoin=
g
   back what was typed, but with this change you will see it as you typ=
e.

 * The internal of "revert/cherry-pick" has been tweaked to prepare
   building more generic "sequencer" on top of the implementation that
   drives them.

 * "git add" learned to stream large files directly into a packfile
   instead of writing them into individual loose object files.

 * "git checkout -B <current branch> <elsewhere>" is a more intuitive
   way to spell "git reset --keep <elsewhere>".

 * "git checkout" and "git merge" learned "--no-overwrite-ignore" optio=
n
   to tell Git that untracked and ignored files are not expendable.

 * "git commit --amend" learned "--no-edit" option to say that the
   user is amending the tree being recorded, without updating the
   commit log message.

 * "git commit" and "git reset" re-learned the optimization to prime
   the cache-tree information in the index, which makes it faster to
   write a tree object out after the index entries are updated.

 * "git commit" detects and rejects an attempt to stuff NUL byte in
   the commit log message.

 * "git commit" learned "-S" to GPG-sign the commit; this can be shown
   with the "--show-signature" option to "git log".

 * fsck and prune are relatively lengthy operations that still go
   silent while making the end-user wait. They learned to give progress
   output like other slow operations.

 * The set of built-in function-header patterns for various languages
   knows MATLAB.

 * "git log --format=3D'<format>'" learned new %g[nNeE] specifiers to
   show information from the reflog entries when warlking the reflog
   (i.e. with "-g").

 * "git pull" can be used to fetch and merge an annotated/signed tag,
   instead of the tip of a topic branch. The GPG signature from the
   signed tag is recorded in the resulting merge commit for later
   auditing.

 * "git log" learned "--show-signature" option to show the signed tag
   that was merged that is embedded in the merge commit. It also can
   show the signature made on the commit with "git commit -S".

 * "git branch --edit-description" can be used to add descriptive text
   to explain what a topic branch is about.

 * "git fmt-merge-msg" learned to take the branch description into
   account when preparing a merge summary that "git merge" records
   when merging a local branch.

 * "git request-pull" has been updated to convey more information
   useful for integrators to decide if a topic is worth merging and
   what is pulled is indeed what the requestor asked to pull,
   including:

   - the tip of the branch being requested to be merged;
   - the branch description describing what the topic is about;
   - the contents of the annotated tag, when requesting to pull a tag.

 * "git pull" learned to notice 'pull.rebase' configuration variable,
   which serves as a global fallback for setting 'branch.<name>.rebase'
   configuration variable per branch.

 * "git tag" learned "--cleanup" option to control how the whitespaces
   and empty lines in tag message are cleaned up.

 * "gitweb" learned to show side-by-side diff.

Also contains minor documentation updates and code clean-ups.


=46ixes since v1.7.8
------------------

Unless otherwise noted, all the fixes since v1.7.8 in the maintenance
releases are contained in this release (see release notes to them for
details).

----------------------------------------------------------------

Changes since v1.7.8 are as follows:

Anders Kaseorg (2):
      gitk: Remove unused $cdate array
      gitk: Remember time zones from author and commit timestamps

Andrew Wong (1):
      rebase -i: interrupt rebase when "commit --amend" failed during "=
reword"

Bert Wesarg (14):
      git-gui: fix multi selected file operation
      git-gui: handle config booleans without value
      git-gui: add smart case search mode in searchbar
      git-gui: add regexp search mode to the searchbar
      git-gui: add search history to searchbar
      git-gui: fix unintended line break in message string
      git-gui: use "untracked" for files which are not known to git
      git-gui: new config to control staging of untracked files
      git-gui: fix display of path in browser title
      git-gui: use a tristate to control the case mode in the searchbar
      git-gui: span widgets over the full file output area in the blame=
 view
      git-gui: include the file path in guitools confirmation dialog
      git-gui: make config gui.warndetachedcommit a boolean
      git-gui: don't warn for detached head when rebasing

Brandon Casey (2):
      t/t4131-apply-fake-ancestor.sh: fix broken test
      builtin/apply.c: report error on failure to recognize input

Brian Harring (1):
      fix hang in git fetch if pointed at a 0 length bundle

Carlos Mart=C3=ADn Nieto (2):
      convert: track state in LF-to-CRLF filter
      clone: the -o option has nothing to do with <branch>

Clemens Buchacher (2):
      Documentation: read-tree --prefix works with existing subtrees
      t5550: repack everything into one file

Conrad Irwin (1):
      Update documentation for stripspace

Dejan Ribi=C4=8D (1):
      git-gui: fix spelling error in sshkey.tcl

Eric Wong (1):
      enable SO_KEEPALIVE for connected TCP sockets

Erik Faye-Lund (3):
      mingw: give waitpid the correct signature
      compat/setenv.c: update errno when erroring out
      compat/setenv.c: error if name contains '=3D'

Gary Gibbons (5):
      git-p4: ensure submit clientPath exists before chdir
      git-p4: use absolute directory for PWD env var
      git-p4: fix test for unsupported P4 Client Views
      git-p4: sort client views by reverse View number
      git-p4: support single file p4 client view maps

Gustaf Hendeby (1):
      Add built-in diff patterns for MATLAB code

Jack Nagel (2):
      Documentation: fix formatting error in merge-options.txt
      Add MYMETA.json to perl/.gitignore

Jakub Narebski (7):
      gitweb: Refactor diff body line classification
      gitweb: Extract formatting of diff chunk header
      gitweb: Give side-by-side diff extra CSS styling
      t9500: Add test for handling incomplete lines in diff by gitweb
      t9500: Add basic sanity tests for side-by-side diff in gitweb
      gitweb: Use href(-replay=3D>1,...) for formats links in "commitdi=
ff"
      gitweb: Fix fallback mode of to_utf8 subroutine

Jeff King (53):
      http: drop "local" member from request struct
      prune: handle --progress/no-progress
      reachable: per-object progress
      read-cache: let refresh_cache_ent pass up changed flags
      refresh_index: rename format variables
      refresh_index: make porcelain output more specific
      upload-archive: use start_command instead of fork
      archive: don't let remote clients get unreachable commits
      stripspace: fix outdated comment
      fetch: create status table using strbuf
      test-lib: add test_config_global variant
      t5550: fix typo
      introduce credentials API
      credential: add function for parsing url components
      http: use credential API to get passwords
      credential: apply helper config
      credential: add credential.*.username
      credential: make relevance of http path configurable
      docs: end-user documentation for the credential subsystem
      credentials: add "cache" helper
      compat/snprintf: don't look at va_list twice
      docs: mention "-k" for both forms of "git mv"
      mv: honor --verbose flag
      mv: make non-directory destination error more clear
      mv: improve overwrite warning
      mv: be quiet about overwriting
      strbuf: add strbuf_add*_urlencode
      imap-send: avoid buffer overflow
      imap-send: don't check return value of git_getpass
      move git_getpass to its own source file
      refactor git_getpass into generic prompt function
      add generic terminal prompt function
      credentials: add "store" helper
      prompt: use git_terminal_prompt
      t: add test harness for external credential helpers
      credential: use git_prompt instead of git_getpass
      Makefile: linux has /dev/tty
      Makefile: OS X has /dev/tty
      contrib: add credential helper for OS X Keychain
      drop "match" parameter from get_remote_heads
      t5500: give fully-qualified refs to fetch-pack
      fetch-pack: match refs exactly
      connect.c: drop path_match function
      t5540: test DAV push with authentication
      http-push: enable "proactive auth"
      blame: don't overflow time buffer
      test-lib: redirect stdin of tests
      use custom rename score during --follow
      pretty: give placeholders to reflog identity
      docs: brush up obsolete bits of git-fsck manpage
      make "git push -v" actually verbose
      commit, merge: initialize static strbuf
      remote-curl: don't pass back fake refs

Jelmer Vernooij (1):
      Fix an incorrect reference to --set-all.

Jens Lehmann (2):
      diff/status: print submodule path when looking for changes fails
      docs: describe behavior of relative submodule URLs

Joey Hess (1):
      write first for-merge ref to FETCH_HEAD first

Johan Herland (3):
      t9301: Fix testcase covering up a bug in fast-import's notes fano=
ut handling
      t9301: Add 2nd testcase exposing bugs in fast-import's notes fano=
ut handling
      fast-import: Fix incorrect fanout level when modifying existing n=
otes refs

Johannes Sixt (3):
      Compatibility: declare strtoimax() under NO_STRTOUMAX
      Makefile: unix sockets may not available on some platforms
      t0090: be prepared that 'wc -l' writes leading blanks

Jonathan Nieder (15):
      gitk: Make vi-style keybindings more vi-like
      branch: allow a no-op "branch -M <current-branch> HEAD"
      Allow checkout -B <current-branch> to update the current branch
      test: add missing "&&" after echo command
      test: remove a porcelain test that hard-codes commit names
      t7501 (commit): modernize style
      test: commit --amend should honor --no-edit
      revert: give --continue handling its own function
      revert: allow cherry-pick --continue to commit before resuming
      revert: pass around rev-list args in already-parsed form
      revert: allow single-pick in the middle of cherry-pick sequence
      revert: do not remove state until sequence is finished
      Revert "reset: Make reset remove the sequencer state"
      revert: stop creating and removing sequencer-old directory
      test: errors preparing for a test are not special

Jonathon Mah (1):
      stash: Don't fail if work dir contains file named 'HEAD'

Junio C Hamano (65):
      branch: add read_branch_desc() helper function
      format-patch: use branch description in cover letter
      branch: teach --edit-description option
      request-pull: modernize style
      request-pull: state what commit to expect
      request-pull: use the branch description
      fmt-merge-msg: use branch.$name.description
      get_tree_entry(): do not call find_tree_entry() on an empty tree
      unpack_object_header_buffer(): clear the size field upon error
      write_pack_header(): a helper function
      create_tmp_packfile(): a helper function
      finish_tmp_packfile(): a helper function
      Split GPG interface into its own helper library
      merge: notice local merging of tags and keep it unwrapped
      fetch: allow "git fetch $there v1.0" to fetch a tag
      refs DWIMmery: use the same rule for both "git fetch" and others
      fmt-merge-msg: avoid early returns
      fmt-merge-msg: package options into a structure
      fmt-merge-msg: Add contents of merged tag in the merge message
      merge: make usage of commit->util more extensible
      merge: record tag objects without peeling in MERGE_HEAD
      request-pull: use the annotated tag contents
      commit: copy merged signed tags to headers of merge commit
      merge: force edit and no-ff mode when merging a tag object
      commit: teach --amend to carry forward extra headers
      commit-tree: update the command line parsing
      commit-tree: teach -m/-F options to read logs from elsewhere
      commit: teach --gpg-sign option
      log: --show-signature
      test "commit -S" and "log --show-signature"
      pretty: %G[?GS] placeholders
      receive-pack, fetch-pack: reject bogus pack that records objects =
twice
      pack-object: tolerate broken packs that have duplicated objects
      gpg-interface: allow use of a custom GPG binary
      csum-file: introduce sha1file_checkpoint
      bulk-checkin: replace fast-import based implementation
      Kick-off the 1.7.9 cycle
      checkout -m: no need to insist on having all 3 stages
      commit: honour --no-edit
      Update draft release notes for 1.7.9
      Git 1.7.6.5
      Git 1.7.7.5
      Update draft release notes for 1.7.8.1
      Update draft release notes to 1.7.9
      checkout_merged(): squelch false warning from some gcc
      request-pull: update the "pull" command generation logic
      lf_to_crlf_filter(): tell the caller we added "\n" when draining
      Update draft release notes to 1.7.9
      lf_to_crlf_filter(): resurrect CRLF->CRLF hack
      advice: Document that they all default to true
      request-pull: do not emit "tag" before the tagname
      Update draft release notes to 1.7.9
      commit: do not lose mergetag header when not amending
      Git 1.7.8.1
      Update draft release notes to 1.7.9
      Update draft release notes in preparation for 1.7.9-rc0
      Git 1.7.8.2
      Update draft release notes to 1.7.9
      verify_signed_buffer: fix stale comment
      commit --amend -S: strip existing gpgsig headers
      log-tree.c: small refactor in show_signature()
      log-tree: show mergetag in log --show-signature output
      log --show-signature: reword the common two-head merge case
      Git 1.7.8.3
      Git 1.7.9-rc0

J=C3=BCrgen Kreileder (3):
      gitweb: Call to_utf8() on input string in chop_and_escape_str()
      gitweb: esc_html() site name for title in OPML
      gitweb: Output valid utf8 in git_blame_common('data')

Kato Kazuyoshi (2):
      gitweb: Add a feature to show side-by-side diff
      gitweb: Add navigation to select side-by-side diff

Kirill A. Shutemov (1):
      git-tag: introduce --cleanup option

Linus Torvalds (1):
      fetch: do not store peeled tag object names in FETCH_HEAD

Martin von Zweigbergk (11):
      gitk: Fix file highlight when run in subdirectory
      gitk: Fix "show origin of this line" with separate work tree
      gitk: Fix "blame parent commit" with separate work tree
      gitk: Fix "External diff" with separate work tree
      gitk: Put temporary directory inside .git
      gitk: Run 'git rev-parse --git-dir' only once
      gitk: Simplify calculation of gitdir
      gitk: Show modified files with separate work tree
      am: don't persist keepcr flag
      t3401: modernize style
      t3401: use test_commit in setup

Michael Haggerty (17):
      git symbolic-ref: documentation fix
      struct ref_entry: document name member
      refs: rename "refname" variables
      refs: rename parameters result -> sha1
      clear_ref_array(): rename from free_ref_array()
      is_refname_available(): remove the "quiet" argument
      parse_ref_line(): add docstring
      add_ref(): add docstring
      is_dup_ref(): extract function from sort_ref_array()
      refs: change signatures of get_packed_refs() and get_loose_refs()
      get_ref_dir(): change signature
      resolve_gitlink_ref(): improve docstring
      Pass a (ref_cache *) to the resolve_gitlink_*() helper functions
      resolve_gitlink_ref_recursive(): change to work with struct ref_c=
ache
      repack_without_ref(): remove temporary
      create_ref_entry(): extract function from add_ref()
      add_ref(): take a (struct ref_entry *) parameter

Michael Schubert (2):
      builtin/commit: add missing '/' in help message
      builtin/log: remove redundant initialization

Mika Fischer (3):
      http.c: Use curl_multi_fdset to select on curl fds instead of jus=
t sleeping
      http.c: Use timeout suggested by curl instead of fixed 50ms timeo=
ut
      http.c: Rely on select instead of tracking whether data was recei=
ved

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (20):
      tree-walk.c: do not leak internal structure in tree_entry_len()
      read_directory_recursive: reduce one indentation level
      tree_entry_interesting(): give meaningful names to return values
      tree_entry_interesting: make use of local pointer "item"
      fsck: return error code when verify_pack() goes wrong
      verify_packfile(): check as many object as possible in a pack
      fsck: avoid reading every object twice
      fsck: print progress
      prune: show progress while marking reachable objects
      Convert many resolve_ref() calls to read_ref*() and ref_exists()
      checkout,merge: loosen overwriting untracked file check based on =
info/exclude
      checkout,merge: disallow overwriting ignored files with --no-over=
write-ignore
      Copy resolve_ref() return value for longer use
      revert: convert resolve_ref() to read_ref_full()
      Convert resolve_ref+xstrdup to new resolve_refdup function
      Rename resolve_ref() to resolve_ref_unsafe()
      merge: abort if fails to commit
      Convert commit_tree() to take strbuf as message
      commit_tree(): refuse commit messages that contain NULs
      Catch invalid --depth option passed to clone or fetch

Nick Alcock (2):
      Add strtoimax() compatibility function.
      Support sizes >=3D2G in various config options accepting 'g' size=
s.

Pat Thoyts (11):
      git-gui: include the number of untracked files to stage when aski=
ng the user
      git-gui: theme the search and line-number entry fields on blame s=
creen
      git-gui: catch invalid or complete regular expressions and treat =
as no match.
      git-gui: enable the smart case sensitive search only if gui.searc=
h.smartcase is true
      git-gui: set suitable extended window manager hints.
      git-gui: support underline style when parsing diff output
      git-gui: sort the numeric ansi codes
      git-gui: set whitespace warnings appropriate to this project
      git-gui: added config gui.gcwarning to disable the gc hint messag=
e
      git-gui: handle shell script text filters when loading for blame.
      git-gui 0.16

Paul Mackerras (1):
      gitk: Update copyright

Pete Harlan (1):
      Test 'checkout -m -- path'

Pete Wyckoff (18):
      git-p4: introduce skipSubmitEdit
      git-p4: submit test for auto-creating clientPath
      git-p4: test for absolute PWD problem
      git-p4: fix skipSubmitEdit regression
      rename git-p4 tests
      git-p4: introduce asciidoc documentation
      git-p4: clone does not use --git-dir
      git-p4: test cloning with two dirs, clarify doc
      git-p4: document and test clone --branch
      git-p4: honor --changesfile option and test
      git-p4: document and test --import-local
      git-p4: test --max-changes
      git-p4: test --keep-path
      git-p4: test and document --use-client-spec
      git-p4: document and test submit options
      git-p4: test client view handling
      git-p4: rewrite view handling
      git-p4: view spec documentation

Ramkumar Ramachandra (11):
      t3200 (branch): fix '&&' chaining
      test: fix '&&' chaining
      t3030 (merge-recursive): use test_expect_code
      t1510 (worktree): fix '&&' chaining
      t3040 (subprojects-basic): fix '&&' chaining, modernize style
      revert: free msg in format_todo()
      revert: make commit subjects in insn sheet optional
      revert: tolerate extra spaces, tabs in insn sheet
      revert: simplify getting commit subject in format_todo()
      t3510 (cherry-pick-sequencer): use exit status
      t3502, t3510: clarify cherry-pick -m failure

Ramsay Allan Jones (3):
      builtin/log.c: Fix an "Using plain integer as NULL pointer" warni=
ng
      environment.c: Fix an sparse "symbol not declared" warning
      fmt-merge-msg.c: Fix an "dubious one-bit signed bitfield" sparse =
error

Raphael Zimmerer (1):
      gitk: When a commit contains a note, mark it with a yellow box

Ren=C3=A9 Scharfe (5):
      read-cache.c: allocate index entries individually
      cache.h: put single NUL at end of struct cache_entry
      use struct sha1_array in diff_tree_combined()
      pass struct commit to diff_tree_combined_merge()
      submodule: use diff_tree_combined_merge() instead of diff_tree_co=
mbined()

SZEDER G=C3=A1bor (9):
      completion: document __gitcomp()
      completion: optimize refs completion
      completion: make refs completion consistent for local and remote =
repos
      completion: improve ls-remote output filtering in __git_refs()
      completion: support full refs from remote repositories
      completion: query only refs/heads/ in __git_refs_remotes()
      completion: improve ls-remote output filtering in __git_refs_remo=
tes()
      completion: fast initial completion for config 'remote.*.fetch' v=
alue
      completion: remove broken dead code from __git_heads() and __git_=
tags()

Samuel Bronson (1):
      git-gui: Set both 16x16 and 32x32 icons on X to pacify Xming.

Sebastian Morr (1):
      Add MYMETA.yml to perl/.gitignore

Steven Walter (1):
      git-svn.perl: close the edit for propedits even with no mods

Thomas Jarosch (1):
      imap-send: Remove unused 'use_namespace' variable

Thomas Rast (13):
      userdiff: allow * between cpp funcname words
      Add test-scrap-cache-tree
      Test the current state of the cache-tree optimization
      Refactor cache_tree_update idiom from commit
      commit: write cache-tree data when writing index anyway
      reset: update cache-tree data when appropriate
      grep: load funcname patterns for -W
      grep: enable threading with -p and -W using lazy attribute lookup
      grep: disable threading in non-worktree case
      test-terminal: set output terminals to raw mode
      git-sh-setup: make require_clean_work_tree part of the interface
      bash completion: use read -r everywhere
      Documentation: rerere.enabled is the primary way to configure rer=
ere

Tilman Vogel (1):
      git-gui: add config value gui.diffopts for passing additional dif=
f options

Vincent van Ravesteijn (4):
      Compile fix for MSVC: Do not include sys/resources.h
      Compile fix for MSVC: Include <io.h>
      MSVC: Remove unneeded header stubs
      Show error for 'git merge' with unset merge.defaultToUpstream

Yggy King (1):
      gitk: Make "touching paths" search support backslashes

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (9):
      apply: get rid of useless x < 0 comparison on a size_t type
      cast variable in call to free() in builtin/diff.c and submodule.c
      pull: introduce a pull.rebase option to enable --rebase
      i18n: add infrastructure for translating Git with gettext
      t/t2023-checkout-m.sh: fix use of test_must_fail
      builtin/init-db.c: eliminate -Wformat warning on Solaris
      Fix an enum assignment issue spotted by Sun Studio
      Fix a bitwise negation assignment issue spotted by Sun Studio
      Appease Sun Studio by renaming "tmpfile"
