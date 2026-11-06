Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997988;
	b=Ckxcqyt0I/AEhXhZKYRsqfT7vVDyevsR9JhP0OreYt4mGHYIYPiehUD44Ii30eAunumM
	 xwJqjHSvjeQlRI1v1qgTEtpNiOB6yLkdo0rETZkTEuSeXogujI9pBqklZ5m2FElaM6qYg
	 gf0F0oysyxt8kqblNe5G0WfJ36rZpmsOT93nAZSJduv9qxVupCLZ11jEcoIcEKKFXT+N3
	 eDfWgK6NqDexAdKOZ0AhZMt9Rb2DiTZCQprEUV7urmPR6u0tH4Ub5fF0b4cqOn1X1wzFr
	 WFJ6Ykc/incVH89xngsuJ/AcbQae7PxnCUv1rJy9Fp/wc8gZrtX4ILX+ungknqLA6Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997988;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=7FXzPIvlQ+LPORZ89D03kBGjwqrQM6jvUPKLOIkWb4o=;
	b=SI2MWLmN7b9zLXgem2r95CMk1u633NxPNL1rKFB55AOE/LIW3tnMO5F5IBSx2xK+qo8N
	 mLUxUhN8RuuMIAeYalkbP8rPKTiO5UX0RV6G9sGBbcddhxJcAZthun4K8mffY0hyYuR/D
	 1u3ciWoXDOWz931JshqjkvffCpkhB5bCJl/UjVfk1VtFwqjtt84/cI/g0FIDIqumVFBqc
	 +xlayhbUyAOVqnPUvqQEIo47YtRwoWnwDgdIo6O3O4itTLMxwwyJeckvwQll5L9Lq/8pu
	 Q3V1n6RVuUYV57ro31ZGi2IkQq2C7IIwLoxmOjqqNeuZD03Oht7+W2gT0dA7xzjTIDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=TSKtt3KE;
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AB5606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 20:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92AB5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=TSKtt3KE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1793997986;
	bh=fvGPxWSqFy5frjjDcyZul56FSHEYS/f56nJLKwVK6ac=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=TSKtt3KEYDv3uWC2ckqf7WdY98kNBfCHysLsKV4m2UV7n45SwHMznuKCJWpKl9Zxp
	 FLq/X9NLgVBFs08SVkN2LK+M5+EEYCqUwgTICvr7eVHLLfqfJ2t62+0SX+RjGRTpqT
	 +B/7Ap0Y/KyZYL84TMaBvZqrj3NVUDXkfyjp9Wz4UZRMtEIw2FRYTecQQZHYNsqjoe
	 O8K+fExiJeQlHqI+EMuB45BHmoEtARcEwtPQ2P9Q4m/8EGbnDtYVyiuv07BhEOZ5jX
	 bnJCt9Qjnhq/R31cEpRAZsjGRX7uMUgscVsvfDc9UGB1Wr79e5DupPeTMdUllA292c
	 x3NLsrexSpCrL8wPrVRDLje0MCPPUAaGRNu/Pt1CjNQ8GWEWFIiM0/LK6/+MCDHErk
	 GuVzz5aFKUlt0UBtmgZobQdxZWXbKLMQSzU0IT4rfyCScibpFKnv4ACWaXIr3qNEQp
	 at744eHMBwLnRPf4TbN+PMpi7Mb6A26Tvx3QkNWQDtDw056ujug
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:828b:3227:a916:b7f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 02CAC200AA;
	Fri,  6 Nov 2026 20:46:25 +0000 (UTC)
Date: Fri, 6 Nov 2026 20:46:24 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Adam Dinwoodie <adam@dinwoodie.org>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: Default object format for new repositories in Git v3
Message-ID: <au48oHXom4FGzwb9@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Adam Dinwoodie <adam@dinwoodie.org>,
	Git Mailing List <git@vger.kernel.org>
References: <CA+kUOampvjU3=VK3VGhYw2L5-E+LBsk=Q0UrAxhhR7hC5SUdJg@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DImmDjSrzffVQ5Eg"
Content-Disposition: inline
In-Reply-To: <CA+kUOampvjU3=VK3VGhYw2L5-E+LBsk=Q0UrAxhhR7hC5SUdJg@mail.gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--DImmDjSrzffVQ5Eg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-11-06 at 16:50:03, Adam Dinwoodie wrote:
> Hi folks,
>=20
> As part of preparing for Git v3, in particular for Nixpkgs, I've been
> running a bunch of tests using Git built with
> `WITH_BREAKING_CHANGES=3D1`. Somewhat to my surprise, `git init` seems
> to still be creating new repositories using sha1 rather than sha256.
> Is this expected?
>=20
> For reference, I've attached the test script I've produced as a repro
> that can be run from the root of a Git checkout, although it does
> require Nix. I've confirmed the behaviour at v2.56.0, next
> (972d6e3ab651d838b30a8d5d70d8ef6ced05a986) and main
> (0ffa3e35c7c82ab8d0de226149fb03b3f7674d05).
>=20
> For a simpler repro that doesn't require Nix, build Git with
> `WITH_BREAKING_CHANGES=3D1`, then run:
>=20
> ```
> git init tmpdir
> git -C tmpdir rev-parse --show-object-format
> ```
>=20
> This will print "sha1", when I'd expect "sha256".

This does appear to be broken.  I have a patch that should fix it that's
running through CI right now.  I'll send it once it's green, either
later tonight or tomorrow.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA
Speaking for myself only

--DImmDjSrzffVQ5Eg
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmruPKAJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ5pTnswCH8tIiUqjOo9XXyY479zwaKRvSFiv6PDeP7ab
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAKHCAP9OtHwzHp45bOU0uqef1dB3i35V
iJqerR1FhOmLmMOV1gD7BFQS3uLDvL5trumhfveacjqSTg4x7UUKLmTDeanKtwo=
=8FuM
-----END PGP SIGNATURE-----

--DImmDjSrzffVQ5Eg--
