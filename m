Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816C9EEC0
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759357222; cv=none; b=E4huRy5mDFvIHflsqdpdKQC9vhYUl5q4Pgc8durzofgw7FT2W3+2IM0epM2EWMLi9D9oBwz383NSck/qcoqnBQdEc4pzN/W8Q8Tuw1FXDvQ/6bOm0zvbau9jbhIXPydaBO1RCKjhBcA88rGQPSo+GkA839r72CCorF9cER6mwKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759357222; c=relaxed/simple;
	bh=aR1AkRX+ayFDENdN7q/1FI/TyTz7u2X+/glfZugRBE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fo/FtcMqymAsSrVInwMsUqKZXl7S663R6vHc9gDTTZhYGug7GxvSSqOl6IhhMH0Zcx5SG5k3OI9b0ot+iutVPjwhLLUQdA3wprdivX2BAChpG8gkbcOUmurn1o00MJ4WuCue/Sd8OoApZPE9AzcILKlfTb1pctM8wGA0fiAibBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=qBtLLDLO; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="qBtLLDLO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1759357219;
	bh=aR1AkRX+ayFDENdN7q/1FI/TyTz7u2X+/glfZugRBE0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=qBtLLDLO20nwDNdrJCt7Z2pWiBHERGdk8jk1gjKUfS78s1lBkTy1rneZpFRnwqRn1
	 FVfhWUbg1r+2p3RQ3Aw/isjFuVp3wDHfcTKDootcJgqb+nb/0fcYoihIVHGxzssc1f
	 1d+lhwyHsjQo/IV3MNp795MnrW6OSG5oxe+RdU6rgZcAQ6Djxnm9N3BI5i8tLR3DMb
	 IvYu1hDr5yHEKtbvKoUWnIiaT45bcJPaYkfbptXB1TQ1QhzExOjUPJRjBpxFR7ZThm
	 ajJEOXmbHqRmqRZQT9Jx/+4tAP5NNlgfsjGFRZgGpf2wol1+ASSQt0Stn/bAkxl2f+
	 dWttEVfXBHaqFTggBya1TnUaSvJ0johN2oSFENA1JHLOLTdVq7ePTRcaUpOtA98pDd
	 4eZSvEDRwIPpwcE5zYZDqBfUQImBerbNPruY46Gu+P8BhpHMI0pafdaLt3SwSC3PeH
	 eSLJmvLcsOZUaBB9pn+1bt0+YoWZz0JI8o7Z6510E1p1a6ln+Ei
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:eb6:3c64:95b3:ebcf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7C3D820113;
	Wed,  1 Oct 2025 22:20:19 +0000 (UTC)
Date: Wed, 1 Oct 2025 22:20:18 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH] docs/gitcredentials: describe URL prefix matching
Message-ID: <aN2pItzrFaga7m9z@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	M Hickford <mirth.hickford@gmail.com>
References: <pull.1979.git.1759352209657.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="05eL6cYAC5lUBKDs"
Content-Disposition: inline
In-Reply-To: <pull.1979.git.1759352209657.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--05eL6cYAC5lUBKDs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-01 at 20:56:49, M Hickford via GitGitGadget wrote:
> diff --git a/Documentation/gitcredentials.adoc b/Documentation/gitcredent=
ials.adoc
> index 3337bb475d..60c2cc4ade 100644
> --- a/Documentation/gitcredentials.adoc
> +++ b/Documentation/gitcredentials.adoc
> @@ -150,9 +150,8 @@ pattern in the config file. For example, if you have =
this in your config file:
>  	username =3D foo
>  --------------------------------------
> =20
> -then we will match: both protocols are the same, both hosts are the same=
, and
> -the "pattern" URL does not care about the path component at all. However=
, this
> -context would not match:
> +then we will match: both protocols are the same and both hosts are the s=
ame.
> +However, this context would not match:
> =20
>  --------------------------------------
>  [credential "https://kernel.org"]
> @@ -166,11 +165,11 @@ match: Git compares the protocols exactly.  However=
, you may use wildcards in
>  the domain name and other pattern matching techniques as with the `http.=
<URL>.*`
>  options.
> =20
> -If the "pattern" URL does include a path component, then this too must m=
atch
> -exactly: the context `https://example.com/bar/baz.git` will match a conf=
ig
> -entry for `https://example.com/bar/baz.git` (in addition to matching the=
 config
> -entry for `https://example.com`) but will not match a config entry for
> -`https://example.com/bar`.
> +If the "pattern" URL does include a path component, then this must match
> +as a prefix path: the context `https://example.com/bar` will match a con=
fig
> +entry for `https://example.com/bar/baz.git` but will not match a config =
entry for
> +`https://example.com/other/repo.git` or `https://example.com/barry/repo.=
git`
> +(even though it is a string prefix).

This looks like a good description.

>  CONFIGURATION OPTIONS
> diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
> index cb3a85c7ff..07aa834d33 100755
> --- a/t/t0300-credentials.sh
> +++ b/t/t0300-credentials.sh
> @@ -991,18 +991,24 @@ test_expect_success 'url parser not confused by enc=
oded markers' '
> =20
>  test_expect_success 'credential config with partial URLs' '
>  	echo "echo password=3Dyep" | write_script git-credential-yep &&
> -	test_write_lines url=3Dhttps://user@example.com/repo.git >stdin &&
> +	test_write_lines url=3Dhttps://user@example.com/org/repo.git >stdin &&
>  	for partial in \
>  		example.com \
> +		example.com/org/repo.git \
>  		user@example.com \
> +		user@example.com/org/repo.git \
>  		https:// \
>  		https://example.com \
>  		https://example.com/ \
> +		https://example.com/org \
> +		https://example.com/org/ \
> +		https://example.com/org/repo.git \
>  		https://user@example.com \
>  		https://user@example.com/ \
> -		https://example.com/repo.git \
> -		https://user@example.com/repo.git \
> -		/repo.git
> +		https://user@example.com/org \
> +		https://user@example.com/org/ \
> +		https://user@example.com/org/repo.git \
> +		/org/repo.git
>  	do
>  		git -c credential.$partial.helper=3Dyep \
>  			credential fill <stdin >stdout &&
> @@ -1012,7 +1018,12 @@ test_expect_success 'credential config with partia=
l URLs' '
> =20
>  	for partial in \
>  		dont.use.this \
> +		example.com/o \
> +		user@example.com/o \
>  		http:// \
> +		https://example.com/o \
> +		https://user@example.com/o \
> +		/o \
>  		/repo
>  	do
>  		git -c credential.$partial.helper=3Dyep \

I appreciate the additional tests here.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--05eL6cYAC5lUBKDs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaN2pIgAKCRB8DEliiIei
gbddAP4nMWeumYMQKQcF6WYZ0gYGipC6sDD6/o4scBOvLZbEnQD+KuEY9AaQC75O
qPNWOqGLx/4939Ngx06d/jahFa3fLwA=
=Lb1l
-----END PGP SIGNATURE-----

--05eL6cYAC5lUBKDs--
