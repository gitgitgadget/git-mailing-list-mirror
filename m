From: martin f krafft <madduck@debian.org>
Subject: Re: [PATCH] tg export: implement skipping empty patches for quilt
	mode
Date: Wed, 26 Nov 2008 10:25:42 +0100
Organization: The Debian project
Message-ID: <20081126092542.GE25162@piper.oerlikon.madduck.net>
References: <1227563810-5426-1-git-send-email-u.kleine-koenig@pengutronix.de> <20081125084531.GA13122@lapse.rw.madduck.net> <20081125205440.GA28679@strlen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AjmyJqqohANyBN/e"
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@strlen.de>,
	git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Nov 26 10:27:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5Gfy-00039N-RX
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 10:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbYKZJZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 04:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbYKZJZ6
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 04:25:58 -0500
Received: from clegg.madduck.net ([193.242.105.96]:34158 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbYKZJZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 04:25:57 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id C59301D40A9;
	Wed, 26 Nov 2008 10:25:43 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id C96EF9F34F;
	Wed, 26 Nov 2008 10:25:42 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 7A3EDB1C3D; Wed, 26 Nov 2008 10:25:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081125205440.GA28679@strlen.de>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.26-1-amd64 x86_64
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.1/8683/Wed Nov 26 07:58:25 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101714>


--AjmyJqqohANyBN/e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Uwe Kleine-K=F6nig <ukleinek@strlen.de> [2008.11.25.2154 +0100]:
> 	TODO: -n option to prevent exporting of empty patches
>=20
> I'm not sure if this was meant for collapse or quilt or both.  I assumed
> the last and implemented -n as suggested.

Hm, except...

+! "$skipempty" || [ "$driver" =3D "quilt" ] ||
+       die "-n is only implemented for the quilt driver"
+

so you assumed "quilt", not both.

Anyway, Petr, I'd make this default for all drivers, unless you object.

--=20
 .''`.   martin f. krafft <madduck@debian.org>
: :'  :  proud Debian developer, author, administrator, and user
`. `'`   http://people.debian.org/~madduck - http://debiansystem.info
  `-  Debian - when you have better things to do than fixing systems
=20
http://www.vcnet.com/bms/

--AjmyJqqohANyBN/e
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkktFhYACgkQIgvIgzMMSnXeaACgnt4TKbZCl8JCdVmU1Sc/QmWj
qvMAoOQ8UgBivlh3S3L715tkw+OqNfOe
=IOCx
-----END PGP SIGNATURE-----

--AjmyJqqohANyBN/e--
