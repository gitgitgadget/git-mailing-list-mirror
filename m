Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC81012B9E
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dJjFqL6j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AygVf9dL"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD110DA
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 03:15:40 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id C48E932009A1;
	Mon, 23 Oct 2023 06:15:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 23 Oct 2023 06:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698056139; x=1698142539; bh=1L
	RL9KJkQwyKCBMW4AVD8a3qSWXrCXPGCKMILaQTpWw=; b=dJjFqL6j1TjlAzUQrf
	P+BQGsA2jUWL89r3Rg5TTWwE+MAwKzQ6CyfK3cZT5uYZVR9SRMcmLyXBmQZ4dbhD
	/93i5qrJUNC8NgLSjveh6mB58ZpGeE/Y9iTqXSu/SzMi3mJl6ZFK6yicR9OeA/qn
	r+L5LkNK3t1Ifb2M4738kfUgVyCikD+20rqY0EyL5YFU1SH6TTm9kLL/fSI+mj68
	uUahfQ1vFaOMbLcUc/gXC0HekgbxcRk949wE1sAPhMliwqHs1z1miwPhIRbyrvnk
	C+29qEHwLXv7f5Sl4MU8o9fC6mJ7U86QevOwGIJ3puBteWsCkKzvzl17SbCg/9zs
	BqWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698056139; x=1698142539; bh=1LRL9KJkQwyKC
	BMW4AVD8a3qSWXrCXPGCKMILaQTpWw=; b=AygVf9dLfAJWYlFdzGNqsQkWjAQ6i
	/j98wOyQAVdp1jx5puiCh9U1onJbRrYc0PrrOe5dNi53KIhh3ufFm7H3qAFBpQ/h
	44id04d8/AT9dlBQyiUnvJPNgEsHjCG20S1N9ubohp0cdc4Ue9IsZHxj2MKf5AV1
	cqRQtMg5UK4IG6xzrc6FBk+RjwPm3IIVDamMNTWPvRcB89CcZWvXGpko5YwLtPNY
	h8xm9Bory+nFKJahZ//asmCrBx19lng0DB9DFC4da/Thrthc00xlGYvqrG8EW1ev
	bR6Ud4Q+YdY2tmuECjFoYAMjw+KwWhCYEQaOtFyROBNgHRsyVVr1HFx+g==
X-ME-Sender: <xms:y0c2ZakX-m5qy3jIOKlM8lMtnD4ADVAn8tmKT3_aiu032_qYJEvlVg>
    <xme:y0c2ZR0FgJcO7bWeSQ-KGOnHtZ0k9QwG5EMlvDr8aAee_u9k8NNuen_b4OPihRoaH
    Z6yUa9glmzXu4PigA>
X-ME-Received: <xmr:y0c2ZYqTNlqx6jegf52fVOdccyLNKYp87C5CcS-0sZJBkwQrehrFovlbmUmIHWPQxi_FpxH-CJLesavrU2nSFX6bzfH67jBkUp-M5H3Q2-ot>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeigddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:y0c2Zek55mWoIP9HWQ6jLZGw75Bxb3HFJOFSo9DTCiAawuzqV5uWrQ>
    <xmx:y0c2ZY3CHeg7qbMdRIP-foZrD8gTsOeZrlYEj85Y4whJL6ktOWfYUQ>
    <xmx:y0c2ZVsgWbJHFDrzv4CNgkAycC2TKX1Tgv6_J_PhzMoeYX4tKQrwfw>
    <xmx:y0c2ZVwWZXAJXA-xQjCxaZ19nxhOZvfJM6MqhsUYNqybre3fAB7obw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 06:15:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 56c62659 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Oct 2023 10:15:33 +0000 (UTC)
Date: Mon, 23 Oct 2023 12:15:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] commit: detect commits that exist in commit-graph but
 not in the ODB
Message-ID: <ZTZHxh4v0_fKkZpg@tanuki>
References: <ZSkCGS3JPEQ71dOF@tanuki>
 <b0bf576c51a706367a758b8e30eca37edb9c2734.1697200576.git.ps@pks.im>
 <xmqq1qdy1iyr.fsf@gitster.g>
 <ZS4rmtBTYnp2RMiY@tanuki>
 <xmqqjzrlhzci.fsf@gitster.g>
 <ZTDQjangLsQ1cSJl@tanuki>
 <ZTDn-Wd5xsFrBmqI@tanuki>
 <xmqqzg0ey1kn.fsf@gitster.g>
 <20231020100024.GA2194074@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6F7ZeGBC/8Z9zyO4"
