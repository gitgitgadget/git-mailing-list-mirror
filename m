Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667EC944F
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 22:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752101234; cv=none; b=feHXzFyVFVqsDdyPFdPQEyi7Rj+Uow5nDM6POaVQFR9R6mvDoMa5FF92AWsjkdXPvd80msgIrOwJiL7cUji3sf15fhedcoQzlvqADqdJjVChNVCQNxZy8h5MU5g4K3LuVuOuDGZgwYRjHM7eGw4UAipdMZESSYOqySAOtzxHlJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752101234; c=relaxed/simple;
	bh=hv8Zo+nUcAN1a0to3CB5TKFxAEanfXecmIR1QGJLj5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxF0mfW8tpxDG/tTb9Vk4vu56ODUFjZA1z2bZCFIwgGExMuA1yodniNHsj2bW+ZH5W+5xo2vUwUc3m8YVUj0iPcozndLwbVZAz4fmqxewI6szKmjAr/vU/JMEUB2aTZLRNWAmrjEETkKQ714ck9NZrMxj6MW1a9W7kgwVbXqcxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=HrvMwsPj; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="HrvMwsPj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1752101231;
	bh=hv8Zo+nUcAN1a0to3CB5TKFxAEanfXecmIR1QGJLj5M=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=HrvMwsPjUva3A3Tapt4N/m5wnAsY88BujBVFUtaHDNUmxbV0X+e/7Hh5ax9jwZu+F
	 3A8W4SStvpNUPzLFN/Q5KhukKM/yV+Zgui4LmtWzfAek+PkWe04i/s9CTuQcY3m0C/
	 pVGL+E7AUpUwrW2/RdyTeO2r4C3bbY1h6VEBX8mRX2p95qaXdSlzxOtjDvunnC4Igu
	 b8rt/VrJsBsa17/KqSC+DXVcaDZD4xlG0QGqoLILbY3Z6N9unPkd4a7m3VjtIvFBVv
	 klzcnfScpZuuDDDM2kCenJLxNdLK81iAyqRk9F0QfVYI9InC52DgRzExZsHEn+xL/f
	 pWo7waYTKShno/lCWoFOT0bY+0qD0qGgYBws1kCwH/v+lYJgYm0B4iKIklZuRDqy+m
	 HlUt4pMqnXWbp0Vigdw9FFbn8DogQI9TMf3pWWN/r94l0+xK+UkH5mSN5raqhGG3xk
	 c/QFItX2ZRslFXnoUcnOjnAXa1vrG6jOj76/t2fMwaObuHvU2yD
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:828b:3227:a916:b7f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E69EA20075;
	Wed,  9 Jul 2025 22:47:10 +0000 (UTC)
Date: Wed, 9 Jul 2025 22:47:09 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: "Preston, David J." <David.Preston@onegas.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git bash bug
Message-ID: <aG7xbbPf2ZsTh1ND@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"Preston, David J." <David.Preston@onegas.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <PH7PR11MB65466DEE20BA470C600C7B9B9549A@PH7PR11MB6546.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+FMpVaAXOE5ZX/Wo"
Content-Disposition: inline
In-Reply-To: <PH7PR11MB65466DEE20BA470C600C7B9B9549A@PH7PR11MB6546.namprd11.prod.outlook.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--+FMpVaAXOE5ZX/Wo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-09 at 17:20:22, Preston, David J. wrote:

Hi,

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)
> started happening after an update to a newer version of git... has been h=
appening for a while, so i am not sure what version it started with
>=20
> What did you expect to happen? (Expected behavior)
> when using git bash in windows environment, when a previously typed comma=
nd is executing and i start typing, i expect that what i type will eventual=
ly show up on the command line, in the order i typed it, once the executing=
 command completes.

The Git project doesn't ship bash, a terminal, or any software other
than the source code to Git.  Git Bash is part of Git for Windows, which
is a separate project.  You may want to report this https://github.com/git-=
for-windows/git/issues.

I would recommend searching for any relevant issues, open or closed,
first and providing any information that might be relevant.  For
instance, does this problem only occur when the system is loaded or does
it happen all the time, even with little load?  Is there anything else
going on that is correlated with the problem (e.g., a virus scan)?  Does
the same thing happen when running Git for Windows's bash through
Windows Terminal, or is it only the built-in MinTTY?  Those kinds of
things might help the maintainer solve the problem more quickly.

Best of luck on this.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--+FMpVaAXOE5ZX/Wo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaG7xbQAKCRB8DEliiIei
gcofAQC3qwmrc5J18QhdudryGOt0E8rLKvLRdD9JzJHhvak+KAEA8wj10vCDxLmf
/gWKOIpZ6rPQPAUY/OhggwYtWdNerQg=
=EPUn
-----END PGP SIGNATURE-----

--+FMpVaAXOE5ZX/Wo--
