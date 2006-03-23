From: Keith Packard <keithp@keithp.com>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Thu, 23 Mar 2006 07:45:51 -0800
Message-ID: <1143128751.6850.35.camel@neko.keithp.com>
References: <20060322133337.GU20746@lug-owl.de>
	 <Pine.LNX.4.64.0603221517210.26286@g5.osdl.org>
	 <Pine.LNX.4.64.0603221607580.26286@g5.osdl.org>
	 <44223B90.3040500@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-M/6r8Cr6FDLTLbpzbiya"
Cc: keithp@keithp.com, Linus Torvalds <torvalds@osdl.org>,
	Jan-Benedict Glaw <jbglaw@lug-owl.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 16:46:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMS18-0005bs-FS
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 16:46:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWCWPq1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 10:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWCWPq1
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 10:46:27 -0500
Received: from home.keithp.com ([63.227.221.253]:38672 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S932118AbWCWPq0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Mar 2006 10:46:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 20B78130020;
	Thu, 23 Mar 2006 07:46:14 -0800 (PST)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 05632-03; Thu, 23 Mar 2006 07:46:13 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1033)
	id 6866913001F; Thu, 23 Mar 2006 07:46:13 -0800 (PST)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 4637914002;
	Thu, 23 Mar 2006 07:46:13 -0800 (PST)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id 837AE6AC1BF; Thu, 23 Mar 2006 07:45:52 -0800 (PST)
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <44223B90.3040500@zytor.com>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17859>


--=-M/6r8Cr6FDLTLbpzbiya
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-03-22 at 22:09 -0800, H. Peter Anvin wrote:
> Linus Torvalds wrote:
> >=20
> > It _seems_ that the reason for that is that cvsps considers a revision=20
> > number of 1.1.1.1 to have a "dot depth" of 0, for some really strange=20
> > reason (it's a total special case).
> >=20
>=20
> Probably because in 99% of all cases, revision 1.1.1.1 is the result of=20
> a "cvs import".

All odd branches are imports. Internal branches are even. So, 1.1.3.1
would be the first import along the second vendor branch from the trunk.

Note that vendor branches are always made from the first revision along
a branch, independent of when they occur, so you'll get 1.1.3.1 even if
the head revision along the trunk is 1.246.

--=20
keith.packard@intel.com

--=-M/6r8Cr6FDLTLbpzbiya
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEIsKvQp8BWwlsTdMRAqsiAJ908Cv3k8CDRUSGmdRVfOmsGnRC0QCeL3/R
c5uK1iD7ptB9ft87bUbXO3k=
=4Py0
-----END PGP SIGNATURE-----

--=-M/6r8Cr6FDLTLbpzbiya--
