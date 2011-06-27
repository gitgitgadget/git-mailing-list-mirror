From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.6
Date: Mon, 27 Jun 2011 08:59:19 -0700
Message-ID: <7v8vsnz2nc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 27 17:59:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbEDy-0001DM-98
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 17:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752652Ab1F0P7a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Jun 2011 11:59:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41921 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483Ab1F0P7X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2011 11:59:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6CF5C551F;
	Mon, 27 Jun 2011 12:01:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=atHjyhUdrDjktvVT5ZobXiqTY
	xI=; b=be62vMlelfU9xJdmEYXtK0Ihlxba1ssWQV99lVktsOsoIFAH1WFezG17X
	ybQi9CmsOowd4Bf0fJZyghNL2EZNFUGN7ijfHsboeIidT3iyg7jRE3KnXCv1u8Ef
	JcPzFpgfBhj281fPT8BYfr3EIyuMeXYnE1kpdszdm+DTmwWlGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=AZNPE2k2I1JmlcPjfJX
	z9LJy6HTFWCA21nfA0b0X+9VXuvH3FEZ0mSDGPUtYAHBGmw8sJOXdr6EMdn7tBh8
	gqoToM7uyPbuDoiyS6gVc5mecb10aCTq38gW/nRPjO8AYjjG3oQwEW3HKSGEnH7a
	bRCdmbBWReK03+7vltAPRU8k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 63630551E;
	Mon, 27 Jun 2011 12:01:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D7FA8551D; Mon, 27 Jun 2011
 12:01:32 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA3A4328-A0D6-11E0-B4FB-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176349>

The latest feature release Git 1.7.6 is available at the usual
places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.6.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.6.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.6.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.7.6-1.fc13.$arch.rpm	(RPM)

Git v1.7.6 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Updates since v1.7.5
--------------------

 * Various git-svn updates.

 * Updates the way content tags are handled in gitweb.  Also adds
   a UI to choose common timezone for displaying the dates.

 * Similar to branch names, tagnames that begin with "-" are now
   disallowed.

 * Clean-up of the C part of i18n (but not l10n---please wait)
   continues.

 * The scripting part of the codebase is getting prepared for i18n/l10n=
=2E

 * Pushing and pulling from a repository with large number of refs that
   point to identical commits are optimized by not listing the same com=
mit
   during the common ancestor negotiation exchange with the other side.

 * Adding a file larger than core.bigfilethreshold (defaults to 1/2 Gig=
)
   using "git add" will send the contents straight to a packfile withou=
t
   having to hold it and its compressed representation both at the same
   time in memory.

 * Processes spawned by "[alias] <name> =3D !process" in the configurat=
ion
   can inspect GIT_PREFIX environment variable to learn where in the
   working tree the original command was invoked.

 * A magic pathspec ":/" tells a command that limits its operation to
   the current directory when ran from a subdirectory to work on the
   entire working tree. In general, ":/path/to/file" would be relative
   to the root of the working tree hierarchy.

   After "git reset --hard; edit Makefile; cd t/", "git add -u" would
   be a no-op, but "git add -u :/" would add the updated contents of
   the Makefile at the top level. If you want to name a path in the
   current subdirectory whose unusual name begins with ":/", you can
   name it by "./:/that/path" or by "\:/that/path".

 * "git blame" learned "--abbrev[=3D<n>]" option to control the minimum
   number of hexdigits shown for commit object names.

 * "git blame" learned "--line-porcelain" that is less efficient but is
   easier to parse.

 * Aborting "git commit --interactive" discards updates to the index
   made during the interactive session.

 * "git commit" learned a "--patch" option to directly jump to the
   per-hunk selection UI of the interactive mode.

 * "git diff" and its family of commands learned --dirstat=3D0 to show
   directories that contribute less than 0.1% of changes.

 * "git diff" and its family of commands learned --dirstat=3Dlines mode=
 to
   assess damage to the directory based on number of lines in the patch
   output, not based on the similarity numbers.

 * "git format-patch" learned "--quiet" option to suppress the output o=
