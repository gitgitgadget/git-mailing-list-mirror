From: Joey Hess <joey@kitenet.net>
Subject: Re: Git performance results on a large repository
Date: Mon, 6 Feb 2012 11:40:43 -0400
Message-ID: <20120206154043.GA14632@gnu.kitenet.net>
References: <CB5074CF.3AD7A%joshua.redstone@fb.com>
 <CACsJy8DkLCK0ZUKNz_PJazsxjsRbWVVZwjAU5n2EAjJfCYtpoQ@mail.gmail.com>
 <243C23AF01622E49BEA3F28617DBF0AD5912CA85@SC-MBX02-5.TheFacebook.com>
 <CACsJy8Bf95JMp1qOiruR7+Tdi7JN42KNeMqGLud+z3O26DREnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 06 16:41:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuQgh-0003Ih-U7
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 16:41:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755384Ab2BFPkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 10:40:47 -0500
Received: from wren.kitenet.net ([80.68.85.49]:41319 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755356Ab2BFPkq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 10:40:46 -0500
Received: from gnu.kitenet.net (fttu-216-41-255-233.btes.tv [216.41.255.233])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 17A9E11805F
	for <git@vger.kernel.org>; Mon,  6 Feb 2012 10:40:45 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id BA05D49C3E; Mon,  6 Feb 2012 10:40:43 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CACsJy8Bf95JMp1qOiruR7+Tdi7JN42KNeMqGLud+z3O26DREnw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190073>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Nguyen Thai Ngoc Duy wrote:
> The "interface to report which files have changed" is exactly "git
> update-index --[no-]assume-unchanged" is for. Have a look at the man
> page. Basically you can mark every file "unchanged" in the beginning
> and git won't bother lstat() them. What files you change, you have to
> explicitly run "git update-index --no-assume-unchanged" to tell git.
>=20
> Someone on HN suggested making assume-unchanged files read-only to
> avoid 90% accidentally changing a file without telling git. When
> assume-unchanged bit is cleared, the file is made read-write again.

That made me think about using assume-unchanged with git-annex since it
already has read-only files.=20

But, here's what seems a misfeature... If an assume-unstaged file has
modifications and I git add it, nothing happens. To stage a change, I
have to explicitly git update-index --no-assume-unchanged and only then
git add, and then I need to remember to reset the assume-unstaged bit
when I'm done working on that file for now. Compare with running git mv
on the same file, which does stage the move despite assume-unstaged. (So
does git rm.)

--=20
see shy jo

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTy/0eMkQ2SIlEuPHAQj7kw/9G/WFwSXd9fJ/rm03xA8FT3UDsGSuzAcZ
lR6okNWq2VwP8/imWEP2gIE7LZ95G+IfKPIWOWT3TIWzJepBPsn/oveF4BGdVVNN
++jESPbSAF95cbeDbrS+9jaDr1WwgeHVIirX95E9LR4371lyzZSaPbjyfGjSJL2O
oV9uQo8KnCevPBvitCl9mwmZ74WM5bC8/mXwT9GR3LemDYbalAeD12XL+0lHxuOn
RSWYgBtqKeRAsM9SD8MI828jFsF1muJ11i8YBULV6T2TwvuTgH2ZUoFFIuDWnCmP
cL8NSK1cKQ7OuiXhXpczAxfS+QPPe7tg58mTCXx1nfTiDjxubl7a9eOHYW286DDM
L5Yi94usIt5Akvh7G4nTc+EYUetFf15KQD7Li/9n/aspjLsynW/ZvQEfcNoXPm5f
O5gMicBxNpkS9R6I/mn1PRTI9Rhu4bs4oDRNcJgzZ20gnCZiaoKOp5a410qx7lCa
mfYL7Fma/JgrOjI5I3kJlAFRsW9wQGO2HXbUJJrNLhR83n1QUtVmjSr+gGB32JNl
JeBgEPkgYBeQhxYakZ6w8cZqERf9TiMBT365BWRg4iFPJpMeA+iuv9hZBKJqQV8s
Ewx0peNkvc6Q0+do9AHlvYryBIM0Qj8mSKd4GhQOvVPu4dAuSQCzc0QucHvV2L6n
j+4X7Y2y+ik=
=zRTY
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
