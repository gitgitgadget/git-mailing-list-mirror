Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24E755C22
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 23:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705706100; cv=none; b=FHsLmj93OIxKKhzrnZgHq+P8YsnGLej9Ep9cQnbIiv0SK+aom4haXxJy4rMFQRfEmKHjSf6l5Gc/S3Jn30kFGy9Tfvpv1pKnzaqq+SBFGUFEVcHD04MWicncf2Z8ZYLsUpoAWy2HnH1TvIvHd4K6z2ey7D5w6Cj8rmSSye9HPGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705706100; c=relaxed/simple;
	bh=2sYigHjlP6PHL6l0DWrOykbv+sCcGQRZkQuFKkUlvLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+x8uinMo60LqyujIcmOpQVzMmYjpPe7QAaL+EzO/os/c3SsFhaJDaKjPVJcBay5q5DRy5RAziz2VI3gnn06ffhFMnVSVRUfYh6vBsb/u+3WhgKI+LTIxzpjyCEuH1UkBMO/wz9qj1OAV8jIcqVebcIW63O2OP90uu13AsVx8j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=U+D+w/kt; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="U+D+w/kt"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id D5D7E5A3CC;
	Fri, 19 Jan 2024 23:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1705706089;
	bh=2sYigHjlP6PHL6l0DWrOykbv+sCcGQRZkQuFKkUlvLI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=U+D+w/ktdlcZbMA2AavnZJRJegs5YFaxy41LQTT5cCalyloCHTgBvFPeOEVNto7YU
	 +wzvzF/tUph2QGK/RygI3HfEFsF/VQl8mHDJYy+b4RtFbbSuYX3+yPzz5XoMVFw4Tt
	 R4fT7LD2c/XnBkGLEVbclCAQqbybZIDkDuPBWfxxw+s+hZXqLVTWZWNzz93eYq5Fqj
	 10p6KammBRV815PZCYVRifDDe6OGs+m4vfj+SRk7X8suEfcngMHws4Ayjg1Qsf105d
	 sr7gvDSJDnGskLlN0xvV2WCeGY8yKv/Ym8xiOLOD2OsOqEZVkL9zEKgrTK1ECO0y8i
	 MkCVfslrzbXeSUQRX085myfPCLlJYPw/us3IS2sollhSwzOtbEjlZ68QIGN1nBPMg3
	 rAlJnNQMbdz5Q1UsZuFI1E4dozxQA+JHjborhjw5FEQtZtDRgv5XGiOha6/gj1pmRH
	 ZkILxcmedSLitJqDOw7066YNRS89WFBGPhgUxihtMRrtT4/3vQs
Date: Fri, 19 Jan 2024 23:14:47 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Frank Schwidom <schwidom@gmx.net>
Cc: git@vger.kernel.org
Subject: Re: Bugreport
Message-ID: <ZasCZ0YetzmlBFvw@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Frank Schwidom <schwidom@gmx.net>, git@vger.kernel.org
References: <20240119132551.GA31532@debian64>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XLeOBcqm1/bT3Yd7"
Content-Disposition: inline
In-Reply-To: <20240119132551.GA31532@debian64>
User-Agent: Mutt/2.2.12 (2023-09-09)


--XLeOBcqm1/bT3Yd7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-01-19 at 13:25:51, Frank Schwidom wrote:
>=20
> This bug exists in possibly all git versions.
>=20
> $ git init
> $ touch a.txt
> $ ln -s a.txt d
> $ git add .
> $ git commit -m + .
> [master (root-commit) f6b4468] +
>  2 files changed, 1 insertion(+)
>  create mode 100644 a.txt
>  create mode 120000 d
> $ ls -la
> total 12
> drwxr-xr-x 3 ox ox 4096 Jan 19 14:10 .
> drwxr-xr-x 4 ox ox 4096 Jan 19 14:04 ..
> drwxr-xr-x 8 ox ox 4096 Jan 19 14:10 .git
> -rw-r--r-- 1 ox ox    0 Jan 19 14:10 a.txt
> lrwxrwxrwx 1 ox ox    5 Jan 19 14:10 d -> a.txt
> $ rm d
> $ mkdir d
> $ touch d/b.txt
> $ git add .
> $ git commit . -m +
> error: 'd' does not have a commit checked out
> fatal: updating files failed

I can confirm this behaviour[0], and it's definitely wrong that it
thinks `d` is a submodule.  It does, however, work if you do `git commit
-m +` (that is, without the .), which makes sense since the relevant
change is already staged in the index.

I'm not going to get to a patch or more thorough investigation, but
perhaps someone else will.

[0] git version 2.43.0.381.gb435a96ce8
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--XLeOBcqm1/bT3Yd7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZasCZwAKCRB8DEliiIei
gdOfAQD1OiRlp4cqJGJ6BYLlvLzLkrQKEkggNkYQCks2TFGIZAD8DFluUkz8CLrA
Pv9mgcMGk0/nZoCIKZDfgQyrDkGp5Q0=
=e5z5
-----END PGP SIGNATURE-----

--XLeOBcqm1/bT3Yd7--
