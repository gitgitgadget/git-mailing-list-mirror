Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051581BF24
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707258591; cv=none; b=kzvstk0s7Z84nQ/YwdIMd03XXdDLkRvN04N0mgBHp80r0jKBUFttzHj2EqsxK1KAl75Sg+Z5FWpG5w7JzV5XiPu+sghLkWkZ0mD1GOId9Ec7GF9CxlbkiAhOoFn8jSdQNjeJq9RHjv3GC9n7PNEwVLF+4wPNsbuMNaimbSxnoJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707258591; c=relaxed/simple;
	bh=/U0jEeBaaTHvWHI2XsZcox9Y2P9/6cUEx92lzmYIQuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0F7qxQwmO78CcgXDdGMNssNZp9nle2FevuZ3e+qhAgOVs19alc4Ek0wya1nBQHF/EBO0mJYQDMkZjHvac6kHSNl6nrXWUtsxJI1EsFoHbkeIY4zL3Vro7Wc7fejR+bWquO3wnWhYzTWRS026oYOtR1paVJ8pAtgJl17pGewrbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=JdnZSs72; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="JdnZSs72"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 39A4F5B047;
	Tue,  6 Feb 2024 22:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1707258582;
	bh=/U0jEeBaaTHvWHI2XsZcox9Y2P9/6cUEx92lzmYIQuE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=JdnZSs72WjnZJ/u9ORMNJaa4G0O8bMoPrTAXaRTJpBihd47gY5AkV/b2bZ4gkodxR
	 oa+bqhRWhPUFN8Zv5ct/tKQykXukdYpT1e9vuxtUdp+RRTC2encKDw354mnSitvq9R
	 i0FkQr0Seireu5xOugb0BTDF6WegKsaSSBC7RfIpj7T+HoKuOp10OfTRl5ddvl3uCn
	 BtJBgl1P6waf2WsO3kaUt4YE1d+vwjqzcdauZjT+kkkNiKuCqGJgc0L7uj3EYgMVQu
	 4AzhaSuzZYtanyBrK19S36asK9QPZxRZFbRZ9HRRE8nUePDpNMxFFy81Wnw5R97iu9
	 6XnFA+XaXq+XYlyur+BvTx1MzSycAtX0tWNSBbKGr4L2kY9gWtlt/jqhEPvcL2bqUS
	 Am2aHYkcNijFvCadv5CMWBXJBnNac2CzZo9KSCDWfPVwZWCm8Mf2uSrVW/Js2zVUWf
	 wEIXrBxbBSPJ/I63sb2vLsHeittmsTljURJAazkMmk6DXGxz3bQ
Date: Tue, 6 Feb 2024 22:29:40 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Tobias Boesch <tobias.boesch@googlemail.com>
Cc: git@vger.kernel.org
Subject: Re: git-gui desktop launcher
Message-ID: <ZcKy1GVhJDvl6N35@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Tobias Boesch <tobias.boesch@googlemail.com>, git@vger.kernel.org
References: <beeab03c564e94861ab339d26c4e135b879a1ccd.camel@googlemail.com>
 <ZcFhNPRprfMqeRu1@tapette.crustytoothpaste.net>
 <e897282f-ac33-4f1e-903a-b6fb69e0c55e@googlemail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k42mz02Gmnwho9zw"
Content-Disposition: inline
In-Reply-To: <e897282f-ac33-4f1e-903a-b6fb69e0c55e@googlemail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--k42mz02Gmnwho9zw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-02-06 at 21:14:04, Tobias Boesch wrote:
> 5 Feb 2024 23:29:10 brian m. carlson <sandals@crustytoothpaste.net>:
>=20
> > It's not guaranteed that bash even exists on the system, let alone that
> > it's in /bin.=C2=A0 For example, this wouldn't work on most of the BSDs.
> > This would need to be templated using SHELL_PATH and written in POSIX
> > sh (e.g., no `[[`).
> >
>=20
> I see. I'll try to look into it. If someone knows how to do that let me k=
now.
>=20
> >> Icon=3D/usr/share/git-gui/lib/git-gui.ico
> >
> > This would also need to be given an appropriate location based on the
> > build parameters.
> >
>=20
> Is it about the build parameters of the build of git(-gui), or about the =
downstream distros are building?
> So git leaves this empty and the packagers full this out?

No, this would be built by a Makefile target.  You'd provide a template
file and adjust it based on something like the `RUNTIME_PREFIX` value,
which is used to adjust locations for data.

There's examples for scripts, such as git-instaweb, which you can use as
an example of how to generate a target file based on the input.  This
can also be used to work with `SHELL_PATH` as I mentioned above.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--k42mz02Gmnwho9zw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZcKy0wAKCRB8DEliiIei
gWu8AQD6p3uhUEUInsnQrTfvA4U+BtfNtI1saBpXZSodA5xKTQEAz67tMVWmn/JM
wKf6eGKTkYSBBt3glvxXtL979UZd7wk=
=2ix9
-----END PGP SIGNATURE-----

--k42mz02Gmnwho9zw--
