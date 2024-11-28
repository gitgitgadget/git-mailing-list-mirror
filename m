Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0701C2DA1
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 20:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732827524; cv=none; b=XPN4SLFntzUYfzeSSIjk8B7BYyHe4PAJiQ/cxxJG44Xj/aZkPs86O6b/VZW9LgiL0jL24FBU8PUgN1wsY3w9/0m1Hkl6SkmP1uW8ReYr48nYheu7bXLSkYaLJKsO7i2qBAO9XO3gMI+D16DE8rubBMI7/Q4pyOi0T1n9N7FDdAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732827524; c=relaxed/simple;
	bh=+ZkpWV7FMde3yzoycX8q+NWwqwzSIbRUlpysvZm11KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKwZ3c+CX/mWzAKKxX06b/LQ3iKyABlzPICw9p8n2HPcKXuWDgjAFB/23RnoIW1kriCCGiW0hOlP0fNBp46ND6EaooVHre7Eb2Cdo/TzjSPtvcJ9+aRapez9UOqJz/apXOaxi2e1vTHQkMEbloZuP92WoW8F8nWyUqWOXEw2XVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=hXLD6M2w; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="hXLD6M2w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1732827521;
	bh=+ZkpWV7FMde3yzoycX8q+NWwqwzSIbRUlpysvZm11KM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=hXLD6M2wTPo4EN6x82Zqe+dcAe5pQr8dC1Xrt1g/diRZk7EOXo3G7pDIOxB1QiqrG
	 tiessDAHbeejBZSYB1M40l5Je+C94SdB6CRJbVKfzhljmVgwIl3mzRbDwV/X5GH0eV
	 I9tXNF/gP/8ZXDhe3HoQKGChqklNPW3YqDIZgmFwW5GyXx4/fnTklQ8PyGhV59vUOH
	 GitGKxXfjfgBzr6wnsdAScRjmtso7zki4b6mHXPstm2+J4brLIYQ9xT8l7opJIbOW4
	 lN5K1x5Kue1+D8J4uRl1qQHOLJc0u5Yqzx+atL770PrCZ1MtBDOZBqI5fqZxp04oUO
	 fj1Fvykjr//PYMupmeM+Hfy49RIcQz56jU70Eq/2xu+mG+piyqHFkkLx+r6CTMSSmO
	 2ZWTKUKpxYbPiClHfd2B2yFDMyr2IHRnVwV9zJI8Ey90h9ItNtM/OHt7JdaR6o4VvC
	 9HUGK1uquJjXtOJXrsFqXt/OGFzQ2SGdtrxg5T1cxujVU/QVLMl
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2600:1700:f991:38c0::39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0895620994;
	Thu, 28 Nov 2024 20:58:40 +0000 (UTC)
Date: Thu, 28 Nov 2024 20:58:38 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Homyee King <homyeeking@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git clean --exclude broken?
Message-ID: <Z0jZfltm0O3y9QoW@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Homyee King <homyeeking@gmail.com>, git@vger.kernel.org
References: <1A13EB2A-6075-4CA9-855E-B72ACDA67C0C@gmail.com>
 <Z0Nsq3lQZKJZxd-y@tapette.crustytoothpaste.net>
 <CABAKogYaajvedff2ihsC5g+156L-Oe2N_XR3c+uyyfoovVQ5gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="35Z75DxicIPxtMZ3"
Content-Disposition: inline
In-Reply-To: <CABAKogYaajvedff2ihsC5g+156L-Oe2N_XR3c+uyyfoovVQ5gg@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--35Z75DxicIPxtMZ3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-11-26 at 06:13:44, Homyee King wrote:
> Thanks for replying.
> It's a typo mistake, the correct command is `git clean -Xdn -e foo` but t=
he
> problem still exists which is `--exclude` option not work with `-X`, is
> that design so or a bug? For example:
>=20
> simple-project/ =E2=94=82 =E2=94=9C=E2=94=80=E2=94=80 foo/ =E2=94=82
> |---- bar/ =E2=94=9C=E2=94=80=E2=94=80 .gitignore # contains foo/ bar/ =
=E2=94=82 =E2=94=94=E2=94=80=E2=94=80 test.ts # untracked
> file
>=20
> I only want to clear all gitignored files/folder but *`foo/` *and keep the
> untrakced files/folders, so here's the command
> $ git clean -Xdn -e foo
> $  ls
> $  Would remove foo/ bar/

I don't think there's a command for what you want to do here.  You
basically want to clear only ignored files, but exclude one pattern from
the ignore rules.  `-e` doesn't do that: it _adds_ to the ignore rules,
not subtracts from them.

So this is what I'd expect to see here with your file structure:

----
% git clean -Xdn -e test.ts
Would remove bar/
Would remove foo/
Would remove test.ts
----

since by using `-e`, we've added the additional files to be ignored, and
with `-X`, we've said to remove the files.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--35Z75DxicIPxtMZ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ0jZfgAKCRB8DEliiIei
gU58AP45DH0UbqH9WRVQ1u8kpkwngqiM1Btn2ypFuBkFltpgMwEAxZ5WQfHUTv5g
1WribiAe9Gms6IvkRSM6Q3L6TKPnQwY=
=AD+i
-----END PGP SIGNATURE-----

--35Z75DxicIPxtMZ3--
