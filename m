From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Tue, 04 Sep 2007 12:20:03 +0200
Message-ID: <46DD3153.8060805@trolltech.com>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com> <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com> <Pine.LNX.4.64.0709031428080.28586@racer.site> <46DC5ED4.8050202@trolltech.com> <46DD0C16.70101@eudaptics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2021450F0170C1A270E26BE1"
Cc: Johannes Sixt <johannes.sixt@telecom.at>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@eudaptics.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 04 12:20:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISVVv-0008Nu-Ud
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 12:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbXIDKT7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 06:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752535AbXIDKT6
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 06:19:58 -0400
Received: from esparsett.troll.no ([62.70.27.18]:39419 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbXIDKT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 06:19:57 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 49649741D8; Tue,  4 Sep 2007 12:19:54 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id 3444B741CA; Tue,  4 Sep 2007 12:19:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <46DD0C16.70101@eudaptics.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57545>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2021450F0170C1A270E26BE1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Sixt said the following on 04.09.2007 09:41:
> Marius Storm-Olsen schrieb:
>> Johannes Schindelin wrote:
>>> To make it easier on others, I just uploaded it into the
>>> "teststat" branch on 4msysgit.git (subject to removal in a few
>>> days).
>> Ok, I've updated the patch in the 4msysgit.git repo, 'teststat'
>> branch. RFC, and please test.
>=20
> Thanks a lot! I've pushed it out in mingw.git's master.

Ops, already in master branch?
Ok, I found out that the custom fstat function was incomplete, so I=20
completed it. However, since you've already pushed it to your main=20
branch, I've added it as a separate commit to the 4msysgit.git=20
'teststat' branch. It might also explain some of the testfailures we=20
were seeing, but I haven't finished the test run yet. (So, consider=20
the patch something to play with, and don't commit it to your 'master'=20
branch yet! ;-)

http://repo.or.cz/w/git/mingw/4msysgit.git?a=3Dcommitdiff;h=3Df15974add93=
bdfa92775c77c00e7c65aefd42127


> The reason that t4200-rerere.sh fails is that we now store UTC in
> st_mtime. However, for the garbage-collection we compare this entry
> to a local time stamp. Therefore, I've pushed out a fixup patch at
> the top of mingw.git's devel branch that converts mtime to local
> time=20
> (http://repo.or.cz/w/git/mingw.git?a=3Dcommitdiff;h=3D1b62ecb31068af06c=
2fa7664f06c6c36316aac2c).
> Would you kindly conduct the performance test with this patch? I'm
> afraid that this makes us substantially slower.

Ok, I can give it a performance test, but I tend to agree with David=20
Kastrup there. It would be better if we rather fix the places where we=20
check with the local timestamp instead; depending of course on how=20
many places we actually do this.
We'll see how much the timezone conversion in the custom stat=20
functions actually hurt us performance wise.

--=20
=2Emarius


--------------enig2021450F0170C1A270E26BE1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFG3TFUKzzXl/njVP8RAhgiAJ9MeiRc4kQyq3EpKJf3Hegw/Cl/RgCglu9D
ZKhdmEMgz0dUGyoLvYjaCqE=
=zbk7
-----END PGP SIGNATURE-----

--------------enig2021450F0170C1A270E26BE1--
