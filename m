Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150BE1487F9
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 22:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721775025; cv=none; b=pTwuxxyCke5+9yb6Yew9MuqJPJPwyP+59da6e9yZE1+XIfPnZ4sz5YWSyL5frHKw+C7v1F4p2BEtDHNfGlAI5FjY4KA49lXEOfcFpviXfZJxnLvoYbP+TnoZzePI5eNXSiVpdNnv4itB1EBDaa9sGoQhxa4P7JzfB29ff2u5yW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721775025; c=relaxed/simple;
	bh=bv1c4eEfL7VmgtY0/HdGqsjGss3r4IKTzyyPuX/L9Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQgdr/tKFupAxSnjv3CvWr8H01hZYLh8hTH8ZWdK2gNi08UauBoPvdCNH0zUkV9q3Wtca0BaYG4MbKnvjfzJIxmVkmaIQYUaV98O9EJ2PytNDq4N3tJpEX4TtGu235t+UbZgHGtFkIw6T4+DoU206ab2qPGEPCT2c47BOTtkDPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=glj6y/oO; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="glj6y/oO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1721775015;
	bh=bv1c4eEfL7VmgtY0/HdGqsjGss3r4IKTzyyPuX/L9Os=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=glj6y/oOXIaP7oHlV+E9q072VgJqYc/WFzOfbLA1oPp+tU3GdJ8uOO5JLGT1QnjRZ
	 k6Vfg5DpYuxxpKhoWQ09G9pj400kyl67X/bCqEQvOLt1fhecc5bBUjcR+Aa+8KDHiM
	 5bz3ceMuBLeMeQ6vBN68p/UObVzhRjx+jHiBkN6InC4gpbb6ILg9eZCoPXluwEjNxd
	 qrXM2L/oDl/ZCpDzuEBo2mIu0ycA/4jE9qaRIxmJHxJfqpQK4wz14M9iplMSkBt33x
	 fgYqiYjCZ/Z9yU9+9hCQ/axfqsSYEU5DYkjSaBee7aN00f7KORbIUzcda7AzeOa33s
	 zXAaoCZSsgq/pNLHq7zAoqNszgg2AOynbMqFAxuHbaBsH4FoBVSAshRE3vvqiCU8qs
	 mHSKQARPyfRuXf57CaGD5xWpBU6U8DT8SMnYvIBqR3EusEyejP2mr+75wMmV91YWpF
	 gI3CM4z91U36KCkSxLC+7p6eSdvivG5IQpHrBAEv85tvLpcOXXz
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 165A9209B3;
	Tue, 23 Jul 2024 22:50:15 +0000 (UTC)
Date: Tue, 23 Jul 2024 22:50:13 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Avi Halachmi via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Avi Halachmi <avihpit@yahoo.com>
Subject: Re: [PATCH 0/8] git-prompt: support more shells
Message-ID: <ZqAzpYuTrK6L-uyN@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Avi Halachmi via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Avi Halachmi <avihpit@yahoo.com>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rpv0a0DBb+Nkibas"
Content-Disposition: inline
In-Reply-To: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--rpv0a0DBb+Nkibas
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-23 at 19:18:18, Avi Halachmi via GitGitGadget wrote:
> Before this patchset only bash and zsh were supported.
>=20
> After this patchset, the following shells work: bash, zsh, dash (since at
> least 0.5.8), free/net bsd sh, busybox-ash, mksh, openbsd sh, pdksh(!),
> Schily extended Bourne sh (bosh), yash.
>=20
> The code should now be almost posix-compliant, with one big exception
> ("local" variables in functions) which is not simple to fix.

We explicitly allow `local` in our coding guidelines.  As a side note,
Debian requires it of all shells that can be used as `/bin/sh`.

> Shells which don't work, likely only due to missing "local": ksh93[u+m],
> Schily minimal posix Bourne sh (pbosh), yash-posix-mode.

ksh93u+m is planning on adding local in a future revision.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--rpv0a0DBb+Nkibas
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZqAzpAAKCRB8DEliiIei
gU16AQD/6zC8Mny1OrgnDwgX2blvy11GOLs2F8EMovcmODAbnAD/ferEPeac/oD6
aLZdpI7JEUK9N8AAkeJ3UD76UYLYYQo=
=kQMO
-----END PGP SIGNATURE-----

--rpv0a0DBb+Nkibas--
