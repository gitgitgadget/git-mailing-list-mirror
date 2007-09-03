From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and
 make stat use that implementation too.
Date: Mon, 03 Sep 2007 08:12:56 +0200
Message-ID: <46DBA5E8.105@trolltech.com>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com> <200709022016.54262.johannes.sixt@telecom.at> <46DB0478.8050402@trolltech.com> <46DB0F9C.2090306@trolltech.com> <20070902214128.GC2756@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8E741EFDFD999FEE11E461FA"
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 08:13:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS5BQ-0002xI-9m
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 08:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287AbXICGM6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 02:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753338AbXICGM5
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 02:12:57 -0400
Received: from esparsett.troll.no ([62.70.27.18]:47834 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312AbXICGMu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 02:12:50 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 9819F741B6; Mon,  3 Sep 2007 08:12:48 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id 8AE49741B3; Mon,  3 Sep 2007 08:12:48 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <20070902214128.GC2756@steel.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57430>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8E741EFDFD999FEE11E461FA
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Alex Riesen said the following on 02.09.2007 23:41:
> Marius Storm-Olsen, Sun, Sep 02, 2007 21:31:40 +0200:
>> +		buf->st_ino =3D 0;
>=20
> You sure about that? Ever wondered why it is not so on everywhere else?=


Pretty sure. If you look at Windows' native version of stat, it will
return you st_ino =3D 0. Or maybe you where referring to something else,
and I just missed your point?

AFAIK, the ino in the index is only to be _really_ sure that nothing
has changed with the file, and we can just skip it on Windows. If in
doubt, try running this on your Windows box:

#include <windows.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>

int main(int, char **)
{
    wchar_t DirSpec[] =3D L".\\*";
    WIN32_FIND_DATA FindFileData;
    HANDLE hFind =3D FindFirstFile(DirSpec, &FindFileData);
    if (hFind =3D=3D INVALID_HANDLE_VALUE) {
        printf ("Crap happened: %u\n", GetLastError());
        return -1;
    }=20

    struct _stat buf;
    while (FindNextFile(hFind, &FindFileData) !=3D 0)=20
    {
        if (!_wstat(FindFileData.cFileName, &buf))
            printf("file: %S, ino: %u\n", FindFileData.cFileName, buf.st_=
ino);
    }

    FindClose(hFind);
    return 0;
}



--=20
=2Emarius


--------------enig8E741EFDFD999FEE11E461FA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFG26XoKzzXl/njVP8RAr3XAKClasbJ7WdlQLlbmGiHkTLPaMww9wCfbmzb
8qbFaNhKfCmn8PTZ7xurzXk=
=6rZY
-----END PGP SIGNATURE-----

--------------enig8E741EFDFD999FEE11E461FA--
