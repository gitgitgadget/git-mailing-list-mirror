Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00F7192B75
	for <git@vger.kernel.org>; Sun, 27 Sep 2026 22:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790548448; cv=none; b=s5x2rFB+3C5aqKMSD93C2b17+QvBHtFgRiO0H8isTZip58fNNPI1/B3+M5jX7IuLy2coQ6rEPl7PQZ9dM7WH4r/FSFGCL79fGrhga6Xt8fU37Abl1gQDH+IVoiHAu1oJnCnbuM/XSEFT/XjhYTaEaXDDKsctqKcv5h7hFo4y6oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790548448; c=relaxed/simple;
	bh=TyYHOomRZFxoPLuq8ld4OeDLtpOZdRasQ8MCA2daURE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZR0STveyJe5JQ8pEKeLgj0TqVmdHXkz5Em6++trIpwgHPTsGXo2xSwRfl45sxFJr0SRPsRQjK7YHywigRjJ9GPfRmEHet9v6u0S6vKPdj3w1FlxYnwrB3Lm7q25qa6ldYq8T+kKs1K0KJbYzDlqKY1oKDTzzexszm+VbyEfNmys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=MRn3RtnD; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="MRn3RtnD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1790548444;
	bh=TyYHOomRZFxoPLuq8ld4OeDLtpOZdRasQ8MCA2daURE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=MRn3RtnDq8Vgh9Fac59F3ZcScZoEelH7zdKUeHqngrult0N4zvzhTdUmGvARelRKf
	 qkVM2Z5crPQQLZP8MiZdf3s+CqDspxltuyEny6/15r7O7UVlXS4gtbEGN8g3Np8MQP
	 kxzDjd0OyrKK0X82QnYifb41ui7TpwPLIj7PFrwfBio3GgSf1gGVNeloEm403AR/nf
	 BzCjPsSpOmUup/CqR0MwiYfAlP39CQdOG9wNfTVBOIrdUrskbG4E//nhyIYfZeoiPr
	 PvTozDaVETzL2K52LZ/jJvJ+NSYynhtW72DLQG04sP7rH9Xk/WX+hJoLH6gYidcDil
	 H7y7P+qUiPr2AiygGwBmBS+XHmXZFqHy2DjGqjdMzYQZnjzrG+nmwBwOsXXZKSti52
	 ruNpHpDUjPlULeJ66DDUgKWZXqQTBNLcGLSBt5YvOUIGkcHmhYF/nKJVgCLg3XPm3C
	 EpmvV5NvY8JEi4vpzDaxqiIylpPzZ4jUNLn27eJCgmpkWM8D7BF
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f1ae:eb38:1836:c72c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id BB38B200FF;
	Sun, 27 Sep 2026 22:34:04 +0000 (UTC)
Date: Sun, 27 Sep 2026 22:34:03 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: jyotish kumar <jyotishkumar725015@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] name-rev: update hash descriptions
Message-ID: <armZ28MWl9dTHDz6@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	jyotish kumar <jyotishkumar725015@gmail.com>, git@vger.kernel.org
References: <arkfFUpCskucD7Nh@fruit.crustytoothpaste.net>
 <20260927194602.86750-1-jyotishkumar725015@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/I6CEKfLKGTVzN1C"
Content-Disposition: inline
In-Reply-To: <20260927194602.86750-1-jyotishkumar725015@gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--/I6CEKfLKGTVzN1C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-09-27 at 19:46:02, jyotish kumar wrote:
> The documentation for --annotate-stdin and --name-only refers to
> SHA-1, although name-rev handles object IDs according to the active
> hash algorithm.
>=20
> Update the descriptions to refer to object IDs instead.
>=20
> Signed-off-by: jyotish kumar <jyotishkumar725015@gmail.com>
> ---
>  Documentation/git-name-rev.adoc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/git-name-rev.adoc b/Documentation/git-name-rev=
=2Eadoc
> index d4f1c4d594..9837fe59b3 100644
> --- a/Documentation/git-name-rev.adoc
> +++ b/Documentation/git-name-rev.adoc
> @@ -43,7 +43,7 @@ OPTIONS
>  	List all commits reachable from all refs
> =20
>  --annotate-stdin::
> -	Transform stdin by substituting all the 40-character SHA-1
> +	Transform stdin by substituting all the full-length object ID
>  	hexes (say $hex) with "$hex ($rev_name)".  When used with
>  	--name-only, substitute with "$rev_name", omitting $hex
>  	altogether. This option was called `--stdin` in older versions
> @@ -72,7 +72,7 @@ while its tree object is 70d105cc79e63b81cfdcb08a15297c=
23e60b07ad
>  -----------
> =20
>  --name-only::
> -	Instead of printing both the SHA-1 and the name, print only
> +	Instead of printing both the object ID and the name, print only
>  	the name.  If given with --tags the usual tag prefix of
>  	"tags/" is also omitted from the name, matching the output
>  	of `git-describe` more closely.

This looks much better.  I didn't see any other instances of "SHA-1" in
the documentation or "40", so this looks complete.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--/I6CEKfLKGTVzN1C
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmq5mdsJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZzvRFY2jaeKw9UxzhYcwfaByNGH/hv1xKByMeEBDTWzN
FiEECCzmip28ZfuD0cORfAxJYoiHooEAACbrAQDp6t1kyUp/cRbb9lTO1ayY9XnG
OQtgIanSs6uwn3qaswEAwkUhDduGMXOTY8BSIBK0XnLe4l8VpUEO4sdd9+qoIQ0=
=Gt1Z
-----END PGP SIGNATURE-----

--/I6CEKfLKGTVzN1C--
