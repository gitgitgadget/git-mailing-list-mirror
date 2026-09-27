Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5934925B0B6
	for <git@vger.kernel.org>; Sun, 27 Sep 2026 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790517351; cv=none; b=sj4RTM14KVhHhoqS8tv8WMEYqJvymoACAHckC1sgHSGbCcXNCpT/r4Hjl5f2I6dqBVuVU0+DLFiZrmE+LA648hRh4xio4v6gv/5p7YOjdrmevOrk/+MtPCxEJTPizhay5vhk/nDmt+6LrJbGqBXBIj9xUGbeW0qusiQAYd0h9rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790517351; c=relaxed/simple;
	bh=PwBIF3FFJ2GhXrI6D64tS9OOwGCkQle/FAtKxE6Cf04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3X+0D4avWV6+m7RmZ3pNn9o2IELSJu5qjiwZtHVe+Zl4zZDI7D5Nw3lMmh55E/haPv7Np5eUBZP8hcCpvuj92lxs/HLxwUr1L52sisn9HK7xN4hPydyQaSPBd8lN74sDGqRh+FxPk8EyqlUavgcr6FCgs+kwJdAAdvtgBYjNWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=aVzOWvrS; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="aVzOWvrS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1790517016;
	bh=PwBIF3FFJ2GhXrI6D64tS9OOwGCkQle/FAtKxE6Cf04=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=aVzOWvrSMs+NOrShtTyt7gKJHKIWgSqHpOPQ4M44DQbx90piImQ1V+smC729CL9H7
	 W0kXiA8e/8KxJxiq3UCAG2hzyDCBGH5TMFVEzGPuyJJv7qyx1SJ7yOzS76TdlYRfBW
	 26ATvyDGQStFwElhoQNQfaq10XqvRUqNabCxM2wFYf1dwafmGYfeb7dOrH2VaAYbfI
	 rxrshWigPOXXGeE4FgC8FRb7PNCsGB2gviac4t47+Vw80Sb2+o0i0UE0ZrzNtY3LEx
	 Vt5yCT3jmgJdyQAlxmBFeGixsTcQzNOESXahsQArjuj981LyBr23RvIY59WMLcbiW3
	 ATt3gJxJDWGauPpD9MzSgnIlCr9xMK9WPzcTDcYDcbeoiNJmKKpToAGmT8h5HlDYlU
	 Ppg586smL1+VbCu9hqXbp03L1qV+mbFoxoEu6z2Xp83B6c/Z+TGI34YrFWMEv1GP4f
	 sZLAws29HlnFkVMqN/dHeKq4HR1zoViXPB1vrfGZGiATIbSXtVc
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:89b7:82e7:fe5d:3046])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0D1FC200FF;
	Sun, 27 Sep 2026 13:50:16 +0000 (UTC)
Date: Sun, 27 Sep 2026 13:50:14 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: jyotish kumar <jyotishkumar725015@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [DOC] name-rev: --annotate-stdin docs still describe SHA-1
Message-ID: <arkfFUpCskucD7Nh@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	jyotish kumar <jyotishkumar725015@gmail.com>, git@vger.kernel.org
References: <CAGjZMyTrA4Fre7kaTq_=QGyobdEgC0a7U6-94n4qehBWMwn3uQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MQGAx58QdhXQoUaF"
Content-Disposition: inline
In-Reply-To: <CAGjZMyTrA4Fre7kaTq_=QGyobdEgC0a7U6-94n4qehBWMwn3uQ@mail.gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--MQGAx58QdhXQoUaF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-09-27 at 09:54:58, jyotish kumar wrote:
> Hi,

Hey,

> Would it make sense to update these descriptions to refer to the
> object ID length used by the selected hash algorithm, rather than
> specifically referring to SHA-1?
>=20
> If this is considered a documentation bug, I would be happy to prepare
> a small patch.

Yes, I think this is a documentation bug and a patch would be welcome.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--MQGAx58QdhXQoUaF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmq5HxYJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ3oR4aLF2onNdHf6EUIoIk5Om1nJ1LSNjPgO+5uvk2sZ
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAOspAP9uHtRpxfxIwNyodHXrhMESDFq/
VX1TeYCfnjsphaOxjwD7Bd870ESRJMxa/RkEIVRhiTrfPa4ejmhqEcodWKE7Fgk=
=Gf1U
-----END PGP SIGNATURE-----

--MQGAx58QdhXQoUaF--
