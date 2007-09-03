From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and
 make stat use that implementation too.
Date: Mon, 03 Sep 2007 13:53:16 +0200
Message-ID: <46DBF5AC.6070400@trolltech.com>
References: <46DACD93.9000509@trolltech.com> <46DB0478.8050402@trolltech.com> <46DB0F9C.2090306@trolltech.com> <200709022228.00733.robin.rosenberg.lists@dewire.com> <46DBA672.9050308@trolltech.com> <Pine.LNX.4.64.0709031238400.28586@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE5BF2D62F8880D52B4E679B6"
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 03 13:53:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISAUV-000379-9U
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 13:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755135AbXICLxL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 07:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755072AbXICLxL
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 07:53:11 -0400
Received: from esparsett.troll.no ([62.70.27.18]:49679 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865AbXICLxK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 07:53:10 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 4C8337418D; Mon,  3 Sep 2007 13:53:08 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id 3C6E574240; Mon,  3 Sep 2007 13:53:08 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <Pine.LNX.4.64.0709031238400.28586@racer.site>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57474>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE5BF2D62F8880D52B4E679B6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin said the following on 03.09.2007 13:39:
> On Mon, 3 Sep 2007, Marius Storm-Olsen wrote:
>> Robin Rosenberg said the following on 02.09.2007 22:27:
>>> It does now: See=20
>>> http://msdn2.microsoft.com/en-us/library/aa363866.aspx
>> Yeah, I know about Vista's improved support for symbolic links.
>> However, I think we can let that lay for a while, until we decide
>> to make Git generate proper symlinks on Vista. I don't see it as
>> a 1st priority at the moment, and we can always add the needed
>> functionality in a separate stat() function later.
>=20
> ... and force everybody to upgrade to Vista, thereby working for
> Microsoft for free?  You _know_ that I will oppose that change.

;-) I wouldn't dream of it!
Nah, my comment was more 'allow usage of proper Symlinks on Vista' at=20
a later point. I would still argue that the default would be what we=20
have today. So, it would have to be an option.
But seeing what they've done to the symlinks there, it might be far=20
fetched. We'll worry about that (much) later..

--=20
=2Emarius


--------------enigE5BF2D62F8880D52B4E679B6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFG2/WsKzzXl/njVP8RAhmEAKC/cL7KfaT5yyLuezfmdS0jTXqsMACgqRJc
FD5Y/Xlca1LOcdbN+1S9QkU=
=Eo95
-----END PGP SIGNATURE-----

--------------enigE5BF2D62F8880D52B4E679B6--
