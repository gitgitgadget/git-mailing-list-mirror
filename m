Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C497DA84
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 20:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738440189; cv=none; b=qOIe5U8Vhjrd7gNX+Po003i1cYAlrTX/yYQ+Jr2MwoI27moi2sRdwdS773uMhkaNdikPnCVnJby+h/bS9Zp/REEbiO8z+MD3G1KGoegiKXiTP03idSvH9c+EK7v2gNVsB5U6Mh8v//K5QSJQSn5HiTOHx7ukEGCVtDRAv0304ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738440189; c=relaxed/simple;
	bh=2Fnuokkm8cNrWdAP1R8lt2a/A6LRvhIGhNbhvrD0Zls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1wO72OWSs/j6GjUv2R4Eyr4tnmM3jPckNkpP+WOhgYdvVC2/agIgB6+qslWDhFeIntKeQ+yvNXDbzY/uxlcASYdTA6S5QLi0B2fxFbF/9mIxF+0Rx+Jkd5pLtPju4uqB6R/ajJ0slnngv6C8gR/mJqYnOr18+4vZBqyvzaTctU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=UqJFwM8t; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="UqJFwM8t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1738440185;
	bh=2Fnuokkm8cNrWdAP1R8lt2a/A6LRvhIGhNbhvrD0Zls=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=UqJFwM8tpfAn8Il3b8IDuJfrnH1QQjHIWRfQjwIohrT0zgCdzbpkV4i7n7+rhvzxA
	 3gXesF9kkyIesMlUWfoUHiNxVp6R4pcdRHJqDHUDG11Px5rUmz8GXbeiaNSv0AWMDP
	 qg5bRE9DZKi+N6SG7Rve7pGX3pPAJK3JQa74/7uFhmzdnQ/tM1yZOakMgaeNCSRV7E
	 jIwNU4mrwlbYWG4x+6n+NgnAdMMXoLyS4zbUKX1ODn0cAyrO1eqc03BpOyyr4zaTJS
	 hFTSHhXf9BisN+6V0xWwWNnrPzAECxdN/nuyrlK9swymH2AnwMipoNMVs9n32UNsWD
	 1/ikOBPyVMLy6qzLQ1gpaNNaB0JSay175x3Eh46PmmoMjcoVL+Pco6L+cwqy7i9klJ
	 HraztalwiByZWm8QnRUyWkxQryEMXVTBd00ygdsoh+rvCikpTtZPO0ZU49q9yfgOx3
	 C+l0T5i6GAtrCmQwjwG3tWskb2gZDNP2hqMqNxva25hdm6JMmjI
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B764920068;
	Sat,  1 Feb 2025 20:03:04 +0000 (UTC)
Date: Sat, 1 Feb 2025 20:03:02 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Moumita <dhar61595@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/1] Rename all *.txt files to .adoc in Documentation
Message-ID: <Z5599iKKWOQ1KHXI@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Moumita <dhar61595@gmail.com>, git@vger.kernel.org
References: <20250201125851.21079-1-dhar61595@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rUxZDRskOaUn7M2z"
Content-Disposition: inline
In-Reply-To: <20250201125851.21079-1-dhar61595@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--rUxZDRskOaUn7M2z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-02-01 at 12:58:51, Moumita wrote:
> Hello, I am Moumita Dhar . I am a newbie I tried to do this issue because=
 it was tagged #leftoverbits . This patch renames all `.txt` files in the D=
ocumentation directory to `.adoc`
> to align with AsciiDoc formatting standards.
>=20
> Moumita (1):
>   Renamed all *.txt files to .adoc of Documentation

I think your patch has been incorrectly generated and is much too large
to make it to the list.  The patches you've sent to me have been as
large as 10 MB, which I'm pretty sure the list won't accept.

Also, I regret to inform you that I've sent a series that did this which
is cooking in `next`.  I realize it doesn't appear in `master` yet,
since Junio is trying to let it cook for a little longer and see if
anyone has any problems with it.

I might also request that if possible, when Cc'ing someone, that you use
the Cc field and not the Bcc field, since my mail filtering is designed
to place mail that includes me _and_ the list but doesn't have the
List-Id header into a special patches folder which is not my inbox (and
thus, doesn't go to my phone).  Your emails don't include me in the To
or Cc, and thus they _do_ go to my inbox and phone, which is much less
preferable, since I only review code on my laptop.  Perhaps others have
similar filtering.

It would be great if you decided to pick up another small item of
#leftoverbits or just a TODO in the code, because that is indeed a great
way to get involved, and that's how I started to contribute to Git.  So
all that to say, best of luck on a different project.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--rUxZDRskOaUn7M2z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ5599gAKCRB8DEliiIei
gbxZAP0VEA6U/zUZsoUVMxMTjnjZISFwjxHfmZU8t4zvlwwnigD+LhvK2YdjlvVO
IvzlteVK6rpXg469MOFnksQ4aCnWiwE=
=/tPj
-----END PGP SIGNATURE-----

--rUxZDRskOaUn7M2z--
