From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: a few Topgit patches
Date: Sun, 4 Jan 2009 14:05:32 +0100
Message-ID: <20090104130532.GA1055@pengutronix.de>
References: <20081223143035.GA24087@cassiopeia.tralala> <20081225145834.GA16852@lapse.rw.madduck.net> <20081226170334.GA18722@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>
To: martin f krafft <madduck@debian.org>
X-From: git-owner@vger.kernel.org Sun Jan 04 14:07:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJSh8-0007Jo-4M
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 14:07:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbZADNFh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Jan 2009 08:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbZADNFg
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 08:05:36 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45559 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbZADNFf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 08:05:35 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LJSfd-0008DP-N1; Sun, 04 Jan 2009 14:05:33 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1LJSfc-00069X-D3; Sun, 04 Jan 2009 14:05:32 +0100
Content-Disposition: inline
In-Reply-To: <20081226170334.GA18722@pengutronix.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104515>

Hi martin,

On Fri, Dec 26, 2008 at 06:03:34PM +0100, Uwe Kleine-K=F6nig wrote:
> On Thu, Dec 25, 2008 at 03:58:34PM +0100, martin f krafft wrote:
> > also sprach Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> [20=
08.12.23.1530 +0100]:
> > > I hacked using topgit for some time now, and found the following =
changes
> > > to topgit useful:
> > >=20
> > > Uwe Kleine-K=F6nig (3):
> > >       tg export: implement skipping empty patches for collapse dr=
iver
> > >       tg export: Implement flattening patch paths for quilt mode
> > >       tg export (quilt): Implement numbering the patches
> >=20
> > They all look good. I am a bit concerned about the use of
> > single-letter options at this stage. tg-export is bound to grow, an=
d
> > using them all up now might mean breaking compatibility later, when
> > a more common option needs e.g. -f, which has already been taken.
> I updated my tree to make '-f' '--flatten'.  IMHO -n is nice for gett=
ing
> numbered patches, but if you prefer, I will make this --numbered.
>=20
> Oh, and I just noticed that documentation is missing.  I will fix thi=
s
> when I sent this mail.
This is done.  Now I even changed '-n' to '--numbered' and changed the
commit log accordingly.  Are there still concerns about my patches?
Should I resend the current version?

The patches are still available in my topgit repo at

	git://git.pengutronix.de/git/ukl/topgit.git master

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