f
   the names of generated files.

 * "git format-patch" quotes people's names when it has RFC822 special
   characters in it, e.g. "Junio C. Hamano" <jch@example.com>.  Earlier
   it was up to the user to do this when using its output.

 * "git format-patch" can take an empty --subject-prefix now.

 * "git grep" learned the "-P" option to take pcre regular expressions.

 * "git log" and friends learned a new "--notes" option to replace the
   "--show-notes" option.  Unlike "--show-notes", "--notes=3D<ref>" doe=
s
   not imply showing the default notes.

 * They also learned a log.abbrevCommit configuration variable to augme=
nt
   the --abbrev-commit command line option.

 * "git ls-remote" learned "--exit-code" option to consider it a
   different kind of error when no remote ref to be shown.

 * "git merge" learned "-" as a short-hand for "the previous branch", j=
ust
   like the way "git checkout -" works.

 * "git merge" uses "merge.ff" configuration variable to decide to alwa=
ys
   create a merge commit (i.e. --no-ff, aka merge.ff=3Dno), refuse to c=
reate
   a merge commit (i.e. --ff-only, aka merge.ff=3Donly). Setting merge.=
ff=3Dyes
   (or not setting it at all) restores the default behaviour of allowin=
g
   fast-forward to happen when possible.

 * p4-import (from contrib) learned a new option --preserve-user.

 * "git read-tree -m" learned "--dry-run" option that reports if a merg=
e
   would fail without touching the index nor the working tree.

 * "git rebase" that does not specify on top of which branch to rebase
   the current branch now uses @{upstream} of the current branch.

 * "git rebase" finished either normally or with --abort did not
   update the reflog for HEAD to record the event to come back to
   where it started from.

 * "git remote add -t only-this-branch --mirror=3Dfetch" is now allowed=
=2E Earlier
   a fetch-mode mirror meant mirror everything, but now it only means r=
efs are
   not renamed.

 * "git rev-list --count" used with "--cherry-mark" counts the cherry-p=
icked
   commits separately, producing more a useful output.

 * "git submodule update" learned "--force" option to get rid of local
   changes in submodules and replace them with the up-to-date version.

 * "git status" and friends ignore .gitmodules file while the file is
   still in a conflicted state during a merge, to avoid using informati=
on
   that is not final and possibly corrupt with conflict markers.

Also contains various documentation updates and minor miscellaneous
changes.


=46ixes since v1.7.5
------------------

Unless otherwise noted, all the fixes in 1.7.5.X maintenance track are
included in this release.

 * "git config" used to choke with an insanely long line.
   (merge ef/maint-strbuf-init later)

 * "git diff --quiet" did not work well with --diff-filter.
   (merge jk/diff-not-so-quick later)

 * "git status -z" did not default to --porcelain output format.
   (merge bc/maint-status-z-to-use-porcelain later)


----------------------------------------------------------------

Changes since v1.7.5 are as follows:

Alex Riesen (2):
      clean: unreadable directory may still be rmdir-able if it is empt=
y
      t3703: skip more tests using colons in file names on Windows

Andreas Schwab (1):
      builtin/gc.c: add missing newline in message

Andrew Wong (1):
      git-rebase--interactive.sh: preserve-merges fails on merges creat=
ed with no-ff

Boris Faure (1):
      Do not strip empty lines / trailing spaces from a commit message =
template

Brandon Casey (5):
      Documentation/technical/api-diff.txt: correct name of diff_unmerg=
e()
      git-submodule.sh: separate parens by a space to avoid confusing s=
ome shells
      t7508: demonstrate status's failure to use --porcelain format wit=
h -z
      builtin/commit.c: set status_format _after_ option parsing
      sh-i18n--envsubst.c: do not #include getopt.h

Brian Gernhardt (1):
      t/annotate-tests: Use echo & cat instead of sed

Carlos Mart=C3=ADn Nieto (3):
      format-patch: don't pass on the --quiet flag
      format-patch: document --quiet option
      log: convert to parse-options

