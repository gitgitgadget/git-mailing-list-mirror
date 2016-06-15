From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2010, #05; Sun, 21)
Date: Sun, 21 Feb 2010 16:19:18 -0800
Message-ID: <7vtytacebd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 01:52:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjM1K-0000fw-9C
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 01:19:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955Ab0BVATZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 19:19:25 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37084 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748Ab0BVATX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 19:19:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2700F9CB07;
	Sun, 21 Feb 2010 19:19:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=Venl
	CGhkCgG3wr2XB1J0KEpZb2E=; b=B4oVu0Dd0QTCTNUFCiM8zYl5yh3sY8U4ZCip
	/hjrStUF5X9mZkk6O3a0bG0xy+s8TMyIOBtx/yCctKa5EVz/zYUgG2sd4E1buakA
	KI0Ojdh9u/znue7QVAwOAjBR3RaHLbvp2wFNmANWQSNXSOXqhnrpaqthPOKdMPSx
	/19DpbY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=iiE
	3JR1fZcPRXsnUzblZDG1MFCxzkpevdlskVUwb5EAx4eTjScjfcL/aKz6rwO7h2ps
	pbrJXMV8rdBbpS2HkhaIKJ/IXRYt9XF8f9+KyxqLzDKxoAt2GOqTkIdPgb4pTpec
	vUF3T15pSbHul8pQzQ7+/cOBSQv8Sgwnbsq5nG4A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E824A9CB06;
	Sun, 21 Feb 2010 19:19:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 92B6D9CB05; Sun, 21 Feb
 2010 19:19:19 -0500 (EST)
X-master-at: 241b9254e1c8ff071d8054f8b6fbe1883b389d69
X-next-at: d52c051f421da80f7dc5fed68a7046d70d06d008
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ECAA0A44-1F47-11DF-8865-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140626>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

--------------------------------------------------
[Graduated to "master"]

* np/fast-import-idx-v2 (2010-02-17) 6 commits
 + fast-import: use the diff_delta() max_delta_size argument
 + fast-import: honor pack.indexversion and pack.packsizelimit config vars
 + fast-import: make default pack size unlimited
 + fast-import: use write_idx_file() instead of custom code
 + fast-import: use sha1write() for pack data
 + fast-import: start using struct pack_idx_entry

* ml/maint-grep-doc (2010-02-15) 1 commit
  (merged to 'next' on 2010-02-16 at 4059a38)
 + grep documentation: clarify what files match

* tc/maint-transport-ls-remote-with-void (2010-02-16) 1 commit
  (merged to 'next' on 2010-02-16 at e6ef1a8)
 + transport: add got_remote_refs flag

* hm/maint-imap-send-crlf (2010-02-12) 1 commit
  (merged to 'next' on 2010-02-17 at c6162cb)
 + git-imap-send: Convert LF to CRLF before storing patch to draft box

* sp/maint-push-sideband (2010-02-10) 8 commits
  (merged to 'next' on 2010-02-16 at 6f19e5b)
 + receive-pack: Send internal errors over side-band #2
 + t5401: Use a bare repository for the remote peer
 + receive-pack: Send hook output over side band #2
 + receive-pack: Wrap status reports inside side-band-64k
 + receive-pack: Refactor how capabilities are shown to the client
 + send-pack: demultiplex a sideband stream with status data
 + run-command: support custom fd-set in async
 + run-command: Allow stderr to be a caller supplied pipe
 (this branch is used by sp/push-sideband.)

Based on 1.6.5 maintenance track, later to be merged to 1.6.X maintenance
series if needed.

* sp/push-sideband (2010-02-10) 0 commits
 (this branch uses sp/maint-push-sideband.)

* jc/checkout-detached (2010-01-29) 1 commit
  (merged to 'next' on 2010-02-17 at 7e03edc)
 + Reword "detached HEAD" notification

* jc/maint-fix-test-perm (2010-01-30) 2 commits
  (merged to 'next' on 2010-02-16 at 9d2e037)
 + lib-patch-mode.sh: Fix permission
 + t6000lib: Fix permission

* jn/makefile-script-lib (2010-01-31) 1 commit
  (merged to 'next' on 2010-02-16 at f5334f5)
 + Do not install shell libraries executable

* mv/request-pull-modernize (2010-01-29) 1 commit
  (merged to 'next' on 2010-02-16 at be03aad)
 + request-pull: avoid mentioning that the start point is a single commit

