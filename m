Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD10DF49
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 19:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720812836; cv=none; b=qbp2riNKWa5KfUgSztBdiF9dx0nEU56ushRdCd0SWqIFy/s8TJCapCpc4LYXUryt4Z8WUD3KkSj7PyuGJzbw9rDzgS7CQlAK3xZiPV+2T/Oz1QB8LGha4MGmALYUFBJ0wXqqBpQyay3cciZUUQanAZq52SK3A79lQOVI1Kep77w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720812836; c=relaxed/simple;
	bh=qchjYgz6N3x0FZd8nuv22GFIqku6+GCTev2GIv/WnIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDi0KaA/EtrZf4Pzosh0eKB7Dd6OhwN6FP4hT0ecyJflWu44kv+GNZUIItXhNjaEAy0k4dDNxOgiPvm0MKHv27VpEDPLQUsA7oudVRcTDlJEBKral9X6/HdRY8GLirYSV/klOHKpM5RS4FaRJLDPWUuC9lnl87kospMfEzwgWbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=QU2ezj+y; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="QU2ezj+y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720812831;
	bh=qchjYgz6N3x0FZd8nuv22GFIqku6+GCTev2GIv/WnIE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=QU2ezj+yyWcc5uyPhGNsMPjd4WTeocfyEpNv7Ig/VrqV4T3Pljxrt1XgjfOfyz5Eh
	 VO7Z2+yO3kgRIjiAsOo9oByWDFJCAO5XbW+1DlbhFpikcE+mabvLws06oiEilEgf5Z
	 QUyw5gq5BYdbbKicT5gaXv7KW9WO5hpfFJ6vhNAEJeMk9HkEGVvVT1xLGX2iolHrJp
	 cU3pq/w4K7u41j/J9wg9qsIRXZ8GnkUeCLbwmuHHRo4x22JZNR+A2gLKB9ZVqMjSH9
	 hzwBYBzSjzuNkuzwBJqE4R/JEUWcDBeC/71odx6Y3thA17AnFueAmBgDm1xRGt7j8x
	 xKtse9d1IZT0Bjv2d4qgIUW71fo8Y0IRye8ZpOxYbWaaWmhPVR2xrqg9XzX5HQlvOS
	 xamca5mcok2nVawvCRBZBSZ8Cu8hvUSwHVa2cSYYaN6dkNigl9VJyGMZTy1E+gvgGL
	 Tnp1P/dpPxecjitmPlK7N/rw37Ix7xNbxbMu+aoyGPPbIYpu4qm
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B32DD20991;
	Fri, 12 Jul 2024 19:33:51 +0000 (UTC)
Date: Fri, 12 Jul 2024 19:33:49 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Emily Shaffer <nasamuffin@google.com>
Cc: Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: add platform support policy
Message-ID: <ZpGFHWZTWAQUXGCe@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Emily Shaffer <nasamuffin@google.com>,
	Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
References: <20240709225042.2005233-1-emilyshaffer@google.com>
 <Zo3EvvSI999ngrLn@tapette.crustytoothpaste.net>
 <CAJoAoZmq=TyQxnVJvGxqKJj7XqvOxX4osa5Q5K4=w1NMWECBOQ@mail.gmail.com>
 <ZpBbgXYQlpHZa3xR@tapette.crustytoothpaste.net>
 <CAJoAoZn+R3qhoVA=av8NMcCAJyRHOe6QTXV=pyjs80JmV0mVzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vCzVq+kTIo7a0NOu"
Content-Disposition: inline
In-Reply-To: <CAJoAoZn+R3qhoVA=av8NMcCAJyRHOe6QTXV=pyjs80JmV0mVzw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--vCzVq+kTIo7a0NOu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-11 at 23:15:35, Emily Shaffer wrote:
> On Thu, Jul 11, 2024 at 3:24=E2=80=AFPM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > Some older OSes require kernel features that aren't compiled in by
> > default, so containers are out.  For example, CentOS 6 won't run on a
> > modern kernel because it lacks whatever the predecessor to the vDSO was
> > (which can be recompiled into the kernel, but nobody does that).
>=20
> Is this hinting that we should mention a minimum kernel version for
> Linux-kernel-based OSes?

This is actually a feature that still exists in the kernel and could be
enabled for newer kernels, but because distros don't use it (they use
the vDSO instead), they don't compile it in.

