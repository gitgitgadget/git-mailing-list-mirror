From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.4.0
Date: Sat, 10 Jun 2006 14:16:46 -0700
Message-ID: <7vmzckhfsx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 10 23:16:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpApD-0000r3-RP
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 23:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161018AbWFJVQu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 10 Jun 2006 17:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030509AbWFJVQu
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 17:16:50 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:2281 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030508AbWFJVQs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Jun 2006 17:16:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060610211647.KTCN5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 10 Jun 2006 17:16:47 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21620>

The latest feature release GIT 1.4.0 is available at the
usual places:

	http://www.kernel.org/pub/software/scm/git/

	git-1.4.0.tar.{gz,bz2}			(tarball)
	git-htmldocs-1.4.0.tar.{gz,bz2}		(preformatted documentation)
	git-manpages-1.4.0.tar.{gz,bz2}		(preformatted documentation)
	RPMS/$arch/git-*-1.4.0-1.$arch.rpm	(RPM)

This is a significant update since v1.3.0 (and v1.3.3 which is
the same codebase with bugfixes-only).  User visible changes
are:

 - Many commands are now coded in C instead of implemented as
   shell scripts.

 - Checkout is more careful not to clobber untracked files.

 - You can "alias" git commands with leading arguments in your
   configuration file.

 - Documentation set, especially the tutorial, has been reworked.

 - Comes with the latest gitk, gitweb, and contributed software.

----------------------------------------------------------------

Changes since v1.3.0 are as follows:

Alex Riesen:
      make update-index --chmod work with multiple files and --stdin
      remove superflous "const"

Aneesh Kumar K.V:
      gitview: Add key binding for F5.
      gitview: Move the console error messages to message dialog
      gitview: Add some useful keybindings.

Ben Clifford:
      include header to define uint32_t, necessary on Mac OS X

Bj=F6rn Engelmann:
      remove the artificial restriction tagsize < 8kb
      add more informative error messages to git-mktag

Catalin Marinas:
      Add a test-case for git-apply trying to add an ending line

Christian Couder:
      Builtin git-rev-parse.

Dennis Stosberg:
      Fix git-pack-objects for 64-bit platforms
      Fix compilation on newer NetBSD systems
      git-write-tree writes garbage on sparc64
      git-clean fails on files beginning with a dash
      Update documentation for git-format-patch

Dmitry V. Levin:
      Separate object name errors from usage errors
      execv_git_cmd: Fix stack buffer overflow.
      git_exec_path, execv_git_cmd: ignore empty environment variables

Elrond:
      git-cvsimport: Handle "Removed" from pserver

Eric W. Biederman:
      Implement git-quiltimport
      Implement a --dry-run option to git-quiltimport
      Make read_one_header_line return a flag not a length.
      Move B and Q decoding into check header.
      Refactor commit messge handling.
      In handle_body only read a line if we don't already have one.
      More accurately detect header lines in read_one_header_line
      Allow in body headers beyond the in body header prefix.

Eric Wong:
      git-svn: documentation updates
      git-svn 1.0.0
      apply: fix infinite loop with multiple patches with --index
      send-email: address expansion for common mailers
      Install git-send-email by default
      send-email: allow sendmail binary to be used instead of SMTP
      send-email: quiet some warnings, reject invalid addresses
      Install git-send-email by default
      commit: allow --pretty=3D args to be abbreviated
      git-svn: starting a 1.1.0-pre development version
      git-svn: ignore expansion of svn:keywords
      t3300-funny-names: shell portability fixes
      tests: Remove heredoc usage inside quotes
      t5500-fetch-pack: remove local (bashism) usage.
      t6000lib: workaround a possible dash bug
      git-svn: t0001: workaround a heredoc bug in old versions of dash
      git-svn: remove assertion that broke with older versions of svn

=46lorian Forster:
      git-svnimport: Improved detection of merges.

=46rancis Daly:
      Some doc typo fixes
      config.txt grammar, typo, and asciidoc fixes
      git-cvsserver asciidoc formatting tweaks

