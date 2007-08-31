From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH 1/2] Introduces xmkstemp()
Date: Fri, 31 Aug 2007 10:42:53 +0200
Message-ID: <46D7D48D.6000503@trolltech.com>
References: <20070814164453.400b9c55@localhost> <46D7D0F7.1050302@trolltech.com> <46D7D284.30004@telecom.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6CFF817B7B5EFD7D56702045"
Cc: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Fri Aug 31 10:43:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR25u-0006ke-WB
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 10:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487AbXHaImx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 04:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755142AbXHaImw
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 04:42:52 -0400
Received: from esparsett.troll.no ([62.70.27.18]:39429 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974AbXHaImv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 04:42:51 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 8D4B77427B; Fri, 31 Aug 2007 10:42:50 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id 815947424D; Fri, 31 Aug 2007 10:42:50 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <46D7D284.30004@telecom.at>
X-Enigmail-Version: 0.95.3
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
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57136>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6CFF817B7B5EFD7D56702045
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Sixt said the following on 31.08.2007 10:34:
> Marius Storm-Olsen schrieb:
>> This functions needs to be further down in the file for MinGW
>> builds, since mkstemp() is forward declared later in the file.
>> So, something like this:
>=20
> Please consider using the lates MinGW port. It's already fixed
> there.

Right. (That's the whole 4msysgit.git mingw.git discussion on the=20
msysgit mailinglist these days)

Just wanted to let the original author know, so he would be aware of=20
it, and we wouldn't have to go the extra round-trips with patches to=20
fix patches. (And for MinGW awareness when adding code to=20
git-compat-util.h)

--=20
=2Emarius


--------------enig6CFF817B7B5EFD7D56702045
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFG19SNKzzXl/njVP8RAmLiAJ9oKtFg7W8ADvc+aEyfhl0IhPnbbACg9tfl
4cyraUGWeNf5CuseDL75ORY=
=z7FC
-----END PGP SIGNATURE-----

--------------enig6CFF817B7B5EFD7D56702045--
