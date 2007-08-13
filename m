From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH 2/2] checkout: fix attribute handling in checkout all
Date: Mon, 13 Aug 2007 09:15:33 +0200
Message-ID: <46C00515.5050308@trolltech.com>
References: <11869508753328-git-send-email-prohaska@zib.de> <118695087531-git-send-email-prohaska@zib.de> <7veji8ifs2.fsf@assigned-by-dhcp.cox.net> <7vfy2ogdvl.fsf@assigned-by-dhcp.cox.net> <46BFFB1A.4070704@trolltech.com> <5BA0164D-8327-4B01-84CD-595D8573BEEF@zib.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6B679BB8A2D558AC813F41BA"
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Brian Downing <bdowning@lavos.net>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Aug 13 09:14:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKU8b-0004mE-9n
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 09:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S940890AbXHMHOc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 03:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S940884AbXHMHOb
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 03:14:31 -0400
Received: from esparsett.troll.no ([62.70.27.18]:56521 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S940872AbXHMHO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 03:14:29 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 5E91174245; Mon, 13 Aug 2007 09:14:27 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id 5059574221; Mon, 13 Aug 2007 09:14:27 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <5BA0164D-8327-4B01-84CD-595D8573BEEF@zib.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55749>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6B679BB8A2D558AC813F41BA
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Steffen Prohaska said the following on 13.08.2007 08:50:
> On Aug 13, 2007, at 8:32 AM, Marius Storm-Olsen wrote:
>> In msysgit.git/etc/.gitattributes we have 'termcap -crlf', to avoid =20
>> the termcaps being checked out with Windows EOL, if the user =20
>> happens to have 'autocrlf =3D true'. However, when you checkout the =20
>> working dir the first time it still has Windows EOL due to exactly =20
>> this problem.
>=20
> And exactly this is where I recognized the issue.
>=20
> msysgit devs,
> We should really make autocrlf =3D true the default for us and fix
> all problems that we'll encounter. There may be more tricky stuff
> ahead, like merges, cherry-picks, ...

I'm more leaning towards having the installer give you the option to=20
choose what kind of line-endings you want Git to work with; just like=20
the Cygwin installer.

--=20
=2Emarius


--------------enig6B679BB8A2D558AC813F41BA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFGwAUVKzzXl/njVP8RAl2nAKCEfat06rEtGFU0a4aPzG8Dz0cqkwCdGqfl
CCIz12n9jrd+lxZwRdJk/Gw=
=dehg
-----END PGP SIGNATURE-----

--------------enig6B679BB8A2D558AC813F41BA--
