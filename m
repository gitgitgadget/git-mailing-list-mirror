From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: GIT character codecs
Date: Mon, 14 Nov 2005 08:42:46 +0100
Message-ID: <20051114074246.GP27727@kiste.smurf.noris.de>
References: <20051114063126.27817.qmail@web26306.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SCOJXUq1iwCn05li"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 08:45:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbZ0G-00061K-Sm
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 08:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbVKNHnl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 02:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbVKNHnl
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 02:43:41 -0500
Received: from run.smurf.noris.de ([192.109.102.41]:49850 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S1750956AbVKNHnl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 02:43:41 -0500
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1EbYzH-00048i-Et; Mon, 14 Nov 2005 08:42:58 +0100
Received: (nullmailer pid 661 invoked by uid 501);
	Mon, 14 Nov 2005 07:42:46 -0000
To: Marco Costalba <mcostalba@yahoo.it>
Content-Disposition: inline
In-Reply-To: <20051114063126.27817.qmail@web26306.mail.ukl.yahoo.com>
User-Agent: Mutt/1.5.9i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11770>


--SCOJXUq1iwCn05li
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Marco Costalba:
> >Or, if you want to be super-flexible, just try to decode as UTF-8.
> >Success? fine -- otherwise use whatever your application's default is
> >set to, or your local encoding (which may of course also be UTF-8), or
> >fall back to 8859-15.
>=20
> How it is possible to test for success?

UTF-8 decoding does NOT always succeed.

In fact, there is no other 8-bit encoding which decodes as valid UTF-8,
given real-world text.

> The codec could see everything decodable, but It's only from the
> context, i.e. the user who reads, that it is possible to realize it's
> the wrong codec. =20
>=20
True in general, but not with UTF-8 (or ASCII, for that matter ;-).

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
You can fool the people about many things, but only a fool would be foolish
enough to fool the people about money.
					-- Italo Bombolini

--SCOJXUq1iwCn05li
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDeD/28+hUANcKr/kRAmpyAKCAaq7QjWN5Gue78RwklDYm05NT3gCgneCD
/E9RYzgfNNkNpszmnAbHjDw=
=lPPw
-----END PGP SIGNATURE-----

--SCOJXUq1iwCn05li--
