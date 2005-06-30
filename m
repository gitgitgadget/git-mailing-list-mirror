From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] cvsimport: perform string comparison on "HEAD"
Date: Thu, 30 Jun 2005 17:21:51 +0200
Message-ID: <20050630152150.GP10850@kiste.smurf.noris.de>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de> <20050630145528.GA18553@pc117b.liacs.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UljtkXebtcviItgt"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 17:16:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do0lS-00069a-Pe
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 17:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbVF3PXG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 11:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbVF3PXG
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 11:23:06 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:40920 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S262750AbVF3PXB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 11:23:01 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1Do0rQ-0006Jc-7b; Thu, 30 Jun 2005 17:22:12 +0200
Received: (nullmailer pid 6533 invoked by uid 501);
	Thu, 30 Jun 2005 15:21:51 -0000
To: Sven Verdoolaege <skimo@liacs.nl>
Content-Disposition: inline
In-Reply-To: <20050630145528.GA18553@pc117b.liacs.nl>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--UljtkXebtcviItgt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Sven Verdoolaege:
> -		$ancestor =3D $opt_o if $ancestor =3D=3D "HEAD";
> +		$ancestor =3D $opt_o if $ancestor eq "HEAD";

Duh. Thanks for spotting that. :-/

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
I am enough of an artist to draw freely upon my imagination.
Imagination is more important than knowledge.
Knowledge is limited. Imagination encircles the world.
		-- Albert Einstein

--UljtkXebtcviItgt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCxA4O8+hUANcKr/kRAh5+AKCdF7+VYCYfJY3EgfEYxKjGkCHIPgCeJFDa
b1IXLhVyJCjshWpJX85Vxt0=
=fOFH
-----END PGP SIGNATURE-----

--UljtkXebtcviItgt--