Christof Kr=C3=BCger (1):
      Documentation: git diff --check respects core.whitespace

Ciaran Jessup (1):
      Pass empty file to p4merge where no base is suitable.

Conrad Irwin (5):
      Use a temporary index for git commit --interactive
      Allow git commit --interactive with paths
      Add support for -p/--patch to git-commit
      Add commit to list of config.singlekey commands
      Test atomic git-commit --interactive

Csaba Henk (1):
      rebase: create HEAD reflog entry when aborting

Dan McGee (6):
      Share color list between graph and show-branch
      stash: add two more tests for --no-keep-index
      stash: ensure --no-keep-index and --patch can be used in any orde=
r
      http: make curl callbacks match contracts from curl header
      http-push: use const for strings in signatures
      http-push: refactor curl_easy_setup madness

Dima Sharov (1):
      shell: add missing initialization of argv0_path

Dmitry Ivankov (1):
      Fix typo: existant->existent

Elijah Newren (3):
      t6022: New test checking for unnecessary updates of renamed+modif=
ied files
      t6022: New test checking for unnecessary updates of files in D/F =
conflicts
      merge-recursive: When we detect we can skip an update, actually s=
kip it

Erik Faye-Lund (2):
      strbuf: make sure buffer is zero-terminated
      config: support values longer than 1023 bytes

=46elipe Contreras (1):
      git-completion: fix regression in zsh support

=46raser Tweedale (1):
      gitweb: supply '-n' to gzip for identical output

Guy Rouillier (1):
      Look for password in both CVS and CVSNT password files.

Heiko Voigt (1):
      test that git status works with merge conflict in, .gitmodules

Ingo Molnar (1):
      hashcmp(): inline memcmp() by hand to optimize

Jakub Narebski (20):
      gitweb: Restructure projects list generation
      gitweb: Change the way "content tags" ('ctags') are handled
      gitweb: Mark matched 'ctag' / contents tag (?by_tag=3Dfoo)
      git-instaweb: Simplify build dependency on gitweb
      Remove gitweb/gitweb.cgi and other legacy targets from main Makef=
ile
      gitweb: Split JavaScript for maintability, combining on build
      gitweb.js: Update and improve comments in JavaScript files
      gitweb.js: Provide default values for padding in padLeftStr and p=
adLeft
      gitweb.js: Extract and improve datetime handling
      gitweb.js: Introduce code to handle cookies from JavaScript
      gitweb.js: Provide getElementsByClassName method (if it not exist=
s)
      gitweb: Refactor generating of long dates into format_timestamp_h=
tml
      gitweb: Unify the way long timestamp is displayed
      gitweb: Make JavaScript ability to adjust timezones configurable
      gitweb: Refactor reading and parsing config file into read_config=
_file
      gitweb: Move information about installation from README to INSTAL=
L
      gitweb: Describe CSSMIN and JSMIN in gitweb/INSTALL
      gitweb: Move "Requirements" up in gitweb/INSTALL
      gitweb: Fix usability of $prevent_xss
      gitweb: 'pickaxe' and 'grep' features requires 'search' to be ena=
bled

Jay Soffian (2):
      "git log -h": typofix misspelled 'suppress'
      Add log.abbrevCommit config variable

