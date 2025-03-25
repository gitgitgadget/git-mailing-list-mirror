Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6637F269CE5
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 22:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742943532; cv=none; b=ENf1TXiV9rYAlXXPftpcO/bU7kl60ZPGKZsNWhbdfkoFdL1rJ1YhvE83ufqKe0TEhwhCCdOoO0BCymxDbSUe+uefFRT19LKMFeak7ZEFFXCFjYkeoM0sPaHRaSuaS/8mkqLayz1zpPkspmjcRISKUyTm7I8Z3UE2NgGU4ffrEE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742943532; c=relaxed/simple;
	bh=Y9aBBneUCHte8/wVjn4lpWanfcAuks0WaaGjfpwkXTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAKzfQZnh5avR+ra35E2/01uMltW/wTIVFH9i+cjq6RuKQnGeqXrXw5nsnN2/3UipfhJJV+65lm2owfGpT0dojoE5o0D1N1/egt41pUMD48tFFsZONzhr6l9jBxWzH+3C8q8y05ayKPFAC+KevsESI19+8Qq9scolszMu8JWbHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=KpuHUKGf; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="KpuHUKGf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1742943529;
	bh=Y9aBBneUCHte8/wVjn4lpWanfcAuks0WaaGjfpwkXTs=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=KpuHUKGf3P+T+ECdc4h2tpyyGv02pOKNtVVNVyAyspYvvDkb67mNBJ1ySph4uK8Lf
	 GZ0CFLeUiul7dNMA6diDdzmvbYoSlL3fv4fI7NX212Wto58Rtqf8eCtELrkmNCRK2S
	 ySTvCAU5J8+VnnVjfb9BvWoMJIUetcg4ubIeIIuLt9fmhLFm5sbhOlsQEBvTjVQpgj
	 F9vuX800t8OPON2p5Ef7jDWyEmg6HE258SUwZsQfGaJ518lZA8iCwUL6I2dlxBRozq
	 VsEeeOIdLOuoEOwvnu9iCNT8BRbMqgRus8tsj3RJ+fEKyzD/YKX/pphdWmCJULdpqv
	 t5Kij4VsdrZaQbxRWe89SxLgb/3b25zajBejsR3jOHXzzeyVJjHL+4G2vTHPAEzEK7
	 00zmZIAFHVAl7zTs97qHBrcptUkzB2vK/nHHUgD6p+sMXuVxgrQtUr9qTuLj4ETCj7
	 AhLkl9jBNbKJTZaD7TjQ6X8w6kNHD8rUEyzbfD2DdmhWDstvjEs
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id F2C9B200C0;
	Tue, 25 Mar 2025 22:58:48 +0000 (UTC)
Date: Tue, 25 Mar 2025 22:58:47 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: Possible venues for Git Merge 2025
Message-ID: <Z-M1J52nQBxxMrXS@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>
References: <Z9vuiCnKcMRRXHOR@pks.im>
 <Z9ySGbE4sq0JfgKs@tapette.crustytoothpaste.net>
 <Z-Knm2WGeMI9a7zt@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mw5FMof7NCN2qony"
Content-Disposition: inline
In-Reply-To: <Z-Knm2WGeMI9a7zt@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--mw5FMof7NCN2qony
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-03-25 at 12:54:51, Patrick Steinhardt wrote:
> The only reasons why I proposed Amsterdam are the Open Source Summit and
> that I have some ways to help out with organizing the event over there.
> I would be equally happy with alternatives like Canada, but didn't
> really want to propose alternatives like this myself because I would
> have to push the entire burden onto somebody else.
>=20
> So if it would be a possibility and if people could help out getting
> things organized in other countries/continents I'd be happy.

I think there are other concerns and it appears the decision has been
made, but of course I'd be happy to help out with things if Git Merge
were in Toronto.  I don't have experience organizing events, but I am
pretty familiar with the city, having lived here for almost 4 years, and
could, of course, make suggestions on locales or help coordinate things
to the best of my ability.  The city also has great public transit[0],
which I always think is an asset for travelers from out of town.

I must say I am less familiar with Montr=C3=A9al, having been there only
twice, but I do speak French reasonably well (although English is
commonly spoken) and it's only a five-hour train ride, so if that were
the choice I'd be happy to help there as well, although I'm less
confident in my abilities.

[0] By North American, not European standards.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--mw5FMof7NCN2qony
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ+M1JwAKCRB8DEliiIei
gU1OAQCKpM8nssXQeOMsVcAGzc/yi7LI9x311x/y253JgpyDsgD/cNTOUryMJtoj
5Emd2gmWjR3fnxhw8+cDaMrvBx0xGgA=
=XCNo
-----END PGP SIGNATURE-----

--mw5FMof7NCN2qony--
