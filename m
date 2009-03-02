From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: topgit patches
Date: Mon, 2 Mar 2009 17:26:41 +0100
Message-ID: <20090302162641.GB15229@pengutronix.de>
References: <20090225195856.GA12372@pengutronix.de> <20090225212309.GM12275@machine.or.cz> <20090225231550.GA19741@pengutronix.de> <20090226060652.GA16251@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: martin f krafft <madduck@debian.org>
X-From: git-owner@vger.kernel.org Mon Mar 02 17:28:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeB09-0004hQ-JQ
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 17:28:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756484AbZCBQ0q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Mar 2009 11:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756167AbZCBQ0q
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 11:26:46 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55169 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755684AbZCBQ0p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 11:26:45 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LeAyY-0003sC-6q; Mon, 02 Mar 2009 17:26:42 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1LeAyX-0001GH-Gd; Mon, 02 Mar 2009 17:26:41 +0100
Content-Disposition: inline
In-Reply-To: <20090226060652.GA16251@lapse.rw.madduck.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111944>

Hello,

On Thu, Feb 26, 2009 at 07:06:52AM +0100, martin f krafft wrote:
> also sprach Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> [2009=
=2E02.26.0015 +0100]:
> > Well, I already wondered if there is someone using topgit apart
> > from me. :-)
>=20
> I use it and would like to actively maintain it, but time is short
> and I wanted to push out a new option parser with 0.6, but it's just
> not finished yet. As soon as I find a few hours, I'll try to revisit
> it. But if someone else has the time, maybe we can prepare a 0.6
> without a new option parser?
I assume you planned to use git rev-parse --parseopt?

Since topgit-0.5 we have some fixes, a new export method and improved
bash completion.  Just repackaging the current state into a new Debian
package closes 4 bugs in the Debian BTS.

Before 0.6 I still need to write some documentation for the new export
method, but after that I consider releasing the then current state as
0.6 is a good idea.

martin, Petr, others: any comments?  Should I just tag if I feel ready?

martin: I can try to prepare the Debian package, AFAIK I cannot upload
it, so here I need your help.  (And maybe you should check the package,
because up to now I only created Debian packages for my private use.)

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
Peiner Strasse 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-=
0    |
Amtsgericht Hildesheim, HRA 2686              | Fax:   +49-5121-206917-=
5555 |
