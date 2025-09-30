Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49C4229B2A
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 23:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759273673; cv=none; b=RigZkagjKDsmtRlNqPida45TZ3Qtr3YHeVm1gVuLi37P9YeXEISbVJJLWbmOR58R41iEkMif151HPOu9qBG8RQ1io/Xc146ZIwJKXxRJ0oC/BOTqNc2R8FXF1SZpaD/2sRfB3g3Vdp1ordrpvZEggWnfB7LXtyJk84s1vEzFJYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759273673; c=relaxed/simple;
	bh=T+AoZJan2eo47iOAO9ED1kvngB/oSq9WdjOhhiga8aM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hP48a4GE3mxSqwtkaW8jKvgT9P3YPMy73Jl4ZiS483tUsYQIm7Fmu9b01yaYuDjayM0kYECL9OLX93BMrZEFnUl3dPKYJyABLQ44e5LCXqVXrM8pFID/CvtOBXfUfXMagJCvM49nbckdW+pu5nhYH3zkT3+kGAguai6Dvqw55ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=h+pyw631; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="h+pyw631"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1759273664;
	bh=T+AoZJan2eo47iOAO9ED1kvngB/oSq9WdjOhhiga8aM=;
	h=Date:From:To:Subject:Content-Type:Content-Disposition:From:
	 Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
	b=h+pyw631BH6czvI4Fk1dFYFR4B0txK541CsggLhiZ87HKet81ybPyD40XeOskLpwB
	 eYj4jYk9VubdXRrXWcKMJVYa2LhyZmA7oh93zpdyXwURopTJ/HPnUv+qyrvh8jFKU2
	 vm4Wwg4ALIPX0WqDZlrjvahX1xBxAKAkDBYMWZlHJaXBmQq/VilRkPkrni6M/zNgSe
	 L7aAQA4T6g9sD7njLHVLUuVqFduymm8SKOZqQfSP3HXyUE/eyynTgHSwgg8J5IXIdb
	 7agWEgVcFIoDkWjBZUeUnwdTtAIFrPOJG3+Mlpjx7+gb7FCvEEA26BBkDX8/GOLTWM
	 Sw/lpXtT2OSJWrWyJkR7Vd4444ifF0+/XJN8Ow95OLhRR1rUPLT3utaIht+RwEmUhO
	 63SDXOl9JMAbO2CVoytSwH/JT70+Z7vcG0MGggvHS672ZPKV7mglTtEkrYNaO8ZapJ
	 vgsdSMtLYL+Od4zhy5NClAyvWoH1Qot/plJSZMhQulj53rqab/g
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:3c0c:de88:5b0d:9364])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4E38020113
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 23:07:44 +0000 (UTC)
Date: Tue, 30 Sep 2025 23:07:42 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: git@vger.kernel.org
Subject: When should we release Git 3.0?
Message-ID: <aNxivuJEnSHbQNdr@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nplUULpJmJrTBpU4"
Content-Disposition: inline
User-Agent: Mutt/2.2.13 (2024-03-09)


--nplUULpJmJrTBpU4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There's been discussion at the Contributor Summit about when we should
release Git 3.0.  The original plan that was discussed was to release in
about a year, which is about 4 releases away.

Almost all of the functionality that we had wanted in Git 3.0 has been
implemented.  The two major things we may want to consider as blockers
for Git 3.0 are the following:

* The SHA-256 interoperability work is not done yet.  My estimate of
  this work is 200=E2=80=93400 patches, of which about 100 are done.  If the
  original schedule is maintained, this would require writing up to 75
  patches and sending in 100 patches per cycle, which is unrealistic
  without additional contributors.
* Some forges and other projects do not yet have full SHA-256 support.
  It's my understanding that all of the major forges are undertaking or
  have undertaken this work and are at various levels of completion, but
  it's not clear that other projects have appropriate support.

We may also wish to stick to a stricter timeframe for this release
regardless and make four releases from now or the next release a year
away Git 3.0 regardless of whether those items above are completed.

Discussions at the Contributor Summit did mention the advantage of
having a hard deadline would be that it would make projects and forges
spend the time to implement SHA-256 support if they're lacking it.

I personally do not want the interoperability work to be a blocker.  I
haven't really heard other commitments of contributors who want to work
on it and I don't really want to have to run full tilt trying to get it
out.  However, some other people may feel differently, in which I case I
encourage their participation in the project.

What do others think about this?
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--nplUULpJmJrTBpU4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaNxivgAKCRB8DEliiIei
gVOQAP45MMgtqUrHB1zVo8fVmKhZxGHuX+eKfiLE6r0aLbc7AwD+IXaFuSqmOmfw
mETjm9JxF3j0dVw7YwQk/HocDlDyZAE=
=dCV+
-----END PGP SIGNATURE-----

--nplUULpJmJrTBpU4--
