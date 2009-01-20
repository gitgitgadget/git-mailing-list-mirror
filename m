From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH] diff: Support diff.color-words config option
Date: Tue, 20 Jan 2009 11:58:56 -0600
Message-ID: <200901201159.00803.bss@iguanasuicide.net>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de> <7v1vuympie.fsf@gitster.siamese.dyndns.org> <200901201842.24000.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1587754.cb67jCWSlT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Santi =?utf-8?q?B=C3=A9jar?= <santi@agolina.net>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Teemu Likonen <tlikonen@iki.fi>
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Tue Jan 20 18:59:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPKt5-0001S3-Ty
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 18:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049AbZATR6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 12:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752767AbZATR6U
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 12:58:20 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:38216 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbZATR6T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 12:58:19 -0500
Received: from [63.167.79.115]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LPKrb-0001ym-IQ; Tue, 20 Jan 2009 17:58:11 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <200901201842.24000.markus.heidelberg@web.de>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106504>

--nextPart1587754.cb67jCWSlT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 2009 January 20 11:42:23 Markus Heidelberg wrote:
>Junio C Hamano, 20.01.2009:
>> "Boyd Stephen Smith Jr." <bss@iguanasuicide.net> writes:
>> > When diff is invoked with --color-words (w/o =3Dregex), use the regular
>> > expression the user has configured as diff.color-words.
>> >
>> > diff drivers configured via attributes take precedence over the
>> > diff.color-words setting.  If the user wants to change them, they have
>> > their own configuration variables.
>>
>> This needs an entry in Documentation/config.txt
>>
>> None of the existing configuration variables defined use hyphens in
>> multi-word variable names.
>
>Except for diff.suppress-blank-empty
>Should it be converted or is it intention to reflect GNU diff's option?

I think best would be to have a project policy, use that for the wordRegex=
=20
option and other options moving forward, then fix the others at some point =
in=20
the future (1.7?) while having some period of time where both old and "per=
=20
policy" names work.  But, then I'm a big fan of standardization.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart1587754.cb67jCWSlT
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEUEABECAAYFAkl2EOQACgkQdNbfk+86fC0v8ACdFWRVgrsxvsvny00vCZmuEhwA
5NoAmKkl8V9thM41Un56mAE05hDYjFc=
=0sQU
-----END PGP SIGNATURE-----

--nextPart1587754.cb67jCWSlT--
