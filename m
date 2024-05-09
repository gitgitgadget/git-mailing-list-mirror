Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719CB770FC
	for <git@vger.kernel.org>; Thu,  9 May 2024 22:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715293953; cv=none; b=UDPIVITbRUwbka2ZWYSGtLCZJj2vpix88MgLj4Yw/bnlD2AaTVu9RavQc5GqIygY7IBt8Eq6508m71pkK1r/AKkJPKvo98V6OIOWB2KKlh4OpICH5Nd960lnWy9+d9ddfSyZJFCgmGQrZIiw7JaWVTXH9Uq4Ov1ewSaki08jaDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715293953; c=relaxed/simple;
	bh=541myGYsJHBsHA5bH7Tp1jSKK+hhq/tjLTaTrbzTML0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mB9QzMuItb8g/V+4ckT48knO0ebCmlwQ9uHg2UqTxLeM1ysDyeAdvmoPF4BN94gWWML1D02qS9Y8mSpRcCnPJiZfclDhokLjmsu4+pNENbXr7LYnd+cIRk+udTg3sFdy1DCzf78lhDPn7dbXfFA1zf3V9rmOK2QfNG90tV18yxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PleKk3O5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PleKk3O5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834D5C116B1
	for <git@vger.kernel.org>; Thu,  9 May 2024 22:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715293953;
	bh=541myGYsJHBsHA5bH7Tp1jSKK+hhq/tjLTaTrbzTML0=;
	h=Date:From:To:Subject:From;
	b=PleKk3O5HvUZcr39IUlYBpYr177nygernpFrn8zYY6fZy+pPoxruB/2K72bK/+zsN
	 iEJTGHrwbXPiZitSWgQBseDaWuPVELSlpk/kSHXN/XfLCp4zJHyYo7GWNjPblPjF/L
	 0Rc2zZxcEXsAHO9XLDabHlx7+HIDe54S9GercEog60Q1WuIwYfUMJ9JXvCsu8mB6ZT
	 7hQlHhVSpOzgMCSeIiRqoOIV70R8paAUDS3GLNuuBjXW7F3j0obOINtlD+5MQd0IkH
	 tho734RbM9MvUXGr5Nzz2YdWkKgSB0kdE/tBpdAhPTZZWRG0eWaQwe+qBxhV5TdcdU
	 2qiK0ELajZqyA==
Date: Fri, 10 May 2024 00:32:30 +0200
From: Alejandro Colomar <alx@kernel.org>
To: git@vger.kernel.org
Subject: git-cherry-pick(1) -- path
Message-ID: <e5pklmijfpbsnl2trj4n4czam7n7i37gx7w56med2pfaf6q3yx@wizseio2ickk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ji2zsdlvwbjagaq6"
Content-Disposition: inline


--ji2zsdlvwbjagaq6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: git@vger.kernel.org
Subject: git-cherry-pick(1) -- path
MIME-Version: 1.0

Hi!

I'd be interested in being able to partially cherry-pick commits, based
on a path filter (similar to how many other git(1) commands behave with
-- path).

Do you have any opinions on that?

Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es/>
A client is hiring kernel driver, mm, and/or crypto developers;
contact me if interested.

--ji2zsdlvwbjagaq6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmY9Tv4ACgkQnowa+77/
2zKRexAAkLqkNEfhKzrktf3NdihfRS1dVac3fjDmTKv0eKVIQ3h7hPTHUrV/xZtN
Z3JEH3xqXGZZLCeHjYbUvOivrspPaFqYjURfu6Wok5ocCNJceh+XU+74USmwPLtC
Tr1q/YsUjl10rNQ9AQ3DXICc75iZjNgeUSIAFa0eeWooFsdFnllkJKJycluahEI9
psgq59AN6KEMaGd78A03jK9LKnTtajeb8ZBJjtCjNqlbszkX2qGxNrQI4sKZDVAQ
Z9JNvmcyYOLqdKcaVVltxFjBfidMSJskOUUqXn9Z2HAO0kdbg0jIuYMSJ0qFeCwp
18Iagdm8sNR2ZgFIOjr/V1zhM1jr37cxC2wckqdVuns2GSMvjdMXVlWMZO9dSIBV
8grJru9o+INByM2Hv8JTaU/+OBMaSc2dZbUMRTPg3/rxa6kqsg3e6306DMcuXDJu
R8aH6ns8upj+ENo8+ZL1ZBhZSq8GhDfCIkL5jkeg/RbXuaG+3IYBG5RHr6XKXtnN
4TjByV2HfYH/E8LUEn6YQ5hXDFT2Eg8YfC+lN0AaOGneB/sc2NTLdasV+zZ/+p+5
ZbwJUnSKdR5kXLxmkh/ZHqSC09YEW38cOCRATpcCd9+lr+r+q3EayV1DKSXEltNh
uocoIwR6mlO35bJITsNYtheiBEaNKhj3Ibb5r5zgiBdZRcVqhys=
=dPbS
-----END PGP SIGNATURE-----

--ji2zsdlvwbjagaq6--