Content-Disposition: inline
In-Reply-To: <20231020100024.GA2194074@coredump.intra.peff.net>


--6F7ZeGBC/8Z9zyO4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 06:00:24AM -0400, Jeff King wrote:
> On Thu, Oct 19, 2023 at 10:16:56AM -0700, Junio C Hamano wrote:
>=20
> > Patrick Steinhardt <ps@pks.im> writes:
> >=20
> > > There's another way to handle this, which is to conditionally enable =
the
> > > object existence check. This would be less of a performance hit compa=
red
> > > to disabling commit graphs altogether with `--missing`, but still ens=
ure
> > > that repository corruption was detected. Second, it would not regress
> > > performance for all preexisting users of `repo_parse_commit_gently()`.
> >=20
> > The above was what I meant to suggest when you demonstrated that the
> > code with additional check is still much more performant than
> > running without the commit-graph optimization, yet has observable
> > impact on performance for normal codepaths that do not need the
> > extra carefulness.
> >=20
> > But I wasn't sure if it is easy to plumb the "do we want to double
> > check?  in other words, are we running something like --missing that
> > care the correctness a bit more than usual cases?" bit down from the
> > caller, because this check is so deep in the callchain.
>=20
> I wonder if we would want a "be extra careful" flag that is read from
> the environment? That is largely how GIT_REF_PARANOIA works, and then
> particular operations set it (though actually it is the default these
> days, so they no longer do so explicitly).
>=20
> I guess that is really like a global variable but even more gross. ;)
> But it is nice that it can cross process boundaries, because "how
> careful do we want to be" may be in the eye of the caller, especially
> for plumbing commands. E.g., even without --missing, you may want
> "rev-list" to be extra careful about checking the existence of commits.
> The caller in check_connected() could arguably turn that on by default
> (the way we used to turn on GIT_REF_PARANOIA for pruning repacks before
> it became the default).

Good point indeed, I also started to ask myself whether we'd want to
have a config option. An environment variable `GIT_OBJECT_PARANOIA`
would work equally well though and be less "official".

What I like about this idea is that it would also allow us to easily
unify the behaviour of `lookup_commit_in_graph()` and the new sanity
check in `repo_parse_commit_gently()` that I'm introducing here. I'd
personally think that the default for any such toggle should be `true`,
also to keep the current behaviour of `lookup_commit_in_graph()`. But
changing it would be easy enough.

I'll send a v2 of this series with such a toggle.

Patrick

--6F7ZeGBC/8Z9zyO4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU2R8UACgkQVbJhu7ck
PpRsRA//RvqUW5TTIsAMJZeGY1wtpKJBVx6otxRG8FAeKlbrtbB8IKLoeSnnbEGa
CcwGkRyK1YeGBZcOrwRtegsdsZmuR/+JgG6aazFipNmSTo3T2zxidqQxNwtfGegT
swcqPGmSMNV6SCga8mkIZV6I3SjFI3mNq6JsMnpggznL2jJCvTvSARn4KYXzhkyU
UGhumVAzB0pLp0mS/4af0U+p5oCb6q/3sVrpNVtDQI+dZBBYyPtgA37hFCbGhfXt
3GZQqLOaV0tvBwq48pBvT0SBaW2UI2bwuGCMGaMCe0HOUUZprf6HnBk9Jar7cpDY
7xzDaHF26ot323Z2r8WomuWkXJnkPiNM82SHWnH9U03ey0noxSTh7idwQuMOR9aK
drZIwfNMM5Rz9Rz5A0J1hWiE9HaAilxvNR/Xs4CLbcSUEatfZO/YPXPREDUapqWN
DbVRWhQt5EzheoFwc7TniWomO8+e+zlyLSqsFjIxmg2Z8S4ha1Tcczs7crcgMZNu
YzauDHQySkibgtcB9WGy+/lA6o4coTnoarPXdH7WXkuzaJlILKfMybMEb38uEJV2
i4+k/dBlFiPFhzkbWRznFSaidH0nd3KsnwUy88ykLKBGx0+31orZ8QtmScoFziXu
Bpr4U1Q5R9W30SdJBjIwyFy+AmToTsqZYOo0uPZEkUbVR2cVcNE=
=5hbV
-----END PGP SIGNATURE-----

--6F7ZeGBC/8Z9zyO4--
