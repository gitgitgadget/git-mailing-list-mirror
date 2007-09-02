From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and
 make stat use that implementation too.
Date: Sun, 02 Sep 2007 20:44:08 +0200
Message-ID: <46DB0478.8050402@trolltech.com>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com> <200709022016.54262.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig76AEB8F8D16D4EFBB530F76D"
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Sep 02 20:44:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRuQp-0005WS-Ey
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 20:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbXIBSoT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 14:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbXIBSoT
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 14:44:19 -0400
Received: from esparsett.troll.no ([62.70.27.18]:60981 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbXIBSoS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 14:44:18 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 1F9847423A; Sun,  2 Sep 2007 20:44:17 +0200 (CEST)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	by esparsett.troll.no (Postfix) with ESMTP
	id 9660474230; Sun,  2 Sep 2007 20:44:16 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <200709022016.54262.johannes.sixt@telecom.at>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57377>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig76AEB8F8D16D4EFBB530F76D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Johannes Sixt wrote:
> On Sunday 02 September 2007 16:51, Marius Storm-Olsen wrote:
>> This gives us a significant speedup when adding, committing and stat'i=
ng
>> files. (Also, since Windows doesn't really handle symlinks, it's fine =
that
>> stat just uses lstat)
>>
>> Signed-off-by: Marius Storm-Olsen <mstormo_git@storm-olsen.com>
>=20
> Your numbers show an improvement of 50% and more. That is terrific!

Yes, I was surprised myself about the impact. Didn't think it would make
_such_ a difference. And if you compare it to the results we had before
Linus' performance fix too, just checkout the performance improvements
we've had (based on Moe's test script):

    Before                        Now
    -------------------------     -------------------------
    Command: git init             Command: git init
    -------------------------     -------------------------
    real    0m0.031s              real       0m0.078s
    user    0m0.031s              user       0m0.031s
    sys     0m0.000s              sys        0m0.000s
    -------------------------     -------------------------
    Command: git add .            Command: git add .
    -------------------------     -------------------------
    real    0m19.328s             real       0m12.187s
    user    0m0.015s              user       0m0.015s
    sys     0m0.015s              sys        0m0.015s
    -------------------------     -------------------------
    Command: git commit -a...     Command: git commit -a...
    -------------------------     -------------------------
    real    0m30.937s             real       0m17.297s
    user    0m0.015s              user       0m0.015s
    sys     0m0.015s              sys        0m0.015s
    -------------------------     -------------------------
    3x Command: git-status        3x Command: git-status
    -------------------------     -------------------------
    real    0m19.531s             real       0m5.344s
    user    0m0.211s              user       0m0.015s
    sys     0m0.136s              sys        0m0.031s

    real    0m19.532s             real       0m5.390s
    user    0m0.259s              user       0m0.031s
    sys     0m0.091s              sys        0m0.000s

    real    0m19.593s             real       0m5.344s
    user    0m0.211s              user       0m0.015s
    sys     0m0.152s              sys        0m0.016s
    -------------------------     -------------------------
    Command: git commit...        Command: git commit...
             (single file)                 (single file)
    -------------------------     -------------------------
    real    0m36.688s             real       0m7.875s
    user    0m0.031s              user       0m0.015s
    sys     0m0.000s              sys        0m0.000s

> I'll test it out an put the patch into mingw.git. I hope you don't mind=
 if I=20
> also include your analysis and statistics in the commit message. It's w=
orth=20
> keeping around! BTW, which of your email addresses would you like regis=
tered=20
> as author?

Sure, include the stats if you'd like. You can use
mstormo_git@storm-olsen.com for email address.

>> +		ext =3D strrchr(file_name, '.');
>> +		if (ext && (!_stricmp(ext, ".exe") ||
>> +			    !_stricmp(ext, ".com") ||
>> +			    !_stricmp(ext, ".bat") ||
>> +			    !_stricmp(ext, ".cmd")))
>> +			fMode |=3D S_IEXEC;
>> +		}
>=20
> I'm slightly negative about this. For a native Windows project the exec=
utable=20
> bit does not matter, and for a cross-platform project this check is not=
=20
> sufficient, but can even become annoying (think of a file=20
> named 'www.google.com'). So we can just as well spare the few cycles.

Ok, that's fine by me. It was only added for completeness, and with no
benefits I'd say we drop it too.

>> +		buf->st_size =3D fdata.nFileSizeLow; /* Can't use nFileSizeHigh, si=
nce
>> it's not a stat64 */
>=20
> Here's an idea for the future: With this self-made stat() implementatio=
n it=20
> should also be possible to get rid of Windows's native struct stat: Mak=
e a=20
> private definition of it, too, and use all 64 bits.

Yep, that will shave off one assignment, bit-shift and addition. Quick
operations, but still worth while IMO. No point wasting cycles where we
don't have to.

>>  		return 0;
>> +	}
>> +	errno =3D ENOENT;
>=20
> Of course we need a bit more detailed error conditions, most importantl=
y=20
> EACCES should be distinguished.

Right, you want to do that in a second commit?

>> +/* Make git on Windows use git_lstat and git_stat instead of lstat an=
d
>> stat */ +int git_lstat(const char *file_name, struct stat *buf);
>> +int git_stat(const char *file_name, struct stat *buf);
>> +#define lstat(x,y) git_lstat(x,y)
>> +#define stat(x,y) git_stat(x,y)
>=20
> I'd go the short route without git_stat() and
>=20
> #define stat(x,y) git_lstat(x,y)

Please do, thanks.

--
=2Emarius


--------------enig76AEB8F8D16D4EFBB530F76D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFG2wR8KzzXl/njVP8RAsimAJ0Rp2uh1De4rDVbtzs8UBiVApbMFACgpTGM
SU57NNDdagOdQ9wR+ZZn5Xw=
=F0HJ
-----END PGP SIGNATURE-----

--------------enig76AEB8F8D16D4EFBB530F76D--
