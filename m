From: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] diff and apply: fix singular/plural grammar nit.
Date: Sun, 27 Nov 2011 15:50:33 +0100
Message-ID: <20111127145033.GA1738@centaur.lab.cmartin.tk>
References: <4ED23EB5.1030208@ripton.net>
 <m37h2lmxk9.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Cc: David Ripton <dripton@ripton.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 27 15:50:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUg3x-0003UP-T6
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 15:50:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590Ab1K0Oud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Nov 2011 09:50:33 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:35439 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753095Ab1K0Oud (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2011 09:50:33 -0500
Received: from centaur.lab.cmartin.tk (brln-4db9ed61.pool.mediaWays.net [77.185.237.97])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id D0153461A5;
	Sun, 27 Nov 2011 15:49:51 +0100 (CET)
Received: (nullmailer pid 21606 invoked by uid 1000);
	Sun, 27 Nov 2011 14:50:34 -0000
Mail-Followup-To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Jakub Narebski <jnareb@gmail.com>,
	David Ripton <dripton@ripton.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <m37h2lmxk9.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185987>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 27, 2011 at 06:47:21AM -0800, Jakub Narebski wrote:
> David Ripton <dripton@ripton.net> writes:
>=20
> > Remove the trailing 's' from "files", "insertions", and "deletions"
> > when there is only one of the item.
> >=20
> > Signed-off-by: David Ripton <dripton@ripton.net>
> > ---
> [...]
> > -       printf(" %d files changed, %d insertions(+), %d
> > deletions(-)\n", files, adds, dels);
>=20
> Whitespace damaged.  Please turn off word wrapping (limiting line
> width) when sending patches.
>=20
> > +       printf(" %d file%s changed, %d insertion%s(+), %d deletion%s(-)=
\n",
> > +              files, (files =3D=3D 1 ? "" : "s"),
> > +              adds, (adds =3D=3D 1 ? "" : "s"),
> > +              dels, (dels =3D=3D 1 ? "" : "s"));
> >   }
>=20
> First, I think this is an API / plumbing and should not be changed.
> But I might be mistaken about that.

I think somebody already tried to do this not too long ago (don't know
if there as a patch) but the diffstat tool always uses the plural, and
it might break scripts.

   cmn



--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJO0k45AAoJEHKRP1jG7ZzTl3EH/3kz3ywRDL/FFV5bjJsDm42r
gIxEy14kp2ppg3k/Gh6Hjj4Qm8cVIlS6MEPaicHurP8pPy4nKkg9TSGEnUSDyBFN
H/t33ogHJ5/rtUZRaK2H3lsrcb+QT3XxG5hoAN82zcMQ8sJP7rEe5946J14k7Pyc
GPBCOQHO+TmX8OCBzksDSDWxRpbte1+cPgNXdc+DP99kwg8n+fi7BYoxR1Q4hNR7
PEJ24UMDI1BcyJ1v4gzOQZL7FM/uJmap3NMCbiELEIdkUWkk4OTv7GwDADKfUhUe
lOp9zixjaCWREdXgamNMcgDFA5Y/aw5ozJmHXMTPL4jxhIK6sbfR5L9RyTI7bDI=
=LKjh
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
