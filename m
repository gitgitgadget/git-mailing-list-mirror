From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: bug in gitk: history moves right when scrolling up and down with
 mouse wheel
Date: Fri, 7 Jan 2011 11:55:23 +0100
Message-ID: <20110107105523.GA6701@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 07 11:55:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pb9yj-0001bx-PE
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 11:55:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553Ab1AGKzY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jan 2011 05:55:24 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55121 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400Ab1AGKzY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 05:55:24 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1Pb9yd-0008L5-F0
	for git@vger.kernel.org; Fri, 07 Jan 2011 11:55:23 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1Pb9yd-00027L-Dx
	for git@vger.kernel.org; Fri, 07 Jan 2011 11:55:23 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164706>

Hello,

I don't know yet how to reliably trigger that, but it feels scary.

If that help, it happens with the view

	{karo {} ^linus/master {git for-each-ref --format=3D'%(refname)' refs/=
remotes/customers/karo refs/heads/karo}}

If I knew how to record a video of my screen, I'd do this.  Maybe
someone knows?  Maybe this report is already enough?

Happens with Debian's git 1:1.7.2.3-2.2.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
