From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH 2/2] checkout: fix attribute handling in checkout all
Date: Mon, 13 Aug 2007 08:32:58 +0200
Message-ID: <46BFFB1A.4070704@trolltech.com>
References: <11869508753328-git-send-email-prohaska@zib.de> <118695087531-git-send-email-prohaska@zib.de> <7veji8ifs2.fsf@assigned-by-dhcp.cox.net> <7vfy2ogdvl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCCB5DA003F1BB1A030198111"
Cc: Steffen Prohaska <prohaska@zib.de>, dmitry.kakurin@gmail.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 08:32:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKTTq-0002RR-OZ
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 08:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967009AbXHMGcZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 02:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966714AbXHMGb6
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 02:31:58 -0400
Received: from esparsett.troll.no ([62.70.27.18]:42008 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966379AbXHMGbz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 02:31:55 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id B6DBE74242; Mon, 13 Aug 2007 08:31:52 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id 8C2697420F; Mon, 13 Aug 2007 08:31:52 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <7vfy2ogdvl.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55746>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCCB5DA003F1BB1A030198111
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Junio C Hamano said the following on 13.08.2007 08:14:
> Ok, let's step back a bit and I'll suggest an alternative
> approach to your 1/2.  This would hopefully solve 2/2 without
> any code change your patch 2/2 has.
(..snip..)
> I think this approach is very much in line with how the git
> plumbing works, but you would need to know how the world is
> designed to work in order to appreciate it fully.  Let's have a
> few paragraphs to give the readers some background.
(..snip..)
> Currently, the attr_stack code reads only from the work tree
> and work tree alone.  We could change it to:
>=20
>  - If the directory on the work tree has .gitattributes, use it
>    (this is what the current code does);
>=20
>  - Otherwise if the index has .gitattributes at the
>    corresponding path, use that instead.
>=20
> This essentially treats not having .gitattributes files checked
> out as equivalent to having these files checked out unmodified,
> which is very much in line with how the world is designed to
> work.

ACK! We really need this! :-)

In msysgit.git/etc/.gitattributes we have 'termcap -crlf', to avoid=20
the termcaps being checked out with Windows EOL, if the user happens=20
to have 'autocrlf =3D true'. However, when you checkout the working dir=20
the first time it still has Windows EOL due to exactly this problem.

The above algorithm would alleviate this issue.

--=20
=2Emarius


--------------enigCCB5DA003F1BB1A030198111
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFGv/saKzzXl/njVP8RAhXwAKCMgSXJk3aSjWND3MvJmKNRDkmI/QCgrBII
111ExYamt+iNysPZq7xxwV8=
=yaDO
-----END PGP SIGNATURE-----

--------------enigCCB5DA003F1BB1A030198111--
