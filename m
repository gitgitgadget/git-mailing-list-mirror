From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [RFC] Change handling of RelNotes
Date: Fri, 31 Aug 2007 08:08:02 +0200
Message-ID: <46D7B042.7010807@trolltech.com>
References: <316a20a40708301835hc4236d4tdb289b6f705ab86@mail.gmail.com> <7vejhk5tr0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig091C4BB7F957BF2E5E055AAC"
Cc: Stephen Cuppett <cuppett@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 08:08:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQzgM-000672-2P
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 08:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755920AbXHaGIe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 02:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755598AbXHaGIe
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 02:08:34 -0400
Received: from esparsett.troll.no ([62.70.27.18]:53088 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbXHaGId (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 02:08:33 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id EF9CA74280; Fri, 31 Aug 2007 08:07:59 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id 9E6F974323; Fri, 31 Aug 2007 08:07:59 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <7vejhk5tr0.fsf@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57119>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig091C4BB7F957BF2E5E055AAC
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Junio C Hamano said the following on 31.08.2007 04:21:
> "Stephen Cuppett" <cuppett@gmail.com> writes:
>> I went to clone git onto a memory stick today.  The default fs on
>> the sticks doesn't support symlinks.  After looking a little bit,
>> the only symlink I can see in the source tree is RelNotes.  It
>> appears when going to a new release the file gets created in
>> /Documentation and the symlink updated.
>=20
> Well, I hope you do not compile nor checkout git onto a memory=20
> stick but use it as just a sneakernet medium.
>=20
> If that is the case why should it matter if the contents tracked=20
> has symlinks?

Well, you have the same thing on Windows, of course. Where the first=20
time you try to clone git.git, it reports the RelNotes symlink.
So, at first you think, "Hmm, that just seems broken"; till you=20
discover core.symlinks=3Dfalse, and set that globally, and every thing=20
works.

So, as a Windows user you always have that option set to false; but=20
you have to discover it first. I can see it being a problem on Linux,=20
mounting a memorystick, and then trying to clone git.git to it. Your=20
inclination to discover core.symlinks=3Dfalse is not as high, I guess.=20
And since it's certainly nothing you'd want in your global config, it=20
might take some time before you realize that the correct way of=20
cloning it for a memorystick is in fact:
     git clone -n git://repo.or.cz/git.git

(and if you'd want it checked out too)
     cd git
     git config core.symlinks false
     git checkout


Maybe we should consider having Git detect the underlying FS's=20
capabilities when cloning, and set core.symlinks to the correct value?=20
(You'll have to manually adjust it if you just 'cp' it to another FS,=20
that's as expected.)

^shrug^

--=20
=2Emarius


--------------enig091C4BB7F957BF2E5E055AAC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFG17BCKzzXl/njVP8RAtpZAKCQYCcsNpKf+S8C9TZ3jMqJoGcmrQCg+sEw
olrtMKb+TvxWBPfFWUljkLc=
=Ub4i
-----END PGP SIGNATURE-----

--------------enig091C4BB7F957BF2E5E055AAC--
