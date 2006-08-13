From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.4.2
Date: Sat, 12 Aug 2006 20:17:40 -0700
Message-ID: <7vk65dmii3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 13 05:18:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GC6UE-0000Oz-Ob
	for gcvg-git@gmane.org; Sun, 13 Aug 2006 05:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbWHMDRo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 12 Aug 2006 23:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932667AbWHMDRn
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Aug 2006 23:17:43 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:42746 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932663AbWHMDRm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Aug 2006 23:17:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060813031741.UCDQ27846.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 12 Aug 2006 23:17:41 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25275>


The latest feature release GIT 1.4.2 is available at the usual
places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.2.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.2.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.2.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.2-1.$arch.rpm	(RPM)

I do not currently have access to i386 RH boxes, so there is
only x86_64 RPM in the RPMS directory mentioned above.

----------------------------------------------------------------

Changes since v1.4.1.1 are as follows:

A Large Angry SCM:
      Additional merge-base tests (revised)

Alex Riesen:
      Do not use perl in git-commit.sh
      Trivial path optimization test

Alexandre Julliard:
      git.el: Run git-rerere on commits if the rr-cache directory exist=
s.
      git.el: Prepend a slash to the file name when adding to .gitignor=
e.
      git.el: Try to reuse an existing buffer when running git-status.
      git.el: Put the git customize group in the 'tools' parent group.
      show-branch: Fix another performance problem.

Alp Toker:
      Fix some doubled word typos
      Fix some doubled word typos
      Fix typos involving the word 'commit'
      typofix (git-name-rev documentation)
      git-send-email: Remove redundant Reply-To header
      gitweb: Send XHTML as 'application/xhtml+xml' where possible
      gitweb: Include a site name in page titles
      gitweb: Make command invocations go through the git wrapper
      documentation (urls.txt) typofix

Daniel Drake:
      gitweb: escape tag comments

Dennis Stosberg:
      gitweb: Declare global variables with "our"
      gitweb: Declare global variables with "our"

Eric Wong:
      Add git-instaweb, instantly browse the working repo with gitweb
      instaweb: fix unportable ';' usage in sed
      t8001-annotate: fix a bash-ism in this test
      git-svn: avoid fetching files outside of the URL we're tracking
      git-svn: migrate out of contrib
      builtin-log: respect diff configuration options
      diff.c: respect diff.renames config option
      templates/hooks--update: replace diffstat calls with git diff --s=
tat
      git-svn: fix --file/-F option in commit-diff
      tests: Set EDITOR=3D: and VISUAL=3D: globally
      git-fetch: fix a bashism (=3D=3D)
      git-svn: don't check for migrations/upgrades on commit-diff
      typechange tests for git apply (currently failing)
      git-svn: fix fetching new directories copies when using SVN:: lib=
s
      git-svn: correctly kill keyword expansion without munging EOLs
      git-svn: bugfix: allow SVN:: lib users to track the root of the r=
epository
      git-svn: split the path from the url correctly with limited perms

Gerrit Pape:
      Build on Debian GNU/kFreeBSD

Jakub Narebski:
      Allow INSTALL, bindir, mandir to be set in main Makefile
      Rename man1 and man7 variables to man1dir and man7dir
      autoconf: Use autoconf to write installation directories to confi=
g.mak.autogen
      send-email: format 2822 datestring ourselves.
      Teach make clean about configure and autoconf
      Copy description of build configuration variables to configure.ac
      autoconf: Preparing the way for autodetection
      autoconf: Checks for typedefs, structures, and compiler character=
istics.
      autoconf: Checks for some library functions.
      autoconf: Checks for libraries
      autoconf: Checks for some programs
      configure.ac vertical whitespace usage cleanup
      Wrap long lines in docstrings in contrib/emacs/git.el
      Display help for Git mode after pressing `h' or `?' in *git-statu=
s*

Jeff King:
      pack-objects: check pack.window for default window size
      Colorize 'commit' lines in log ui
      git-push: allow -f as an alias for --force
      git-push: remove obsolete git-push.sh
      Documentation: convert uses of git-link macro to gitlink
      git-annotate: remove extraneous debugging line
      git-push: allow pushing from subdirectories

Joachim B Haga:
      Make zlib compression level configurable, and change default.

Joachim Berdal Haga:
      core.compression documentation formatting fix.

