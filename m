Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4315D79D2
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 21:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728595420; cv=none; b=ZQM63p5KGFuSbRGaganMAglpEth9/uQX9Lhm2d3RhTWNP2OVsOSbkvfkBVQGWSfRibUYjGAhJ1P595lGWXqoJto3EjaSTQS+6HQbdH5nODjp0BweEPCL4T17mXmDcE7ZTDG/LUgnPLe2au90DQCqSyhvA+8pmS5CXPt+JUlaBvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728595420; c=relaxed/simple;
	bh=ku5Am2A1Nia0GGuXb+4d/aWrF3wIvPsPOfj3iPXygPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2H9VwQ21fMY5x1KtCBRuxBCQV6ie5NVzASRWQTrjd60kRy8lLTKQo+xtQY7/feqaef5Oaiff0Q3J32OjEsWDkj+xVHoUXiRpNAR/Ft+p+e37l6B12aQSUjrbu39IdZWxZUVqcVmRQThUgcNYSWOP0+zPmfmLkrK6WYm+X1Q9h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=J12gsXoF; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="J12gsXoF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1728595410;
	bh=ku5Am2A1Nia0GGuXb+4d/aWrF3wIvPsPOfj3iPXygPg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=J12gsXoF0GlJCvtoR5PsKeosKXrRmkZlFCrS8I7NiuoDrpNk0waZPcot+bxfvKTbe
	 vYGQP1iYPlL1PoZTOG5sRvRz2NwjeuSHm7PMOEfzj+hgS84dRDNzTKFpcecm4WQfay
	 j0oHIlmtqP8kc8Q18AWSBsJg/+vDn3eNi9VbRjRHepd87c1NwFGnZk7JmCgsrdSSMn
	 VjRhpdlIjtiHIVGy6s1GZYc6b/Fae71PNO3MD2ev1xV4V2ZA96Ee/HyqsO4eToCerd
	 yvV7R6Y9CeuzA/sbYpGq7x6SH7QwVBiYbhzPhu6xrlwk9D21NQR1ddxPXpzvUhWLiT
	 cYKT0LUG0a0nfhLErbA2blLUkKsdbFxijfqJbsHkrsJqOp8XqlpBn/ZoGAdJTv3Hpz
	 J4qpkVsMXJHIzt/knz4av0XbgSfLVwR4N0zzJdlTD1/ciP6EE06loxy+dle9IpZk9S
	 1HLVp35QioEUQA+ZImMyjCmyC8YZo6d3efuqzBTfriwSn+f3Skd
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3FFD22008B;
	Thu, 10 Oct 2024 21:23:30 +0000 (UTC)
Date: Thu, 10 Oct 2024 21:23:28 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Cc: Git List <git@vger.kernel.org>
Subject: Re: minimum curl version effectively changed
Message-ID: <ZwhF0OZ2gpLWUfHD@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>,
	Git List <git@vger.kernel.org>
References: <CAOO-Oz0NUA-YeyFT1MJ=XKyLWJvQoFH1b-F0EFOzvy8iWka3KA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ukiV0b3ctAVfI0he"
Content-Disposition: inline
In-Reply-To: <CAOO-Oz0NUA-YeyFT1MJ=XKyLWJvQoFH1b-F0EFOzvy8iWka3KA@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--ukiV0b3ctAVfI0he
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-10 at 18:24:52, Alejandro R. Sede=C3=B1o wrote:
> As of ad9bb6dfe6e598d87ffe6e2285b4b86dac3bc726, http.c depends on
> symbols introduced curl 7.37.0, which is newer than the documented
> minimum version of 7.21.3 in INSTALL.
>=20
> ```
> In file included from /usr/include/curl/curl.h:2238:0,
>                  from git-curl-compat.h:3,
>                  from http.c:4:
> http.c: In function =E2=80=98set_proxyauth_name_password=E2=80=99:
> http.c:655:28: error: =E2=80=98CURLOPT_PROXYHEADER=E2=80=99 undeclared (f=
irst use in
> this function)
>    curl_easy_setopt(result, CURLOPT_PROXYHEADER,
>                             ^
> http.c:655:28: note: each undeclared identifier is reported only once
> for each function it appears in
> make: *** [http.o] Error 1
> ```

=46rom the curl changelog, I do agree that that feature was added in
7.37.0.  I think that's okay, since that was released in May 2014, over
a decade ago, so we probably need to update INSTALL appropriately.  I
don't think any major Linux distros are still offering complementary
security support for such an old version of libcurl, so I don't see us
restoring support for older libcurl.

It will probably also involve ripping out appropriate parts of
`git-curl-compat.h` and the option flags. If nobody else gets to it over
the next couple of days, I'll try to, but of course anyone is free to
send in a patch.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--ukiV0b3ctAVfI0he
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZwhF0AAKCRB8DEliiIei
gdMsAP0fRt15HsnN39AcmGRIRQwA6kF8jb++tB4qvt0QzC3muQEAzQKRcj7RdHNq
qE9TjpMylGGGtr3WfMmt95SasjINtwE=
=tGRC
-----END PGP SIGNATURE-----

--ukiV0b3ctAVfI0he--
