Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D73334BA50
	for <git@vger.kernel.org>; Sun,  6 Sep 2026 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788718490; cv=none; b=T+K0zl2JR11EWFRTymDW9VHSVIzdhF/HDb+IzIj1GnioSAHzVKUqH1Lj7aXTFg0kbFh3+f7xk5IlByP7JVFDejQs6iFXz5I5gK7wi7+U/g56uhL2G91RMKdLUqhD78b82ljAuugSPtlBfMbinjfUG7Gw3UV2DBmEq/CRWKTyP0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788718490; c=relaxed/simple;
	bh=f+cqtXId2pwXRKc0GL5cKnqd9P0SG2WpYLRJxrgHolg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCvPdRJEzcfmkBJ0uG8MelA8sD/Jk3SP6JEwK87y8cH7tCN02VxMYajxKl35QLZ+6n6Um3jyS6ttSKSKbnRTlNE3kSiXwDou0MNB843bDMBhA7tqn1fQJQFpaGCLsOEueHoIVOE4ZJ2UKmrgxEgdIAG/A814nzugpNJLEreffqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=k6wsJFg7; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="k6wsJFg7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1788718481;
	bh=f+cqtXId2pwXRKc0GL5cKnqd9P0SG2WpYLRJxrgHolg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=k6wsJFg73DjznCGf22uJ9WuB/oVFjLo2MzECIHhy/h0hV36JKIZlTogrtaSyHunI1
	 q+yqOOIZdBmuVdcBHCznFOdmRQ8ZP4WTOJ4QcDjknJ0n4YwAdKMnRlrm3W5cTMYFI0
	 XQCmtVQr5wsmIBFt0TnvUasgh6O+fzYcjd5ALFGJ/XN1nOOr72k2Lq87qnIeqJBY8b
	 RKsH+F0Ib4NidaNSk0QIe0NlxJJ+T/SWnC/57F1MfcTBfdB6JAKqsHoI/m79UQ5BwZ
	 1k02Yr+Ru89pUIM9AAwGWFyDArsPDO/ymKvUro258Dq1WUeIDS/IyraNreTKV+9pcN
	 0PH81y3CPHis84aYtSDx5s6Q/mycWsmV2zfnvIqk1JL6Ga4FVETJGwZcBd6DQR68VY
	 1SNM2ZlhkPIEjcmDmQRkbdNPP7WIFwSk5nu4wkJFYlAZmcKxSlER3FTi9e/RvCSFcW
	 2mMaFHFtMYI6qgYI068rV/WYLtOyFBJpy0iPQmiTqFfaZlT987X
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:536c:7f6d:8004:5e14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 6393E20033;
	Sun,  6 Sep 2026 18:14:41 +0000 (UTC)
Date: Sun, 6 Sep 2026 18:14:40 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What will come after Git 2.56?
Message-ID: <ap2tjx0z7kiFjDM9@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqmrtu50av.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s42zZUsfFdWMXV4m"
Content-Disposition: inline
In-Reply-To: <xmqqmrtu50av.fsf@gitster.g>
User-Agent: Mutt/2.4.1 (2026-07-04)

--s42zZUsfFdWMXV4m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-09-06 at 07:03:20, Junio C Hamano wrote:
> http://tinyurl.com/gitcal tells us that the current development
> cycle for Git 2.56 will conclude around the end of this month.  As
> our typical development cycle lasts between 8 and 12 weeks, we will
> have exactly one more cycle after that before the end of the year.
>=20
> Now, the question is what that release should be called.  A few
> thoughts.
>=20
>  (1) Git 3.0: it is tempting to conclude the year with a big
>      version bump.  Splash!
>=20
>  (2) Git 2.99: by leaving no more room until 3.0, we will
>      conclude the year with a version that is still in the 2.X
>      series, but will hopefully force us to seriously prepare for
>      a big version bump with the first release of the year 2027.
>=20
>  (3) Git 2.98 (or 2.97): we admit that we are not ready for even
>      (2) and chicken out, leaving us breathing room for a few
>      more preparatory releases before the big one.
>=20
>  (4) Git 2.57: doing business as usual.
>=20
> Needless to say, this is not a popularity contest, nor is it even a
> democracy.  Regardless, we should review what we have in the
> 'BreakingChanges' document and ask ourselves how ready we are.

There are a few remaining things I think we should consider in regards
to this:

* forge support for SHA-256 on the remaining major forges (I have an
  update to provide about this at Git Merge);
* any updates on libgit2 and its support for SHA-256 and reftable; and
* the lowercase-only object IDs series, which I will be sending out a
  re-roll for today or tomorrow and which is a breaking change that we
  may want to soak for a release or two.

I think anyone else who is not already extremely far along on SHA-256
(and reftable, for software working with local repositories) is likely
not worth considering.  JGit and Gitoxide were both informed that
SHA-256 was coming in Git 3.0 at least a year ago, for instance.  (I
know because I did the informing.)

Similarly, I am not aware of anyone who is seriously undertaking Rust
support for platforms that do not already support it, so I don't think
that should be a blocker, either.

So my gut reaction would be that maybe 3 is the best choice.  2.97 might
be nice, or we could be more careful and go with 2.95 and then skip
ahead to 3.0 whenever we're ready.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--s42zZUsfFdWMXV4m
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmqdrZAJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ2SnPaE+eZTnhluXjKrcT/dyCSlgC0Ch5wlB+0CvR03c
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAG6NAQCgbRRDbp5CYScG6fjqvkoPDNPI
C+uUDVYenEyIjyb9fAD/cfoIL5pQ7HOcyyEJewAzqUAFXhcudqR0/0JNjOsjlgo=
=ytuK
-----END PGP SIGNATURE-----

--s42zZUsfFdWMXV4m--
