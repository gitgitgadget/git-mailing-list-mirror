Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A1125F97E
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 23:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752102877; cv=none; b=CFrgsVVaQblCz7EOlZor2Lgy8XRpqTCZ17B+qq44bU8tWTlF/42rPUpsEq6RrZBYUdRg3ZrIXP3VuJ4MS96nfaqNqBRvVJ9DzHouUbEq7JRPHuYKO69QKFf3VOY4IQa/Fyz69JoCL4MRcppKZALSNJ17ZcbZI+I1xRHNGf2yb7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752102877; c=relaxed/simple;
	bh=Foi+VJFIjYH0oL7N0a9Kp4YGlAMirsK2ahUQzsvU+FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TG0jcPckvPOVQuedVx6ncnO9xTrM5/v8i89qk7HGOBo8j2Dr67Rnk9ZurNHw1R2LW7femZpiCL+/iH67XLXZRaRhZ8veRzwAWDmO0xdOKcxrp/3f+nbZ/aKDJ73nVdnLeYAt7wj9ax5KfhdEluu0SrcXX5H2ObgUQ3Foce2PFkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=yAxHhN8B; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="yAxHhN8B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1752102874;
	bh=Foi+VJFIjYH0oL7N0a9Kp4YGlAMirsK2ahUQzsvU+FI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=yAxHhN8B5BadOIl8r377wT10l+mGyAUgtgm32rLqT0nGB5EkLnVX5osfkikGdZplt
	 vpC3JHWw2RgjxLnrYQAEkrjB+uew57wcbgsLXXv86CB1ZIshCuQOCSJv1phaOqzBCP
	 UXVZHv4EzI+y5BL9ITNKzZ3sZv874/sZkmgvtMtgo4So4ytdd4M1dHK8GMdxg4Sb2+
	 z5nYi/zNtvRp1bzVEW3RxSzZYo5K+PdMyqLtGCnLcamSXoyKC8VzD2FgSXL/Pr+aFS
	 HFWWl9UUBdZxsatApR6uS65vNSvx4FkDAUUXO3ovwT4Ez58WW3XBAcOD/TgnKUb0cA
	 xeAUODUT1dD71alhdtVdOOmA7GXaO3TpUNjqxg5uvRuBZ4JGhXShoLzsCpfF04EtXl
	 T5PWZhxa9oI+doXMcVixiehQROJQMST8RM3PI6PJCiso6v02IohWBHzAPgn+o/q7R1
	 pfufYq0YG0KwXjw8+VW7RvllcHYnxq9Lw2U8J60Nw0Z9XfSd4so
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:828b:3227:a916:b7f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 518BA2018E;
	Wed,  9 Jul 2025 23:14:34 +0000 (UTC)
Date: Wed, 9 Jul 2025 23:14:33 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2025, #02; Mon, 7)
Message-ID: <aG732RLqENitRwlv@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqplebzgm7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IqHFP9MOujTRSShS"
Content-Disposition: inline
In-Reply-To: <xmqqplebzgm7.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--IqHFP9MOujTRSShS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-08 at 00:11:12, Junio C Hamano wrote:
> * bc/use-sha256-by-default-in-3.0 (2025-07-01) 11 commits
>  - Enable SHA-256 by default in breaking changes mode
>  - help: add a build option for default hash
>  - t5300: choose the built-in hash outside of a repo
>  - t4042: choose the built-in hash outside of a repo
>  - t1007: choose the built-in hash outside of a repo
>  - t: default to compile-time default hash if not set
>  - setup: use the default algorithm to initialize repo format
>  - Use legacy hash for legacy formats
>  - builtin: use default hash when outside a repository
>  - hash: add a constant for the legacy hash algorithm
>  - hash: add a constant for the default hash algorithm
>=20
>  Prepare to flip the default hash function to SHA-256.
>=20
>  Will merge to 'next'?
>  source: <20250701212237.766774-1-sandals@crustytoothpaste.net>

Patrick Steinhardt thought this looked fine and I didn't have any
intentions for another round, so I suspect it's ready.

Of course, if people disagree and would like more changes, please say
so.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--IqHFP9MOujTRSShS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaG732AAKCRB8DEliiIei
gapBAP9E+yg+MSuyBLmoN7KQRnopsCl2rkeYfaghlDsSDqnURAD/WyY7KrE7gZAN
Vp2x1wvMgUaxKCCzLA0Iq06ysBgNuAA=
=2Gtj
-----END PGP SIGNATURE-----

--IqHFP9MOujTRSShS--
