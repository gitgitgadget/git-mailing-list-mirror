Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE50212D21
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 19:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728417158; cv=none; b=JL4ulY0xJ6KNCq26HhujCDemwfwB3zbXGkNMKlWrZffpuvSWH7aui6Ec85l2COfzQDRDaIeQsV4kgNNb0JhPVD4vDDyfcbX3260lfG/IgquJ1Rffh4soiT9J/N2hzsrBxyhvRrOgwK5CUcEIwtnSPZu/TnUKlkSbAdZvFPfxIqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728417158; c=relaxed/simple;
	bh=kbbVuMcbRYEiIB2FW7SQCMDjTRTXVCyiNYLpjqTl46Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0gWyQjNS6eZ3gr82fjDa7I8RxWUujs+UKLerYWoTmbGaYX0zPa779w03Hk8GVOwbyN4N3WouumnCCfF7SAJSEW5mOrBv7+YbcxJky2Cs5LnATO9F6888A56qrAedikYCQY5+E5bvHDFdnJnqXYjXvLB5JEJk0cegsUipQly+Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=IzhoAjIj; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="IzhoAjIj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1728417155;
	bh=kbbVuMcbRYEiIB2FW7SQCMDjTRTXVCyiNYLpjqTl46Y=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=IzhoAjIjytA/9uNnJX5FEPT6bpMdQt/lL2NZSgjaqMpTQ/fMdDtU0oMXtYs6Gbjmu
	 jL/3ID315NdACZBX083WlBg9jm5Jx5jREH9QlgZfhxru6FakViB3406xaJBA2waKEb
	 fJkTBKrmwIrj3m+6mkKSd+c4o9jBkSbeSuuYur/DCnWGfySO3LumKwc07wTmeYADsg
	 AX1QO2dXzevlH4Bsj9NGyTUxNvDofs+xUWQjB20t2UFE8vLv/wWkkaXVMskptegMDP
	 CxKkqViKtpBzA8r7E3fTidoRKctwQd4eS22oZq/pJp2RuKnlu5RNES1r/fJe89OgwW
	 MVo0em/xOOmSMf8ig51dTrf0mLcAUPeB8XqoqzxWoYUYxVGrmnGiFe8bso5lEs1YwN
	 /+/DZmRLUJntf4IgwaA1+WaFuaBcUiZu4RvyYUeWrlHWUey5Z8wvI3NoqpQPsm4QAV
	 L7aKo3R794g+6HtgwOWY4V6AjB6HieLdkOKobKRCnNpHFUklBsI
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 2762920081;
	Tue,  8 Oct 2024 19:52:35 +0000 (UTC)
Date: Tue, 8 Oct 2024 19:52:33 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Spencer Fretwell <spencer.fretwell@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Verbose Commit Ignore Line Fails via CRLF Line Endings
Message-ID: <ZwWNgc6JY46bmcjE@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Spencer Fretwell <spencer.fretwell@gmail.com>, git@vger.kernel.org
References: <CABa71ByU_9g_6OgJ9PsoQ99oyMspucTBqO-RkB_2W4smTr2RNw@mail.gmail.com>
 <CABa71BwtEWS79CZwPOa_Nrh1iMrXRo+hyxNBc5F8GsQiwjdapw@mail.gmail.com>
 <ZwWDd1_76Z6zH4mP@tapette.crustytoothpaste.net>
 <CABa71By0WYkbNip6-hmcX2jH1GuHWEx=WBTda5=RV9koR-cVFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jte2wW8/6DKhK+wX"
Content-Disposition: inline
In-Reply-To: <CABa71By0WYkbNip6-hmcX2jH1GuHWEx=WBTda5=RV9koR-cVFg@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--jte2wW8/6DKhK+wX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-08 at 19:34:46, Spencer Fretwell wrote:
> Thanks Brian,
>=20
> It appears sublime auto-normalizes endings to "whatever occurs most
> frequently in the first 32kB". So, I guess it was witnessing the CRLF
> from the verbose output and replacing all lines with CRLF. Thanks for
> the reminder about --renormalize.
>=20
> Is there any chance for git to support a CRLF magic ignore line,
> particularly considering the variation in standard line ending across
> different platforms? I tried autocrlf=3Dinput as well and it sadly
> doesn't normalize the commit message file itself. Either way (magic
> ignore with CRLF or normalizing line endings in the commit message),
> would be appreciated for mixed line ending workflows (especially
> considering WSL)

The answer is essentially that I don't know.  We typically make
decisions on whether we'll accept features when we see the patch.  My
guess is that, assuming someone (maybe you) sends a patch, it will
probably be accepted, since I wouldn't expect it would be very difficult
to do or have major impacts on the code.  It might, as with any patch,
take a couple of rounds, though.

I use Linux or rarely other Unix systems and always use LF endings, so I
don't plan to send a patch since this doesn't affect me, but assuming
the patch looked reasonable, I don't see myself having an objection to
it.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--jte2wW8/6DKhK+wX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZwWNgQAKCRB8DEliiIei
gSMFAP9rXSGWu0fTbSTGTNpVEu5xQRSyDE83mKnsDPvUJf3gxAD+O8wvnir8WqJl
mxE7zCL2zxoloXBS0Y7CqYcRhAdW9AY=
=IEZ6
-----END PGP SIGNATURE-----

--jte2wW8/6DKhK+wX--
