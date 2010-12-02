From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: (minor) problems with gitk
Date: Thu, 2 Dec 2010 11:51:05 +0100
Message-ID: <20101202105105.GA20016@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 02 11:51:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO6kv-0000CO-64
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 11:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756060Ab0LBKvI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Dec 2010 05:51:08 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43142 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748Ab0LBKvH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 05:51:07 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1PO6kj-0006pD-IB
	for git@vger.kernel.org; Thu, 02 Dec 2010 11:51:05 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1PO6kj-0006sA-HM
	for git@vger.kernel.org; Thu, 02 Dec 2010 11:51:05 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162691>

Hello,

just to let you know ...

(This happens with Debian's git 1.7.2.3.)

If gitk only shows a few commits such that the canvas containing the
list isn't completely filled, I can scroll the commits down using the
mouse wheel.  Then clicking on a commit doesn't work anymore.  I have t=
o
click in the upper area of the canvas to change the focus, that feels
scary.  I would expect that scrolling doesn't work at all.

When changing the highlight drop box to "touching paths" and entering a
string starting with / sometimes a message on the console is printed
("oops, git diff-tree died") sometimes together with an error dialog.
I would expect here that this path is smoothly ignored.  (Maybe unless =
the
path specifies the working copy?).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
