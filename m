Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AED14D283
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759250404; cv=none; b=AX3JLNMIE1DBRcL2+RM0vAd6gkYVWxHw8mbCIrwAnSL7em0KX8M99FdVM9dCngFLAAWkVzO2AGB9n8zgF/cEBX/JeZhbcb32TR0zJMIZc2TLLtFzEJLwr7rgGNBoKW2TD3/LFa8m8VgTpNR9l6K3eC1WJEmYFp0ggg+UXEaCp1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759250404; c=relaxed/simple;
	bh=zHNSkjUiEBLamcbfZN80BScGfH08Cg0KcF8h3kz1V/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnCuG+JtY+5Os7sdhU3/IUhkeyPaSYIxecAOQVEdtt/8rMDKE+L83P34JkfcipD2UhJhvQzpSkXNrjjz/m4oZxA6S5dYIgXsZE/mf/IyiT3SYGdxiGM1juT+h4zyMSCYO2ZANzqQc698x9kcG7ORkBnfGVsBR7v40APfpQUTnkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=MCCLQcDT; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="MCCLQcDT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1759250401;
	bh=zHNSkjUiEBLamcbfZN80BScGfH08Cg0KcF8h3kz1V/o=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=MCCLQcDTVsDjzO+B2+np1csVXFnYCmJ2PNIF6x1+oBL1PXEf4/Lgw9UKEURsB4O+o
	 VWYN7On0jA5vCUIJHUQrNTQFv/nckqK1PjN36S5gCBjRo0aESckjy0TUF7b8vaKNE0
	 Oqt0XzaBL40I9bT9lVI723ZtDP3iyKHceHVDPaWrt9yQuIoOYIytZH2PaYZhlMv5j0
	 oycGpHAfHS//j2EuD6EoVHUl99+aIqhTt44x53wNdyfn6gHsWhJ6AdYpuy+AHzwxbo
	 MYGoR1t/Pe6JNuBc+3BO4tx0r/zRmpRQ5Do977KOnriPdZO0ucDz6NrRFu42gafJmy
	 12wWA2qfWtrvFhVIlyLTQvZ2jA+e8rcMYffCv26kTRVCkTIf2Y3FiAi+z1opma6dBb
	 X/gIEkqyee3VxRiAqPqATa5mt56SMQ/OMgiA1mOmhFCX5rubzH6FxDBFdU1Bou7Ssc
	 sxaAhB1L4nwcnlfNqSz6a6tEMipB1GNKYtzy5JOdoSjAllTjYs9
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:3c0c:de88:5b0d:9364])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 1471120119;
	Tue, 30 Sep 2025 16:40:01 +0000 (UTC)
Date: Tue, 30 Sep 2025 16:39:59 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 5/9] docs: add documentation for loose objects
Message-ID: <aNwH3wqMzbNMpnEB@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
 <20250919010911.649831-6-sandals@crustytoothpaste.net>
 <aNOkBuigxCODIcVN@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lHw28jTdidSW8HEH"
Content-Disposition: inline
In-Reply-To: <aNOkBuigxCODIcVN@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--lHw28jTdidSW8HEH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-24 at 07:55:50, Patrick Steinhardt wrote:
> On Fri, Sep 19, 2025 at 01:09:07AM +0000, brian m. carlson wrote:
> > We currently have no documentation for how loose objects are stored.
> > Let's add some here so its easy for people to understand how they
>=20
> Nit: s/its/it is/

Will be fixed in v2.

> Do we maybe want to call this "gitformat-loose-objects(5)"? "loose"
> feels rather generic.

We have "index" and "pack", so I'd rather keep it short.

> > @@ -0,0 +1,49 @@
> > +gitformat-loose(5)
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Makes me wonder whether we should also have gitformat-reffiles(5) and
> gitformat-reftables(5). Obviously nothing you have to do, but rather an
> action item for myself or others interested in the ref backends.

Yeah, I definitely think that would be useful.

> > +SYNOPSIS
> > +--------
> > +[verse]
> > +$GIT_DIR/objects/[0-9a-f][0-9a-f]/*
> > +$GIT_DIR/objects/loose-object-idx
> > +$GIT_DIR/objects/loose-map/map-*.map
>=20
> It's a bit weird to list the mapping files here without explaining them.
> Should we maybe drop them for now and only add them once we also add a
> section explaining their format?

I've bumped those two lines to a future commit (probably part 2).

> I feel that "most of its primary repository data" is a bit misleading,
> as one can expect that most of the data should be in packfiles instead.
> How about the following instead:
>=20
>     Loose objects are how Git stores individual objects, where every
>     object is written as a separate file.
>=20
>     Over the lifetime of a repository, new objects are typically written
>     as loose objects initially. Eventually, these loose objects will be
>     compacted into packfiles via repository maintenance to improve disk
>     space usage and speed up the lookup of those objects.

I adopted most of this language.

> Should we maybe give a hint why we have these sharding directories?

Done in v2.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--lHw28jTdidSW8HEH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaNwH3wAKCRB8DEliiIei
gcAxAP9bsSA74nn5LstvSY2Yb6EZ6LUVHaAwSUCePkjozaeAfAEAi5G1WrLTI6GU
ufraCBcgv2fZq3nNbU6/5XAvOTcKcQg=
=Ja8N
-----END PGP SIGNATURE-----

--lHw28jTdidSW8HEH--
