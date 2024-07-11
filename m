Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AA71A0711
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 22:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720736654; cv=none; b=nxuW0ZFF0CP7qTABCOXFHppBNMHK/GXdmhqb11bnm/ISWEHAEmq+9GoNea50n1fnBsS0aERUKbmxqSJf5WoO1j6jX0RW0L9jmVPJpkDppkWsIxnbrcqAMHO68uEZZ3bj7wtUtrHCBBsPnVPS8ae5xd1Sr8BagiCtU5l/UficLws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720736654; c=relaxed/simple;
	bh=IKmoiABPwZj/vA+TLdP4aFc6B34dM9hJoBUQafRZg+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uS2s1BHqiAJxnekmVG7h9KALKdcfAcdz9S+EYfl1d2WpvsKaycog50/fFN52BjKRgkklm5LnHH7j7jeT8X4NP+HT4GjZudIQ08sCWXOvYmwgk26KMfzsCVYBGxxq/5iCQ+MFw+fINQgxdthH0wImxssBAtPOPtabQCmPmGpoE+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=z0KP3gjr; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="z0KP3gjr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720736643;
	bh=IKmoiABPwZj/vA+TLdP4aFc6B34dM9hJoBUQafRZg+U=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=z0KP3gjrGzn6LY0cCIonU+9iUP+LZ18G/424IedDmT2Lnni+lCc+D2UTuHQwLOcf3
	 L1lCEuJKmiwr6D238H7fvprQch5cNKP8wnbjSaGBRMYcgEasuzPLIw1sg7Ii9xFRRa
	 m4lgmLUskJ+x/cGVAf8pBObXBbRbn58If5N3NTlhXA4FiK8fP73+DFeyI9G3D6OV7q
	 kRzByxZ1MuWjUdpfafBMc8dgFibyzlGSIFmNS1w9s5nJMgrZZ2KB8uqUoDPRXJ7C1f
	 HaOyANU822kn4xl4lnq4dROwKg4GHIDVq3I+FlIzaYFSFpMKqBY8ZqnrJqTnnuBWTz
	 UAj6004XppQsuzgHi7f9ApKBzqZq/3TJ2KmA2dE1lyZd6/cQFO+Pi7Vd6YQg3xnUO/
	 yF2Bq9jSc8IEH7Csbm9HBcpUwJ0VFM4BdAGucQ7k5d53ddr2E9JNQJq/iJdVI/uT1T
	 3JtFQE5ReEeY539ROvxCZBybZdt+m7Lfia/q/Vey2eZV3Oyw4IA
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C92A720991;
	Thu, 11 Jul 2024 22:24:03 +0000 (UTC)
Date: Thu, 11 Jul 2024 22:24:01 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Emily Shaffer <nasamuffin@google.com>
Cc: Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: add platform support policy
Message-ID: <ZpBbgXYQlpHZa3xR@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Emily Shaffer <nasamuffin@google.com>,
	Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
References: <20240709225042.2005233-1-emilyshaffer@google.com>
 <Zo3EvvSI999ngrLn@tapette.crustytoothpaste.net>
 <CAJoAoZmq=TyQxnVJvGxqKJj7XqvOxX4osa5Q5K4=w1NMWECBOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QT092aCG9M/JPXVI"
