From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Tue, 04 Sep 2007 13:21:45 +0200
Message-ID: <46DD3FC9.2020706@trolltech.com>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com> <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com> <Pine.LNX.4.64.0709031428080.28586@racer.site> <46DC5ED4.8050202@trolltech.com> <46DD0C16.70101@eudaptics.com> <46DD3153.8060805@trolltech.com> <46DD3943.8040403@eudaptics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig84E6A08395645222D67DB052"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 13:21:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISWTl-0002Dq-0e
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 13:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368AbXIDLVi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 07:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753092AbXIDLVi
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 07:21:38 -0400
Received: from esparsett.troll.no ([62.70.27.18]:34152 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368AbXIDLVh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 07:21:37 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id A1306741D8; Tue,  4 Sep 2007 13:21:35 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id 8B27E741CF; Tue,  4 Sep 2007 13:21:35 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <46DD3943.8040403@eudaptics.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57552>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig84E6A08395645222D67DB052
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Sixt said the following on 04.09.2007 12:53:
> Marius Storm-Olsen schrieb:
>> Johannes Sixt said the following on 04.09.2007 09:41:
>>> Thanks a lot! I've pushed it out in mingw.git's master.
>> Ops, already in master branch?
>=20
> Yes, it looked so polished ;)
>=20
>> http://repo.or.cz/w/git/mingw/4msysgit.git?a=3Dcommitdiff;h=3Df15974ad=
d93bdfa92775c77c00e7c65aefd42127=20
>=20
> Looks good, although you should now handle INVALID_HANDLE_VALUE at the =

> beginning of git_fstat() like this:
>=20
> 	HANDLE fh =3D (HANDLE)_get_osfhandle(fd);
> 	if (fh =3D=3D INVALID_HANDLE_VALUE)
> 		return -1;	/* errno has been set */
>=20
> 	if (GetFileInformationByHandle(...

Actually, that's already handled.
GetFileType will report FILE_TYPE_UNKNOWN (0), and GetLastError() will=20
return a result !=3D NO_ERROR (<-- so you can follow the codepath, but=20
it actually returns ERROR_INVALID_HANDLE (6))
So, it will fall all the way through the function, and end up=20
returning -1, with errno =3D EBADF.

(I use the
     case FILE_TYPE_UNKNOWN:
         if (GetLastError() !=3D NO_ERROR)
             break;
construct, since the documentation says that an FILE_TYPE_UNKNOWN is=20
still a _valid_ handle iff GetLastError() returns NO_ERROR. So, then=20
we pass it on to the normal fstat function to let that figure out what=20
we're dealing with)


>> Ok, I can give it a performance test, but I tend to agree with David=20
>> Kastrup there. It would be better if we rather fix the places where we=
=20
>> check with the local timestamp instead; depending of course on how man=
y=20
>> places we actually do this.
>> We'll see how much the timezone conversion in the custom stat function=
s=20
>> actually hurt us performance wise.
>=20
> I'd make the decision on the grounds of a perfomance test. If it turns =
out=20
> that the penalty is bearable, we should keep this stuff private to the =
MinGW=20
> build. Otherwise, we would need MinGW specific code at the call sites=20
> (unless we can hide the opposite conversion in some other wrapper funct=
ion).
>=20
> ... time passes ...
>=20
> Ok, I just tested FileTimeToLocalFileTime() in a tight loop, and I can =
run=20
> it 100,000,000 times per second. So I'm confident that there won't be a=
ny=20
> noticable degradation with my proposed change.

Ok. I haven't done the performance test with Git yet, but we'll see.=20
If it's not noticeable, I'll add it to all the timestamps we have.

--=20
=2Emarius


--------------enig84E6A08395645222D67DB052
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFG3T/JKzzXl/njVP8RApETAKC5imI52FbSiAz0mOwkkTKgZyPZQgCfR5sh
i6p/N5gneb0Fx+Rtl1HHNng=
=Rxfc
-----END PGP SIGNATURE-----

--------------enig84E6A08395645222D67DB052--