=46redrik Kuivinen:
      blame: Fix path pruning
      Update the documentation for git-merge-base

Horst H. von Brand:
      Documentation: Spelling fixes
      Cleanup git-send-email.perl:extract_valid_email
      Add example xinetd(8) configuration to Documentation/everyday.txt
      Fix Documentation/everyday.txt: Junio's workflow
      Fix formatting of Documentation/git-clone.txt

Horst von Brand:
      Fix some documentation typoes

Huw Davies:
      git-format-patch: Use rfc2822 compliant date.

J. Bruce Fields:
      tutorial: replace "whatchanged" by "log"
      tutorial: expanded discussion of commit history
      tutorial: add discussion of index file, object database
      documentation: mention gitk font adjustment in tutorial
      documentation: add brief mention of cat-file to tutorial part I
      Documentation: retitle the git-core tutorial
      Documentation: fix a tutorial-2 typo

Jeff King:
      cvsimport: use git-update-index --index-info
      cvsimport: cleanup commit function
      cvsimport: set up commit environment in perl instead of using env
      cat-file: document -p option
      cvsimport: avoid "use" with :tag
      handle concurrent pruning of packed objects
      sha1_file: avoid re-preparing duplicate packs

Jim Meyering:
      Don't write directly to a make target ($@).

Johannes Schindelin:
      builtin-push: resurrect parsing of Push: lines
      cache-tree: replace a sscanf() by two strtol() calls
      builtin-push: also ask config for remote information
      fetch, pull: ask config for remote information
      repo-config: fix segfault with no argument.
      repo-config: trim white-space before comment
      repo-config: support --get-regexp
      repo-config: deconvolute logics
      fetch, pull: ask config for remote information
      Add a conversion tool to migrate remote information into the conf=
ig
      builtin-push: --all and --tags _are_ explicit refspecs
      Teach fmt-patch to write individual files.
      fmt-patch: output file names to stdout
      fmt-patch: implement -o <dir>
      Teach fmt-patch about --numbered
      Teach fmt-patch about --keep-subject
      repo-config: trim white-space before comment
      fmt-patch: understand old <his> notation
      Fix users of prefix_path() to free() only when necessary
      Fix users of prefix_path() to free() only when necessary
      Fix crash when reading the empty tree
      diff family: add --check option
      fmt-patch: Support --attach
      git-format-patch --start-number <n>
      send-email: only 'require' instead of 'use' Net::SMTP
      format-patch: resurrect extra headers from config
      If you have a config containing something like this:

Jon Loeliger:
      Alphabetize the glossary.
      Added definitions for a few words:
      Add a few more words to the glossary.
      Refactor git_tcp_connect() functions a little.

Jonas Fonseca:
      Fix filename scaling for binary files
      Misc doc improvements
      Document git-ls-tree --fullname

Josef Weidendorfer:
      gitk: Add a visual tag for remote refs

Junio C Hamano:
      Fix up default abbrev in setup_revisions() argument parser.
      Fix up rev-list option parsing.
      Split init_revisions() out of setup_revisions()
      rev-list option parser fix.
      Built-in git-whatchanged.
      Do not fork PAGER=3Dcat
      Simplify common default options setup for built-in log family.
      log/whatchanged/show - log formatting cleanup.
      rev-list --header: output format fix
      git.c: LOGSIZE is unused after log printing cleanup.
      combine-diff: show diffstat with the first parent.
      Fix "git log --stat": make sure to set recursive with --stat.
      Tentative built-in format-patch.
      sha1_name.c: prepare to make get_tree_entry() reusable from other=
