From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Mon, 03 Sep 2007 18:22:01 +0200
Message-ID: <46DC34A9.8020308@trolltech.com>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com> <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com> <Pine.LNX.4.64.0709031428080.28586@racer.site> <46DC1186.2010008@trolltech.com> <Pine.LNX.4.64.0709031538320.28586@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE537EEF5D01A954D1F693AE8"
Cc: Johannes Sixt <j.sixt@eudaptics.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 03 18:22:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISEgr-0001yV-PC
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 18:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508AbXICQWN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 12:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752502AbXICQWN
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 12:22:13 -0400
Received: from esparsett.troll.no ([62.70.27.18]:49756 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518AbXICQWM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 12:22:12 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id C725A741D7; Mon,  3 Sep 2007 18:22:11 +0200 (CEST)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	by esparsett.troll.no (Postfix) with ESMTP
	id 6A194741A2; Mon,  3 Sep 2007 18:22:11 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <Pine.LNX.4.64.0709031538320.28586@racer.site>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57493>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE537EEF5D01A954D1F693AE8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin wrote:
> On Mon, 3 Sep 2007, Marius Storm-Olsen wrote:
>> Johannes Schindelin said the following on 03.09.2007 15:33:
>>> BTW it would have been way easier to apply your patch, had you=20
>>> followed SubmittingPatches...
>> Heh, I actually tried, using the Thunderbird way. Of course the=20
>> attachments are non-conforming :-) What was the problem? Whitespace
>>  issues, Windows EOL, attachments, or all of the above? :-)
>=20
> git am said that the patch was empty.

Hmm, must be the attachments then. I'll use the 4msysgit.git repo from
now on. I assume it'll be ok if I +push to the teststat branch?

--
=2Emarius


--------------enigE537EEF5D01A954D1F693AE8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFG3DSvKzzXl/njVP8RArw0AKCbO/WjZy1ObnTNFihejYCq3Duv+wCgyUue
QDBpRCbkm9z9Vj3okzBx0ic=
=CSai
-----END PGP SIGNATURE-----

--------------enigE537EEF5D01A954D1F693AE8--
