From: martin f krafft <madduck@madduck.net>
Subject: Re: git and mtime
Date: Thu, 20 Nov 2008 14:59:56 +0100
Message-ID: <20081120135956.GA29789@piper.oerlikon.madduck.net>
References: <20081119113752.GA13611@ravenclaw.codelibre.net> <20081120132107.GA27571@piper.oerlikon.madduck.net> <20081120133546.GA6023@codelibre.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
To: Roger Leigh <rleigh@codelibre.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 20 15:01:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3A5w-00022m-9B
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 15:01:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196AbYKTOAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 09:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754715AbYKTOAH
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 09:00:07 -0500
Received: from clegg.madduck.net ([193.242.105.96]:44545 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298AbYKTOAG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 09:00:06 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 5ED091D40A9;
	Thu, 20 Nov 2008 14:59:58 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 5188E9F34F;
	Thu, 20 Nov 2008 14:59:57 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 0ADB545F4; Thu, 20 Nov 2008 14:59:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081120133546.GA6023@codelibre.net>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.26-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.1/8653/Thu Nov 20 10:04:07 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101436>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Roger Leigh <rleigh@codelibre.net> [2008.11.20.1435 +0100]:
> By end user, I mean person downloading and building the sources.
>=20
> They are optional build depdendencies.  They are provided pre-built,
> and won't be rebuilt unless they get outdated.  In the release
> tarball, the timestamps are correct, ensuring this never happens.
> When checking out with git, the timestamps are incorrect, and it
> attempts to rebuild something that's *already built*.

I know you will hate me, but I think the solution here is to fix the
toolchain and make those build dependencies required.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"first get your facts; then you can distort them at your leisure."
                                                       -- mark twain
=20
spamtraps: madduck.bogus@madduck.net

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkklbVcACgkQIgvIgzMMSnWlCQCfd2tea/tfEvGEHekxOsIzjLpY
Aq8AoOd/ponJc9njpcnOcAv/um3xoK09
=bGL+
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
