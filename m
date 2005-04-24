From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: [ANNOUNCE] git-pasky-0.7
Date: Sun, 24 Apr 2005 12:35:06 +0200
Message-ID: <1114338906.27940.35.camel@nosferatu.lan>
References: <20050423205847.7758bfaa.pj@sgi.com>
	 <Pine.LNX.4.21.0504240018350.30848-100000@iabervon.org>
	 <20050423220236.26f834ee.pj@sgi.com>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WED9SOGGWAHAKJMONj/p"
Content-Transfer-Encoding: 8bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, pasky@ucw.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 12:26:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPeJj-0004Bc-DA
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 12:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262305AbVDXKbP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 06:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbVDXKbP
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 06:31:15 -0400
Received: from ctb-mesg1.saix.net ([196.25.240.73]:58017 "EHLO
	ctb-mesg1.saix.net") by vger.kernel.org with ESMTP id S262305AbVDXKbM
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 06:31:12 -0400
Received: from gateway.lan (wblv-146-254-56.telkomadsl.co.za [165.146.254.56])
	by ctb-mesg1.saix.net (Postfix) with ESMTP id CB7554F9C;
	Sun, 24 Apr 2005 12:31:05 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id F33163A2430;
	Sun, 24 Apr 2005 12:37:30 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 00127-15; Sun, 24 Apr 2005 12:37:27 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id 2A4C93A241A;
	Sun, 24 Apr 2005 12:37:27 +0200 (SAST)
To: Paul Jackson <pj@sgi.com>
In-Reply-To: <20050423220236.26f834ee.pj@sgi.com>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-WED9SOGGWAHAKJMONj/p
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-04-23 at 22:02 -0700, Paul Jackson wrote:
> The winning solution via private email:
>=20
> 	mkdir linux
> 	cd linux
> 	git init rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x-2.6.git
>=20
> Another email was missing the 'scm' term.
>=20
> I still don't see how to get to the official 2.6.12-rc3:
>=20
> 	a2755a80f40e5794ddc20e00f781af9d6320fafb
>=20

If you want a new directory that only goes to official 2.6.12-rc3, try:

    git fork linux-2.6.12-rc3 ../linux-2.6.12-rc3 a2755a80f40e5794ddc20e00f=
781af9d6320fafb

This will also share the object database, so only space for the checked
out files will be needed.


Cheers,

--=20
Martin Schlemmer


--=-WED9SOGGWAHAKJMONj/p
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCa3ZaqburzKaJYLYRAmnjAJ0dglP2gwWWpQP4uNSRwxXG6a9dDQCfdxIL
iBoLTw87w5x9UF1oHLvO9Ao=
=5SDc
-----END PGP SIGNATURE-----

--=-WED9SOGGWAHAKJMONj/p--

