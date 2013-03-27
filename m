From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [BUG gitk] strange scrolling behaviour if history canvas not
 completely filled
Date: Wed, 27 Mar 2013 14:35:29 +0100
Message-ID: <20130327133529.GA10464@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 27 14:36:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKqWL-00006l-AM
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 14:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027Ab3C0Nfc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Mar 2013 09:35:32 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35990 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437Ab3C0Nfa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 09:35:30 -0400
Received: from dude.hi.pengutronix.de ([2001:6f8:1178:2:21e:67ff:fe11:9c5c])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1UKqVl-0006GR-Qu
	for git@vger.kernel.org; Wed, 27 Mar 2013 14:35:29 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.80)
	(envelope-from <ukl@pengutronix.de>)
	id 1UKqVl-0003Il-Q2
	for git@vger.kernel.org; Wed, 27 Mar 2013 14:35:29 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219248>

Hello,

(running gitk from Debian's gitk 1:1.8.2~rc3-1 package)

if only a few commits are shown in gitk such that the history canvas is
too big, i.e. there is place for more commits to be shown, the scroll
bar on the right hand side correctly is greyed out. Still I can scroll
using the mouse moving the oldest shown to the bottom of the canvas
(sometimes even half a line further). Not sure this qualifies as bug
already.

But when having scrolled down selecting commits with the mouse doesn't
work as expected anymore: If I click on the topmost commit, not that on=
e
is selected but the one that would appear at the mouse tip if the
history were not scrolled down.

Best regards
Uwe

PS: I'm not subscribed, so please Cc: me on replies.

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
