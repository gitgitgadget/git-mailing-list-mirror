Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BF933CD1
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 19:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725044508; cv=none; b=ohSbIon9OndWZVLGN1iPuqT4B3m4+7bxYfKfJ1mcV1jPJucQnwLiw46/N+QuGpZGBOsWnymktolTVxZn4ORfP9x4U8DL/e6gI/Yi3fF9sySML605XO51Wu0uK20cyO3xkfUm9ilrdOwo5hOh7QrlTjP2QoYZFQlSOqxK2GjjugA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725044508; c=relaxed/simple;
	bh=9hPy6juD1ZKlYyS/R45wnjJf1uq7Er0bkY/wkFSKmFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKm0ZYkqsqjz6Sq5R26xzjGjTfowgI8THKN2cdPIsWMQIx4G5fDpJEjJNw3rO+fjKPeR5iuvFkg5DO8m1ONL4pHOPHoCBpsfCsT6R55muIGmbLz+F71QSI/1ZBO4N69b+Aouxv7awh+k0ffzY93j8e1la7L2rSJi5sO+QsmS07Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=1XcxxLxj; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="1XcxxLxj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1725044503;
	bh=9hPy6juD1ZKlYyS/R45wnjJf1uq7Er0bkY/wkFSKmFU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=1XcxxLxjx+yY+qzeimuJgr1uJRemcar39ABcpVE2MLt1vqgG7qD2CRHU4ez+NlVeM
	 esWG4tm4LLUOW+RB9gFmOC034T0LaK/bmat7BPBwDgLNyRVsW7Ie4o/fMU6AFC38OW
	 f6DBeN1UFG6Q4rpKOq2L7OSk9dT0OzQ9fkOqZDD7ETcFIuLFZ/6qA8kzMcBn9qh+Q3
	 hF7In2YRHWvpZ1rzQS5PjY2FbNvYOtHBhge6UrRkUnGiVEEfAjd4wMb7KiGiAO0Txr
	 knZ01FVyijhY4sewm4SbpQO73Fl9SmtEDwcNwgW+cBgJJtZ8fncol61ml7dUtfMF3Y
	 rUfP20RqlccMLfRWet5kareqY104xGrq3oc/unf8nTMvHULJWXOXRBiw3xi9e/GT80
	 alPHrpjI5haR63HShETES5sR77dgjw+Kr8zikV7SBdnHmNEu9HDI6K4fuu4mx9pm+H
	 30XsSvgJD6Xn/bKBqur1R/vUCX9QmUVAcYgXZYTR1h+PVj6JCdY
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8F1B4260C9;
	Fri, 30 Aug 2024 19:01:43 +0000 (UTC)
Date: Fri, 30 Aug 2024 15:02:09 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Roman Sandu <r.sandu@gaijin.team>
Cc: git@vger.kernel.org
Subject: Re: Committing crimes with NTFS-3G
Message-ID: <ZtHe8Vi9aRmY-UMI@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Roman Sandu <r.sandu@gaijin.team>, git@vger.kernel.org
References: <7d1dad03-703c-47ae-a039-c15aa765fd0b@gaijin.team>
 <ZtEWvQOwLPgjIFks@tapette.crustytoothpaste.net>
 <3eda2715-3b44-469e-85d5-f25504212928@gaijin.team>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DFmEqIZGs5E1zjfY"
Content-Disposition: inline
In-Reply-To: <3eda2715-3b44-469e-85d5-f25504212928@gaijin.team>
User-Agent: Mutt/2.2.13 (2024-03-09)


--DFmEqIZGs5E1zjfY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-08-30 at 12:52:05, Roman Sandu wrote:
> Yes, I am aware that the index will be fully refreshed on the first run of
> status. That is completely acceptable. But that is not what I am observin=
g,
> it is being refreshed on every single run of `git status`!
>=20
> After running stat before and after a status, the sha256 is identical. Bo=
th
> for files and for folders. Maybe Windows has somehow corrupted the index
> with its negative aura which makes git invalidate it on every single run?
> Are there tools in git to diagnose the reason for the index's cache being
> invalidated?

It would still be helpful to see the output of the `stat` command, since
that would tell us useful things about what's causing Git to think the
data has changed.  For example, some systems lack certain timestamp
granularity, which can break Git when compiled in certain ways.

You can see if setting `core.trustctime` to false fixes it, and you can
also try `core.checkStat` to `minimal` as well.  You should try them in
that order to see if they fix things.

Also, what version of Git are you using?  Is it the one in Ubuntu 24.04,
or the one from the git-core PPA, or a different one?
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--DFmEqIZGs5E1zjfY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZtHe8QAKCRB8DEliiIei
gTRSAQDi9j0dG2xC688PmizDASXerl+rGS8KuekxyQV5VfSK8AD9EfmU4rlF5JQK
wdIizhlWglS/ipPpllDg2KnW18OlFAE=
=9VcD
-----END PGP SIGNATURE-----

--DFmEqIZGs5E1zjfY--
