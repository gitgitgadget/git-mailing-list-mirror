Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A131E552
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755963848; cv=none; b=RpnbezZNYbFBoeWYemjcaxHzLcRfWNfE3Lurr8rd+vDyslHDcBGiuG/4FncCN8RVX3PkNYDX3TpbUn3X4Ev2BaOir+jAfc2dYjdfvbSsmjCOoucQdIbRMT1ZePb7ZRgWerqKhEocCQRW3iTVL9TlcuTl/+5BwaBYkF0whp12/rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755963848; c=relaxed/simple;
	bh=URmbXOZ8tTeasQHacKfvO+qnw3Lu5qWGiU43haFmwWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCcb1LTYyNMV8+vwWLTtJ5AKRRMdIHaXSz2UTVpY/bDy4lueevPJv2ewyaPBSlyT5v+RRLRsXvlG7Gpd5vLNXBGjocBdevrCbGlDhPmvCpHGlzvIDSpjpcWyiXpdpTpX52ge4268Ii9Vr+tUpQmZjNs9CXKfWg9lpBD1F4IAGAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=PS117R7Y; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="PS117R7Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1755963838;
	bh=URmbXOZ8tTeasQHacKfvO+qnw3Lu5qWGiU43haFmwWY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=PS117R7Yzt/vBuDpO+Mz4W6sxpwzMTdn7evJZxa5Yd8wAMzvbjypCckfm3o8vu7Zw
	 K5YBHabn3ClUwM/K+eCadEnFeO7coXltGSRI9VDIZlYOcFZAUvy2ySTSJ4B9q1XNfO
	 qOHIP1bLYLFj+KxJzes2Ba19XvmnmnQuWV3fmbaiB3xpl4vbJ1rKnmwFxojmsgAXNE
	 z7iYICCrcxOh4XNuQ+dWQiPzkiEJvl7VHL4yS11ppQthgOcCQbda3jWmr5Ag+uITlP
	 g0I1KmHhZgtDCRjOqRYaHIsDLdTuMGSb66AHeUru4oXdyh/VDMjlNv1cJrTBLsCtKZ
	 avsGDn5CVy7tB0elgfNIjAMOohX9yvmMqJebbVs0EnN1PQScqXm1R7cXxl7mdqC1gw
	 rJXN3G1LrfQNX15pX+IRBQ7QHq9UtQj9z9VOncJ3B65gjSOfTQAW9e9w5s6crztU+u
	 EvDDEctnVvs6M9Usb7WGh9hM1/wHLExUbKxQFEDRSfegPhoncmO
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:e876:ad4b:1ea1:a47d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 095C620081;
	Sat, 23 Aug 2025 15:43:58 +0000 (UTC)
Date: Sat, 23 Aug 2025 15:43:56 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Isaac Oscar Gariano <isaacoscar@live.com.au>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [feature request] allow directly committing untracked files
Message-ID: <aKnhvH1KHrAkfYwH@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Isaac Oscar Gariano <isaacoscar@live.com.au>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <SYBP282MB2963ABA12BD14594F62E47B08C3CA@SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q3Sok6jOlcxw98Vj"
Content-Disposition: inline
In-Reply-To: <SYBP282MB2963ABA12BD14594F62E47B08C3CA@SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM>
User-Agent: Mutt/2.2.13 (2024-03-09)


--q3Sok6jOlcxw98Vj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-08-23 at 06:45:30, Isaac Oscar Gariano wrote:
> I often use 'git commit some-file -m 'some message'" to quickly make a co=
mmit, but this is annoying as it doesn't work if some-file is untracked, yo=
u first have to do 'git add some-file'.
> It would also be nice to do this with the `-a` option as well.
> Is there any reason why git does not let you do this?

I think we've seen a request for this before.

I will say that I always stage changes ahead of time because I'll often
work on a few different things before committing[0] and I always want to
be very sure what I'm including, but I know not everyone does that.
It's also the case that sometimes files end up not being properly
ignored[1], so it's very easy to accidentally include files that you
wouldn't ever want to commit.

> Would people be open to me making a patch that ads this? Would it need to=
 be behind an option for backwards-compatibility?

I can see that it would be useful.  For instance, it could be convenient
when writing tests of Git's behaviour where you really want to just
include everything in the directory.

It would definitely need to be behind an option.  I might suggest
something like this:

    git commit --include-untracked -m "message" some-file

Of course, we typically reserve a final opinion on a change until we see
a patch, since we're interested in both the idea behind the feature and
the implementation.

[0] For instance, at work, I was fixing some software tests to run
properly with reftable and I fixed several different files before
committing, each of which would have needed to be its own commit.
[1] I've seen this in codebases in which tests are only infrequently run
by hand and where the CI doesn't care about untracked files.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--q3Sok6jOlcxw98Vj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaKnhuwAKCRB8DEliiIei
gSWLAQCXuWHVeH50rj3MXMsJscXbuWEnKleb9ilSVEB8RMxKuAEAkOMkR6o2TbDD
G173Twj0Ak58xVM3DmDjIlDMDKpnUQ8=
=tblE
-----END PGP SIGNATURE-----

--q3Sok6jOlcxw98Vj--
