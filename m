From: martin f krafft <madduck@madduck.net>
Subject: Re: What about allowing multiple hooks?
Date: Fri, 21 Nov 2008 14:55:07 +0100
Message-ID: <20081121135507.GA24516@piper.oerlikon.madduck.net>
References: <20081121133828.GB5912@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 21 14:56:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3WUt-0002aW-9X
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 14:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245AbYKUNzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 08:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753135AbYKUNzU
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 08:55:20 -0500
Received: from clegg.madduck.net ([193.242.105.96]:36726 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113AbYKUNzT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 08:55:19 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id C18C11D40A9;
	Fri, 21 Nov 2008 14:55:09 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id E90FF9F355;
	Fri, 21 Nov 2008 14:55:07 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 4998645F5; Fri, 21 Nov 2008 14:55:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081121133828.GB5912@gmx.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101528>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Marc Weber <marco-oweber@gmx.de> [2008.11.21.1438 +0100]:
> So what about allowing (or even enforcing) ths directory layout?
>=20
> .git/hooks/pre-commit/hook1.sh
> .git/hooks/pre-commit/hook2.sh
> .git/hooks/pre-commit/topGitcheck.sh
>=20
> instead of
> .git/hooks/pre-commit # <- the one and only pre-commit hook

If you do this, I strongly suggest .git/hooks/pre-commit.d, and to
use .git/hooks/pre-commit to invoke it, which adds to transparency.
Debian does this all over the place. You need to ignore backup files
and/or only execute *.hook files, to be able to have other files in
there. Or the +x flag, as it is used now.

> The hook direcotry list apporach is better because you've more
> control about order of execution..

It's also way more transparent and natural.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"america may be unique in being a country which has leapt
 from barbarism to decadence without touching civilization."
                                                        -- john o'hara
=20
spamtraps: madduck.bogus@madduck.net

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkmvbsACgkQIgvIgzMMSnW78gCdFmX/qKzfRf/XP2U32wUrdpQy
zD0An0mrjbzy+mwYH0yFBfBSPiemrs0g
=M5I7
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
