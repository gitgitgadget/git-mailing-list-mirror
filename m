From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: git-gui 0.11.0 tagged
Date: Sun, 10 Aug 2008 00:07:10 -0700
Message-ID: <20080810070710.GA24229@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 09:08:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS52M-0005sx-UT
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 09:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbYHJHHN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Aug 2008 03:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbYHJHHM
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 03:07:12 -0400
Received: from george.spearce.org ([209.20.77.23]:54766 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbYHJHHL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 03:07:11 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D99B23836B; Sun, 10 Aug 2008 07:07:10 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91804>

I just tagged git-gui 0.11.0.  This is highly likely the version
that will be shipping with git 1.6.0.  With the exception of the
bump to the GIT-VERSION-GEN script it already is part of Junio's
master branch, and has been for a little while now.

Thanks to everyone who contributed to this cycle.  At this point
git-gui is mostly in maintenance mode, and you can see from the
changes that most of the work was not done by me this time around.

The full list of changes since 0.10.3 follows.

------

Abhijit Menon-Sen (3):
      git-gui: Move on to the next filename after staging/unstaging a c=
hange
      git-gui: Don't select the wrong file if the last listed file is s=
taged.
      git-gui: Look for gitk in $PATH, not $LIBEXEC/git-core

Alexander Gavrilov (6):
      Fix pre-commit hooks under MinGW/MSYS
      Add options to control the search for copies in blame.
      Kill the blame back-end on window close.
      Add a menu item to invoke full copy detection in blame.
      git-gui: Fix the Remote menu separator.
      git-gui: Preserve scroll position on reshow_diff.

Christian Stimming (1):
      git-gui: Update German translation

Johannes Schindelin (1):
      git-gui: MERGE_RR lives in .git/ directly with newer Git versions

Johannes Sixt (4):
      git-gui: Implement "Stage/Unstage Line"
      git-gui: Fix "Stage/Unstage Line" with one line of context.
      git-gui: "Stage Line": Treat independent changes in adjacent line=
s better
      git-gui: Adapt discovery of oguilib to execdir 'libexec/git-core'

Michele Ballabio (2):
      git-gui: update po/it.po
      git-gui: add a part about format strings in po/README

Mikael Magnusson (1):
      git-gui: Update swedish translation.

Richard Quirk (1):
      git-gui: Fix accidental staged state toggle when clicking top pix=
el row

Shawn O. Pearce (4):
      git-gui: Correct 'Visualize Branches' on Mac OS X to start gitk
      git-gui: Fix gitk search in $PATH to work on Windows
      git-gui: Update git-gui.pot for 0.11 nearing release
      git-gui 0.11

Soeren Finster (1):
      git-gui: Exit shortcut in MacOSX repaired

Steffen Prohaska (3):
      git-gui: Correct installation of library to be $prefix/share
      git-gui (Windows): Switch to relative discovery of oguilib
      git-gui (Windows): Change wrapper to execdir 'libexec/git-core'

=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93 (1):
      git-gui: update Japanese translation

--=20
Shawn.
