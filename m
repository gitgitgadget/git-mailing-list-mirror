Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792709993;
	b=VD6O5R2iwxPPuvRNEv/3eR78ANsyLoA4JXgw0dZDzCYpstZvn3vZGLxse2RthxCu/dti
	 xDMsbmherZhM8HgQWT8p9CX7YN4pb7N/T2Tt5pofjOdD+HJo9pMCfsAupW/YabtFw9q7x
	 ynx3/HR0zEskQGFWyclXPLDlke2M3fce3a7UsZKRhvxeuHefEb/v9pYcE+LJqlEqvRI1H
	 XG+uFQbVI8J6kMsXIboPvpnS4cXHdG55TFSpQngZNkodk2zZ55wKE+2nIk5I3eZvJG950
	 fKDn8E4iHTncHhpKmDd+EjFUtG8nRqEe2xaTh+2dF61QJ4cq1iYeMj8iCsRe3my4XqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792709993;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=A/hLwfIcfuSwzcAYRCe+iL/5iwc5lH7X14CAAf9rVcY=;
	b=oQrL8edVdq6N+mo3+RQuFluU47Pc6dw4Ziez8BbbtJYm/WSaVaZR8uZHhKYBZBJKrB1G
	 vA6xc/Dbk1Xpeyd6nZ82ZHcFz5UC6f4F+bBFolPZid+X798pKT/4IjSK+0sTWvCG6XdkQ
	 efGObPNYPfHx9jpPlI/DYDCyPOSsLrXYo8Ws6UHTKZLGTtzRJ3EU45giiO99LLr9JBIkP
	 RrqhyOiwdzWz9e/6zgNaNK5vcgcS8seaKF2yBo6ZB9PX2Jw9+rDeFTJ59v8MOIynWGVsZ
	 WEuL2mzhlI/CMVtgtAyqTiRdMKij+DIjX9Kz5zyZO1bMyPrTDYCIoRzTqvPKx/+n8hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=vS2Bv20v;
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EBA606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 22:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44EBA606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=vS2Bv20v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1792709991;
	bh=ZtV7tjt5QGcohRlXnaARdVQLJSDTLknsxbmMHUHDcH0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=vS2Bv20vr68VcvpJx3kF0qIA2wwvUCiOZsH9yzRlEbLE48+ngF79KAGsdqbz2lVvf
	 wm0wn2uJmnX2ESbDe1QiaOi7CrJKkEWDQrl8bMhtMgpkIkayku6wz4scmmZrgwZoWs
	 kmTpxtbksuntArrElAFxz/CxHHVshiiW1TfOCmaBaiWxC9AfAFcyaficUgBFzgm/a0
	 tx5VWEs8Pjm7uwX79hZAesj0MxsLxTv33TuTPd6hkdLnLwE7chzc0exlEAhqLUGOxo
	 7pB0GM/ZhuzNQ6r1dNw+9TErT0oZXju1seI6/CqUgZ7Rn7opjPyn9pCIx1zIlNyMpi
	 0njbGNcZYA/BkoCVTNHEUv2GAmtwrvscgyO9ttPWx/sJq2Lx1qDKzZlPFKlTSOKZP0
	 lsBrcPiaEGFf+ydHOUTh3SzdAmB3HL+uuqARdTtj5LeaMJqQpJF50tV4V5bYh2UYc/
	 tL3ScoW52u0ZenhpMxfYnX2C7Gn3oWRwSFJC2K7eFCDWbDdKxfm
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b44d:c6f6:4e4b:66bf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 059242006B;
	Thu, 22 Oct 2026 22:59:51 +0000 (UTC)
Date: Thu, 22 Oct 2026 22:59:49 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Emily Shaffer <nasamuffin@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Documentation: propose community voting process
Message-ID: <atqVZYU3YfuyFdvU@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Emily Shaffer <nasamuffin@google.com>, git@vger.kernel.org
References: <summit-2026.94e33e9ddf234334.06@ttaylorr.com>
 <20261021200341.378978-1-emilyshaffer@google.com>
 <CAJoAoZnhc6Tjm9m9dmTA6UD18HzkxAv2_ifB5x74ectqX8YieA@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="0mdlEJp8Xd/CN0Fz"
Content-Disposition: inline
In-Reply-To: <CAJoAoZnhc6Tjm9m9dmTA6UD18HzkxAv2_ifB5x74ectqX8YieA@mail.gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--0mdlEJp8Xd/CN0Fz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-10-21 at 20:05:06, Emily Shaffer wrote:
> There are a few appealing options.
>=20
> * Debian uses devotee (https://salsa.debian.org/debian/devotee), which
> appears to require hosting. Finding neutral hosting may prove tricky.
> * Konstantin let me know that The Linux Foundation's Technical
> Advisory Board has used CIVS (https://civs1.civs.us/) in the past. He
> says he wasn't involved in setting it up but doesn't think it looks
> too challenging. CIVS and devotee use the same tallying algorithm.

I'm not volunteering to set this up or maintain things, but I do follow
Debian stuff reasonably closely and I have a positive opinion of
devotee.

> * jj used voting on a GitHub poll in the past. That would just give us
> simple majority, and it would require GitHub accounts, which may be a
> barrier.

I think some people who are contributors will not want to use GitHub and
we've historically been neutral on forges and tooling, so we should
continue that policy here.

> > +Votes are welcome from contributors who have authored a commit which h=
as been
> > +merged to next, or who have provided 2 or more code reviews, and who h=
ave not
> > +been banned from participation in the project. All eligible contributo=
r votes
> > +are weighed equally, regardless of the overall number of contributions=
 they
> > +have landed.

I think this is too few contributions.  Other projects use a much
tighter mechanism for choosing contributors and some even restrict
access to a core team.  I'm not saying that we should do that here, but
we should put a threshold in place where people are not incentivized to
contribute only to vote.  That is, we want contributors to contribute
for the sake of contributing and have voting be merely a consequence
of being a serious contributor.

At this moment, I'm not sure exactly where that threshold should be set,
though.

> * Easy (scriptable) eligibility determination. If we start to explore
> other types of contribution, like user support in non-mailing-list
> platforms, it becomes really difficult to send a ballot to everyone
> who's supposed to get one.

Scriptability is important, I agree.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA
Speaking for myself only

--0mdlEJp8Xd/CN0Fz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmralWUJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZy+L7eVBamk9ntmEP8UrIbdVN5SzqToW9HLL0TcEGHib
FiEECCzmip28ZfuD0cORfAxJYoiHooEAANMrAP4q8WXLULPDBZuO9NDfVUIOB6f1
LbWWGHbrMVsi+0Cd9gD8Ccc+0NMi8DVJIUFXXyFMRFdb8rH4/lBTVlH+Hc+jvws=
=oJlK
-----END PGP SIGNATURE-----

--0mdlEJp8Xd/CN0Fz--
