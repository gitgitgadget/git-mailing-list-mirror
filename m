From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Thu, 06 Sep 2007 18:34:12 +0200
Message-ID: <46E02C04.1060400@trolltech.com>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com> <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com> <Pine.LNX.4.64.0709031428080.28586@racer.site> <46DC5ED4.8050202@trolltech.com> <46DD0C16.70101@eudaptics.com> <46E0285E.1000603@eudaptics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8B04EEE0E66F733B58D650B5"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 18:34:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITKJI-0004WE-Op
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 18:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbXIFQeY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 12:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbXIFQeY
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 12:34:24 -0400
Received: from esparsett.troll.no ([62.70.27.18]:50778 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbXIFQeX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 12:34:23 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 123B6741DB; Thu,  6 Sep 2007 18:34:22 +0200 (CEST)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	by esparsett.troll.no (Postfix) with ESMTP
	id B04C27429A; Thu,  6 Sep 2007 18:34:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <46E0285E.1000603@eudaptics.com>
X-Enigmail-Version: 0.95.3
OpenPGP: id=34EB4437
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57902>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8B04EEE0E66F733B58D650B5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Johannes Sixt wrote:
> Johannes Sixt schrieb:
>> Marius Storm-Olsen schrieb:
>>> Johannes Schindelin wrote:
>>>> To make it easier on others, I just uploaded it into the
>>>> "teststat" branch on 4msysgit.git (subject to removal in a few
>>>> days).
>>>=20
>>> Ok, I've updated the patch in the 4msysgit.git repo, 'teststat'
>>> branch. RFC, and please test.
>>=20
>> Thanks a lot! I've pushed it out in mingw.git's master.
>>=20
>> The reason that t4200-rerere.sh fails is that we now store UTC in=20
>> st_mtime. However, for the garbage-collection we compare this entry
>> to a local time stamp.
>=20
> This analysis is incorrect, I think. The reason we fail seems to be
> that t4200 uses test-chmtime, which uses utime(). Likely, we need a
> wrapper for that one?

Ok, could you make a quick patch to add a git_utime() (and probably
git_time()) and see if the tests pass without the UTC to Local time patch=
?

--
=2Emarius


--------------enig8B04EEE0E66F733B58D650B5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFG4CwIKzzXl/njVP8RApHWAJoC9gaaSoVwJuD7C16lsx7uKzm94wCfeqGp
ySXAd82xsgWNmLe9/ULUAig=
=/Dpb
-----END PGP SIGNATURE-----

--------------enig8B04EEE0E66F733B58D650B5--
