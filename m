From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile
 git)
Date: Fri, 03 Aug 2007 15:11:29 +0200
Message-ID: <46B32981.9040904@trolltech.com>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site>  <460B6BF8541C4D9B916F02A12E0576F5@ntdev.corp.microsoft.com>  <46B2D4D9.4020103@trolltech.com> <a1bbc6950708030258h16a6514kf5c637af13874fb7@mail.gmail.com> <Pine.LNX.4.64.0708031243330.14781@racer.site> <Pine.LNX.4.64.0708031347160.14781@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig325D9CCAEC324A7702DDC8C1"
Cc: Dmitry Kakurin <dmitry.kakurin@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 03 15:10:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGwvT-00057p-EO
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 15:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbXHCNKk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 09:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757636AbXHCNKk
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 09:10:40 -0400
Received: from esparsett.troll.no ([62.70.27.18]:52721 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757236AbXHCNKj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 09:10:39 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 6D620741F4; Fri,  3 Aug 2007 15:10:38 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id 232E6741F1; Fri,  3 Aug 2007 15:10:38 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <Pine.LNX.4.64.0708031347160.14781@racer.site>
X-Enigmail-Version: 0.95.2
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54722>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig325D9CCAEC324A7702DDC8C1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

>> Completely forgot: we might want to do something like this at the end =
of=20
>> /etc/profile:
>>
>> 	test ! -d /git || {
>> 		mv /git $HOME/ &&
>> 		cd $HOME/git &&
>> 		make install &&
>> 		git config remote.origin.url \
>> 			git://repo.or.cz/git/mingw.git
>> 		git config remote.origin.fetch \
>> 			'+refs/heads/*:refs/remotes/origin/*'
>> 		git config remote.mob.url \
>> 			repo.or.cz:/srv/git/git/mingw.git
>> 		git config remote.mob.fetch \
>> 			+refs/remote/mob:refs/remotes/origin/mob
>> 		git config remote.mob.push \
>> 			master:mob
>> 		git fetch
>> 		git reset 51785010a4d3e7f6c3
>> 	}
>>
>> Please test that, and include it if it works.

Hmmm, I have trouble 'parsing' this.
You meant
     test ! -d $HOME/git ||
right?

But, given that he removed the initial git sources, the script won't=20
work. He left the git executables to be able to check a new Git out,=20
if I understand correctly.

--=20
=2Emarius


--------------enig325D9CCAEC324A7702DDC8C1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFGsymBKzzXl/njVP8RAmGWAKDQJ0gMsdN1mQMzMCVeMZz60md30ACffD84
raybcnkO5ibR/hOZjrYRJRE=
=upqg
-----END PGP SIGNATURE-----

--------------enig325D9CCAEC324A7702DDC8C1--
