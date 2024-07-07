Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC3139AD5
	for <git@vger.kernel.org>; Sun,  7 Jul 2024 19:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720382049; cv=none; b=SyLOejl7xwV0HHxppGx8EU7x6QscUYBoyqXGqUCXp7pNrn2p6jhN4SGawdbUiOl728qnqQVAEPLp4N6FvADWaYUKm9ZkZm7sPtdvtm+uxtPVkEpFFn+n7J1785rvOO7g17VYrza4J/U6NkDUKKrMve4MhjGmENYYCnXfsQaAGRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720382049; c=relaxed/simple;
	bh=2jVYVkQpnoM3EeJ7HMEkwbL5aavNbv4AgN/qBk56YL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAneTbTGoqFnlnQBaEL6UZY0Dyswt28K1AY57abR7xnPelpbJINIkWtxm8TF8vKA7kp5sKKme6udySz3goPP9zspRjN6fI9Y7ca9PSLREWnPpERvAr2p3GVa+O/jk1c2L9SiAoFgML1n3okYeAjrCyLkKAFi+NCC9B3hxWjDhIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=z2Iz94Mi; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="z2Iz94Mi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720382045;
	bh=2jVYVkQpnoM3EeJ7HMEkwbL5aavNbv4AgN/qBk56YL8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=z2Iz94MiFba36VxAP9HaNIoTL1lji63gedTPOpfeI0pohZz/JwZY/i/8bUDJTnJYh
	 RPeSJjkQUtYdkCWr+bBkoHIvF/iw3S9979M3yhrbfDT0unOMm34jeekyF+v7/ySZAz
	 lBIlfYdFgcEbHUvJDuovQnml9m5Bv54tlGJ7b1K6PQAblGe1rjTHwbZj2PZrvqRyEJ
	 sumM9gBKYmJQwChiv0n94hkrja3C0cj4qEwICFwmhZ1pYucejgeUFaaE4FZfMdgnH+
	 9t0WSwZpi5brvTvnzcpgM6K6J4KajrX0u5pSk5OILyl/H9IFL77yQY306YBZVAc7ci
	 rGn5k5UDI/uepHgJ//jZu+kKT19Y1fiOLckGMCuTFfXiExgdI3eLeiGooVG8oIWItN
	 QE+FARzF15xDY7ZtdrchOhdID4oBkmG7bfWp+cWAALpULj+74E00lJk0VbM4hqy73j
	 ZSskwP5LsbvnU2ppw0yEKqkMoVsq9PnEJn5W9TU+Alct9KvqsiX
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7014E20991;
	Sun,  7 Jul 2024 19:54:05 +0000 (UTC)
Date: Sun, 7 Jul 2024 19:54:02 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: github@online.ms
Cc: git@vger.kernel.org
Subject: Re: linux git init/clone on Netapp NTFS security style volumes
Message-ID: <ZoryWtGqsD9iIafI@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	github@online.ms, git@vger.kernel.org
References: <trinity-ea5945a3-0663-4e48-b995-913003b5e932-1720294530422@msvc-mesg-web002>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P9JuhglkZmWNdHjt"
Content-Disposition: inline
In-Reply-To: <trinity-ea5945a3-0663-4e48-b995-913003b5e932-1720294530422@msvc-mesg-web002>
User-Agent: Mutt/2.2.12 (2023-09-09)


--P9JuhglkZmWNdHjt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-06 at 19:35:30, github@online.ms wrote:
> Hello,
> =C2=A0
> I'm trying to execute git init and git clone operations on a linux
> client that mounts a Netapp volume with NTFS Security Style. Meaning
> the client is Linux based but the filesystem is managed from Windows
> side - especially linux chmod operations are not permitted.
> =C2=A0
> Maybe a new CLI option might be helpful to skip those chmod operations.

I'm not surprised by this, because Windows volumes under WSL also have
the same problem.  However, I don't see the behaviour you describe when
creating a new file system with NTFS on Linux and using ntfs-3g to
mount with default options.  In my case, everything works just fine.

Note that I didn't try using the old non-FUSE driver because that's
deprecated and I don't believe it's available anymore in Debian sid.

What OS (including version) are you using and how are you mounting the
file system?
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--P9JuhglkZmWNdHjt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZoryWQAKCRB8DEliiIei
gZAIAQD2qwT/5dDdEUL6VgBpYrE+UWk1AUy/bUgIHbLLSmciRAEAt7LvBjexg9eF
+5BFxDHSIrQv1CrmS987vXmNxsGRVg8=
=8uY1
-----END PGP SIGNATURE-----

--P9JuhglkZmWNdHjt--
