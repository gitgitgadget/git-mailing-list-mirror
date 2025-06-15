Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD7117548
	for <git@vger.kernel.org>; Sun, 15 Jun 2025 23:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750030990; cv=none; b=SgARq6lnRlxGgn+ops5HkEKmTh6UJPgatPqJbaG6XcoVtDeIhlL7pLQbuYLur3oujWqfAiu+2cGRKuBKnGRINjAWml8msEFWtRQeDRY1rl2zHq+Qxa2JCS5+hX/LqDa5+yMLv/WkG0CXwfRlrc8BI1n2+ZZGRjX7xvqFTyRTHr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750030990; c=relaxed/simple;
	bh=6pWoG/9Gxaj6fy8Uvc9E3EqkGv9cjN5Msh0OnkMrAQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEHPugctfNoFpPMXFJizky58O1M7FB+nBxOmGXpdffImjQhFzEeQhmsqTvPnY2DiwJ2vawyzDum3Vko/GlI/maFNfLJAkzdc2/jQWKOhZzVQDjbSKjUhg2ySsImiIiODtimiLD4XUYfH7Hyy7YOHG0+0AoUE1YNkUnhznR+7tWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=WyEoQGFI; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="WyEoQGFI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1750030980;
	bh=6pWoG/9Gxaj6fy8Uvc9E3EqkGv9cjN5Msh0OnkMrAQ8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=WyEoQGFIkZhuqQpXske9/kRvHeBqCIJ/dMSrgTKDMbuSVSxiKr3MqqiOsL0jhSrUj
	 e9GnBTwwzetlfjZCTnJ1jg2rsJ9blWnoRCdOF+Yb7B2yg7uquNEtHW2Bm8jMMffIoN
	 4NNRanhlplqo+5apzNgA0A6zl5dEGtu31S2It90tDbCCPflEmkG6/ITdgZcGJjmfPA
	 yvSyC8bLwWQ7PbFxu8E808aBdYXO6W6A7tD6zTtG0EWQxm9GfkDZ8Eg4k2dc/7MP/O
	 WwNlC9iv1BQUJeq5mVV7kQKC8NBl48D+V/VWDKI/kH20rmHHaMqg24zmcKvQGgh7wC
	 V4ewDhm/EtDK9LMNDByijC8SLpvd/AMjLmSVms5JsaZ5kwipfMbRKIkfErXMTT0idR
	 yabnKD9jFd1erVjTb7QTtKAHR5w6xk7vWTsNaOnfAFp2vvTt5AtGYVMlwjThdtGIfh
	 y6rfwtOWU/m2dP6bZKmnHhi0N3038jcqYBy8n3001Quo8q/m5Y3
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:828b:3227:a916:b7f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B8DFF2008A;
	Sun, 15 Jun 2025 23:43:00 +0000 (UTC)
Date: Sun, 15 Jun 2025 23:42:59 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Juri <juraj.sojak@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Git gui webclient info
Message-ID: <aE9ag8TY7i4Qi1Pr@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Juri <juraj.sojak@gmail.com>, git@vger.kernel.org
References: <CAKn8H7qa_b==1LqPkJ-dmH0UNNp4Z4xbewN+LgcL6-bBPM1boQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s//LC1V18L4hEcV2"
Content-Disposition: inline
In-Reply-To: <CAKn8H7qa_b==1LqPkJ-dmH0UNNp4Z4xbewN+LgcL6-bBPM1boQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--s//LC1V18L4hEcV2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-06-15 at 21:41:50, Juri wrote:
> Hello,

Hi,

> Will you have a webclient version?

I'm not sure exactly sure what you're asking.  Is it that you want a
version of Git GUI that runs in the browser and allows you to access a
repository?  If so, were you expecting that it would modify a repository
on the server where the web version is hosted, or a repository stored
only temporarily in the browser?

If it's something else, please do explain a bit more about what you're
looking for because there might in fact be a tool to do what you want.
It's just hard to make a recommendation right now without more
information.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--s//LC1V18L4hEcV2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaE9aggAKCRB8DEliiIei
gXunAPwL8yJN7nB+7vLkYtBffbXQOfBl4vFRV10Thl+DaIesowD/QHBUowG1GFCC
EWMin+zftVbVWvOZBxPoFrD8yTlFmA0=
=rBQU
-----END PGP SIGNATURE-----

--s//LC1V18L4hEcV2--
