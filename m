From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH take 3 0/4] color-words improvements
Date: Wed, 14 Jan 2009 16:24:32 -0600
Message-ID: <200901141624.38315.bss@iguanasuicide.net>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de> <200901142059.09005.trast@student.ethz.ch> <alpine.DEB.1.00.0901142258250.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3746895.L4AUh1kgiT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	Teemu Likonen <tlikonen@iki.fi>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Santi =?utf-8?q?B=C3=A9jar?= <santi@agolina.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 14 23:25:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNEB2-0008E1-TM
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 23:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747AbZANWYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 17:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752243AbZANWYF
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 17:24:05 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:44472 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbZANWYE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 17:24:04 -0500
Received: from [63.167.77.128]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LNE9S-0002EQ-HN; Wed, 14 Jan 2009 22:23:54 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <alpine.DEB.1.00.0901142258250.3586@pacific.mpi-cbg.de>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105713>

--nextPart3746895.L4AUh1kgiT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 2009 January 14 16:06:48 Johannes Schindelin wrote:
>On Wed, 14 Jan 2009, Thomas Rast wrote:
>> Bug aside, examples like this one make me wonder if we should force a
>> "last resort" match for `[^[:space:]]`.  For example,
>>
>>       -aaa [aaa]
>>       +aaa (aaa) aaa
>>
>> would still give you
>>
>>       aaa (aaa)<GREEN> aaa<RESET>
>>
>> which may be unexpected.
>
>But why should it be unexpected?  If people say that every length of "a"
>makes a word, and consequently everything else is clutter, then that's
>that, no?

I think some people are going to have problems with the strict dichotomy=20
between "part of a word" and "ignorable whitespace" that is being set up. =
=20
It makes sense technically, but it could confuse.

Imagine with --diff-words=3D[A-Z][A-Za-z]* and the following change:
=2DTo be Or Not To be.
+To ignore Or Not To treat whitespace differently.

I think there is value in being able to ignore anything that's not a word,=
=20
so the documentation that mentions adding '|[^[:space:]]' to your regex=20
seems sufficient to me.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart3746895.L4AUh1kgiT
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkluZiYACgkQdNbfk+86fC3PAACfbaUnvIyq1ov0b3joLgHyNgek
1FoAn05tsm1t7HDzCpO06tJaxvJ/utcE
=C/EE
-----END PGP SIGNATURE-----

--nextPart3746895.L4AUh1kgiT--