Johannes Schindelin:
      refactor merge_bases() as preparation to libify merge-base
      move get_merge_bases() to core lib.
      Makefile: replace ugly and unportable sed invocation
      Make git-fmt-merge-msg a builtin
      Makefile: export NO_SVN_TESTS
      Close the index file between writing and committing
      Fix linking for not-so-clever linkers.
      Fix t4114 on cygwin
      Always reset the color _before_ printing out the newline
      cvsserver: suppress warnings
      cvsserver: avoid warning about active db handles
      Allow an alias to start with "-p"
      git wrapper: add --git-dir=3D<path> and --bare options
      git-instaweb: some Apache have mod_cgi builtin
      git-instaweb: respect bindir from Makefile
      gitweb: fix two warnings
      t7001: add test for git-mv dir1 dir2/
      git-cvsserver: support multiline commit messages
      Extract helper bits from c-merge-recursive work
      Make git-mv a builtin
      builtin git-mv: support moving directories
      instaweb: Be more clear if httpd or the browser fail
      cvsserver: imitate git-update-ref when committing
      Makefile: ssh-pull.o depends on ssh-fetch.c
      Teach git-apply about '-R'
      Fix http-fetch
      tar-tree: illustrate an obscure feature better
      Fix crash when GIT_DIR is invalid

Jonas Fonseca:
      Documentation/urls.txt: Use substitution to escape square bracket=
s
      Update git-init-db(1) and documentation of core.sharedRepository

Josef Weidendorfer:
      Extend testing git-mv for renaming of subdirectories

Josh Triplett:
      git-format-patch: Make the second and subsequent mails replies to=
 the first
      Add option to enable threading headers
      Add option to set initial In-Reply-To/References

Junio C Hamano:
      Makefile: add framework to verify and bench sha1 implementations.
      test-sha1: test hashing large buffer
      t4013: add tests for diff/log family output options.
      t4013: add more tests around -c and --cc
      Fix some more diff options changes.
      t4013 test updates for new output code.
      combine-diff.c: type sanity.
      format-patch: fix diff format option implementation
      t4013: add format-patch tests.
      t4013: note improvements brought by the new output code.
      gitweb: optimize per-file history generation
      gitweb: optimize per-file history generation
      t4013: add "diff" UI program tests.
      builtin-diff: turn recursive on when defaulting to --patch format=
=2E
      commit.c: do not redefine UNINTERESTING bit.
      get_merge_bases: clean up even when there is no common commit.
      revert clear-commit-marks for now.
      boolean: accept yes and no as well
      send-email: do not barf when Term::ReadLine does not like your te=
rminal
      t6200: fmt-merge-msg test.
      git-grep: fix parsing of pathspec separator '--'
      git-grep: fix exit code when we use external grep.
      git-grep: use a bit more specific error messages.
      Re-fix clear_commit_marks().
      git-grep: boolean expression on pattern matching.
      git-reset: complain and exit upon seeing an unknown parameter.
      mailinfo: assume input is latin-1 on the header as we do for the =
body
      diffcore-rename: try matching up renames without populating files=
pec first.
      builtin-rev-parse.c: constness tightening
      show-branch: match documentation and usage
      rev-parse documentation: talk about range notation.
      git-svn: migrate out of contrib (follow-up)
      diff.c: --no-color to defeat diff.color configuration.
      Update diff-options and config documentation.
      git log -p --merge [[--] paths...]
      colored diff: diff.color =3D auto fix
      diff: do not use configuration magic at the core-level
      "git -p cmd" to page anywhere
      merge-base: update the clean-up postprocessing
      fmt-merge-msg fix
      Fix grammatical error in git-revert
      git-repack: avoid redirecting stderr into git-pack-objects
      test-lib: unset GIT_TRACE
      t4013 diff format tests update
      Adjust t4013 tests to corrected format-patch.
      Documentation: Fix ssh://[user@]host.xz URL
      fetch/clone: check return status from ls-remote
      builtin-prune.c: forgot TYPE =3D> OBJ changes.
      Documentation/Makefile: product depends on asciidoc.conf
      builtin-log: typefix for recent format-patch changes.
      show-branch: fix performance problem.
      checkout -f failed to check out a file if an existing directory i=
nterfered.
      apply: check D/F conflicts more carefully.
      apply: split out removal and creation into different phases.
      apply: handle type-changing patch correctly.
      git-diff A...B to (usually) mean "git-diff `git-merge-base A B` B=
"
      git-fetch: fix --keep vs --thin
      unpack-objects: remove stale and confusing comment
      t4112: simplify the test and remove unneeded working tree file.
      lost-found: use fsck-objects --full
      git-reset: detect update-ref error and report it.
      log and diff family: honor config even from subdirectories
      git-apply -R: binary patches are irreversible for now.
      t4103: fix binary patch application test.
      git-checkout: allow "checkout HEAD -- path"
      Builtins: control the use of pager from the command table.
      fetch/clone: mark messages from remote side stand out.
      Cygwin needs NO_C99_FORMAT???
      Fix "git diff blob1 blob2" showing the diff in reverse.
      read-tree: shadowed variable fix.
      Add a couple of subdirectory tests.
      diff.c: do not use pathname comparison to tell renames
      Show both blob names from "git diff blob1 blob2"
      sideband: do not use color, just say "remote:"
      Documentation/git.txt: link git-svn and git-instaweb from the mai=
