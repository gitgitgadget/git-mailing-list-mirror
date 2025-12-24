Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3C02AD22
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 01:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766539852; cv=none; b=fK4KQFcUCzzS8MvbE8KvVTgTyjj5xuIs8CwDn4kv++K2Da58+s4XKhhcELBeC+pQCIHLh86IQFvLvN62cdF/5nvROO2ZSPpl2LyiRX2vfe26YubZSsRaDs3cMYGK2Wr6GePqUlZRbsu1jdVms7WVwN99WAVbj3CpH8X9moQyH5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766539852; c=relaxed/simple;
	bh=pFgEvr2AlGli+3YpzN0SiGNIiKhSJXAOGoyDenSmjvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=te311zoB3MLjjutIglXRuvOse+NPIpeOp+t4metax3I+kbgD5Yd5ajJ7pVsHDtFoLWUoNcDeUHvR1918b5DM4/k895Lv0nxSs9nP/EEN8iS6YWC0weWfalTL8eFiN+tHvnB4PaCgDCZoy51ZgctZp1FvZLkdHbksbNLZGgPBBoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=aHv5/aXf; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="aHv5/aXf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1766539840;
	bh=pFgEvr2AlGli+3YpzN0SiGNIiKhSJXAOGoyDenSmjvI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=aHv5/aXfPjRtb3+zcHwgPqdwjGI60fewb5S5oHFzbtBERgFqCoZ5yxVb0193kviCb
	 XGjKR33CtRFDaLZ1lvAGlpZ7RefdXKDhriNyrxZ4lL/9FhCGvVPFP2QQae8MxUDT2M
	 nKQPAnMdMDsgvFTKcftKkurNbUmA99KKyq7og8/7RFbDN6dGV50EY56Sl0C+jNQ1OB
	 OedM7oTQKeMmT1cqP2bZw40QAelcFjGjnZhNKws86zA/VJ4/EVqTEpVL5Nz5IfGi07
	 hkiwvc7aCuYP72GKVpPmmqnpCguJT6LviWfxvdSRSU8Z5dgZy+Qdbic5MN0+tNwqWg
	 NQqqmANicu0SnudeQB9eu4q1jC119vGZ59bVe2aeXqeizcRwpciBauaprQAWNsNJt8
	 mk5HfGjj3F1wGJ8wavjfn2ZtGQpACjpQoNniYo+H6iybGecLb5MDN7r06gdax4iJWg
	 ujHDA3u2T9vNLaae/u+s8aBnp/tpFrwvZ8munjoKJzZcZM1GZBD
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b928:cf9e:1e81:aac6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E737620079;
	Wed, 24 Dec 2025 01:30:40 +0000 (UTC)
Date: Wed, 24 Dec 2025 01:30:39 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2 1/2] status: show comparison with upstream default
 branch
Message-ID: <aUtCP5YvE_v9hmgM@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2138.git.git.1766451217075.gitgitgadget@gmail.com>
 <pull.2138.v2.git.git.1766530448.gitgitgadget@gmail.com>
 <a3800aed18e576e42de273c9dae0e25bbe26ac6a.1766530448.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aN7YmDlsojqNGAZm"
Content-Disposition: inline
In-Reply-To: <a3800aed18e576e42de273c9dae0e25bbe26ac6a.1766530448.git.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--aN7YmDlsojqNGAZm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-12-23 at 22:54:07, Harald Nordgren via GitGitGadget wrote:
> +static char *get_default_remote_ref(char **full_ref_out)
> +{
> +	int flag;
> +	const char *resolved;
> +	static const char *remotes[] =3D { "upstream", "origin", NULL };

This should definitely be configurable, not hard-coded.  For instance, I
have this in my gitconfig:

    [clone]
        defaultRemoteName =3D def

so my default remote name is `def` (short for "default", as in the
default place to push) and this code will never work.

Another reason to have this be configurable is that some projects (like
a company I used to work at) have tooling that demands a specific remote
naming convention for tooling to work properly.  In this particular
case, `upstream` would have been the right choice, but I also worked at a
company where English was the common language.  Many people may prefer
to use names suitable to their local language.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--aN7YmDlsojqNGAZm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaUtCPwAKCRB8DEliiIei
geAbAQCyi6Bl/vLa3PvEJNxLDumByBqnt+wdA1A8H1GJ1mzefgD8DDB5W7LDiEZc
Xy45TntTnjY7AsThqKY0OeQhLsUcFQA=
=e+fS
-----END PGP SIGNATURE-----

--aN7YmDlsojqNGAZm--