s.
      sha1_name.c: no need to include diff.h; tree-walk.h will do.
      get_tree_entry(): make it available from tree-walk
      Minor tweak on subject line in --pretty=3Demail
      git-merge: a bit more readable user guidance.
      pre-commit hook: complain about conflict markers.
      diff: move diff.c to diff-lib.c to make room.
      Add git-unresolve <paths>...
      diff --stat: do not drop rename information.
      git-update-index --unresolve
      git-commit --amend: two fixes.
      rename internal format-patch wip
      pack-objects: do not stop at object that is "too small"
      mailinfo: decode underscore used in "Q" encoding properly.
      Makefile: dependency for builtin-help.o
      Add colordiff for git to contrib/colordiff.
      Fix "git show --stat"
      Libify diff-files.
      Libify diff-index.
      git-fmt-patch: thinkofix to show properly.
      Libified diff-index: backward compatibility fix.
      read-cache/write-cache: optionally return cache checksum SHA1.
      Add cache-tree.
      Update write-tree to use cache-tree.
      Invalidate cache-tree entries for touched paths in git-apply.
      Use cache-tree in update-index.
      Add test-dump-cache-tree
      cache-tree: protect against "git prune".
      index: make the index file format extensible.
      Teach fsck-objects about cache-tree.
      cache-tree: sort the subtree entries.
      test-dump-cache-tree: report number of subtrees.
      Makefile: remove and create libgit.a from scratch.
      diff --stat: show complete rewrites consistently.
      git-cvsserver: typofixes
      t0000-basic: Add ls-tree recursive test back.
      Makefile: remove and create xdiff library from scratch.
      commit-tree: allow generic object name for the tree as well.
      rebase: typofix.
      commit-tree.c: check_valid() microoptimization.
      revision parsing: make "rev -- paths" checks stronger.
      t0000-basic: more commit-tree tests.
      update-index: when --unresolve, smudge the relevant cache-tree en=
tries.
      read-tree: teach 1 and 2 way merges about cache-tree.
      read-tree: teach 1-way merege and plain read to prime cache-tree.
      diff-index: fix compilation warnings.
      verify-pack: check integrity in a saner order.
      cache_tree_update: give an option to update cache-tree only.
      test-dump-cache-tree: validate the cached data as well.
      pack-objects: update size heuristucs.
      built-in count-objects.
      cache-tree.c: typefix
      git-am --resolved: more usable error message.
      built-in diff.
      built-in diff: assorted updates.
      builtin-diff.c: die() formatting type fix.
      Fix builtin-push to honor Push: lines in remotes file.
      Extended SHA1 -- "rev^@" syntax to mean "all parents"
      get_sha1(): :path and :[0-3]:path to extract from index.
      built-in "git grep"
      Use RFC2822 dates from "git fmt-patch".
      builtin-grep: wildcard pathspec fixes
      builtin-grep: support '-l' option.
      builtin-grep: do not use setup_revisions()
      fsck-objects: mark objects reachable from cache-tree
      builtin-count-objects: make it official.
      builtin-diff: call it "git-diff", really.
      builtin-log/whatchanged/show: make them official.
      show-branch: omit uninteresting merges.
      builtin-push: make it official.
      builtin-grep: printf %.*s length is int, not ptrdiff_t.
      Revert "fetch, pull: ask config for remote information"
      builtin-grep: allow -<n> and -[ABC]<n> notation for context lines=
=2E
      builtin-grep: allow more than one patterns.
      builtin-grep: support -c (--count).
      builtin-grep: support -w (--word-regexp).
      builtin-grep: tighten path wildcard vs tree traversal.
      core.prefersymlinkrefs: use symlinks for .git/HEAD
      repo-config: readability fixups.
      builtin-count-objects: open packs when running -v
      Fix test-dump-cache-tree in one-tree disappeared case.
      read-tree: invalidate cache-tree entry when a new index entry is =
