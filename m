Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85C52114
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 12:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074763; cv=none; b=qgsfmE1IJvB+4CJxIdPS31KR/oVjqTmDfhJNABejbP7WiZAAbepghcBkg7hDdRyrP5AsBDyxdzCeXXuqkdKTfvKyfy56TewyoI8KwtMJ6x0EVzeYpSGS6k4mUB9Sf0/onaukoLP0AT6XNmhCpuh42Hg6aMIHSfxhoGZYDom3K8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074763; c=relaxed/simple;
	bh=kIh4cD42YVIgw2O0Mw0FVXfkBk4e7bWiQTBcc5CoVF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ne8skmDN6PlMbdvg6ZCT7KTRzcZQ6nj5iMrG4XYFqgRbPxuilUFSnaF8j7FAtAyBm/RSOBIgoLS+szEcuj/OUEIu47Uj9A6/LGxPjpZyleS9QNIki3b0IxjViyynOdA5YL+q8fVjHn/cxBtmxTkV8J9U69Z2CTcJeOQHK5XHsh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=t7HU7Geu; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="t7HU7Geu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1757074754;
	bh=kIh4cD42YVIgw2O0Mw0FVXfkBk4e7bWiQTBcc5CoVF8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=t7HU7Geu08HiVUAlESh9gBbyF5c9SDIKFCQQclLqurlQp40AvXsQyiV1Z9gkntt+V
	 NKy9YQG3g0WacYfAscQepDVXWoH0yyvCWS/JjQX2M40tqPLqWggLp5BrvoanfJK+TO
	 sc5qTflzja7zMwWwi/1qQp8qW0jhnbzdTezhs++Gxn0dvvw+oXFk+vctRT4z9cjzKE
	 Wcutg6Bngvp6Hs/+6HcBNiYFGxFZN5yDqrMkjX4k9kR9QUjzGQ2Q094RqtXy/cWGa0
	 Zs9BOdojYXEeWPr6NT6X4La2blK7SWqCfSj+90iylj2LleinNYzY4Jdy58QqZ72F/A
	 ueNY4aZ04Hz9N/OMWq46Hfn0yoBLinERvJMO7EY5uBB7oJ779m+aFDk4ZYHEo74QBL
	 Hw1frvu8cCM7a1mk74fD7d6/E7y/7aizeqVoIeSGfqykEDizXvJLZ+Z6mmRPIHK85V
	 Rfg0Oc7j1JqKzHzROxk+G1qII6IaCLClGoOYZuTTItu0MW3n4uu
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:bf12:8113:e329:8d0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4CFF520100;
	Fri,  5 Sep 2025 12:19:14 +0000 (UTC)
Date: Fri, 5 Sep 2025 12:19:12 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: git@vger.kernel.org, gitster@pobox.com, Patrick Steinhardt <ps@pks.im>,
	kernel@pengutronix.de
Subject: Re: [PATCH] GIT-VERSION-GEN: Use standard versioning suffix
Message-ID: <aLrVQLZpAf-WqFvY@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jonas Rebmann <jre@pengutronix.de>, git@vger.kernel.org,
	gitster@pobox.com, Patrick Steinhardt <ps@pks.im>,
	kernel@pengutronix.de
References: <20250905-semver-v1-1-3f6dd32f71a3@pengutronix.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UDSwJYqsNtZYNXn8"
Content-Disposition: inline
In-Reply-To: <20250905-semver-v1-1-3f6dd32f71a3@pengutronix.de>
User-Agent: Mutt/2.2.13 (2024-03-09)


--UDSwJYqsNtZYNXn8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-05 at 12:14:38, Jonas Rebmann wrote:
> In snapshot builds of git, git-version uses a modified variant of the
> git-describe output, e.g. 2.51.0.178.g2462961280 instead of
> 2.51.0-178-g2462961280 for seemingly historical reasons.
>=20
> This is not semver compliant which makes the output harder to parse in
> tooling such as b4, which currently errors out when using a snapshot
> build of git.

Git doesn't follow SemVer.  We make breaking and incompatible changes
without bumping the major version all the time, so it doesn't make sense
to say that we should follow SemVer for version numbers.

I would say that since Git has had this version number format for a long
time, b4, which is much newer and should be designed to work with Git,
should gracefully handle the Git version number rather than have Git
conform to b4.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--UDSwJYqsNtZYNXn8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaLrVQAAKCRB8DEliiIei
geTtAQD1gRMd+qIFVvZzS8o0+wXtGf9DnOUTPm2dK0QawiNzSAD/Wg0UyXXMZhfA
nlsDn8XwDjcq2vCj+784cNSIdiBEwgE=
=wCA8
-----END PGP SIGNATURE-----

--UDSwJYqsNtZYNXn8--
