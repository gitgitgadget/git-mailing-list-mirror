Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF59B824A3
	for <git@vger.kernel.org>; Mon, 13 May 2024 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715635203; cv=none; b=LalxNqNq6LXUpJo2VygA5fLc5on7G9bLUUi3iGZf9UUP6fUb1MMXQJHXl+zB+BCEuq86SmDtGDCFj5GQIP5jP1leb2aWfPpkpTdLx7ud7VX1qs2rKKQenIbmKsBtYLVj9s64CyhVNjXyd9iVjtnSGpnuMFyCjqraFIYOPhI7VAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715635203; c=relaxed/simple;
	bh=SjKGpdbThgdNCcHr7Mn/S7ZSzG4WfPOeG70IxN4OZtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZB2CBXUj/AvmHkFgdy06yNWiD4fOkfUgMg2fLJgzcBbSrHLL7Yk/UArJNzIflkBPM0bWrJcxMzhbfblXtyKDn4ovW6ldA8SQMoOjhFv4IYI1g6Uh/tbVFLnPOkjdsxkN2qg25we6nZLK91jRxFPs1ct4mxcgw9K+I3mHjY0PF0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=my/aS5tY; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="my/aS5tY"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 4356D5DA7D;
	Mon, 13 May 2024 21:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1715635194;
	bh=SjKGpdbThgdNCcHr7Mn/S7ZSzG4WfPOeG70IxN4OZtc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=my/aS5tYmUsAMBONhmQ8yq5QhaSSQnD55eL+V9+vt16qNI5UPLNKRCd1opIREAxw5
	 3YLgtimsTxgxZl7ir5dZPkS3oMGba/r5a+O6fa8PPGsUUNQBWi27hPijBfQmGXjaxq
	 fdT5lDKlEVzo/tZ85W9LjBWwP7FalQ1SFyBeWnLPgLujgKH+5Cm+nOegvrhCKk1OCB
	 dLD6OOZVX19k2sjLhuKOKclsqdaIeq9gnpKK1uHsn8nZHvxzz5CGUIkgHaEsPwqdm7
	 URuEAv+8QstJ5g+Bmwc8Dp8mp7zvHP3tW4ckfW4PVC7RrIkR2/vrT4RnLfCjHhVegU
	 fz2pSzFHyCJui4fD705jcgcKX1HC/8R1ZC2R7lct1g7YyRO6qkXw+5MEa/tpKkBeU/
	 CeV6nYpZfUs9/EdtSIU8KMB1jUPS9qvrZ+nNj9YPyhrV5PrM+P7Fk9fQ5hzdh3jET9
	 7rD+HEORPeI425CdRwgFhid51MAhL+DwVvlH0wY/OY8CGlYRoeJ
Date: Mon, 13 May 2024 21:19:51 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: lbdyck@gmail.com
Cc: 'Junio C Hamano' <gitster@pobox.com>,
	'Sean Allred' <allred.sean@gmail.com>, git@vger.kernel.org
Subject: Re: git client enhancement request
Message-ID: <ZkKD95VBlmsUJdB5@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	lbdyck@gmail.com, 'Junio C Hamano' <gitster@pobox.com>,
	'Sean Allred' <allred.sean@gmail.com>, git@vger.kernel.org
References: <02f201daa547$503df630$f0b9e290$@gmail.com>
 <m0pltptx3h.fsf@epic96565.epic.com>
 <xmqq8r0dfsvd.fsf@gitster.g>
 <051d01daa567$caa22750$5fe675f0$@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L0zrESb3a81w8rFN"
Content-Disposition: inline
In-Reply-To: <051d01daa567$caa22750$5fe675f0$@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--L0zrESb3a81w8rFN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-05-13 at 19:00:14, lbdyck@gmail.com wrote:
> I have to interject here that the git client doing a push must be fully
> authenticated which implies to me that all the information required is
> available to do so and allow the server repository to be updated.

First of all, the authentication required to _create_ a repository need
not be the same as to _read_ or _write_ a repository.  It might require
a totally different set of scopes or privileges to create a new
repository, which many users will have avoided giving to their
credentials for least-privilege reasons.

Second, there's no standard API to perform that functionality, and the
implementation varies widely on different forges.  There are also people
who don't use forges at all, or use tooling like gitolite[0] that handles
this differently.  Adding such functionality into the Git protocol
requires intertwining that functionality and the services that provide
it with the standard forge API, so it's likely to be very complex for
forges to implement using the same functionality as Git uses currently.

Third, we specifically try not to prioritize any individual piece of
software or project here.  Even if there are many common forges, we
won't ship tooling that's specific to GitHub, GitLab, or Bitbucket,
since that prioritizes those users over others.  Since there's no
standard API for this, we won't be adding any forge-specific
functionality to Git.

Even if we decided to implement a standard API for doing this, it
doesn't mean that forges would adopt it.  Many forges don't implement
`git-archive` over SSH, for example, since it's hard to cache versus
using HTTP.

[0] gitolite actually allows you to create repositories by just pushing
to them if you have permissions to do so in the configuration.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--L0zrESb3a81w8rFN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZkKD9wAKCRB8DEliiIei
gQq7AQCrQ40vBcCWhoDFwco7fhAL0hHhgRNjTVpqKJbZnu07XgEAqin+EbjpbSE8
zbk+UN3BW78gV9RviBvmvDCD34r+uAw=
=n/b2
-----END PGP SIGNATURE-----

--L0zrESb3a81w8rFN--