added.
      cache-tree: a bit more debugging support.
      builtin-grep: terminate correctly at EOF
      builtin-grep: binary files -a and -I
      fsck-objects: do not segfault on missing tree in cache-tree
      builtin-grep: -L (--files-without-match).
      Makefile: do not link rev-list any specially.
      delta: stricter constness
      core.prefersymlinkrefs: use symlinks for .git/HEAD
      pack-object: squelch eye-candy on non-tty
      binary patch.
      binary diff: further updates.
      update-index --unresolve: work from a subdirectory.
      checkout-index: plug memory leak from prefix_path()
      update-index: plug memory leak from prefix_path()
      update-index --again
      update-index --again: take optional pathspecs
      binary diff and apply: testsuite.
      repo-config: document what value_regexp does a bit more clearly.
      Fix repo-config set-multivar error return path.
      Teach -f <file> option to builtin-grep.
      builtin-grep: documentation
      Documentation: {caret} fixes (git-rev-list.txt)
      get_sha1() - fix infinite loop on nonexistent stage.
      Teach git-clean optional <paths>... parameters.
      builtin-grep: tighten argument parsing.
      builtin-grep: typofix
      builtin-grep: -w fix
      builtin-grep: -F (--fixed-strings)
      checkout: use --aggressive when running a 3-way merge (-m).
      checkout: use --aggressive when running a 3-way merge (-m).
      diffstat rename squashing fix.
      read-tree -u one-way merge fix to check out locally modified path=
s.
      apply --numstat: show new name, not old name.
      Fix pack-index issue on 64-bit platforms a bit more portably.
      builtin-grep: unparse more command line options.
      apply --cached: apply a patch without using working tree.
      git-am: use apply --cached
      builtin-diff: fix comparison between two blobs.
      merge-base: Clarify the comments on post processing.
      read-tree -m -u: do not overwrite or remove untracked working tre=
e files.
      builtin-grep: workaround for non GNU grep.
      Revert "builtin-grep: workaround for non GNU grep."
      apply --cached: do not check newly added file in the working tree
      builtin-add: fix unmatched pathspec warnings.
      builtin-diff: do not say files are renamed when blob and file are=
 given
      Fix build procedure for builtin-init-db
      built-in tar-tree and remote tar-tree
      git-format-patch: now built-in.
      checkdiff_consume: strtol parameter fix.
      git-rebase: use canonical A..B syntax to format-patch
      tutorial-2: typofix in examples.
      mailinfo: skip bogus UNIX From line inside body
      CMIT_FMT_EMAIL: Q-encode Subject: and display-name part of From: =
fields.
      builtin format-patch: squelch content-type for 7-bit ASCII
      diff: minor option combination fix.
      fetch-pack: output refs in the order they were given on the comma=
nd line.
      Tutorial #2: broken link fix.
      builtin-rm: squelch compiler warnings.
      cvsimport: do not barf on creation of an empty file.
      apply: force matching at the beginning.
      fetch.c: remove an unused variable and dead code.
      ls-remote: fix rsync:// to report HEAD
      mailinfo: More carefully parse header lines in read_one_header_li=
ne()
      gitk: start-up bugfix
      built-in format-patch: various fixups.
      format-patch: -n and -k are mutually exclusive.
      Let git-clone to pass --template=3Ddir option to git-init-db.
      git-fetch: avoid using "case ... in (arm)"
      adjust to the rebased series by Linus.
      send-email: do not pass bogus address to local sendmail binary
      format-patch --signoff
      fetch.c: do not pass uninitialized lock to unlock_ref().
      fetch.c: do not call process_tree() from process_tree().
      fetch: do not report "same" unless -verbose.
      read-tree --reset: update working tree file for conflicted paths.
      git alias: try alias last.
      rev-parse: tighten constness properly.
      send-email: be more lenient and just catch obvious mistakes.
      send-email: a bit more careful domain regexp.
      git-format-patch: add --output-directory long option again
      HTTP cleanup
      Make index file locking code reusable to others.
      refs.c: convert it to use lockfile interface.
      ref-log: style fixes.
      Documentation: add missing docs make check-docs found.
      make clean: remove dist-doc targets.
      Documentation: git-ls-tree (typofix)
      Documentation: add another example to git-ls-files
      git-clone: fix duplicated "master" in $GIT_DIR/remotes/origin
      git-rm: honor -n flag.
      builtin-init-db: spell the in-program configuration variable in l=
owercase.
      shared repository - add a few missing calls to adjust_shared_perm=
().
      git-clone: fix --bare over dumb-http
      GIT 1.4.0

