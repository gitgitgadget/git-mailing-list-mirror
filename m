From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: git-gui 0.9.1 release plans
Date: Mon, 24 Dec 2007 23:54:41 -0500
Message-ID: <20071225045441.GQ14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 25 05:55:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J71os-0002dp-SB
	for gcvg-git-2@gmane.org; Tue, 25 Dec 2007 05:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbXLYEyp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Dec 2007 23:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbXLYEyp
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Dec 2007 23:54:45 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45343 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbXLYEyo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Dec 2007 23:54:44 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1J71oE-0002OB-94
	for git@vger.kernel.org; Mon, 24 Dec 2007 23:54:30 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6A4F320FBAE; Mon, 24 Dec 2007 23:54:41 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69227>

So git-gui 0.9.1...

I have 12 changes in `master` since 0.9.0 that will be included.
Other than these changes, and maybe Bernt's "always append LF in
commit message" patch, this is what will make up the 0.9.1 release.

I expect 0.9.1 will be the last git-gui release before git 1.5.4
goes final, which means git 1.5.4 will be shipping with 0.9.1.

Translators, testers, etc. please speak up in the next week and a
half and get your patches in if there are any outstanding translation
changes or minor bug fixes that should be included.


I'm on vacation (and completely offline) Jan. 5-13th, so I'd like
to wrap up 0.9.1 by the 4th if I can, as Junio has been targeting
for a mid-Jan release of git 1.5.4.


---  Changes since 0.9.0 ---

Christian Stimming (2):
      Update git-gui.pot with latest (few) string additions and changes=
=2E
      Update German translation. 100% completed.

Johannes Sixt (2):
      git-gui: Improve the application icon on Windows.
      git-gui: Move frequently used commands to the top of the context =
menu.

Mark Levedahl (1):
      git-gui: Unconditionally use absolute paths with Cygwin

Michele Ballabio (2):
      git-gui: fix a typo in lib/commit.tcl
      git-gui: update it.po and glossary/it.po

Miklos Vajna (1):
      Update Hungarian translation. 100% completed.

Robert Schiele (1):
      git-gui: install-sh from automake does not like -m755

Shawn O. Pearce (1):
      git-gui: Handle file mode changes (644->755) in diff viewer

brian m. carlson (1):
      git-gui: Reorder msgfmt command-line arguments

=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93 (1):
      Update ja.po for git-gui


--=20
Shawn.
