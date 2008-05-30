From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH 2/3] Introduce core.showUntrackedFiles to make it possible
 to disable showing of untracked files.
Date: Fri, 30 May 2008 15:10:51 +0200
Message-ID: <483FFCDB.9010902@trolltech.com>
References: <043361f81946d5657217e6be0f22f4df350fd13f.1212152269.git.marius@trolltech.com> <3088e5a9507aa55ee55f512fb3bd554f1658d2e3.1212152269.git.marius@trolltech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9079232688D09F749DD6FD47"
Cc: Junio C Hamano <gitster@pobox.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 30 15:11:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K24OV-0000NL-Se
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 15:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbYE3NKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 09:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbYE3NKw
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 09:10:52 -0400
Received: from hoat.troll.no ([62.70.27.150]:46957 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446AbYE3NKw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 09:10:52 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id E6ED920BEF;
	Fri, 30 May 2008 15:10:50 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id DC47C20BEA;
	Fri, 30 May 2008 15:10:50 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <3088e5a9507aa55ee55f512fb3bd554f1658d2e3.1212152269.git.marius@trolltech.com>
X-Enigmail-Version: 0.95.6
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
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83297>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9079232688D09F749DD6FD47
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

(Err.. Sent from me, and should have had a:)
From: Simon Hausmann <simon@lst.de>
> Determining untracked files can be a very slow operation on large trees=
=2E This commit introduces
> a configuration variable that makes it possible to disable showing of u=
ntracked files by default
> as well as a -U commandline option to override this.
>=20
> Signed-off-by: Simon Hausmann <simon@lst.de>
> Signed-off-by: Marius Storm-Olsen <marius@trolltech.com>

Sorry for the confusion...

--=20
=2Emarius [@trolltech.com]
'if you know what you're doing, it's not research'


--------------enig9079232688D09F749DD6FD47
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFIP/zbKzzXl/njVP8RAszWAJ9efMmi1SedlRQoxptVNMP5veuUxgCfc9bo
LYoRopr8YGrayrgwcItBWeE=
=JomB
-----END PGP SIGNATURE-----

--------------enig9079232688D09F749DD6FD47--
