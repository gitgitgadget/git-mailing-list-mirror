From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: git rebase is confused about commits w/o textual changes (e.g.
 chmod's)
Date: Fri, 4 Oct 2013 20:28:54 +0000
Message-ID: <20131004202853.GB4165@vauxhall.crustytoothpaste.net>
References: <20130924225648.48af3f4e@x34f>
 <20130927222807.GA18384@vauxhall.crustytoothpaste.net>
 <20130928023244.1ce16dc5@x34f>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Cc: git@vger.kernel.org
To: Paul Sokolovsky <pmiscml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 04 22:29:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VSBzm-0001zk-Ri
	for gcvg-git-2@plane.gmane.org; Fri, 04 Oct 2013 22:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595Ab3JDU3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Oct 2013 16:29:01 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:60762 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753184Ab3JDU3A (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Oct 2013 16:29:00 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 5C7C52807C;
	Fri,  4 Oct 2013 20:28:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20130928023244.1ce16dc5@x34f>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-rc7-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235717>


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 28, 2013 at 02:32:44AM +0300, Paul Sokolovsky wrote:
> $ git --version
> git version 1.8.4
>=20
> Specifically from Ubuntu PPA:
> http://ppa.launchpad.net/git-core/ppa/ubuntu
>=20
>=20
> Script to reproduce the issue is:
> https://gist.github.com/pfalcon/6736632 , based on a real-world case of
> merging histories of a fork created from a flat tree snapshot with
> the original project it was created from.

Okay, as I suspected, the rebase would have resulted in an empty commit.
In this particular case, the commit being rebased changed the permissions
on the files, but those permissions are already correct, so the commit
really is empty, even considering permissions.  It looks like git is
doing the right thing here.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJSTyUFAAoJEL9TXYEfUvaL9AoQAJWssKlAs1d6fGO5f9UUPEj5
WgwpxqtaoVLFnaEeFLcKxPsZ7UQmd40Dq73NonjFpl7XxhcWCdrYWk3pnfehhNyy
u3teXU2/9lOyqln8sLnbqgIZ4RC21BVeQVlWWdM2a21vJ6LV+NTAU72UzQE4Hpwz
dEC1uaoYkzTzYXRFp/vp7B3JbrSoGt9FVCv8/umYAyagoJ6mHdluRFDq+RanMAS/
4jjaQzsh18qpOC7AXIPkF2sCCPFB0fGRsYDwfKlfkVt0NghFX5gRBgFFxz3qA2qK
bK1KLNgLzuF/nBURouJQjMoiFVfK99Z4C6okQF2prx7tHh4fJzL+yWICULjIJTx+
4KyUtOeLitVPT+5s6Ma+NhnOTkkBeHJ+2ErFoB37QGBZU6E3ytTPd3ag97+IhI2+
ZsNKWT+UU1dMbUIyXhIHqbqVcZLsbwc8xhSExD43g9Mx9C9dSBr9E5YXMBsDxILJ
SFrXaw65e31xK7lCpPRFpXGFjCFLl4ebdmbOO5PKW+Zpr7R0jpB1p+N4JWOV7ro/
wYm0lvHo9/gHsZpUNkt3zdqfeEC42nqpXSNQCd6qErDGWQsF5KIvCunyhVeR0DDn
aXRpsPW6LTofxwG50ORW5ru25EAekOK5+S4ImSxDBk/m9ZluCdAbgH5fmGfa2+5x
tgho3Y1PBiyrUiJx0rKc
=KKdZ
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
