Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD2926ACB
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744237927; cv=none; b=tHCRVsCWDpOjbkCnzB6WSKoKRAjLGP8dV4APURE/v+YJDqiaeq7JQlOhJD9ckZIroYq2JFv2zgb92aSlXRFfNLr8/RRIRoPLICs2gxyMhRxjm2rJ0UdMSc26QXiqOYiudhO0J2ANnhYiTKfGVptRMoPnbgTwmIfLO0DwePx+IXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744237927; c=relaxed/simple;
	bh=AlHWHGfXukGKrDulAMt6f6fXD2+zIe0IU6a3IRDOYuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXCHT2vdAm9ajsQHfyLF3P6bhZbPU1Y+FlL/tszj9c8ztKzT7/2ndOvkDN5UDu/kWFmMkFOO2noW8k/8p4BXA6WtuNyCWTK4LljLSwdNXFBnfwFLsG6KXWoen7zQAWxVh8++00fjNJ0su8UpShdfQDVgddMnYVFVjES2KkdHQ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=GSxvZbXW; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="GSxvZbXW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1744237558;
	bh=AlHWHGfXukGKrDulAMt6f6fXD2+zIe0IU6a3IRDOYuw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=GSxvZbXWE6LAcAEh3xprxyURMZQIc2jlpKjhKqMIS+rYNCbinHS41itfBgBT1ai2j
	 K9wknOhxmh9EZeFebGYIa7o6GEP8qhdzW62lj+mc9AASJYaZpJeJP9/Wed/0CORIDS
	 xaxOjJwJSnPKa99RopZ9ArSlLOAMvdzSVm8Oe1w2LQ0UxZrlhbESzFL9ffgKkYRokN
	 ifPhJa6VUnpDo9aQGwGnQ+q3UYgUwynJAZxd6hXVTLSn1N2RZUTZqzNk+J+QFFT11u
	 yqey/RDWSAUvZnyhV8dH87Z9JK9sW0tYs5xA8RzYHdsRcjqIw1N5k3pr/gjBkZn64G
	 f+nPo9U34660iEscej59x9fZEMPTnxsOeSE4FgF46oQxMGph+zo2mMS575CjmTVrMT
	 guZzlAf8YDPLqcPQcm6pCt87d01izWOBM63JSRqMdR6+q9vS3PiaSv4WMh+f3udjxL
	 gJj2WpLZLBdJpATenIA4/czriM4lDCx32Tg0l37KJDuuMvdSfu9
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0732120107;
	Wed,  9 Apr 2025 22:25:58 +0000 (UTC)
Date: Wed, 9 Apr 2025 22:25:56 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio Luan Pereira <junioluanutfrma@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Error on using git update-git-for-windows
Message-ID: <Z_bz9Os4AqjmL8LR@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio Luan Pereira <junioluanutfrma@gmail.com>, git@vger.kernel.org
References: <CA+7SsOdTiAocj7ZTV=OVw0tyKJxZ-H+m5S8soPfFy6zW=1ddzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/IF9S/flTVdfuDSx"
Content-Disposition: inline
In-Reply-To: <CA+7SsOdTiAocj7ZTV=OVw0tyKJxZ-H+m5S8soPfFy6zW=1ddzg@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--/IF9S/flTVdfuDSx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-04-09 at 19:52:31, Junio Luan Pereira wrote:
> Hello everyone,

Hi,

> I am using git-for-windows on a windows 11 laptop with the Brazilian
> Portuguese language.
>=20
> Recently, an error occur every time I execute the git
> update-git-for-windows in the following way:

This particular program is specific to Git for Windows, which is its own
project.  You'd probably want to report it at the Git for Windows
project's issue tracker at
https://github.com/git-for-windows/git/issues.

> $ git update-git-for-windows
> curl: (35) schannel: next InitializeSecurityContext failed:
> CRYPT_E_NO_REVOCATION_CHECK (0x80092012) - A fun=EF=BF=BD=EF=BF=BDo de re=
voga=EF=BF=BD=EF=BF=BDo n=EF=BF=BDo
> p=EF=BF=BDde verificar a revoga=EF=BF=BD=EF=BF=BDo do certificado.

I don't use Windows, so I can't really be of much help here, but I will
say that some googling indicates that this error could happen if you
have a proxy (including a non-default antivirus or firewall), so you may
want to check that first before reporting.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--/IF9S/flTVdfuDSx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ/bz9AAKCRB8DEliiIei
gcQEAQCDGlS6kcNc4BIzmdK8660w6/0YyBOqGo8/TmfxGjPweAEAp+PAJnZn7PR5
ncn35QQpncE67LuA/S/uDczD91SdAQA=
=3XLA
-----END PGP SIGNATURE-----

--/IF9S/flTVdfuDSx--
