Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8DA14F6D
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 08:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kdWGN5RR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IMSqwP7z"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F7410F
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 01:25:34 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 1F31C5C02DC;
	Thu, 19 Oct 2023 04:25:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 19 Oct 2023 04:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1697703934; x=1697790334; bh=jA
	22UXqLHHVXEWBojAH26oD/K3VzUYd1P+Y6BagLsLU=; b=kdWGN5RREa8H6hyS7G
	u/Bzdm2bQgShXXeu68YSTyD5j+a1Yuk6shDWtrhxemhEcnqtQj0LZfRQfcZufg1/
	QK3fh4AvUHraEoPZ1i7mTlQI06qCUgwOvu0q6R1eQmb4te2Gk2XGyFQdKOrsmAiE
	X9t9QPo36EVZEwUTI4thNgyEcgPO/9AdO1jaq0oPXiEVSTI1n+FrkABpp739cpcc
	vTtPpANOXNM+di2kEm2Ub530Vzviq1d5I0MIJJKrS77oiFoGyLaQ7bc09F7wZaR8
	Bewz0q1fTvA4k+c/WcopMcegPLeuYCM+ZhAaFQBbDrxuQ9foJTol7JYuUPRL7X2V
	TrWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697703934; x=1697790334; bh=jA22UXqLHHVXE
	WBojAH26oD/K3VzUYd1P+Y6BagLsLU=; b=IMSqwP7zZ22szi5b1q7F8QRGK+e3L
	4Q8tq/3vDVHF+4RkQfLm26Waln+jEZoW0L0abZexgNXHcHwrMzL0Jw28pk0Fopsl
	Hd5OSy59pnhEw1sCGZU2gKRUvUHdJWUvoh1EEiLac+KyuumwdZXhCLIu/QJFgUh0
	aMEQp8XtKMQCCTO5UNanD4Ecye5xjnopA2DRiwExhgWQ8pEuv7FMpjrLSb1mrajW
	+qVtS6SV/AhPEiiqEhZ8XDKlglO3LTXrz+YyzQhRjrJYCMyQg5NEfkg4gVbr8hJS
	ZKsiiue46Y4qy3tu3LIzx++HECLw8z6zIPeO91wgkoYKcEg2QS59cuSxg==
X-ME-Sender: <xms:_ecwZfiRYjrqu5Rl-See3AvSi1JtCzlweHBGD0tjVkwzl0970n5weg>
    <xme:_ecwZcASs1NSHYMFqDn-d5MYcENRGcfieE-Z46eDPyj8HtsioCRHEfjfciTN-PokE
    E9T24IAK38AgIhIxQ>
X-ME-Received: <xmr:_ecwZfHTd0biDMWJcj-AeFuNcHh9UtllxZo0fgCN_Nb4vtizV5o9rIFbq2Eq2d_OCx_hsOSMhsxWFRKvkKE1qu8gMOCdWtdF-pZi3Dj7bX912A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeeigddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:_ecwZcQvf06XVsFlcjz6vo0h2pugaQTtLEaEwejHx3paDnhLJcj_vA>
    <xmx:_ecwZcwyBe4bAON7Iruv8Ic22q3jNcHQTkRhhFXNE_SyRaQLekcmRg>
    <xmx:_ecwZS6F0EAsRHICOMYo1bEdYKYIolSygEZFhY2lisSuucZdSNyLsA>
    <xmx:_ucwZX9Nf7HdJjRNh6ZF2XpQtsGXHlSYYMNJ5shxD7_ZvAYs_BC2Bg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Oct 2023 04:25:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3fc88290 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Oct 2023 08:25:27 +0000 (UTC)
Date: Thu, 19 Oct 2023 10:25:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] commit: detect commits that exist in commit-graph but
 not in the ODB
Message-ID: <ZTDn-Wd5xsFrBmqI@tanuki>
References: <ZSkCGS3JPEQ71dOF@tanuki>
 <b0bf576c51a706367a758b8e30eca37edb9c2734.1697200576.git.ps@pks.im>
 <xmqq1qdy1iyr.fsf@gitster.g>
 <ZS4rmtBTYnp2RMiY@tanuki>
 <xmqqjzrlhzci.fsf@gitster.g>
 <ZTDQjangLsQ1cSJl@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nrpdo2SARCRdayQR"
