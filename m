From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] autodetect core.symlinks in git-init
Date: Fri, 31 Aug 2007 10:23:01 +0200
Message-ID: <46D7CFE5.9040508@trolltech.com>
References: <316a20a40708301835hc4236d4tdb289b6f705ab86@mail.gmail.com> <200708310645.l7V6jKJk009287@mi0.bluebottle.com> <7vveaw2na9.fsf@gitster.siamese.dyndns.org> <7vodgo2moe.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig004F6E1B654460125826CBDD"
Cc: Git mailing list <git@vger.kernel.org>,
	Stephen Cuppett <cuppett@gmail.com>,
	Nanako Shiraishi <nanako3@bluebottle.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 10:23:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR1mi-00022S-En
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 10:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755892AbXHaIXF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 04:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755691AbXHaIXD
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 04:23:03 -0400
Received: from esparsett.troll.no ([62.70.27.18]:48195 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755892AbXHaIXB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 04:23:01 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 9AE1B7432C; Fri, 31 Aug 2007 10:22:59 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id 5B14374329; Fri, 31 Aug 2007 10:22:59 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <7vodgo2moe.fsf_-_@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57131>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig004F6E1B654460125826CBDD
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Junio C Hamano said the following on 31.08.2007 09:22:
> We already autodetect if filemode is reliable on the filesystem
> to deal with VFAT and friends.  Do the same for symbolic link
> support.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> +		if (!close(xmkstemp(path)) &&

Just tried this with 4msysgit (so, MinGW on Windows), and with a patch=20
for adding xmkstemp() to git-compat-util.h, this patch works perfectly=20
on Windows. It's obviously the right thing to do.

Acked-by: Marius Storm-Olsen <mstormo_git@storm-olsen.com>

--=20
=2Emarius


--------------enig004F6E1B654460125826CBDD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFG18/mKzzXl/njVP8RAmQmAKCjUtnu5Cq1Eg8faF3sx8+2DQJgdACcDjDi
GVqbjOkP0V/b2iuf5fu2hQU=
=NuKz
-----END PGP SIGNATURE-----

--------------enig004F6E1B654460125826CBDD--
