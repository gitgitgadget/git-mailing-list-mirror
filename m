From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: git-p4import.py robustness changes
Date: Mon, 04 Jun 2007 10:41:34 +0200
Message-ID: <4663D03E.5040601@trolltech.com>
References: <4ACE2ABC-8D73-4097-87AC-F3B27EDA97DE@slamb.org> <0EDF1E14-3682-4B1E-A7D2-F82388F752AA@slamb.org> <7vzm3inisa.fsf@assigned-by-dhcp.cox.net> <200706031511.31157.simon@lst.de> <839AEF71-ED29-4A79-BE97-C79EAFEDC466@slamb.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5826B882562EDAAA6D7B7A75"
Cc: Simon Hausmann <simon@lst.de>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Scott Lamb <slamb@slamb.org>
X-From: git-owner@vger.kernel.org Mon Jun 04 10:41:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv88C-0000h1-IJ
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 10:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbXFDIlc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 04:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752446AbXFDIlc
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 04:41:32 -0400
Received: from esparsett.troll.no ([62.70.27.18]:49118 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321AbXFDIlb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 04:41:31 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id B074060012; Mon,  4 Jun 2007 10:41:29 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id 6C65A60008; Mon,  4 Jun 2007 10:41:29 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.3) Gecko/20070326 Thunderbird/2.0.0.0 Mnenhy/0.7.5.666
In-Reply-To: <839AEF71-ED29-4A79-BE97-C79EAFEDC466@slamb.org>
X-Enigmail-Version: 0.95.0
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49084>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5826B882562EDAAA6D7B7A75
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

> git-p4import.py should work fine on Windows, too - the binary mode on  =

> the pipe should be all handled by "subprocess", and git-p4's =20
> data.replace("\r\n", "\n") is not necessary if you use "LineEnd: =20
> unix" or "share" in the Perforce client specification.

The problem is that you cannot set the LineEnd when using the 'p4=20
print' command, since it doesn't use the client spec; so Perforce the=20
uses the platform default when printing the file.

> git-p4 seems to use "git fast-import". I guess the big performance
> improvement there is removing the ls-files operation? So we're=20
> talking about a 0-10% speedup, right? Plus some fork()/exec()
> overhead.

With git-p4 the performance bottleneck is from what we can see the=20
Perforce server, on non-Windows machines.

--=20
=2Emarius


--------------enig5826B882562EDAAA6D7B7A75
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFGY9A+KzzXl/njVP8RAnbTAJ44uOVdHJ5UPHL7p1+Nk3H+cbhofQCg6psa
NhL9OKlnP47tcsCpK2Tw+Gc=
=amSY
-----END PGP SIGNATURE-----

--------------enig5826B882562EDAAA6D7B7A75--
