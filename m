Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A57E1DA23
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 20:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701315; cv=none; b=Gvnwrx0weaF3uj1rdtDhe9Dg5eacpKcR2w5eG+wnEzh/C2Bu1uXS0W6BDCj4chPDMzeP+gSLyHRKtr4qAahmp5TKJMWzmAO/LrgcdkKgzf6zfeDNa8bsvF1qj4+2AsypOqR2QJfS23DWHNKu7Y3mVUKD2qN63ZqZiQ+8lbdOokQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701315; c=relaxed/simple;
	bh=BdCh8ed1rUfj+hiNXpgc/YpQ5TzySVTw30ijkbWm3LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Txs0Z9l9+QBiAWnNxqtIEce5jcaAakdOEqkrZFhVoNKANGQNSvnToOQpBy6VqfGD0K5J7ZehPOiMJJ/WAReqefWN6Q8rtSpsPrHqiy/ktjOr6hS7/+fVj/EbwwH++lzV21DIM9z8M7wk5o3mdaV5+kLjZbjWP0gNW/U1EE/h054=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=DYzHXAEn; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="DYzHXAEn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1731701309;
	bh=BdCh8ed1rUfj+hiNXpgc/YpQ5TzySVTw30ijkbWm3LU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=DYzHXAEnfB96w3sDBQ7kEVG9/L1tclaeIemDEt9G2WCCmN5S46TJBGWMsfT7L2tBR
	 SaQexDxxvLztv9c5Wnyk8rmUV8PivmrdbRXOYXiNRGkaty48A0CsOzOnEbBO7siUcb
	 VL6SkfrsObNqrZVkQiYbkqv7E+owp0DJO3hkKTT8MI2y9Y5ZhkylzveHFoJqmYUIh5
	 Kz+yd6GOIQKsA6sd7FEpTa6S+JuRUz2FFDLCDt+QH4FtNjdtSAMGVlYq5U72rOlgz2
	 dVwvKXtcaUZpwuQrY3/7QWPo2VY0v6AehBo1HyM6fIYp1BlLelQLsCP8b1cQ6o2rQA
	 PkDuetCjcE1jmWc4s3gYTcMH0Pg2OmUGiDt+w0yvRNT5DQdjjpgs6BXDlaMAnKF+4K
	 6fHhj5JENhs9HXCwcK+Jwm1KGwH5iGLThftRYl7QPeN5GA+7z7HwZBTUyjnsWp2mIR
	 VD6g1QeJa+tRvOLRToK9vqCtslgBsumMHFHPuhoSZMTuJcu6K5q
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 1B919200CB;
	Fri, 15 Nov 2024 20:08:29 +0000 (UTC)
Date: Fri, 15 Nov 2024 20:08:27 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Sachin tiwari <sjtiwari007@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Bug Report
Message-ID: <ZzeqO9n_6dLBgRmX@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Sachin tiwari <sjtiwari007@gmail.com>, git@vger.kernel.org
References: <CAGoMMr+f4oqgDqq_1h4cV39GVRd8fgzEzHgBP8fJsJ+HAgiwqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RwAVQhE7WynO+T2S"
Content-Disposition: inline
In-Reply-To: <CAGoMMr+f4oqgDqq_1h4cV39GVRd8fgzEzHgBP8fJsJ+HAgiwqQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--RwAVQhE7WynO+T2S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-11-15 at 13:02:21, Sachin tiwari wrote:
> Sachin tiwari <sjtiwari007@gmail.com>
>=20
> 18:28 (3 minutes ago)
> to git
> Hello,
> Title:Git Clones Repository Even After Incorrectly Inputting Personal
> Access Token (PAT) and Leaving Password Blank
>=20
> Description:
> When cloning a repository using HTTPS, Git prompts for the username
> and password. However, if a Personal Access Token (PAT) is mistakenly
> entered when prompted for a username and the password is left empty,
> the repository is cloned successfully without any authentication
> failure. This behavior should not occur, as Git should ideally reject
> the clone operation when a PAT is input as a username and no password
> is provided.

This isn't a bug.  Git itself has no way of knowing whether what you put
in a field is a username, password, token, or something else entirely.
The decision on authentication is made by the remote system, and it can
apply arbitrary policies on what to accept and what not to.

My guess is that you're using GitHub, and GitHub allows you to do this.
GitHub requires that you use a token, and it can be in the username or
password field, mostly for backwards compatibility (changing it now
would break a lot of things and isn't really possible).

I would say that it's definitely strongly recommended to not put secrets
in the username, because many tools will filter passwords from logs, but
the username is often not filtered, so you _should not_ do this, but
with GitHub, you can indeed do it if you really want.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--RwAVQhE7WynO+T2S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZzeqOgAKCRB8DEliiIei
gaogAQDEQj3JLf0ghsxGEVo19oLZT235HEPAF0nwW1CSfaX7rQEAzJsQJhEyGKfL
HAL2Amf/qc/hZ5iQ5ssbpgsLKKmBfQQ=
=ySnp
-----END PGP SIGNATURE-----

--RwAVQhE7WynO+T2S--
