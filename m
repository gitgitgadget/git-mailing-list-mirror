From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: topgit patches
Date: Wed, 25 Feb 2009 20:58:56 +0100
Message-ID: <20090225195856.GA12372@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@ucw.cz>, "martin f. krafft" <madduck@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 21:05:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcPzs-0007gn-28
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 21:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757977AbZBYUDS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2009 15:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757947AbZBYUDR
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 15:03:17 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45145 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757790AbZBYUDR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 15:03:17 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LcPyM-0002lK-WC
	for git@vger.kernel.org; Wed, 25 Feb 2009 21:03:15 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1LcPyM-0003HJ-SC
	for git@vger.kernel.org; Wed, 25 Feb 2009 21:03:14 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111486>

Hello,

The following changes since commit 8c77c342166ddc6ecb3840628d89ddc5bb6b=
043b:
  Kirill Smelkov (1):
        tg-completion: complete options for `tg remote`

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/topgit.git pu

Uwe Kleine-K=F6nig (5):
      [TOPGIT] limit rev-list in branch_contains to a single rev
      [TOPGIT] allow working with annihilated branches
      [TOPGIT] make tg remote idempotent
      [TOPGIT] make creating a commit from a topgit branch a function
      [TOPGIT] implement linearize export method

 tg-export.sh  |   94 +++++++++++++++++++++++++++++++++++++++++++++++++=
+-------
 tg-remote.sh  |    6 ++--
 tg-summary.sh |   11 ++++++-
 tg.sh         |   19 ++++++++++-
 4 files changed, 113 insertions(+), 17 deletions(-)

I consider the first three as ready to pull (they form my master branch
at the repo above).  The fourth commit is just preparing the fifth.  Th=
e
fifth commit implements a new export method that I use often.  The erro=
r
handling isn't well tested, just because I don't usually run into merge
conflicts in my series :-)

I look forward to comments, especially for the last commit.

=46or review purposes I send the patches as a reply to this mail.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