--------------------------------------------------
[New Topics]

* dp/read-not-mmap-small-loose-object (2010-02-21) 1 commit
 - hash-object: don't use mmap() for small files

I treaked the cut-off based on my reading of Dmitry's numbers.

* np/compress-loose-object-memsave (2010-02-20) 1 commit
 . sha1_file: don't malloc the whole compressed result when writing out objects

* jc/maint-add-paranoid (2010-02-19) 2 commits
 - paranoid: avoid unnecessary re-hashing
 - Teach "git add" and friends to be paranoid

This conflicts rather badly with more logical change by Nicolas in the
other thread; perhaps we should drop this "paranoia" for now.

* jc/maint-fix-mailinfo-strip (2010-02-19) 1 commit
 - mailinfo: do not strip leading spaces even for a header line

Linus noticed that an indented first line in the log message body loses
its indentation.  Lukas sent a lot more intrusive patch to keep the
removal of leading spaces for header lines while avoiding this issue, but
I think removing the leading blanks is wrong in either the message or
in-body header.

* ne/pack-local-doc (2010-02-18) 1 commit
 - Documentation: pack-objects: Clarify --local's semantics.

Comments from pack experts?

* ml/connect-refactor (2010-02-17) 1 commit
 - connect.c: move duplicated code to a new function 'get_host_and_port'

* ml/encode-header-refactor (2010-02-16) 1 commit
 - refactor duplicated encode_header in pack-objects and fast-import

* ml/fill-mm-refactor (2010-02-16) 1 commit
 - refactor duplicated fill_mm() in checkout and merge-recursive

These three should be safe for 'next' but I postponed them because they
were distractions compared to other topics I wanted to proccess first.

* mm/mkstemps-mode-for-packfiles (2010-02-20) 6 commits
 - Use git_mkstemp_mode instead of plain mkstemp to create object files
 - git_mkstemps_mode: do not overwrite errno
 - Use git_mkstemp_mode and xmkstemp_mode in odb_mkstemp, not chmod later.
 - git_mkstemp_mode, xmkstemp_mode: variants of gitmkstemps with mode argument.
 - Move gitmkstemps to path.c
 - Add a testcase for ACL with restrictive umask.

The test does not seem to pass for me.

* rs/optim-text-wrap (2010-02-19) 4 commits
  (merged to 'next' on 2010-02-21 at 70ef189)
 + utf8.c: speculatively assume utf-8 in strbuf_add_wrapped_text()
 + utf8.c: remove strbuf_write()
 + utf8.c: remove print_spaces()
 + utf8.c: remove print_wrapped_text()

* tr/maint-cherry-pick-list (2010-02-20) 1 commit
  (merged to 'next' on 2010-02-21 at 65fded0)
 + cherry_pick_list: quit early if one side is empty

* tc/transport-verbosity (2010-02-18) 9 commits
 - transport: update flags to be in running order
 - pull: learn --progress
 - fetch: learn --progress
 - push: learn --progress
 - transport->progress: use flag authoritatively
 - clone: support multiple levels of verbosity
 - push: support multiple levels of verbosity
 - fetch: refactor verbosity option handling into transport.[ch]
 - Documentation/git-push.txt: put --quiet before --verbose

--------------------------------------------------
[Stalled]

* ld/push-porcelain (2010-02-09) 4 commits
 - git-push: fix an error message so it goes to stderr
 - git-push: make git push --dry-run --porcelain exit with status 0 even if updates will be rejected
 - git-push: send "To <remoteurl>" messages to the standard output in --porcelain mode
 - git-push: squelch advice message if in --porcelain mode

This needs further simplification, judging from the previous discussion?

* ld/maint-diff-quiet-w (2010-02-16) 1 commit
 - git diff --quiet -w: check and report the status

Needs tests but otherwise looked Ok.

* sd/format-patch-to (2010-02-17) 1 commit
 - Add 'git format-patch --to=' option and 'format.to' configuration variable.

Shouldn't be too hard to add tests to t4014; other than that looked ready
for 'next'.

* sd/init-template (2010-02-17) 2 commits
 - Add a "TEMPLATE DIRECTORY" section to git-init[1].
 - Add `init.templatedir` configuration variable.

Shouldn't be too hard to add tests to t0001; other than that looked ready
for 'next'.

