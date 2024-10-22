Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E082110E
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 03:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729568071; cv=none; b=WTmj37iMJ8A70mNvLRERXbAWyGsO+YjffNHDoa8ERFjWN827YIa2tm8T4Y+bdP6KSmFVZ+wm+ZN2I7xLlSLXIGdJteEBTtZUPWqtCWCpoe0bpu0YcUz8ma8X0UUI7lbfo/h5PgIO1qAHX89NYQuDT5qlNecozpJQnLmNqx+xkhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729568071; c=relaxed/simple;
	bh=dkHOLqrFoPhpYTIkJdNXjg3iS+Qlksio7TClmBcllqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nxjhipjApJ+3vepghw+bSbRVo3v/GnrlH8C6opYWF2KJ4wdFQa8U5qjvLdGcVtbequ71cglMt1jfk+EfJF4by5SebkG6oOB4dyJ39z+mTwpar1VLwkrlQXUsy/T8p/uzVDv6BWMI66PNDMaCn4+OYvie8XylfOkTNyio05Kxd0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Message-ID: <66bb101c-eb9f-4824-8766-750e58cd422e@gentoo.org>
Date: Mon, 21 Oct 2024 23:34:25 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] Update versions of libcurl and Perl
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
 git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
 <20241011074022.GC18010@coredump.intra.peff.net>
 <CAPig+cRmyZhq1qtomTFP7p7XMqrCP8-u7ah8D2+yUtrL880y7g@mail.gmail.com>
 <ZwmEDt7ftJabvMUH@tapette.crustytoothpaste.net>
Content-Language: en-US
From: Eli Schwartz <eschwartz@gentoo.org>
Autocrypt: addr=eschwartz@gentoo.org; keydata=
 xjMEZmeRNBYJKwYBBAHaRw8BAQdAYNZ7pUDWhx1i2f3p6L2ZLu4FcY18UoeGC04Gq/khqwfN
 I0VsaSBTY2h3YXJ0eiA8ZXNjaHdhcnR6QGdlbnRvby5vcmc+wpYEExYKAD4WIQTvUdMIsc4j
 CIi+DYTqQj6ToWND8QUCZoRL+gIbAwUJBKKGAAULCQgHAwUVCgkICwUWAgMBAAIeBQIXgAAK
 CRDqQj6ToWND8aB5AP9r4kB691nNtNwKkdRiOdl7/k6WYzokvHvDamXxRJ0I+gEAjZqR5V8y
 mfR3fy2Z+r2Joeqdt3CIv5IwPs64spBvigLOOARmZ5E0EgorBgEEAZdVAQUBAQdATT46Z06b
 1X9xjXFCYFxmq/Tj3tSEKZInDWTpoHQp4l8DAQgHwn4EGBYKACYWIQTvUdMIsc4jCIi+DYTq
 Qj6ToWND8QUCZmeRNAIbDAUJBKKGAAAKCRDqQj6ToWND8a2RAP40KPfbfoiZAJW5boFmFJ3G
 TUBDJRh9CWHyaPqq2PN+0wD/R07oLzfnJUN209mzi9TuTuHjeZybysyqXSw4MAxkMAY=
In-Reply-To: <ZwmEDt7ftJabvMUH@tapette.crustytoothpaste.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------cy4f29B0tVNPClnn2aDSxNe4"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------cy4f29B0tVNPClnn2aDSxNe4
Content-Type: multipart/mixed; boundary="------------aK8DoBhFtQPK8lNzYmBd1IyP";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
 git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Message-ID: <66bb101c-eb9f-4824-8766-750e58cd422e@gentoo.org>
Subject: Re: [PATCH 00/13] Update versions of libcurl and Perl
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
 <20241011074022.GC18010@coredump.intra.peff.net>
 <CAPig+cRmyZhq1qtomTFP7p7XMqrCP8-u7ah8D2+yUtrL880y7g@mail.gmail.com>
 <ZwmEDt7ftJabvMUH@tapette.crustytoothpaste.net>
