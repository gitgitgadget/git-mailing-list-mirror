Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABE412D1FA
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 18:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726251853; cv=none; b=k1fp8Rg2QUyaSBSZq38jIDkgM/JSvTTZH4rbB2Uk19WrS5TDfUA89S4nwcC2PMxn98cqE2Hv/RZXXX/3GlAAXG7xxTVZAjYoQkRsex8dE2AMiiiHfiJxRF/p0whaDyndEC6V0k+YkELV+I75jelg7E2Ms8CsT0MTzjvtDPCDUcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726251853; c=relaxed/simple;
	bh=ctLqmbQN/AIpFiknX+rl0f5wdxP6ZuSzttK7Pa/T9yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qS4/QAz0ir4ZKosxFWVqi9MTx7AfJWdgDoHXHCteBegsNIWcM8bAIE+okJaJ9yI2cESocFxEPSD3tLishauugd0RJfsCBUBgRJ5FGIGTKMk898DP+yswvJImlk2GIEknvAwsnjChT0TKeh6doVBK1aBba2Dexz42Zjulf+SdydM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=wbgIgcFH; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="wbgIgcFH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1726251843;
	bh=ctLqmbQN/AIpFiknX+rl0f5wdxP6ZuSzttK7Pa/T9yU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=wbgIgcFH8LkNZ6DxyMlYSQp5+wj0Qi+FTDxyJNmCqzNfoTPkuOIUXcbsti/XcJajX
	 zLkE/Bx5tYbYg/0Q12phBDXMIyVJm9thedhDm55/BYuujrBNjHGwws1R0M+l7oJkec
	 TU4rgZGdiybDR5cXfdRcdesgFppzNjsnzYa0UTssbWCgHtDQ55QTRIWuUj7omwoJ+2
	 h81rpUm9wjirZXO6qD+GbTbmSnce67D8HsTNbKA4QIg0s3NpzNb1XxzYlhrsv9EZwv
	 4ZSM/n6mPXSexBypZH5Bgd9RJPDPDxQmN9qB+2hrHLZFCC03kCrumJwvUYeqgRXzZP
	 Ta6xAxrwhO1C0/5NIr/AeUq1WB8rSK5w5pfHZipUiCu8ClDsaY+GQO9TaqzmGRJ+3t
	 CpAfDG+eVK94nLjPPxrtvoWmi1QZ2Shg5V2FuUz9+G55PIvGopk2e0GK0egoZruwJU
	 GFXIKUwPtJh+XmYFhc/nN5aMyHgLCUoBQtMPbmSIeYmhGwWqQnL
Received: from tapette.crustytoothpaste.net (unknown [204.148.121.182])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4EF0C2447C;
	Fri, 13 Sep 2024 18:24:03 +0000 (UTC)
Date: Fri, 13 Sep 2024 18:24:00 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Stephen Smith <ishchis2@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: SyntaxWarning for   '\S'
Message-ID: <ZuSDQPssBOujNCrF@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Stephen Smith <ishchis2@gmail.com>, git@vger.kernel.org
References: <2214912.irdbgypaU6@thunderbird>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v/oRyDI3sKBdQxqL"
Content-Disposition: inline
In-Reply-To: <2214912.irdbgypaU6@thunderbird>
User-Agent: Mutt/2.2.13 (2024-03-09)


--v/oRyDI3sKBdQxqL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-10 at 03:49:33, Stephen Smith wrote:
> When compiling Git from source on my Ubuntu machine I've lately been gett=
ing
> some warnings when the docs are built.
> =20
> An example of is:
>=20
> ASCIIDOC git-sh-i18n--envsubst.html
> <unknown>:1: SyntaxWarning: invalid escape sequence '\S'
> <unknown>:1: SyntaxWarning: invalid escape sequence '\S'
>=20
> This syntax warning shows up for nearly every man page or html file.
>=20
> Is there are current documented solution?   If there isn't a documented
> solution, where do I start looking and I will craft a patch and submit it.

I believe this is a warning from Python about the asciidoc program
itself.  I don't see this on my Debian unstable system, so it may be
that it's fixed upstream (you can check at
https://gitlab.com/asciidoc3/asciidoc3/) and if so, you can open an
issue with Ubuntu to get it fixed.

If it bothers you, you could also use Asciidoctor, which is written in
Ruby, and which won't have that warning.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--v/oRyDI3sKBdQxqL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZuSDQAAKCRB8DEliiIei
gTT0AP9ikm3BrJ5pdWuOvUEksm0iiE5AWXlRgkTKNs+A+ZC6/AD+I7HaCIfdVhg0
Rz7tF4gKFFuPCetRfycQr7WnspIGAwo=
=GyJA
-----END PGP SIGNATURE-----

--v/oRyDI3sKBdQxqL--