Jeff King (51):
      notes: make expand_notes_ref globally accessible
      revision.c: refactor notes ref expansion
      notes: refactor display notes extra refs field
      notes: refactor display notes default handling
      revision.c: support --notes command-line option
      revision.c: make --no-notes reset --notes list
      stash: fix accidental apply of non-existent stashes
      stash: drop dirty worktree check on apply
      upload-pack: start pack-objects before async rev-list
      format-patch: wrap email addresses after long names
      pretty: quote rfc822 specials in email addresses
      add tests for merge-index / merge-one-file
      merge-one-file: fix broken merges with alternate work trees
      send-pack: unbreak push over stateless rpc
      add tests for various blame formats
      blame: refactor porcelain output
      blame: add --line-porcelain output format
      t7501.8: feed a meaningful command
      cherry-pick: handle root commits with external strategies
      revert: allow reverting a root commit
      t3503: test cherry picking and reverting root commits
      connect: treat generic proxy processes like ssh processes
      connect: let callers know if connection is a socket
      send-pack: avoid deadlock on git:// push with failed pack-objects
      test core.gitproxy configuration
      fetch: avoid repeated commits in mark_complete
      Makefile: sort TEST_PROGRAMS list
      refactor refs_from_alternate_cb to allow passing extra data
      bisect: refactor sha1_array into a generic sha1 list
      receive-pack: eliminate duplicate .have refs
      doc: discuss textconv versus external diff drivers
      config: make environment parsing routines static
      git_config: don't peek at global config_parameters
      config: always parse GIT_CONFIG_PARAMETERS during git_config
      read_gitfile_gently: use ssize_t to hold read result
      remote: allow "-t" with fetch mirrors
      read_in_full: always report errors
      t: test subject handling in format-patch / am pipeline
      mailinfo: always clean up rfc822 header folding
      pretty: add pp_commit_easy function for simple callers
      clean up calling conventions for pretty.c functions
      format-patch: preserve subject newlines with -k
      docs: minor grammar fixes to git-status
      docs: update status --porcelain format
      docs: make sure literal "->" isn't converted to arrow
      docs: fix some antique example output
      rebase: write a reflog entry when finishing
      format-patch: make zero-length subject prefixes prettier
      diff_tree: disable QUICK optimization with diff filter
      t/Makefile: pass test opts to valgrind target properly
      tests: link shell libraries into valgrind directory

Jens Lehmann (3):
      Submodules: Don't parse .gitmodules when it contains, merge confl=
icts
      unpack-trees: add the dry_run flag to unpack_trees_options
      Teach read-tree the -n|--dry-run option

Jim Meyering (9):
      diffcore-rename.c: avoid set-but-not-used warning
      Documentation/git-fsck.txt: fix typo: unreadable -> unreachable
      do not read beyond end of malloc'd buffer
      rerere.c: diagnose a corrupt MERGE_RR when hitting EOF between TA=
B and '\0'
      plug a DIR buffer leak in rerere.c
      remove tests of always-false condition
      diffcore-rename.c: avoid set-but-not-used warning
      fetch: do not leak a refspec
      plug a few coverity-spotted leaks

Johan Herland (15):
      log/pretty-options: Document --[no-]notes and deprecate old notes=
 options
      Make "git notes add" more user-friendly when there are existing n=
otes
      --dirstat: Describe non-obvious differences relative to --stat or=
 regular diff
      --dirstat-by-file: Make it faster and more correct
      Teach --dirstat not to completely ignore rearranged lines within =
a file
      --dirstat: In case of renames, use target filename instead of sou=
rce filename
      Add several testcases for --dirstat and friends
      Make --dirstat=3D0 output directories that contribute < 0.1% of c=
hanges
      Refactor --dirstat parsing; deprecate --cumulative and --dirstat-=
by-file
      Add config variable for specifying default --dirstat behavior
      Allow specifying --dirstat cut-off percentage as a floating point=
 number
      New --dirstat=3Dlines mode, doing dirstat analysis based on diffs=
tat
      Improve error handling when parsing dirstat parameters
      Mark dirstat error messages for translation
      t5400: Fix a couple of typos

Johannes Sixt (6):
      Documentation/format-patch: suggest Toggle Word Wrap add-on for T=
hunderbird
      send-pack: avoid deadlock when pack-object dies early
      Honor $(prefix) set in config.mak* when defining ETC_GIT*
      t3703: Skip tests using directory name ":" on Windows
      Tweak t3102-ls-tree-wildcards to run on Windows
      Windows: add a wrapper for the shutdown() system call

John 'Warthog9' Hawley (2):
      gitweb: JavaScript ability to adjust time based on timezone
      gitweb.js: Add UI for selecting common timezone to display dates

