Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8C81D63C7
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 22:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032513; cv=none; b=QHvLVRyjtq5sNSxsuShqxFAhZx3LZBEL5JDh9Cp2Ahe0HZGaTgk5LJZsVkN5y4hcstWMLkykHHnfO9Ev9xU0TVqdI76LvvE9UuHjPafLJRuQOp2oDjeC+XK2hD1br7a21fNgYLc/8U4is/BuJrzDuvOl5soOHs8dCRH71YRcWtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032513; c=relaxed/simple;
	bh=yjgMzRJ0+4gM2PLiXjlzHL7uS/XhHACLCRSSWwmWyoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvsnB/T6ECzfpmyYcpzZj/vv5wu1Ur8ALj5RsZ70LXMjojuT/hQrOXueYAhsM+z6Nr8RPxidn/UxFZs0QqQpFR6PsA1A3Kk3QOAV17cZXwdbYxHxvLbIESSg8eGuBKJ2rPbdbZ7cqJ6Bgv3lGTxlawERgCnKEWsDgQEWVDN7n2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=0w4s9LO/; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="0w4s9LO/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1729032502;
	bh=yjgMzRJ0+4gM2PLiXjlzHL7uS/XhHACLCRSSWwmWyoE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=0w4s9LO/iOy7I3N2X+NBXyPAWyreZYXzrtj5xAEOjv4fuzUjIVPpC9kF0gaLYjXM3
	 tndebeHWoaaVW5Vzfpw4dBLwM0ZIHSETSNiZ9RKLMZzDJdmdHIlmKocj79suQNidAK
	 DrySsm4uEtHiSeTGAcpTZaoYepByJnaXqqyBh4Ju/eDXT3iiMDeqNXCntUj6brjg8P
	 dNkzHiRIB/PCPLzsINA1AX4lBKblVKRpYruftzTNL3guFtqYgvyBROv/yyYGlZLOJ6
	 +VEFAj2vcoU5cvFG09VhMJ6D6CBLYIA9TSxPOWBJbWwBoQa2NOsoheIrUGpGHBrQD0
	 +wMds06N+fB2Yv+PMowLA3TVJN+JQhRELtow2KDddAODX1OLb4UBQ0tHGVCRXVQqZB
	 tAZk1TCQwwPb9vvKl5XJVcdTjnFu+lkRwDB2aQISBM1xONROnCYjKzZlWfJz8yk4K7
	 Tv7e7gavRZUOx/DS95O6Fzx2R4Cp7lwEJ1Kgrt60iTVz6hWG8+h
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id DB8A32008B;
	Tue, 15 Oct 2024 22:48:22 +0000 (UTC)
Date: Tue, 15 Oct 2024 22:48:21 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH 12/13] INSTALL: require Perl 5.26.0
Message-ID: <Zw7xNX1Tk8BbT9k_@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
 <20241010235621.738239-13-sandals@crustytoothpaste.net>
 <ZwjyHl98xRs9TDQZ@ugly>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l/OOMuVikbwfouQi"
Content-Disposition: inline
In-Reply-To: <ZwjyHl98xRs9TDQZ@ugly>
User-Agent: Mutt/2.2.13 (2024-03-09)


--l/OOMuVikbwfouQi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-11 at 09:38:38, Oswald Buddenhagen wrote:
> On Thu, Oct 10, 2024 at 11:56:20PM +0000, brian m. carlson wrote:
> > Update the INSTALL file to reflect our new dependency requirement.
> >=20
> any particular reason not to squash this into the parent commit?
> i see how the separation makes sense for the libcurl sub-series, but
> that doesn't seem applicable here.

Sure, I can do that.

> regarding the actual `use` statements, you could make them somewhat more
> legible by using 'v5.26' as the version number.
>=20
> another aspect to consider is that the statement doesn't just specify
> the minimal version, but also subtly changes behavior. for example, the
> `use strict;` statements become redundant.
>=20
> cf. https://perldoc.perl.org/functions/use#use-VERSION

Yes, I'll change that to a require v5.26 instead, since my goal isn't to
change the behaviour.

> lastly, it would be nice to update the build systems to reflect the
> version requirements. though the only pre-existing version check i found
> is the libcurl one in contrib/buildsystems/CMakeLists.txt.

I don't build with cmake, so I can't speak to the requirements for it.
It doesn't actually work on Unix as far as I know, and I don't run
Windows at all.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--l/OOMuVikbwfouQi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZw7xNAAKCRB8DEliiIei
gX/qAQC+zv+cIT7Rumbo9GMYWmWkSCbRNy/kO27YZXOxYbLMEAEA+p1mLyLnPgGx
LW4Ltp6lnfEsqgzgVg5m9qGfxm+BmA8=
=axc4
-----END PGP SIGNATURE-----

--l/OOMuVikbwfouQi--
