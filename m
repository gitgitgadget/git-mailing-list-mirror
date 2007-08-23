From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [TESTCASE] Failing 'git am' when core.autocrlf=true
Date: Thu, 23 Aug 2007 19:45:21 +0200
Message-ID: <46CDC7B1.7070908@trolltech.com>
References: <46CD94AB.7070709@trolltech.com> <alpine.LFD.0.999.0708230956190.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF1FC762BD5E829EB45CB2D1C"
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 19:44:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOGj1-0004Nw-AA
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 19:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155AbXHWRoB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 13:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756954AbXHWRoB
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 13:44:01 -0400
Received: from esparsett.troll.no ([62.70.27.18]:57283 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754101AbXHWRoA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 13:44:00 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 06E397422B; Thu, 23 Aug 2007 19:43:59 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id EC764741E4; Thu, 23 Aug 2007 19:43:58 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <alpine.LFD.0.999.0708230956190.30176@woody.linux-foundation.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56509>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF1FC762BD5E829EB45CB2D1C
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Linus Torvalds said the following on 23.08.2007 19:18:
> On Thu, 23 Aug 2007, Marius Storm-Olsen wrote:
>> I have an issue with git-rebase failing on a repository using
>>     core.autocrlf=3Dtrue
>=20
> Very interesting.
>=20
> Adding some instrumentation to "git-am.sh" (namely a lot of
>=20
> 	git diff --quiet || exit

Aah! Very neat way to narrow it down. I'll keep that in mind for later=20
debugging. Thanks!


> This patch should fix it.=20

Yep, it did. I just rebased 80 commits with core.autocrlf=3Dtrue. Thanks =

again, Linus, for the quick reply!

--=20
=2Emarius


--------------enigF1FC762BD5E829EB45CB2D1C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFGzcexKzzXl/njVP8RAs6mAKDPL4OsVOe+YcQkFsZie7qPD4ULowCdEpF/
g5Ei8xvtPwud4AvNHbrXatk=
=IRAy
-----END PGP SIGNATURE-----

--------------enigF1FC762BD5E829EB45CB2D1C--
