Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0453D2EB10
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 08:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764936; cv=none; b=fR4yv3OYFt9SHMpxXN29R5UJLM+0IqeZWCXO+y9JT3l29yRUl4x3j4XvdMMrHb+kmpzdtle83NnqEu+sX3BTrZST/xWxinU/mUBxSwp3Jzj5QBd2oHnLAKGfiLjGbP/bLw6Z5sfSYyqtD8Gg8e9v2FE6aTCRhdIgpph2+uhyIWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764936; c=relaxed/simple;
	bh=lspvOEWb3bstyV/1O1IEJJx8skzWrxr1c2FbZ54FscU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVX4HFw+o5/aXpYUlfKJ8MU3bMvNg2UstxGnorm6pftD9mo0kSsIsG5iC2dbBMKkMF+mN2TtIM8HIH/UO4+gUdmDTa+N9do1FVZFGcgz++vFGHhMRBFXuVOpTfUxjDd1gq/KsBVMLd7QXxzYECk+OBP91keS0t1+GyD1BBvFfK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=hbQulD8x; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="hbQulD8x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1755764926;
	bh=lspvOEWb3bstyV/1O1IEJJx8skzWrxr1c2FbZ54FscU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=hbQulD8xQ4JPj1b31dE2VO8YSczhjOqIInmV/zEV3mJ7Egd6DGcId/uTCNe9ZRVZw
	 YPgsMNsDJB8u2tpjAf6VOKF5RVmXPjqCvdsii8Q/78L1VpLhD157E4UTfHhIKIM0zZ
	 rDKKJ5URJssuVFWq1Ais7SULSg2D5eaegxqTpgG835XTZ0qFDw/USbTObrxRDM4llQ
	 C/ieTlGj5opQ4c5W1717xWHeAGnei6IoFMpw3GNNSDJe/6+PE3AZRQqpamwKeRlVK4
	 yTEAnlsCKEpFtW8oX1yUCdMJABhaoMaL7a+tyM9n7ojQE8qZWq2pDC3lSsTpspuMsE
	 7UZDuHDhVBonkldtmRhY+fFaIv8LLh5wxUwoC8SzR18nVlGwAgnr8+/JVpaXatFpXJ
	 zfAy/XRtAtmZP7kVKaHUT50u4kdLNPIk0+cZNC435dr+o5JJSyVdZy2SglePx89oPR
	 HtBavqgXokTk3Z7Mr6QTaQVda9Kq6dzMoJlTNQQR/JtV/88ul+y
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:cf30:27f6:1b7b:28f6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4AC70200C0;
	Thu, 21 Aug 2025 08:28:46 +0000 (UTC)
Date: Thu, 21 Aug 2025 08:28:45 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: git <git@vger.kernel.org>
Subject: Re: git: prepare to regularly change hashsums
Message-ID: <aKbYvbWWL0FGXpG7@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Simon Richter <Simon.Richter@hogyros.de>, git <git@vger.kernel.org>
References: <198c2b87f70.ff0fbb4065293.4919681043907358329@zohomail.com>
 <aKTqHTnOMp1LFNLD@fruit.crustytoothpaste.net>
 <e069a7ca-fba4-432a-9a05-a68b2b6ddbc7@hogyros.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gg3sE78BDtGgqBuT"
Content-Disposition: inline
In-Reply-To: <e069a7ca-fba4-432a-9a05-a68b2b6ddbc7@hogyros.de>
User-Agent: Mutt/2.2.13 (2024-03-09)


--gg3sE78BDtGgqBuT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-08-20 at 05:55:43, Simon Richter wrote:
> On 8/20/25 6:18 AM, brian m. carlson wrote:
>=20
> > There are many fewer places where we have hard-coded hash values in the
> > tests and a lot more places where we compute values (for instance, if
> > what the test wants to know is that we're three commits before HEAD,
> > then we write `HEAD~3` instead of a specific object ID).  Instead of
> > lots of hard-coded 20- and 40-based constants throughout the code, we
> > have a few #define constants and a hash algorithm abstraction.
>=20
> For me it would be great to still be able to use commit IDs in this way in
> the future.

You can continue to do use object IDs for this purpose: we're not
removing them or deprecating them in any way.  It's merely that for our
testsuite we're relying less on object IDs to make it less brittle.

> So if the hash algorithm changes I need to either still be able to make
> ancestor tests using the old IDs, or a quick way to convert them.

Existing repositories will continue to use SHA-1 unless you actively
convert them.  The change is simply that _new_ repositories will use
SHA-256 by default (again, you can say that you want to use SHA-1 for a
new repository, just as you can say you want to use SHA-256 now).

I am working on code for interoperability between the two algorithms
which will allow you to convert a repository simply by cloning into a
repository using both hash algorithms.  That is, the remote might be
SHA-1, but your repository will have SHA-256 with SHA-1 compatibility
enabled, and then you'll have both algorithms.  You'll be able to look
up SHA-1 object IDs in that repository very similarly to SHA-256 object
IDs and convert the two.

That code already exists and works if your repositories are not using
shallow clone, partial clone, or submodules.  It just has yet to be sent
upstream.  I need to improve a few things in the current status quo
before I can send out the series.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--gg3sE78BDtGgqBuT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaKbYvAAKCRB8DEliiIei
gXJEAQCgevmQJK6jOiM7GTfrYiIET7DgZRN+Gve4FGq8iOhJtAD/VF9FlYDnIDvu
uYWvaU+U292begGOEraoysbD01iPsAk=
=H8rk
-----END PGP SIGNATURE-----

--gg3sE78BDtGgqBuT--
