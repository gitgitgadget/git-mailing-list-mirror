From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: git/webdav is refusing to authenticate properly.
Date: Tue, 13 Jan 2009 12:20:30 -0600
Message-ID: <200901131220.35782.bss@iguanasuicide.net>
References: <137c54e10901121354l284f11ag675abb003fc83e93@mail.gmail.com> <200901121953.16183.bss@iguanasuicide.net> <alpine.DEB.1.00.0901131204420.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2153119.d2sxGcWDZ7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 13 19:21:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMntC-0008TI-Jd
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 19:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753721AbZAMST5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 13:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753153AbZAMST5
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 13:19:57 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:37001 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbZAMST4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 13:19:56 -0500
Received: from [206.104.163.94]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LMnrn-0000Za-4H; Tue, 13 Jan 2009 18:19:55 +0000
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0901131204420.3586@pacific.mpi-cbg.de>
X-Eric-Conspiracy: There is no conspiracy.
X-UID: 10
X-Length: 2515
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105517>

--nextPart2153119.d2sxGcWDZ7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 13 January 2009, Johannes Schindelin=20
<Johannes.Schindelin@gmx.de> wrote about 'Re: git/webdav is refusing to=20
authenticate properly.':
>Oh, and FWIW: trying to ridicule the way Git does it completely misses
> the fact that you are using such a ridiculously weak authentication
> scheme anyway that you could just as well open the window and shout your
> password out loud.

Using DIGEST auth would help, although it is still quite vulnerable, but I=
=20
couldn't convince git to use that either.

I'm pretty sure even PLAIN auth is acceptable (security-wise) if used over=
=20
SSL/TLS.  It would be really nice for contributors behind oppressive firewa=
lls=20
if they could push via https and not have their passwords exposed to the=20
local BOFH.  (Who else sets up an oppressive firewall?)

SVN supported it.  It would be nice to add it to the list of git features. =
=20
Still, it's just not important enough to me right now to make the time to=20
throw together a PATCH/RFC.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart2153119.d2sxGcWDZ7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkls23MACgkQdNbfk+86fC2cbwCeKf45znEcnPda7U8S7PCXDrtI
6QoAnA81tky6Tsoicl+C19A2OwlRgbdY
=T+6I
-----END PGP SIGNATURE-----

--nextPart2153119.d2sxGcWDZ7--
