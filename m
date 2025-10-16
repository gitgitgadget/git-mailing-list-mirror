Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38AA21ADB9
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 21:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760650367; cv=none; b=heBzSHAi2FlyIA3NSvbNw4C0kUr0uLQvlbTwLjO5x1LDNyD7Ly1RhurTcBOzYU2fXDGg0hm2i6t92ljUXGrkwF8KK6kupAVFjauOQ8GB5QZ3iFH1mltedgPSMORjR0dxgFqaKkPYbKGvFFsVSyGJfur+RzrFsA9DGKME0ngQWlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760650367; c=relaxed/simple;
	bh=xIuvNUU801esMlSgGnzsgsjV+QQKeRtuHQpSvskDy0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aT0uKHGfHz+E0jqx55u3baw+r8VertbAPRaUKbYO1RSaRdMnUZOXJdEyeDvXTpN2/4z510HUrv5lF/f1R9q1aigVU/W7n/k1XXkbAsZ2cXe4kk0KXvRbSnuVA8QVFxBW6RSu1a2b8h7hCbs4FAoEa0yi+cyopN/7by65rk2QENM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=VOlxKKX/; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="VOlxKKX/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1760650363;
	bh=xIuvNUU801esMlSgGnzsgsjV+QQKeRtuHQpSvskDy0M=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=VOlxKKX/jDj0SLRuTEp7yVMZgvFscblzXgOS+NFA3jieyuJnPwv34SczjnUIMxECA
	 PcurXrFf9JHImqH8Ma1KxLKfnDLQ9grjMgc0j3dV7qteN/S8FnxB6WgSSg+u7a1s7T
	 /jG/SJ4/rrrZoFNstcGzt4NAApCofr6tJZ2HjiVMVNjTEiyU7VaiDld7SSuh8nUqE0
	 r47YX5wZpg0oBvtysWM6umztg+6KyKJXhkFjE4tSKlFdszao+l1TDaQhIk9FHlpTvm
	 a62TllWwKFnrGNAcgyJZvT+zYx3NCsDkT0iDWAwUrTjwpLP2ULdgC78K2OrlsiigKI
	 Pw9psX2sRcU7FLXAnxJfONRVJrdcU8tKOtwEUCoCy8P0zqTJYONcM/qUgTaSHT0PmY
	 TXfAOEBgftDKhMCdn4Xlg5h79yFjCuXGILoGFwltF6Nl9wNOIx8ckdaDNzcHyXyWfJ
	 yRhGCpTSRs90mjoUe2X3Hrtt1Pyo6mZ2G0/xrigsGfNjb1d/F80
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:5c18:db3b:8800:f1b6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 23D0B200BA;
	Thu, 16 Oct 2025 21:32:43 +0000 (UTC)
Date: Thu, 16 Oct 2025 21:32:41 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>, Ben Knoble <ben.knoble@gmail.com>,
	Luca Milanesio <luca.milanesio@gmail.com>, git@vger.kernel.org
Subject: Re: When should we release Git 3.0?
Message-ID: <aPFkeZrowzxtg6uN@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
	Ben Knoble <ben.knoble@gmail.com>,
	Luca Milanesio <luca.milanesio@gmail.com>, git@vger.kernel.org
References: <aN5-n_ArhQqaQZgt@pks.im>
 <D59D0576-63C9-4144-B49E-54D43A80E0B0@gmail.com>
 <aOTrBAXhKF4iYzQB@pks.im>
 <aObgEGjcou06nP68@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k9BgRK7609lzr2mr"
Content-Disposition: inline
In-Reply-To: <aObgEGjcou06nP68@nand.local>
User-Agent: Mutt/2.2.13 (2024-03-09)


--k9BgRK7609lzr2mr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-08 at 22:05:04, Taylor Blau wrote:
> I am not sure what our proposal would be other than max(proposed_dates),
> clamped to some reasonable range that we are comfortable with so as not
> to delay the transition to use SHA-256 by default too far into the
> future.
>=20
> I think a more interesting question is:
>=20
>  - What do we do for implementations that do not have a roadmap, or
>    whose roadmap is too far into the future?
>=20
>  - What do we do for implementations that have a roadmap, have a date
>    that is palatable to the project, but end up slipping and are unable
>    to meet that date?
>=20
> I generally agree that we have to draw a line in the sand *somewhere*,
> but I don't think we should be so inflexible as to say "if you don't
> have SHA-256 done by X date, you are out of luck". Of course, if the
> amended timeline is too far beyond the initial deadline that's one case.
> But if someone is a release cycle or so behind, I think it's reasonable
> that the project should be flexible enough to accommodate that.

I agree that it would be appropriate to be somewhat flexible.  My
personal view is that we should inform stakeholders relatively soon
(preferably within the next month) and expect them to promptly and
diligently undertake the necessary work to get started (maybe within
another month) and provide a rough roadmap.

If that happens, I expect most stakeholders will be done in about a year
to a year and a half, tops.  Assuming a reasonable release cycle, I
think it should be fine to give people some grace to do a release with
those changes as long as they can communicate a reasonable timeline to
us and show that they're making a reasonably diligent effort.

I also think there will be some stakeholders, probably including some
forges, that will not promptly undertake the work.  In my view, the
answer then is that we won't consider their readiness as affecting our
timeline.

There are also some implementations that I know already have SHA-256
support.  I believe libgit2 and Forgejo both have at least some
functionality there, so we may want to just give them a heads up that
they may want to polish any support they have before Git 3.0.

If we want to set a hard cap, then I'd say two years.  I know that's
what we said in 2024, but we didn't communicate it well at the time.
What I have been communicating elsewhere is that Git 3.0 is tentatively
planned for a year from now, so that may be a good initial phrasing to
set expectations, with the clarifications we've specified.  I think a
year from now would be good if all the relevant stakeholders are
finished before then (which is possible, but unlikely).
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--k9BgRK7609lzr2mr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaPFkeQAKCRB8DEliiIei
gSmSAP9syv8LQtfT0/ecwOeIu3j4Wr2Mzhby6NCS8q+7jWTldwEAowsZnd+Xr5ow
u/GHV7bNkRy/Y3YhX9FNManwXYl3JAs=
=At74
-----END PGP SIGNATURE-----

--k9BgRK7609lzr2mr--
