From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] git-commit: '--no-status' Allow suppression of status
 summary in commit msg
Date: Fri, 29 Aug 2008 07:49:27 +0200
Message-ID: <48B78DE7.3070700@trolltech.com>
References: <1219949215-10189-1-git-send-email-marcus@griep.us> <20080828191302.GA2704@blimp.local> <48B6FB57.5030406@griep.us> <48B78B82.5010908@trolltech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig32944FA7753C415424462008"
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Fri Aug 29 07:51:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYwsc-0000kd-99
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 07:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbYH2Ft1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 01:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbYH2Ft1
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 01:49:27 -0400
Received: from hoat.troll.no ([62.70.27.150]:33530 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751177AbYH2Ft0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 01:49:26 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 970B52095F;
	Fri, 29 Aug 2008 07:49:25 +0200 (CEST)
Received: from [172.24.106.50] (unknown [172.24.106.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 79D54205FB;
	Fri, 29 Aug 2008 07:49:25 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.16) Gecko/20080708 Thunderbird/2.0.0.16 Mnenhy/0.7.5.666
In-Reply-To: <48B78B82.5010908@trolltech.com>
X-Enigmail-Version: 0.95.7
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig32944FA7753C415424462008
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Marius Storm-Olsen said the following on 29.08.2008 07:39:
> Marcus Griep said the following on 28.08.2008 21:24:
>> Using --untracked-files=3Dno cuts the time to display the editor from =
down to 12 seconds,
>> so that is perfectly fine.  The patch can be ignored.  However, would =
config option to
>> change the default --untracked-files value be entertained?  Allowing:
>>
>> [commit]
>> 	untrackedfiles=3Dno
>>
>> which defaults (as stated in the documentation for --untracked-files) =
to all?
>=20
> That was already added in the commit d6293d. Just set
>      status.showUntrackedFiles=3Dno
With that, I of course mean:

[status]
	showUntrackedFiles=3Dno

--=20
=2Emarius [@trolltech.com]
'if you know what you're doing, it's not research'


--------------enig32944FA7753C415424462008
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFIt43nKzzXl/njVP8RAlSJAJ0QMQ450CgQ7SLBU1vnXLlQb0P23wCgp4pC
UpVdXulCa+doXvVowPjmGzY=
=EXb7
-----END PGP SIGNATURE-----

--------------enig32944FA7753C415424462008--
