Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBE72D039
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbZemCjK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFD1C433C7
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 11:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699355489;
	bh=7BcVe1W/FD16E4seFhd30oX6mvZx6rHE7+8N/qumBhY=;
	h=Date:From:To:Subject:From;
	b=dbZemCjKc0a34NvkyD30CTlQrl0JoXwoOuxnmER74QHPzAwonviQaQV8WhYYo10Es
	 HxBTfDRwhsS+7/0HYIG2gqGLjOmyAWCBi4ul9GvTONbhllVVn1u8H0PO9VxNVnC3uy
	 xy3GnhqM3f+oG07HELhZAXBVS5xb8HGADqvk3c74c7h/vawbuI5lXQnDbOU4ioZwAf
	 iQrt/Vxz9u+6vO4299WuYO06Bi7rx0vqIVESjakpzwZ5Ega72i4DMN1lUv6+OSzq5G
	 SiM9db+u4pBaot7RSxJ7R7GeijklnPaEaoH8WmJKsk1aCdaRmUhqLht4MNt1ZYG7FK
	 trSZraWSvfsCA==
Date: Tue, 7 Nov 2023 12:14:21 +0100
From: Alejandro Colomar <alx@kernel.org>
To: git@vger.kernel.org
Subject: git-send-email: Send with mutt(1)
Message-ID: <ZUocFhmPHstwKCkZ@devuan>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w/8NzKZjd05QSpDf"
Content-Disposition: inline


--w/8NzKZjd05QSpDf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 7 Nov 2023 12:14:21 +0100
From: Alejandro Colomar <alx@kernel.org>
To: git@vger.kernel.org
Subject: git-send-email: Send with mutt(1)

Hi!

I'm trying to use mutt(1) with git-send-email(1).  Is that possible?
I tried --sendmail-cmd=3Dmutt, but am getting strange errors.
The reason I want to send with mutt(1) is because it can encrypt and
sign mail (with some tweaks), which git-send-mail(1) doesn't.

Thanks,
Alex
--=20
<https://www.alejandro-colomar.es/>

--w/8NzKZjd05QSpDf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmVKHA0ACgkQnowa+77/
2zKpehAAkuD3E0odtXV46wo2fJJ6d5v2sxXZhk/Ku/yXgGmH4w76o9Nu0h9l2hL2
6YenibIKVVYUkCPsPBjWmgvrDjaP8OKlwihVTCFIVehfdcST+FG/jWIWfhpntAxG
i5LiLF2/2du9p6ll4dmtVxHMOK2ouc5tPuWjggCnuz6SX5CIQqkBNaDyU5msMAMj
G4uMV7v4OYWRCNSqDid0r0kkUPymdvL2Aim8wFj7ZNlT/9qwIVk/qQEbZgiFpr0A
oiZgu6SFWOcE48w1xDCQBM01ys3e96ZrhmHxlh3bTFpxQV9rUtn0376SpLpXJoD0
EejFl9GDtst3VFHjbEw9NXXJfPE1NJRBPI+XhL8u4F/+agjgBNpdnzwRRe2j/V2D
rmxFEoeiv9iPUKT2hdlf+VNG1htkf+QOe+TuMRiXcD3qdrthvBSnU6uHWQhmpm1m
C30NaA67MUcHat5wJZ+CyLSH23aImd2dk2m9ukPo5MYq9M4GK4DFmesF5nn1Obq9
iwYsFzBWJi3dxJDB+ktnk7aGn5dV3zy3Rz4GINAvtvKC7FZ+cnvSMPx0+O3vaoTX
VDWqHiWxiPcwP+tw1zK1dEJH7B/T7nMbKiLQXMo0k6rmablHt8KKWpgwqbLqoKzq
fvE3IjhOD2CL0alEyfHkMem5WYOVL4heMDGEf2AvnsvL1PXKtwo=
=+v8b
-----END PGP SIGNATURE-----

--w/8NzKZjd05QSpDf--
