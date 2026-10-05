Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD8136A01A
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 12:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791203883; cv=none; b=DF6Fi9Oz/je56zkU2d06uQxt4px1YAjNahKDUaw5jsdDHtN61RqN3Bg/vXY9YmtRT1xTD5GHcRADlKvDjczanOaOJ2YSscvy6K6btJNpndsWqmmuUKfTPS0IYhMGFchBME1DC+vxp07iEqkfsjLiytBnYywSeksC3LTK9rdXdnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791203883; c=relaxed/simple;
	bh=mfJhWPuL3WqX0w8Sk6N4+m6w4aUJ2/aL+0ZmwehFwuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txbcRS9EHpTtVVwLxlmTZtBDFULLhCehS6/8gIp89FyXDsw/9LziyqwS3Nj6yMCxQa1+xgh27ucsqQe6xLh618zTMkRRSE8+3J8ECGtC0XmsD+aBZSIubCfkdd6No/LZxZ+BcHdBMzUO+najF8liQMHDjcwygcF2/KVFnFoa0nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nl8EssFV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nl8EssFV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DE81F000FF;
	Mon,  5 Oct 2026 12:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791203882;
	bh=RkhM0CMFhKesnJjT+dhZyVxKfzLrsO/SGAqchV31Kh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nl8EssFV1vMSb1yI0zDJZwqCOeIJtVX3U0J2s7x9PBopfo8eMNG1xpXFrdHnS6FNo
	 SJnC1GY9iNlU6eJvelyb/anqFCJv0W+1Ms3IndCp0YQoSQIjFdD/3QfYpF2y6Akphh
	 B6JhraRpdWURPHSRaVhJO/a9dd+Cm3+CjH61dzS0uf/g7LHxeJGMWgBPFhzrt6nMzv
	 7uK7o0w51c4z9NDCgfen5q87CFtm0gg47THZXjeOcgrYBWIuaCksZuxfL6c1TB6tD5
	 AZ5shZhNP7SDWrgkV6akn7ArI6Tch1+4HGypmf+wSAj4A5GkW6BUniPH5U4uaps/8n
	 wKmikb3ywXweQ==
Date: Mon, 5 Oct 2026 14:37:57 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: git-bisect(1) next after finding the commit
Message-ID: <asOaBQ_vrF6NC0dW@debian>
References: <asAbOSQ4BkuCTPY5@debian>
 <20261002221154.GA833115@coredump.intra.peff.net>
 <asCY8kLEV4OAG1BG@debian>
 <20261005032348.GA10163@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zysrc7xovwifmm6e"
Content-Disposition: inline
In-Reply-To: <20261005032348.GA10163@coredump.intra.peff.net>


--zysrc7xovwifmm6e
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: git-bisect(1) next after finding the commit
Message-ID: <asOaBQ_vrF6NC0dW@debian>
References: <asAbOSQ4BkuCTPY5@debian>
 <20261002221154.GA833115@coredump.intra.peff.net>
 <asCY8kLEV4OAG1BG@debian>
 <20261005032348.GA10163@coredump.intra.peff.net>
MIME-Version: 1.0
In-Reply-To: <20261005032348.GA10163@coredump.intra.peff.net>

Hi Jeff,

> Date: 2026-10-04 23:23:48-0400
> From: Jeff King <peff@peff.net>
>
> On Sat, Oct 03, 2026 at 07:59:43AM +0200, Alejandro Colomar wrote:
>=20
> > > I'm not 100% sure, but I think "git show bisect/bad" should work.
> >=20
> > Thanks!  It works.
> >=20
> > I guess the plumbing version of it would be
> > 	git rev-list -1 bisect/bad
> > right?
>=20
> Yeah. Or even just "git rev-parse bisect/bad" (maybe with --verify if
> appropriate).

Oh, thanks!  I've changed the rev-list -1 calls to do rev-parse.


Have a lovely day!
Alex

> -Peff

--=20
<https://www.alejandro-colomar.es>

--zysrc7xovwifmm6e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrDmiQACgkQ64mZXMKQ
wqnHCw/+MSAMYF1ZphOqzOUUk2+FJ7Gb7RQdBV+NO5ZVJ1/veqTI7Tciy6ZdB6fM
p1DTt/4cDy7Yeg0OBWq1dDg7VAAEUeu/+vBGL2FoVTRdvC4HDCqFo/cYyuHyaeYN
ctdPgOIIvdIyFhBXBUEH9zWaEtMKKItWzW10Y4py0WeiVHWKUtr3e11LQmVqHVEH
Ejfz0FXjUHETdkFO1ttI2KqJo9jvzMfWOHNnNN8FJ8CN0VnwJLvSzjzmAZvp9yDb
wegaWwBT/qi4lO03TYdYGuyVI/qdQ9kYL41ySustBoTyr+Nf74N0hHHu0k9R+oTV
CJ4LhMWSswyzawpZ/L8jLT2t4m2PHu/KO/VLOS0JZBAnWwWBP54THi9nOJPQZtL0
bG18PmschvJ0bOpAzKxxg4nAH//qG7rW21NcKpb3YpiWXcUMFYZgp5d9YFRGYVhp
1pqZLSUpzt8JBkZzd46jQWUC3xnqaDceTDg5oZ7r/5gD5dO36FSwsyam6wIJR1G1
DHZ0QLw7nNX9FiGTEi/V5YSS/gG+w9JmNadYkkky2feWA7l6MXewDW81WHEorH81
nVwqFy6ai5kJrUsXeojZMmv7nyAoMrg7YCYiuYIE0MjhyPwhQjS6mev6ha/2bvoL
6gx5AS8hH6due68j4XHO0zJ6ynpEHZ/aVHZ6NEqRnQUs/xwgbU0=
=XlhK
-----END PGP SIGNATURE-----

--zysrc7xovwifmm6e--
