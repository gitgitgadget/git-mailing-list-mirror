Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499B981AC8
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 21:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723756612; cv=none; b=YpCb1VeIRTHFf7qiVSXyZG0cnhhOutH4eQ36P2zYcevE07zT4BVHJr2fJlcKbnDN/BfLKogb/Xjp11OAdTGaA68dGyeXbl6YY5EJQoEgjsRvNvWPOuOpWbuMBCpNw3fGzMj3O4/3xs+zpkaWwNN7ZpoeJrjT0V9oQGVO1NApl3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723756612; c=relaxed/simple;
	bh=L5BjAOJ9UHYFSIltr8fEPo4a8eocd7cGkDEaKpn/znQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uv98CiH23hgwArpenU/2XQO00GXRskEtgaEHfFcdA5V9iTRPNPFOBuEVyl4ADphlYxeuotqvXbqJOk/jwH0vBsxxsHlmXUDSP5R5Z6sTE3Uf30kJGt6/ZMhrrhJJlSe/5TUOqvFi9huDSo0EnKArHen0ZeQrPt0mA1f7ciXOxSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=XLnlvGnG; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="XLnlvGnG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1723756602;
	bh=L5BjAOJ9UHYFSIltr8fEPo4a8eocd7cGkDEaKpn/znQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=XLnlvGnG+YzVCt9mcCxoTUC8oakuH/NvYxKXz9T17BusouTaLCV9QeHokRbmRBlWC
	 5jBwnczw19PKpmFAbggn6xzfND4ohODOzPNA/Twpi2X87KsM2MmTS9muIOgmXyMCzf
	 mNAIsqXf/p837cujhb8eSwkFF7fOvh11Ie2oMcmXILFffx2aabapfCPfbIevKRFfvm
	 I/EIpgRZaNFS3gc+MYlfyZ6LrzZ5YzGPskaHHXFyCAzDtmayWrZ4Ha3BIuDPzA9KfV
	 8uvOPVVXxsagkewaSnohZwfWAiJzw9HEbvTfD3gp+jvmBNdkonv7SkppMKunrBZB4J
	 HtjUl6Uk/wPJwfHyPIYjM+zGpeWWgU8yXLwVr6YqbxmzIQZSVVCI7WZ6FckSbBtt0u
	 zsDbyX8QHxdKqWOFkdBJEameklLMMN6Hw6wb969hH5RcFaR6zBlq0gc31njMtdaHrm
	 FnX/6mwtqrjHJw8H3927HTExILVdCdIvl9OjnauICY5faUjS2jP
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3CDD9209C8;
	Thu, 15 Aug 2024 21:16:42 +0000 (UTC)
Date: Thu, 15 Aug 2024 21:16:40 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: shejialuo <shejialuo@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 0/5] Introduce configs for default repo format
Message-ID: <Zr5wODo8tgGtPEIM@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	shejialuo <shejialuo@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>
References: <cover.1723708417.git.ps@pks.im>
 <Zr4dvybR6j6Ifyya@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FENe770jURhC3LAk"
Content-Disposition: inline
In-Reply-To: <Zr4dvybR6j6Ifyya@ArchLinux>
User-Agent: Mutt/2.2.13 (2024-03-09)


--FENe770jURhC3LAk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-08-15 at 15:24:47, shejialuo wrote:
> If the user uses the following command:
>=20
>   $ export GIT_DEFAULT_HASH_ENVIRONMENT=3Dsha1
>   $ git -c init.defaultObjectFormat=3Dsha256 repo
>=20
> The repo would be initialized with the sha1 algorithm. I think we should
> think carefully which precedence should be higher. I cannot give an
> answer here. I am not familiar with the whole database and do not the
> concern. But from my own perspective, I think the precedence of the
> config should be higher than the environment variable. This is a new
> feature, the people who would like to use it, they will never use
> environment variable and we should ignore the functionality of the
> environment variable. But for people who do not know this feature, they
> will continue to use the environment variable and they will never be
> influenced by the configs.

The standard behaviour we have with other environment variables is that
they override the config, such as with `GIT_SSH_COMMAND` and
`GIT_SSH_VARIANT`.  The reason is that the config in this case is
usually per-user or per-system, but it's very common to override
settings on an ephemeral basis with the environment.

Think of the case where you have a language package manager that's
creating a repository or fetching from one.  You can override on the
command line with `GIT_DEFAULT_HASH` or `GIT_SSH_VARIANT`, but you can't
control the actual `git` invocation, since it's baked into the package
manager.  Or if you're writing a test and need all of the Git commands
to use a particular setting, then it's easy to simply set the
environment once and forget about it.  (This is what we do at $DAYJOB to
implement SHA-256 test modes for our repos: the test script sets
`GIT_DEFAULT_HASH` and all of our test repos magically use the right
setting.)
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--FENe770jURhC3LAk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZr5wOAAKCRB8DEliiIei
gepZAQCfBHmUZcb1XpxOpe5dOhvHpaOk4/uzIDhQ4pehrPVUygD9EmH4umhDNEca
eGrr/3nwy3gCRWb6iPv8ctjp0UYn0g8=
=07oU
-----END PGP SIGNATURE-----

--FENe770jURhC3LAk--
