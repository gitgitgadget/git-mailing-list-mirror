Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125813793CC
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 23:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791244783; cv=none; b=dR7HiBQzfR9o71LIosKzJugrjBOMINSNADMliM4ZIMlGT9XSYcuy/+b+V4H6kNNdyWTfTNhH7D+hV6f1quAurJ/kDXDv+eU2mfvlQMy/d7W2mx6u8boM7EM/2zWwunTJekFl0pNmiIYQNo8rsWcDHQxxwetJ8ltMZOS4GB5KMus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791244783; c=relaxed/simple;
	bh=r5+O5WXZE0EXvuo2Hb3rhs+3Elisn+QquMSubq0cdRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gm+2t3ORWHNd1VDeCM1bYM7FyPgSuIWbjAn4z0epSfTw75ESPqHziGdq6RCpOyRly0JCEC4lq7hWT+8B0ncjqzHTL91SE9hbJSOSJ76331kHOuWMwnnmHDg++DbHkBuGDKMMUbwZbERV7GiAQsTAG9BbXLn4dAfrrkbAzyL/9aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=XQP1FUdp; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="XQP1FUdp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1791244780;
	bh=r5+O5WXZE0EXvuo2Hb3rhs+3Elisn+QquMSubq0cdRA=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=XQP1FUdpyb4+5L2q0Z0QoDhJFEFxjIdDu11owLthGxsszmJF/gzMwUvgmPoIZA1aC
	 UK2N00fZK31WODmuFMtZp6De8Fy7/k/rSwJnGhhVFMr9PceEWAAIt/Y2vphpPtKwGk
	 E+kP4dJyL35PGPphsQ/roh/L+UaXvSdR9r+f4VZPcEE23lel0XvR8f7VTdS5PhYWJv
	 WaX7nHuCbQqUath+pxljIZM0GRJsi5N7S9u1qkVmoIh0+JWn+yCyTpoCjZNWE2kZ8V
	 88UUPbSH4T3HWesBgQiGbbNcRZE7x6h8wNc6OMhSYzDuKV70mnNXXdKQKkhXbDXAbt
	 Z7eWrSgPdz8qxxjw5ahc3YKqIlog5iRptjkloOgY3MZP1J8dVIJaW/rBKVE6Jcxhep
	 7RN+OYPz7jVX0YnjGhsDPU+o5mK3xSzrPA0H+IWUcKDCTu5JIG/3MTR2vDLOEY3Iv1
	 Xr8cgxy6rCCrV3gBo6ehSZpmQwN7ICiN18G81peGA0tsAVzNAW/
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:3b5f:558:e3d6:2c05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 99C9220077;
	Mon,  5 Oct 2026 23:59:40 +0000 (UTC)
Date: Mon, 5 Oct 2026 23:59:39 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org, Francisco Boni <boboniboni@gmail.com>
Subject: Re: [PATCH] doc: add more examples of overriding LESS in core.pager
Message-ID: <asQ56mv3VbiYmtwk@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org,
	Francisco Boni <boboniboni@gmail.com>
References: <20260919163725.TExDduTp@teonanacatl.net>
 <20261002234203.4064847-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xMxLsw8TN6wHlgC1"
Content-Disposition: inline
In-Reply-To: <20261002234203.4064847-1-tmz@pobox.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--xMxLsw8TN6wHlgC1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-10-02 at 23:41:52, Todd Zullinger wrote:
> +Another way to deactivate an option is prefixing `core.pager` with
> +`LESS=3D"RX"` to remove `-F` or `LESS=3D""` to override all options.
> +This is useful if the `core.pager` command eventually runs `less` or
> +a command which respects the `LESS` environment variable but lacks
> +command line options to override `LESS` options.
> ++
> +One can specifically activate some flags for particular commands: for
> +example, setting `pager.blame` to `less -S` enables line truncation
> +only for `git blame`.

Sure, this seems like an improvement.  I'm not very particular on the
wording, but it's good that folks have the information that they need.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--xMxLsw8TN6wHlgC1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmrEOeoJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZzP54cZA4llzX6Vn3+GyZLOrZO7jWLZWmI77JPmlvy89
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAEZnAQCMhxLIit25LXV1pXzeudAH8fbj
5hnZNaBwgVg94+CO5AD/Zzo06x7HJwuGtf5NDN0qmJX9PwHDcA2SnFt92vXIpgo=
=FNw0
-----END PGP SIGNATURE-----

--xMxLsw8TN6wHlgC1--
