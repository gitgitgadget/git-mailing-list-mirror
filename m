From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: git commit -a -m is not working
Date: Sat, 26 Sep 2015 18:54:16 +0000
Message-ID: <20150926185416.GA233088@vauxhall.crustytoothpaste.net>
References: <CAMWrOy7YoAofbzfW+dy=v1TRgWGe5OuZ8U2x+Q-XCKc1y_agRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Cc: git@vger.kernel.org
To: Alex Radulescu <mydesweb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 26 20:54:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zfuc7-00075M-5g
	for gcvg-git-2@plane.gmane.org; Sat, 26 Sep 2015 20:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535AbbIZSyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2015 14:54:23 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47088 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753258AbbIZSyW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Sep 2015 14:54:22 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A16AC28094;
	Sat, 26 Sep 2015 18:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1443293661;
	bh=vUyGymJfZPKpSLWXDhOeOsQ8lzKnXQDFVo610HuW+8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QOVIJHpAsHzs1C5LTRlQwWhDNbaasyDU0meshdNYGh4bt5azwHhF37GU4YQ8iSkBY
	 MJV2meZ4VRpPZvwiYkfYKeyMdcub8kHTv6psfBqDLfoN5aKZEzs7ZaR8Es64sDMwIT
	 ZnTRtwFGKOos6H9ISBWz17qrL8+J9Y/gXrpaPipXFkk45AC9kozfB6jAGfW9X41W2V
	 fvgqzxOMEsiqoisv9UBe012LhRTje1TiKGaCAHFk2501D6wXvh+DQA+0Ij9HMOznl4
	 GF8vEanlDM7+rTKzoyt+GS4rJVEytSHuXiSezI7+oCHvnkkiJYy/vIxTrEUB2u8gjG
	 PfimtLnMtxY6SlXZJRx+B7z9BRyojK5aSIueTueGB1ijJWuiTkuwcE0Xwi5OAlYMnX
	 bKDdCBClE0FfNCcur+hqVVGArgaW93JSDlFtWWNb7FeFNPrNQfD9PDZ7pmxj1j5+aY
	 tHDm1JaoXtFvJHprak85ddc7Sr7aLxhbbcGAB0UKZX2Hje9XOIo
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Alex Radulescu <mydesweb@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CAMWrOy7YoAofbzfW+dy=v1TRgWGe5OuZ8U2x+Q-XCKc1y_agRA@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.1.0-2-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278697>


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2015 at 09:51:12PM +0300, Alex Radulescu wrote:
> Hi,
>=20
> This command is not working. Any advice?
>=20
> Alex:testGit Alex$ git commit -a -m 'made a change'
>=20
> On branch v1.0
>=20
> Untracked files:
>=20
> new_branch.txt
>=20
> nothing added to commit but untracked files present

git commit -a does not add untracked files.  Such files might be build
by-products or such and you haven't told Git to track them, so it
doesn't.

=46rom git-commit(1):
  -a, --all
      Tell the command to automatically stage files that have been
      modified and deleted, but new files you have not told Git about
      are not affected.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.8 (GNU/Linux)

iQIcBAEBCgAGBQJWBunYAAoJEL9TXYEfUvaLMXIQAIiKgJl9W/pB2zOMrMdZEWZN
CGw2t0mjK+bf+DVvjh4sdPBDb0RKGLxcCss7iZFZuCDleUP+Rwy7nlH40kiBDXBc
55/LWNamgnxr/oBRZDbqbaanjx8jH2ZP4NYw0sS6CF0m1AfFFCdMphnx7qUKpJO6
0hxwNrboT31TI85Eh5FK4W3Zp6wrK6zoB1QMVgczPfl0edfVG+nRKbeVyyjDPRbj
tDAmm8NRxktpwlXbk5wAd4MPtNlK4pcm1YEFS/wqiCy0qcp49SHRqKuzlco1o/Vt
0DJ0hGVgai6L1obmWf6ocxwk00vs6l8NDRRS0bxL+EvWdEhmSlZV+fHdBu7FwH2K
jlTPZS4ABmec+tsM/7nF+fRq5pCX24OS4LkPDYdK+9bU9PPWqQBMl3+SPOCI1zaG
szk4R5TpiAIdfwHMN4/WZHnbZExYIpL1xag9OfGGFZe/0gULDDYtJ+XbULAMXsby
IvIB20oxEa9kycwvtBZSdlZNYrmJzN19vqrkYExzRSt3mMVAmxr+3wK03Kb/kuXI
odqf2pzTb2BOUPDAUp5bm+Tp/0zZrhxgS92Dak3hU6XqJFkIMmsSEKe8iCZEXXVE
dTlTqTAg+fZCh/ud4N8wJK9HRlr7l2Eq7B7G8zQZDzbCrobFatN78et/DKx488WF
p78AoYS4YkdrNKqAoWIM
=yTbv
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
