From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH] Change the spelling of "wordregex".
Date: Wed, 21 Jan 2009 09:33:57 -0600
Message-ID: <200901210934.03196.bss@iguanasuicide.net>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de> <200901202259.54886.bss@iguanasuicide.net> <alpine.DEB.1.00.0901210925430.7929@racer>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2831787.CN4ZU0OUf1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Santi =?utf-8?q?B=C3=A9jar?= <santi@agolina.net>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <junio@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 16:35:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPf76-0005MV-C6
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 16:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755431AbZAUPeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 10:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754752AbZAUPeJ
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 10:34:09 -0500
Received: from eastrmmtao107.cox.net ([68.230.240.59]:35875 "EHLO
	eastrmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921AbZAUPeH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 10:34:07 -0500
Received: from eastrmimpo03.cox.net ([68.1.16.126])
          by eastrmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090121153404.WAZM23750.eastrmmtao107.cox.net@eastrmimpo03.cox.net>;
          Wed, 21 Jan 2009 10:34:04 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo03.cox.net with bizsmtp
	id 6Fa31b00F2i4SyG02Fa4FQ; Wed, 21 Jan 2009 10:34:04 -0500
X-Authority-Analysis: v=1.0 c=1 a=2Fv2EKjhX3QA:10 a=faiBtoTYQDwA:10
 a=Fq1VQ0LPAAAA:8 a=JTvFaT_eLHf6DdUm-aMA:9 a=2rt2o4HXKDMFsPftPd0A:7
 a=h7ev1YLV6Hdm-Rkrc-8XlKoD5hQA:4 a=_RhRFcbxBZMA:10 a=T3brmoaXcPoA:10
 a=LY0hPdMaydYA:10 a=ZEDJ0eMuRbD0KcWhxysA:9 a=zZW2u5neITycYC45QKBahKQ8q4wA:4
 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LPf5f-000OvL-Bi; Wed, 21 Jan 2009 09:34:03 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0901210925430.7929@racer>
X-Eric-Conspiracy: There is no conspiracy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106616>

--nextPart2831787.CN4ZU0OUf1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 21 January 2009, Johannes Schindelin=20
<Johannes.Schindelin@gmx.de> wrote about 'Re: [PATCH] Change the spelling=20
of "wordregex".':
>On Tue, 20 Jan 2009, Boyd Stephen Smith Jr. wrote:
>> diff --git a/userdiff.c b/userdiff.c
>> index 2b55509..d556da9 100644
>> --- a/userdiff.c
>> +++ b/userdiff.c
>> @@ -6,8 +6,8 @@ static struct userdiff_driver *drivers;
>>  static int ndrivers;
>>  static int drivers_alloc;
>>
>> -#define PATTERNS(name, pattern, wordregex)			\
>> -	{ name, NULL, -1, { pattern, REG_EXTENDED }, wordregex }
>> +#define PATTERNS(name, pattern, word_regex)			\
>> +	{ name, NULL, -1, { pattern, REG_EXTENDED }, word_regex }
>>  static struct userdiff_driver builtin_drivers[] =3D {
>>  PATTERNS("html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$",
>>  	 "[^<>=3D \t]+|[^[:space:]]|[\x80-\xff]+"),
>
>In general, it is an awesomly good idea to imitate code that is already
>there.  That literally guarantees consistency (which is Good, as you
>know).

Agreed that consistency is good.  However, using "wordregex" isn't=20
consistent.  The rest of the time it is used as an identifier in the code,=
=20
it's spelled "word_regex" or "word_regexp", even before my patch. =20
(Declarations in: userdiff.h, builtin-grep.c, 3x diff.c, and grep.h)

In particular, the macro is used to initialize "struct userdiff_driver"s=20
and the relevant member of that struct uses "word_regex" before my patch.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart2831787.CN4ZU0OUf1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkl3QGYACgkQ55pqL7G1QFkQ2ACZAZytT/zfr5C5PnIy5IefVeO4
HuAAn0sdc/cw3lFlYP51hSQx7xDIHoDh
=noKQ
-----END PGP SIGNATURE-----

--nextPart2831787.CN4ZU0OUf1--
