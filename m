From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: cvsimport: rewritten in Perl
Date: Wed, 6 Jul 2005 09:32:37 +0200
Message-ID: <20050706073237.GE11514@kiste.smurf.noris.de>
References: <20050705230226.0F9F4353A69@atlas.denx.de> <Pine.LNX.4.58.0507051936350.3570@g5.osdl.org> <20050706063712.GV18608MdfPADPa@garage.linux.student.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
X-From: git-owner@vger.kernel.org Wed Jul 06 09:34:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dq4Pk-0002Nk-U5
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 09:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbVGFHdd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 03:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVGFHdd
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 03:33:33 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:50092 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S262133AbVGFHdP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 03:33:15 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1Dq4Oc-0005Al-OZ; Wed, 06 Jul 2005 09:32:52 +0200
Received: (nullmailer pid 13805 invoked by uid 501);
	Wed, 06 Jul 2005 07:32:37 -0000
To: Linus Torvalds <torvalds@osdl.org>, Wolfgang Denk <wd@denx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050706063712.GV18608MdfPADPa@garage.linux.student.kuleuven.ac.be>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Sven Verdoolaege:
> > to get an idea of what the files may be. Looks like the new perl versio=
n=20
> > is leaking file descriptors..
> >=20
> > Matthias?
>=20
> That was my mistake, actually.
> Thanks for spotting this.
>=20
Ouch. For me, the main danger of lots of Python programming is that
I tend not to see this kind of problem any more, because in Python it
Simply Doesn't Happen.=20

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Conscience is the inner voice that warns us somebody is looking
					-- H. L. Mencken

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCy4kV8+hUANcKr/kRAllRAJ9YI/wvqm6Zxa1Zyt9ZGFzlQRRQhQCdFLl1
LT47WzYDOz9vVz1nYVDyyqw=
=NFAr
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--
