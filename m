Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1B2126BE1
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 08:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727943340; cv=none; b=QyjD1gmtYrloWxshz+jMJhuInSJVf/bB39gp4wg8u+iaOYrbOY1uMnGNgUI9XFAnQJmadihbVLLikzNKS9WbZWvJP/LLLGKU5UIxV9FQxJFq5UcFrZiodohBoI7gF5OBQNNa/7RCBAMaNWZ0vIzURsIzMfkrpryieApqy693naM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727943340; c=relaxed/simple;
	bh=ILaGLW6mtieHpMT3ybPLg9qIs0PvsEr5ets9UYFktgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkGDtZGZiD45IPuVCqY7V5FfaggS6mh7X06f2sqx8Mep9SoP71QhHGq6A+fN4xzP/OI5QYe13HVVxVFYGdtjXWs5fMaKOAqLY1Zc2OTzRHXkhEkGgyfZ6iHXD/nLpymkWD2BynZ9xdPPyaXwtN3DlfHPbE5bkrEyu08Hgw7AvXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=iw4jZ/Bf; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="iw4jZ/Bf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1727943334;
	bh=ILaGLW6mtieHpMT3ybPLg9qIs0PvsEr5ets9UYFktgw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=iw4jZ/BfD1k0Ip30T0LWa97cQEHSICProUmcyADuFQSVUYn3wI3G4fp42xLVkvOU5
	 YEgdJLq0LipiQXPLuSS3Z9Mq8XJ63qTpUDHoTv7gQLaJhA4e7DpV4jDN5yP16OARGL
	 PToop4Lc7IlQbxbfBOHa1xVPqB7YUANFye9lK+hzz0nC7xIgcLBfp8j2s45GvPQ04P
	 POIzWwjRWen9BLFD3NYbhi52+w7uDtc25H5fbHXOsH6HiWZxrWPO9NblWXcqcixxTh
	 fsGwffKjJEdiaHM5BE7AzmjaPBY+eP00pPne3fOgmOEFgJhuwNHAa9RqsRhOBNuyPk
	 EnyP9I1RxyVfL/SOcGEFl5Kel882N6NJOI/OzU2MstKdp7SbHr0nzhgipmiWeODwIC
	 2p9QYuLZU+62Dgl+zK2gAEJR04G5h0Wb99LA+s3xrEfh+WEk7j0uI4oqAMc9vhxo+E
	 E4wVB4v4UKeBag/lCm9CfKywMTRl1VEmn6vHSAjcrR4z3IHH58J
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id EC1BC2007A;
	Thu,  3 Oct 2024 08:15:34 +0000 (UTC)
Date: Thu, 3 Oct 2024 08:15:33 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Sparr <sparr0@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Lack of system-level excludesFile
Message-ID: <Zv5SpewqUmlvhOl-@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Sparr <sparr0@gmail.com>, git@vger.kernel.org
References: <CANp3UNBGd=jiSZyFSAdPjayvgHbP5SF4Dm-uCNwna_H16bRgRA@mail.gmail.com>
 <CANp3UNCXqLJmAj2Vc7jB+i9qRjfKzrri_Mr9VvG4J5tUR-1HeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2FWp2v4PuPgX6g0L"
Content-Disposition: inline
In-Reply-To: <CANp3UNCXqLJmAj2Vc7jB+i9qRjfKzrri_Mr9VvG4J5tUR-1HeQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--2FWp2v4PuPgX6g0L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-03 at 00:23:17, Sparr wrote:
> Was the decision to not allow or implement such a file intentional, or
> is it just an emergent property of the way the config system works and
> how core.excludesFile was implemented? Would an implementation of a
> new feature supporting this sort of thing be worth discussing?

I wasn't part of the project when the exclude functionality was
implemented, so I can't say what the intent was, but I will note that
even CVS had ignore files.  My guess is that it wasn't seen as something
useful to implement, so nobody implemented it, but I think your argument
for doing so isn't bad.

I'll just note that typically I ignore things in the global include
which are likely to affect the environment I use, including my editor
and operating system.  So when I was tutoring an Emacs user, we
configured his machine to ignore `*~`, since his editor creates backup
files, and likewise, if I were still using macOS, I'd ignore
`.DS_Store`.

So basically, I think such a feature could be useful, but I also don't
see it as immediately necessary because the global (per-user) file is
also generally useful for this if the user is aware enough to know it
exists (which I admit they might not be).  One thing I would request is
that if you add this, you add an appropriate var to `git var` so that
people can find the location, which is important because different
versions of Git (say, Apple's vs. Homebrew's) may install the system
configuration in different locations.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--2FWp2v4PuPgX6g0L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZv5SpAAKCRB8DEliiIei
gTZ7AQDfixp+weEhwpwDQRz/N2b15232RNlmXorMaylDtbFF5AD/dXy28GxYd2pV
Vy/92jvsp3fSqFXzy1JkcOw8q43tEQE=
=GxRf
-----END PGP SIGNATURE-----

--2FWp2v4PuPgX6g0L--
