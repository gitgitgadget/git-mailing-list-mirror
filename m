Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE99C2FCBFC
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244633; cv=none; b=hUvYbmCubhOLlh3GzIqifeKK89nqvTIGc0AQ8XfZV7b9f+NXjH4stiuVRc7U2Sranpevi/POnceh9e/vltIrAF6nTmnLrvGiRCBavE+EnnYPLCt3t7k8zrxnaoKuW5wOXJObslxyvu/bG34UOKAhTJ8a9/y61fhxNAY1DD5cc0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244633; c=relaxed/simple;
	bh=0l7Lv2KN+TeBFngr0wlitOYIAk9VjZ10/IiL+SLIIbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWz9Swna19Cem8aKq5bdn/Z0vn2B9UP4pjiERbCGYTj2sq5gnOHWTwOh3Ozy9NirUgmWSR/ylPuM6Tb2Sg1Lc5RMltV0qh0ssVIw2/7PhDjZ04RyJaDbckxNNvhIJhCQ0aCf36TLXDb4r3za8/KDKvk/N5alVfQH2PWc4G1CLpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Awpgkfs5; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Awpgkfs5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1759244629;
	bh=0l7Lv2KN+TeBFngr0wlitOYIAk9VjZ10/IiL+SLIIbI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Awpgkfs54jsNNkw+jGOIcpg7IsBsJQRDS5Xy0m1oHiwoj+63sRdF8ApIhoQVQh/jq
	 0Q05gn6Njd4w2hOkJFWMXsfObAqq0TuOTZ1lurVAMDlPjfEtRze25is5WtsznddtQW
	 BWxAVPcyBSQ5tcw/zFYBwqmtLoSy88pAi8KE4I89JHW6NzQiXX4h3OROcaEwBewRgR
	 Gx0n2aM8KGXKOfTlvbge5QTFFxoR7xyuw3AT2SDIxeC7ZQvlsrjHsYvvSolih3J2r0
	 mPjjBR+aFPh2xTe2W/d7orucjapJ8HgtlOobkMM+dSI+Rs3L8qQviNBmrTJxyma9fj
	 1DAt+5i6QD4EKWdSxq2EbZBN7nG7BrMqiTfShxtOYWkHtur3xwhxKOzznSiYlVewXG
	 jxlKW5OY51aOpwO9zlzIossrySnbAA+lhtVhKWMaVF3wFfg2E/o3Pe/AkZAs3yEznn
	 qc4hGKZD2HNjuEpC8/MmGLPTP/PCRDP93Rejug1zfCXaRuWgnQt
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:416b:3f41:6bad:4527])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7657F20117;
	Tue, 30 Sep 2025 15:03:49 +0000 (UTC)
Date: Tue, 30 Sep 2025 15:03:48 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: M Hickford <mirth.hickford@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: Feature request: partial URL matching for credential config
Message-ID: <aNvxVOUyijGaJfsr@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	M Hickford <mirth.hickford@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
References: <CAGJzqsn7BbaVckJ17XhsDHLtmS3OZPBG=oniwe+FRjhEwGc+Eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ErdJ9LpRwpXvL+0G"
Content-Disposition: inline
In-Reply-To: <CAGJzqsn7BbaVckJ17XhsDHLtmS3OZPBG=oniwe+FRjhEwGc+Eg@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--ErdJ9LpRwpXvL+0G
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-27 at 18:48:46, M Hickford wrote:
> Any thoughts on adding support for URL prefix matching?
>=20
> Example syntax could be credential.https://example.com/org1/*.key
> (explicit wildcard) or credential.https://example.com/org1/.key
> (implicit wildcard)

I think I may have added support for this (using the urlmatch patterns)
but didn't document it[0].  I see some tests for it in t0300.  Have you
tried it?

Regardless, I believe it's a useful feature that we should have.

If, perchance, I did add it and it's still around, would you be willing
to write some documentation for it?

[0] I believe Dscho graciously helped fix a few bugs in my changes,
which I appreciate.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--ErdJ9LpRwpXvL+0G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaNvxUwAKCRB8DEliiIei
geLUAQDQyn+HqcRsIdGZm+x7mPchlMGBB/abJFg1PXgeCWW4pQEApZ5gs/3xhQy1
1eeoavLki+I/dUBHHgw0tS0zm9APMgo=
=0oC9
-----END PGP SIGNATURE-----

--ErdJ9LpRwpXvL+0G--