n page.
      GIT 1.4.2-rc3
      Further clean-up: usage() vs die()
      Makefile: Cygwin does not seem to need NO_STRLCPY
      Fix "grep -w"
      debugging: XMALLOC_POISON
      builtin-mv: fix use of uninitialized memory.
      GIT-VERSION-GEN: adjust for ancient git
      Documentation: git-status takes the same options as git-commit
      Fix tutorial-2.html
      check return value from diff_setup_done()
      find_unique_abbrev() with len=3D0 should not abbreviate
      make --find-copies-harder imply -C
      allow diff.renamelimit to be set regardless of -M/-C
      git-apply: applying a patch to make a symlink shorter.
      combine-diff: use color
      Fix git-diff A...B
      builtin-apply: remove unused increment
      git-sh-setup: do not use repo-config to test the git directory
      git-am: give better diagnostics when the patch does not apply dur=
ing --3way
      Better error message when we are unable to lock the index file
      t/t4013: fix futzing with the version string.

Linus Torvalds:
      xdiff: generate "anti-diffs" aka what is common to two files
      Prepare "git-merge-tree" for future work
      Improved three-way blob merging code
      Improve git-peek-remote
      builtin "git prune"
      Make the unpacked object header functions static to sha1_file.c
      Remove TYPE_* constant macros and use object_type enums consisten=
tly.
      sha1_file: add the ability to parse objects in "pack file format"
      Call setup_git_directory() early
      Call setup_git_directory() much earlier
      Fix double "close()" in ce_compare_data
      Fix up some fallout from "setup_git_directory()" cleanups

Luben Tuikov:
      gitweb: Enable tree (directory) history display
      gitweb: Enable tree (directory) history display
      Add "raw" output option to blobs in "tree" view format
      gitweb.cgi: Create $git_temp if it doesn't exist
      gitweb.cgi: Teach "a=3Dblob" action to know the blob/file mime ty=
pe
      gitweb.css: Use monospace fonts for commits and tree-diff.
      gitweb.cgi: Teach git_history() to read hash from $hash_base
      gitweb.cgi: Include direct link to "raw" files from "history"
      gitweb.cgi: git_blame2: an alternative simple working git blame
      gitweb.cgi: git_blame2: Allow back-trekking through commits
      gitweb.cgi: Show "raw" head of project link even when $hash is no=
t defined
      gitweb.cgi: git_blame2: Revision blocks now have alternating colo=
rs
      gitweb.cgi: Centralize printing of the page path
      gitweb.cgi: git_blame2: slight optimization reading the blame lin=
es

Lukas Sandstr=F6m:
      git-am: Don't accept an mbox on stdin of we already have a .dotes=
t directory

Martin Langhoff:
      cvsexportcommit - add -a (add author line) flag, cleanup warnings

Matthias Kestenholz:
      Make git-prune-packed a builtin
      Make git-repo-config a builtin
      use declarations from builtin.h for builtin commands

Matthias Lederhofer:
      GIT_TRACE: show which built-in/external commands are executed
      change ent to tree in git-diff documentation
      git-rev-list: add documentation for --parents, --no-merges
      daemon: use a custom die routine with syslog
      daemon: if one of the standard fds is missing open it to /dev/nul=
l
      upload-pack: ignore write errors to stderr
      daemon: new option --pid-file=3D<path> to store the pid
      daemon: new option --detach to run git-daemon in background
      Documentation about exclude/ignore files
      argv created by handle_alias should be NULL terminated
      upload-pack: fix timeout in create_pack_file
      daemon: documentation for --reuseaddr, --detach and --pid-file
      setup_git_directory_gently: do not barf when GIT_DIR is given.
      git.c: allow alias expansion without a git directory
      pager: config variable pager.color
      git-grep: document --and, --or, --not, ( and )

Michael:
      fixed variable declaration in gitk

Michael Krelin:
      handle https:// protocol in git-clone

Michael S. Tsirkin:
      mailinfo: accept >From in message header

Michal Rokos:
      sed -e '/RE/r rfile/' needs space in 'r rfile'
      Using 'perl' in *.sh

Paul Mackerras:
      gitk: Allow the user to set some colors
      gitk: Show the currently checked-out head in bold font

Pavel Roskin:
      Assorted typo fixes
      Typofix in Makefile comment.
      Typofix in configure.ac comment.
      Fix more typos, primarily in the code
      Avoid C99 comments, use old-style C comments instead.
      Quote all calls to GIT_CONF_APPEND_LINE
      Set datarootdir in config.mak.in

