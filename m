From: martin f krafft <madduck@madduck.net>
Subject: Re: [TopGit PATCH] put die() messages to stderr
Date: Fri, 21 Nov 2008 14:56:50 +0100
Message-ID: <20081121135650.GB24516@piper.oerlikon.madduck.net>
References: <1227261900-23420-1-git-send-email-bert.wesarg@googlemail.com> <20081121123654.GB20537@piper.oerlikon.madduck.net> <20081121132801.GA5912@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 21 14:58:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3WWV-0003F3-Jy
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 14:58:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559AbYKUN5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 08:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753458AbYKUN47
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 08:56:59 -0500
Received: from clegg.madduck.net ([193.242.105.96]:38633 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358AbYKUN47 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 08:56:59 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id DD3A01D40A9;
	Fri, 21 Nov 2008 14:56:51 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id A44F19F355;
	Fri, 21 Nov 2008 14:56:50 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 3CD5F45F5; Fri, 21 Nov 2008 14:56:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081121132801.GA5912@gmx.de>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.26-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.1/8659/Fri Nov 21 13:49:26 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101529>


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Marc Weber <marco-oweber@gmx.de> [2008.11.21.1428 +0100]:
> > Shouldn't info also output to stderr?
>=20
> die is calling info. So this patch is enough.

Sure, I was just wondering whether info() shouldn't also print to
stderr. Or only die(). I think info() prints status messages, which
are not standard operation and thus don't go to stdout, but go to
stderr. No?

> You should just send this patch to the author. I think he'll apply
> it instantly. I've send a small patch to him yesterday as well.

Yes, but I applied that. :)

(I am Petr's apprentice, learning to help him a bit with TopGit).

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"wovon man nicht sprechen kann, dar=FCber mu=DF man schweigen."
                                                       -- wittgenstein
=20
spamtraps: madduck.bogus@madduck.net

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkmviIACgkQIgvIgzMMSnUhXACfct3v8/NevepFV651AZM/Cb90
k4MAoMOv1Qxgs3pYcg4LOuGoRzxC8dG8
=J0WM
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
