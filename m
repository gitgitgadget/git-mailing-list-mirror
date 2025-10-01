Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F85CEEC0
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 22:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759357005; cv=none; b=G0w801eKkjA+/vWIMOv4eIx39plRk6VYSzz7RElgGiVX7v9Ix8wiDeEV27i/cC5av4thckR2SMiPOrIrnxuEV+2zqmDDv7SlhBKMe+eXFZhiOe76Wg4Qpcqs3Ff6Ih3b0smr9vl4l23FE1tkpjj+Qok853YYU4Z4VR10y+VJxCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759357005; c=relaxed/simple;
	bh=yHCUcpuPc9VHhRQ4BOpcrkuKpDa7jnZcc9PQRHTKMsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/zKaxSxqjqNYopvAl2a+jA7tSypHSFbScl1XA/tOf78AXG4gdcdWFAQhCf9x9cvE5ztvmQkzfzgbMOByGThwAry4pRs2QEjZk6T7wySsNKPJGnhizy4XXxonQ2riKgFnpRZTitsEH2CjkJS2y0/yF/1NjFuzFkm0I3FjMZ/z48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=fVMQj5cI; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="fVMQj5cI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1759357001;
	bh=yHCUcpuPc9VHhRQ4BOpcrkuKpDa7jnZcc9PQRHTKMsE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=fVMQj5cI/ByrWmtuPSwzzWgDBD82uWj0bBkDwd4YID5+2tiqVCdlhBcDIkVO8vJwJ
	 j0khzgLVFMrBR0gX1o8NIZW4G4ku4JP/uyf66Pjm1lZ2+tzxfMh9XM8gJnfJjM3AkJ
	 c7ryaxNKKdReUU1NZVM5sJPTNvEDLfiHHM1Y+IPgU52EDFP4aJfssQWISgS0cUK/WO
	 g5tCzEMqzJBK9ZdXQ131Kt/nfcWVc2qccTsFJqy6mHKBvjZ781aa1kMtb2lBgYuXWM
	 UaygoiQPIrvZAarEtTD4EyGuLsSvNlglASb91a/Yw/8umcSu9gdk3lrItLVFzoTOjO
	 Zq5RtN27hjIKaj6rwif7+8tRseUOmEsq4l9MzGWP+z3jVv8X85mB9el+95ZWn2pvNb
	 cWwyxg78CkcQ7Ry+wOSv7MoprcHgVUm0uYY6nibm1/iCDLUns7TYUUAb25i/pugVa6
	 /kx6ShcYvLVHHIcWQNJxuUtFWersAhVQPWf9kiklLrq1uWqCvcW
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:eb6:3c64:95b3:ebcf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id ADCB120113;
	Wed,  1 Oct 2025 22:16:41 +0000 (UTC)
Date: Wed, 1 Oct 2025 22:16:40 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: When should we release Git 3.0?
Message-ID: <aN2oSBz8s_hSBMPq@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
	Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
References: <aNxivuJEnSHbQNdr@fruit.crustytoothpaste.net>
 <aN1QUDzYli0GsGy9@nand.local>
 <aN1UtbJRIhgvMmaF@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T+K501xGQASZabOI"
Content-Disposition: inline
In-Reply-To: <aN1UtbJRIhgvMmaF@kitsune.suse.cz>
User-Agent: Mutt/2.2.13 (2024-03-09)


--T+K501xGQASZabOI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-01 at 16:20:05, Michal Such=C3=A1nek wrote:
> From my very limited point of view as a user the interop is the major
> planned feature currently missing in git, and I do not see much point
> without it. Then again I do not know how useful it will be in practice.

It is the major planned feature which was missing.

The primary use cases are converting repositories and working with
repositories using a different algorithm.  The latter might be useful if
you're using a SHA-256 repository that someone else has created but your
tooling cannot handle longer object IDs or otherwise has some limitation
of that sort.

If you are happy working with SHA-1 repositories in SHA-1 and SHA-256
repositories in SHA-256, then you don't need the interoperability work.
SHA-256 repositories have been supported in a compatible way since 2.29
or 2.30.

> Then again cloning a repository uses the correct hash which means if I
> create the repository on the forge and clone it there is no problem
> whatsoever regardless of hash used. Whill that break as well?

Cloning a repository always uses the existing algorithm.  The default
would change to create _new_ repositories created with `git init` with
SHA-256 (although you could change the settings to use SHA-1 instead),
but it wouldn't affect existing repositories.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--T+K501xGQASZabOI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaN2oRwAKCRB8DEliiIei
gVATAP0Yvb37Yrhl80AVmrRT8js3tWLkkYSIJrhk8C+pbSyTcQEAwR4oWuGVm/yP
SDZwPLkkyClygzsX3QsW9f+dvQL57w8=
=UIMW
-----END PGP SIGNATURE-----

--T+K501xGQASZabOI--
