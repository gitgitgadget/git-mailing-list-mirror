From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: Odd merge behaviour involving reverts
Date: Thu, 18 Dec 2008 19:30:40 -0600
Message-ID: <200812181930.43782.bss@iguanasuicide.net>
References: <1229642734.5770.25.camel@rotwang.fnordora.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2475830.KsReSdAA7z";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alan <alan@clueserver.org>
X-From: git-owner@vger.kernel.org Fri Dec 19 02:32:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDUDs-0002jU-UN
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 02:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbYLSBaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 20:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752227AbYLSBae
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 20:30:34 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:33736 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbYLSBad (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 20:30:33 -0500
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.123])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LDUCF-00063o-EJ; Fri, 19 Dec 2008 01:30:31 +0000
User-Agent: KMail/1.9.9
In-Reply-To: <1229642734.5770.25.camel@rotwang.fnordora.org>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103526>

--nextPart2475830.KsReSdAA7z
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 2008 December 18 17:25:34 Alan wrote:
> Here is my situation...
>
> I have a master branch. =C2=A0We have a branch off of that that some
> developers are doing work on. =C2=A0They claim it is ready. We merge it i=
nto
> the master branch. =C2=A0It breaks something so we revert the merge. =C2=
=A0They
> make changes to the code. =C2=A0they get it to a point where they say it =
is
> ok and we merge again.
>
> What am i doing wrong here?

Don't do tests on the master branch.  Or at least, do as little as possible=
=2E  Also, try not to revert merges.  Depending on your workflow and team s=
ynamics it might be easier to rewrite history than wrangle reverts of a mer=
ge commit.
=2D-=20
Boyd Stephen Smith Jr. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 `-'(. .=
)`-'=20
http://iguanasuicide.net/ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0\_/ =C2=A0 =C2=A0=20

--nextPart2475830.KsReSdAA7z
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklK+UMACgkQdNbfk+86fC1EMQCfQQoUg23TcyZ7s1hpx5UlbpcT
B60AoIc7PeDUnlgKz8w3BdvyXMG36Wvb
=prr6
-----END PGP SIGNATURE-----

--nextPart2475830.KsReSdAA7z--
