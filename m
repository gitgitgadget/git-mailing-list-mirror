From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: Stats in Git
Date: Sun, 02 Sep 2007 22:09:31 +0200
Message-ID: <46DB187B.9060809@trolltech.com>
References: <46DACD93.9000509@trolltech.com> <20070902200218.GA2756@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3300ACE43738747501A02AC9"
Cc: Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 22:10:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRvlf-0005Gz-EM
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 22:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbXIBUJp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 16:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753305AbXIBUJp
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 16:09:45 -0400
Received: from esparsett.troll.no ([62.70.27.18]:60828 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbXIBUJo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 16:09:44 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 174F574235; Sun,  2 Sep 2007 22:09:41 +0200 (CEST)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	by esparsett.troll.no (Postfix) with ESMTP
	id E1FDB7420B; Sun,  2 Sep 2007 22:09:40 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <20070902200218.GA2756@steel.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57383>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3300ACE43738747501A02AC9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Alex Riesen wrote:
> Marius Storm-Olsen, Sun, Sep 02, 2007 16:49:55 +0200:
>> By applying the diff below, you can see for yourself what happens when=

>=20
> just use "strace -e fstat,stat,lstat,stat64,lstat64 -f git-status"
> on sane platform.

Right, I was doing this on Windows, where strace is rather.. limited, so
I thought I'd just share the code for all to play with :-)

But, on my linux box:
$ strace -e fstat,stat,lstat,stat64,lstat64 -f git-status 2>&1 | wc -l
300195

(Slightly more stats there, as expected, due to the listings of the
shells stats too, and not just the builtins.)

--
=2Emarius


--------------enig3300ACE43738747501A02AC9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFG2xiAKzzXl/njVP8RAtSTAJ9kg/4JvA38/B+HkM/v6xMShCsyMwCgp+2l
DY62HMlahu61UsdqkNFnCmY=
=O8qV
-----END PGP SIGNATURE-----

--------------enig3300ACE43738747501A02AC9--
