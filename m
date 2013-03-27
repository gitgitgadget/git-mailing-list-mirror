From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [BUG gitk] notes not reloaded on Update/Reload
Date: Wed, 27 Mar 2013 14:27:10 +0100
Message-ID: <20130327132710.GA4761@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 27 14:27:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKqOB-00008i-OH
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 14:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743Ab3C0N1M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Mar 2013 09:27:12 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47407 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613Ab3C0N1L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 09:27:11 -0400
Received: from dude.hi.pengutronix.de ([2001:6f8:1178:2:21e:67ff:fe11:9c5c])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1UKqNi-0005kU-Dt
	for git@vger.kernel.org; Wed, 27 Mar 2013 14:27:10 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.80)
	(envelope-from <ukl@pengutronix.de>)
	id 1UKqNi-0002ie-Cz
	for git@vger.kernel.org; Wed, 27 Mar 2013 14:27:10 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:21e:67ff:fe11:9c5c
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219247>

Hello,

running gitk from Debian (1:1.8.2~rc3-1) I noticed that

	$ gitk ... &
	$ git notes edit $some_ref_shown_by_gitk

and then pressing F5 or Shift-F5 doesn't update the notes shown.

Best regards
Uwe

PS: Please Cc: on replies as I'm not subscribed

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
