From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Mon, 03 Sep 2007 18:15:28 +0200
Message-ID: <46DC3320.1010408@trolltech.com>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com> <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com> <46DC10FE.1080805@eudaptics.com> <Pine.LNX.4.64.0709031536060.28586@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFDEDD42C67A12534A333DA0B"
Cc: Johannes Sixt <j.sixt@eudaptics.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 03 18:15:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISEaY-0000Km-SE
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 18:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304AbXICQPl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 12:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752405AbXICQPl
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 12:15:41 -0400
Received: from esparsett.troll.no ([62.70.27.18]:44114 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbXICQPk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 12:15:40 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id D89B0741DE; Mon,  3 Sep 2007 18:15:36 +0200 (CEST)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	by esparsett.troll.no (Postfix) with ESMTP
	id 891F474196; Mon,  3 Sep 2007 18:15:36 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <Pine.LNX.4.64.0709031536060.28586@racer.site>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57492>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFDEDD42C67A12534A333DA0B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin wrote:
> On Mon, 3 Sep 2007, Johannes Sixt wrote:
>> I see many more failures. in:
>>
>> t4001-diff-rename.sh: 5
>> t4101-apply-nonl.sh: all
>> t4102-apply-rename.sh: 2,3,4
>> t4116-apply-reverse.sh: 3
>> t4200-rerere.sh: 12,13,17
>> t5515-fetch-merge-logic.sh: 54
>> etc...
>=20
> Funny.  I do not get most of these:
>=20
> t4200-rerere,
> t5510-fetch,
> t5515-fetch-merge-logic,
> t5700-clone-reference,
> t5701-clone-local,
> t7004
>=20
> This is all on top of 4msysgit's "devel" branch, and the t5* and
> t7004 failed there already.
>=20
> Oh, and I actually run from sh, not from cmd.  (Wouldn't you have=20
> guessed?)

I was also running the tests under sh, however on top of mingw.git, and
not 4msysgit.git.

--
=2Emarius


--------------enigFDEDD42C67A12534A333DA0B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFG3DMkKzzXl/njVP8RAr2jAJ9WkVoOhmxFbBZrVOMxjUE/pOd3MQCgpxv9
Hbfsn1iYn2D/cTsuP55E/0A=
=LG4A
-----END PGP SIGNATURE-----

--------------enigFDEDD42C67A12534A333DA0B--
