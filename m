Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F337271450
	for <git@vger.kernel.org>; Tue, 26 May 2026 00:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779756112; cv=none; b=rzL5i+X8DQhTungeaxN3fac2WJa3XeXYz/z/lDmkSj3jHTN7XvMqTFQrH8sNve6xr5mWZ6Faxfh9r6w17hEDHGj7pL26806Ya2n7IxlJkubKHxUWQMUHEMCAoiyBsFzT19VK45wnRQJupDMzNzNFMFjj2dQHzNVNzPtdbCIL6FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779756112; c=relaxed/simple;
	bh=Yg8WVXdbS4BcWhKViTVEf4K7IOO8Vx/z+7dPChrvv2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atf/Q3XBJmiBn3EYx8Do+EWw97WSpPHdINNbtCfRcrHmBCS5scXvPSBeewbQTxFC35E7ZZTQq1L/1ubaseNgDInbfGmVKIiq0taxmAK3u+rEFVBogIkNT5Q+K28y8V0GdsZJR20wocE4e3Q/I//ZWOPyphc32gMiOxsm2qYLK4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=kDTrz5Me; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kDTrz5Me"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1779756109;
	bh=Yg8WVXdbS4BcWhKViTVEf4K7IOO8Vx/z+7dPChrvv2A=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=kDTrz5MeM+fQUOVsii4cSwFOvaJAiPc5F5fFi9va1+Kcc8u/X+q9KT50OFMjbX3v1
	 GwiU6zMp6n2UVgee+BPU04jQIRInP6M5u50oFAWJhaGj2dGSbLrrTqyJ4EqsJGhoOQ
	 pr8xaafyblkCmARrgxWroaYHJjBb6E12oekTBDwkusV4k9BqyvLK8ahCUqtC05nqCu
	 HlfeUdoFcOgiGTZ1/UkXxXW43uvpgfSLh2k3aJG0guMISh0XbrI4TGaXUNoJlO3eOI
	 mCMc096CacglRXTaIGsCMQkFlHCJ+pGEcOFwHSgphRqGE63nGL/4Mfj0MubBXtm+xr
	 nA6L9xeRbNem5uC/2E4s9Bmjk1bS6qu1M/6mEImIMQl0HfRS/i17EOTj7SrMV2Fcz3
	 RmoaHp93zUNQKeUEda3zY48oLNV0Dnxdn7QRiJgVUPilQwfj0ovx25R45xtqX3kLUr
	 qOe4V6aIQyaiU2Xl9cEJy2uBLPGxdNrQ1T1dme4e4cBjHfJIAy6
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:4762:abe:10d6:485])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 6BA8E20103;
	Tue, 26 May 2026 00:41:49 +0000 (UTC)
Date: Tue, 26 May 2026 00:41:48 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Amogh Dambal <amoghdambal1@gmail.com>
Cc: Jeff King <peff@peff.net>, Michael Montalbo <mmontalbo@gmail.com>,
	git@vger.kernel.org
Subject: Re: Expected test suite behavior
Message-ID: <ahTsTDhVPkHTEbB_@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Amogh Dambal <amoghdambal1@gmail.com>, Jeff King <peff@peff.net>,
	Michael Montalbo <mmontalbo@gmail.com>, git@vger.kernel.org
References: <CAC2QwmKgQW2c6_OhepsB1hzXYHxpX0X4eyQS0dPcxRZLOnCdig@mail.gmail.com>
 <20260525072711.GE2737798@coredump.intra.peff.net>
 <23221493-ea81-47c3-9647-6c6ac8d03360@gmail.com>
 <ahTKq_zCmEDJpoN5@fruit.crustytoothpaste.net>
 <4649049a-ded5-4cc6-bc2b-d5f543e6df99@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zNQI5UNyHYdApgID"
Content-Disposition: inline
In-Reply-To: <4649049a-ded5-4cc6-bc2b-d5f543e6df99@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--zNQI5UNyHYdApgID
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-05-25 at 22:25:11, Amogh Dambal wrote:
> > What are the OS and file system on the host?  We tend to see
> > executable bits set when NTFS, FAT, or other Windows-adjacent file
> > systems are used on Linux and you're mounting `$(PWD)` into the
> > container as a volume.
>=20
> Ah, this is a smoking gun. I'm not on a Windows-adjacent file system; I'm
> running macOS Sequoia 15.5 on the host. Specifically:
>=20
> $ uname -msprsv
> Darwin 24.5.0 Darwin Kernel Version 24.5.0: Tue Apr 22 19:54:26 PDT 2025;
> root:xnu-11417.121.6~2/RELEASE_ARM64_T8112 arm64 arm
>=20
> But I am mounting $(PWD) into the container as a volume.

I wouldn't expect that to be a problem, then.  macOS uses Unix-style
permissions and I've never seen odd permissions behaviour mounting a
macOS APFS file system into a container.  I will, however, note that I
am using a case-sensitive APFS volume, but I cannot imagine how this
would occur with _any_ macOS APFS volume mounted into a Linux container.

> > Git doesn't use `/tmp` for most files in the tests.  Those are stored
> > under `t/`, so you'd want to create your test directory there.
>=20
> ACK, good to know, thanks! I am still seeing the same behavior with a
> `debug` directory under `t/`:
>=20
> root@ec94ab1b260e:~/git/t/debug# /root/git/git init plain
> root@ec94ab1b260e:~/git/t/debug# ls -alhrt
> /root/git/t/debug/plain/.git/config
> -rw-r--r-- 1 root root 111 May 25 22:24 /root/git/t/debug/plain/.git/conf=
ig

I think I know what the problem is: you're running as root.  I suspect
`test -x` in the test says that you have permission to execute it
because you're root and root always ignores permissions.  My guess is
that most of the tests you're failing have to do with permissions of
some sort that are being ignored because you're privileged.

In general, you would not want to run this as root.  Use `adduser` to
create yourself a regular user and then use the `USER` directive in the
Dockerfile to change users.  I don't run the tests as root and I'm sure
none of the other regular contributors do, either.  Running unprivileged
in a container is a best practice anyway.

I'll just note that if you just want to do Git development, macOS is a
fully supported platform on which to do that.  I will admit most of the
major contributors (with the notable exception of the Git for Windows
maintainer) do use Linux and of course I like and endorse Debian, but
macOS should build and run just fine if you prefer that.

But if you do want to use a container, I'd try unprivileged and see if
substantially more of the tests pass.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--zNQI5UNyHYdApgID
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmoU7EsJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZxSN+c0U1tu3OE8PshJpya3GCagJPPkAD5i4VefdzqYt
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAITkAQC9lbChyR0PCpGdUySKeTxl1h07
iAkDB3Qy569tULID3AD/VVO/kQ8vDe0HEaCJMv8VqdQRcdf+4AWLpun4/8iWsA4=
=vP0s
-----END PGP SIGNATURE-----

--zNQI5UNyHYdApgID--
