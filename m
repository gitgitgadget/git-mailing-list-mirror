Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357C644C9E
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 15:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707665348; cv=none; b=TFqyW1kzSimSqawJ6roIFmlwOu0v24Ut5Yj147oQwER/0uLxfhTeP63CHzBYXJGVi09mZsXlCW3REtQsi9NK7EohTrVLHFh0a8NX14/v54P7c56D6mfAJKGfqLyXu8aCeZBJmVFK6IXkNvYIpNSrzVOxiUgpKN0w91lhAOkOuaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707665348; c=relaxed/simple;
	bh=1xiCJU9QQuCZbZgvHOF0kRq6Y7oXP9wjENUMRZgOeC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adOHXHxPps+WyAivb5QxghKxzsrDkUmYkHF2QXfDhGO2hk8W7ELgar1L5cROOGs16sAvTEhYuUpi8hhQJ8unKygpDxS/lWZHc1tT59NRJhMEje/VKx46vD5m8xXJSG83ic6Zi4SYyQrZeZ7T8EcC3nCl2DwDxlPXHcUIo2vzp9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=aFY6RhSJ; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="aFY6RhSJ"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 8F74F5B2F3;
	Sun, 11 Feb 2024 15:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1707665339;
	bh=1xiCJU9QQuCZbZgvHOF0kRq6Y7oXP9wjENUMRZgOeC4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=aFY6RhSJMi4UbVaExdVYcWEwyTixjxrolR+glLqtpQekXDeXJlEg1ule/s9eIT72q
	 q2kAGTwPJoqjH0+lFyWia8PpqYodiKiZoxo1Pkk8uDVMqI2KhGuR3dF0FQFOZA0Axq
	 kVzaYoEl8y3Ik9l5W9Pfshy6wy9cYR7V7yoOUMSZWWh8NcW/Px6dUokLJbv2R+isI2
	 X3iPYBHuNaXt4pWlOvTjlSHMjwZEXaDZ7XC3JV7xVutrLvWoODrbD+tX7IzOK4NXCJ
	 t5KMW98mGNqurN6MHfmlhMus+a7g+3FISVbhJzHHF+b5ohXcFp6omNm1T5GCeBjkiq
	 8HwxWsym6t6UXqns/GTM9R1Gpsl+qj+vAqGU/9lPIGxf0qC+d59b5v9mVJD7d/2v28
	 FNryesrBLCptmx4K+X5KMQ6itiOmIKwYnQc6MTmTEVx35QvAH8tV1A2xFaNBulS7zQ
	 8IkJ+kL2Yohvej2TIjGwAIEdMlSh5U6bXy/ENpib7diiwmJ0V1/
Date: Sun, 11 Feb 2024 15:28:57 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: K_V <zinen2@gmail.com>, git@vger.kernel.org
Subject: Re: git gc changes ownerships of files linux
Message-ID: <ZcjnuSAZiNHvA5h1@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	K_V <zinen2@gmail.com>, git@vger.kernel.org
References: <CABkRduQNdgdF8WhZadP5hyYvpEWgP_AE8=qzxNiRNA71bdJcYQ@mail.gmail.com>
 <20240211151455.GA27103@tb-raspi4>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KUFkhLKMnT4L88Og"
Content-Disposition: inline
In-Reply-To: <20240211151455.GA27103@tb-raspi4>
User-Agent: Mutt/2.2.12 (2023-09-09)


--KUFkhLKMnT4L88Og
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-02-11 at 15:14:55, Torsten B=C3=B6gershausen wrote:
> Thanks for reporting this -
> I think that you have a working workaround ?
>=20
> However, Git has a feature called "shared repository".
> You need to define a (unix) group that is shared between
> your user(s) and the ansible user.
>=20
> The basic trick is to do
> git config core.sharedRepository true
>=20
> (And then change the ownership of all files/directories to the new group)

On Linux, you also should set each directory to be setgid.  That's
because by default, Linux uses the user's current group ID as the group
to create new directories.  However, you'll want the group to be
inherited from the parent directory, which is the behaviour when the
parent directory is setgid.

This behaviour is the default on the BSDs, and no such configuration is
required there.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--KUFkhLKMnT4L88Og
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZcjnuQAKCRB8DEliiIei
gYV6AP9GYQFDomvCPT+ph92ykWkCMIePXkoXzjufsuWj0bmrewEA0mw1gpEGo+sC
jLQ/xurM6F7YbVE0na4mWUNz100tfQc=
=WwKG
-----END PGP SIGNATURE-----

--KUFkhLKMnT4L88Og--
