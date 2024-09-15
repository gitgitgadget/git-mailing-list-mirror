Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F537DDAB
	for <git@vger.kernel.org>; Sun, 15 Sep 2024 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726414690; cv=none; b=uwRuzApuUK7mkY2KdToDbLCklmpGYfZcXL6DxdL3S+AK0OBgin3XO8rTLphjxC1Iu1ZhnUSFWbwL5mybczq8ZefCC2+92NY0U7dIXn5M4b8ePhe/iXruBPhOihxcG7M+c+bC4uGCYXA2dyz7JEUe+VzWmoPykhT5rSA6yo154bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726414690; c=relaxed/simple;
	bh=9RFw5hPCrymV0evLPpGhJ5GwwfqZ8gqm6tyFpZu2Vb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kv+QuZSZ1V+wc1MCAVohmvLrAmKAbTktwSbLYXyMHp8IYMjnPDube2NblzH1tUeYC/ucn0fmrTX6npQoJUDchXq4mnUykrCALV80x3iRvUofsw2X85FKpGVlyWxikwPALb18sFIo0als1UKn3Zf6Who6PLZYZ//6HDH878Zb62c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=XDBgHjgu; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="XDBgHjgu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1726414679;
	bh=9RFw5hPCrymV0evLPpGhJ5GwwfqZ8gqm6tyFpZu2Vb8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=XDBgHjgu6LQqsUVdgmXNevELHnxO6xBsdwVP89W/Fxn9UpnfnSSNkEMpTw1CLbAzU
	 WD4SITemfYfseLxDGdh/uZWOK/Vwk4xXWv/2PPQtDg0dLMNaFrFIecPMcZmnLTpiaZ
	 gn/atwXIM06OYjho0+NwghiSu6XgnazwE+HJI+/3O5k2VHjv0gfqi4ZYjSfBjeCu8Z
	 4ctfvUeJgMgnWeZW36VAtnYns/ocgIs4SKEQ8cbB5urpXIDFtSIyP4k+aiQJeLs8+E
	 weKQM/fCsvK68qOh9XyVeUijnkhT0Cad/jOjwn02DxV4SFUcHYGMFoztoHfmm9//gB
	 f8bkft90WtKGfd45nKHPNA6mXmtLs2DCezJdp/XM/k8CTqg8Pzr1SBdiAPbVZcrMKX
	 1vrQHTlqREvDGvgsqBsVvJmnrOUQBkGQNiczS7/j1S1WafTBNr/TH4iczb+dMyYTD1
	 FR3f07u6GeYOLWIwqfOZVatSUamBTLjI0IFPSo28Yd67CNmmL+m
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D22EB20077;
	Sun, 15 Sep 2024 15:37:59 +0000 (UTC)
Date: Sun, 15 Sep 2024 15:37:58 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Luis Guillermo =?utf-8?Q?V=C3=A1zquez?= de Lara Cisneros <lgvazdela@yahoo.com.mx>
Cc: git@vger.kernel.org
Subject: Re: error ubuntu 22.04
Message-ID: <Zub_Vi9bcgSCodEV@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Luis Guillermo =?utf-8?Q?V=C3=A1zquez?= de Lara Cisneros <lgvazdela@yahoo.com.mx>,
	git@vger.kernel.org
References: <ec8a1a28-2e16-4e4d-8329-eae6fabd22ab.ref@yahoo.com.mx>
 <ec8a1a28-2e16-4e4d-8329-eae6fabd22ab@yahoo.com.mx>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uImZNai4+2KBPewv"
Content-Disposition: inline
In-Reply-To: <ec8a1a28-2e16-4e4d-8329-eae6fabd22ab@yahoo.com.mx>
User-Agent: Mutt/2.2.13 (2024-03-09)


--uImZNai4+2KBPewv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-15 at 14:44:44, Luis Guillermo V=C3=A1zquez de Lara Cisneros wro=
te:
> Dear Sirs:

Hey,

I might suggest just omitting this greeting here or using something
informal like "Hi".  We're not all men or "sir", and this is a
relatively informal and collegial list.

> When updating my system (ubuntu 22.04), I recently started to receive the
> following message:
>=20
> Fallo al obtener https://cli.github.com/packages/dists/stable/InRelease=
=C2=A0 Las
> siguientes firmas no fueron v=C3=A1lidas: EXPKEYSIG 23F3D4EA75716059 GitH=
ub CLI
> <opensource+cli@github.com>
>=20
> How can I solve this?

This is about the GitHub CLI.  The Git project isn't affiliated with
GitHub or any other forge, so this isn't really on topic here.

However, I happen to be aware that the GitHub CLI rotated the OpenPGP
keys they use to sign their packages recently and you can see
https://github.com/cli/cli/issues/9569 for more details.  Hopefully
that's helpful and if you need more assistance, the GitHub CLI team
should be able to help.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--uImZNai4+2KBPewv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZub/VQAKCRB8DEliiIei
gbdiAQCW7mL2gb7EhUkZa6sfYDFmavzVfHXSKrcAReMKbQw4QwD/XJKouWBCkZ08
0xt7K5/YUMwGNjujAXq24k6nEJEHeAE=
=FWyD
-----END PGP SIGNATURE-----

--uImZNai4+2KBPewv--
