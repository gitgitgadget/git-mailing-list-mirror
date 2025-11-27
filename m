Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED171CD15
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 23:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764285103; cv=none; b=IYKnsW6fZhFkreXZ9HVRg/Hh6xHhqQJ7dcdtC/8NL8i/ZgsrjZ7vCZnDTulu9ecUjh0LsjdgtAF/qUBOv7Rxf8erKDB8qPI8fmFBsKg0WOVfMhCL3fcoR7VrPQiH23rgC6cPoN4lv+KGn6iP2aXbpZDG8I+dVgPYgQkE+utZUn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764285103; c=relaxed/simple;
	bh=RiD+bLH0JtJ7DutB8FN/pzi14Uh544C3UTcCxxFwmkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkHhE36Uhlrk+I6NL+H53K60Fr6tWnaXu6t/Wv+zcwNa9a7DLIEE/K6w6QcxSKPE/Mzk8Ai/+ZBcAs/mGk5gvGquD61hAeMPa9MEVYCMiDEzQRS/R0bGlFXzoN7g6RpRUr4cfdGCLNugYEhj/lm61fOogYe51wbD6533Vd7bE9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=lkmRmagx; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="lkmRmagx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1764284715;
	bh=RiD+bLH0JtJ7DutB8FN/pzi14Uh544C3UTcCxxFwmkQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=lkmRmagxumRhauWLSh/ByZMnlEcvOkCIcunfmAzFHk2f32tap46oP8Vw30cGUNcjE
	 ov1/J5FJQ8YnX+vKbLDOaI4Q1mrqg6asIA/m+NCAObb0PeIXZ8Q7YsVqHsTO/q0xt8
	 mJPgxUHrKZIdxboQAIp3UFYlf0W+LdVBYzHmY50R+R/2oEeijfyz8/wV5Pjy5wUz8U
	 9xDnquOkCtU3jrppWcfzIIrTxQqhuJE66aP3qwSgVulpOdbPTjpkuusy2ZRPCNNL3H
	 4T3fRTnDugpxsgXrgIeYEPEqACkFR2r0y+LpeZzfbVEZFTU1BTKcsL37nppl7g8mEc
	 nSvsU6MdMFYs2F56Sm5i9R+2MDP5LauSyifzMeNksgqHhxxeM9N0L/QqA8uargPTii
	 hGf74Vt9pzumvIo+pW+8ssjUS5pR6rEXYd4LAaJwkzMoYa4nbfbfBUK/5b20oM8i+a
	 9QixqSY7cqwhfCCJMGIA5kslVvimtumBFG5Lq6oLJt+xM9wmbme
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d48d:a8fd:1e1f:2dee])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id EA3242003B;
	Thu, 27 Nov 2025 23:05:15 +0000 (UTC)
Date: Thu, 27 Nov 2025 23:05:14 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Peter Krefting <peter@softwolves.pp.se>
Cc: git@vger.kernel.org
Subject: Re: How to localize "git push"?
Message-ID: <aSjZKl17Vz4fMXxu@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Peter Krefting <peter@softwolves.pp.se>, git@vger.kernel.org
References: <f2cb6da7c17e8de829c3e4cb066684e2@softwolves.pp.se>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oLSJcVYqKFTkXh1H"
Content-Disposition: inline
In-Reply-To: <f2cb6da7c17e8de829c3e4cb066684e2@softwolves.pp.se>
User-Agent: Mutt/2.2.13 (2024-03-09)


--oLSJcVYqKFTkXh1H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-11-26 at 07:50:15, Peter Krefting wrote:
> Hi!

Hi,

> Re: https://fosstodon.org/@McPringle/115611195011002487
>=20
> The message shown when running "git push" without any changes queued is
> always shown in English, whereas the corresponding message in "git pull" =
is
> properly localized.
>=20
> I looked at the sources, and the string "Everything up-to-date\n" is
> included in both builtin/send-pack.c and transport.c, with both instances
> annotated with a comment "stable plumbing output; do not modify or
> localize".
>=20
> How do we fix that? Having the message show in English from "git push" is
> confusing. What is the corresponding plumbing command that needs to have =
it
> machine-readable, so that we can fork that to fix "git push"?

There isn't any tooling in Git that requires that particular message but
it's rather that other software outside of Git may depend on that
output.

It should be noted that "Everything up-to-date" should actually be
"Everything up to date", since it's an abbreviated form of "everything
is up to date" and for most compound adjectives, we only hyphenate them
in English before the noun they modify.  However, because there was
supposedly existing software that expected that output, we chose not to
modify those messages at the time that cleanup went in.  I am, however,
unable to find any such software that expects that string on GitHub with
a quick search.

Personally, I'm fine with modifying that message unless something like a
`--plumbing` argument is given (or just letting people set
`LC_ALL=3DC.UTF-8` if they want fixed output), but other people may not
be.

I will say that we changed the following message sometime back for
localization (to uppercase the N in "Needed") and it broke things at my
last company, but we also easily fixed it and I'm pleased that it's now
localized:

----
% git rev-parse --verify nonexistent
fatal: Needed a single revision
% LC_ALL=3Des_MX.UTF-8 git rev-parse --verify nonexistent
fatal: Se necesit=C3=B3 una revisi=C3=B3n singular
% LC_ALL=3Dfr_CA.UTF-8 git rev-parse --verify nonexistent
fatal=C2=A0: Une seule r=C3=A9vision attendue
----
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--oLSJcVYqKFTkXh1H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaSjZKQAKCRB8DEliiIei
gcVqAQCepNzdtBGvCnlZtN6NCwxBInSZCX1tisgMibNUjT1lVQEAseFyRH4k0WYc
AUYKtVwIXLPKvh1I+gj5JifKQ4blzAY=
=xOMW
-----END PGP SIGNATURE-----

--oLSJcVYqKFTkXh1H--
