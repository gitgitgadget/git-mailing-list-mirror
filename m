Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB618390209
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 12:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772801938; cv=none; b=auG8dTbM1pPdwCTtPQw6lL2hljZ/dHTTJ1ZFo5kpMLccnFjWCD7E0aDLYk37jN17Uodn6rfY1fQa3PTtDk8jl0OoZabisMsbhNiC4jGf+Nwprem90aCWICAVxKz7sDSsr+LmBMTeFfh0BdzEz4ijfUt6PFp8qnZR4FVLNFSc6fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772801938; c=relaxed/simple;
	bh=icrZwyhn7Mo2861teiWhfo7Ed/l8Y9V4uLgQPprdy/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nv0986X9N9sY41zu7CR7fkjRVUhZJi3sFllfqHfqQ1WFM3NPUlp0GRHUpcakfQbhxSI9a8KmV7tQPKoW25BlmP3usxbqmD4Ak1/WJTl77319Dhp4Cjtc7ODTni/7fO8hkRwqYmIWKo57QEEcyzFrQ/Gjf5uUjF7JkQcWdzIHyV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=LbHhRzAw; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="LbHhRzAw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1772801936;
	bh=icrZwyhn7Mo2861teiWhfo7Ed/l8Y9V4uLgQPprdy/s=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=LbHhRzAw1NSPlf/Eb29ShuXO1oWd/FlFTalHQotyuiLIBAf8/fgOGzaARSO1/R/bH
	 BsVDaJz88HYS1tm8s4AFmfLWAA+EqtqGpHk7qlUaSzTshCb0QgU6ebK2ehE43wm6gr
	 U2aPZq2NRs5s3c1OvpJC/8n4O6EkRQRk212xlksZIbjORs72pOHV7cpckTLZZH0vhu
	 d8SeGEOzpSSNiOUTqyoA4x+ESas+N23akuewg/2neIA9rJoYBY2S6tQgQxRnzHN2B0
	 wrw4vH3mkd5Kq7QpDCfysd9G5zijuF+1fT7fz54V6MXRbv+mctbiOIr/vTrvl/L5f1
	 0mYk41V2ZmJw4BpzyIun1uxaEauG/xHfZulTxhZfd3zFzgyStZkDfC6yBLs8gkgVry
	 VeIHfhisQOYlGd+88frpcVCnmTbcCNcFmNgWx1jt/SnYiRzzCvKvKQnCkip1hDz/DE
	 oM67GXPKbrYrpvZVu7BWSpm6LzvkxAdNrL1JEzEPF1VGLq+B3G5
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:941e:963:e525:3a6c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 1424B20112;
	Fri,  6 Mar 2026 12:58:56 +0000 (UTC)
Date: Fri, 6 Mar 2026 12:58:54 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH] Documentation: extend guidance for submitting patches
Message-ID: <aarPjlYv0H10rNKJ@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org, ps@pks.im
References: <20260305193836.973122-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mt/NbzfiuhPOiArl"
Content-Disposition: inline
In-Reply-To: <20260305193836.973122-1-jltobler@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--mt/NbzfiuhPOiArl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-03-05 at 19:38:36, Justin Tobler wrote:
> +It is also a good idea to check whether your topic has been discussed
> +previously on the mailing list, or whether similar work is already in
> +progress.  Prior discussions may contain useful context, design
> +considerations, or earlier attempts at solving the same problem. Being
> +aware of such discussions can help you avoid duplicating work and may
> +allow you to coordinate with other contributors working in the same
> +area.

This seems reasonable.  We've had cases of patch series that have
stalled due to a minor issue and someone wanting to send a patch may
find that they really could fix that minor issue on top of the existing
patch and have their problem solved.  Or at least, they might be
inclined to not get stuck in the same way.

I try to do this anyway, but it's much easier on forge-style systems
than it is on a mailing list, so mentioning it may help refresh people's
memories.

You could, if you wanted to, link to `{gitml}` after the phrase =E2=80=9Cthe
mailing list,=E2=80=9D which might help folks find the right location.  Or =
you
could link to the https://lore.kernel.org/git/ archives instead via a
footnote.

> +It is often beneficial to allow some time for reviewers to provide
> +feedback before sending a new version, rather than sending an updated
> +series immediately after receiving a review. This helps collect broader
> +input and avoids unnecessary churn from many rapid iterations.

I think this is a good idea, too.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--mt/NbzfiuhPOiArl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaarPjgAKCRB8DEliiIei
gXL6AP4xv2UCqL8ckPgYthDwjNqqjHyRr6nVLdaLHsvCJRvvOgD9GbFohloYNkRn
8PWAiTqYPV+n/sM4D/7L01T2AA6UZwU=
=Fd5S
-----END PGP SIGNATURE-----

--mt/NbzfiuhPOiArl--
