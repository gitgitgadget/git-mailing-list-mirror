Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C81285C8A
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 21:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759785037; cv=none; b=p3VWOvJ+VK47PAg2iQyplJu1+IKAEZ5Ui6fHpX6IEnlVF/wNxLOuuXgxeIxDwnxcgntyJWi94Zmvw4B74B+n+YOhrjmc2Wt4xNDstN+f3iogNxGtVlKeyBJeqSL9fMHK0Hdyu9VEQCnvKEYysemXtsBFC9isdZfbjIGRAqw2oMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759785037; c=relaxed/simple;
	bh=ux9Mfl/AwAJC16M0PGQZmLwO0WDtoYw7EmG8vrVc6L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmeLAV0ls/zdX3FYAYXYFusCPyB15CHe6sotHbp/9H2CHr9STCjoC0jsbutKuITob5qjiOrWq6jNQxYePeA0fkAXezbv3BHjNfXfY7lKNKnkAWDRktZvDVkK2PJGbYoa8XwDSvPtPpjunAuuVdPac5/kBuuEBQxUbYxMOyGuhic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=TNIuVC7G; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="TNIuVC7G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1759785027;
	bh=ux9Mfl/AwAJC16M0PGQZmLwO0WDtoYw7EmG8vrVc6L4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=TNIuVC7GmDMm7DpQlhWL575bkfZmlRkAyip/XQMf2dpkK+XhhW+NuCB8CvSWy388y
	 8VUvzqbsmxmfK3Vx6Bv3AK2pN8zyhUMcujkAaR9RQSFrtPg3DtucJwIvjGvsHLUNw1
	 SfvfKTccQ0YI2GDjwiYrJq8Bs28zAu6246N0rOXkJlSo7U9fpz9WxeY1losatZZ0BF
	 8Dkb4ZDGv5z36OOOnsu82U+Ys78gtYtmDuFMK9kp/8OnBe7Ru3Ca333055nlNpdERD
	 V9ne4IYTCt/nAPcuIRUYijj8B4H9k+4Ittvn3kf8DfqyV1XahXyKeH4dOFCG/Zr7vx
	 Qe13A19igxAEVFptpJKwYLXgF218QTpR76JnLRElik1IteY7+9UFpwpSCQvfbQ2UQk
	 guRra6t64jbZGgY+U51/wZVwFrFXUrwoqm9W1YaX2KbiAwnRv7vCWjcrC1HhqP3WIp
	 fb9xsozUGp3LVq/a23G1L7y5j1AlNVyTFZqZuPUU/1oCyn+pRJG
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:1cc7:db20:f4a5:abef])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B5FFB200C6;
	Mon,  6 Oct 2025 21:10:27 +0000 (UTC)
Date: Mon, 6 Oct 2025 21:10:26 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH] doc: do not break sentences into "lego" pieces
Message-ID: <aOQwQq0KJBLlda0m@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
References: <pull.1982.git.1759698724134.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Wu7ZaR2Lu5DPrVh/"
Content-Disposition: inline
In-Reply-To: <pull.1982.git.1759698724134.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Wu7ZaR2Lu5DPrVh/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-05 at 21:12:04, Jean-No=C3=ABl Avila via GitGitGadget wrote:
> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>=20
> The sentence needs to be whole to be properly translated.

This patch seems reasonable and I agree this is the right thing to do to
make the documentation more easily translatable (as well as generally
more legible).
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--Wu7ZaR2Lu5DPrVh/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaOQwQQAKCRB8DEliiIei
gd9CAQCA8X+cOD3fDvfbsZEpKn5BjqOcaVuCH78Dkjl3qBiaxAD/UFpZMZLetX2L
OUefKH1nEu6qJxSAD6XfsUw9S4m2Ng0=
=Sy3I
-----END PGP SIGNATURE-----

--Wu7ZaR2Lu5DPrVh/--