Peter Baumann:
      git-cvsexportcommit can't handle merge commits correctly

Peter Eriksen:
      Substitute xmalloc()+memset(0) with xcalloc().

Petr Baudis:
      Remove -d from *-fetch usage strings
      Make pull() take some implicit data as explicit arguments
      Make pull() support fetching multiple targets at once
      Teach git-local-fetch the --stdin switch
      Teach git-http-fetch the --stdin switch

Ramsay Jones:
      Ensure git-clone exits with error if perl script fails.
      Fix annotate test script; notice when git-annotate fails.
      Fix installation of templates on ancient systems.
      New tests and en-passant modifications to mktag.
      Add NO_C99_FORMAT to support older compilers.
      Fix header breakage due to redefining PATH_MAX.
      Remove cmd_usage() routine and re-organize the help/usage code.
      Fix header breakage with _XOPEN_SOURCE.
      Fixup command names in some usage strings.
      Replace some calls to die(usage_str) with usage(usage_str).
      Allow config file to specify Signed-off-by identity in format-pat=
ch.
      commit walkers: setup_ident() to record correct committer in ref-=
log.

Rene Scharfe:
      Add get_merge_bases_clean()
      Add '...' operator for revisions
      Make clear_commit_marks() clean harder
      Fold get_merge_bases_clean() into get_merge_bases()
      rev-list: free commit_list in ... handler
      git-tar-tree: fix minor memory leak
      Add has_extension()
      git-verify-pack: show usage when no pack was specified
      git-verify-pack: more careful path handling
      git-verify-pack: insist on .idx extension
      git-verify-pack: get rid of while loop
      git-verify-pack: free pack after use and a cleanup
      git-verify-pack: buffer overrun paranoia
      git-verify-pack: no need to count errors
      drop length argument of has_extension

Robert Shearman:
      format-patch: Generate a newline between the subject header and t=
he message body
      rebase: Fix the detection of fast-forwarding of the current branc=
h to upstream.
      rebase: Make the fast-fowarding message more user-friendly by usi=
ng branch names instead of SHA1 IDs.

Rutger Nijlunsing:
      http-push: Make WebDAV work with (broken?) default apache2 WebDAV=
 module
      Add Documentation/howto/setup-git-server-over-http.txt

Ryan Anderson:
      annotate: Support annotation of files on other revisions.
      annotate: Correct most merge following to annotate correctly.
      Disable color detection during format-patch
      log-tree: show_log() should respect the setting of diffopt->line_=
termination
      annotate: Fix bug when parsing merges with differing real and log=
ical parents.

Santi B=E9jar:
      Teach rev-parse the ... syntax.
      Defaulting fetch to origin when set in the repo-config

Sergey Vlasov:
      Fix "git-fetch --tags" exit status when nothing has been changed

Shawn Pearce:
      Avoid C99 initializers
      Allow user.name and user.email to drive reflog entry.
      Record the type of commit operation in the reflog.
      Log ref changes made by git-fetch and git-pull.
      Log ref changes made by git-merge and git-pull.
      Log ref changes made by quiltimport.
      Log ref changes made by resolve.
      Make lazy mkdir more robust.
      Record rebase changes as 'rebase' in the reflog.
      Disable linking with Fink or DarwinPorts.
      Display an error from update-ref if target ref name is invalid.

Stephan Feder:
      Do not drop data from '\0' until eol in patch output
      Teach --text option to diff
      Teach diff -a as shorthand for --text
      Add -a and --text to common diff options help
      diff-options: Explain --text and -a

Timo Hirvonen:
      Merge with_raw, with_stat and summary variables to output_format
      Make --raw option available for all diff commands
      Set default diff output format after parsing command line
      DIFF_FORMAT_RAW is not default anymore
      Add msg_sep to diff_options
      Don't xcalloc() struct diffstat_t
      whatchanged: Default to DIFF_FORMAT_RAW
      Print empty line between raw, stat, summary and patch
      diff-tree: Use ---\n as a message separator
      log --raw: Don't descend into subdirectories by default
      Fix diff-tree -s
      GIT_TRACE: fix a mixed declarations and code warning
      diff: Support both attributes and colors
      diff: Support 256 colors

Unknown:
      A better-scheduled PPC SHA-1 implementation.

Uwe Zeisberger:
      Document rev-list's option --merge

Ville Skytt=C3=A4:
      Fix print-log and diff compatibility with recent vc versions

Willy Tarreau:
      tar-tree: add the "tar.umask" config option

Yakov Lerner:
      Mention the [user@] part in documentation of ssh:// urls.
