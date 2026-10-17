Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2DC175A79
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 13:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792244731; cv=none; b=D7vO2cscdKoYvXg8DhxG/GN980WHE/NhIpd93w0ufSk2R6weaDdt6QKkjWldmrzZ2VaeRVdZtmPIIafKKjzin0+rpRTULviNIeNFShdaA+9qCkEDKIG+8LH0BDRpH4VfkOMsCky9peJ/S0bmmUqseQklHFKXoe9K9wCyJYI3AUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792244731; c=relaxed/simple;
	bh=Zaf4qwuRidiFwpdrrIjXh8n9Hz6IVdWSB/73ATsyirg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2SRK8rDhb8lPI4MRecKcbnU0qmQSYgLEA8oShqPLbyFUa5dvIfcbb45JAW05DPP3Sd1BAfqiMFWvt69N7WcIWLlAX4s05LTyJQNLE+6WErdrTFCI3Ud3G58XDUyIdr8WAfCC0ZTBW33lqoSkfu5GI+iurNqWIZZTEwqlMXSQew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=yNhpbYNH; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="yNhpbYNH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1792244186;
	bh=Zaf4qwuRidiFwpdrrIjXh8n9Hz6IVdWSB/73ATsyirg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=yNhpbYNHI917FfBD+jVGHjYmF2Tzzp8kKPluN73KQQy+rsu/b2JHcc/m9b7NTsPi2
	 Ib+t2byJBaPbATvhHDs2SM3oPIGbUq7fVf93T0xCI3Ab08BsdStirXbS4zYdaOKbO4
	 t2i/9bPMQA5N3IIlyCDktT27oRWRgunheyTSF/n/e7r7mWNkMRCorDX5l8vpv/9jRd
	 CT7eeaXIcE0lCN+WpVR38VLDYIwx9EVloF6We2Akj+Q6V6mcVvbBbRvxsCAdR9/pql
	 //U1QhFWWXY4ee3xDRM5rhHFMudma0hD25N4qsX/s0jor7z1uzXwGtxEmeetZsdVGx
	 zuTo4bv6cDI5VMhqC/sDip7H6/2Xlfe4nmNCt8kNLQIRunhbp8niwXxgsp+Xs9llGS
	 nFmkW8XfDF5nB51KnLzRbvw+1zncWUzmNpBOY6ZzBliNj3Vs/ZAO/BqT1rsga0/+pQ
	 qjXRW2Eac+Q/cmn/+vhpL8L48HnmXyeTN+OhRHXbB9J96snwy1e
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:cd:73f5:f355:ccfe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9A225200C9;
	Sat, 17 Oct 2026 13:36:26 +0000 (UTC)
Date: Sat, 17 Oct 2026 13:36:25 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] github-ci: update macos jobs to macos-15
Message-ID: <atN52HNEzdSeh19l@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqfqy5clgz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vuxzExMS7RqFqOzF"
Content-Disposition: inline
In-Reply-To: <xmqqfqy5clgz.fsf@gitster.g>
User-Agent: Mutt/2.4.1 (2026-07-04)

--vuxzExMS7RqFqOzF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-10-16 at 22:46:36, Junio C Hamano wrote:
> GitHub from <no-reply@github.com> address keeps sending
>=20
>   Subject: [Action Required] macOS 14 hosted runner image is closing down
>=20
> and suggests to update to either macos-latest (macos-26) or
> macos-15.  As we do not have strong reason to pick one over the
> other, this patch picks more conservative choice with hopefully
> smaller impact.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * Not tested at all and I do not do macos myself.

I think this is fine if it passes CI.  There's not that much of a
difference in terms of POSIX-related functionality in different versions
of macOS, so upgrading to macOS 15 shouldn't be a problem.  I think 15
is a better option than 26 because we're more likely to avoid anything
new that older versions don't have.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--vuxzExMS7RqFqOzF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmrTedgJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ+Ub4kOGxiEkTReNCVexC+w8xNEwOcrZW5KN0EqS1Glo
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAA5cAQD7UjlLfSHCjBgCguzVlO6qWotM
wHXgaF6WwKG1JpJkBgEAzdvvkYLSrP6EZD7wldLOAwh0ZbkkzNqRMyBxIxhe3QM=
=7KQ4
-----END PGP SIGNATURE-----

--vuxzExMS7RqFqOzF--
