From: martin f krafft <madduck@madduck.net>
Subject: Re: Reacting to new commits in a poll-mirror
Date: Wed, 3 Feb 2010 23:48:57 +1300
Message-ID: <20100203104857.GC20450@lapse.rw.madduck.net>
References: <20100202220234.GA17107@lapse.rw.madduck.net>
 <20100203011050.GA23249@lapse.rw.madduck.net>
 <7vzl3rt88c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
To: git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 11:49:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NccnO-0005ZM-Qq
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 11:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753070Ab0BCKtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 05:49:13 -0500
Received: from clegg.madduck.net ([193.242.105.96]:57951 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791Ab0BCKtM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 05:49:12 -0500
Received: from lapse.rw.madduck.net (lapse.nz.madduck.net [IPv6:2001:4428:234::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id ECC351D4099;
	Wed,  3 Feb 2010 11:49:01 +0100 (CET)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id 7EF9AFF; Wed,  3 Feb 2010 23:48:57 +1300 (NZDT)
Content-Disposition: inline
In-Reply-To: <7vzl3rt88c.fsf@alter.siamese.dyndns.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.32-trunk-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.95.3 at clegg
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138828>


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Junio C Hamano <gitster@pobox.com> [2010.02.03.1432 +1300]:
> So I don't see what you find wrong about writing your script like:
>=20
>     #!/bin/sh
>     before_fetch=3D$(git for-each-ref --format=3D'%(objectname)') &&
>     git fetch || exit
>=20
>     git rev-list --all --not $before_fetch |
>     while read rev
>     do
> 	do your patchwork magic...
>     done

This sounds pretty much what I had in mind, and you have convinced
me that this is the right/better approach. Thanks for keeping those
feet on the ground!

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
half a bee, philosophically, must ipso facto half not be.
but half the bee has got to be, vis-a-vis its entity. you see?
but can a bee be said to be or not to be an entire bee,
when half the bee is not a bee, due to some ancient injury?
                                                       -- monty python
=20
spamtraps: madduck.bogus@madduck.net

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEAREDAAYFAktpVJkACgkQIgvIgzMMSnXvdACdG46XN1Fq53i03thQGQ+dXFGs
ia8AoKzPNvFx5lR/yi/sDwfwquLI0eT2
=aWJS
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
