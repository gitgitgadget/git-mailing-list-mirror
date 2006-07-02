From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.4.1
Date: Sat, 01 Jul 2006 23:33:42 -0700
Message-ID: <7vlkrca52x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 08:34:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwvWq-0000A5-Ck
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 08:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWGBGdp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 2 Jul 2006 02:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWGBGdp
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 02:33:45 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:29134 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750803AbWGBGdo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jul 2006 02:33:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060702063343.UPFG11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 2 Jul 2006 02:33:43 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23094>

The latest feature release GIT 1.4.1 is available at the usual
places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.1.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.1.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.1-1.$arch.rpm	(RPM)

As announced earlier, 1.4.1 is not just 1.4.0 plus bugfixes, but
also has enhancements from the "master" branch.

----------------------------------------------------------------

Changes since v1.4.0 are as follows:

Andre Noll:
      object-refs: avoid division by zero

Andreas Ericsson:
      git wrapper: fix command name in an error message.

David Woodhouse:
      Log peer address when git-daemon called from inetd

Dennis Stosberg:
      Make t4101-apply-nonl bring along its patches
      Make t8001-annotate and t8002-blame more portable
      Fix t8001-annotate and t8002-blame for ActiveState Perl
      Solaris needs inclusion of signal.h for signal()
      Fix pkt-line.h to compile with a non-GCC compiler
      Fix expr usage for FreeBSD

Eric W. Biederman:
      Don't parse any headers in the real body of an email message.
      Fix git-format-patch -s
      Check and document the options to prevent mistakes.

Eric Wong:
      git-svn: t0000: add -f flag to checkout
      git-svn: fix handling of filenames with embedded '@'
      git-svn: eol_cp corner-case fixes
      git-svn: restore original LC_ALL setting (or unset) for commit
      git-svn: don't allow commit if svn tree is not current
      git-svn: support -C<num> passing to git-diff-tree
      git-svn: --branch-all-refs / -B support
      git-svn: optimize --branch and --branch-all-ref
      git-svn: support manually placed initial trees from fetch
      git-svn: Move all git-svn-related paths into $GIT_DIR/svn
      git-svn: minor cleanups, extra error-checking
      git-svn: add --repack and --repack-flags=3D options
      git-svn: add --shared and --template=3D options to pass to init-d=
b
      git-svn: add some functionality to better support branches in svn
      git-svn: add UTF-8 message test
      git-svn: add 'log' command, a facsimile of basic `svn log'
      git-svn: add support for Perl SVN::* libraries
      git-svn: make the $GIT_DIR/svn/*/revs directory obsolete
      git-svn: avoid creating some small files
      git-svn: fix several small bugs, enable branch optimization
      git-svn: Eliminate temp file usage in libsvn_get_file()
      git-svn: bugfix and optimize the 'log' command
      git-svn: tests no longer fail if LC_ALL is not a UTF-8 locale
      git-svn: svn (command-line) 1.0.x compatibility
      git-svn: rebuild convenience and bugfixes
      git-svn: fix --rmdir when using SVN:: libraries
      rebase: Allow merge strategies to be used when rebasing
      rebase: error out for NO_PYTHON if they use recursive merge
      git-svn: fix commit --edit flag when using SVN:: libraries
      rebase: allow --merge option to handle patches merged upstream
      rebase: cleanup rebasing with --merge
      rebase: allow --skip to work with --merge
      git-svn: SVN 1.1.x library compatibility
      git-svn: several graft-branches improvements
      git-svn: add the commit-diff command
      git-svn: add --follow-parent and --no-metadata options to fetch
      git-svn: be verbose by default on fetch/commit, add -q/--quiet op=
tion
      rebase: get rid of outdated MRESOLVEMSG
      rebase: check for errors from git-commit
      git-svn: allow a local target directory to be specified for init

=46lorian Forster:
      gitweb: Adding a `blame' interface.
      gitweb: Make the `blame' interface in gitweb optional.
      Remove ranges from switch statements.
      Initialize FAMs using `FLEX_ARRAY'.
      Don't instantiate structures with FAMs.
      Cast pointers to `void *' when used in a format.
      Don't use empty structure initializers.
      Change types used in bitfields to be `int's.
      Remove all void-pointer arithmetic.

=46redrik Kuivinen:
      blame: Add --time to produce raw timestamps

Jakub Narebski:
      Update gitweb README: gitweb is now included with git
      Move gitweb style to gitweb.css
      gitweb: safely output binary files for 'blob_plain' action
      gitweb: text files for 'blob_plain' action without charset by def=
ault
      Fix gitweb stylesheet
      Make CSS file gitweb/gitweb.css more readable
      gitweb: add type=3D"text/css" to stylesheet link
      Fix: Support for the standard mime.types map in gitweb
      gitweb: A couple of page title tweaking
      gitweb: style done with stylesheet
      gitweb: whitespace cleanup
      Add git version to gitweb output
      Move $gitbin earlier in gitweb.cgi
      gitweb: Make use of $PATH_INFO for project parameter
      gitweb: whitespace cleanup around '=3D'

Jeff King:
      git-commit: allow -e option anywhere on command line
      quote.c: silence compiler warnings from EMIT macro

