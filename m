Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792621290;
	b=5fgBQSfHPOcMVEQiMVzmROimk90pE3vq7L+bTrBg4ACI0OAXDZng65DCz3JWg2odftCm
	 0ZxDm3Ei9IhV10uPMtBEyHjR+LrZV9PSBkNvwZXmfiJWqNRFWhyfBUXgxesTHBofifpKP
	 USwX4rFSd4O+xWlqm4TZFpJLbfh8qqGmXq4XUvLgkNpNUBoKaAM0IqP83elDMcHyv6Dkx
	 vY/pK8S7X9M73udrsN+uqHOwk9eqxA3hhIap2wEqv5/zRam/xPnXu5ASAJNuFjZYr/KxM
	 mRJ7aoY8BUkPUtyQj4Xgw4ImsMaevjZYXy4k7tD6gaLnxtNELeWDFuXHnr1LBBcTvoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792621290;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=n2Sb/s9L1vD2lJZKQGvDbQYLLOkEZwWSw/qPLq4Ymoc=;
	b=GfSHE1TJtBU9UGE4BQ8OQFeuKJorJtYbbqIUXGQPGFQZmOQEDEwwEyTIEJEzUn3dCMQn
	 wOI3jVVjQtCDpidHc1DcaTSDzqCqWIhfxr+SN4tPtbMxq2QwLtMQbS3Hhe2n+1x0Spj9h
	 vR3bLKlMg2HpWQdi7vFieDw68TOJMZvdfeNz/q3UmUTRvPDywASCdkVZxiyqa13H9NRNr
	 /eJnNNXJcf9YOZ8LC+covvil9E3DHi74KYdbYV/jF2pyXM94ag5fSWL/QjV7ISE2ynS2p
	 Q5LmEiKL60YSvsd/efDBPND2tpDvK9Kike68GTpCLSAtXTNwjMLrcZiRh68F9FOz4RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b="zB/L18l+";
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D041C606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 22:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D041C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=zB/L18l+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1792621281;
	bh=BRuMq+xDe6u5xf6emIZTHxNUzsKF00ZbIjSTi4ekieY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=zB/L18l+T5WHSqBMSIPkT2Wy+U60qtqmCrISSAIoVmKYkCv8MPPatQds9y4t8jURS
	 cbfc2t0oDoO4VhNEvwzetO34y+7npNzIIPSutSrTn19cpp4C0aYSbIdIiPVVzdVG9F
	 qm5pz4te/S9I31xjZSGJO2xGP3/s2xm9CMFpd/sGK+mTvKsCOG0JR1P5pAodQ/fsB9
	 5vaZw3oWyapVRYwTmmlaXKPUTLocorIB9mVDGy2Bv+LNVpBMlbP6S03wYhwynjZJv8
	 pKg0U7uRATfeJV7h4lGWI5qfoivSwuQAGpU/4N7ywRtO/hTsBLpnmWD/Q/YZhsvG+Y
	 MrTLtvYAZzNswIEAzG+18OXypxYoZDPl9A2eU6tQU2x1MahaN3QYF0q+peRh2TFD9s
	 uC8eO5jJouIgAy1Y2ipiHot/yGyXjRRrUYXX3j7URMq1cbZr0tKK2n+YmiyfAeYIYs
	 UtTiGVHgQsiAxCG7WBet804KEIcipge8fS6MNMjqp7TbI5FmEuq
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:964b:4716:5e4c:1d15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B4FCC2006B;
	Wed, 21 Oct 2026 22:21:21 +0000 (UTC)
Date: Wed, 21 Oct 2026 22:21:20 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Adam Majer <adamm@zombino.com>
Cc: git@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: discussion: sha1/sha256 repositories and convert_commit_object
Message-ID: <atk63xoG773PzGq7@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Adam Majer <adamm@zombino.com>, git@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@xmission.com>
References: <ce3756bc-704c-41ff-bf8a-c060a2848aeb@zombino.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5fFluT4XzCRMhHaH"
Content-Disposition: inline
In-Reply-To: <ce3756bc-704c-41ff-bf8a-c060a2848aeb@zombino.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--5fFluT4XzCRMhHaH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-10-21 at 17:37:13, Adam Majer wrote:
> Hi,

Hey,

> I'm been experimenting with having both OID types in a repository. First,=
 I
> tried nodejs, which failed due to missing submodules, so I could not impo=
rt
> it.. Then I tried linux. This proved somewhat more problematic.
>=20
> I've been using convert_commit_object to convert a commit from one OID ty=
pe
> to another. The current implementation of convert_commit_object function =
has
> some comments about requiring to convert all types of OID references. The=
se
> includes mergetag and it just bails on other, unknown headers.
>=20
> In the linux tree, some dozen or so mergetags contain references that do =
not
> seem to be fetchable from anywhere.

I had noticed that the mergetags were not in Linus's repository, but I
hadn't tried other repositories on kernel.org.

> Also, a number of commits in linux history contains these unknown headers:
>=20
> ab5af2903baa472930c94a421efdd22a49036213:
>   predecessor bc6a71940d5182103469a479d12f4266ac155a39
>   predecessor-op rebase
>=20
> 3a413ece2504c70aa34a20be4dafec04e8c741f9:
>   predecessor 86d97728d053d6584be5592480ff3687d3d616ab
>   predecessor-op amend
>=20
> And the objects references here are unavailable.

We won't try to convert arbitrary headers like this.  However, I'm fine
with us skipping those headers so that their commits can be converted.

> How can we deal with these if we ever want to have the sha1-sha256 intero=
p?
> If we require stubborn adherence to 1-1 mappings of all OIDs, these
> repositories cannot ever be imported into sha256 repositories with their
> histories. Even recent commits cause issues here as git is not holding on=
 to
> referenced objects.
>=20
> Would it be possible to have a little different approach? For example,
> mergetag headers and other unknown headers, maybe we can consider these as
> just text and copy verbatim in convert_commit_object? I understand this
> would result in different commit ids, depending if coming originally from
> sha256 or sha1 repo, but since git is not really preserving references to
> these objects anyway, this may call for a little flexibility.

I don't think I converted mergetag entries in my original series.  The
problem is that if we don't convert them, then we also can't validate
them because we don't know what data they point to.  We don't make
assumptions based on the size of the hash because in the future we might
also have SHA3-256 or BLAKE2b-256.

That means that the original point of the mergetags, to preserve the
signature and contents of the original tag, would be useless.  That
doesn't mean we couldn't skip converting them, but it does mean that if
we do so, we should probably just stop writing those headers because
they're no longer fit for purpose and we should consider them a failed
implementation.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--5fFluT4XzCRMhHaH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmrZOt8JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ4jwfdRg9hRQUvsnkf9xDtW9i6MCmZwk9UY2xy6/gSxC
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAGstAP0Wpb4LEGs4pCqSi6nJxwzFaFIY
d1vt8qTouz0rm5AvYAD/RtigzYn3aKTW2LBTnBG9ScZ0Cx+ZIAhfyYBnl4/5XgA=
=esqa
-----END PGP SIGNATURE-----

--5fFluT4XzCRMhHaH--
