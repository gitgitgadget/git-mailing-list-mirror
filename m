Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813AC745CB
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 22:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713996279; cv=none; b=fZ7NJbmKq+jTJHMVYr/Q96AEz9RCJu4TCmf7W1tQmUvfnC6KlAwHy7iwKA0TBwgOKqxtCDz2434uWnQur7iXKJ+BL5ep/rGwyY6e2WVu9Qgy4Bx04v+xfROIluEJfRVZCmM4PRsoaZ5TaIRWQMKe/MzZplxZXXu9GueHseD80jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713996279; c=relaxed/simple;
	bh=xB5uCNsA4/hDmN/Zy60oplhaNKOXyqw1/lelCgL9pUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WycLDezERuf+RRJZ09Q+tjqLtoLyTpOEmuQnLdHKoaySP6hmnuO7b945Md6P3a4D/hHoUmmlnAKQkuMameTkqZUkXdbQipyMEApBEfy5b5XgZFfkFS/PfTu0+FVSJR553Mf31ttSGUEr0zPZ1KjvYAO7VILe2QP3CIklruoZ5hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=1AZ0CXTH; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="1AZ0CXTH"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id BD7765B295;
	Wed, 24 Apr 2024 21:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1713995676;
	bh=xB5uCNsA4/hDmN/Zy60oplhaNKOXyqw1/lelCgL9pUE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=1AZ0CXTHAFAkdO36Lhl5x6+VNDwfXHm4qYh/SqNimJltJKVClyXUBupkvDPvyRXqq
	 w2bwt5nQpBtLQKbB24MoM2ssGbIZkiivnkpUGp34S6tkCXRzgtJ+d6nG+1/TJWy9cr
	 FgioV4SdjYDe2d4PplpXiuSrFO8C/BITenvlgNaZ+IKb6cQzPv+tXFFZOGT4Npw8RJ
	 6YfbtUNNJz8nUlpIfVF8S1JsS91/FVJ9UHw4zAocoYY73ForIp8JqUzfx8Efatjjfm
	 hdsn9FjNDnlB02XHq1ZTR/RvZjj+C76fqLwLM2Wj3jaX4JUn7kVxy22I5RoQKDB0Cl
	 z4oii0fIv1tPagVAApGX2t0AsLXIC45gNtDCWBNQZjS/mxa1NNKXUM8d98bHjz6RyK
	 ukTTTtLauqI9/0Pz5PrYINP36YbN5cZQqkf/cMXJ90PrDgqX6DOUYEdNsUoNoANxFF
	 ZE/tb09VZMXlnqDxl50KWACeNpxYoeLaFrfhyIWJku2yx90qcOd
Date: Wed, 24 Apr 2024 21:54:35 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Dan Demp <drdemp@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Git Bug Report: git add --patch > "e" makes keyboard unresponsive
Message-ID: <Zil_m_1B0wcLejNH@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Dan Demp <drdemp@gmail.com>, git@vger.kernel.org
References: <CADs5QabwDtUpehNY3hr6BzKyfpp-Ts54TANGkygWPcN3T=OSOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kyU2v5B6bODIigdl"
Content-Disposition: inline
In-Reply-To: <CADs5QabwDtUpehNY3hr6BzKyfpp-Ts54TANGkygWPcN3T=OSOg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--kyU2v5B6bODIigdl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-04-24 at 16:22:12, Dan Demp wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)
>=20
> When doing a git add --patch, I used the "e" option to edit a diff I
> couldn't split sufficiently. This worked, however when it moved on to
> the next diff, my keyboard became unresponsive.
>=20
> What did you expect to happen? (Expected behavior)
>=20
> Not make my keyboard unresponsive.
>=20
> What happened instead? (Actual behavior)
>=20
> I was unable to enter any option to proceed with the patch, and even
> Ctrl+C failed to kill the git command. I ended up having to close my
> Git Bash process and open a new one.
>=20
> What's different between what you expected and what actually happened?
>=20
> Keyboard unresponsive.
>=20
> Anything else you want to add:
>=20
> I've reproduced this every subsequent time I've tried this, and it's
> specific to using the "e" option with --patch.

Using the "e" option should invoke your editor and wait until it exits.
The only way Git has to know that you're done editing is that the editor
process it invokes has exited.

What does "git var GIT_EDITOR" at a Git Bash prompt print?  If you have
your editor configured to open in an existing editor window, does
closing the new editor tab or window that Git causes to be opened fix
the problem?
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--kyU2v5B6bODIigdl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZil/mgAKCRB8DEliiIei
gaZCAQDRuKOiuIJmr4PCDuEg7QGYzWxX+Ijoy37eR0KG7y7/ewD/ch1O8EiOuCqD
igMnnX2BilmK3gFg9gNiw4zJ+58HzgM=
=cXme
-----END PGP SIGNATURE-----

--kyU2v5B6bODIigdl--
