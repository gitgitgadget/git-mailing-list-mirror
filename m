Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D82622538F
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 21:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756416673; cv=none; b=XYhnWRgTrvZya+RQ4i9aAxnx3R/H0wIMKRYqyvlFwY6bK887rb5N84eL81/PZN+Ny7+VHZDa+ZC3MezlTe7NtVDNz+igDbXlwWJ+c9EXIMJOj4rbAvr5qNi2YYlTJBvWGD5f6mwmqC6FwSYXMl6hSJ22y+Hm8PmVSjHORFql4PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756416673; c=relaxed/simple;
	bh=Wsu0RcF61FXWxpEWP0lJPu3vVkvSl3HGtfxFmW2mWoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbzYXSowqQ6C05aXMZ96TD7xZRkfe2xIYz99pEV/nBIr3tLdfUsO+dUp+l24IZ24Swcc/xxxLsK4SK8FuTPm0nL0ycci0KWtgQJN3NACBIFol0cpQfhlKjFI2Af6iHUkn8CIaM1vpUp7UHzw5UY9JfD6tzycQhwsMRtKzZm+7Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=MoeVAENL; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="MoeVAENL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1756416663;
	bh=Wsu0RcF61FXWxpEWP0lJPu3vVkvSl3HGtfxFmW2mWoE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=MoeVAENLNJiPxgFzs5GCrtKQogr7G1cJ8O/1zge6d4OBbVPlEzsLmbaPiV+Rf5BJR
	 sT47KeVVuFCDgi3JglfGs3PXDVxOU+An29mTcWA1rM5i8lxvvKVpZgnBzHinzDZEc5
	 iTSg7dqkXIcEg+pB+xNJYz1sMDGuwTLXkutVpqJ/RAvALNYC8QZTSwYyVfcQ+hKqA9
	 xWZ2DRtgk+Hoj4vPzJ568tUCCkKz90la/8Im7d75B8vanYmSwjUxhgmdK6IN8kPxLD
	 wrTkATDwJvzl58+KrDtIxt1sMOuIhK+q1+e6IOqYeHD1jokVziyBnxpOeQgqp9Ecur
	 1BQq2AzyNmPwI7Cj++g1Yn9lWn5hDvxnY3aj9otkGPKl4LXet3pgmLoDpuzaBKvhAn
	 ar/IXAIQSzopRzEvaV5Is/HBg5/xE9pA9MAJSTjCLovZ4Nos5nKr0HQd/hSCq1C40Y
	 aHWrWa3rJFvYHUjklPn9fCccqOnbXBKcZgqV5Jt8+CU7mqWIzy/
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:db8f:7ecf:23e1:9783])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id F0E98200C5;
	Thu, 28 Aug 2025 21:31:02 +0000 (UTC)
Date: Thu, 28 Aug 2025 21:31:01 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wing Huang <huangsen365@gmail.com>
Subject: Re: [PATCH 1/6] t0018: switch default branch name to main
Message-ID: <aLDKlfsUrDTrKrl_@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wing Huang <huangsen365@gmail.com>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
 <7c20f7693f4518ef79be0a2277515bb00d912213.1756308283.git.phillip.wood@dunelm.org.uk>
 <xmqq5xe81y0i.fsf@gitster.g>
 <b6b60e6b-c06d-4dc6-8722-b53736f8b059@gmail.com>
 <xmqqbjnzwfvk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JBM34nZUQnOrVrMk"
Content-Disposition: inline
In-Reply-To: <xmqqbjnzwfvk.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--JBM34nZUQnOrVrMk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-08-28 at 16:49:35, Junio C Hamano wrote:
> One thing that is missing is probably a way to remotely create a
> symref (or repoint one).  As it would break existing users if an
> upstream suddenly switches its 'master' to 'main', the second best
> thing to do is to ensure that they always point at the same commit,
> and the natural way to do so is to
>=20
>     $ git symbolic-ref refs/heads/main refs/heads/master
>=20
> but we cannot do so remotely.  I've been doing the third best thing
> since late November 2021, which is to push to both at the same time,
> which is ugly but https://git.kernel.org/pub/scm/git/git.git/ and
> other mirrors may tell you that both are available.

Yes, this would be a nice feature to have.  Oftentimes forges have
external functionality that needs to hook in to name changes, so they
might not choose to enable such an option, at least at first, but users
using things like Gitolite or simply bare repositories over SSH might
find this to be very useful.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--JBM34nZUQnOrVrMk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaLDKlAAKCRB8DEliiIei
gfmdAP4gs5eM7cc0p02pAEIjIufIpo8qT/MAgOxjmJhhMlgeKwD/Wq/W9qjMvLqF
YBCEt/SGv0WgyoNHnEgCHNoV2K+JhQU=
=H6zi
-----END PGP SIGNATURE-----

--JBM34nZUQnOrVrMk--
