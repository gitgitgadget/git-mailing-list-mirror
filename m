From: martin f krafft <madduck@debian.org>
Subject: Re: [PATCH] tg export: implement skipping empty patches for quilt
	mode
Date: Wed, 26 Nov 2008 21:39:59 +0100
Organization: The Debian project
Message-ID: <20081126203959.GB31563@piper.oerlikon.madduck.net>
References: <1227701580-9762-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Cc: git@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Nov 26 21:41:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5RCu-0000wq-Oe
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 21:41:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983AbYKZUkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 15:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753288AbYKZUkR
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 15:40:17 -0500
Received: from clegg.madduck.net ([193.242.105.96]:41947 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755354AbYKZUkP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 15:40:15 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id C520E1D40A9;
	Wed, 26 Nov 2008 21:40:00 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id A0C539F34F;
	Wed, 26 Nov 2008 21:39:59 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 5F55DB1C3D; Wed, 26 Nov 2008 21:39:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1227701580-9762-1-git-send-email-u.kleine-koenig@pengutronix.de>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.26-1-amd64 x86_64
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.1/8684/Wed Nov 26 16:37:33 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101765>


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> [2008.11.26=
=2E1313 +0100]:
> addionally fix the README item for skipping the export of empty patches
> not to need an option (-n) as this should be the default.
[...]
> -	TODO: -n option to prevent exporting of empty patches
> +	TODO: prevent exporting of empty patches

Is it still a TODO? Looks like your patch fixes it, no?

--=20
 .''`.   martin f. krafft <madduck@d.o>      Related projects:
: :'  :  proud Debian developer               http://debiansystem.info
`. `'`   http://people.debian.org/~madduck    http://vcs-pkg.org
  `-  Debian - when you have better things to do than fixing systems
=20
"the difference between genius and stupidity
 is that genius has it's limits."
                                                    -- albert einstein

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkttB8ACgkQIgvIgzMMSnWXDwCdH5Nk2fCuyVLHSqZ7pnVKfzwJ
7zsAoNhTx4JmFPLL+KotNEx4XZPBIbdF
=OZdM
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
