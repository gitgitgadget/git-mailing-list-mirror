Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23A110E3
	for <git@vger.kernel.org>; Sun, 24 Nov 2024 18:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732471990; cv=none; b=iDZ8A/P6TDx/9oS5V+zLZZyLd2sKnaH463020qhD5aPoCJ6n37QBKIidYf3MFqhhLEiPatw8TKBXKoUHLoCVBEwGvwsm0AyBbnYx4mK4OgDu1Vbq59lNtKTUhRRwp9nscCHR/96W7+khnpahCafLdFhATBEF/vDsQVS0oP3ux0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732471990; c=relaxed/simple;
	bh=uZEOgDV2o6u5NoksGtqz+6B3KG7pCk1UwoHyqXrjROo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoApTZEImrBNx9nGMxbfOxY1iQIyoPBFBJAt8yGYoBHShPDnu6eD1g22tgO0dFlsZu8EJBA0rG7uYuBlVYSeDFg/vrW6+hkc4KPQIFYH5eNxaHibmysP7PgLhffArwUjQXL7/BrlgGBL+wMAn3dkW6bMbExPM4TnYbEcwt3nig0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=rU8GkiU6; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="rU8GkiU6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1732471981;
	bh=uZEOgDV2o6u5NoksGtqz+6B3KG7pCk1UwoHyqXrjROo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=rU8GkiU6IwSWspDjxwzIdwj/v6bqsBCMSTT6zAGh+basRlJ4zcNGFqQ/Gbe+SWzQa
	 NZmSlUFIi3O0Hf53Pf08jTiYbh5etBwWJFaSmEJSMFBx+41DnPEMZtIP/2+7AKn77S
	 Lv4iSwbC2LAb/47RK+JyXMc80PQGD8PCz8Y3G33Z8aak4ynk0e3IoF4s5j8FzObETH
	 yuoa6AsYQd/STYk84P5qWT7Ub1fbDPb1l31ouuJBGHO1buOjv/CSv8eHJnNZmYUIBs
	 KkAYHA7BNzdzDd+bifmLUjfLOq7NYhpPqRil5wkIJHIEBpykmqpDjsP6d1QLt+v7Go
	 z2uYP10IMfJIaG6mKGNtHB+tx8J/Zf809B6W2KtdaObRzHj9eX7MYlVWOWh+yQLX91
	 5vk4Yg+oRzoUTjXSR8os3okh9uEOOM+pMxHAk9PKNYHBRb9SnBpuIbrYC+YtxLusur
	 JN9v5oeYIKrhYSPmMmrDm1tVP/9/UpoYvd38628GEP8v2etW79b
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5C6D620994;
	Sun, 24 Nov 2024 18:13:01 +0000 (UTC)
Date: Sun, 24 Nov 2024 18:12:59 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Homyee King <homyeeking@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git clean --exclude broken?
Message-ID: <Z0Nsq3lQZKJZxd-y@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Homyee King <homyeeking@gmail.com>, git@vger.kernel.org
References: <1A13EB2A-6075-4CA9-855E-B72ACDA67C0C@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sNqUftjOcVyNWexf"
Content-Disposition: inline
In-Reply-To: <1A13EB2A-6075-4CA9-855E-B72ACDA67C0C@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--sNqUftjOcVyNWexf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-11-24 at 11:10:57, Homyee King wrote:
> 13 years ago, Todd Rinaldo found that =E2=80=94exclude option is not works
> with any options, for example, `git clean -Xd -e=3Dfoo` to clean the
> files/folders respect the .gitignore rule except the foo, but in real
> world, git only respect the git ignore standard rule and not work with
> -e option.
>=20
> Today, 13 years later, the problem still exist, so I wonder is this a
> bug or should we clarify the =E2=80=9Ccorrect=E2=80=9D usage of exclude in
> documentation, because it=E2=80=99s really confusing.

I don't think this is the right syntax.  For example, I did this in my
checkout of the Git project:

----
$ touch foo
$ git clean -n
Would remove foo
$ git clean -n -e foo
$ git clean -f -e foo
$ ls foo
foo
----

When you use a short option, you don't specify the equals sign.  So you
can write `-e foo`, `-efoo`, `--exclude foo`, or `--exclude=3Dfoo`.
However, `-e=3Dfoo` is equivalent to `-e =3Dfoo`, which ignores `=3Dfoo`.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--sNqUftjOcVyNWexf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ0NsqwAKCRB8DEliiIei
gQOrAQDIKe4Sjlm2qs7Su7YkbCmdZarjOpmamMURJKa0zYgBQQEAiwHq4SRflT5y
x14FFhcavyAQaA3J9lHiVxL44IgIvgw=
=vNxx
-----END PGP SIGNATURE-----

--sNqUftjOcVyNWexf--
