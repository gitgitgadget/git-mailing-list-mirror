From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Sun, 13 Aug 2006 19:30:16 -0700
Message-ID: <7vbqqogibr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Aug 14 04:30:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCSDn-0005Uw-7x
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 04:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbWHNCaS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 22:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbWHNCaS
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 22:30:18 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:26829 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751796AbWHNCaR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Aug 2006 22:30:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060814023017.CTCR29796.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 13 Aug 2006 22:30:17 -0400
To: git@vger.kernel.org
X-maint-at: 9a1ae9ab03abaffc977421f182997f3e735e7098
X-master-at: 182a8dabd5f5f646608f3857f10f3ac18c3d1445
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25309>

* The 'maint' branch now is at 1.4.2 plus a few fixes to be
  released as part of 1.4.2.1

   Luben Tuikov:
      Fix regex pattern in commit-msg
      sample commit-msg hook: no silent exit on duplicate Signed-off-by lines


* The 'master' branch has these since the last announcement.
  Most are what have been cooking in "next" for quite a while.

   Eric Wong:
      git-svn: correctly kill keyword expansion without munging EOLs
      git-svn: bugfix: allow SVN:: lib users to track the root of the repository
      git-svn: split the path from the url correctly with limited perms

   Jakub Narebski:
      gitweb: whitespace cleanup
      gitweb: Use list for of open for running git commands, thorougly.
      gitweb: simplify git_get_hash_by_path
      gitweb: More explicit error messages for open "-|"
      gitweb: Cleanup - chomp $line in consistent style
      gitweb: Cleanup - chomp @lines in consistent style
      gitweb: Add git_page_nav for later use
      gitweb: Navbar refactoring - use git_page_nav to generate navigation bar
      gitweb: Replace form-feed character by ^L
      gitweb: Show project descriptions with utf-8 characters in project list correctly
      gitweb: Add "\n" after <br/> in git_page_nav
      gitweb: Pager refactoring - use git_get_paging_nav for pagination
      gitweb: Remove $project from git_get_paging_nav arguments
      gitweb: Headers refactoring - use git_header_div for header divs
      gitweb: Remove characters entities entirely when shortening string
      gitweb: Ref refactoring - use git_get_referencing for marking tagged/head commits
      gitweb: Refactor generation of shortlog, tags and heads body
      gitweb: do not quote path for list version of open "-|"
      gitweb: Remove characters entities entirely when shortening string -- correction
      gitweb: Reordering code and dividing it into categories
      gitweb: Refactoring git_project_list
      autoconf: Add support for setting SHELL_PATH and PERL_PATH
      autoconf: Move site configuration section earlier in configure.ac
      autoconf: Add support for setting PYTHON_PATH or NO_PYTHON
      autoconf: Check for ll hh j z t size specifiers introduced by C99
      autoconf: Typo cleanup, reordering etc.
      Copy description of new build configuration variables to configure.ac
      autoconf: Set NEEDS_LIBICONV unconditionally if there is no iconv in libc
      gitweb: Separate input validation and dispatch, add comment about opml action
      gitweb: die_error first (optional) parameter is HTTP status
      gitweb: Use undef for die_error to use default first (status) parameter value
      gitweb: Don't undefine query parameter related variables before die_error
      gitweb: Cleanup and uniquify error messages
      gitweb: No periods for error messages
      gitweb: No error messages with unescaped/unprotected user input
      gitweb: PATH_INFO=/ means no project
      gitweb: Inline $rss_link
      gitweb: Refactor untabifying - converting tabs to spaces
      gitweb: fix commitdiff for root commits
      gitweb: Skip nonmatching lines in difftree output, consistently
      autoconf: Unset NO_STH and NEED_STH when it is detected not needed
      gitweb: Remove unused variables in git_shortlog_body and git_heads
      autoconf: Add configure target to main Makefile
      autoconf: Error out on --without-shell and --without-perl
      autoconf: Improvements in NO_PYTHON/PYTHON_PATH handling
      autoconf: Move variables which we always set to config.mak.in
      autoconf: It is --without-python, not --no-python
      autoconf: Add support for setting CURLDIR, OPENSSLDIR, EXPATDIR
      gitweb: Whitespace cleanup - tabs are for indent, spaces are for align

   Jeff King:
      gitweb: optionally read config from GITWEB_CONFIG

   Johannes Schindelin:
      read-trees: refactor the unpack_trees() part
      read-tree: move merge functions to the library
      http-push: avoid fork() by calling merge_bases() directly
      Add the --color-words option to the diff options family

   Junio C Hamano:
      upload-pack: use object pointer not copy of sha1 to keep track of has/needs.
      upload-pack: lift MAX_NEEDS and MAX_HAS limitation
      sha1_file.c: expose map_sha1_file() interface.
      pack-objects: reuse deflated data from new-style loose objects.
      unpack-objects: read configuration data upon startup.
      gitweb: There can be more than two levels of subdirectories
      gitweb: an obvious cut and paste error.
      gitweb: fix use of uninitialized value.
      gitweb: when showing history of a tree, show tree link not blob
      gitweb: avoid undefined value warning in print_page_path
      gitweb/README: do not bug Kay with gitweb questions anymore
      Makefile: gitweb/gitweb.cgi is now generated.
      gitweb: do not use @@FOO@@ for replaced tokens
      Make git-checkout-index a builtin
      builtins: Makefile clean-up
      git.c: Rename NEEDS_PREFIX to RUN_SETUP
      autoconf: fix NEEDS_SSL_WITH_CRYPTO
      autoconf: NO_IPV6
      Racy git: avoid having to be always too careful
      read-cache: tweak racy-git delay logic
      autoconf: clean temporary file mak.append
      git-apply: applying a patch to make a symlink shorter.
      combine-diff: use color
      Fix git-diff A...B
      builtin-apply: remove unused increment
      git-sh-setup: do not use repo-config to test the git directory
      git-grep: show pathnames relative to the current directory
      git-am: give better diagnostics when the patch does not apply during --3way
      Better error message when we are unable to lock the index file
      t/t4013: fix futzing with the version string.

   Luben Tuikov:
      gitweb: git_tree displays blame based on repository config
      gitweb: bugfix: git_commit and git_commitdiff parents
      gitweb: blame table row no highlight fix

   Martin Waitz:
      gitweb: fill in gitweb configuration by Makefile
      gitweb: use out-of-line GIT logo.

   Matthias Kestenholz:
      Make git-name-rev a builtin
      Make git-pack-objects a builtin
      Make git-unpack-objects a builtin
      Make git-symbolic-ref a builtin
      Add gitweb.cgi to .gitignore

   Matthias Lederhofer:
      upload-pack: fix timeout in create_pack_file
      pager: environment variable GIT_PAGER to override PAGER
      gitweb: use a hash to lookup the sub for an action
      gitweb: require $ENV{'GITWEB_CONFIG'}
      gitweb: check if HTTP_ACCEPT is really set
      gitweb: fix commitdiff_plain for root commits
      gitweb: fix $project usage

   Paul Mackerras:
      gitk: Allow the user to set some colors
      gitk: Show the currently checked-out head in bold font

   Ramsay Jones:
      Fix header breakage with _XOPEN_SOURCE.

   Rene Scharfe:
      Add has_extension()
      git-verify-pack: show usage when no pack was specified
      git-verify-pack: more careful path handling
      git-verify-pack: insist on .idx extension
      git-verify-pack: get rid of while loop
      git-verify-pack: free pack after use and a cleanup
      git-verify-pack: buffer overrun paranoia
      git-verify-pack: no need to count errors
      git-verify-pack: make builtin
      drop length argument of has_extension

   Rutger Nijlunsing:
      http-push: Make WebDAV work with (broken?) default apache2 WebDAV module
      Add Documentation/howto/setup-git-server-over-http.txt

   Timo Hirvonen:
      --name-only, --name-status, --check and -s are mutually exclusive
      Remove awkward compatibility warts


