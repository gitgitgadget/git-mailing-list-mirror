From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Tue, 04 Sep 2007 18:32:11 +0200
Message-ID: <46DD888B.9020101@trolltech.com>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com> <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com> <Pine.LNX.4.64.0709031428080.28586@racer.site> <46DC5ED4.8050202@trolltech.com> <46DD0C16.70101@eudaptics.com> <Pine.LNX.4.64.0709041145230.28586@racer.site> <46DD433A.5040604@eudaptics.com> <46DD473A.8010602@trolltech.com> <46DD63F5.5050002@trolltech.com> <Pine.LNX.4.64.0709041529191.28586@racer.site> <46DD6F2B.3060001@trolltech.com> <Pine.LNX.4.64.0709041547240.28586@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE400888B2133718935050EBB"
Cc: Johannes Sixt <j.sixt@eudaptics.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 04 18:32:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISbKG-0003Yf-27
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 18:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612AbXIDQcW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 12:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753464AbXIDQcV
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 12:32:21 -0400
Received: from esparsett.troll.no ([62.70.27.18]:46278 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252AbXIDQcU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 12:32:20 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 4E55C74232; Tue,  4 Sep 2007 18:32:19 +0200 (CEST)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	by esparsett.troll.no (Postfix) with ESMTP
	id E3570741B1; Tue,  4 Sep 2007 18:32:18 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <Pine.LNX.4.64.0709041547240.28586@racer.site>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57613>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE400888B2133718935050EBB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin wrote:
> On Tue, 4 Sep 2007, Marius Storm-Olsen wrote:
>> Johannes Schindelin wrote:
>>> Bad news.  I do not know if it was the newest version I tried,
>>> but I could no longer fetch... said something about some bad
>>> file.
>> Then you're missing this patch:=20
>> http://repo.or.cz/w/git/mingw/4msysgit.git?a=3Dcommitdiff;h=3Df15974ad=
d93bdfa92775c77c00e7c65aefd42127
>>=20
>> I guess the quickest way is to manually apply this patch and
>> recompile. (or add the '#undef fstat', and have git_fstat just
>> 'return fstat(fd, buf)')
>>=20
>> The problem is that without this patch fstat(0, buf) would fail
>> with bad filedescriptor instead of returning the st_mode =3D S_IFIFO.
>=20
> I guessed as much, but could not fetch the patch, since fetch was
> broken ;-)

Heh, yeah, that's happened to me too before. One neat thing with this
gitweb thingy though, is that you can actually grab the patch, like this
http://repo.or.cz/w/git/mingw/4msysgit.git?a=3Dcommitdiff_plain;h=3Df1597=
4add93bdfa92775c77c00e7c65aefd42127

No excuse! ;-)

--
=2Emarius


--------------enigE400888B2133718935050EBB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFG3YiOKzzXl/njVP8RAnMXAKCLcdpRDleBz+p6UAKE1TgHxIOI4QCeKAW6
5nol+7pChxvCf/Gxvrd8mJo=
=DUu7
-----END PGP SIGNATURE-----

--------------enigE400888B2133718935050EBB--