Content-Disposition: inline
In-Reply-To: <CAJoAoZmq=TyQxnVJvGxqKJj7XqvOxX4osa5Q5K4=w1NMWECBOQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--QT092aCG9M/JPXVI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-11 at 18:14:36, Emily Shaffer wrote:
> On Tue, Jul 9, 2024 at 4:16=E2=80=AFPM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > I think it's also worth discussing what we require from a platform we're
> > willing to support.  For example, we might require that the platform
> > pass the entire testsuite (ignoring irrelevant tests or tests for things
> > that platform doesn't use, such as Perl) or be actively pursuing an
> > attempt to do so.  We may also want to require that an OS be actively
> > receiving security support so that we don't have people asking us to
> > carry patches for actively obsolete OSes, such as CentOS 6.  Finally,
> > some sort of time limit may be helpful, since some Linux vendors are now
> > offering 15 years of support, and we really may not want to target
> > really ancient versions of things like libcurl.
>=20
> I sort of wonder how much of this is taken care of by expressing
> "fully supported" as "can run in GitHub Actions". Even if an LTS
> distro is 12 years old and using ancient curl, will GitHub still be
> able to run it in a VM/container? Maybe there's no such guarantee,
> since you can hook up self-hosted runners (which sounds more appealing
> if someone's got something weird enough it doesn't run well in a
> container).

Some older OSes require kernel features that aren't compiled in by
default, so containers are out.  For example, CentOS 6 won't run on a
modern kernel because it lacks whatever the predecessor to the vDSO was
(which can be recompiled into the kernel, but nobody does that).

We also don't really want to be on the hook for trying to support OSes
that get no security support.  We don't want to be running an OS
connected to the Internet that has known root security holes, even in a
CI environment, so I think _someone_ should be providing security
support for it to their customers or the public free of charge.

I also want to let us use new features from time to time that may not be
able to be conditionally compiled in (such as new Perl features), so I
think maybe setting a hard limit on a supported age of software might be
a good idea.  If we want to have good support for LTS Linux distros, we
could set it at 10 years initially.

Also, if we do decide to adopt Rust in the future, we'll need to
consider a different lifetime policy for that.  I try to support an old
Debian release for a year after the new one comes out, which is about
three years for a compiler version, but anything older that that becomes
a real bear to support because most dependencies won't support older
versions.  Since we're not using Rust now, we don't have to consider
that at the moment, but it's a thing to think about when we're
discussing policy since different language communities have different
expectations.  We might find that we need different policies for, say,
Perl than we do for C.

> """
> Minimum Requirements
> ------
>=20
> Even if tests or CI runners are added to guarantee support, supported
> platforms must:
>=20
> * Be compatible with C99
> * Use curl vX.Y.Z or later
> * Use zlib vA.B.C or later
> ...
> """

I think to start off, we could say that it has to have C99 or C11, that
dependencies must have been released upstream in the past 10 years, and
that the platform and dependencies must have security support.

I mention C99 or C11 because Windows _does_ have C11 but not C99; they
are mostly compatible, but not entirely.  FreeBSD also _requires_ C11
for its header files and won't compile with C99.  I think the difference
is small enough that we can paper over it ourselves with little
difficulty, though.

> > At the same time, we do have people actively building Git on a variety
> > of platforms and a huge number of architectures, including most Linux
> > distros and the BSDs, and we will want to be cognizant that we should
> > avoid breaking those environments when possible, even though, say, the
> > porters for some of those OSes or architectures may not actively follow
> > the list (due to limited porters and lots of porting work).  I imagine
> > we might say that released architectures on certain distros (Debian
> > comes to mind as a very portable option) might be implicitly supported.
>=20
> Are they implicitly supported, or are they explicitly supported via
> the GH runners? Or indirectly supported? For example, the Actions
> suite tests on Ubuntu; at least once upon a time Ubuntu was derived
> from Debian (is it still? I don't play with distros much anymore); so
> would that mean that running tests in Ubuntu also implies they will
> pass in Debian?

Ubuntu is still derived from Debian.  It is likely that things which
work in one will work in another, but not guaranteed.

I mention Debian is because it has a large variety of supported
architectures.  I absolutely don't want to say, "Oh, you have MIPS
hardware, too bad if Git doesn't work for you."  (I assure you the
distro maintainers will be displeased if we break Git on less common
architectures, as will I.)  In fact, MIPS is an architecture that
requires natural alignment and can be big-endian, so it's very useful in
helping us find places we wrote invalid or unportable C.

The reason I'm very hesitant to require that we run everything in GitHub
Actions because it only supports two architectures.  ARM64 and RISC-V
are really popular, and I can tell you that running even a Linux
container in emulation is really quite slow.  I do it for my projects,
but Git LFS only builds one set of non-x86 packages (the latest Debian)
because emulation is far too slow to build the normal suite of five or
six packages.

And it's actually much easier to run Linux binaries in emulation in a
container because QEMU supports that natively.  Most other OSes must run
a full OS in emulation, which is slower.  There also aren't usually
pre-made images for that; I tend to use Vagrant, which has pre-built
images for x86-64, but I don't really want to be bootstrapping OS images
other architectures in CI.

So I'd say that we might want to consider supporting all release
architectures on specific OSes.  I think Debian is one of the more
portable Linux distros (more portable than Ubuntu).  Debian has also
abandoned some architectures that you can't buy anymore, like Itanium,
so that might be a reasonable limit on how far we're willing to go.

> (By the way, I think we should probably just add a BSD test runner to
> Actions config; we test on MacOS but that's not that closely related.
> It seems like it might be a pretty easy lift to do that.)

FreeBSD and NetBSD are pretty easy.  I won't 100% commit to it, but if I
find time I'll try to send a patch.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--QT092aCG9M/JPXVI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZpBbgAAKCRB8DEliiIei
gRGIAP4z5W3jz7DhohIjltRpiBmMDr7HMEsZ1MmfiQurX/rkjQEA8JVjqhEBIFbl
/vHu5aVJEdXtGqgRHi+NvMCmTrhUcwc=
=MmOI
-----END PGP SIGNATURE-----

--QT092aCG9M/JPXVI--
