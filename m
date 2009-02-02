From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: duplicate sign-off-by error
Date: Mon, 2 Feb 2009 14:04:55 -0600
Message-ID: <200902021405.00562.bss@iguanasuicide.net>
References: <79FCCC4F-9C66-470E-AC32-8F3AE3C81EE9@columbia.edu>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart154201231.bryhAWQEWH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sharib Khan <sak2109@columbia.edu>
X-From: git-owner@vger.kernel.org Mon Feb 02 21:07:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU54A-0002ty-Iq
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 21:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753755AbZBBUFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 15:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753564AbZBBUFP
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 15:05:15 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:53388 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753502AbZBBUFN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 15:05:13 -0500
Received: from h15.154.102.166.static.ip.windstream.net ([166.102.154.15] helo=dellbuntu.localnet)
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LU52e-00061L-2c; Mon, 02 Feb 2009 20:05:12 +0000
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <79FCCC4F-9C66-470E-AC32-8F3AE3C81EE9@columbia.edu>
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108113>

--nextPart154201231.bryhAWQEWH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 02 February 2009 11:22:36 Sharib Khan wrote:
> I m getting a Duplicate Sign-off by error when trying to commit to=20
the
> repository.
> I am using git 1.5.6 on solaris
>
> what is this error related to and how can it be resolved.

It's looking for lines in the commit message like:
Signed-off-by: Joe Hacker <jhacker@uni.edu>

and seeing duplication.  Remove the duplication and try again.

If you can't see the duplication, please try to put together a series=20
operations we can preform to reproduce your error.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20


--nextPart154201231.bryhAWQEWH
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmHUewACgkQdNbfk+86fC11fgCfVku2X9mleNdjj6LIccc1TkVG
ibUAnR1svv1wk688t7ieMXrA9qH07ak/
=1ctb
-----END PGP SIGNATURE-----

--nextPart154201231.bryhAWQEWH--
