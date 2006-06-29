From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Wed, 28 Jun 2006 23:41:08 -0700
Message-ID: <7vpsgstqez.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jun 29 08:41:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvqDE-0004gM-2e
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 08:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbWF2GlM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 02:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932670AbWF2GlL
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 02:41:11 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:36089 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932663AbWF2GlK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 02:41:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060629064109.MRVJ6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Jun 2006 02:41:09 -0400
To: git@vger.kernel.org
X-maint-at: be0c7e069738fbb697b0719f2252107261c9340e
X-master-at: abc02670169cee9541793a86324a014272ca8ed5
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22842>

Hopefully 'master' which I tagged and pushed out as v1.4.1-rc2
is very close to the final.  I would like to merge format-patch
fixes by Johannes, see nobody yells at me for a few days, and
call it 1.4.1 this weekend.

Thanks to Pavel Roskin and Marco Roeland, the Perly Git series
by Pasky should be in much better shape now.  Timo's diff output
format options updates is looking better and I am gaining
confidence in it, especially after I've done small testsuite and
fixed things here and there.  I would want a bit more tests to
cover wider combinations to avoid regression but basically it
looks ready.  These two series are still in "pu" and I'd like to
pull them into "next" after 1.4.1.

A late comer is Linus's merge-tree/merge-files work.  I'm
parking it on "pu" but haven't read it through yet.

----------------------------------------------------------------

* The 'master' branch has these since the last announcement.

   Andreas Ericsson:
      git wrapper: fix command name in an error message.

   Dennis Stosberg:
      Solaris needs inclusion of signal.h for signal()
      Fix pkt-line.h to compile with a non-GCC compiler
      Fix expr usage for FreeBSD

   Eric Wong:
      rebase: allow --merge option to handle patches merged upstream
      rebase: cleanup rebasing with --merge
      rebase: allow --skip to work with --merge
      git-svn: SVN 1.1.x library compatibility
      git-svn: several graft-branches improvements
      git-svn: add the commit-diff command
      git-svn: add --follow-parent and --no-metadata options to fetch
      git-svn: be verbose by default on fetch/commit, add -q/--quiet option
      rebase: get rid of outdated MRESOLVEMSG
      rebase: check for errors from git-commit

   Jeff King:
      quote.c: silence compiler warnings from EMIT macro

   Johannes Schindelin:
      Teach diff about -b and -w flags
      cvsimport: always set $ENV{GIT_INDEX_FILE} to $index{$branch}
      Save errno in handle_alias()

   Junio C Hamano:
      git-merge --squash
      diff --color: use $GIT_DIR/config
      combine-diff.c: type sanity
      connect.c: remove unused parameters from tcp_connect and proxy_connect
      connect.c: check the commit buffer boundary while parsing.
      t/README: start testing porcelainish
      checkout -m: fix read-tree invocation

   Martin Langhoff:
      cvsimport: setup indexes correctly for ancestors and incremental imports
      cvsimport - cleanup of the multi-indexes handling

   Matthias Lederhofer:
      correct documentation for git grep

   Timo Hirvonen:
      Make some strings const


* The 'next' branch, in addition, has these.

   Johannes Schindelin:
      add diff_flush_patch_id() to calculate the patch id
      format-patch: introduce "--ignore-if-in-upstream"
      t4014: fix for whitespace from "wc -l"
      format-patch: use clear_commit_marks() instead of some ad-hockery

   Junio C Hamano:
      Makefile: add framework to verify and bench sha1 implementations.
      test-sha1: test hashing large buffer
      git-repack: Be careful when updating the same pack as an existing one.
      t4013: add tests for diff/log family output options.
      t4014: add format-patch --ignore-if-in-upstream test
      t4013: add more tests around -c and --cc
      t4014: fix test commit labels.
      diff.c: fix get_patch_id()

   Linus Torvalds:
      xdiff: generate "anti-diffs" aka what is common to two files


* The 'pu' branch, in addition, has these.

   Dennis Stosberg:
      "test" in Solaris' /bin/sh does not support -e
      Makefile fix for Solaris
      Add possibility to pass CFLAGS and LDFLAGS specific to the perl subdir

   Junio C Hamano:
      Fix some more diff options changes.
      t4013 test updates for new output code.
      combine-diff.c: type sanity.
      Perl interface: add build-time configuration to allow building with -fPIC
      Perl interface: make testsuite work again.
      perl: fix make clean
      Git.pm: tentative fix to test the freshly built Git.pm
      Perly Git: arrange include path settings properly.
      Makefile: Set USE_PIC on x86-64

   Linus Torvalds:
      Prepare "git-merge-tree" for future work
      Improved three-way blob merging code

   Matthias Lederhofer:
      GIT_TRACE: show which built-in/external commands are executed

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
      --name-only, --name-status, --check and -s are mutually exclusive
      Remove awkward compatibility warts
      Fix a mixed declarations and code warning

   Unknown:
      A better-scheduled PPC SHA-1 implementation.
