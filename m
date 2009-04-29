From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: (topgit question) deleting a dependency
Date: Wed, 29 Apr 2009 20:48:51 +0200
Message-ID: <20090429184851.GA17286@pengutronix.de>
References: <slrngvdgo4.kr7.sitaramc@sitaramc.homelinux.net> <20090428094138.GB9415@piper.oerlikon.madduck.net> <20090428204018.GA17722@pengutronix.de> <slrngvf976.65c.sitaramc@sitaramc.homelinux.net> <20090429082410.GB18521@pengutronix.de> <slrngvgh7m.isk.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 20:49:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzEq8-000899-Ie
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 20:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753969AbZD2Ssx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2009 14:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752248AbZD2Ssx
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 14:48:53 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47961 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693AbZD2Ssw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 14:48:52 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LzEpw-00076r-9N; Wed, 29 Apr 2009 20:48:52 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1LzEpv-0004VE-5k; Wed, 29 Apr 2009 20:48:51 +0200
Content-Disposition: inline
In-Reply-To: <slrngvgh7m.isk.sitaramc@sitaramc.homelinux.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117910>

Hello,

> >> This is a little beyond my comprehension :(  However, this
> >> is also why I am limiting myself to
> >>=20
> >>   - a single level of dependencies in tg, (master -->
> >>     multiple t/something --> t/all), and
> >>=20
> >>   - no changes of its own in t/all
> >>=20
> >> When any of the t/something graduates to master, t/all will
> >> be blown away (safe, since it has no changes of its own) and
>=20
> > What makes you think it will "be blown away"?  Or alternatively, wh=
at do
>=20
> My mistake.  I meant that I will blow it away myself, and
> create a new one with the same name except it's list of deps
> will exclude the one that graduated.
>=20
> > you mean saying that?  I often use the same approach and I never ha=
d the
> > feeling anything is blown away.  If upstream uses your t/something =
patch
> > it just merges into t/something making it empty without changing th=
e
>=20
> How?  When I update master from upstream and then tg update
> on t/all?
yes.  I think it's even save to just remove empty dependencies (and add
the dependencies of the patch branch to be deleted) from .topdeps.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