In-Reply-To: <ZwmEDt7ftJabvMUH@tapette.crustytoothpaste.net>

--------------aK8DoBhFtQPK8lNzYmBd1IyP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/11/24 4:01 PM, brian m. carlson wrote:
> It is not effectively zero cost.  When I want to write a patch, I must
> make sure that it works on all the platforms we support, or my patch
> will get reverted or not picked up.  That means I have to expend
> additional effort when adding features to look through the supported
> versions of our dependencies and either conditionally check them or ski=
p
> the feature.  Sometimes I have to rewrite that feature in a different
> way, or ship a compatibility stub for a system that doesn't support it.=

>=20
> I have actually spent a decent amount of work getting things to work
> across older versions of software, both in Git and elsewhere.  The more=

> we honour the policy we have already made and agreed upon, the less wor=
k
> Git developers have to do to support adding and maintaining these
> features.


On a personal level I have a mild abhorrence of the general notion of
bumping a version requirement in order to bump a requirement. I have a
lot of sympathy for having a policy about what to expend effort on
supporting, though!

Without getting into what the git project "should expend effort to
support" (future efforts to be clear, not existing code that simply
stays in place doing no significant harm)...

This patch series simplifies the codebase in order to remove workarounds
for versions of curl < 7.56.0 -- it then documents the minimum supported
version as 7.61.0 and there are even proposals to add a version check
for that. Why? Is it currently believed that curl 7.56 through 7.60.x
are going to break as a result of the modifications to ./INSTALL alone?

Instead I would suggest documenting the minimum version as 7.56 to align
with reality.

Your general observation about respecting the platform support policy
and not making developers expend time working around ancient dependency
versions no one should be using... is something that I would say is a
better fit for, well, the platform support policy.

You could instead add a section to the platform support policy detailing
the minimum versions of dependencies which the git developers are
willing to spend time supporting. A developer working on changes which
would be onerous to backfill support for, would then have a simple,
documented, easy to find policy about when it is acceptable to bump the
version documented in ./INSTALL. The process would then look like:

- Code a new feature.

- Check the version table to see if maybe it was added basically
  yesterday in curl 8.7, or whether it is available in say, curl 7.75.

- Discover it was added in curl 7.59. Oh shoot! The ./INSTALL says we
  still support versions before that, but it's also super decrepit and
  nobody runs it anyway. But wait -- the platform support says we only
  care about 7.61.

- Shrug and grin. First patch in the series now bumps ./INSTALL to say
  the minimum required curl is 7.59, and if anyone disagrees then it's
  fair game to respond with. "fite me. The platform support says I don't
  have to care, we are making this change whether you like it or not".


The important distinction here is that in this model, the install
requirements aren't about what you want to spend time on supporting,
they are about truthfully communicating what *works* in point of fact.

Likewise, it does actually make sense to have a version check either in
the build system or the code, but probably the build system, to ensure
that the minimum required version which is necessary in order to
successfully compile the codebase is available. It doesn't change what
works and what fails -- it simply provides a clear error message.
Instead of inscrutable compiler errors about CURLSSLSET_NO_BACKENDS not
existing, you get:



Dependency libcurl found: NO. Found 7.51.0 but need: '>=3D7.56.0'

meson.build:642:7: ERROR: Dependency 'libcurl' is required but not found.=




--=20
Eli Schwartz


--------------aK8DoBhFtQPK8lNzYmBd1IyP--

--------------cy4f29B0tVNPClnn2aDSxNe4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCZxcdQQUDAAAAAAAKCRCEp9ErcA0vV76r
AQCMeCK+cy2doowc7PlfVTXovjsXM7vbMpBZgePYpuVSgQEA0dCKb9slOym7nGUyNnvyZSd0bESm
kSlCaWADClp1QAU=
=flPA
-----END PGP SIGNATURE-----

--------------cy4f29B0tVNPClnn2aDSxNe4--