Jon Seymour (2):
      stash: fix false positive in the invalid ref test.
      git: add --info-path and --man-path options

Jonathan Nieder (28):
      Revert "t0081 (line-buffer): add buffering tests"
      Restructure documentation for git-merge-base.
      Documentation: describe the format of messages with inline patche=
s
      Documentation: explain how to check for patch corruption
      Documentation: hints for sending patches inline with Thunderbird
      Documentation: publicize KMail hints for sending patches inline
      Documentation: publicize hints for sending patches with GMail
      tests: check error message from run_command
      run-command: handle short writes and EINTR in die_child
      revisions: split out handle_revision_pseudo_opt function
      revisions: allow --glob and friends in parse_options-enabled comm=
ands
      Documentation: clarify meaning of --html-path, --man-path, and --=
info-path
      tests: eliminate unnecessary setup test assertions
      tests: teach verify_parents to check for extra parents
      tests: check git does not barf on merge.ff values for future vers=
ions of git
      completion: move private shopt shim for zsh to __git_ namespace
      add, merge, diff: do not use strcasecmp to compare config variabl=
e names
      provide a copy of the LGPLv2.1
      t4018 (funcname patterns): make .gitattributes state easier to tr=
ack
      t4018 (funcname patterns): make configuration easier to track
      t4018 (funcname patterns): minor cleanups
      userdiff/perl: anchor "sub" and "package" patterns on the left
      userdiff/perl: match full line of POD headers
      userdiff/perl: catch sub with brace on second line
      tests: make test_expect_code quieter on success
      userdiff/perl: tighten BEGIN/END block pattern to reject here-doc=
 delimiters
      Documentation: do not misinterpret refspecs as bold text
      gitweb: do not misparse nonnumeric content tag files that contain=
 a digit

Jonathon Mah (1):
      mergetool: Teach about submodules

Josh Stone (1):
      blame: tolerate bogus e-mail addresses a bit better

Jo=C3=A3o Britto (1):
      Remove duplicated "is a"

Junio C Hamano (112):
      merge-recursive: tweak magic band-aid
      builtin/diff.c: remove duplicated call to diff_result_code()
      diffcore-rename: refactor "too many candidates" logic
      diffcore-rename: record filepair for rename src
      diffcore-rename: fall back to -C when -C -C busts the rename limi=
t
      git diff -D: omit the preimage of deletes
      pathspec: rename per-item field has_wildcard to use_wildcard
      Teach core.bigfilethreashold to pack-objects
      magic pathspec: add tentative ":/path/from/top/level" pathspec su=
pport
      merge: allow "-" as a short-hand for "previous branch"
      magic pathspec: futureproof shorthand form
      magic pathspec: add ":(icase)path" to match case insensitively
      i18n: do not overuse C_LOCALE_OUTPUT
      i18n: .git file is not a human readable message (t5601)
      i18n: use test_i18ncmp in t1200 and t2200
      i18n: do not overuse C_LOCALE_OUTPUT (grep)
      i18n: use test_i18ngrep in lib-httpd and t2019
      i18n: use test_i18ngrep in t2020, t2204, t3030, and t3200
      i18n: use test_i18ncmp and test_i18ngrep in t3203, t3501 and t350=
7
      i18n: use test_i18ncmp and test_i18ngrep in t3700, t4001 and t401=
4
      i18n: use test_i18ncmp and test_i18ngrep in t5541, t6040, t6120, =
t7004, t7012 and t7060
      i18n: use test_i18ncmp and test_i18ngrep in t7102 and t7110
      i18n: use test_i18ngrep in t7201
      i18n: use test_i18ncmp in t7500
      i18n: use test_i18ngrep in t7501
      i18n: use test_i18ngrep and test_i18ncmp in t7502
      i18n: use test_i18ngrep in t7506
      i18n: use test_i18n{grep,cmp} in t7508
      i18n: use test_i18n{cmp,grep} in t7600, t7607, t7611 and t7811
      test: use $_z40 from test-lib
      diff.c: return filepair from diff_unmerge()
      diff: remove often unused parameters from diff_unmerge()
      diff-files: show unmerged entries correctly
      Fix "add -u" that sometimes fails to resolve unmerged paths
      http: clear POSTFIELDS when initializing a slot
      Start 1.7.6 cycle
      Start 1.7.5.1 maintenance track
      add -p: 'q' should really quit
      t3701: Editing a split hunk in an "add -p" session
      add--interactive.perl: factor out repeated --recount option
      "add -p": work-around an old laziness that does not coalesce hunk=
