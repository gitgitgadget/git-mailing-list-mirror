Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97DF2F2D
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 22:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759444445; cv=none; b=oe6oive13CuBEVrShMxC0x6CthX+wrVaocxZP4uAHpOAAUFOCa0XCi34x0fJlJPifdQ3fB9/zx2+nkDifMX7UgaxhXth+XgJT8FNep8tA8CHi8/VMIeHfSswpktretq7t+s3hjh5D+RPBZP9Nxf1bubpI+JqUsxaUw+bDbHPL30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759444445; c=relaxed/simple;
	bh=L6gfq8mZ3M7pa/hbQFv+xKxEbEDwK2xgat7YXHlmr2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdYt8kumMtCG70rKI+N23Zci7EBuWpt2TzsFPEoZf3FX5XinzWRIIyIMvt7UBPM76IAEVwCBaXHFmw8eq44skMCqVDAm5Z9MfEvnonGMY6huvrzkSoAVvmOdn1lg2Ts9K7KFlh9M0lPTD8XtYlaNESJZqIP+0RxgH46d7oeOO68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=tERLHWrD; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="tERLHWrD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1759444440;
	bh=L6gfq8mZ3M7pa/hbQFv+xKxEbEDwK2xgat7YXHlmr2o=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=tERLHWrD3ZG0fXlriAQifra5AxSt6Np4zkpHPDWZNRbVPfGb9Sjh9S+BBauH9RJ/0
	 gFj4O50guq8hL6q+peW5057z/1+8uSHjejoGJEe4q7/sSkxhpSXLb+K4Xwp622b9Tk
	 0E/T89VHYYJMQ4+fA6lv3mGlsLSKF0EbNnfNXBT3mSyFkIhIc6po691dWbYt1AxaZK
	 MS1Rv6qU/cPqYD0kQZw406D6fMOho/aDuipA9eFI1Om/+E0LPaONG4HI6lqZcSzCnu
	 WHucjaNNjCj27jla4YPPG/GS41I2HBp8Gya4j4sGZspFN7oAJzYBVVfeKLKbOrhj9r
	 a/5NUWta5hASHJ2/NS6AK4dgy3adPiieSbNdzI/UwnOzMzVuKM9yOsf8Cp4DGBsZk9
	 PsU4vi/P5ysbBGk++VB1SJv7XqRG1J6eyQE+MlGpJLmi06CQSIdfmsXsImo1cSCVYu
	 p1wTpRjx36p+mGI51XRUyMUEjyNSUbmHCd4bnzCZ6/pkXbIkGNx
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b8e7:3022:3f31:478d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7327320113;
	Thu,  2 Oct 2025 22:34:00 +0000 (UTC)
Date: Thu, 2 Oct 2025 22:33:59 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Luca Milanesio <luca.milanesio@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: When should we release Git 3.0?
Message-ID: <aN7917RSHBz3IV5o@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Luca Milanesio <luca.milanesio@gmail.com>, git@vger.kernel.org
References: <aNxivuJEnSHbQNdr@fruit.crustytoothpaste.net>
 <E03F997F-1738-4CF6-B7D5-206183FA5BD1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iJUKNCE3f17wjQ1u"
Content-Disposition: inline
In-Reply-To: <E03F997F-1738-4CF6-B7D5-206183FA5BD1@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--iJUKNCE3f17wjQ1u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-01 at 07:13:12, Luca Milanesio wrote:
> > I personally do not want the interoperability work to be a blocker.  I
> > haven't really heard other commitments of contributors who want to work
> > on it and I don't really want to have to run full tilt trying to get it
> > out.  However, some other people may feel differently, in which I case I
> > encourage their participation in the project.
>=20
> Sure, happy to participate.

Fantastic.  If you're interested, you can get the current state of the
project from the `sha256-interop` branch at
https://github.com/bk2204/git.git.  This is frequently rebased, but
mostly to squash down patches or add new features.  It is based on v7 of
Patrick Steinhardt's Rust series and will effectively require
`WITH_RUST=3D1` to function.

One really valuable thing that you could work on if you like is a tool
to do in-place migration of repositories to add a compatibility
algorithm, so SHA-1 repositories would have SHA-256 compatibility added
on top.  That might look like this:

* Recursively convert submodules, if any.
* Build a loose object map for any submodule commits that exist in the
  history.
* Repack all the loose objects into a pack (including using a cruft pack
  if necessary).
* Regenerate the indexes for the pack using pack index v3.

This might be a good subcommand for something like a `git hash`
command, maybe `git hash convert`.  We'd probably want to anticipate
maybe in the future having a mode that converts the main algorithm, too,
although that need not be implemented now.

You should be able to test this end-to-end with Git's repository, since
it has submodules.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--iJUKNCE3f17wjQ1u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaN791gAKCRB8DEliiIei
gfsMAP9asPpFmuHzJtoPwSTE37djta76bB5+FdEnsYPJGwqstAD+MgimJSU5owpL
nUIF9Z43d1l63cYdrSndEB4xnRCA4gc=
=gqP8
-----END PGP SIGNATURE-----

--iJUKNCE3f17wjQ1u--
