Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7531F94A
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 21:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761859415; cv=none; b=h/USNZtXSILtYgenb1Sz3ixwkA+fd+Q4TPFxb13UXNKx7FyjIMlnZu5HXEPCIfvKN5I2g9VSIUezLd88dVhhj0T8Ghj2SYsCWTWVP3w11+Hx8raGatCsyZVpiCB+pCFW1E14AGyQleb/RLzspefVwHzAbrL4dkzuw+1lY4kSwY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761859415; c=relaxed/simple;
	bh=jDzmGi2OH9dQYI9C5dSkeL224t9y8Gv+cyfd2n31XF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V28VS5I2wTGkAINwpxEalBv3W9NNse0DyRHhPm2vkpDhKRXbt3an0UzyZX98/xZiNttdh61xRDIXynMYiCLo3qCyt4MtsLVWgfyZEy2E0Jr2ll7b30/vhIRwJvP/mdMXaPS+II/ifAsgoo91DXu8FEmyRxODuVWWfTmSE1/F68Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=tu9AOQhm; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="tu9AOQhm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1761859405;
	bh=jDzmGi2OH9dQYI9C5dSkeL224t9y8Gv+cyfd2n31XF0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=tu9AOQhm3LETSuFada5QRo1KOpbJys1hsx6u5G40dNetD8e8UcD6SWhqMfZP5RmwB
	 dpk2Y00qmar9hgN4VIO+WBcugNyGygM92XWBwn3vEYSIPvVtmdQJJ3zQNgikUjDKm3
	 BxTFPqCy9kn2iSPbf6S2qxAg+Iu207wNu/2qtrHEoNiwM0hkvEaTg/8sx5ak6u6Gi1
	 zTTkWQMBzdSO1/PfTMYprOop/rP3463PucnoooSmPK+lPQ03Cn/PPjtP14qinymaGx
	 R4UO6AbdoiWIBao5Sw2Lt+jN0gv7onqPSUWj1nifdY8Vz/8o16AseYo8AO4CpvNTAk
	 sr2oj2lupCtf3vX5emHPmSpNTlHwgP1XPmmsuRo4LSX0qdTc4AzZGjMefHVPxA44dQ
	 +zT1WMK4k+9zxLFgTkbzEmNCaiB4qbvMcC+/44qEYNP5xgX5E8fhGcaT6j9PYgJWF3
	 DG42bNLW3TN2wbbQvT6RlE8w2gAWGp1ixp+7F4hHSKaGLN5LmXB
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:bbe9:68f3:1302:8e3b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 2284C20036;
	Thu, 30 Oct 2025 21:23:25 +0000 (UTC)
Date: Thu, 30 Oct 2025 21:23:23 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: rsbecker@nexbridge.com,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	git@vger.kernel.org
Subject: Re: [BUGS] Git v2.51.2 on NonStop
Message-ID: <aQPXSyyHWz8hKaJe@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"D. Ben Knoble" <ben.knoble@gmail.com>, rsbecker@nexbridge.com,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	git@vger.kernel.org
References: <xmqqo6psjq2n.fsf@gitster.g>
 <000d01dc4831$ff049500$fd0dbf00$@nexbridge.com>
 <aQKVByfUdYHSEcDz@szeder.dev>
 <000201dc4925$2cdbc450$86934cf0$@nexbridge.com>
 <aQKgxfZ9WQjyrhpa@szeder.dev>
 <000701dc4933$9f79c670$de6d5350$@nexbridge.com>
 <CALnO6CAYmtDmfk36nX6TCCaV2c=8J0BXv9eN+L=j1PU=gPmJUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dEmxL2VcuRnGInpz"
Content-Disposition: inline
In-Reply-To: <CALnO6CAYmtDmfk36nX6TCCaV2c=8J0BXv9eN+L=j1PU=gPmJUQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--dEmxL2VcuRnGInpz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-30 at 13:52:34, D. Ben Knoble wrote:
> On Wed, Oct 29, 2025 at 8:25=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
> >
> > What appears to be happening is that the Make environment is only using=
 SHELL=3D/bin/bash
> > for the outer processing but not the inner #!/bin/sh of t7900. The syst=
em is using /bin/sh
> > as specified, which uses ksh, not bash, which is the trace above. When =
I run the individual
> > tests with bash, the error reported goes away. The problem is, with my =
version of Gnu Make,
> > 4.1.2, the SHELL variable is only being replaced for the command proces=
sing of each
> > recipe. Once the system loader sees the shebang of #!/bin/sh, /bin/sh i=
s used as requested,
> > and fails out. This means that I have to remember to manually run each =
test that fails with
> > bash instead of the default. It is frustrating and now adds hours to my=
 manual evaluation
> > of the CI/CD results.
> >
> > The trace above is from sh, not bash because of this.
> >
> > With Frustration,
> > Randall
>=20
> Is this the only ksh-induced failure? And if so, what is inducing the
> failure=E2=80=94is it something the test library can work around, or is t=
he
> system {k,}sh not behaving portably here?

We know that AT&T ksh (ksh93) doesn't work for Git because we require
`local` and AT&T ksh doesn't offer that.  Other ksh implementations,
such as pdksh, mksh, lksh, OpenBSD's ksh (which is also its /bin/sh),
ksh88, and various others, do in fact work just fine because they
support `local`.  The `test_subcommand` function does use `local`,
so that may explain why things aren't working.

ksh (and zsh in zsh mode, but not in sh mode[0]) also run the last command
in a pipeline in the main shell instead of a subshell.  That may also be
a source of incompatibility.

It may also be failing to work for other reasons as well, though.

[0] To be clear, zsh has never successfully run our testsuite in zsh
mode, but it should mostly work in sh mode.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--dEmxL2VcuRnGInpz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaQPXSwAKCRB8DEliiIei
gUW3AQDZmd8pVQKCTFZRDhpolA7fMs768rQ7xXPNLxmrYUw7AgD+Njjl84TfxTjG
NNsMwJWk+/2J8DB/LTLcOcBFhoB2+Qo=
=yFvt
-----END PGP SIGNATURE-----

--dEmxL2VcuRnGInpz--