s
      Update draft release notes to 1.7.6
      Update draft release notes to 1.7.6
      Git 1.7.5.1
      Update draft release notes to 1.7.6
      t3701: fix here document
      Update draft release notes to 1.7.6
      merge: make branch.<name>.mergeoptions correctly override merge.<=
option>
      merge: introduce merge.ff configuration variable
      rerere: libify rerere_clear() and rerere_gc()
      t3701: add-p-fix makes the last test to pass
      t1507: avoid "${parameter<op>'word'}" inside double-quotes
      index_fd(): turn write_object and format_check arguments into one=
 flag
      index_fd(): split into two helper functions
      convert: rename the "eol" global variable to "core_eol"
      convert: give saner names to crlf/eol variables, types and functi=
ons
      convert: make it safer to add conversion attributes
      convert: make it harder to screw up adding a conversion attribute
      Revert "Honor $(prefix) set in config.mak* when defining ETC_GIT*=
 and sysconfdir"
      git-grep: do not die upon -F/-P when grep.extendedRegexp is set.
      Revert "magic pathspec: add ":(icase)path" to match case insensit=
ively"
      pathspec: drop "lone : means no pathspec" from get_pathspec()
      grep: use get_pathspec() correctly
      fix overstrict :<path> diagnosis
      fix overslow :/no-such-string-ever-existed diagnostics
      rev/path disambiguation: further restrict "misspelled index entry=
" diag
      Revert "completion: don't declare 'local words' to make zsh happy=
"
      Update draft release notes to 1.7.6
      setup_revisions(): take pathspec from command line and --stdin co=
rrectly
      revision.c: leave a note for "a lone :" enhancement
      Prepare for 1.7.5.2
      Update draft release notes to 1.7.6
      Bigfile: teach "git add" to send a large file straight to a pack
      Declare lookup_replace_object() in cache.h, not in commit.h
      t6050: make sure we test not just commit replacement
      read_sha1_file(): get rid of read_sha1_file_repl() madness
      inline lookup_replace_object() calls
      read_sha1_file(): allow selective bypassing of replacement mechan=
ism
      sha1_file: typofix
      git_open_noatime(): drop unused parameter
      Update draft release notes to 1.7.5.2
      Sync release notes for 1.7.6 to exclude what are in maintenance t=
rack
      git-grep: update tests now regexp type is "last one wins"
      Makefile: Pass USE_LIBPCRE down in GIT-BUILD-OPTIONS
      sideband_demux(): fix decl-after-stmt
      Update draft release notes to 1.7.5.2
      Update release notes to 1.7.6
      notes remove: allow removing more than one
      notes remove: --ignore-missing
      notes remove: --stdin reads from the standard input
      show: --ignore-missing
      Git 1.7.5.2
      Revert "Merge branch 'en/merge-recursive'"
      Update draft release notes to 1.7.6
      Update 1.7.6 draft release notes
      require-work-tree wants more than what its name says
      handle_options(): do not miscount how many arguments were used
      userformat_find_requirements(): find requirement for the correct =
format
      compat/fnmatch/fnmatch.c: give a fall-back definition for NULL
      Git 1.7.5.3
      Update 1.7.6 draft release notes
      config.mak.in: allow "configure --sysconfdir=3D/else/where"
      log: --quiet should serve as synonym to -s
      diff: futureproof "stop feeding the backend early" logic
      Start 1.7.5.4 draft release notes
      Update draft release notes to 1.7.6
      Git 1.7.5.4
      Git 1.7.6-rc1
      Git 1.7.6-rc2
      t7810: avoid unportable use of "echo"
      Git 1.7.6-rc3
      Git 1.7.6

