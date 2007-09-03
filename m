From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and
 make stat use that implementation too.
Date: Mon, 03 Sep 2007 08:15:14 +0200
Message-ID: <46DBA672.9050308@trolltech.com>
References: <46DACD93.9000509@trolltech.com> <46DB0478.8050402@trolltech.com> <46DB0F9C.2090306@trolltech.com> <200709022228.00733.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2449DB18B746076980F8095D"
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 08:15:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS5DO-0003SB-Tm
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 08:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbXICGPK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 02:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbXICGPJ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 02:15:09 -0400
Received: from esparsett.troll.no ([62.70.27.18]:39704 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbXICGPH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 02:15:07 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 15861741B3; Mon,  3 Sep 2007 08:15:07 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id 09A34741AD; Mon,  3 Sep 2007 08:15:07 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <200709022228.00733.robin.rosenberg.lists@dewire.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57431>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2449DB18B746076980F8095D
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Robin Rosenberg said the following on 02.09.2007 22:27:
> s=F6ndag 02 september 2007 skrev Marius Storm-Olsen:
>> (Also, since Windows doesn't really handle symlinks, it's fine that st=
at just uses lstat)
>=20
> It does now: See http://msdn2.microsoft.com/en-us/library/aa363866.aspx=


Yeah, I know about Vista's improved support for symbolic links.
However, I think we can let that lay for a while, until we decide to=20
make Git generate proper symlinks on Vista. I don't see it as a 1st=20
priority at the moment, and we can always add the needed functionality=20
in a separate stat() function later.

--=20
=2Emarius


--------------enig2449DB18B746076980F8095D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFG26ZzKzzXl/njVP8RAq1rAJ0eoz0l6RdegVMEEYnXkTlowe2XpwCfSxpZ
OptYLBoJwwfdmYfbe0Arzo4=
=13Ba
-----END PGP SIGNATURE-----

--------------enig2449DB18B746076980F8095D--
