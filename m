Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48768221DB1
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 21:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772400315; cv=none; b=ODpnif+1N3cfntWLtIc6OAg8JOiape21WTxQ5eVWHqECQsPb7afHouYY+M0u1oCgHzqP4eS6N9BLCliGugDvnU7XOa4BDvVxACKcSYr4ZLTlFYAwyZ4BkCRzc+HVwqDEYFp984A3snnN2mxpcuhxHbqZJnASa75OAryZAmf6B/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772400315; c=relaxed/simple;
	bh=P0vFnkZRrLPGzAa+QZ+QWjYiPL6Ho5Z5fPyIZkoDvJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6P3I39N+m7qaHD/YnF4oFDCpAvhsouTGr5k/+ftv6jrR5GxzJJ1xFcRuahsEybhXIL1KgnH0YU6q/9jW3T3U8EYN2gQZnM3cQr+pzNHERvaR0Rwr0npWUAS/2pOZ9f1igIHMa4r/kcBcelzj3vKINnsTNabHcqqyby8xCCoun8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=jKXOQXf8; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="jKXOQXf8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1772400306;
	bh=P0vFnkZRrLPGzAa+QZ+QWjYiPL6Ho5Z5fPyIZkoDvJQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=jKXOQXf8FtQDKWtplbvFrVUj3qEfRFKNJIbBmckoOkLRt2T64dx6dFYfM+nj7Ni3A
	 MQ2V+wQDIutE7UYV/H1Ok5Ve+/gkk9jOu6NfSlAmPQIHUH6cL8ZEV1E9nwM5ss5fJX
	 v9bYk3Pj6ak/JLlxqQN4jnStnfo54W2S7mwz7hMAGTjI2SHiG7QtLkfI8+1M+MSsYd
	 0MlXTYoeApfY6oS/yQX31aY1R2WSRUYk63nNkjhAW7kINnjM9ewZZ2TMgBWKumZZUW
	 JFnKCnla61fqihLoWzysbSq4VxtV+oWZ3bTkH5QfuDB0WzLSPEq+f0E/S3TmGBtkUx
	 XJmq5wnO0uBvZdxvG1PVFPFWWvTN1tGiJdx0ElwkdgnLKhIZf2ZGnw1aeAsoaNvq4Q
	 Btuot/ys95KOTpZorFK7XpQw+1UVBr/hBJzt9GphX6+0M+1uQsWI8DUfAKgQ+So509
	 73JkSYATnPX65qn0zq/IXCKK1qh8a3YDTGAGSSeaiH191Cn+tHb
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:6ea2:3fc9:e167:33a0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 74375200B7;
	Sun,  1 Mar 2026 21:25:06 +0000 (UTC)
Date: Sun, 1 Mar 2026 21:25:05 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, kumarayushjha123@gmail.com, a3205153416@gmail.com,
	jayatheerthkulkarni2005@gmail.com, valusoutrik@gmail.com,
	pushkarkumarsingh1970@gmail.com
Subject: Re: [PATCH 0/4] repo: add support for path-related fields
Message-ID: <aaSusXil9nDHYGMR@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
	git@vger.kernel.org, kumarayushjha123@gmail.com,
	a3205153416@gmail.com, jayatheerthkulkarni2005@gmail.com,
	valusoutrik@gmail.com, pushkarkumarsingh1970@gmail.com
References: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hUUAqG9Ex84vuZ3w"
Content-Disposition: inline
In-Reply-To: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--hUUAqG9Ex84vuZ3w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-02-28 at 22:05:54, Lucas Seiki Oshiro wrote:
> Hi!
>=20
> This patch series adds support for path-related fields in repo-info, base=
d on
> what we already have in git-rev-parse:
>=20
> 1. The two first patches moves the path formatting used by git-rev-parse =
to
>    path.c. This will allow us to reuse this code in git-repo-info
> 2. The second patch add a new flag --path-format to git-repo-info, simila=
r to
>    the flag of git-rev-parse with the same name
> 3. Add the new field `path.toplevel` as a proof of concept.
>=20
> This arises from the fact that I didn't know what should be the default b=
ehavior
> of git-repo-info when dealing with paths. Some ideas were:
>=20
> 1. Add --path-format, just like we have in git-rev-parse
> 2. Use what rev-parse uses by default
> 3. Add keys for both relative and absolute formats
>=20
> In this case, I'm using 1, but I'm not sure if it's the best option. One
> downside that I see here is that git-repo-info won't be able to return
> a relative and an absolute path for different keys in the same call.

I think you should provide both.  I originally added this for things
like `--git-common-dir`, which Git LFS would really like to have as an
absolute path in the way that Git canonicalizes it, as well as
potentially a relative path.

The reason is that the way Git canonicalizes things on Windows is not
easily accessible on all systems or in all languages.  For instance, Go
has steadfastly refused to provide functionality for
`GetFinalPathnameByHandle`, despite that being necessary to canonicalize
the way Git does, so it's important to be able to get that information
both in a relative way and as an absolute path.

On Unix, things are easier since there are fewer special file system
objects and `realpath` or its equivalent are usually present in most
languages.

With `git rev-parse`, you can change `--path-format` on the command line
between options, so if you want both, you just request one thing, use
`--path-format`, and then request the other.  However, that can't be
done with `git repo` and `--path-format`.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--hUUAqG9Ex84vuZ3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaaSusAAKCRB8DEliiIei
gcrbAP0eec4tx3BGCz05m2XJkCclbgQxhigwTeeovXZzkhY3SwEAwI0uN8jiZJpw
Dz1a8W1tnkKMUO69e8u3L4jFz2M0eA0=
=xLh/
-----END PGP SIGNATURE-----

--hUUAqG9Ex84vuZ3w--
