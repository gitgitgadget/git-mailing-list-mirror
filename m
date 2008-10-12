From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: What's in git/spearce.git (Oct 2008, #02; Sun, 12)
Date: Sun, 12 Oct 2008 14:25:12 -0700
Message-ID: <20081012212512.GF4856@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 12 23:33:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp8Yg-0007QF-6h
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 23:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042AbYJLVZO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Oct 2008 17:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752413AbYJLVZO
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 17:25:14 -0400
Received: from george.spearce.org ([209.20.77.23]:44612 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbYJLVZN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 17:25:13 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 86B883835F; Sun, 12 Oct 2008 21:25:12 +0000 (UTC)
Content-Disposition: inline
X-maint-at: 72d404debaa804fca82fd9cf710fbde48c7305c6
X-master-at: 5c283eb13c94be6ca974aa722159dc9838d10d97
X-maint-was: e261cf94848d31868c21fb11cade51c30dfcdbe7
X-master-was: 276328ffb87cefdc515bee5f09916aea6e0244ed
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98055>

What's in git/spearce.git (Oct 2008, #02; Sun, 12)

  maint 72d404d (test-lib: fix broken printf)
 master 5c283eb (Merge branch 'maint')
-----------------------------------------------------------------------=
-

* The 'maint' branch has these fixes since the last announcement.

Brandon Casey (2):
  builtin-merge.c: allocate correct amount of memory
  git-stash.sh: fix flawed fix of invalid ref handling (commit da65e7c1=
)

Deskin Miller (1):
  git init: --bare/--shared overrides system/global config

Imre Deak (1):
  builtin-apply: fix typo leading to stack corruption

Jeff King (2):
  Makefile: do not set NEEDS_LIBICONV for Solaris 8
  git apply --directory broken for new files

Johannes Schindelin (2):
  git rm: refresh index before up-to-date check
  rebase -i: do not fail when there is no commit to cherry-pick

Johannes Sixt (1):
  git-push.txt: Describe --repo option in more detail

Mikael Magnusson (1):
  Fix a few typos in relnotes

Miklos Vajna (1):
  test-lib: fix color reset in say_color()

Nicolas Pitre (1):
  fix pread()'s short read in index-pack

SZEDER G=C3=A1bor (2):
  rebase -i: proper prepare-commit-msg hook argument when squashing
  rebase -i: remove leftover debugging

Samuel Tardieu (1):
  Do not use errno when pread() returns 0

Shawn O. Pearce (1):
  test-lib: fix broken printf


* The 'master' branch has these since the last announcement
  in addition to the above.

Brandon Casey (4):
  xdiff-interface.c: strip newline (and cr) from line before pattern
    matching
  Replace xmalloc/memset(0) pairs with xcalloc
  t9001: use older Getopt::Long boolean prefix '--no' rather than '--no=
-'
  Replace calls to strbuf_init(&foo, 0) with STRBUF_INIT initializer

Dmitry Potapov (4):
  add have_git_dir() function
  mingw: move common functionality to win32.h
  cygwin: Use native Win32 API for stat
  print an error message for invalid path

=46lorian Ragwitz (1):
  Add git-svn branch to allow branch creation in SVN repositories

Jonathan del Strother (1):
  Teach git diff about Objective-C syntax

Junio C Hamano (1):
  git-add --intent-to-add (-N)

Linus Torvalds (1):
  date/time: do not get confused by fractional seconds

Matt McCutchen (1):
  "git diff <tree>{3,}": do not reverse order of arguments

Michael J Gruber (1):
  make prune report removed objects on -v

Michael Witten (9):
  Docs: send-email's usage text and man page mention same options
  Docs: send-email usage text much sexier
  Docs: send-email: Man page option ordering
  send-email: change --no-validate to boolean --[no-]validate
  Docs: send-email: --chain_reply_to -> --[no-]chain-reply-to
  Docs: send-email: Remove unnecessary config variable description
  Docs: send-email: Create logical groupings for --help text
  Docs: send-email: Create logical groupings for man text
  send-email: signedoffcc -> signedoffbycc, but handle both

Mike Ralphson (1):
  gitweb: Sort the list of forks on the summary page by age

Miklos Vajna (2):
  builtin-merge: refresh the index before calling a strategy
  Cleanup in sha1_file.c::cache_or_unpack_entry()

Petr Baudis (5):
  gitweb: Clean-up sorting of project list
  gitweb: Add support for extending the action bar with custom links
  gitweb: Support for tag clouds
  gitweb: Make the by_tag filter delve in forks as well
  gitweb: Support for simple project search form

Pierre Habouzit (3):
  parse-opt: migrate fmt-merge-msg.
  parse-opt: migrate git-merge-base.
  parse-opt: migrate builtin-merge-file.

Raphael Zimmerer (1):
  git grep: Add "-z/--null" option as in GNU's grep.

Teemu Likonen (1):
  bash completion: Add --[no-]validate to "git send-email"

Thomas Rast (1):
  Documentation: remove stale howto/rebase-and-edit.txt

--=20
Shawn.
