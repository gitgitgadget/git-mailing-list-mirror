From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: gitk highlighting commits
Date: Fri, 08 Jun 2007 08:55:17 +0200
Message-ID: <4668FD55.9030604@trolltech.com>
References: <20070608084501.1b66f16a@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF0EC02129BC527D302CBA1FF"
Cc: git@vger.kernel.org
To: picca <picca@synchrotron-soleil.Fr>
X-From: git-owner@vger.kernel.org Fri Jun 08 08:55:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwYNT-0003Sm-Mi
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 08:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843AbXFHGzK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 02:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756537AbXFHGzK
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 02:55:10 -0400
Received: from esparsett.troll.no ([62.70.27.18]:58371 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754843AbXFHGzI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 02:55:08 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id A2F2C600AE; Fri,  8 Jun 2007 08:55:05 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id 7F5D26006D; Fri,  8 Jun 2007 08:55:05 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.3) Gecko/20070326 Thunderbird/2.0.0.0 Mnenhy/0.7.5.666
In-Reply-To: <20070608084501.1b66f16a@localhost.localdomain>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49443>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF0EC02129BC527D302CBA1FF
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

picca said the following on 08.06.2007 08:45:
> Hello
>=20
> I am using git to follow the wine development. And I wondering if it
> is possible to highlight all the commit since my last git pull ?
>=20
> Indeed there is so many commits that I can not remenber the
> last one I red before I did this git pull.

You _could_ do:
Simply use a tag to mark the HEAD commit before you do the next pull.
     git tag LastReadCommit
(HEAD is implicit on the tag command)
The tag will then be displayed in gitk, so you know where you left=20
off. Then, when you're done, simply move the tag to the new HEAD.
     git tag -d LastReadCommit
     git tag LastReadCommit

--=20
=2Emarius


--------------enigF0EC02129BC527D302CBA1FF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFGaP1VKzzXl/njVP8RAjnTAJ9VF6whStKMKVwtlD7FJWwWjcywIgCg83Ir
2U3PqsGtsHQu9YPjXLAdq9w=
=D6lC
-----END PGP SIGNATURE-----

--------------enigF0EC02129BC527D302CBA1FF--
