From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: Pulling linux-2.6.git with gitinit.sh and gitpull.sh fails
Date: Fri, 22 Apr 2005 15:52:20 +0200
Message-ID: <1114177940.29271.9.camel@nosferatu.lan>
References: <200504221442.29488.rhys@rhyshardwick.co.uk>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LbCrkCybr3BSLZGEIf9U"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 15:45:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOyRr-0008Ql-Bc
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 15:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVDVNse (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 09:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVDVNse
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 09:48:34 -0400
Received: from ctb-mesg2.saix.net ([196.25.240.74]:34524 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S261733AbVDVNsa
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 09:48:30 -0400
Received: from gateway.lan (wblv-146-254-56.telkomadsl.co.za [165.146.254.56])
	by ctb-mesg2.saix.net (Postfix) with ESMTP id 5F81ADC5C;
	Fri, 22 Apr 2005 15:48:24 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id 382813A2430;
	Fri, 22 Apr 2005 15:54:44 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 17486-19; Fri, 22 Apr 2005 15:54:38 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id C83E23A241A;
	Fri, 22 Apr 2005 15:54:38 +0200 (SAST)
To: rhys@rhyshardwick.co.uk
In-Reply-To: <200504221442.29488.rhys@rhyshardwick.co.uk>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-LbCrkCybr3BSLZGEIf9U
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-22 at 14:42 +0100, Rhys Hardwick wrote:
> Hey there,
>=20
> I am trying to pull the latest repository of the linux-2.6 git from Linus=
'=20
> rsync mirror.
>=20
> Here is the shell:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> rhys@metatron:~/repo/linux-2.6.repo$ gitinit.sh=20
> rsync://www.kernel.org/pub/linux/kernel/people/torvalds/linux-2.6.git
> defaulting to local storage area
> gitpull.sh: unknown remote
> gitinit.sh: pull failed
> rhys@metatron:~/repo/linux-2.6.repo$ rm -r .git
> rhys@metatron:~/repo/linux-2.6.repo$ gitinit.sh=20
> www.kernel.org/pub/linux/kernel/people/torvalds/linux-2.6.git
> defaulting to local storage area
> gitpull.sh: unknown remote
> gitinit.sh: pull failed
> rhys@metatron:~/repo/linux-2.6.repo$  =20
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Any idea why this is not working?
>=20

Try:

 $ git init rsync://www.kernel.org/pub/linux/kernel/people/torvalds/linux-2=
.6.git



--=20
Martin Schlemmer


--=-LbCrkCybr3BSLZGEIf9U
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCaQGUqburzKaJYLYRArbZAJ9ydP0f8sjyLOdF7okZOCgbHpGnGACdFS8A
Omcgx+W6zH71rVsDzWhqfQo=
=OCDP
-----END PGP SIGNATURE-----

--=-LbCrkCybr3BSLZGEIf9U--

