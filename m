Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E971F30BB
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789832902; cv=none; b=pA29fOx5l+fqa1Fbr2D+dA9SPQrCm/CGi6d4NZR3Fm5RuVHDXrb1HfcnoFZBU4LigQD1X+FQb0jePI8HgAHMcwUt1KijP96cUdcl5awhJ8HM0LqLS9M8dpjPGriFT2ionz0bWKVeeFAXJi5jXHBZoGHRDO5mKB9cPNjkRp+5zPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789832902; c=relaxed/simple;
	bh=OrzDWywaGuAmu8qetzaenjHnTiMDYbDXP+suVZvuxLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5Q7nv+ANWfNdbk8GIrPMD31GYA3tVVOInJgtmSA6/OuKOKHqhZ+Al8PfQQvHmR5mRpYr5vLeS2FPlae8UKd+i2A5VOmurOLRq3sJ6vDNWFojOiKRuV5rfcRJOXVO12Gyh1OOs/UfKq5v5hfpNoFR9WYD5cNRksw/6W46nrpHN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=HmpB8z1l; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="HmpB8z1l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1789832900;
	bh=OrzDWywaGuAmu8qetzaenjHnTiMDYbDXP+suVZvuxLo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=HmpB8z1lwdyC2rKQcAfkJkClACfFzt1CLEJBpVVNAwzlTKP/+Lo1oIsrA28RFbUox
	 fsrJHPE/Xv0y7doz/u1XnJVMakkPgkSpHWejhvQa892PsGuQMFTEIpy9KSuxBkLfgS
	 yOsshavkrWiaHQWYdVRrO93y2EomDB4czgX6o947yu4zCFv7EjG/k3fYi2C/o2x+zR
	 ZdL5Q8RuB3Xe+mRbHEiHOYsSqV29BTjrAG25jjmOHAPV8/+1Eve0XubfGmYNZL7iqj
	 bfyaGocJ4cA9x4pefSkkuyz7zmhKpziNkHQKJjAnrQrYL+x9l5RAI7Qfxhe/6F8GxD
	 SSSt0QvbkQs1YkJXmw30dJQFpcQgI94rF5lrr/KGCNjZ1d1nN2pGZI7NZZWIgurkE7
	 HwI48qxXW8ImwntUFU7WQsumu5/FUc3A9WCkCNoKEsAcfJ7Fe+9Tgnfc65VF3ddwZD
	 ajYnNRVxOv6/1QWuJwQNI6x2WGSWuzkUULUkAJkAV3ujFDBA/Ix
Received: from fruit.crustytoothpaste.net (unknown [205.220.129.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4F5DE2011E;
	Sat, 19 Sep 2026 15:48:16 +0000 (UTC)
Date: Sat, 19 Sep 2026 15:48:06 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Francisco Boni <boboniboni@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: pager: consider revisiting automatic LESS=FRX with custom
 core.pager
Message-ID: <aq6utXAQA-rRoKSm@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Francisco Boni <boboniboni@gmail.com>, git@vger.kernel.org
References: <CAKNeS+mFS_VCs_tQeFb8jBx70FwQLW0LtuqhSk4xSdbWdqDR=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YC8Mq1CcUDmMGeRU"
Content-Disposition: inline
In-Reply-To: <CAKNeS+mFS_VCs_tQeFb8jBx70FwQLW0LtuqhSk4xSdbWdqDR=g@mail.gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--YC8Mq1CcUDmMGeRU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-09-19 at 12:19:40, Francisco Boni wrote:
> Hi,

Ney,

> There is also an unintuitive distinction between:
>=20
> ```
> unset LESS
> ```
>=20
> and:
>=20
> ```
> LESS=3D""
> ```
>=20
> The former causes Git to inject `FRX`, while the latter causes Git to
> leave the pager environment alone.

Yes, that's because Git sets the environment iff it is unset.  In the
latter case, it is not unset: it is set to a zero-length value.

> I realize simply removing the default could have substantial
> compatibility consequences given how longstanding this behavior is.
> But perhaps it would be worth considering whether the automatic `LESS`
> default should:
>=20
> * apply only to Git's own default pager path
> * be suppressible explicitly through configuration; or
> * otherwise avoid affecting arbitrary custom `core.pager` commands.

We can't know in the general case whether the pager is less or not.  On
FreeBSD, `more` is less, for instance, and the pager command allows
arbitrary shell commands, so determining statically which branch is
taken is not always possible.  Notably, Debian has `sensible-pager`,
which is the default on that OS, and may (or may not) be less.

Users would be displeased if Git's pager functionality worked
differently with less depending on how less was invoked or named, or if
it weren't enabled in a case like the following:

    core.pager=3D'f() { if [ "$(uname -s)" =3D FreeBSD ]; then more "$@"; e=
lse less "$@"; fi; };f'

A user might in fact do exactly that to make things work correctly on
multiple platforms with a single gitconfig file.  (This is why passing
certain environment variables or options to the shell is obligatory and
you cannot simply do shell parsing of the command.)

I agree that this can cause unusual behaviour in the case you've
described, but that's more of the case because it's actually unusual to
have commands that take arguments through the environment in this way.
That's no longer really considered a good design; normally we use a
config file instead these days.

I'll note that it is configurable both through the environment and
through configuration, using one of the following:

    GIT_PAGER=3D'LESS=3D"" delta'

or:

    git config core.pager 'LESS=3D"" delta'

or, if you prefer to be still more conservative:

    GIT_PAGER=3D'env -i PATH=3D"$PATH" delta'

which unsets all environment variables but the path for your pager.

> So this is not primarily a request for a workaround; rather, I wanted
> to raise the broader behavior because the interaction with pager
> wrappers is quite surprising and difficult to diagnose.

I think at this point, we're unlikely to change the behaviour and it
would be a notable and unwelcome change to do so.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--YC8Mq1CcUDmMGeRU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmqurrYJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ9+qug1SBXxObHchpvRbveQTBq0BsaKj8KugA6ZOn40b
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAKOFAP4rxMZ1wjWo0jlkCww2OIfWOZzV
zqWxbXrJCUAehi4SPwEA/yo4o5wNcuUoJ5PEnJBNG+C5AiG+FFbHZQlsXeZWjgQ=
=zux4
-----END PGP SIGNATURE-----

--YC8Mq1CcUDmMGeRU--
