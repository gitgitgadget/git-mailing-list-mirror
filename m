From: "Fernando J. Pereda" <ferdy@gentoo.org>
Subject: Re: What does "properly support iconv" in git Makefile (NO_ICONV) mean?
Date: Tue, 5 Sep 2006 01:16:09 +0200
Message-ID: <20060904231609.GA6855@ferdyx.org>
References: <200609050108.57695.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 05 01:18:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKNhi-00039V-FD
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 01:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbWIDXQm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 19:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbWIDXQe
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 19:16:34 -0400
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:4745
	"EHLO smtp.ferdyx.org") by vger.kernel.org with ESMTP
	id S965028AbWIDXQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 19:16:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id 801E58D38F;
	Tue,  5 Sep 2006 01:15:39 +0200 (CEST)
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 08917-06; Tue, 5 Sep 2006 01:15:36 +0200 (CEST)
Received: from posidon.ferdyx.org (posidon.ferdyx.org [192.168.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ferdyx.org (Postfix) with ESMTP id A037E8D317;
	Tue,  5 Sep 2006 01:15:35 +0200 (CEST)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	ferdy@gentoo.org; Tue,  5 Sep 2006 01:16:10 +0200 (CEST)
To: Jakub Narebski <jnareb@gmail.com>
Mail-Followup-To: "Fernando J. Pereda" <ferdy@gentoo.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200609050108.57695.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at ferdyx.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26449>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 05, 2006 at 01:08:57AM +0200, Jakub Narebski wrote:
> To add autoconf support for checking if NO_ICONV has to be defined
> (Define NO_ICONV if your libc does not properly support iconv.)
> one needs to know what does "properly support iconv" mean.
>=20
> The commit message of a commit which introduced this compilation=20
> variable (commit b6e56eca8a4eb74a86e9f2d99aa480c665458aa7) tells:
>=20
>     Systems using some uClibc versions do not properly support
>     iconv stuff.
>=20
> At what exactly iconv fail? What should the test to put in configure.ac=
=20
> check?

As far as I know, iconv stuff is not supported on uClibc. Thats the
reason I sent the patch. Gentoo bug #115826 [1].

You should probably set it if you are building for uClibc. Not sure how
you'd test that in configure.ac though.

- ferdy

[1] https://bugs.gentoo.org/show_bug.cgi?id=3D115826

--=20
Fernando J. Pereda Garcimart=EDn
Gentoo Developer (Alpha,net-mail,mutt,git)
20BB BDC3 761A 4781 E6ED  ED0B 0A48 5B0C 60BD 28D4

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFE/LO5CkhbDGC9KNQRAr9NAJ0SQcvbYoZw9NB23Put1GtASAqhNwCgkv4T
Q5sMiRsmYfCBbrMDX1l/O1o=
=d/Gs
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
