Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AC3BA24
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 01:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706838812; cv=none; b=ZWCNDekfN6WiKkW4i4ro7g8AKF8uhoJy1395yWWTrXzcOefLwWK6xAOpGQCGPnYRI8W2mb9jWajy8YdjGKBzONGkonYlhqZdEqdP93n6NhlFNe5nDvPvPrB7u06B6npBn0cwvYp8LjBW+KMbtW1BgjKx/shhcVEQk0jZC202JEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706838812; c=relaxed/simple;
	bh=HW4kD+f/5G4Fq06yREearRzivFnUEYP78TF+WM2MdGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Le67qf3wmjvhK+rkwicYtYBpZLsifRVti2yjg3ufWi4v7d9HtU3YnGt5D+R/uGCokiCIteyiBfPjhi+c9Ac/DC6StUd/r7+IDC2w+5zXeC0dFDD2rqP9gml0dtYZ69jNHArpyD6C3Uj1pwhQzkrUOdSfFDnssRTXlxVcT60jJH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=n1X3xL71; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="n1X3xL71"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id DBEA95A41A;
	Fri,  2 Feb 2024 01:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1706838244;
	bh=HW4kD+f/5G4Fq06yREearRzivFnUEYP78TF+WM2MdGE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=n1X3xL71rB0gBBpAM5CuqH8RZAVA/UlyMK+QuNV9uhQYD9TvFy4BffO2denz+pr6t
	 MoB3h3PIv+oU2rtOU7SA+IuyA2+vl90lLD7sMoyXojvPyR5L/hFAsSKQ84KQmorxo5
	 KcwK+biLcGFnigWElj4mszz5wFNiPVRPWckHIdrg43kn3vd+Lkpca62aQH4nnMnVAM
	 mxbbKBEHQ859Z1rQB/MT3g5G/ndFkIU8Y6bKDi8zAmIQoL19lXinpZZ81lzkOPn6XU
	 vFV/56hRg9/+U5EAKJa05RJyLympg5xMiBWENpixIVXqtTIxGNJciSlpnD4o54+nz6
	 0X5Xy4NILKQ8Brp/l7E9TtDRP/3gOCqIuCd+jbecT5/PxxVY1bVAE3K0uWofhmxQPL
	 QAQxUjqEvtGZX0VtiW8TjmP7/YBbQrG1/C8SOgU7FJtmVFuBnE1RQ4u/GVg4igdBV3
	 RxP8u9XGHDkCLNvePhhKW9p74ohDebdQtwUzq5ujg9N6r0Lk1nX
Date: Fri, 2 Feb 2024 01:44:03 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Hans Meiser <brille1@hotmail.com>
Cc: Dragan Simic <dsimic@manjaro.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
Message-ID: <ZbxI4wNTBZ48YcTi@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Hans Meiser <brille1@hotmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <20240201-primitive-aardwark-of-contentment-aaabb9@lemur>
 <DB9P195MB21301E5E271567256303443CE2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <c3b6de0c2ccf71f0dfa5aff06fa63d8f@manjaro.org>
 <DB9P195MB21303B5546A764A18FE78C97E2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UPqonseOJ2bFxRpf"
Content-Disposition: inline
In-Reply-To: <DB9P195MB21303B5546A764A18FE78C97E2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
User-Agent: Mutt/2.2.12 (2023-09-09)


--UPqonseOJ2bFxRpf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-02-01 at 18:36:48, Hans Meiser wrote:
> > Could you, please, clarify what kind of git documentation are you
> > referring to?=C2=A0 Are you having git man pages in mind?
>=20
> Yes, these in particular.
>=20
> From my point of view, many of these are quite unorganized, hard to
> read and =E2=80=93 as I believe =E2=80=93 need a fix-up. Markdown could r=
eplace the
> currently used language, so editing them would be more easy, proving
> support for preview and lint the documentation.

We've discussed moving to Markdown.  Unfortunately, while Markdown is
great for HTML, it's pretty terrible for things that are not HTML.
Certainly there are tools that convert Markdown to other formats, but
I'm not aware of any single tool (outside of Pandoc[0]) that does so into
all the formats we offer, including HTML, PDF, Texinfo, and manual
pages.  Markdown also comes in a large variety of variants and writing
documentation to please any substantial number of tools is very
difficult.

AsciiDoc supports converting into all of those things either directly or
through DocBook, and it's flexible enough to allow a decent amount of
customization, which we take advantage of.  It also has relatively
little variation.  Both of these are part of the reason that Git LFS
moved from Markdown to AsciiDoc.

> >Quite frankly, I think you've missed some important points from the
> > Konstantin's message.=C2=A0 To sum it up a bit, not having continuous s=
upport
> > is simply unacceptable for any kind of a long-term project.
>=20
> As I wrote, once installed on-premise, no-one will shut down an
> on-premise git server except for yourself. It can run for eternity.
> You just need someone to administer it properly and publish the
> website.

Yes, and that would be someone at kernel.org, which is a nonprofit.
Maintaining a busy Git server takes server resources and sufficient
staffing to ensure that things work properly and that problems are
resolved in a timely manner.  It also comes with potential security
risks.  The mail-based approach will likely remain for the Linux kernel,
so someone will have to maintain this in addition.  Are you offering to
provide long-term funding to kernel.org to provide the necessary
resources and staffing?

> In the end, it's all just about git. You may create your own git
> webserver (https://git-scm.com/book/en/v2/Git-on-the-Server-GitWeb),
> or just use an existing one, like the GitLab server:
> https://about.gitlab.com/install/

The Git project has tried for a long time to be neutral on any
particular external piece of software.  Installing a GitLab server as
our preferred development platform would promote GitLab as the preferred
forge to other users.  Similarly, moving to GitHub would prefer GitHub
over other forges.  That's not a thing we want to do.

We also don't accept patches or features for the benefit of one
particular forge or external project.  Patches and features must be
of general benefit to the project at large.

[0] Pandoc is built in Haskell using GHC, which has decent architecture
support, but quite poor OS support outside of the most common platforms.
Relying on it would be a serious regression in terms of documentation
support.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--UPqonseOJ2bFxRpf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZbxI4gAKCRB8DEliiIei
gR74AQDhp+drXfAeSKp3+jb2ELSOqFkYhrh2LJ26BAYHyGobswD/SFeD06zyrm/2
UnHGlrEfFbknbBKHOiM1JuRxi8eBpw4=
=Y7yj
-----END PGP SIGNATURE-----

--UPqonseOJ2bFxRpf--
