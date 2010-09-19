From: Jonas Fonseca <fonseca@diku.dk>
Subject: [ANNOUNCE] tig-0.16.1
Date: Sun, 19 Sep 2010 20:35:56 +0200
Message-ID: <20100919183556.GA22302@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 19 20:36:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxOkA-0004XH-Bc
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 20:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755243Ab0ISSf7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 14:35:59 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:39699 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755219Ab0ISSf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 14:35:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 1082819BC4A
	for <git@vger.kernel.org>; Sun, 19 Sep 2010 20:35:58 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 23567-17 for <git@vger.kernel.org>; Sun, 19 Sep 2010 20:35:56 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id C07BE19BC46
	for <git@vger.kernel.org>; Sun, 19 Sep 2010 20:35:56 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP id 6BAC36DF823
	for <git@vger.kernel.org>; Sun, 19 Sep 2010 20:33:36 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id A8F71211E2; Sun, 19 Sep 2010 20:35:56 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156507>

A small release fixing several bugs that has accumulated.

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
Improvements:

 - Add scroll-first-col action to jump to the first column. Bound to '|=
'
   by default.
 - Add 'status-untracked-dirs' option to ignore unknown directories
   contents in the status view. On by default.

Bug fixes:

 - Fix 'tig show <commit>' to show the provided commit.
 - Fix problem with empty diff views when file specs were passed on the
   command line.
 - Fix segfault when starting tig in pager mode.

Change summary
--------------
The diffstat and log summary for changes made in this release.

 NEWS                |   17 ++++++
 VERSION             |    2 +-
 contrib/aspell.dict |    2 +-
 manual.txt          |    1 +
 tig.c               |  126 +++++++++++++++++++++++++++++++++---------
 tigrc.5.txt         |    7 +++
 6 files changed, 126 insertions(+), 29 deletions(-)

Jonas Fonseca (6):
      Refactor argv_size out from argv_append
      Fall back to retry if no diff will be shown
      Fix segfault when starting tig in pager mode
      Remove remains from the obsoleted toggle-date-short action
      Fix tig show by replacing %(commit) with %(revargs) on first disp=
lay
      tig-0.16.1

Jonathan Neusch=E4fer (1):
      Don't show out-of-sight tildes

Pierre Habouzit (5):
      Allow tig to parse control-modified chars in tigrc
      Add vi-like ^ bindings
      Add a scroll-first-col command
      Actually add the ^D binding to move-page-down
      Add an option to ignore unknown directories contents in the statu=
s view

Stefan Naewe (1):
      Use function set_tabsize()

--=20
Jonas Fonseca
