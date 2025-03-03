Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D9C2AEF1
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 23:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741045579; cv=none; b=olisHZd3Z4SXbwip4c9/wDF9Zg2N6viLwltAxR3LqnhzzW4bj2iZpl0v663ECaJzJqJZOTFu1QLPqqzRn4J+uRTNd2k5zGHQyWTGSjaBUXKkndMAoWyEvXFDiz2cvsosMHmysQlXlMW16N+DMuHsLjtAb6EJhJuNlDod+FTmQkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741045579; c=relaxed/simple;
	bh=sHzxxukhlfFuvuyNhLgMG3sOvt5RqBP17w8hCcMiLfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roeyexDBEg9cgbMIB1oHyXEOg1V1JrMxulvVaNkXPuJLnejCx3seFOG0SUA/Gw5svWjF98CLhOp79xRgVFCJnaYHVOUQqdAcJcdsEOAUm5ZmdUgLNg78zEKDlh1w/l+BUXVWoGfOdm7Lw8RMviK/1PTwe97AIaHy37I2QXvH94I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=pXHhh5ym; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="pXHhh5ym"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1741045569;
	bh=sHzxxukhlfFuvuyNhLgMG3sOvt5RqBP17w8hCcMiLfM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=pXHhh5ymPBL1/a3Pa1DlANSlWBgtpjf+EDD5CwGBxHmX0nMmsC1R3zdX4Z/+OxJ0x
	 j45LY2fLiwdxNE2jPj9+4xrpTju/+aYuDF8D54OZnAmaJEtgEXAUqg/Z0vFsjdI98c
	 ul+EAhRix9R+/SdPuIrA0ZTb+PhPYtpBXyaXsI6SxWRHkloTi2HCYOxwMFBzhC9lgW
	 s0pS1Wh0Mfk9rSFnzQEL/AVG3ul5j5Igz0DHn3SaMVGBZVqCQbdPvKAGaXlzkzi1LD
	 bAyKW816L0TLPa7gbdnJpDrIDMDYeSUk2vd60u89NhluIyrs93icgZGbsoAR1OBzgV
	 Epvg3IFeuOb6nFkzn/PgsfWdqfyWGnMwXzuvTY4QE3uzVRzk26G28g7FzCUs5SoCqA
	 7vJV9fTfbIVx/4J7VKubyCDTjG7pf85zXagoO9YqAm787QxlFBjo6Yxl2x9tBE68RV
	 gTF51G9TnjUf7pEXxKSBwqlgVIYfRymGFhSAre1/+AhwEirJzAD
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0474F200B3;
	Mon,  3 Mar 2025 23:46:09 +0000 (UTC)
Date: Mon, 3 Mar 2025 23:46:07 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/34] misc *.txt -> *.adoc fixes
Message-ID: <Z8Y_PxXsYndBV64C@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
References: <20250303204443.360595-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YorVpMzWiITYgc72"
Content-Disposition: inline
In-Reply-To: <20250303204443.360595-1-tmz@pobox.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--YorVpMzWiITYgc72
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-03-03 at 20:43:58, Todd Zullinger wrote:
> As a follow-up to <Z8Ni0EyQYgD8uWJ0@teonanacatl.net>, this
> series aims to fix a good number of the remaining references
> to renamed *.txt files in our tree.
>=20
> The first patch fixes an actual issue, where we were
> skipping all the tests in t0450-txt-doc-vs-help.

All of these seem reasonable to me.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--YorVpMzWiITYgc72
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ8Y/PwAKCRB8DEliiIei
gZSmAP0SaFF8KTKQ9z2/8/9MT4oHY4oTWLsJsxsMworSqEVAKAD/XymPVLefvDoq
+8edpMBHg/7PB4N+dDZdf149GQKZBAg=
=2Ufw
-----END PGP SIGNATURE-----

--YorVpMzWiITYgc72--