Content-Disposition: inline
In-Reply-To: <ZTDQjangLsQ1cSJl@tanuki>


--nrpdo2SARCRdayQR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 08:45:34AM +0200, Patrick Steinhardt wrote:
> On Tue, Oct 17, 2023 at 11:34:53AM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> >=20
> > > Fair point indeed. The following is a worst-case scenario benchmark of
> > > of the change where we do a full topological walk of all reachable
> > > commits in the graph, executed in linux.git. We parse commit parents =
via
> > > `repo_parse_commit_gently()`, so the new code path now basically has =
to
> > > check for object existence of every reachable commit:
> > > ...
> > > The added check does lead to a performance regression indeed, which is
> > > not all that unexpected. That being said, the commit-graph still resu=
lts
> > > in a significant speedup compared to the case where we don't have it.
> >=20
> > Yeah, I agree that both points are expected.  An extra check that is
> > much cheaper than the full parsing is paying a small price to be a
> > bit more careful than before.  The question is if the price is small
> > enough.  I am still not sure if the extra carefulness is warranted
> > for all normal cases to spend 30% extra cycles.
> >=20
> > Thanks.
>=20
> Well, seen in contexts like the thread that spawned this discussion I
> think it's preferable to take a relatively smaller price compared to
> disabling the commit graph entirely in some situations. With that in
> mind, personally I'd be happy with either of two outcomes here:
>=20
>     - We take the patch I proposed as a hardening measure, which allows
>       us to use the commit graph in basically any situation where we
>       could parse objects from the ODB without any downside except for a
>       performance hit.
>=20
>     - We say that corrupt repositories do not need to be accounted for
>       when using metadata caches like the commit-graph. That would mean
>       in consequence that for the `--missing` flag we would not have to
>       disable commit graphs.
>=20
> The test failure that was exposed in Karthik's test only stems from the
> fact that we manually corrupt the repository and is not specific to the
> `--missing` flag. This is further stressed by the new test aded in my
> own patch, as we can trigger a similar bug when not using `--missing`.

There's another way to handle this, which is to conditionally enable the
object existence check. This would be less of a performance hit compared
to disabling commit graphs altogether with `--missing`, but still ensure
that repository corruption was detected. Second, it would not regress
performance for all preexisting users of `repo_parse_commit_gently()`.

Patrick

--nrpdo2SARCRdayQR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUw5/gACgkQVbJhu7ck
PpR00g//UWNwcn31EESOB0EPLlQHbh9qOYRmY1LeOEbpUnDGK4gLpITkl99+fNQQ
PSabm6ki0snIIASXDu6vhsCagj7h5qLV0PBu59ImGgdyoYv/nhs6UrqaanmjHC2T
1rcGJnk3AfE+2/9S8pat5RpJcThRpb+Jlk8+enhE/MPgg9awVcMZ3216HQiOrx+9
4zy/n7gZcZYZRn6NMDOIstm6KGq5ea7jMxxXZ2GrSG/p3spxKTDZ38oTouJxO4+0
PkIi1yOW9CVylkfperLrmab+b8BWCDXt+L928i32vq32T/jpkACO1r0iRNbH2t0X
pwbcAg3Wenlrb5kFd0In0b7UN/2odGmHHxnDzBMI58QmRqdyZGsx/KK9dYl0Alc0
Aw+NcQg8oiJKjrO/0N6GyxQGFCCZxIlRBvwaY24b0kfC6T4TYc7DC1zw8+ZpNNeo
jZ8+Pk+Z5+/GoREROVo6Amkuw0062RPPwcaXLqhxF8t8heljnthSpjVJUnzbWGU8
6IHBxrrBWZZxUIIiykkRlT6Z58j9HZubFLoZ2qTSAJ7V4TQtxRlWh3JYvXzItrkK
3gliZNdz5xbQQUr3ic227Opfc77guJ4m6O6z7qvjyRReksNuUnVAi9dhpenL0lkS
RvpN5aj9PWmjUZUOZ6+AYdCBOV4xM4VpQnlhiQCLs/WRjZLX66s=
=nfmC
-----END PGP SIGNATURE-----

--nrpdo2SARCRdayQR--
