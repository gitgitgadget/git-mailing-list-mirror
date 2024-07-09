Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728D2185605
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 21:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720559626; cv=none; b=NTnCkikyqB5JKNzaq4jk/WgEGLc4kz+wpNxw03BJjIzD+gp9z2XebTnQ/+2fXlXvsoPng7ECnlenlkfQsnZ2hFNJUv03nrKk67h6xkSTKi2qlOArm2bB85scDZQzu3JOvUxxwk8Yv2Tt2CPk8LY7sUj09NFCg/RmitziyoiKkR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720559626; c=relaxed/simple;
	bh=jMMGcRnEUwsJiAYuYfFYynFazpM+X+cWJoTvbTTrr/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WH9VBIPqzj9EEg3AnlnYy1z21BInzj17mgqNu7TfWTUr25KRHwub7wUS+6I6hMQlnEy+oIpBmIBukDo6TsjCuBKyfYXKMPsDdwaHfJF2mvaNj1Wj40zeypDH+9K+3Ag8aQRAgTje58iiRO30/uBD9s/r61DT5b2NYddu4KCcQyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=K3RdhPy+; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="K3RdhPy+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720559622;
	bh=jMMGcRnEUwsJiAYuYfFYynFazpM+X+cWJoTvbTTrr/Y=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=K3RdhPy+fMU8MbaKvNr5bkjziDmCoiTpjzKOXov4QDNm7Tf1NDfwVNUdJexkv70Y+
	 XMB9aWQLXOOXk49btTx+lPUHx3JpNtL8Alpcpsj+7dCx+3y/jeaMvrKf35OrqlRtgy
	 k++TxGidF7LUESEZMv1d7Ol9pjYT+armlXWfK4WFjJpoiuY5PzCYD45uLoZaM4JE/w
	 ae3IMGmFYxu5dMTLWpi2yBnu8Oz239JGlslqJbafBYacSs7AZiftA8b87Wi4hZeE/Y
	 zFdMrf+vn11SANv1Nhb+mhtT/d2bkdnnjGUom/edwdBQBhFqL+sfGOTi0Qi8E8STjW
	 JF6XKRuuwJ2pcYViisocsIDprwTyEuNNOtRxXKiEPsEqc2XDeFHkL69oPsmH1MfULC
	 7PucveM/3mXfZ71RV9FnlYxr+Hx4/dwLRaZhinx0PAuvznQVBE93w4F4GGWkblns21
	 upoxsK94p8+2vDLRXQ8JJEtnzAf8BO5BhH99IlwWsSVEZ+jJgeG
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4814E20991;
	Tue,  9 Jul 2024 21:13:42 +0000 (UTC)
Date: Tue, 9 Jul 2024 21:13:40 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Favour Ajao-Rotimi <favour870487@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Git installation file not downloading
Message-ID: <Zo2oBOzjqTtBJS8w@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Favour Ajao-Rotimi <favour870487@gmail.com>, git@vger.kernel.org
References: <CA+7C6U7EaRndbSUYULwYdNMjTjfRZD-2D=ABVFVZzz74bx-f5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+9SjenMx8JyX/lBY"
Content-Disposition: inline
In-Reply-To: <CA+7C6U7EaRndbSUYULwYdNMjTjfRZD-2D=ABVFVZzz74bx-f5w@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--+9SjenMx8JyX/lBY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-09 at 10:24:52, Favour Ajao-Rotimi wrote:
> Hi good day,
>=20
> The link to download git to my PC is having issues. It keeps giving an
> error 'object.gitusercontent took too long to respond'. Please find
> the attached image. I've tried using a different browser and also from
> windows powerShell as I saw online nothing seems to be working.

I'm going to assume you're trying to download the latest Git for Windows
release, which is hosted on GitHub and does appear to redirect to
objects.githubusercontent.com.

I don't see a problem on my Linux system, which downloads the file just
fine.  Do you have any sort of proxy installed, including a TLS
middlebox, non-default antivirus or firewall (that is, anything other
than Windows Defender or Windows Firewall), or any sort of monitoring
software?  The reason I ask is that some large companies (and some
individual users of antivirus) have this kind of proxy and it blocks
certain types of data.

If you're using a non-default antivirus or firewall, can you try to
completely uninstall it and reboot, and then try again?  Unfortunately,
disabling it is not enough sometimes and won't fix the problem.

Another possibility is that you're using some custom DNS, which also
might send you to the wrong site to "protect" you, or that you're simply
in a location where you have poor connectivity to GitHub's object
storage location.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--+9SjenMx8JyX/lBY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZo2oAwAKCRB8DEliiIei
gX3WAQDMEqlv2nhaldrX8q6tsPB6VM4zRCxMZhAFpLgI/l2IqgD+IgP9+B3PX2FT
fa6lsmH7gT/MdP+obxmlBlR7F8CBwgE=
=JR7D
-----END PGP SIGNATURE-----

--+9SjenMx8JyX/lBY--
