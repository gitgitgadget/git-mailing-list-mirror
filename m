Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ADADDB0
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 19:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="vTZMZmKs"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DB4A2
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 12:16:21 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 4090C5B0C0;
	Wed,  1 Nov 2023 19:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1698866180;
	bh=6IWZGdKcOf3dFpW0mxPR9g9enn6teyBfE60PRx4hVVQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=vTZMZmKsR/mLKKhDOx2NX3WlbFj1Ntfm2CHBR6GiBLZoeMvQ2pQVBYyPYHWj+D+X+
	 Gg/TamudVTOfBa6ANJFEYCj68SjvqxGMslUynsXUgZMLAHb9/XoV8hwjeLG3y9iaOg
	 ef/A+tWL7TFSZumA3FVW/LU3JZd3/WTqJXZ9gldGEk+N6/enREtjgRnmzObtZAunzw
	 inBbwQnBTpNms1IkkX1NTvvgnWYtJrUXFkSOUN3kQ/i2UOnO+LKRl81rW4BmbKIuDY
	 Lm86bu490ntENil0P7mfy3nB9cdFwjXAfjEt1Jv9puA2PCk/5B/Owbhf7ERybMERMN
	 gpZpvwhNtch2c10GpFgD4prB6gQcC1gFZDwElwIMjt7MPRnyQGCe/nfsh1wwOoYHNc
	 mhEV/oHif2P5Sv3eIHmH9ueTkhlUb2PUjpagZiyEi48aG2c+E+Ng8ZABrGaJQdd9MV
	 GEgRTGTTgZHMK6vzdzGYcbGsSzBLgLmIe1LZXFujDN3H5n9Ez7e
Date: Wed, 1 Nov 2023 19:16:18 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/1] merge-file: add an option to process object IDs
Message-ID: <ZUKkAueca1jzrQ5A@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>
References: <20231030162658.567523-2-sandals@crustytoothpaste.net>
 <20231031214859.25293-1-martin.agren@gmail.com>
 <ZUGASkMgoAbe7RjR@tapette.crustytoothpaste.net>
 <xmqqedhaw31d.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VDtpzH0tTq0LaizD"
Content-Disposition: inline
In-Reply-To: <xmqqedhaw31d.fsf@gitster.g>
User-Agent: Mutt/2.2.12 (2023-09-09)


--VDtpzH0tTq0LaizD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-11-01 at 03:44:30, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > This seems reasonable.  Junio, do you want to sneak this in and fix the
> > commit message above, or do you want me to do a v3?
>=20
> As it hasn't hit 'next' on my end, I'd prefer to see a version I can
> blindly apply without having to care all the details of what was
> discussed.  Thanks.

I'll send out a v3 shortly.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--VDtpzH0tTq0LaizD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZUKkAQAKCRB8DEliiIei
gVDOAP9ykUysU7elD97SX8VHdGil1U0Frx+s2+vCl3O2wyB32AD9GbMnLdG+5vUh
yfkXGq0k8AP1VPAFvnU1LU9GGS9/EAc=
=JsOU
-----END PGP SIGNATURE-----

--VDtpzH0tTq0LaizD--
