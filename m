Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361A4233159
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 02:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733797408; cv=none; b=KYT4yPrBXOGk7QBvst0L5jScKQllhQyQQG/l4mItyH0x0A9v8294n/eiPmpv5S2l8MSuYGwCJ54xWALpXisfR6U+MDUXfrn7eJh5Is6FGQYdKNXHVhV5eMK6HKk49Yl4vWbL0K+RKvaCf8he8YAyKhc9Ohq/gd1ZODOVzRi1QJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733797408; c=relaxed/simple;
	bh=7j1PEBOuBfcDzZJ3QrEzuPV3ql8iDCi3FUM2jGS+eyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vh+Oq8l02P9zE/SWtIZz1eHvN4UTF8Mrl1hXA6QHfESA+UMq03PXk+zvKd6gPlWAvzTt4G7PnR5urJIilxUaRa4Px+cuaL34rIpKSypGwMAH+72wuN6kXoPbwVBHmptSU4FWAS2E89jyNMBO/ApXGyTUfhp225UZYopZ0AFt3c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=jjYaSZ8u; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="jjYaSZ8u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1733797398;
	bh=7j1PEBOuBfcDzZJ3QrEzuPV3ql8iDCi3FUM2jGS+eyQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=jjYaSZ8ujQ47CdOdLB39O2ycGzxIiay3Zsx/sCuzwKWNTE2JdLIHh5YbgSERihoUd
	 WKNVf2V9S89K6A1q+84UQ5HzW2rjC+uRShS4DYU7Jue+4viCaA1XkY5EglUb/BB5u5
	 ImPrjP4BJr/BQQOohp1Rohe3HueN402xkcIneABFJ1x5yYNoHNJalDDzOG05i02yq1
	 YKXrQYyFSF5mAc/8DTuvNW4ogShE1bySM8MlBmYU92MMo1CJBhvS+8k2ldUzeWzifR
	 1uFsk6x0PGd74YQlui3bn9ci+OnxcLgOIMDsBhVxZ13uawpoIam55XCfJh4nT15QbB
	 o1lAqcc/ZuYs6yVW7P7GGjbqpsxjItu+GJix7CysWfhTGdJwPgSnvfZxhUVjXXtJba
	 S8xTlydQcurv2xB4LRVNLfanuYBUS0kP0qpWZucs4BpXTOC88vSpX4j3Kbxs/i20HC
	 GUTm7Jh2pf+vghIgrG+l7j+V20nwmk6NR9Sih5N7cAfZSvPAbk/
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 51B9720994;
	Tue, 10 Dec 2024 02:23:18 +0000 (UTC)
Date: Tue, 10 Dec 2024 02:23:17 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Homyee King <homyeeking@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git clean --exclude broken?
Message-ID: <Z1emFS-L-f4caBJ1@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Homyee King <homyeeking@gmail.com>, git@vger.kernel.org
References: <1A13EB2A-6075-4CA9-855E-B72ACDA67C0C@gmail.com>
 <Z0Nsq3lQZKJZxd-y@tapette.crustytoothpaste.net>
 <CABAKogYaajvedff2ihsC5g+156L-Oe2N_XR3c+uyyfoovVQ5gg@mail.gmail.com>
 <Z0jZfltm0O3y9QoW@tapette.crustytoothpaste.net>
 <CABAKogZQ4bAh-KPE79q0W7iBBoRmxW26RK_6VSg=6Y-Sg68tig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bElD+DSzWMvyZBoo"
Content-Disposition: inline
In-Reply-To: <CABAKogZQ4bAh-KPE79q0W7iBBoRmxW26RK_6VSg=6Y-Sg68tig@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--bElD+DSzWMvyZBoo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-12-09 at 04:53:24, Homyee King wrote:
> But if you try *git clean -xdn -e foo*, the *foo *will be excluded and not
> what you said *"it _adds_ to the ignore rules".  *It's the confusing part
> of *`-e` *option, and I think it should always exclude something within t=
he
> given pattern.
> If we follow what you said, it should be *--include,* what do you think?

The `--exclude` option means "exclude this (mark this as ignored)
additionally".  I agree it could be misinterpreted, but `--include`
could as well.  The manual page says this about `-e`:

  Use the given exclude pattern in addition to the standard ignore rules
  (see gitignore(5)).

And the text says this about `-x`:

  Don=E2=80=99t use the standard ignore rules (see gitignore(5)), but still=
 use
  the ignore rules given with -e options from the command line. This
  allows removing all untracked files, including build products. This
  can be used (possibly in conjunction with git restore or git reset) to
  create a pristine working directory to test a clean build.

That means that when you say `git clean -xdn -e foo`, Git ignores only
`foo`, and says it will remove everything else that would normally be
ignored (which is no longer ignored, and thus untracked).  Remember that
`git clean` only removes untracked files and directories, and `-x` just
makes all files normally ignored untracked temporarily for the life of the
command.  Equivalent text exists in the description section of the
manual page.

I don't think this is confusing or that the text is inaccurate, but of
course if you want to submit a patch to improve the text, I'm sure we'd
be happy to take a look.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--bElD+DSzWMvyZBoo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ1emFAAKCRB8DEliiIei
gVigAP9fo9V/AANBwrXuKNbzePhP7uoKeiH63ZBsA3SbXMsY2AD/WcOm8fq3rLUU
2JjZalCjqQhYgTPsWrGi8zoyTPLjkgc=
=A6Jo
-----END PGP SIGNATURE-----

--bElD+DSzWMvyZBoo--
