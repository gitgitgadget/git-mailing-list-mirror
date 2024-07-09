Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D9E13DB92
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 23:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720566985; cv=none; b=Q5OS0QbBcnZccug8g0W5dc5X77p970dyL5F7zBUnHW51TpLFb2XcugdFDkNVn/A+VcQGajGOV0+Bf89Yi7GKv+RIS9uXx9/ebvhAew88YzBPRf5gqY78LRnzdb7Pi4Ut4NBXtOZsZtr2N3pSrumO4/+6WKtL7Thz68DDYTgcQzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720566985; c=relaxed/simple;
	bh=TibTpXTJ99imUxl/6wT7N8FDsZqiQqUL1nSvo2T1V30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kdjac+shUKvwbmvOc0QvbV4xAhHP3sh6fsO6meRA9EjRVXXQajM0elimDNp8t8srZHT6IxvOab5mCG20QH9EpHVtEaIUQP+74L5tXZvU5Tk/UBoWRt4wUd5WX5iHVeiUQWG9BzcEU8xcDq8/9ui0JjscGfbklyG4t0cCnVRouik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=MFCDM4hc; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="MFCDM4hc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720566976;
	bh=TibTpXTJ99imUxl/6wT7N8FDsZqiQqUL1nSvo2T1V30=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=MFCDM4hcmv3NRNjYw6JGF2ZiLHj/pmW48aexa8Wxf7ejT9yQR9cw2efWhkZydqUYT
	 RpM7O6EzFNMQHSg7TuGxHjpgiION1aoEGo0SsMar/qBH9Wqt9A5b/XO5sZ7irtcUne
	 /CB+qkYHSVi/O4ml/jcaS0giiPRVJYWP9gjkhE7c7f8F1OZdx1CIx4rxYaco96+UXK
	 O2/5dtQOdvHodCAB3wQajbN+gSwNh8SdhRZtjdrwpgA+sYP+/EqqORvMSxZpDFf8YB
	 UGDXUR4TEGPFJUD3s/6hVyXLSV5zkB+4QXjefx8rUM/G1kmkK11awWkDNA6cYSeaU1
	 BxLYI5yuptXceRBuqtvNKToim89SuStgf6/tuK1ppLT4Eqczj7U49l9j5pp2GoIrxz
	 TyM8H11d0DNP29tixbrSao4MRVRqeaeboRDUfbY3w3uX43U8PPY4CuQZEO3sM1GMef
	 gSVYQrnukYWjquXIhL+mlkNsp3BRZ4GkF/q4Srz3bDbu2VMJRCl
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 628DC20991;
	Tue,  9 Jul 2024 23:16:16 +0000 (UTC)
Date: Tue, 9 Jul 2024 23:16:14 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Emily Shaffer <emilyshaffer@google.com>
Cc: git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Emily Shaffer <nasamuffin@google.com>
Subject: Re: [PATCH] Documentation: add platform support policy
Message-ID: <Zo3EvvSI999ngrLn@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Emily Shaffer <nasamuffin@google.com>
References: <20240709225042.2005233-1-emilyshaffer@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Xir7JRLiByc+N5+n"
Content-Disposition: inline
In-Reply-To: <20240709225042.2005233-1-emilyshaffer@google.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--Xir7JRLiByc+N5+n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-09 at 22:50:42, Emily Shaffer wrote:
> Right now, this doc talks about "guarantees." I used that phrasing based =
on
> what I've observed to be an implicit expectation that we guarantee suppor=
t; it
> could be this isn't actually a guarantee that the community is willing to=
 make,
> so I am hoping we can discuss it and come up with the right term.

I think it might be helpful to look at what some other projects do. Rust
has a concept of tiered support, and it requires platforms to have
maintainers who will commit to support an OS.  I don't think we
necessarily need to be so formal, but if nobody's stepping up to monitor
an OS or architecture, it may break at any time and we won't be able to
consider it when deciding on features we require from the platform (such
as Rust, C versions, or POSIX versions).

I think it's also worth discussing what we require from a platform we're
willing to support.  For example, we might require that the platform
pass the entire testsuite (ignoring irrelevant tests or tests for things
that platform doesn't use, such as Perl) or be actively pursuing an
attempt to do so.  We may also want to require that an OS be actively
receiving security support so that we don't have people asking us to
carry patches for actively obsolete OSes, such as CentOS 6.  Finally,
some sort of time limit may be helpful, since some Linux vendors are now
offering 15 years of support, and we really may not want to target
really ancient versions of things like libcurl.

At the same time, we do have people actively building Git on a variety
of platforms and a huge number of architectures, including most Linux
distros and the BSDs, and we will want to be cognizant that we should
avoid breaking those environments when possible, even though, say, the
porters for some of those OSes or architectures may not actively follow
the list (due to limited porters and lots of porting work).  I imagine
we might say that released architectures on certain distros (Debian
comes to mind as a very portable option) might be implicitly supported.

> +Compatible on `next`
> +--------------------
> +
> +To guarantee that `next` will work for your platform, avoiding reactive
> +debugging and fixing:
> +
> +* You should add a runner for your platform to the GitHub Actions CI sui=
te.
> +This suite is run when any Git developer proposes a new patch, and havin=
g a
> +runner for your platform/configuration means every developer will know i=
f they
> +break you, immediately.

I think this is a particularly helpful approach.  I understand the Linux
runners support nested virtualization, so it's possible to run tests in
a VM on a Linux runner on OSes that Actions doesn't natively support.  I
do this for several of my Rust projects[0] on FreeBSD and NetBSD, for
example, and it should work on platforms that support Vagrant and run on
x86-64.

That won't catch things like alignment problems which don't affect
x86-64, but it does catch a lot of general portability problems that are
OS-related.

I'm in agreement with all of your suggestions, by the way, and I
appreciate you opening this discussion.

[0] An example for the curious is muter: https://github.com/bk2204/muter.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--Xir7JRLiByc+N5+n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZo3EvgAKCRB8DEliiIei
gQhzAQDqsYutoCUUBaTqYYn1Khqbipy19RWkTo2kxNlY9HUtzgD9E/X5l3zivl9I
dnSNwRfpZ99pmLhEd3gn2PNKhZpO9AI=
=8WXS
-----END PGP SIGNATURE-----

--Xir7JRLiByc+N5+n--