* sd/log-decorate (2010-02-17) 3 commits
 - log.decorate: usability fixes
 - Add `log.decorate' configuration variable.
 - git_config_maybe_bool()

Probably ready for 'next', except that people need to be warned about
having to update their scripts to explicitly pass --no-decorate to keep
them working.

* pb/log-first-parent-p-m (2010-02-10) 1 commit
  (merged to 'next' on 2010-02-17 at 2f8e5ae)
 + git log -p -m: document -m and honor --first-parent

Needs tests but otherwise looked fine.  We might want to teach "-m trumps
implicit --cc" to "git show", but that is a totally separate topic.

* js/rebase-origin-x (2010-02-05) 1 commit
 - [RFC w/o test and incomplete] rebase: add -x option to record original commit name

I retract my objection against the idea of -x; needs polishing before
moving forward.

--------------------------------------------------
[Cooking]

* cp/add-u-pathspec (2010-02-09) 2 commits
 - test for add with non-existent pathspec
 - git add -u: die on unmatched pathspec

I am a bit torn on this one.  Traditionally we never complained on
unmatched pathspec when talking about tracked files.  If we were to go
this route, I think we should probably enhance the "run_diff_files" and
friends in such a way that they mark matched pathspecs, in a way similar
to match_pathspec() in dir.c does, and report unmatched ones based on
that result, instead of adding an extra pass to scan the index.  The same
goes for pathspec_matches() in builtin-grep.c

Incidentally, I've proposed "pathspec unification" as possible GSoC'10
project---with luck, we might finally see a progress on this front ;-)

* jc/for-each-ref (2010-02-13) 4 commits
  (merged to 'next' on 2010-02-21 at c9a6c2f)
 + for-each-ref --format='%(flag)'
 + for-each-ref --format='%(symref) %(symref:short)'
 + builtin-for-each-ref.c: check if we need to peel onion while parsing the format
 + builtin-for-each-ref.c: comment fixes

* jn/gitweb-config-error-die (2010-02-14) 1 commit
  (merged to 'next' on 2010-02-21 at e3ecd65)
 + gitweb: Die if there are parsing errors in config file

* jn/maint-fix-pager (2010-02-20) 7 commits
  (merged to 'next' on 2010-02-21 at 640e10c)
 + t7006-pager: if stdout is not a terminal, make a new one
 + tests: Add tests for automatic use of pager
 + am: Fix launching of pager
 + git svn: Fix launching of pager
 + git.1: Clarify the behavior of the --paginate option
 + Make 'git var GIT_PAGER' always print the configured pager
 + Fix 'git var' usage synopsis

* ml/color-when (2010-02-16) 1 commit
  (merged to 'next' on 2010-02-21 at d52c051)
 + Add an optional argument for --color options

* hm/imap-send-cram-md5 (2010-02-15) 1 commit
 - imap-send: support CRAM-MD5 authentication

A potential clean-up sent as a counter-proposal; waiting for response.

* jh/maint-submodule-status-in-void (2010-02-16) 1 commit
  (merged to 'next' on 2010-02-21 at 2e605c3)
 + submodule summary: Don't barf when invoked in an empty repo

* bg/apply-blank-at-eof (2010-02-17) 3 commits
 - t3417: Add test cases for "rebase --whitespace=fix"
 - t4124: Add additional tests of --whitespace=fix
 - apply: Allow blank context lines to match beyond EOF

RFC.

* gf/maint-sh-setup-nongit-ok (2010-02-16) 1 commit
  (merged to 'next' on 2010-02-21 at aca55e6)
 + require_work_tree broken with NONGIT_OK

* ml/send-pack-transport-refactor (2010-02-16) 1 commit
  (merged to 'next' on 2010-02-21 at db276f4)
 + refactor duplicated code in builtin-send-pack.c and transport.c

* jc/maint-status-preload (2010-02-17) 1 commit
 - status: preload index to optimize lstat(2) calls

* nd/root-git (2010-02-14) 5 commits
 - Add test for using Git at root of file system
 - Support working directory located at root
 - Move offset_1st_component() to path.c
 - init-db, rev-parse --git-dir: do not append redundant slash
 - make_absolute_path(): Do not append redundant slash

* ac/cvsimport-revision-mapping (2010-02-06) 1 commit
  (merged to 'next' on 2010-02-17 at 6756446)
 + cvsimport: new -R option: generate .git/cvs-revisions mapping

Will merge to 'master' shortly unless negative comments from CVSimport
users comes.

* jn/maint-makedepend (2010-01-26) 5 commits
  (merged to 'next' on 2010-02-21 at 34a3e48)
 + Makefile: drop dependency on $(wildcard */*.h)
 + Makefile: clean up http-walker.o dependency rules
 + Makefile: remove wt-status.h from LIB_H
 + Makefile: make sure test helpers are rebuilt when headers change
 + Makefile: add missing header file dependencies
 (this branch is used by jn/makedepend and jn/master-makedepend.)

* jn/master-makedepend (2010-01-26) 0 commits
 (this branch uses jn/maint-makedepend; is used by jn/makedepend.)

This is to help merging the clean-up to "master".

* jn/makedepend (2010-01-31) 9 commits
  (merged to 'next' on 2010-02-21 at 34a3e48)
 + Makefile: always remove .depend directories on 'make clean'
 + Makefile: tuck away generated makefile fragments in .depend
 + Teach Makefile to check header dependencies
 + Makefile: list standalone program object files in PROGRAM_OBJS
 + Makefile: lazily compute header dependencies
 + Makefile: list generated object files in OBJECTS
 + Makefile: disable default implicit rules
 + Makefile: rearrange dependency rules
 + Makefile: transport.o depends on branch.h now
 (this branch uses jn/maint-makedepend and jn/master-makedepend.)

* jh/notes (2010-02-13) 30 commits
  (merged to 'next' on 2010-02-21 at 75fc451)
 + builtin-notes: Add "copy" subcommand for copying notes between objects
 + builtin-notes: Misc. refactoring of argc and exit value handling
 + builtin-notes: Add -c/-C options for reusing notes
 + builtin-notes: Refactor handling of -F option to allow combining -m and -F
 + builtin-notes: Deprecate the -m/-F options for "git notes edit"
 + builtin-notes: Add "append" subcommand for appending to note objects
 + builtin-notes: Add "add" subcommand for adding notes to objects
 + builtin-notes: Add --message/--file aliases for -m/-F options
 + builtin-notes: Add "list" subcommand for listing note objects
 + Documentation: Generalize git-notes docs to 'objects' instead of 'commits'
 + builtin-notes: Add "prune" subcommand for removing notes for missing objects
 + Notes API: prune_notes(): Prune notes that belong to non-existing objects
 + t3305: Verify that removing notes triggers automatic fanout consolidation
 + builtin-notes: Add "remove" subcommand for removing existing notes
 + Teach builtin-notes to remove empty notes
 + Teach notes code to properly preserve non-notes in the notes tree
 + t3305: Verify that adding many notes with git-notes triggers increased fanout
 + t3301: Verify successful annotation of non-commits
 + Builtin-ify git-notes
 + Refactor notes concatenation into a flexible interface for combining notes
 + Notes API: Allow multiple concurrent notes trees with new struct notes_tree
 + Notes API: write_notes_tree(): Store the notes tree in the database
 + Notes API: for_each_note(): Traverse the entire notes tree with a callback
 + Notes API: get_note(): Return the note annotating the given object
 + Notes API: remove_note(): Remove note objects from the notes tree structure
 + Notes API: add_note(): Add note objects to the internal notes tree structure
 + Notes API: init_notes(): Initialize the notes tree from the given notes ref
 + Add tests for checking correct handling of $GIT_NOTES_REF and core.notesRef
 + Notes API: get_commit_notes() -> format_note() + remove the commit restriction
 + Minor cosmetic fixes to notes.c

* jc/grep-author-all-match-implicit (2010-01-17) 1 commit
  (merged to 'next' on 2010-02-17 at 3b7be80)
 + "log --author=me --grep=it" should find intersection, not union

* jh/gitweb-caching (2010-01-30) 1 commit
 - gitweb: Add an option to force version match

The controversial one.  Will probably drop this.  RFC v3 of gitweb caching
series needs to be queued but hasn't happened yet.

* cc/reset-keep (2010-01-19) 5 commits
 - reset: disallow using --keep when there are unmerged entries
 - reset: disallow "reset --keep" outside a work tree
 - Documentation: reset: describe new "--keep" option
 - reset: add test cases for "--keep" option
 - reset: add option "--keep" to "git reset"
