Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124E515E5CC
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 11:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351702; cv=none; b=Joguznd6hDwDFh4omYozIL1cSJW1usmaDURr2wjAjXJy1T2lkNsGsWhJb2b3Y+s34f3Xqc/esfjlmw3Y/IO0NsthngorUY5PiNdyroP7S5r88NI+BEWIkaWO33bTPvuhxhUmEgG7j/SQ+5g62TlpLEfAexN61ULfSt3/J7so3iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351702; c=relaxed/simple;
	bh=J4tza/FMQXNGv7BDnnno1IzwoA27U4BPvXcSrorpCQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTatYndEYzMv8azXUrT36wGZ30q0S6v49XobsirbPMdDZ+eLtAnwFAdKWUKdBNurt1jUxNDkdIvknsPIxRX8ikoOhQ5Xiu0tkW5ffL+iw0ALhxx3EPRSEhPhzfikRzpFtpzuUcbspqnjsopUdyZeq/abe42fZWaUIkNqYUiOl6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=PacCI+bl; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="PacCI+bl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1727351693;
	bh=J4tza/FMQXNGv7BDnnno1IzwoA27U4BPvXcSrorpCQY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=PacCI+blnSLydAcVczu/lvEtig9GJVIuI/NsZf4mA7OmNRguQXsQxg/EQmQSsisFp
	 tlZnFXuepp7wg8o8eXCsnUgnRtapLUxnWu7doCB8nWpo7w1nsQggZWlIlWHA6ELsJW
	 Q3bzfNc/FrdFGlcoPvLi4G8BFVz/cAQP+xuXaRt5BJVd9EJIFRMMO7YlcGFC4ut4kU
	 UtYy1T/4I2LHoWEcj41dhbj7f61rgBQwWnr2ImT567up2bjb4KnogMX/zcU0fC1bHl
	 TwNRM1ULFwHJL6jk1MTUniQyImj2xjOP2eZgR+6nMWEAfFI9ST0zPiFIQ94GTavpdM
	 vQkJCHXfAaGEY2no7TzXHYTFbxJintmBUP9QlKMJICZB2X80cERjr6vWRNLAhgeIe6
	 JvWLRZTSRPKHNlKVVeLwl03nXeO3RykJ3X2ZXKoIJ9zHWjouyGibsJSVL8LLJkDg0S
	 wdCQLc+0mK3EKSL1N0U4gXc0VkTaGuX2jy8ByCotlHBxDkGltXu
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A8F0E2006F;
	Thu, 26 Sep 2024 11:54:53 +0000 (UTC)
Date: Thu, 26 Sep 2024 11:54:52 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Krishna Vivek Vitta <kvitta@microsoft.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: Git clone failure
Message-ID: <ZvVLjIa0ynRPPkoV@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Krishna Vivek Vitta <kvitta@microsoft.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <SI2P153MB071833367C62DD94C96CF1F7D46F2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <ZvMy_gAL96v8ahfz@tapette.crustytoothpaste.net>
 <SI2P153MB07185B9AED66870BBAD3C78AD4692@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <ZvR58tnLEMBZC4fa@tapette.crustytoothpaste.net>
 <JH0P153MB099919ABE06434F49ABF43F7D46A2@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K3rkdsuzByz5stkf"
Content-Disposition: inline
In-Reply-To: <JH0P153MB099919ABE06434F49ABF43F7D46A2@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/2.2.13 (2024-03-09)


--K3rkdsuzByz5stkf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-26 at 07:11:05, Krishna Vivek Vitta wrote:
> Hi Brian
>=20
> Can you point me to the GIT FAQ about the recommendation.

Sure, it's part of the proxy text: https://git-scm.com/docs/gitfaq#proxy
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--K3rkdsuzByz5stkf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZvVLiwAKCRB8DEliiIei
gcqHAP0bttfdTNeSgzjX08OmbCwKlx32Ww8xkTlrprDVF1BqEwD+Jw/ytZpOVpmN
u9NIA5jTZNi4OYsEgMe/0K3flLBmTws=
=bHoO
-----END PGP SIGNATURE-----

--K3rkdsuzByz5stkf--
