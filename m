From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH] Add tests for diff.color-words configuration option.
Date: Tue, 20 Jan 2009 10:34:18 -0600
Message-ID: <200901201034.22478.bss@iguanasuicide.net>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de> <200901192017.54163.bss@iguanasuicide.net> <alpine.DEB.1.00.0901201057080.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2989818.NDM0LTI4rF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 20 17:35:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPJZ5-00033S-Oi
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 17:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756569AbZATQdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 11:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756263AbZATQdf
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 11:33:35 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:52481 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756151AbZATQdf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 11:33:35 -0500
Received: from [63.167.79.115]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LPJXh-0001tZ-Lt; Tue, 20 Jan 2009 16:33:33 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <alpine.DEB.1.00.0901201057080.3586@pacific.mpi-cbg.de>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106488>

--nextPart2989818.NDM0LTI4rF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 2009 January 20 03:58:37 Johannes Schindelin wrote:
>On Mon, 19 Jan 2009, Boyd Stephen Smith Jr. wrote:
>> I'm not sure why the diff is crazy long.
>
>Because you changed things that need no changing, such as "cat > expect"
>-> "cat > expect.blabla",

I suppose I could have gotten away with doing this differently, but I did n=
eed=20
to save off some of those results to different files because I wanted to=20
resuse the results.

>and because you inserted your test instead of=20
>adding it at the end.

I put the tests in that order explicitly to test that .gitattributes overri=
des=20
the configuration option.

I'm going to be reworking both patches anyway, so I should be able to=20
rearrange things less, in this file.

Thanks for the feedback.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart2989818.NDM0LTI4rF
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkl1/Q4ACgkQdNbfk+86fC33YACeNzClB3zd1VybuRi8bPysIPXk
+18An2T5ALTillpeGz1k0e8gc4uQ92u0
=3+7r
-----END PGP SIGNATURE-----

--nextPart2989818.NDM0LTI4rF--
