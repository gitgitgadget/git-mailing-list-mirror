From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: Removing options from build
Date: Tue, 13 Jan 2009 16:34:31 -0600
Message-ID: <200901131634.31389.bss@iguanasuicide.net>
References: <1231883002.14181.27.camel@starfruit> <200901131606.04634.bss@iguanasuicide.net> <1231885132.14181.38.camel@starfruit>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4738031.yv6U1EUt0m";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 23:35:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMrr3-0002sN-Ez
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 23:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678AbZAMWdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 17:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754146AbZAMWdt
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 17:33:49 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:53964 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677AbZAMWds (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 17:33:48 -0500
Received: from [206.104.163.94]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LMrpT-0000jf-Ex; Tue, 13 Jan 2009 22:33:47 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <1231885132.14181.38.camel@starfruit>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105553>

--nextPart4738031.yv6U1EUt0m
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 2009 January 13 16:18:52 R. Tyler Ballance wrote:
>On Tue, 2009-01-13 at 16:06 -0600, Boyd Stephen Smith Jr. wrote:
>> receive.denyNonFastForwards
>>         If set to true, git-receive-pack will deny a ref update which
>>         is not a fast forward. Use this to prevent such an update via a
>>         push, even if that push is forced.
>
>Looks good, thanks; sorry I missed it, didn't even think to look at the
>git-config(1) page for such an option.

I didn't really know about it until earlier this week.  I was expecting to =
be=20
able to do a non-ff push to one of my repositories and it didn't work becau=
se=20
this was set "behind my back".  (I'm not sure when it got added, but I don'=
t=20
think the shared repositories I set up with git 1.4.4.4 had it, so I wasn't=
=20
expecting it.)

>I'm assuming this will actually cover the rebase -i case as well?

I don't know exactly what you mean.  It prevents fast-forwards, so once a=20
commit is "visible" on one of your central branches, it won't ever go away.=
 =20
(You can, of course, use git revert to undo it's changes.)

As others mentioned, now would be a good time to look at receive.denyDelete=
s=20
and/or a custom hook as well.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart4738031.yv6U1EUt0m
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkltFvcACgkQdNbfk+86fC12LQCfRb+TnG7vY9ZcCck6YQqjdi7T
RoYAn2zk9xzWbijcySNhgzG8yI+Co6xn
=QgSN
-----END PGP SIGNATURE-----

--nextPart4738031.yv6U1EUt0m--