* The 'next' branch, in addition, has these.  Essentially, they
  are "Git.pm/Git.xs" series and "merge-recur" series.

   Dennis Stosberg:
      "test" in Solaris' /bin/sh does not support -e
      Makefile fix for Solaris
      Add possibility to pass CFLAGS and LDFLAGS specific to the perl subdir

   Johannes Schindelin:
      Git.xs: older perl do not know const char *
      Status update on merge-recursive in C
      Cumulative update of merge-recursive in C
      merge-recur: Convert variable names to lower_case
      merge-recur: Get rid of debug code
      merge-recur: Remove dead code
      merge-recur: Fix compiler warning with -pedantic
      merge-recur: Cleanup last mixedCase variables...
      merge-recur: Explain why sha_eq() and struct stage_data cannot go
      merge-recur: fix thinko in unique_path()
      merge-recur: use the unpack_trees() interface instead of exec()ing read-tree
      merge-recur: virtual commits shall never be parsed
      merge-recursive: fix rename handling
      merge-recur: do not call git-write-tree
      merge-recur: do not setenv("GIT_INDEX_FILE")
      merge-recur: if there is no common ancestor, fake empty one
      merge-recur: try to merge older merge bases first
      merge-recur: do not die unnecessarily
      discard_cache(): discard index, even if no file was mmap()ed

   Junio C Hamano:
      Perl interface: add build-time configuration to allow building with -fPIC
      Perl interface: make testsuite work again.
      perl: fix make clean
      Git.pm: tentative fix to test the freshly built Git.pm
      Perly Git: arrange include path settings properly.
      Makefile: Set USE_PIC on x86-64
      Perly git: work around buggy make implementations.
      Git.pm: clean generated files.
      Perly Git: make sure we do test the freshly built one.
      INSTALL: a tip for running after building but without installing.
      Work around sed and make interactions on the backslash at the end of line.
      recur vs recursive: help testing without touching too many stuff.
      Makefile: git-merge-recur depends on xdiff libraries.
      .gitignore: git-merge-recur is a built file.
      upload-pack: minor clean-up in multi-ack logic
      upload-pack: stop the other side when they have more roots than we do.

   Pavel Roskin:
      Fix probing for already installed Error.pm
      Delete manuals if compiling without docs
      Make perl interface a separate package

   Petr Baudis:
      Introduce Git.pm (v4)
      Git.pm: Implement Git::exec_path()
      Git.pm: Call external commands using execv_git_cmd()
      Git.pm: Implement Git::version()
      Add Error.pm to the distribution
      Git.pm: Better error handling
      Git.pm: Handle failed commands' output
      Git.pm: Enhance the command_pipe() mechanism
      Git.pm: Implement options for the command interface
      Git.pm: Add support for subdirectories inside of working copies
      Convert git-mv to use Git.pm
      Git.pm: assorted build related fixes.
      Git.pm: Try to support ActiveState output pipe
      Git.pm: Swap hash_object() parameters
      Git.pm: Fix Git->repository("/somewhere/totally/elsewhere")
      Git.pm: Support for perl/ being built by a different compiler
      Git.pm: Remove PerlIO usage from Git.xs
      Git.pm: Avoid ppport.h
      Git.pm: Don't #define around die
      Use $GITPERLLIB instead of $RUNNING_GIT_TESTS and centralize @INC munging
      Git.pm: Add config() method
      Convert git-send-email to use Git.pm
      Git.pm: Introduce ident() and ident_person() methods
      Make it possible to set up libgit directly (instead of from the environment)
      Git.pm: Introduce fast get_object() method
      Convert git-annotate to use Git.pm
      Eliminate Scalar::Util usage from private-Error.pm


* The 'pu' branch, in addition, has these.

   Junio C Hamano:
      git-status WIP
