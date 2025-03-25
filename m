Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B07E165F16
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 21:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938290; cv=none; b=c23Y79svIDoOeVoFOtW329CgtxTL874sIITKLMPgU1Sj1syyGTv3wggY+FXpcQZOaMfYhsO/YVDd6L3znB37hL4PAbrAeQfJ9qpQZJDg7JLjzaG51cG566dz/Xd1/PrpU1anTFWM2iMnSQFdqruviTkqWI4I06raZfGw/N6ZFnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938290; c=relaxed/simple;
	bh=YnHLt0XlF+V7FT3JK+8KM2NhG5O6bEclwjwCKU7z0xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/PPsVsYaQphR6S1Er5qu948DGZFz784RKFRWdlRjcRUnERLnUixgLETkugNE96xYeHK4PNZy/ysaY6Zqlbumw4jQRRoZ6JSphyQYTsK0hROpTRuv9ur4k62TivpzUJmtfGH3ch2eoiRjEclj7at8JTtF3uds+Puhs7OxPYAuxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=tSC9Dxiu; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="tSC9Dxiu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1742938280;
	bh=YnHLt0XlF+V7FT3JK+8KM2NhG5O6bEclwjwCKU7z0xQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=tSC9DxiupIbJ+XKiwEhRDVmiBV7GxX2hT2qKBC34Ytk1CYT2wv6lhX7nJ1ONfOtRU
	 m5mzqyHn0b7Pf8wQr6CKTnp+JYTRgV45q+uFHALfbSbkcTrGYIJHLq6ItOkSG5QvAD
	 b363utNM/sHJh9qdeyr8V0vtYiq0o23WP4xkoSBA/JQf+Ny/4Ja6QlhIY0wV/+G4h9
	 e7DQMjzgHPCh2aFlI+ht8FPsET8/lTt4GvwLaRu9ef9JFZzz2rdiikoAa66RZFxvFV
	 jygVlQlQTvDDjUM7JsTDjsdF1jKaL33x3gbXIMJ+2YIOHPDkfx7BTRQvZyVqY6clo4
	 2xU1fj/mIt9uElVKs20f8izUo2HOkaRIRphBOpMXw2cjop0QLb9e5fuAkRsvrhUvcT
	 o4xYk8uyauTqdJ/48/LjB8ejSR7KVP8wdNNHjawIoqbK0eQdiiRhUko63bwbakI33c
	 yo8tKsfBn/blhPr9tF8KSj0s+c++0TFqLDPNNPw1bHLn2qv9wJk
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9C702200C0;
	Tue, 25 Mar 2025 21:31:20 +0000 (UTC)
Date: Tue, 25 Mar 2025 21:31:18 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Subject: Re: [Question] Moving from Python2 to Python3
Message-ID: <Z-MgpuxFQ3xEgvsU@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	rsbecker@nexbridge.com, git@vger.kernel.org
References: <022b01db9d99$e68785c0$b3969140$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BUHZ0+z0ZKDUA65r"
Content-Disposition: inline
In-Reply-To: <022b01db9d99$e68785c0$b3969140$@nexbridge.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--BUHZ0+z0ZKDUA65r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-03-25 at 15:23:40, rsbecker@nexbridge.com wrote:
> Hi Git Team,
>=20
> I have Python2 and Python3 on my system. We are deprecating Python2 ASAP.=
 Is
> there an easy way to force git
> to use Python3 only? Both are in /usr/bin. python has a symbolic link to
> python2 right now, but we are probably
> going to change that. I already have modified settings in config.mak.uname
> PYTHON_PATH =3D /usr/bin/python3.

I think only git-p4 uses Python in our codebase, so changing `PYTHON_PATH`
should be sufficient to fix it.  As far as I know, git-p4 currently
supports both, so things should just work.

Of course, I might be mistaken, since I don't use git-p4.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--BUHZ0+z0ZKDUA65r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ+MgpgAKCRB8DEliiIei
gVozAPsFodU120UjvSsJhurOhLQJDkfeg4zEkhw39pC1jHsLEwEA3LpPTMFFREb6
RiRA3qjYcv7dGU8IIUMjhEn+o+V+fgg=
=LlIe
-----END PGP SIGNATURE-----

--BUHZ0+z0ZKDUA65r--
