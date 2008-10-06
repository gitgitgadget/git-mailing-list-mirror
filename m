From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: What's in git/spearce.git (Oct 2008, #01; Mon, 06)
Date: Mon, 6 Oct 2008 09:59:08 -0700
Message-ID: <20081006165908.GF8203@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 06 19:06:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmtRW-0004n3-GC
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 19:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565AbYJFQ7L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Oct 2008 12:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753488AbYJFQ7K
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 12:59:10 -0400
Received: from george.spearce.org ([209.20.77.23]:54473 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067AbYJFQ7J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 12:59:09 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 699D93835F; Mon,  6 Oct 2008 16:59:08 +0000 (UTC)
Content-Disposition: inline
X-maint-at: e261cf94848d31868c21fb11cade51c30dfcdbe7
X-master-at: 276328ffb87cefdc515bee5f09916aea6e0244ed
X-maint-was: edb7e82f72106add9f2fbaf9d99d9532a72e3f91
X-master-was: 9800c0df412869c7949935b61581b9361fc49bd1
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97602>

What's in git/spearce.git (Oct 2008, #01; Mon, 06)

  maint e261cf9 (Update release notes for 1.6.0.3)
 master 276328f (Merge branch 'maint')
-----------------------------------------------------------------------=
-

Junio should be returning from vacation this week.  I will keep
updating my git/spearce.git tree until he gets back and asks for
my current topic heads.

Once Junio gets back I think we need to focus on getting 1.6.0.3
out the door.  We have 77 commits queued up since 1.6.0.2 and it
has been almost 4 weeks since our last maint release.

So please, test, test, test maint.

--------

* The 'maint' branch has these fixes since the last announcement.

Alexander Gavrilov (1):
  builtin-blame: Fix blame -C -C with submodules.

David Soria Parra (1):
  Solaris: Use OLD_ICONV to avoid compile warnings

Dmitry Potapov (2):
  make prefix_path() never return NULL
  do not segfault if make_cache_entry failed

Giuseppe Bilotta (1):
  gitweb: remove PATH_INFO from $my_url and $my_uri

Jakub Narebski (2):
  gitweb: Fix two 'uninitialized value' warnings in git_tree()
  gitweb: Add path_info tests to t/t9500-gitweb-standalone-no-errors.sh

Linus Torvalds (1):
  fix bogus "diff --git" header from "diff --no-index"

Luc Heinrich (1):
  git-svn: call 'fatal' correctly in set-tree

Michael Prokop (1):
  Replace svn.foo.org with svn.example.com in git-svn docs (RFC 2606)

Nanako Shiraishi (2):
  docs: describe pre-rebase hook
  Teach rebase -i to honor pre-rebase hook

SZEDER G=C3=A1bor (3):
  t0024: add executable permission
  Documentation: remove '\' in front of short options
  bash: remove fetch, push, pull dashed form leftovers

Shawn O. Pearce (1):
  Update release notes for 1.6.0.3

Tuncer Ayaz (1):
  Fix fetch/clone --quiet when stdout is connected

martin f. krafft (1):
  Improve git-log documentation wrt file filters


* The 'master' branch has these since the last announcement
  in addition to the above.

Brandon Casey (1):
  diff.c: remove duplicate bibtex pattern introduced by merge 92bb9785

David Aguilar (1):
  tests: add a testcase for "git submodule sync"

David Bryson (1):
  Use "git_config_string" to simplify "builtin-gc.c" code where
    "prune_expire" is set

Dmitry Potapov (1):
  do not segfault if make_cache_entry failed

Jeff King (1):
  tests: grep portability fixes

Jonathan del Strother (1):
  Add OS X support to the pre-auto-gc example hook

Nanako Shiraishi (5):
  dir.c: make dir_add_name() and dir_add_ignored() static
  run-command.c: remove run_command_v_opt_cd()
  config.c: make git_parse_long() static
  commit.c: make read_graft_file() static
  archive.c: make archiver static

Nicolas Pitre (1):
  fix openssl headers conflicting with custom SHA1 implementations

Petr Baudis (3):
  gitweb: Quote non-displayable characters in hex, not octal
  config.c: Tolerate UTF8 BOM at the beginning of config file
  gitweb: Identify all summary metadata table rows

Ralf Wildenhues (1):
  Correct typos in RelNotes-1.6.1

SZEDER G=C3=A1bor (1):
  remove vim syntax highlighting in favor of upstream


--=20
Shawn.
