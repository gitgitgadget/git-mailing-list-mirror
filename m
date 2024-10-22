Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4F4126C05
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 21:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729634342; cv=none; b=mN6mAHl6FaA1bx3FseEBDmAE4lpx9tPEM7qdyfrzGC2T3WByD8VGFjJTuGk6TfEQaziuFKKPM4luyH7xyOUcd5JgOT32OUYcIVo6LSY5NQg7bfACQmQbsRXkF9ZzRNQsKew4OH9VahdE32J0ofWsxr97qmNQGVDqNFvz/iq2FTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729634342; c=relaxed/simple;
	bh=HpKXVmEf0kVUbLr9igP/POupZJYliUdhLQPplq2yWzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+f9Oi89tUM/PRtzl/iALRyd6f3bd2/2j0rAHHqwgj3Fc22HoVq4KI5wMxCZo5oM4BwxfpfnE34tZJgthVjHgpKULISxerzMqOhrBzd0aSI9VTpXfY/KYQI7ndvmj7hZq5bqmROuwN3gS8h44kIiTzw5TbEJXJ0DRZbwky989Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=znGSTS8G; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="znGSTS8G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1729634339;
	bh=HpKXVmEf0kVUbLr9igP/POupZJYliUdhLQPplq2yWzU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=znGSTS8GSSHPfUUfva7clhdDtsijz6mX+exMu0icpjSK39eIRN5IvCemEWHOx3c7O
	 QpW2dxiEkTZzoOVDvDdnRpOvV1bb/WgwuCtbB+MdEDdJ8O/OxACM1hXG+4woiXf2S0
	 K4K8NlZHJqy8altHF6/0I7CwflBoIm3AsriasZVtCxgJdmhGg1fp5EMhC9Y+Ndlr7k
	 +4H86DFoHajf5PhmPpIfT6wOEYUIvMjc49yERpaQt+gq9IHI0eMW+XPw0mo3utXRFI
	 CWcWTanrpb+nRZsWeUAfkfNxyu2+AVN19hsxmQFYg4fgh9IF/1YpqD+s8vYvIBjTUx
	 6+Z7JgL9DxdMQWxwt2qFffUYMj7uKY5MsspjkRjuj1Aeg84U/Or7XY2QVDiNRbW66p
	 JrlT5bKY+ZxI4heS1B3syMDgvtU9uURSaUIvemcydqk7NFMh5Z6qNeQ1HlrTBLc9Wd
	 2bDjBqYmWJ6bsn+XkMxWzs+Tga2cQ9jTu+YJtl88eK9j99PTYlM
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 047D820031;
	Tue, 22 Oct 2024 21:58:59 +0000 (UTC)
Date: Tue, 22 Oct 2024 21:58:57 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Subject: Re: [PATCH 00/13] Update versions of libcurl and Perl
Message-ID: <ZxggIfymo78PhXrz@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
 <20241011074022.GC18010@coredump.intra.peff.net>
 <CAPig+cRmyZhq1qtomTFP7p7XMqrCP8-u7ah8D2+yUtrL880y7g@mail.gmail.com>
 <ZwmEDt7ftJabvMUH@tapette.crustytoothpaste.net>
 <66bb101c-eb9f-4824-8766-750e58cd422e@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RNGn6fv7pGSBOw35"
Content-Disposition: inline
In-Reply-To: <66bb101c-eb9f-4824-8766-750e58cd422e@gentoo.org>
User-Agent: Mutt/2.2.13 (2024-03-09)


--RNGn6fv7pGSBOw35
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-22 at 03:34:25, Eli Schwartz wrote:
> Your general observation about respecting the platform support policy
> and not making developers expend time working around ancient dependency
> versions no one should be using... is something that I would say is a
> better fit for, well, the platform support policy.
>=20
> You could instead add a section to the platform support policy detailing
> the minimum versions of dependencies which the git developers are
> willing to spend time supporting. A developer working on changes which
> would be onerous to backfill support for, would then have a simple,
> documented, easy to find policy about when it is acceptable to bump the
> version documented in ./INSTALL. The process would then look like:

We already wrote this out.  If it's supported in a major LTS (not
extended LTS) distribution, then we support it; otherwise, we don't.  I
plan to add some specific CI jobs to cover common supported platforms in
the future, so we actually test what we're supporting.

> - Code a new feature.
>=20
> - Check the version table to see if maybe it was added basically
>   yesterday in curl 8.7, or whether it is available in say, curl 7.75.
>=20
> - Discover it was added in curl 7.59. Oh shoot! The ./INSTALL says we
>   still support versions before that, but it's also super decrepit and
>   nobody runs it anyway. But wait -- the platform support says we only
>   care about 7.61.
>=20
> - Shrug and grin. First patch in the series now bumps ./INSTALL to say
>   the minimum required curl is 7.59, and if anyone disagrees then it's
>   fair game to respond with. "fite me. The platform support says I don't
>   have to care, we are making this change whether you like it or not".

This is the approach we used to have, where we'd accept patches to
support older systems if they weren't too invasive.  It involved lots of
heated discussions on the list that were unproductive and never came to
a conclusion, and they'd repeat with some frequency.  That's why we have
the policy we have now: because it's clearer and more definitive and
arguing extensively about what we were supporting was not in the
interests of a healthy community for the project.  It is also more
honest in that we're clearly communicating to users whether they can
expect things to work out of the box or whether they'll need to carry
custom patches on their own.

Overall, people don't update the INSTALL documentation and it's
routinely out of date.  Should they?  Yes, but practically they don't,
and we don't test that, so we don't know if it's accurate.

> The important distinction here is that in this model, the install
> requirements aren't about what you want to spend time on supporting,
> they are about truthfully communicating what *works* in point of fact.

While this sounds nice in principle, it doesn't work in practice.  We
don't test things like MIPS or UltraSPARC hardware because we don't have
CI systems that use that hardware and they're extremely slow in
emulation, but we do want to support them if they're on an otherwise
supported OS.  Similarly, we probably do want to support NetBSD, but
have no tests for it.

We also don't have situations where, in general, people are willing to
compile their own set of software from scratch.  For example, I'm not
compiling an arbitrary libcurl version to test a problem on the list.
With very few exceptions, the versions people use are tied to their
distribution or vendor.  If someone asks to support libcurl 7.19, we
either have to custom compile that to test or try to run CentOS 6, which
no longer runs in a Docker container on a modern kernel and has no
security support, so practically the answer is no.

So we don't know for certain what does and does work, but we do know
what we're willing to fix and support.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--RNGn6fv7pGSBOw35
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZxggIQAKCRB8DEliiIei
gUBvAQDH40GnsxhOp6S8LBlk6aHawi/xm1XpE5g7zT3fv7KUPAEA8+/FJ7vjus+S
JuovLfwjXUMsLHqUPqdfIJTNppWP+ww=
=8lj/
-----END PGP SIGNATURE-----

--RNGn6fv7pGSBOw35--
