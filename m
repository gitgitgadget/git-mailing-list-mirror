Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F6442065
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 21:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755638306; cv=none; b=pcQmJbQ5tevxj6DPEPKxaxae7R3G03FP785cmgnD/R7zs67D2FuRRXNYFuDKLE29lXaWIijP7QRwCXIqsYc4KUkNQlWGOBtTIAhyQcHxDJ+ODhoLn6oF1mTQguB5PkGzyuRc9nzTGB+UWQGTAfBScFoSFvZ/zXVrt92A+soTc0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755638306; c=relaxed/simple;
	bh=oMrzAPLlzCTBEg0D/CIF8m5apTchcKE49oKMANeZGnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rrviya6miYZsrhTfsEKyni1FgtwRoHP2F83b0ZdajVybtOyn+Iiy0so4qH5ZzP3yhUEHEgBSeseDWsEy43WW38HwQX8eJiciUTCfVb3HkFShTQjunVGfrtMBCN1NNeMzItZc4CzqYyesXRWKD2eoAuWefZZbls/rGVzcP5YEkS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=A177ICwb; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="A177ICwb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1755638302;
	bh=oMrzAPLlzCTBEg0D/CIF8m5apTchcKE49oKMANeZGnU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=A177ICwbK5VNR0dVjjkj0jc0jZayHAJ6X4a9YGhFudVko/sS1jm/c8rUX7rLUSdnv
	 AShce5yw2PS2m0MkFFaHjUdeqGVeuvP3xrdnv9wXHXaFLyATHen34HmZ80Zo5Zi6k8
	 7s9ueDYQfWJoB6j1fZnO/XIMy87MCfIvhWCAEHtZgBW5x0iVGFk8uYlgI5b+10bW57
	 DABiwiT+fxZxVECrJH88eVbK7pGG9VF05TFt/HL4ZUVcGrVqgE82o5s22MslhaF6nC
	 N/4XoLS3gwaa4mFWA2B7vxZcMUOrvBpUXLJeHGD3lBWanyz2NF1uQMeWL62PmSCmzx
	 AKBxDNZXEZQs1Wi06/iCB4GQHUHKfIYNW9j9Ds/ONCKqBzteNEwEQ+cxwNsF0yOifU
	 NgPdtHZ10SfNIcm0g06kE7063opPnVcz9E/ckoZ9VSbDY0Y5KmZKl9/8rqXoG615dD
	 mANTNZCxrp+lktwcoWMXQV/aQ/d+GMijs0sQQ6WxbpYvy3zr4aF
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ea9b:126d:b7c6:bc48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id CC617200B4;
	Tue, 19 Aug 2025 21:18:22 +0000 (UTC)
Date: Tue, 19 Aug 2025 21:18:21 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Askar Safin <safinaskar@zohomail.com>
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: git: prepare to regularly change hashsums
Message-ID: <aKTqHTnOMp1LFNLD@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Askar Safin <safinaskar@zohomail.com>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
References: <198c2b87f70.ff0fbb4065293.4919681043907358329@zohomail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jTfUO5jzoD5au4Mf"
Content-Disposition: inline
In-Reply-To: <198c2b87f70.ff0fbb4065293.4919681043907358329@zohomail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--jTfUO5jzoD5au4Mf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-08-19 at 14:25:27, Askar Safin wrote:
> Hi, git people. I just noticed that you plan to change default hashsum in=
 git 3.0.
> Cool!

Thanks, I'm glad you're excited about it.  I am, too.

> Please, prepare for regular change of hashsum.
> No hash is forever. Be prepared to change hashsum algorithm once in 10 ye=
ars.
> See here for details, i. e. why no hash is forever: https://valerieaurora=
=2Eorg/hash.html

Yes, this was a goal of the project when I did that work.

There are many fewer places where we have hard-coded hash values in the
tests and a lot more places where we compute values (for instance, if
what the test wants to know is that we're three commits before HEAD,
then we write `HEAD~3` instead of a specific object ID).  Instead of
lots of hard-coded 20- and 40-based constants throughout the code, we
have a few #define constants and a hash algorithm abstraction.

If we need to change the hash algorithm again, it will require
substantially less work, and we'll have only 40 test files to change
this time (which is a major improvement over last time).

I hope people also feel that the refactoring we did has made our
codebase easier to understand and more maintainable.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--jTfUO5jzoD5au4Mf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaKTqHAAKCRB8DEliiIei
gX1eAQD8fvyKAfcdIYx6/vipser+uSLRxzV46CHLSGPFWrNHWgD/V7Estk9Lzj3N
8ir0sigt/SmNoveyY7YXVrwYkZsPsA8=
=avjI
-----END PGP SIGNATURE-----

--jTfUO5jzoD5au4Mf--
