Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661311118E
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CY2OJRAw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qHB5PD20"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225A7C9
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 01:10:51 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 50326320096E;
	Tue, 31 Oct 2023 04:10:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 31 Oct 2023 04:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698739849; x=1698826249; bh=0O
	wdfVUsPD5GjBBIdZIw3tLJnPAKH2BXb96fTXNLpzc=; b=CY2OJRAwMse0Od9ljt
	MG2Ja/kyO0W2ZvsQumORQMyRCAizfHOWDFNqxUbkheJAg3JSLlHCLqIBgYyOSFcY
	J/cSZ5d8tc6yCL8sbXzyEb/4HmLa9/N1EPf/e5UjAsD0QUDFPpIee6wGSV44MnSo
	hyADHIxPhDuVrTy0nx5U6sumohFTIMguWdYArhxYxpE3ZCJP4b1qba2yErsKz5Lt
	ytICm/8wb4MotiduFJwD0HRpA4/osnqR1vUFvGbg5bCmDdgEyz+f8OhAqFyQvBND
	Fi6OTMdUbZQHtFMX5IRFW657GXDUIStcU5bdN2lNWokWvxSXHTpHMNjhfYP4rH/0
	R/ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698739849; x=1698826249; bh=0OwdfVUsPD5Gj
	BBIdZIw3tLJnPAKH2BXb96fTXNLpzc=; b=qHB5PD20g0yF0cUUjlTL5EjdgB+OL
	+SoLNBo2feZKmh4zF6Na7Hh6U9+nfGRvgCn1EbKDCokZ/kE4HIqN+X2Ziauncgg2
	LLmTWRnRSOOXGcoFygbTPPBkpEp++5u/ig9lcd5qbbu/JiesqC2xjfbHHEVLLijZ
	vGOmnf2FPJx5jEfymvnW7VqtBk8oV4Rw9U/nWQ8PK7Byf1VqTGhEAxBZRODcLO2V
	V8ZLhjgCESuWj5DqyS4BLEgEbLzUOzypmnQLH5anHwBfntzzrE7Euq4QAmPDGarb
	yNnbV9PDa6/KwgKxdVJpEOepxuPIPkC6znFnxEc3Gq6gnlx57Rtmr+Mfw==
X-ME-Sender: <xms:ibZAZRSC8WdLq7Hhe2e03_H_lyNrSwH62w8aq0X8sgy79Njllz7XXQ>
    <xme:ibZAZax2GMc0jBQxLh7GKpdSJKlM-eFh-8HNfpwkkL3F-ewTxfGg54zbRIgWLSr1y
    nwN08VewyAfwdFpgQ>
X-ME-Received: <xmr:ibZAZW1n-UUc45QE7qrzzA5l3WUTYXtuBYnGqEk8dZUbWvxX7hwFNwQSww121O8vVbiQVIa2xOj2iduBXplbHfFcJAsTkDmVf-sZVYkOyh9eVQ2s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:ibZAZZBjfAEo7EDApkk8LSFawTe_GqpSlHuypOZzSdFaL7gv7zqfYg>
    <xmx:ibZAZaiIbUj1kduacSUx2Ms72tLDmRRjgVKBCf-CG4iqh_k7Lb5FPg>
    <xmx:ibZAZdq7MGvfLywOwoeIGLb2Q5zc9et10ozXEZEDjEgK1ieSALOGqQ>
    <xmx:ibZAZbsCH4jfVR04b-UxdvKF1qtdORR_1crno7ur7giqZl2RRn87Hw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 04:10:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 294f602f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Oct 2023 08:10:40 +0000 (UTC)
Date: Tue, 31 Oct 2023 09:10:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 09/12] builtin/show-ref: ensure mutual exclusiveness
 of subcommands
Message-ID: <ZUC2hhxOkWnzRWzC@tanuki>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698314128.git.ps@pks.im>
 <5ba566723e8742e6df150b12f1d044089ff62b59.1698314128.git.ps@pks.im>
 <ZUAElIb7mjoBBRcn@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uz4EilSk5sNCTtkM"
Content-Disposition: inline
In-Reply-To: <ZUAElIb7mjoBBRcn@nand.local>


