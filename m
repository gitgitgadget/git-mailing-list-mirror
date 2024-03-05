Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB4D12BEAA
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 22:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709678933; cv=none; b=H+OwLqMsBH9fimCG/oybSRcSfb7yjRBiEMFvB6HHOdoT9UQ3h4qP0JNVQ9NmlXmUW+zga/xwlrl0+EI/rZkdtaNnjEuT/mLB7oMwWiwvWSS1hQXSAhUR/PIioM4bKnU/ge4m03h+0o9gSN4hRXvzhNCrdJVACFUCsqkGq6zDX9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709678933; c=relaxed/simple;
	bh=L/63jKbK6UVT9BSZK7Xd7zT2xOBp2RTEHNIEw753gas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8yoscyVCWvhxgtTeQip00ht5J4dmkADM4MSUyC2x+QRZuq29eat59Mh9BffkTHYNFSELlqd50dpWL0b0uPPnyBVuXeH1Kup4XK3KGQ/iy72X4F18DSSkNVHY43n8Py4v29FxOOvcLzc9bnq5YThDTaY/uwPxMgP5jjFRuSEDOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=CuaBmcT2; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="CuaBmcT2"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 2A1D05B3CB;
	Tue,  5 Mar 2024 22:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1709678924;
	bh=L/63jKbK6UVT9BSZK7Xd7zT2xOBp2RTEHNIEw753gas=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=CuaBmcT26JdHD23in9owWHkqvo5E1rgYeJQKTsJptdQDzoe2UsrFLTdOkNaQXq8au
	 emIjInPs20RWuWLWLPJ73c+e0mpFz0dYl3eVhoYJpgNA+Hs2MLwwE3ri716LN6KIYv
	 zlNh1cdVGamuZLSGzHUT35YJJzRJdWPaWCuoY/JaZ5BDtdUd0ieWHsp+MvdWz7KPMF
	 0ptNK8nYv9zd9eA37Ucf9p83hZzEe+aMAY5vOjBr6INojAda+ZHAtDOWxcWT6GH0HA
	 QY9lfzWCIJiE9FUJw/8mUSkPam7vzM73iVOVAmuiKTs75YkilYIMxn7mvPXNaSewtz
	 KUo0TrIa1WfCJnyGWXiUe8NmGL7Vq/UDX/bFRYxiLoIp3P5SsWjmSqy+0fdzpfSmig
	 loOYc6uTjIBZzd0KmpFPIGv8MEZYL+g6QhLAvMQK2OfaEwOd9v3YzNrE0/m1A3e0eg
	 t2zeJXn31kfwT1rj9d4z5V5TL3ONYks+1lfmMl0uM8G6AhFJo6G
Date: Tue, 5 Mar 2024 22:48:42 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Manlio Perillo <manlio.perillo@gmail.com>, git@vger.kernel.org
Subject: Re: Clarify the meaning of "character" in the documentation
Message-ID: <ZeehSl-u3qAXKjF_@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>, git@vger.kernel.org
References: <CAAToxAEE-2B_8Wqrquk1peOnqTbOpV_8KZmsJ2dgk-mfCZXHiA@mail.gmail.com>
 <5e10f1e5-b87f-43cd-ac1e-d7c01b7dad21@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5UxUmwa7vptbVD5I"
Content-Disposition: inline
In-Reply-To: <5e10f1e5-b87f-43cd-ac1e-d7c01b7dad21@app.fastmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--5UxUmwa7vptbVD5I
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-03-05 at 09:00:06, Kristoffer Haugsbakk wrote:
>=20
> On Tue, Mar 5, 2024, at 09:43, Manlio Perillo wrote:
> > I sent this email after reading the documentation of "git diff
> > --color-moved=3Dblocks, where the text says:
> >> Blocks of moved text of at least 20 alphanumeric characters are detect=
ed greedily.
> >
> > In this case it is not clear if the number of characters are counted
> > as UTF-8 or normal 8bit bytes.
>=20
> Alphanumeric characters (a-z and A-Z and 0-9) are ASCII. And one ASCII
> char is represented using one byte in UTF-8. This already looks precise
> to me.

I don't believe that's an appropriate definition. =C3=A9 is an alphanumeric
character, as is =C3=A7.  =C2=BD is numeric.  I would argue an alphanumeric
character comprises at least Unicode classes Ll, Lm, Lo, Lt, Lu, and Nd.
Unicode TR#18 agrees with my assessment.

If we wanted to restrict it ASCII, we need to state that explicitly.
Alternately, if the constraint is 20 UTF-8 octets or something else, we
should state that instead.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--5UxUmwa7vptbVD5I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZeehSQAKCRB8DEliiIei
gbTTAQDyb+8RoM0EA9UZWYTTZIw6WzGcolO92Xlzt7vr23s4uQD+L86Su+cGG94l
2gylIDxN83vtnqnm+eCkRAN9YqKWWgU=
=bQRW
-----END PGP SIGNATURE-----

--5UxUmwa7vptbVD5I--
