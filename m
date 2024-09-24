Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BE6146D76
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 22:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727216895; cv=none; b=Fg/k6YZHZl5Li5iNQ0mmUKJtyqWNWh5o/439siVrA84w8Wdo52kS5Db4RWCRiUl1+9PsePxgkBpiJbc0/FIy+l/ssJ1sAAV05wNGpbBl6IgQyAoBD3YQFWP10eQVM1JRpQzaPUZhqK4GHLd5vZ27vLSIPd0PC1FyrIw7tJAt5SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727216895; c=relaxed/simple;
	bh=LRC1Wa2ql8iyGm0yLOnhOLllh0ZknH704V+USmxyp/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oolj/TdQ9tiVi+nA6sKXoorpy7yenWuRGLuJ0ntt2lo2dL6M/C+RzpBMwltZp38BR7QBD+h/50YXDXOS88qsUzSKmBZkK1z4Rl1LElYZD6Ay21dn6Sxa9SMxOSUHCsF3+1P07ph6vX1ldkAxWgQdiYued7OlcSLxRAu4Ozivd7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=yyq11AJc; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="yyq11AJc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1727216892;
	bh=LRC1Wa2ql8iyGm0yLOnhOLllh0ZknH704V+USmxyp/M=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=yyq11AJcG5wp68kwf5xyLQz7LdnY2wRammdjBeuELABbXEq+K7CrWr8Q5iX0NlOx8
	 d1UDm7mlS1UK+oI4e7fj7pHwmid6CC3QuRHxLdAAk8TaanoguVsGvs8UyvlVxKL/qU
	 N9wFf5QMhC68dq5Neol/Bf5Kr1C87vEzi37ORsKYQb6RlD4RIwJqfve8+l7R7MIdcx
	 BuiFNVTHjdSwWO/1F6ApXN40rhjJxZ5Y8lSb6ImNOkoDR066JmN7cUQKEDQXIPyK3d
	 nQKKd6edNNn43uM7kiySyAY81AsjHylKp73QwAuLvYddbdADde5YWaTMwRIllkgEom
	 wW4mJhp5Wdxz23AQa0GwZj3QcpfMASCCzYLcvaKGFoTZpiYAo73LrGWY3Ku4yZkt0T
	 YKzCtQ+PxKosjI0v/5B/aQcDlYNkrEcd8k7+Gycxekg5rnZCsBKAkI3NNRBNGScTYt
	 MHp9MzfVzW3hUbfZcg4EcyUJ1oKMR4++J0aOl2Uat17uL3IKQFl
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4A04620073;
	Tue, 24 Sep 2024 22:28:12 +0000 (UTC)
Date: Tue, 24 Sep 2024 22:28:11 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, Matt Burke <spraints@gmail.com>,
	Victoria Dye <vdye@github.com>,
	Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Todd Zullinger <tmz@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: git-scm.com is now a static website
Message-ID: <ZvM8-z-0QD9OEs4R@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Matt Burke <spraints@gmail.com>,
	Victoria Dye <vdye@github.com>,
	Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Todd Zullinger <tmz@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>
References: <c3e372f6-3035-9e6b-f464-f1feceacaa4b@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YUq58WBLhP60dpDc"
Content-Disposition: inline
In-Reply-To: <c3e372f6-3035-9e6b-f464-f1feceacaa4b@gmx.de>
User-Agent: Mutt/2.2.13 (2024-03-09)


--YUq58WBLhP60dpDc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-24 at 22:07:05, Johannes Schindelin wrote:
> Hi all,
>=20
> almost 400 weeks after Matt Burke started the process with
> https://github.com/spraints/git-scm.com/commit/60af4ed3bc60 of migrating
> Git's home page away from being a Rails app to being a static website that
> is hosted on GitHub pages instead, today marks the day when Git's home
> page at https://git-scm.com/ has finally moved. Or actually: yesterday
> (because I took so long writing this email that I ended up sending it
> after midnight).

This is great news, and I appreciate everyone's contributions here.  As
I said at the contributor summit, it's fantastic to see that we've
managed to preserve all the links, including the page fragments, which I
really appreciate since I've been trying to link the Git FAQ from
everywhere on the Internet.

Thanks again for all your work.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--YUq58WBLhP60dpDc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZvM8+gAKCRB8DEliiIei
gby2AP9R+G2p3DQ3xaAf0fOrMHJhK2UFzsj+nFbUr930igzQrgD8C05+3HO3LUeM
+yG2i/ldM+W6Uzp3chrvFHNUfTrIygQ=
=QbCv
-----END PGP SIGNATURE-----

--YUq58WBLhP60dpDc--