Johannes Schindelin:
      diff options: add --color
      Initialize lock_file struct to all zero.
      Fix setting config variables with an alternative GIT_CONFIG
      Read configuration also from $HOME/.gitconfig
      repo-config: Fix late-night bug
      git_config: access() returns 0 on success, not > 0
      patch-id: take "commit" prefix as well as "diff-tree" prefix
      Teach diff about -b and -w flags
      cvsimport: always set $ENV{GIT_INDEX_FILE} to $index{$branch}
      apply: replace NO_ACCURATE_DIFF with --inaccurate-eof runtime fla=
g.
      add diff_flush_patch_id() to calculate the patch id
      format-patch: introduce "--ignore-if-in-upstream"
      t4014: fix for whitespace from "wc -l"
      format-patch: use clear_commit_marks() instead of some ad-hockery
      Save errno in handle_alias()

Junio C Hamano:
      read-tree: --prefix=3D<path>/ option.
      write-tree: --prefix=3D<path>
      read-tree: reorganize bind_merge code.
      fetch-pack: give up after getting too many "ack continue"
      Fix earlier mismerges.
      shared repository: optionally allow reading to "others".
      gitk: rereadrefs needs listrefs
      fix git alias
      t5100: mailinfo and mailsplit tests.
      mailinfo: ignore blanks after in-body headers.
      fix rfc2047 formatter.
      xdiff: minor changes to match libxdiff-0.21
      Restore SIGCHLD to SIG_DFL where we care about waitpid().
      checkout -f: do not leave untracked working tree files.
      upload-pack: avoid sending an incomplete pack upon failure
      upload-pack: prepare for sideband message support.
      Retire git-clone-pack
      upload-pack/fetch-pack: support side-band communication
      Add renaming-rebase test.
      daemon: send stderr to /dev/null instead of closing.
      rebase --merge: fix for rebasing more than 7 commits.
      Makefile: do not force unneeded recompilation upon GIT_VERSION ch=
anges
      Makefile: do not recompile main programs when libraries have chan=
ged.
      usage: minimum type fix.
      git-pull: abort when fmt-merge-msg fails.
      git-merge --squash
      diff --color: use reset sequence when we mean reset.
      repo-config: fix printing of bool
      diff --color: use $GIT_DIR/config
      git-repack: Be careful when updating the same pack as an existing=
 one.
      t4014: add format-patch --ignore-if-in-upstream test
      combine-diff.c: type sanity
      connect.c: remove unused parameters from tcp_connect and proxy_co=
nnect
      connect.c: check the commit buffer boundary while parsing.
      t/README: start testing porcelainish
      checkout -m: fix read-tree invocation
      t4014: fix test commit labels.
      diff.c: fix get_patch_id()
      Racy GIT (part #3)
      upload-pack.c: <sys/poll.h> includes <ctype.h> on OpenBSD 3.8

Linus Torvalds:
      gitweb.cgi history not shown
      Shrink "struct object" a bit
      Move "void *util" from "struct object" into "struct commit"
      Some more memory leak avoidance
      Remove "refs" field from "struct object"
      Add specialized object allocator
      Add "named object array" concept
      Fix grow_refs_hash()
      Tweak diff colors
      Do not try futile object pairs when repacking.
      Abstract out accesses to object hash array
      revision.c: --full-history fix.
      git object hash cleanups

Lukas Sandstr=F6m:
      Make git-write-tree a builtin
      Make git-mailsplit a builtin
      Make git-mailinfo a builtin
      Make git-stripspace a builtin
      Make git-update-index a builtin
      Make git-update-ref a builtin

Martin Langhoff:
      cvsimport: ignore CVSPS_NO_BRANCH and impossible branches
      cvsimport: complete the cvsps run before starting the import
      cvsimport: keep one index per branch during import
      git-repack -- respect -q and be quiet
      cvsimport: setup indexes correctly for ancestors and incremental =
imports
      cvsimport - cleanup of the multi-indexes handling

Matthias Kestenholz:
      add GIT-CFLAGS to .gitignore

Matthias Lederhofer:
      correct documentation for git grep

Nicolas Pitre:
      consider previous pack undeltified object state only when reusing=
 delta data
      don't load objects needlessly when repacking

Paul Eggert:
      date.c: improve guess between timezone offset and year.

Paul Mackerras:
      Fix PPC SHA1 routine for large input buffers

Peter Eriksen:
      Implement safe_strncpy() as strlcpy() and use it more.
      Rename safe_strncpy() to strlcpy().

Petr Baudis:
      Support for extracting configuration from different files
      Support for the standard mime.types map in gitweb
      Customizable error handlers
      Fix errno usage in connect.c

Rene Scharfe:
      git-tar-tree: Simplify write_trailer()
      git-tar-tree: documentation update
      git-tar-tree: no more void pointer arithmetic
      Make release tarballs friendlier to older tar versions

Robin Rosenberg:
      Minor documentation fixup.

Sean Estabrooks:
      Add a "--notags" option for git-p4import.

Sven Verdoolaege:
      git-cvsexportcommit.perl: fix typo

Timo Hirvonen:
      gitweb: Use $hash_base as $search_hash if possible
      git-merge: Don't use -p when outputting summary
      Clean up diff.c
      Make some strings const

Uwe Zeisberger:
      Fix possible out-of-bounds array access

Yakov Lerner:
      auto-detect changed prefix and/or changed build flags
      Pass -DDEFAULT_GIT_TEMPLATE_DIR only where actually used.

Yann Dirson:
      git-commit: filter out log message lines only when editor was run=
=2E
