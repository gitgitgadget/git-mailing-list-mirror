Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FBB17BA5
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 00:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730421521; cv=none; b=kisuppPwCAPNB8n7vG8IstfQHw4jcyFFOFBGnW/dNz+YqnlIac0tnlBd8OalOxWS7VvIkuIAmRUJcjUpOjcd6/vwvYziAHWemJTCmx3oIYhJKlp/bBy1/u/Xh83WzICnUPMtUAfIGhJ8b2TUfWW5Oe9AtF4QlnZ5TZvkK4/wyP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730421521; c=relaxed/simple;
	bh=lgwSCAYLx+07kqyDPcwX6oy5mYPmprIZyUMjKy9Wc0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdbAyKNw5x4UsoOvirCtgvRmeuffKcS8Y46/hK0jvhnXq/g4TPTASJpPiiBnBLFtfLpPipSb0rWHDJOFKo1JypzFZmcObPGCd2/AvinzfbuEHAGFsWo7OObZCdVB18H3A/1NWQVqPJpBoWQslfs3CgvrFLla3aL2Jd2rIHmyZ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=qfIZ1ORP; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="qfIZ1ORP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1730421513;
	bh=lgwSCAYLx+07kqyDPcwX6oy5mYPmprIZyUMjKy9Wc0U=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=qfIZ1ORPHm7n91OyhgX80/xyK4w8UdP/PvYBNKBM+KtA82Om5ADiKjOpaMfpmAu3b
	 RzKgDU/HL5dsZUXxcOqO0oP6Ac9IwDt+dMi2onMKlrMKfwQInWBC6mR0IL9MG3unbA
	 DnHboCSFjHggQ7bNHNsMqbTmbkOs0rPCCo5zOyhTdU2LL/sHSHaI19ysPdYDm1JwT7
	 V/sNTSsY8iRnuoSTcYn19ItNt0JfC4Xk9gIJ+RnDyk3ZMinFR/QVszYjhDOmL49TcC
	 fvm2O6q8KD6Qtks0k49lzJtI35Rt9AkVVdSNFTocF8C/RVaiF8Vo0K1Fshs661LdQg
	 Cs9CUADHKYqj1YFVbioSN1IPHcyX0BZu7lLM30PbciIeR5/a3Ic210P23UDKBfVmKY
	 9tZUaWrbnub9gnXxzRZzWnaBxGdk4/j7y5liBUMh9cFhSD+BR+OG6wbVGMPgxfhFsx
	 Y3MS5GUxWl1i6BzQQ3/QMClGkDpaxS4F2PLc485/8TvsXSl/M/1
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 6E3C4200B7;
	Fri,  1 Nov 2024 00:38:33 +0000 (UTC)
Date: Fri, 1 Nov 2024 00:38:31 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/3] ci: remove clause for Ubuntu 16.04
Message-ID: <ZyQjB8iLM1FIDbGe@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
References: <20241031234934.3451390-1-sandals@crustytoothpaste.net>
 <20241031234934.3451390-3-sandals@crustytoothpaste.net>
 <xmqqv7x74ws9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9hHO19zbV8z0UUZ5"
Content-Disposition: inline
In-Reply-To: <xmqqv7x74ws9.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--9hHO19zbV8z0UUZ5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-11-01 at 00:34:14, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > We're no longer testing this version and it's well beyond regular LTS
> > support now, so remove the stanza for it from the case statement in our
> > CI code.
>=20
> Something like "we replaced it with 20.04 which does not need the
> corresponding special casing" would be necessary to explain why this
> is a good change, as opposed to an equally plausible-looking patch
> that replaces 16.04 with 20.04 and otherwise keeps the "stanza".

Sure, I can mention that in v2.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--9hHO19zbV8z0UUZ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZyQjBwAKCRB8DEliiIei
gR6BAP92jc91JHzE6kt4+CQa3aBZ/StQF0QVvKYHPbKqNR+OoQD/dvikofdd3Q1T
dSOInccoad2TI3G55sA43atLfvrSaAc=
=eMw9
-----END PGP SIGNATURE-----

--9hHO19zbV8z0UUZ5--