I'm not sure a minimum kernel version is helpful, because most of the
LTS distro kernels backport features, like Red Hat backported getrandom
for example.  In the interests of getting to a useful agreement, I think
for now we should just punt on this and having a 10 year lifespan will
probably do the trick, and we can determine in the future if we need to
apply more stringent measures.

> > We also don't really want to be on the hook for trying to support OSes
> > Ubuntu is still derived from Debian.  It is likely that things which
> > work in one will work in another, but not guaranteed.
> >
> > I mention Debian is because it has a large variety of supported
> > architectures.  I absolutely don't want to say, "Oh, you have MIPS
> > hardware, too bad if Git doesn't work for you."  (I assure you the
> > distro maintainers will be displeased if we break Git on less common
> > architectures, as will I.)  In fact, MIPS is an architecture that
> > requires natural alignment and can be big-endian, so it's very useful in
> > helping us find places we wrote invalid or unportable C.
> >
> > The reason I'm very hesitant to require that we run everything in GitHub
> > Actions because it only supports two architectures.  ARM64 and RISC-V
> > are really popular, and I can tell you that running even a Linux
> > container in emulation is really quite slow.  I do it for my projects,
> > but Git LFS only builds one set of non-x86 packages (the latest Debian)
> > because emulation is far too slow to build the normal suite of five or
> > six packages.
>=20
> Does that restriction apply to just GitHub-hosted runners, though?
> Would it be possible for an interested party to set up self-hosted
> runners (configured via GH Actions) that are using AMD or POWER or
> whatever? (For example, I think it would be quite feasible for Google
> to donate some compute for this, though no promises).

Self-hosted runners on public code are very hard to secure.  You're
basically letting arbitrary people on the Internet run code on those
machines and make outgoing network connections (due to the fact that you
can push whatever into a PR branch), with all of the potential for abuse
that that involves (and as my colleagues can tell you, there's a whole
lot of it).  GitHub has taken extensive pains to secure GitHub Actions
runners in the cloud, and while we use self-hosted runners for some
internal projects, they are absolutely not allowed for any public
project for that reason.

I would be delighted if Google were willing to do that, but I think
you're going to need help from teams like Google Cloud who are going to
be used to dealing with abuse at scale, like cryptocurrency miners and
such.  Unfortunately, there are many people who act in a less than
lovely way and will exploit whatever they can to make a buck.

I will also note that the official Actions runner is in C# and only runs
on a handful of platforms due to the lack of portability of C#.  (It
might theoretically run on Mono, which would increase its portability,
but I must profess my complete ignorance on anything about that code.) I
also know of an unofficial one in Go[0], which I'm for obvious reasons
unable to endorse, encourage, or speak about authoritatively in any way,
but that would still exclude some platforms and architectures which
don't support Go.

> The appeal is not "because GitHub Actions are great!" for me - the
> appeal is "because most Git developers run the CI this way if they
> remember to or use GGG, and Junio runs it on `seen` all the time". If
> there's some other recommendation for self-service CI runs that don't
> need some careful reminding or secret knowledge to run, I'm happy with
> that too. (For example, if someone wants to set up some bot that looks
> for new [PATCH]-shaped emails, applies, builds, runs tests, and mails
> test results to the author after run, that would fit into the spirit
> of this point, although that sounds like a lot of setup to me.)

Yeah, I understand what you're going for.  If there were some super easy
way to get everything running in an automatic CI, I'm all for it.  I
think CI is the easiest way to make sure we don't break anything.

I think it's worth trying to get CI set up for whatever we can, and if
CI is a possibility somewhere, it becomes a lot easier to say yes.

> Should have a reroll in the next 30min, it was ready to go and then I
> got this mail :)

Sounds good.  I don't think anything in this email should affect that
reroll.

[0] https://github.com/ChristopherHX/github-act-runner
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--vCzVq+kTIo7a0NOu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZpGFHQAKCRB8DEliiIei
gQgZAP98ppijjXhH9NhrmrN3Jx8wcyGEfILH0YQhp9Vx+zDeIwD/W4OQA14cE0bm
9prdfoFScwrDW6SvFV/+JTaEor5npg4=
=x66y
-----END PGP SIGNATURE-----

--vCzVq+kTIo7a0NOu--
