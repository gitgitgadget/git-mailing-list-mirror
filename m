From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH 6/5] NUL hack to create_file()
Date: Thu, 29 May 2008 09:05:37 +0200
Message-ID: <483E55C1.1000900@trolltech.com>
References: <1212020246-26480-1-git-send-email-gitster@pobox.com> <1212020246-26480-2-git-send-email-gitster@pobox.com> <1212020246-26480-3-git-send-email-gitster@pobox.com> <1212020246-26480-4-git-send-email-gitster@pobox.com> <1212020246-26480-5-git-send-email-gitster@pobox.com> <1212020246-26480-6-git-send-email-gitster@pobox.com> <1212020246-26480-7-git-send-email-gitster@pobox.com> <483E4E3C.90805@viscovery.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig80A566CA1C5AF166C713D1E2"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 29 09:06:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1cDb-00044r-QM
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 09:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630AbYE2HFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 03:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753402AbYE2HFk
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 03:05:40 -0400
Received: from hoat.troll.no ([62.70.27.150]:42852 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753145AbYE2HFi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 03:05:38 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 3AE8120838;
	Thu, 29 May 2008 09:05:37 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 2F0672015E;
	Thu, 29 May 2008 09:05:37 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <483E4E3C.90805@viscovery.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83179>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig80A566CA1C5AF166C713D1E2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Sixt said the following on 29.05.2008 08:33:
> Junio C Hamano schrieb:
>> This is not meant for application to the mainline.  It allows your git=
 to
>> refuse to create a blob whose name is "nul".
>=20
> It's not just about "nul"; these won't work either: "aux", "prn", "con"=
,
> "com\d+", "lpt\d+", neither do "$one_of_these.$some_extension". And all=
 of
> that regardless of the case!
>=20
> See http://msdn.microsoft.com/en-us/library/aa365247(VS.85).aspx
>=20
> Definitely, we don't ever want to have such special-casing somewhere in=
 git.

They _can_ be used by using the UNC notation:
     \\?\<drive letter>:\<path>\nul
Do you think we should special-case that, or simply fail?

( 9:04:57 - D:\home\marius\source\hg\test)
 > hg checkout
abort: The parameter is incorrect: D:\home\marius\source\hg\test\nul

'Nuff said? :-)

--=20
=2Emarius [@trolltech.com]
'if you know what you're doing, it's not research'


--------------enig80A566CA1C5AF166C713D1E2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFIPlXBKzzXl/njVP8RAtVuAKDIvwr99J9x9QI6RATdxfilSxJbdACeLiLc
K2NZsOz6u/4IKo2VYi1qkc4=
=uU7R
-----END PGP SIGNATURE-----

--------------enig80A566CA1C5AF166C713D1E2--
