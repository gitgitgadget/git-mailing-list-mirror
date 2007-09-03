From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Mon, 03 Sep 2007 14:38:55 +0200
Message-ID: <46DC005F.70200@trolltech.com>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com> <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCE3946279877F51A04A745C8"
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Johannes Sixt <j.sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 14:39:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISBCg-0004fx-00
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 14:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150AbXICMit (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 08:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752491AbXICMit
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 08:38:49 -0400
Received: from esparsett.troll.no ([62.70.27.18]:37566 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129AbXICMis (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 08:38:48 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 3C8B0741B4; Mon,  3 Sep 2007 14:38:47 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id 22BA3741B3; Mon,  3 Sep 2007 14:38:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <46DBFA2A.7050003@trolltech.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57480>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCE3946279877F51A04A745C8
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Marius Storm-Olsen said the following on 03.09.2007 14:12:
>  With the our own implementations of lstat & fstat, the following test =
cases
>  are now fixed:
>      t4116-apply-reverte.sh
>          ok 3: apply in reverse
>      t4200-rerere.sh
>          ok 17: young records still live
>  However, the following test cases seems to fail now:
>      t6024-recursive-merge.sh
>          FAIL 1: setup tests
>          FAIL 3: result contains a conflict
>          FAIL 4: virtual trees were processed
>          FAIL 5: refuse to merge binaries
> =20
>  See attached test case logs.

How about that, reading the diff backwards :-)
Oh well, you see the issues based on the logs. Would be nice if you=20
guys could also give the testcases a run to see if you get the same=20
result.

--=20
=2Emarius


--------------enigCE3946279877F51A04A745C8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFG3ABfKzzXl/njVP8RAiLMAKCfzH2gLLhWVOlEYK9cnYF+gN7BMgCcCIgW
ZPOFlYY0DWEqzWk5lDnS/08=
=OBnD
-----END PGP SIGNATURE-----

--------------enigCE3946279877F51A04A745C8--
