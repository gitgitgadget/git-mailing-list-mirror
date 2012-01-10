From: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
Subject: Re: [BUG] git archive broken in 1.7.8.1
Date: Tue, 10 Jan 2012 22:33:44 +0100
Message-ID: <20120110213344.GI2714@centaur.lab.cmartin.tk>
References: <5142795.2dTmMhVRTP@xps>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="924gEkU1VlJlwnwX"
Cc: git@vger.kernel.org
To: Albert Astals Cid <aacid@kde.org>
X-From: git-owner@vger.kernel.org Tue Jan 10 22:33:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkjKB-0005qV-Ul
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 22:33:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756581Ab2AJVdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 16:33:39 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:34218 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754621Ab2AJVdi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 16:33:38 -0500
Received: from centaur.lab.cmartin.tk (brln-4db9e80e.pool.mediaWays.net [77.185.232.14])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id AF525461C3;
	Tue, 10 Jan 2012 22:33:24 +0100 (CET)
Received: (nullmailer pid 25835 invoked by uid 1000);
	Tue, 10 Jan 2012 21:33:44 -0000
Mail-Followup-To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Albert Astals Cid <aacid@kde.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <5142795.2dTmMhVRTP@xps>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188294>


--924gEkU1VlJlwnwX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 10, 2012 at 10:18:41PM +0100, Albert Astals Cid wrote:
> CC me on answers since i'm not subscribed to the list
>=20
> Hi, one of our [KDE] anongit servers was updated to 1.7.8.1 and not the s=
yntax
>=20
> git archive --remote=3Dgit://anongit.kde.org/repo.git HEAD:path

This syntax is no longer allowed due to some security tightening. Use
the alternate syntax

    git archive --remote=3Dgit://anongit.kde.org/repo.git HEAD -- path

>=20
> does not seem to return a valid tar archive anymore when it did work=20
> previously. In fact the man page of my version has that syntax in one of =
the=20
> examples.

That sounds like a documentation bug.

   cmn

--924gEkU1VlJlwnwX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJPDK64AAoJEHKRP1jG7ZzTrK0H/3R6Ij1MYRBP04iWPNbUo4Qc
WrVpaLtJc6iuWhZ787Fl1aUKn/cTn5wlILFXVFljMdT/S0qkmInCa2xP39ya/PE9
A3c/Qd59caRDn4fxNn+Bb5kH3YFF58M+3OQblaQbr7WqUgTj6iIy9LxviRCdTdLY
E5Kre0wIn7w64jca82ofbsqWx0eCoS3v28b2KGfa/0SK42YkwRXUOWt5B0aDTUze
uDqOxr7mP6ShlNJQg8iO3i0kIkbp/j2qxm35nrxqbkDYG9QrnTUhxEFg7Q4+6FqN
FjvzTMltGdCWZ0g3Sc0oBIaa/qNeO3J1KtE1kLiE6AC9EE19RLZifPogmSsTekQ=
=bWhU
-----END PGP SIGNATURE-----

--924gEkU1VlJlwnwX--
