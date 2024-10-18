Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F12204950
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 19:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729278198; cv=none; b=tI+2etIc7l9wqnK78Gpfai0dXSMl1QAzD+UXQCmuzLRj41Znt2PU9W47iS7BO1yMc8axPLd+XgdM3XcPNNpjzcE2+pxpJce2yn3uFZsha+pYJP3+1PJJpzgioAXMr70YeLXkgT4KE7wjp7Mpz1VUo2/MCrlho/sQW45hLmybq3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729278198; c=relaxed/simple;
	bh=WQ6uB26uny9svqHQJDSlz2SgxmmTzNjZk8NcYmlOXlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qu8cvMNjBQwLexfGgmndkuJcvnll0q7vrvq+38W8tt+qCrZWMtQplEyfyO+g4b8Rr/eR/DDcIEXM9fl9y9dGC9LxZWKw8kehD/Ul48m84e5M0xraTANiCGVy1B2bYGF0DswnEGZc+QQRTM/PXH36SdSgNvr6mh4RfaMEVuAdisU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Cnxkfis/; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Cnxkfis/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1729278188;
	bh=WQ6uB26uny9svqHQJDSlz2SgxmmTzNjZk8NcYmlOXlw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Cnxkfis/3caRBoGkrg0iQQI/YLfBpAAwWQqJgZnx1uKGxiGn1OTHi1n/2BySO+60O
	 7mnRR0yT8o2q1ub5RsfJgdTbJ7sRXRbxh/uD3RfdFldPVp4+9jg/+pyUDi39cXjAH7
	 +yg7nZzJHKwOXng58SFUSovgqONTxnqElRvOFr+iEEh/Q+PrI+vWZP21CJb0HYbkqz
	 a1zlX8r3XJvatcBvX4vYSLCoKQUTB9uUe/Q4e6O5mafCuK1OgIiZHKEManPEgbZLtK
	 jICAHYQUEk4vy5SF+2i7QVUwY5fzFKpu2Lwkskva03Lmdbb8XxsFxKrjOhpyTWQUxR
	 olT6tmqQ7SVr6K4bBgjll9d7Ln/Yw97sEfz5RQNlCFsz8FWQMwbrPVmyw/RJ42oYK+
	 f5tjBufz7skp4fPV2QyU95ZIBQGiTvK8HtdAnlQjCs3vltEkhbYGohryVsklFRx+L/
	 DhFEuY9CNYBr0TDhdaq5tDwpfw3F7/Vjj4tFCuDeMSUya+KGM98
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D7814200B1;
	Fri, 18 Oct 2024 19:03:08 +0000 (UTC)
Date: Fri, 18 Oct 2024 19:03:07 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: David Fullerton <david.fullerton@alexander-dennis.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git Install Error - Failed to Expand Shell Folder Constant
 "commondesktop"
Message-ID: <ZxKw66wR3UzCuj_b@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	David Fullerton <david.fullerton@alexander-dennis.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <CWLP123MB4691D6EC228FA467749267FCCE402@CWLP123MB4691.GBRP123.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UwHM4Y4jx1uhYmUa"
Content-Disposition: inline
In-Reply-To: <CWLP123MB4691D6EC228FA467749267FCCE402@CWLP123MB4691.GBRP123.PROD.OUTLOOK.COM>
User-Agent: Mutt/2.2.13 (2024-03-09)


--UwHM4Y4jx1uhYmUa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-18 at 09:05:12, David Fullerton wrote:
> Hello,

Hey,

> I am having some trouble installing git and would appreciate some advice.
>=20
> Error message seen after clicking install is
>=20
> "Runtime error (at 27:002):
> Internal error: Failed to expand shell folder constant "commondesktop" "

The Git project doesn't ship with an installer or any binaries at all.
We only distribute source, which various distributors may compile in a
variety of forms.

It sounds like, from the message, that you are probably trying to
install Git for Windows, which is the most common distribution for
Windows, and so I'd recommend that you report it to their issue tracker
at https://github.com/git-for-windows/git/issues, after first checking
to see if it's already been reported.  They'll be able to better assist
you with their specific installer and any issues you may have with it.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--UwHM4Y4jx1uhYmUa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZxKw6gAKCRB8DEliiIei
garqAP4y/g1zuMquJypJeNuvDyH4tRuifYFlmqLYBC3+az9qaAD8CV68uYv5jde7
pkExLtxtFON1BPq8MjwzT2r8FlFaTgk=
=5ijl
-----END PGP SIGNATURE-----

--UwHM4Y4jx1uhYmUa--
