From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH Cogito] match pathnames in exclude handling
Date: Thu, 12 May 2005 09:54:16 +0200
Message-ID: <20050512075415.GA27670@kiste.smurf.noris.de>
References: <20050510075227.GA8176@lug-owl.de> <20050510080445.GB8176@lug-owl.de> <7vis1rpi8a.fsf@assigned-by-dhcp.cox.net> <20050510093212.GD8176@lug-owl.de> <20050510093924.GH11221@kiste.smurf.noris.de> <20050510094538.GE8176@lug-owl.de> <20050510095825.GI11221@kiste.smurf.noris.de> <4281281F.6000101@cobite.com> <20050511052546.GC11192@kiste.smurf.noris.de> <4282797A.5020001@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Cc: David Mansfield <david@cobite.com>,
	Jan-Benedict Glaw <jbglaw@lug-owl.de>,
	Junio C Hamano <junkio@cox.net>,
	Brian Gerst <bgerst@didntduck.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 09:49:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW8Qt-0003Th-5m
	for gcvg-git@gmane.org; Thu, 12 May 2005 09:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVELH4G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 03:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVELH4G
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 03:56:06 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:3036 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S261252AbVELHzx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 03:55:53 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1DW8WO-0005cY-DY; Thu, 12 May 2005 09:54:47 +0200
Received: (nullmailer pid 28623 invoked by uid 501);
	Thu, 12 May 2005 07:54:16 -0000
To: "H\. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <4282797A.5020001@zytor.com>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

H. Peter Anvin:
> How does that mean foo*.c would match foo/bar/quux.c?  That's probably a=
=20
> bad thing.
>=20
No, of course not -- that was a thinko on my part when I typed the
examples.  :-/

> I do like the (sadly, rarely used) convention that ** matches / whereas=
=20
> * doesn't.
>=20
fnmatch() doesn't support that. Of course, if there's demand for it,
it should be reasonably easy to have our own extended copy.

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCgwun8+hUANcKr/kRApTEAJ93LN10xiI2+4QxoseIOUQMietn/ACfe1qu
2Tdmr9hH8taZ+O7Xd6rz8k4=
=WpcO
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
