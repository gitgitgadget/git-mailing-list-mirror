From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Performance on Windows (msysgit) with latest patches
Date: Tue, 14 Aug 2007 11:18:20 +0200
Message-ID: <46C1735C.4050701@trolltech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7DB2230E489CCA30D847F75C"
Cc: msysGit <msysgit@googlegroups.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 14 11:17:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKsWg-0007eQ-U6
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 11:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001AbXHNJRR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 05:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753994AbXHNJRR
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 05:17:17 -0400
Received: from esparsett.troll.no ([62.70.27.18]:57088 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873AbXHNJRP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 05:17:15 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 042D474282; Tue, 14 Aug 2007 11:17:13 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id DFD0B7426F; Tue, 14 Aug 2007 11:17:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55819>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7DB2230E489CCA30D847F75C
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

After all the performance patches that has been commited to the=20
git.git/master branch, I figured it would be interesting to check out=20
how it would affect times on Windows. So, I merged the git.git/master=20
branch into the 4msysgit.git/next branch and ran the scripts which Moe=20
provided. The result you'll find below.

git-status got a 1.6X speed-up, and git-commit on a single file got a=20
2.5X speed-up. However, git-add and git-commit of all 100K files got a=20
slight slowdown.


Before                        After
performance patches           performance patches
-------------------------     -------------------------
Command: git init             Command: git init
-------------------------     -------------------------

real    0m0.031s              real    0m0.032s
user    0m0.031s              user    0m0.015s
sys     0m0.000s              sys     0m0.015s

-------------------------     -------------------------
Command: git add .            Command: git add .
-------------------------     -------------------------

real    0m19.328s             real    0m20.204s
user    0m0.015s              user    0m0.015s
sys     0m0.015s              sys     0m0.000s

-------------------------     -------------------------
Command: git commit -a...     Command: git commit -a...
-------------------------     -------------------------

real    0m30.937s             real    0m31.328s
user    0m0.015s              user    0m0.015s
sys     0m0.015s              sys     0m0.015s

-------------------------     -------------------------
3x Command: git-status        3x Command: git-status
-------------------------     -------------------------

real    0m19.531s             real    0m12.016s
user    0m0.211s              user    0m0.274s
sys     0m0.136s              sys     0m0.091s

real    0m19.532s             real    0m12.016s
user    0m0.259s              user    0m0.242s
sys     0m0.091s              sys     0m0.137s

real    0m19.593s             real    0m12.000s
user    0m0.211s              user    0m0.227s
sys     0m0.152s              sys     0m0.090s

-------------------------     -------------------------
Command: git commit...        Command: git commit...
          (single file)                 (single file)
-------------------------     -------------------------

real    0m36.688s             real    0m14.640s
user    0m0.031s              user    0m0.015s
sys     0m0.000s              sys     0m0.000s

Total time --------------     Total time --------------
Real time:     2m 25.703s     Real time:     1m 42.358s
- User time:   0m  0.031s     - User time:   0m  0.015s
- Kernel time: 0m  0.031s     - Kernel time: 0m  0.078s
=3D Idle time:   2m 25.640s     =3D Idle time:   1m 42.264s
-------------------------     -------------------------

--
=2Emarius



--------------enig7DB2230E489CCA30D847F75C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFGwXNcKzzXl/njVP8RAitXAJ4m1IkrB5PMRXBj0PACEfwObuCCtACfV/55
MM+HassWbOgrlUOl/LGb38Q=
=PcWx
-----END PGP SIGNATURE-----

--------------enig7DB2230E489CCA30D847F75C--