Kacper Kornet (1):
      Honor $(prefix) set in config.mak* when defining ETC_GIT* and sys=
confdir

Luke Diamand (3):
      git-p4: add option to preserve user names
      git-p4: small improvements to user-preservation
      git-p4: warn if git authorship won't be retained

Marius Storm-Olsen (1):
      Automatically autoload bashcompinit for ZSH, when needed

Martin von Zweigbergk (35):
      rebase: clearer names for directory variables
      rebase: refactor reading of state
      rebase: read state outside loop
      rebase: remove unused rebase state 'prev_head'
      rebase: improve detection of rebase in progress
      rebase: act on command line outside parsing loop
      rebase: stricter check of standalone sub command
      rebase: align variable names
      rebase: align variable content
      rebase: factor out command line option processing
      rebase -i: remove now unnecessary directory checks
      rebase: reorder validation steps
      rebase: factor out reference parsing
      rebase: factor out clean work tree check
      rebase: factor out call to pre-rebase hook
      rebase -i: support --stat
      rebase: remove $branch as synonym for $orig_head
      rebase: extract merge code to new source file
      rebase: extract am code to new source file
      rebase: show consistent conflict resolution hint
      rebase -i: align variable names
      rebase: make -v a tiny bit more verbose
      rebase: factor out sub command handling
      rebase: extract code for writing basic state
      rebase: remember verbose option
      rebase: remember strategy and strategy options
      rebase -m: remember allow_rerere_autoupdate option
      rebase -m: don't print exit code 2 when merge fails
      git-rebase--am: remove unnecessary --3way option
      rebase -i: don't read unused variable preserve_merges
      rebase -i: remove unnecessary state rebase-root
      rebase: use @{upstream} if no upstream specified
      Makefile: do not install sourced rebase scripts
      rebase: define options in OPTIONS_SPEC
      diffcore-rename: don't consider unmerged path as source

Mathias Lafeldt (2):
      t/README: unify documentation of test function args
      t/test-lib.sh: minor readability improvements

Michael Haggerty (1):
      git-svn: add an option to skip the creation of empty directories

Michael J Gruber (16):
      builtin/log.c: separate default and setup of cmd_log_init()
      t/t1411: test reflog with formats
      reflog: fix overriding of command line options
      t1506: factor out test for "Did you mean..."
      sha1_name: Suggest commit:./file for path in subdir
      contrib/completion: --notes, --no-notes
      date: avoid "X years, 12 months" in relative dates
      rev-list --count: separate count for --cherry-mark
      t1020: test !alias in subdirectory
      handle_alias: provide GIT_PREFIX to !alias
      config.txt,diff-options.txt: porcelain vs. plumbing for color.dif=
f
      git-fast-import.txt: --relative-marks takes no parameter
      config: define and document exit codes
      config: Give error message when not changing a multivar
      git-svn: Fix git svn log --show-commit
      sh-18n: quell "unused variable" warning

Michael Schubert (2):
      tag: disallow '-' as tag name
      ls-remote: the --exit-code option reports "no matching refs"

Micha=C5=82 Kiedrowicz (11):
      Documentation: Add --line-number to git-grep synopsis
      contrib/completion: --line-number to git grep
      grep: Put calls to fixmatch() and regmatch() into patmatch()
      grep: Fix a typo in a comment
      grep: Extract compile_regexp_failed() from compile_regexp()
      git-grep: Learn PCRE
      configure: Check for libpcre
      grep: Add basic tests
      git-grep: Bail out when -P is used with -F or -E
      git-grep: Update tests (mainly for -P)
      git-grep: Fix problems with recently added tests

Namhyung Kim (2):
      blame: add --abbrev command line option and make it honor core.ab=
