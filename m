Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E557F7E1
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 21:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742332488; cv=none; b=MazMuGGKC3HnKyPOWANYYlozY1Ic8+pnDhvQFolJJlS1ANNuQm7KvoRAkG7KngLIswO3i+io4hY9swnmBxCoM0Yk6u/FKGQ2AybD+upXu2Hl+w6DHzS7bn8jJJcaVuJ7ggcDYUuyz376L1iOZEcpPEVZYLTdwYWa7y3JtO+zrpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742332488; c=relaxed/simple;
	bh=iD9yhV1GLNiUY5copNuR1JZE5d/2n7bmuXdii8LCyXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lr5bAANANQiFEWO27P/fdgrfV7CC5sQR3YLezLOdyduP/iH4pkOxZakLStAVC3mdt9ghoOO9vOMksVg3Lqm+AnswcmPrgSOJhFt3kL+ggjkfeSpg7s9tPXL5us6QE4xyq9MmOVOFonVdmupX9r09EjTkSVPjuKwBJttDVMYyFRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=0NZnZ7H1; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="0NZnZ7H1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1742332484;
	bh=iD9yhV1GLNiUY5copNuR1JZE5d/2n7bmuXdii8LCyXE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=0NZnZ7H1mSCinWVO1oX8qSsg6eAXU1we20uiAZZCEnpF52d3MIi28+7OdP8Qexgqs
	 jWYH9WzB2DVDZ/Ef/OO7WiYLksVC38yCk2lNOzAxZpBes/wC9xu0dcMVj+G5nrCxQT
	 VgGmZK+9laZr4rrRNwLxdL08Jsln/YWcc2iCNKTVxF/Us714CoK4+SPDgwtIrAC4Sf
	 ENc2qBcSRCnHOE8EfrZOMXYBsMN1BQH3ye8/JEo9AZuezKigg1u+PscFRM2I5y4JUg
	 FtUrI5f/IFO/RF388MM2JmN+MVb3xEJis4m1sIDs+OgXrvejmOkcNV/qg47iZ2kNy4
	 oRrpkm7A1D6ZEUaBUlg44jHeqhSDQQAj7Zrb2yKSLYIj941vXSiaZ+xHE6/E6Gw2rm
	 AWXPJ/7XC+xC6zTOgQEtBXj2DAH9FpfeRVNcX91BXMqHDVBUss1rl3Z/hlkE+yW10R
	 pB/rhEYTbh6yYYVbQz50qz06KsBu62QF6KupgtG/uMCOIh9JWK9
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7EA57200B7;
	Tue, 18 Mar 2025 21:14:44 +0000 (UTC)
Date: Tue, 18 Mar 2025 21:14:43 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Tuomas Ahola <taahol@utu.fi>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] format-patch: use raw format for notes
Message-ID: <Z9niQ9v-SjsNgTJR@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Tuomas Ahola <taahol@utu.fi>, git@vger.kernel.org
References: <20250318180251.3712-1-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rCMGbJBvpu2iJK3y"
Content-Disposition: inline
In-Reply-To: <20250318180251.3712-1-taahol@utu.fi>
User-Agent: Mutt/2.2.13 (2024-03-09)


--rCMGbJBvpu2iJK3y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-03-18 at 18:02:51, Tuomas Ahola wrote:
> The default formatting of commit notes by git format-patch --notes
> doesn't make a very good fit.  It would be more beneficial to use the
> raw format for CMIT_FMT_EMAIL and CMIT_FMT_MBOXRD.

I don't really use notes, so I don't have a strong opinion, but I think
"doesn't make a very good fit" isn't really a compelling argument, since
it's very opinionated and short on details.  Maybe you could explain
the current status in terms of the output one receives and mention in
detail why it's unsuitable, and then explain the benefits of the raw
format in terms of its output and why it's better.

Ideally, I, someone who has touched the notes code but is not intimately
familiar with it, would be able to understand the advantages and
disadvantages of the change by reading the commit message, and I'm
afraid I don't right now.

My guess, based on the very small amount of code I've touched there and
my recollection from that, is that there's some sort of prefix printed
in the format-patch output, and that prevents the notes output from
being nicely formatted as an additional explainer when sending a patch,
so it requires further editing, which is a hassle.  Therefore, it would
be more convenient for users to not have to do that by using the raw
mode.  But that's just a guess.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--rCMGbJBvpu2iJK3y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ9niQwAKCRB8DEliiIei
geeDAP46hb6w21xdILT9qXrWnysuDv5g8AZrBPEKxSTH2bABSQEAspXGbrUu6ZwH
MF9iUtTIj01U9m5EmdUFa4DMiBsYvQc=
=WXg4
-----END PGP SIGNATURE-----

--rCMGbJBvpu2iJK3y--
