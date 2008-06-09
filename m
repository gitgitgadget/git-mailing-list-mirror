From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH 1/3] Add an optional <mode> argument to commit/status
 -u|--untracked-files option
Date: Mon, 09 Jun 2008 08:54:31 +0200
Message-ID: <484CD3A7.8090303@trolltech.com>
References: <7vod6i1e3p.fsf@gitster.siamese.dyndns.org> <5f0ab026ce200e501be81a3b5082e482e1580e42.1212670149.git.marius@trolltech.com> <7v4p86qa93.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4A14D7DCD403A1F8515689DE"
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 08:55:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5bHv-0002iW-G0
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 08:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754759AbYFIGyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 02:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754407AbYFIGyh
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 02:54:37 -0400
Received: from hoat.troll.no ([62.70.27.150]:42325 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753524AbYFIGyg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 02:54:36 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 3C96C20A90;
	Mon,  9 Jun 2008 08:54:31 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 19C32203CE;
	Mon,  9 Jun 2008 08:54:31 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <7v4p86qa93.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEXU1NTAwMABAQGsrKyE
 hIQwMDAEBAS8hGUfAAACQUlEQVQ4jV2TS47cMAxEKSDZW1CfwMB4PYLkrKchsveJRR2gEen+R0hR
 9vziBmahhyqSRQ4NfF1FmIv3dH4usNAGoFprBVguQJmZ1nX0XiHgEukTCK3TairiZeXcVGzmZIoU
 3738pehdVbiU9KFgMQWeZ1fpHZDfRS4rPb3eQVaZChGx4ikt5GDkAZQ2KKohzjklno4+iJpVhxka
 ZjSpasJ4gdGaEQMWTMjRa5uTqza0XDJjzhIdzGTMrqoopimoIPCKZtVOq265MAXpMLXycmVl2Y8C
 oE1FkT/faKauOjYoHJyOxHfvixjowvI0xZJsKykubgLYzuJMdBO+L86TjxfQ9hz9jpSudbnXXzRm
 tor5i3MUONpOfARAhlWbzWF7OhP2eSeEW9HUBNiHOxUM8HLWHhUAj3NZNsdqRZpNA+DJ+XlX+Qc9
 Z4ZjHX8LRUzgTBBef84NQoCMOcS0+BMsj3klbTzRri03ugXr9em1GfgzDAyEn4J3fvFI5YwdTrYu
 1ntAY1h5ysM2OMGm+cBOocCXHisAHu2PagnLghoG2krz8bzsA4fj7KxCGk+63jt+DDCtYjbFNkHD
 nRwpRqsQYx5WYzsbm/eBfn0I4TbOGvMWqhQAiEDzNs4apumCI0x2OyHtY7uAlZff/sanbH9+AGT1
 KOEmUlJISdYPgEgehw+cTZEf6xeFyoEjCPgv+A62KhW3EOy9PL7WmCBMRWmfYN0OqW9krzl/Ay91
 75HMqfDtP8UFckFUX2rwrm/kTVB2gH+hdu4avZVCuAAAAABJRU5ErkJggg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84363>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4A14D7DCD403A1F8515689DE
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Junio C Hamano said the following on 07.06.2008 03:55:
> Marius Storm-Olsen <marius@trolltech.com> writes:
>=20
>> diff --git a/builtin-commit.c b/builtin-commit.c
>> index b294c1f..1f4986b 100644
>> --- a/builtin-commit.c
>> +++ b/builtin-commit.c
>> @@ -102,7 +103,7 @@ static struct option builtin_commit_options[] =3D =
{
>>  	OPT_BOOLEAN('o', "only", &only, "commit only specified files"),
>>  	OPT_BOOLEAN('n', "no-verify", &no_verify, "bypass pre-commit hook"),=

>>  	OPT_BOOLEAN(0, "amend", &amend, "amend previous commit"),
>> -	OPT_BOOLEAN('u', "untracked-files", &untracked_files, "show all untr=
acked files"),
>> +	{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mode=
", "show untracked files, optional modes: all, normal. (Default: all)", P=
ARSE_OPT_OPTARG, NULL, (int)"all" },
>=20
> Hmm.
>=20
> $ make
> builtin-commit.c:106: error: initializer element is not constant
> builtin-commit.c:106: error: (near initialization for 'builtin_commit_o=
ptions[18].defval')
> make: *** [builtin-commit.o] Error 1
 >
> I also have to wonder what the funny cast of (int)"all"  is doing.

Ops, obviously it should have been s@\(int\)@(intptr_t)@. Sorry about=20
that, I'll resend the patch series.

(The option struct in parse_options.h uses intptr_t for the default=20
value of an option, thus a normal const char * would make the compiler=20
complain (verified with both Windows MinGW 3.4.5 and Linux GCC 4.1.2))

BTW, which compiler version are you using?

--=20
=2Emarius [@trolltech.com]
'if you know what you're doing, it's not research'


--------------enig4A14D7DCD403A1F8515689DE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFITNOnKzzXl/njVP8RAr8fAKDG1t+dBPIAuYuCTJmOdPcJE1ZUXACgl2sM
mRVEmKJ9AJDnCVan7ZbyeQM=
=tBCG
-----END PGP SIGNATURE-----

--------------enig4A14D7DCD403A1F8515689DE--
