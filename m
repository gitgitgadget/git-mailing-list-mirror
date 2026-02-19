Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58222AF00
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 00:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771462717; cv=none; b=VFffwqAD9xtEkNyRj6MYEnB3zvCeaO7NE/fbzeDjfRS9zD+jM2zXLIHMv3+3t9uqGgGNU7Au13ikBA+Ij1JRl0Nv5X5g2x97RPeX/i37rLWbIlsZ+k3ThlXFU4r8L85SMMa8XVAHtfYcjBExReVZtU43B7Oe/PIWC+UbCll9jwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771462717; c=relaxed/simple;
	bh=Bnt4xuFqeUd7p4kAUks5eehLNqIYSTszGuFIlIQOLIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiJTNObEIFIPYKHN23Y0lSF8dxPwgHPBPvkm3uXQvny5L4gW6s7RIix7md8JWrEGogq/WNq9wTTg5EmoPvhro1COBRaaSv7LQSLYM5EStXC4ggZCNeFDSSzKzzcM+CO3JG+SnSA05zoCa0p1vtAqMStbR6aBbnkKl0YIUZUPUZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=OENA3ISP; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="OENA3ISP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1771462708;
	bh=Bnt4xuFqeUd7p4kAUks5eehLNqIYSTszGuFIlIQOLIU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=OENA3ISPKN5CtjoK1vbaOAyfWUQCE8BKFn6n3kyp8Dbera0rfkwUOs/RYdmFbw3/+
	 xmZOeupCg3/anMHBcYmfA++HuqQTRrZaWKlDJujfuOPE8sbHWL3llTkKLgk3voyrNS
	 RLc7uxALNrTXELFTyYRUw3X+Zwe2upVUkXTrsaL7kfXL8P9ZT0R/CvfbyVSStpw+zy
	 qN7ZQfKOtKgl5chgaYPYpQIq8kBJSRLujVoC2ALxCC9w3G0Uvlu/fURd4MIBL7RScw
	 efthLyvi6HPv5YVNhVYhx4LlvzLA+t06hQLkZmvzbd0jlt5K7FEfB/rYLXPEHjV4zr
	 9nb0nlIonckO+TMibBChveOPhihFLa3Vl4RnEGcnhsO8Vu4N5ARMQENFTBkGVGbACs
	 52o/dfFpxlpenOPoA/9c38HAw+7zlZXBXYseXFFFEa7qmW6h/SkJVc8hg9kQO+r29Z
	 bwT3VYUkv0pmTiIj/vSlmmfabKqkjhDEFG33G1d6BnPoyNswSpf
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d337:1042:f5c6:d8d9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3AB34200C7;
	Thu, 19 Feb 2026 00:58:28 +0000 (UTC)
Date: Thu, 19 Feb 2026 00:58:27 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Yuxuan Liao <homins2307@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [BUG REPORT] Git Bash for Windows Freezes When Receiving User
 Input
Message-ID: <aZZgM9LT8wDy4z0Z@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Yuxuan Liao <homins2307@gmail.com>, git@vger.kernel.org
References: <CAN3BLoV20U7HBXpSM=9aze-Pj_1y_Um6d1LodSeyPXDAp=sPPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/Ohi1PMUHG2v+uXF"
Content-Disposition: inline
In-Reply-To: <CAN3BLoV20U7HBXpSM=9aze-Pj_1y_Um6d1LodSeyPXDAp=sPPQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--/Ohi1PMUHG2v+uXF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-02-19 at 00:11:47, Yuxuan Liao wrote:
> Hi Git Community,

Hi,

> I encountered a Git Bash problem where it freezes when receiving user
> input. Below is the detailed bug report. Thank you so much for your
> time reading this.

The Git project doesn't ship any binaries at all, only source.  It
sounds like you're using Git for Windows, which tracks its issues at
https://github.com/git-for-windows/git/issues.  That would be the proper
place to report problems with Git Bash or other non-Git components.

When reporting the issue, you'll want to search to see if there's an
existing report.  Although I'm not the Git for Windows maintainer and
you should of course follow whatever directions they give you, it may be
helpful to test what happens when you open Git Bash from the Start menu
as well as whether you can reproduce this running the bash environment
under Windows Terminal.  That would provide helpful context that might
assist in tracking down the issue.

I'm afraid I can't personally be of any other assistance because I don't
use Windows (and I don't have multiple keyboard layouts because all of
the languages I currently speak use Latin characters).

Best of luck with your problem!
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--/Ohi1PMUHG2v+uXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaZZgMgAKCRB8DEliiIei
gQOMAQDnTNrwdLsF3qUvS0ZvFTuSnctPsWu8Et7mRjxsaJVs9wD+PET8tQSpTggu
BQP9wnSuMpsHtP3XKFKOPKhqRDdpFwY=
=ottl
-----END PGP SIGNATURE-----

--/Ohi1PMUHG2v+uXF--
