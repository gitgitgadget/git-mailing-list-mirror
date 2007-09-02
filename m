From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and
 make stat use that implementation too.
Date: Sun, 02 Sep 2007 19:05:19 +0200
Message-ID: <46DAED4F.2080407@trolltech.com>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com> <3f4fd2640709020832x656fa78djf29117690318ea48@mail.gmail.com> <46DAE025.900@trolltech.com> <3f4fd2640709020933sa2bdec0g532500ea49c179b5@mail.gmail.com> <F0525923-6D9B-46AA-9678-8B1263C45FF7@silverinsanity.com> <3f4fd2640709020953k2f5367a0o64870da9d8e04f68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0CA81D51B1884A9F802C6865"
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 19:05:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRstD-00038L-Tv
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 19:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756387AbXIBRFc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 13:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755932AbXIBRFb
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 13:05:31 -0400
Received: from esparsett.troll.no ([62.70.27.18]:60819 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbXIBRFa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 13:05:30 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 4FF0E7421C; Sun,  2 Sep 2007 19:05:29 +0200 (CEST)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	by esparsett.troll.no (Postfix) with ESMTP
	id BE48C74213; Sun,  2 Sep 2007 19:05:28 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <3f4fd2640709020953k2f5367a0o64870da9d8e04f68@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57367>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0CA81D51B1884A9F802C6865
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Reece Dunn wrote:
> On 02/09/07, Brian Gernhardt <benji@silverinsanity.com> wrote:
>> On Sep 2, 2007, at 12:33 PM, Reece Dunn wrote:
>>> You pull a repository that contains executable scripts that are=20
>>> required to work in order to build the system. You then make some
>>>  modifications to the local repository and run the 'git add .'
>>> command. Since this patch is reporting executable bits
>>> differently, the mode change is stored as well as the local
>>> modifications. Now the changes are pushed upstream (along with
>>> the file mode changes).
>>=20
>> We already have a way to tell git that the "executable bit" is=20
>> worthless, and any Windows port should use it.
>=20
> Ok, so as the executable bit is worthless, there doesn't need to be=20
> any special casing in this patch to deal with it.

Right, this is true. And I was debating it with myself, and just added
it for completion; at least for the first revision of the patch. It
doesn't really affect the performance all that much anyways. The
conversion of the FileTime to unix time_t is far more heavy. (Which is
why I'm debating to just ignore the access time)

If we could somehow rather use the FileTimes directly in the index,
instead of having to convert them, we could have even better performance
when stat'ing on Windows. (However, it would result in an incompatible
index, so everyone would have to 'git update-index --refresh' on all
repositories before they can use the new version.)

--
=2Emarius


--------------enig0CA81D51B1884A9F802C6865
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFG2u1UKzzXl/njVP8RAjjaAJ9hZ3ovAImcYA22AyOx5DI7mvZHUgCgpXQ7
ndnL8KooXf/EmcTzRGfQ9XU=
=zxcy
-----END PGP SIGNATURE-----

--------------enig0CA81D51B1884A9F802C6865--
