Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BD3225A32
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752787424; cv=none; b=CAVu7XlmJGHzspvTwt3t+WdUMSpE3lGUx4MbTJZRwp/eP+cJyrGq0UFOi2O7RglK0epDDsXWRivieo6SvzT1IWxTGQeLKwRQ6FeV5Lbf9R4129mT5OgDHQWzTh3fuaGzbqvd7d+mPytpb51KD3XlLEVx3s8MKQKdEbB4/45oeYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752787424; c=relaxed/simple;
	bh=eFIxtTHwKk7pzBvyIYF5cuDk9NwTbWV8wb/wFxIIaME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYitcG07dOffWSvA6PLG+FZfb/foRrXCOULzx8NI9F+5Cjh/FwVhSI5hHUIL0Ufqb/bh45iOkOvcZ1NhuVL5BlsPj/G+QjptShfofs/6bmoJN88LPbS1tEZ7iX6Si1IjbOzyxuEfR5CjBzDn5gngNhxby6sONhfGz0K6nYfOatY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Cpa3YbyN; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Cpa3YbyN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1752787415;
	bh=eFIxtTHwKk7pzBvyIYF5cuDk9NwTbWV8wb/wFxIIaME=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Cpa3YbyNZDJtJWxq//5+84xFlwnZRGsaXsCO1ysBgzhWGh+VlkVlel66M5sCLXzr9
	 nbVgyjEJYSlztG5DaB8kBr2cU/RwI5gWMgw/Psow/NXPlGcQfJweUT7wIoW9kmb43B
	 5WXr1OausK50pxQ1CxvqjIkHC61LmiUxMrNXojA4Q0aCwhk9ggT9grSEpjggByvS6O
	 p1irDnbqjNt20x+k8J2hSiFDxuN+PqRvMfWXkLT2aMqpZlxLq+7Li57fnOEjc7cSp+
	 b22af/NJVP7xZzVdcQ55nyA5OICzAwxXDpEPdoCvYPz/4GH/R0e667WveVXEyzQjLJ
	 D99OtFov75i62p7rxWv9p/7oCQ5jmAA0MzxQJbHWelRxSCzwunaAeVIVY7lL2oAAMy
	 clD4qp8bLEURR5T6pEreg9H4W9nf/a7DTG781nkB9wKqMk/4VDvP9NC1ul8x1qPWx4
	 +35ynJyjPpKW/ay83k8ujdsVqzOjXhgQMcEC8GMtiEExS65Qis9
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:c351:2fb1:6e4f:b4fb])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 6DA362007E;
	Thu, 17 Jul 2025 21:23:35 +0000 (UTC)
Date: Thu, 17 Jul 2025 21:23:34 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 7/7] github_workflows: install rust
Message-ID: <aHlp1joMwexLZAAb@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <0de0867ab44f316911bd34b9ceddbc8606e938f2.1752784344.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W04DWQyJ7anznXST"
Content-Disposition: inline
In-Reply-To: <0de0867ab44f316911bd34b9ceddbc8606e938f2.1752784344.git.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--W04DWQyJ7anznXST
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-17 at 20:32:24, Ezekiel Newren via GitGitGadget wrote:
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 7dbf9f7f123c..8aac18a6ba45 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -4,6 +4,7 @@ on: [push, pull_request]
> =20
>  env:
>    DEVELOPER: 1
> +  RUST_VERSION: 1.87.0

Our discussed plan is to support the version in Debian stable, plus a
year.  So we'd be supporting 1.63.0 for a year after trixie's release.

The reason for that is that people build backports and security updates
for Git for stable releases of distros and they will use the distro
toolchain for doing so.  Forcing distros to constantly build with the
latest toolchain is pretty hostile, especially since the lifespan of
Rust release is six weeks.

If the Rust project provides LTS releases in the future, then we can
consider adopting those.

> +if [ "$rust_target" =3D "release" ]; then
> +  rust_args=3D"--release"
> +  export RUSTFLAGS=3D'-Aunused_imports -Adead_code'
> +elif [ "$rust_target" =3D "debug" ]; then
> +  rust_args=3D""
> +  export RUSTFLAGS=3D'-Aunused_imports -Adead_code -C debuginfo=3D2 -C o=
pt-level=3D1 -C force-frame-pointers=3Dyes'

Can you say a little about why these options are needed and the defaults
are inadequate?  For instance, I build with the default options both in
my personal projects and at work and don't see a problem.

I don't know if you plan to do this in a future series, but we'd also
want cargo's tests to be run as part of CI and we'd want a lint job that
ran clippy with both 1.63.0 and the latest stable version of Rust to
make sure things were tidy.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--W04DWQyJ7anznXST
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaHlp1QAKCRB8DEliiIei
gXLnAQC4juxnsSY8Ozwj018Nn7i+FxWonzo6VbacGO73PY0z+wEAvIsu8UHWLMdR
qoKGnaBjS193rrZ8q20AEc/ZRqXvqAk=
=uTc0
-----END PGP SIGNATURE-----

--W04DWQyJ7anznXST--
