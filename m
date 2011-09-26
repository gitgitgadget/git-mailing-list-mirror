From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Can a git changeset be created with no parent
Date: Mon, 26 Sep 2011 23:41:39 +0200
Message-ID: <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
References: <1316960136073-6829212.post@n2.nabble.com>
	 <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
	 <7vaa9r2jii.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-UA6FLfaR9Yp/lQaltX6h"
Cc: vra5107 <venkatram.akkineni@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 26 23:41:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8Ivx-0002Lt-Tz
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 23:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492Ab1IZVlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 17:41:49 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:47047 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752282Ab1IZVlt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 17:41:49 -0400
Received: from [192.168.1.17] (brln-4db9fe34.pool.mediaWays.net [77.185.254.52])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 92B5D46180;
	Mon, 26 Sep 2011 23:41:26 +0200 (CEST)
In-Reply-To: <7vaa9r2jii.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.0.3- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182170>


--=-UA6FLfaR9Yp/lQaltX6h
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2011-09-26 at 12:25 -0700, Junio C Hamano wrote:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> > On Sun, 2011-09-25 at 07:15 -0700, vra5107 wrote:
> >> Hi
> >>=20
> >>         I am currently in the process of converting a large hg reposit=
ory.
> >> One of the changesets has no parents assigned. So to mirror that is it
> >> possible to create a git changeset that doesnot have a parent ?
> >
> > They're called commits in git, and yes it's possible. They are called
> > orphan commits and it's what you get when you do the first commit in th=
e
>=20
> Just to set the terminology straight, s/orphan/root/;

Ah, quite.

>=20
> > repository.
> >
> > You can do this with 'git checkout --orphan somebranch'. Notice that th=
e
>=20
> The orphan here refers to the fact that the next commit will not be a
> child of the current commit. The resulting one is a "root" commit.

The manpage mentions that an orphan branch is created. I guess that's
where I got my "orphan commit" name.


--=-UA6FLfaR9Yp/lQaltX6h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOgPGTAAoJEHKRP1jG7ZzTMfQH/iB+6D59XSlyL0/qy5EGGFil
MBnV1GwYXxynixjif9XwGz0UTZ9UuKdncO92ZhBM2A4CORK88PpVW80Pn+kd5uG9
ebKnazRdDt2rCLG8KJdMzWeiBmWSM5oO+/plkD9GP6UBmJzqb7bcJKdMHpQO+IMp
KJTNsftg7ReojZYCmY+dXZ7/ELxEbO7pB+KbF4gikCu2bx9oW31NH2asalJ/Iyp5
XXAH4Ddago4plrmKJvNeWzam5aDGhnBMEWRt1wy4dHgoVmSZ3mBkJJF3OKKxolzx
tBA0MwWhVnfFYee/K3PTb4EHJ4lJ1b2glRghLPQWT6K2haqhJ7GSk97nOHv0uss=
=gGQN
-----END PGP SIGNATURE-----

--=-UA6FLfaR9Yp/lQaltX6h--
