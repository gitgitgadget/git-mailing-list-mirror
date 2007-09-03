From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Mon, 03 Sep 2007 21:21:56 +0200
Message-ID: <46DC5ED4.8050202@trolltech.com>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com> <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com> <Pine.LNX.4.64.0709031428080.28586@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFDAB603452D5A7506B87D82A"
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@eudaptics.com>,
	Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Sep 03 21:22:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISHV2-0001uD-3C
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 21:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495AbXICTWK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 15:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbXICTWI
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 15:22:08 -0400
Received: from esparsett.troll.no ([62.70.27.18]:52594 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753477AbXICTWH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 15:22:07 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 38AFB741D7; Mon,  3 Sep 2007 21:22:05 +0200 (CEST)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	by esparsett.troll.no (Postfix) with ESMTP
	id 03D6B741AE; Mon,  3 Sep 2007 21:22:05 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <Pine.LNX.4.64.0709031428080.28586@racer.site>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57504>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFDAB603452D5A7506B87D82A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin wrote:
> To make it easier on others, I just uploaded it into the "teststat"
> branch on 4msysgit.git (subject to removal in a few days).

Ok, I've updated the patch in the 4msysgit.git repo, 'teststat' branch.
RFC, and please test.

The patch also incorporates some of Hannes local changes, with some
modifications. Hannes, does it look ok for you? You can add a tag to the
commit message if you'd like, and just +push it.

On Hannes' request (and to which I fully agree), I've gone back to the
old implementation of filetime_to_time_t(), since it was a bit 'nasty'.
(If we want to target CE in the future, it will quite possibly break)

http://repo.or.cz/w/git/mingw/4msysgit.git?a=3Dcommitdiff;h=3Df4f3fbddf6e=
0f16f66f94cedf66614e0e3643496

> First comment: it seems git_fstat() is not declared properly, so
> there are quite a few compiler warnings.

This is also fixed, of course.

Hope this is the final 'cut' :-)

Later!
--
=2Emarius


--------------enigFDAB603452D5A7506B87D82A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFG3F7YKzzXl/njVP8RAsuRAJ0RCs1NTxEXnU5dVSAs9qYEVix/fQCgznCx
ZhaEE7j/WGqlx6syi1H7l+4=
=a8kK
-----END PGP SIGNATURE-----

--------------enigFDAB603452D5A7506B87D82A--
