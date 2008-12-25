From: martin f krafft <madduck@debian.org>
Subject: Re: a few Topgit patches
Date: Thu, 25 Dec 2008 15:58:34 +0100
Organization: The Debian project
Message-ID: <20081225145834.GA16852@lapse.rw.madduck.net>
References: <20081223143035.GA24087@cassiopeia.tralala>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Dec 25 16:01:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFrho-0002Qg-P2
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 16:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbYLYO6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Dec 2008 09:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbYLYO6v
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Dec 2008 09:58:51 -0500
Received: from clegg.madduck.net ([193.242.105.96]:44285 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbYLYO6u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Dec 2008 09:58:50 -0500
Received: from lapse.rw.madduck.net (lapse-wlan.gauting.madduck.net [IPv6:2001:a60:f069:0:214:a4ff:fe04:eadc])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 31D981D40A9;
	Thu, 25 Dec 2008 15:58:36 +0100 (CET)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id 87F6D80F2; Thu, 25 Dec 2008 15:58:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081223143035.GA24087@cassiopeia.tralala>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.27-1-686 i686
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/8798/Wed Dec 24 17:46:31 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103903>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> [2008.12.23=
=2E1530 +0100]:
> I hacked using topgit for some time now, and found the following changes
> to topgit useful:
>=20
> Uwe Kleine-K=F6nig (3):
>       tg export: implement skipping empty patches for collapse driver
>       tg export: Implement flattening patch paths for quilt mode
>       tg export (quilt): Implement numbering the patches

They all look good. I am a bit concerned about the use of
single-letter options at this stage. tg-export is bound to grow, and
using them all up now might mean breaking compatibility later, when
a more common option needs e.g. -f, which has already been taken.

--=20
 .''`.   martin f. krafft <madduck@d.o>      Related projects:
: :'  :  proud Debian developer               http://debiansystem.info
`. `'`   http://people.debian.org/~madduck    http://vcs-pkg.org
  `-  Debian - when you have better things to do than fixing systems
=20
"oh what a tangled web we weave,
 when first we practice to deceive.
 but my how we improve the score,
 as we practice more and more."
                                                   -- sir walter scott

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklTn5MACgkQIgvIgzMMSnXCSQCdERzS23ySuMrWUfRX7FlC2BoX
KTYAn0ISihEjtZ0tKv8NX4EcVNKkAYjw
=rKeO
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
