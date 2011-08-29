From: Jonas Fonseca <fonseca@diku.dk>
Subject: [ANNOUNCE] tig-0.18
Date: Mon, 29 Aug 2011 05:10:02 +0200
Message-ID: <20110829031002.GA15646@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 29 05:10:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxsF5-00020Y-Hw
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 05:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170Ab1H2DKL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Aug 2011 23:10:11 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:53815 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751961Ab1H2DKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2011 23:10:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 9EA8219BCD8
	for <git@vger.kernel.org>; Mon, 29 Aug 2011 05:10:07 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 11569-08 for <git@vger.kernel.org>; Mon, 29 Aug 2011 05:10:02 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id EE7D419BCC5
	for <git@vger.kernel.org>; Mon, 29 Aug 2011 05:10:02 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP id 93C706DF823
	for <git@vger.kernel.org>; Mon, 29 Aug 2011 05:08:57 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id D549E16290E; Mon, 29 Aug 2011 05:10:02 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180291>

Hello,

This release brings several diff and blame view improvements, as well a=
s
a handful of bug fixes. It also marks that the tig repository now sport=
s
1001 commits. The full list of noteable changes are listed below. Enjoy=
!

What is tig?
------------
Tig is an ncurses-based text-mode interface for git. It functions mainl=
y
as a git repository browser, but can also assist in staging changes for
commit at chunk level and act as a pager for output from various git
commands.

 - Homepage:	http://jonas.nitro.dk/tig/
 - Manual:	http://jonas.nitro.dk/tig/manual.html
 - Tarballs:	http://jonas.nitro.dk/tig/releases/
 - Git URL:	git://repo.or.cz/tig.git=20
 - Gitweb:	http://repo.or.cz/w/tig.git

Release notes
-------------
Incompatibilities:

 - Remove support for the deprecated TIG_{MAIN,DIFF,LOG,TREE,BLOB}_CMD
   environment variables.

Improvements:

 - Pressing enter on diff stat file lines will jump to file's diff.
 - Na=C3=AFvely color blame IDs to distinguish lines.
 - Document palette color options used for revision graph and blame IDs=
=2E
 - Add support for blaming diff lines.
 - Add diff-context option and bindings to increase the diff context in
   the diff and stage view.
 - (GH-6) Make blame configurable via extra options passed from the com=
mand
   line and blame-options setting from ~/.tigrc. For example:
  =20
   	set blame-options =3D -C -C -C

Bug fixes:

 - Expand browsing state variables for prompt. (LP #694780, Debian #635=
546)
 - Fix segfault when sorting the branch view by author.
 - Expand %(directory) to . for the root directory. (GH-3)
 - Accept 'utf-8' for the line-graphics option as indicated in the docs=
=2E
 - Use erasechar() to check for the correct backspace character.

Change summary
--------------
The diffstat and log summary for changes made in this release.

 Makefile            |    7 +-
 NEWS                |   31 +-
 VERSION             |    2 +-
 contrib/aspell.dict |    9 +-
 io.c                |    7 +
 manual.txt          |    2 +
 tig.1.txt           |    7 +-
 tig.c               | 1614 +++++++++++++++++++++++++++----------------
 tig.h               |   27 +-
 tigrc.5.txt         |   76 ++-
 10 files changed, 1124 insertions(+), 658 deletions(-)

    58	Jonas Fonseca
     1	Ozan =C3=87a=C4=9Flayan
     1	Pierre Habouzit
     2	Sebastian Harl
     3	Sven Wegener
     1	Tony Miller
     1	Von Fugal

--=20
Jonas Fonseca