--uz4EilSk5sNCTtkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 03:31:32PM -0400, Taylor Blau wrote:
> On Thu, Oct 26, 2023 at 11:56:57AM +0200, Patrick Steinhardt wrote:
> > The git-show-ref(1) command has three different modes, of which one is
> > implicit and the other two can be chosen explicitly by passing a flag.
> > But while these modes are standalone and cause us to execute completely
> > separate code paths, we gladly accept the case where a user asks for
> > both `--exclude-existing` and `--verify` at the same time even though it
> > is not obvious what will happen. Spoiler: we ignore `--verify` and
> > execute the `--exclude-existing` mode.
> >
> > Let's explicitly detect this invalid usage and die in case both modes
> > were requested.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  builtin/show-ref.c  | 4 ++++
> >  t/t1403-show-ref.sh | 5 +++++
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/builtin/show-ref.c b/builtin/show-ref.c
> > index 87bc45d2d13..1768aef77b3 100644
> > --- a/builtin/show-ref.c
> > +++ b/builtin/show-ref.c
> > @@ -271,6 +271,10 @@ int cmd_show_ref(int argc, const char **argv, cons=
t char *prefix)
> >  	argc =3D parse_options(argc, argv, prefix, show_ref_options,
> >  			     show_ref_usage, 0);
> >
> > +	if ((!!exclude_existing_opts.enabled + !!verify) > 1)
> > +		die(_("only one of '%s' or '%s' can be given"),
> > +		    "--exclude-existing", "--verify");
> > +
>=20
> This is technically correct, but I was surprised to see it written this
> way instead of
>=20
>     if (exclude_existing_opts.enabled && verify)
>         die(...);
>=20
> I don't think it's a big deal either way, I was just curious why you
> chose one over the other.

Here it doesn't make a lot of sense yet, agreed. But once we add
`exists` as a third mutually-exclusive option it does because of
combinatorial explosion.

> > +test_expect_success 'show-ref sub-modes are mutually exclusive' '
> > +	test_must_fail git show-ref --verify --exclude-existing 2>err &&
> > +	grep "only one of ${SQ}--exclude-existing${SQ} or ${SQ}--verify${SQ} =
can be given" err
> > +'
>=20
> grepping is fine here, but since you have the exact error message, it
> may be worth switching to test_cmp.

Good point. Doubly so because I switch to `test_cmp` in a later patch.
Will change.

Patrick

--uz4EilSk5sNCTtkM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVAtoUACgkQVbJhu7ck
PpSNZRAAlHQoS77YaG6VBj4NhkqcnC5u7gMGGubKkwvbrx7BS3jB7nQLmW8LQv/8
7Y15wsjGDDxvOugvi5ym1VVs2t/w3cehAz9Sxw2YKtSQKYxSuC34ZcAV7JirXRgJ
Jm+KoDG+RbOgZGwsebA9lKlHpLdp8rh7iYy7fqb5OoDms6zVe0868MeOcwxJgyfD
arK+kQ68Akdn7YSuuVY/fqnK8D++kLyvaiABAQnAoXEAnwFjo+F2yPLk1BRAhgSA
plDzNuJ5bKRCSINHHItXyneGIQfzN3vxT1Vu/kqmGOLLmbqXy+BAaCZjCdkO3yFO
tjpZ/s1NqzcJz3Bk31HdQt8ltG14GCK4VBLUGtcOGcxb7TRxyiPIzTMY+DWPpe1N
yrqak0n7tD8c5br8SzCKmKyrAtdo9eEOehBgfclkvrRU08f8f5Rw0ZiuQTSZrudQ
AHa3SbNLLIZspIGyLBFV2IxzzSq9Bq8dIH0JkkTkBSAAtLUSM4GR6WouFFN4C7AT
aXdmHPfJiYtkle1lumwZbfVWNvgeBkVMVsGqDNSJ3YNWET7FLcHFxz+K3rzBT08B
xCgK4X5ltcJFkrrgBA2R0f3UCPuayuLRn6hXcSlYnLjs0TH3EazRYWdu6vGyVK35
0EUxLTiSWeJnsGce7EVtgn94oPSCnhI0loqA55gRshH6DQvy6JE=
=sS0h
-----END PGP SIGNATURE-----

--uz4EilSk5sNCTtkM--
