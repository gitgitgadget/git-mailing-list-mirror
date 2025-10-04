Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0B122FE10
	for <git@vger.kernel.org>; Sat,  4 Oct 2025 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759599098; cv=none; b=AkGXAxu9E7Yqs7ySaOIq9Nh1q3VI20Fpv3tCcHY9WmLe4t04xvWEbBkcBNR1fp46egtbXZwcknyjFtxEnyA6FPw5jLUN7KtG05e9TH5bUfM2fflimmYcVwxvWIFtekPoPzTkwQCPDPaj5bSkchcg+vDPl3r90KB8GJLZYhdpLNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759599098; c=relaxed/simple;
	bh=KsMLYPgc2/yLFXWW/ge6UTp/n4VO/N6M5Uyzc3K3bTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p036QXUeTwa/KvM0X4feOVhG9XWQtOU0vicavD8Tj3R35YY/SP3qFqIehzAQIMYzHKv+ok1Vm1CLEDRe/1vmHZrrJVfRyWjiGwHHBveSBI2/aNeo0eOZW+HlDzJ4bJQQSy/hm+4zJND9CtVSpKS8nym8R4l209w2Ca5NnP75X4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=S1Z7aMix; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="S1Z7aMix"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:aa96:44a8:d440:4f40])
	(Authenticated sender: jn.avila@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 23B172003E8;
	Sat,  4 Oct 2025 19:31:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1759599093;
	bh=KsMLYPgc2/yLFXWW/ge6UTp/n4VO/N6M5Uyzc3K3bTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S1Z7aMixB2fQGUTVkj37YgkEI5IYiJb0AXLcXfaeKKl+f/mR0UESRo2LTMwwWW3ja
	 sXNM1bHBBwViR/Lk6IGntPNBmjz75aGDID0YTLzl5FifIF97IFDz7T54pL/sGDx7Jw
	 rmUvguZ8i8lLNc6JAj0zaxHZlDCN2q1ZmUIb+jtW5pGJ12NJKI0QhmOUcrvTPYHE8B
	 l/tG5uGVwh8ZWQdrRHNQHiwH7PESpXcp/QTK9Lp56nyHHg3EK/mmR6ReOTCgotXyub
	 09kZ09kEM8fiV/XKkJe3okfX1PP++wtp8ppKZGlKhhMMQGAB1x3aMN4T4HkQ9imywK
	 bVIu1B1gpWrnw==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject:
 Re: [PATCH v2] doc: change the markup of paragraphs following a nested list
 item
Date: Sat, 04 Oct 2025 19:31:29 +0200
Message-ID: <2239952.irdbgypaU6@cayenne>
In-Reply-To: <20251003034134.GA625140@coredump.intra.peff.net>
References:
 <xmqq5xd5aqa5.fsf@gitster.g> <20251003031113.GA6381@coredump.intra.peff.net>
 <20251003034134.GA625140@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, 3 October 2025 05:41:34 CEST Jeff King wrote:
> On Thu, Oct 02, 2025 at 11:11:14PM -0400, Jeff King wrote:
> > which I think is wrong? Looking at the end result with more context, it
> >=20
> > is:
> >              refStorage
> >             =20
> >                  Specify the ref storage format to use. The acceptable
> >                  values are:
> >                 =20
> >                  =E2=80=A2   files for loose files with packed-refs. Th=
is is the
> >                 =20
> >                      default.
> >                 =20
> >                  =E2=80=A2   reftable for the reftable format. This for=
mat is
> >                 =20
> >                      experimental and its internals are subject to
> >                      change.
> >             =20
> >              Note that this setting should only be set by git-init(1) or
> >              git-clone(1). Trying to change it after initialization will
> >              not work and will produce hard-to-diagnose issues.
> >=20
> > So that "Note that..." paragraph is attached to the refStorage
> > definition, and should be indented to the same level as "Specify...".
> >=20
> > Even more interesting, I think asciidoc gets this wrong both before and
> > after your patch!
>=20
> Sorry, this is incorrect. Rendering with regular asciidoc does produce
> the right output already.
>=20
> The patch I showed to drop the extra newline turns that final paragraph
> into a continuation of the second bullet point. So it is wrong for both
> asciidoc (which is already correct) and for asciidoctor (which indents
> too little, but after my proposed patch indents too much).
>=20
> That's a little hard to parse, so here's my attempt at showing visually.
> The rendered output before that final paragraph looks something like
> this, with markers 1-3 showing possible indentation levels:
>=20
>   refStorage
>       Specify ...
>=20
>       =E2=80=A2   files ...
>=20
>       =E2=80=A2   reftable ...
>=20
>   (1) a peer of "refStorage" in the definition list
>       (2) a continuation paragraph in the "refStorage" definition
>           (3) a continuation paragraph in the second bullet point
>=20
> The paragraph "Note that..." should be at indentation level 2, and
> currently is for both asciidoc and asciidoctor. After your patch it is
> unchanged in asciidoc and at indentation level 1 in asciidoctor.
>=20
> My proposed patch (which is garbage) moves it to indentation level 3 in
> both.
>=20
> I think to appease both systems we need to put the inner bulleted list
> inside a block. I think that is OK in this case because there is no
> inner block marker to worry about. So:
>=20
> diff --git a/Documentation/config/extensions.adoc
> b/Documentation/config/extensions.adoc index 49a7598ca5..aaea8c107f 100644
> --- a/Documentation/config/extensions.adoc
> +++ b/Documentation/config/extensions.adoc
> @@ -55,8 +55,9 @@ For historical reasons, this extension is respected=20
regardless of
> the refStorage:::
>  	Specify the ref storage format to use. The acceptable values are:
>  +
> +--
>  include::../ref-storage-format.adoc[]
> -
> +--
>  +
>  Note that this setting should only be set by linkgit:git-init[1] or
>  linkgit:git-clone[1]. Trying to change it after initialization will not
>=20
> on top of your patch seems to do the right thing (no change in asciidoc,
> and eliminating the regression from your patch). It's a little gross
> because we are reaching across the include to realize that
> ref-storage-format.adoc contains a list that needs to go into its own
> block. I wonder if asciidoc implicitly opens a new block for an include
> but asciidoctor doesn't. But at any rate, this is the only way I could
> come up with for both to render correctly.
>=20
> -Peff


Thank you for cross-checking. This is indeed almost impossible to mechanize=
=20
such testing at the moment.

JN



