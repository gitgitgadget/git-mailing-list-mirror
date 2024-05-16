Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D031459F3
	for <git@vger.kernel.org>; Thu, 16 May 2024 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715872532; cv=none; b=lgHmicFNURvGsDbWEJk71IarqGLPaVZP7EQ7BWJ91qTpJfTJdknRDHpUdrTn+9Lpv36KCDshRDOe8KiKnzu8TtH1AdksxUybgnZUNoP8IvkCu6EKg0qai2bzGSh7bbytI6tJ04/LHu/vZJ9PE3sXapkIfkNHCYI/FTYGig2o+zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715872532; c=relaxed/simple;
	bh=hu8b1Oc2/sJRauENhJ3uYrITzq0Djx15dfkY8B+D/fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSBbsCDvD992whpXamYoCc1XPaYLyUpJ2gRd3g+g16Ab9sN07eJtlfx4SYlcUW26O01TbIhov2Hl8stuis4LomwSEREMqT+zQzRkpJj18kjBh29Ur6FUNPhW/6Z6wU5ujR3qPAyYktq2nkY3Cgl+xCnxMjJQzF4oHrIDQwg1gYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=K2R2/znX; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="K2R2/znX"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id C08885DA90;
	Thu, 16 May 2024 15:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1715872528;
	bh=hu8b1Oc2/sJRauENhJ3uYrITzq0Djx15dfkY8B+D/fw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=K2R2/znXl8munk+Z6fOkL+XfXlq9N9Tvf5AmJFENGB6VWk5mPTLL4UuNpnLL3/yCO
	 6gdimjjnmQQZlE3Om32TLjTNDnpt6SFlPCXCl6pyAJtXtAaVr0e4z+OI/uesZma1Y5
	 i0oT4HLEZXj51pzNw+r6axbW6GmKodS1Z9WRRUU5p0ejChQgewNA8yLKXNgm7NrKwN
	 XGKwy0AkWYym4dVhrgXaz7BquNg6pArUivmTwM/7s1P6crSqo8XLYlR7TyN5AT39iT
	 itP/DInZZDORd8UScn7/qSDtLWm87U7sgx3i/zzfC9UCJfZXqF2uN5D+n0s6xYMVDF
	 myQ6g8NqFgcuhkC65piKl/NMc6K0xP/7WmZosDk7XEAu0G/mIXHx7qg5yTQFytMqWk
	 omkDQhjHiDAcgVAObi8JZzTocZyNLWO4Hcj4ELY9S7tmltUJoyHRWFB+OyAxG/7Bzr
	 TUBEhxO170NEMAPWgUaUj4XJvX4cuLcprQStqLEdtaQFZXNgrlJ
Date: Thu, 16 May 2024 15:15:27 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Kevin Gale <s7g2vp2@yahoo.co.uk>
Cc: git@vger.kernel.org
Subject: Re: Embedding Git Command Line
Message-ID: <ZkYjD7VGC4zLhRDF@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Kevin Gale <s7g2vp2@yahoo.co.uk>, git@vger.kernel.org
References: <36B52407-B52F-4394-8DF2-F2DF3D3F0504.ref@yahoo.co.uk>
 <36B52407-B52F-4394-8DF2-F2DF3D3F0504@yahoo.co.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VutRha6zu1SZejk1"
Content-Disposition: inline
In-Reply-To: <36B52407-B52F-4394-8DF2-F2DF3D3F0504@yahoo.co.uk>
User-Agent: Mutt/2.2.12 (2023-09-09)


--VutRha6zu1SZejk1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-05-16 at 12:04:35, Kevin Gale wrote:
> Hi.

Hey,

> What I would like to know is if integrating with the command line tools w=
ould still fall foul of the GPLv2 license or if there is an exception like =
there is for libgit2.

First of all, I'm not a lawyer and this is not legal advice.  However,
having said that, I think the common understanding is that it's fine to
call out to a GPL binary from your proprietary program without violating
the license, unless the output is a derivative work.  Usually that's not
the case; it would only usually be so if the output included part of the
GPL software's source code, such as a parser generator.  The FSF has a
FAQ[0] that covers this to some extent, which calls the approach of
calling out to the program a form of "communicat[ing] at arms length".

As a major copyright holder in Git, I don't see a problem from my
perspective with a proprietary piece of software calling out to Git as a
separate binary.  Git is designed to provide scripting interfaces so
it's easy to use from a variety of software.  You would of course need
to provide the source to the version of Git you distribute and the
copyright and license information as well, in compliance with the
license.  Note also that if you are distributing Git, you cannot link it
against GPL-incompatible software (e.g., OpenSSL) unless that
GPL-incompatible software is distributed independently as part of the
operating system.

I also want to be clear that this is my understanding as a layperson and
my interpretation as a contributor to and copyright holder in Git, but
it isn't binding on anyone else here.  If you want a legal opinion, you
need to consult a lawyer licensed in your jurisdiction who has
experience in FLOSS copyright law.  Nobody here can provide you such
an opinion.

[0] https://www.gnu.org/licenses/gpl-faq.html#GPLInProprietarySystem
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--VutRha6zu1SZejk1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZkYjDgAKCRB8DEliiIei
geXmAP9wHqFaLEkb1L7pISuWru9m5iAtZXN73Pi+/W8+O65JngD+N159+jmySOYM
dI598nF+bAxmL/7wfG7+txE5wUBCnwg=
=hNOu
-----END PGP SIGNATURE-----

--VutRha6zu1SZejk1--
