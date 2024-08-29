Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADA01B3B1D
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 21:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967501; cv=none; b=iP1qlgig2oDkE418cx1tY9gMP5g4r/N2Q8HFrviX9sw/Vx+2s50Pri1MCl0EOJEOAj/AURcz3Nnw+i2KJtuCpK4cxhPgsNfNcWUBBHRuiSMuob3Ckp98jh1fQd51kkOOIH47iFIIE6dokqYulAorqttjZAzRewOQnv2Ghj/3dpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967501; c=relaxed/simple;
	bh=g+kY+q2B8XDPRelbebAD/VHxZeaM2TGMaqWs0LkcOcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtVd+2D8qRTai26SCZNdhUi5R65xlLwxYVWVtMz+mKhY2gg37ha8AMwhXT9/3TU2+Sj/p51VCEnBjd20CO4cktCK0p3UTqW0NheDLft7dRLKt92KEOpHYgb1AbUPXpig/sScz/2NvNuZqtMZlkvxpZPsDx8BWTl2kXXgym/vOfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=jEh2S+xr; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="jEh2S+xr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1724967165;
	bh=g+kY+q2B8XDPRelbebAD/VHxZeaM2TGMaqWs0LkcOcc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=jEh2S+xrBL2H8R/8Vc0gmc5rOO86xXqYHpc5blEFMcjGCOJKvyDXdNRe6iCOmfltO
	 DoV+a7eqVmA1dQI6QfBWRFgnk6JZGDUW+UxpLZVyCciIgb5NhHF7MdrfCCHxe3SM85
	 UHvsTy565Z4g7VflkaRfShxDCeZQcOefuphT+ocSMilnVh81vaC64k4AGQzUbfokr2
	 UGe4ZjDjdSBgt8ljMzvFVlmZBYLayUHjCNz5vp3DvEL7FV7cCQaflUA9byDIKppwyP
	 sSNlSj0sId59tKkn6t8E8IH4SrKqyx2gck40xzTl4wnGsrtZVpTKVqaswTo0Bu1m4M
	 PuA5HNe3ZpmxWGRcsIjvdLSfAKz0JfzlLYUWFLDkQEH6ilYDFIHYkMy8bwFYkpeyRu
	 u01MMzLi/nKtVhwBpu5aixcPZHtIxp/jQiE/nhWnYR4HfasjXA1rrgcVxWozI3ea03
	 rojgnGryHTbaIZtNL2j7FlmVoHTLqKlUp32Qqo6d6QGoGqMZ2Tu
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 390CE24429;
	Thu, 29 Aug 2024 21:32:45 +0000 (UTC)
Date: Thu, 29 Aug 2024 21:32:43 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Yukai Chou <muzimuzhi@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Tags auto fetched by "git fetch origin" but not "git fetch
 origin main"
Message-ID: <ZtDo--AY43-bPTHG@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Yukai Chou <muzimuzhi@gmail.com>, git@vger.kernel.org
References: <CAEg0tHRbGBBq7i78bTSfws_WZO=2W7xuDwiT2qFA5iOza8qDDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RrTpzoSFfjnClW76"
Content-Disposition: inline
In-Reply-To: <CAEg0tHRbGBBq7i78bTSfws_WZO=2W7xuDwiT2qFA5iOza8qDDA@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--RrTpzoSFfjnClW76
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-08-28 at 23:23:57, Yukai Chou wrote:
> In using `git fetch [<options>] [<repository> [<refspec>=E2=80=A6]]`,
> - when a branch is specified as <refspec>, no tags are fetched automatica=
lly;
> - when no <refspec>s are specified, tags are fetched automatically.

Yes, this is expected.  Tags are refs, and when you specify no refspec,
you're asking for the default behaviour, which usually involves fetching
tags.  But when you specify a refspec, you are saying, "I want you to
fetch this, and only this; don't fetch anything else."

For example, if I say, `git fetch origin
refs/heads/main:refs/heads/main`, it would be very unexpected for it to
fetch tags as well; I only wanted it to fetch the main branch.  In fact,
I might be explicitly relying on it not affecting any other refs.

If you want tags nonetheless, you can use the `--tags` option, which
should fetch tags in addition to the refspec provided.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--RrTpzoSFfjnClW76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZtDo+wAKCRB8DEliiIei
gdKnAQDHoIqgqwSznrULcBzRPkRVRJMcwioWvhUsruzeAzIzqAEAoMqSB1FHGJgO
yNSrzMfww0e5GZLfaC3K1ezFYf9a9AA=
=/c04
-----END PGP SIGNATURE-----

--RrTpzoSFfjnClW76--
