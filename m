Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9CF20E704
	for <git@vger.kernel.org>; Sun, 13 Apr 2025 22:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744584774; cv=none; b=WEqfgSwCP8IdhIDYBeXcTokANSUYoHrhQVwcn8nRhQa1JUiez8ZVttpmFxS+0L8zHlIsR7Bcn55IWtS6r1DeNiFIBZYWbXJI5kf/iQlo3v1YJjv/GJMafTuWXRv6/XImfI0vxRLyZIvQZmJMluxpHtTA+ZTV3fgPfZMYweK2wJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744584774; c=relaxed/simple;
	bh=LO75X6jd59LkSy1a4P2aDKQqGZH56iuj3yQlYe07CSQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bV73a3rOKy6nrfpJE55TTnDNpR2A+vDOVaoFAl9/SX6VfnP4/RqUp5vTNfXVHZfN3xo0qzNCJGSlw1aAfXMWF/bO3MkAxUVkNhxAojESupxbfFEMzH6jjDkEafHShXo2qT8qzBurGlZs712+L28eCKQ7295+8PVoecnHUXt3NTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=uDBfH9Lt; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uDBfH9Lt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1744584763;
	bh=LO75X6jd59LkSy1a4P2aDKQqGZH56iuj3yQlYe07CSQ=;
	h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
	 In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
	 Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=uDBfH9Lt/waNrU2G2mif26uzQHmbTclGcDCUSBCgN1jqrbCGq9a+3B2290m5H2adh
	 tGnehbpByKUzTIKkX+OnHp7BwEeWPAPn6swvUmqyqIXj5eCeFRohs8VgZqQ/Jnub5b
	 NfyFQSRkCtMTnayY9V/vVtkz3WVEIIGTFmcOoIYIKY8uCnyp18j1FvpkoxLp9WYwL4
	 tJ3IfIBuFRW0du4P+SwF6U8LjNVETWYEmHtYTpV8sNqCD69Csg19cb7tAVe75WmrkI
	 oHHwRgkqWAHm5PMgVoPem9IhbYs1Ky6AWKpUxis+OHOr/TxEqFzpHkXDiMm/RJr5Jq
	 lzZtjrUN1MOI7V1qkeZ9JayjKwX3RDKzoyg05WiOQ+MYTQJzdrGz91Gfx1xs5ku/pv
	 WPQ5Hw2oCE9TO7Et2cCDwaq2GlD26ZSh6S0LmMffJ/unwjZEJsNkoTsNiR0/V9Xmd9
	 OAlqRw/40Yq0rSTqSBORbBCicBQ+k33hAkqUcoMCMYxUzvneIvO
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7F1BB2010E
	for <git@vger.kernel.org>; Sun, 13 Apr 2025 22:52:43 +0000 (UTC)
Date: Sun, 13 Apr 2025 22:52:42 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: git@vger.kernel.org
Subject: Re: How to gpg signed email patches?
Message-ID: <Z_xAOmQm0e_WE2Dd@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
References: <fx2ofmmhkjmjqfqya5e3qvmovvmpnjepteqobcz4eia5sw64bg@yquuljpwok3f>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bCv3ur03AqYtHF8X"
Content-Disposition: inline
In-Reply-To: <fx2ofmmhkjmjqfqya5e3qvmovvmpnjepteqobcz4eia5sw64bg@yquuljpwok3f>
User-Agent: Mutt/2.2.13 (2024-03-09)


--bCv3ur03AqYtHF8X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-04-13 at 19:17:26, Klaus Frank wrote:
> Hi,

Hi,

> how do I get "git send-email" to send the patches gpg signed? I tried
> first signing the commit but after spending time looking into the
> documentation I couldn't work out how to do it. All I discovered so far
> is that the "git send-email" appears to be using "git format-patch"
> internally and that's where it currently gets lost.
>=20
> Sadly none of the man pages I looked at so far mentions anything about
> gpg signing in this regards. Not even "git am" does.
>=20
> Ideally I'd like to have "git send-email" send my patches gpg-signed to
> ensure authenticity and integrity.
>=20
> I also considered alternatives like using my MTA to GPG-Sign these mails
> however as the "git am" documentation also didn't mention gpg signing I
> refrained from it to avoid breaking it and causing issues for anyone
> receiving that patch. Same for sending it using "git pack".
>=20
> Is this currently a limitation or am I just doing it wrong?

I don't think Git supports this out of the box.  The proper way to do
this would be via PGP/MIME, since clearsigning the patches would result
in them not applying properly (due to the dashes being escaped).

More notably, I've had problems applying patches that are signed using
PGP/MIME because `git am` doesn't seem to understand how to extract the
data in all cases (maybe it does in some cases, but I haven't tested).
As a practical matter, signing PGP/MIME requires that the enclosing body
be encoded as either quoted-printable (recommended) or base64 (not
recommended because plain text as base64 tends to be a sign of spam)
because that prevents breakage from intervening mail servers and
that can introduce some trickiness in extracting the text without
parsing the MIME structure.

I know that Git definitely does not know how to verify those signatures,
though, so many people would end up not verifying them.

The discussion on the list in the past has generally not been in favour
of this approach, since the assumption is that the patch is accepted
based on whether it is good or not and not whether it is authentic.  I
acknowledge that there are workflows where authenticity is useful,
though, so I would not be opposed to seeing patches to implement this,
but I'm afraid that it has yet to be implemented.

An alternative approach, which has also been discussed (and which I
might end up sending a patch for at some point), is including committer,
signature, and base commit data in email headers to allow reconstructing
the exact commit with a valid signature.  Whether the maintainer chooses
to keep that signature is of course up to them, but this would allow
the commit to be verified using the normal mechanism.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--bCv3ur03AqYtHF8X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmf8QDoJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ84cpw938vseyG1dTYLiT6V7TFCL0eTcpf4697Nd8znw
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAEsQAQD4HUP/iJ7cI8jXL0tlRrN6BxQb
jbJdStSRmRdMqfKLggEAtny4sM4gBIzQ/64j419j+ZpN3dDbKBl8ytl5WgbrPAo=
=aVC9
-----END PGP SIGNATURE-----

--bCv3ur03AqYtHF8X--