Linus Torvalds:
      Common option parsing for "git log --diff" and friends
      Tentative built-in "git show"
      Fixes for option parsing
      Log message printout cleanups
      Log message printout cleanups (#2)
      Log message printout cleanups (#3): fix --pretty=3Doneline
      Fix uninteresting tags in new revision parsing
      get_sha1() shorthands for blob/tree objects
      Allow "git repack" users to specify repacking window/depth
      git log: don't do merge diffs by default
      git-log produces no output
      Split up builtin commands into separate files from git.c
      Fix filename verification when in a subdirectory
      Fix "git help -a" terminal autosizing
      git builtin "push"
      Fix "git-log --parents" breakage post v1.3.0
      sha1_to_hex() usage cleanup
      Fix "git diff --stat" with long filenames
      revert/cherry-pick: use aggressive merge.
      git config syntax updates
      git diff: support "-U" and "--unified" options properly
      Allow one-way tree merge to remove old files
      Simplify "git reset --hard"
      builtin-grep: use external grep when we can take advantage of it
      read-tree --reset -u fix.
      Fix silly typo in new builtin grep
      Remove old "git-grep.sh" remnants
      libify git-ls-files directory traversal
      Clean up git-ls-file directory walking library interface
      Do "git add" as a builtin
      builtin-add: warn on unmatched pathspecs
      builtin-grep: workaround for non GNU grep.
      Remove old "git-add.sh" remnants
      Prevent bogus paths from being added to the index.
      Make "git rev-list" be a builtin
      Libify the index refresh logic
      Move pathspec matching from builtin-add.c into dir.c
      Add builtin "git rm" command
      cvsimport: repack every kilo-commits.
      apply: treat EOF as proper context.
      Clean up sha1 file writing
      bogus "fatal: Not a git repository"
      t1002: use -U0 instead of --unified=3D0
      Fix "--abbrev=3Dxyz" for revision listing
      Fix memory leak in "git rev-list --objects"
      Don't use "sscanf()" for tree mode scanning
      Add raw tree buffer info to "struct tree"
      Make "tree_entry" have a SHA1 instead of a union of object pointe=
rs
      Switch "read_tree_recursive()" over to tree-walk functionality
      Remove "tree->entries" tree-entry list from tree parser
      Make "struct tree" contain the pointer to the tree buffer
      Make "tree_entry" have a SHA1 instead of a union of object pointe=
rs
      Switch "read_tree_recursive()" over to tree-walk functionality
      builtin-read-tree.c: avoid tree_entry_list in prime_cache_tree_re=
c()
      Remove "tree->entries" tree-entry list from tree parser
      fsck-objects: avoid unnecessary tree_entry_list usage
      Remove unused "zeropad" entry from tree_list_entry
      Convert "mark_tree_uninteresting()" to raw tree walker
      Convert fetch.c: process_tree() to raw tree walker
      Remove last vestiges of generic tree_entry_list
      tree_entry(): new tree-walking helper function
      read-tree: fix eye-candy.
      Fix typo in tutorial-2.txt
      rev-list: fix process_tree() conversion.
      pack-objects: improve path grouping heuristics.

Lukas Sandstr=F6m:
      Make git-check-format-ref a builtin.
      SubmittingPatches: The download location of External Editor has m=
oved

Martin Langhoff:
      git-cvsexportcommit: Add -f(orce) and -m(essage prefix) flags, sm=
all cleanups.
      git-send-email: fix version string to be valid perl
      cvsserver: use git-rev-list instead of git-log
      cvsserver: use git-rev-list instead of git-log
      cvsimport: minor fixups
      cvsimport: replace anonymous sub ref with a normal sub
      cvsimport: introduce -L<imit> option to workaround memory leaks
      cvsimport: introduce _fetchfile() method and used a 1M buffer to =
read()

Martin Waitz:
      clone: keep --reference even with -l -s
      repack: honor -d even when no new pack was created
      Transitively read alternatives
      test case for transitive info/alternates
      clone: don't clone the info/alternates file
      git help: remove whatchanged from list of common commands
      Documentation/Makefile: remove extra /
      Add instructions to commit template.

Martyn Smith:
      Added logged warnings for CVS error returns
      Many fixes for most operations in Eclipse.
      Change to allow subdir updates from Eclipse

Matthias Kestenholz:
      annotate: fix warning about uninitialized scalar
      annotate: display usage information if no filename was given
      fix various typos in documentation
      add documentation for update-index --unresolve

Matthias Lederhofer:
      core-tutorial.txt: escape asterisk
      git status: skip empty directories, and add -u to show all untrac=
ked files

Nick Hengeveld:
      git-fetch: resolve remote symrefs for HTTP transport
      http: prevent segfault during curl handle reuse
      builtin-push: don't pass --thin to HTTP transport
      HTTP cleanup
      http-fetch: fix possible segfault

Nicolas Pitre:
      fix pack-object buffer size
      split the diff-delta interface
      use delta index data when finding best delta matches
      replace adler32 with Rabin's polynomial in diff-delta
      tiny optimization to diff-delta
      improve diff-delta with sparse and/or repetitive data
      improve base85 generated assembly code
      fix diff-delta bad memory access
      simple euristic for further free packing improvements
      pack-object: slightly more efficient
      improve depth heuristic for maximum delta size

Paul Mackerras:
      gitk: Implement multiple views
      gitk: Make File->Update work properly again
      gitk: Fix various bugs in the view support
      gitk: Don't reread git-rev-list output from scratch on view switc=
h
      gitk: Remember the view in the history list
      gitk: Let git-rev-list do the argument list parsing
      gitk: Use git-rev-parse only to identify file/dir names on cmd li=
ne
      rev-parse: better error message for ambiguous arguments
      gitk: Implement "permanent" views (stored in ~/.gitk)
      gitk: add menu item for editing the current view
      gitk: Use a text widget for the file list
      gitk: Add a tree-browsing mode
      gitk: Basic support for highlighting one view within another
      gitk: Fix file list display when files are renamed
      gitk: Allow view to specify arbitrary arguments to git-rev-list
      gitk: Fix display of "(...)" for parents/children we haven't draw=
n
      Provide a way to flush git-diff-tree's output
      gitk: Make a row of controls for controlling highlighting
      gitk: Fix bug where page-up/down wouldn't always work properly
      gitk: Highlight entries in the file list as well
      gitk: Highlight paths of interest in tree view as well
      gitk: First cut at a search function in the patch/file display wi=
ndow
      gitk: Improve the text window search function
      gitk: Move "pickaxe" find function to highlight facility
      gitk: Fix bug in highlight stuff when no line is selected
      gitk: show_error fix
      gitk: Provide ability to highlight based on relationship to selec=
ted commit
      Make git-diff-tree indicate when it flushes
      gitk: Add a goto next/previous highlighted commit function
      gitk: Show nearby tags
      gitk: Show branch name(s) as well, if "show nearby tags" is enabl=
ed
      gitk: Re-read the descendent/ancestor tag & head info on update

Paul T Darga:
      check for error return from fork()

Pavel Roskin:
      Release config lock if the regex is invalid

Peter Eriksen:
      Add git-quiltimport to .gitignore.
      Builtin git-ls-files.
      Builtin git-ls-tree.
      Builtin git-tar-tree.
      Builtin git-read-tree.
      Builtin git-commit-tree.
      Builtin git-apply.
      Builtin git-show-branch.
      Builtin git-diff-files, git-diff-index, git-diff-stages, and git-=
diff-tree.

Peter Hagervall:
      Sparse fix for builtin-diff

Petr Baudis:
      Document git-var -l listing also configuration variables
      Document the configuration file
      git-repo-config --list support
      Deprecate usage of git-var -l for getting config vars list
      Call builtin ls-tree in git-cat-file -p
      Document git aliases support
      Documentation: git aliases

Rene Scharfe:
      Off-by-one error in get_path_prefix(), found by Valgrind
      Built-in git-get-tar-commit-id

Robert Fitzsimons:
      builtin-grep: pass ignore case option to external grep

Robert Shearman:
      Give the user a hint for how to continue in the case that git-am =
fails because it requires user intervention

Ryan Anderson:
      git-send-email: Add References: headers to emails, in addition to=
 In-Reply-To:
      Add support for --bcc to git-send-email.
      Fix a bug in email  extraction used in git-send-email.
      Add a basic test case for git send-email, and fix some real bugs =
discovered.

Salikh Zakirov:
      Fixed Cygwin CR-munging problem in mailsplit

Santi:
      Document that "git add" only adds non-ignored files.

Santi_B=E9jar:
      Reintroduce svn pools to solve the memory leak.

Sean Estabrooks:
      Add --continue and --abort options to git-rebase.
      Update the git-branch man page to include the "-r" option,
      Fix up remaining man pages that use asciidoc "callouts".
      Properly render asciidoc "callouts" in git man pages.
      Fix trivial typo in git-log man page.
      Several trivial documentation touch ups.
      Fix up docs where "--" isn't displayed correctly.
      Update git-unpack-objects documentation.
      Clarify git-cherry documentation.
      Fix for config file section parsing.
      Another config file parsing fix.
      t1300-repo-config: two new config parsing tests.
      Another config file parsing fix.
      Add "--branches", "--tags" and "--remotes" options to git-rev-par=
se.
      Ensure author & committer before asking for commit message.
      Make git rebase interactive help match documentation.
      Add "--summary" option to git diff.
      Convert some "apply --summary" users to "diff --summary".
      Strip useless "tags/" prefix from git-tag -l output
      Allow pickaxe and diff-filter options to be used by git log.
      Avoid segfault in diff --stat rename output.
      Change GIT-VERSION-GEN to call git commands with "git" not "git-"=
=2E
      Install git builtins into gitexecdir rather than bindir.
      Remove possible segfault in http-fetch.
      --summary output should print immediately after stats.
      A Perforce importer for git.

Serge E. Hallyn:
      socksetup: don't return on set_reuse_addr() error
      socksetup: don't return on set_reuse_addr() error

Sergey Vlasov:
      gitk: Display commit messages with word wrap

Shawn Pearce:
      Document git-clone --reference
      Remove unnecessary local in get_ref_sha1.
      Improve abstraction of ref lock/write.
      Convert update-ref to use ref_lock API.
      Log ref updates to logs/refs/<ref>
      Support 'master@2 hours ago' syntax
      Fix ref log parsing so it works properly.
      General ref log reading improvements.
      Added logs/ directory to repository layout.
      Force writing ref if it doesn't exist.
      Log ref updates made by fetch.
      Change 'master@noon' syntax to 'master@{noon}'.
      Correct force_write bug in refs.c
      Change order of -m option to update-ref.
      Include ref log detail in commit, reset, etc.
      Create/delete branch ref logs.
      Enable ref log creation in git checkout -b.
      Reference git-check-ref-format in git-branch.
      Elaborate on why ':' is a bad idea in a ref name.
      Built git-upload-tar should be ignored.
      Verify git-commit provides a reflog message.
      Test that git-branch -l works.
      Remove unnecessary output from t3600-rm.
      Improved pack format documentation.
      Allow multiple -m options to git-commit.

Tilman Sauerbeck:
      Documentation/Makefile: create tarballs for the man pages and htm=
l files

Timo Hirvonen:
      Builtin git-init-db
      Builtin git-cat-file
      gitk: Replace "git-" commands with "git "

Uwe Zeisberger:
      Document git-clone --use-separate-remote

Yakov Lerner:
      read-cache.c: use xcalloc() not calloc()
      NO_INET_NTOP and compat/inet_ntop.c for some systems (e.g. old Cy=
gwin).
      Problem: 'trap...exit' causes error message when /bin/sh is ash.

Yann Dirson:
      Do not call 'cmp' with non-existant -q flag.
      Document current cvsexportcommit limitations.
      Make cvsexportcommit create parent directories as needed.