brev
      completion: replace core.abbrevguard to core.abbrev

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (9):
      Reimplement read_tree_recursive() using tree_entry_interesting()
      Convert read_tree{,_recursive} to support struct pathspec
      Improve tree_entry_interesting() handling code
      setup: return correct prefix if worktree is '/'
      Kill off get_relative_cwd()
      t1011: fix sparse-checkout initialization and add new file
      sparse checkout: do not eagerly decide the fate for whole directo=
ry
      t3703, t4208: add test cases for magic pathspec
      init/clone: remove short option -L and document --separate-git-di=
r

Nicolas Morey-Chaisemartin (1):
      submodule: Add --force option for git submodule update

Rafael Gieschke (2):
      copy_gecos: fix not adding nlen to len when processing "&"
      ident: add NO_GECOS_IN_PWENT for systems without pw_gecos in stru=
ct passwd

Ramkumar Ramachandra (4):
      Documentation: Add filter.<driver>.* to config
      Documentation: Move diff.<driver>.* from config.txt to diff-confi=
g.txt
      Documentation: Add diff.<driver>.* to config
      Documentation: Allow custom diff tools to be specified in 'diff.t=
ool'

Ramsay Allan Jones (9):
      Makefile: Use cgcc rather than sparse in the check target
      sparse: Fix an "symbol 'cmd_index_pack' not declared" warning
      sparse: Fix some "Using plain integer as NULL pointer" warnings
      sparse: Fix an "symbol 'format_subject' not declared" warning
      sparse: Fix an "symbol 'merge_file' not decared" warning
      sparse: Fix errors due to missing target-specific variables
      sparse: Fix some "symbol not declared" warnings
      setup.c: Fix some "symbol not declared" sparse warnings
      config.c: Remove unused git_config_global() function

Ren=C3=A9 Scharfe (1):
      strbuf: clarify assertion in strbuf_setlen()

SZEDER G=C3=A1bor (3):
      completion: don't modify the $cur variable in completion function=
s
      completion: remove unnecessary _get_comp_words_by_ref() invocatio=
ns
      completion: don't declare 'local words' to make zsh happy

Sebastian Schuberth (1):
      doc: Clarify that "cherry-pick -x" does not use "git notes"

Sebastien Cevey (3):
      gitweb: Split git_project_list_body in two functions
      gitweb: Modularized git_get_project_description to be more generi=
c
      gitweb: Optional grouping of projects by category

Stefan Sperling (1):
      remove noise and inaccuracies from git-svn docs

Sverre Rabbelier (1):
      fast-import: fix option parser for no-arg options

Sylvain Rabot (1):
      git-send-email: fix missing space in error message

Tay Ray Chuan (1):
      t5541-http-push: add test for chunked

Thomas Rast (1):
      add -i: ignore terminal escape sequences

Valentin Haenel (9):
      git-svn.txt: fix usage of --add-author-from
      git-svn.txt: move option descriptions
      git-svn.txt: small typeface improvements
      git-add.txt: document 'add.ignoreErrors'
      config.txt: 'interactive.singlekey; is used by...
      git-add.txt: document 'interactive.singlekey'
      git-stash.txt: better docs for '--patch'
      git-checkout.txt: better docs for '--patch'
      git-reset.txt: better docs for '--patch'

Vincent van Ravesteijn (1):
      Documentation: update to git-merge-base --octopus

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (12):
      i18n: mark merge "Could not read from" message for translation
      i18n: mark merge "upstream" messages for translation
      i18n: mark merge CHERRY_PICK_HEAD messages for translation
      i18n: mark clone nonexistent repository message for translation
      i18n: mark checkout --detach messages for translation
      i18n: mark checkout plural warning for translation
      i18n: mark init-db messages for translation
      git-sh-i18n--envsubst: our own envsubst(1) for eval_gettext()
      git-sh-i18n.sh: add no-op gettext() and eval_gettext() wrappers
      git-sh-i18n.sh: add GIT_GETTEXT_POISON support
      Makefile: add xgettext target for *.sh files
      git-sh-i18n--envsubst: add SYNOPSIS section to the documentation
