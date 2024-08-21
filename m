Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9519B7405A
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 21:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724274373; cv=none; b=bIKNdaOQHr5UbXWTdgwMOcV/2tUOPjbuk3B1o5omHsJ3gxXMTzMAzAPhqchTHZJ6hZWmbvExg+6plprhwpMQyRh1+u0dOc0FfoP7EDuQnyAfAfgeeaBw1Qwx6Ntm9vBQNOAmTi7mbxqo8jZRn3d2b472JRUmcdOwsYbSFILcbGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724274373; c=relaxed/simple;
	bh=aUsjFT/0WOkpQf+RsRx+Xt54ffx8soIGK8emaNbU2Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hT5A5fC4SHwBo6qat8+z5VAHQMxLRlYSPP4uFbtYwRypSsSVlH7piiL0fp/VM3j2rtJBLhPZuUMLYFawaZ1aV1kp7KkrMbMvxr9yINLFYMGU4+5GvXb+6eYZYiBIn4H+r90XyGY3wSjHSFliMBAwMoytQtO1R0UHoBw9/s9lebA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=s6jciCQa; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="s6jciCQa"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:e989:1c38:bc34:7c99])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id E336AB00565;
	Wed, 21 Aug 2024 23:05:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1724274363;
	bh=aUsjFT/0WOkpQf+RsRx+Xt54ffx8soIGK8emaNbU2Pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s6jciCQatdz5KWYjNGmHiEsVlqPYAVng68D0e436oBl8YR9UmZOJmzjH9rJ/KKKIx
	 uN44pYAgbjX/XSgV54EqCZFOyY9Qi/WjijYSyv7ZEcmC0ZwNKtqww3KT/lAe9YZRqE
	 MA2bA/BdxDpnVNa2lUQxGzuTywWIx+ajhMYusLWSAKrthDcVuRGvULFl3JMVsEBtae
	 npUEXMaHh3OnP0YP6e68OUR7Xa+b/vNqkhW59FDEik+o8kifhN2tveSx0mLx+NPTPx
	 5RBHsC1GIT9MEeuiaLOu4A/rKsQbupPag+1KtgTSSSkDIT8RR4HKuK/6BILloJHKcV
	 MO/m1fdnWsv+w==
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:
 =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
 Patrick Steinhardt <ps@pks.im>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/3] doc: introducing synopsis para
Date: Wed, 21 Aug 2024 23:05:57 +0200
Message-ID: <1986021.PYKUYFuaPT@cayenne>
In-Reply-To: <xmqqzfp8cm30.fsf@gitster.g>
References:
 <pull.1766.v2.git.1721855179.gitgitgadget@gmail.com>
 <pull.1766.v3.git.1723389612.gitgitgadget@gmail.com>
 <xmqqzfp8cm30.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Le lundi 19 ao=FBt 2024, 22:08:19 CEST Junio C Hamano a =E9crit :
> "Jean-No=EBl Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> > Jean-No=EBl Avila (3):
> >   doc: introduce a synopsis custom paragraph attribute
> >   doc: update the guidelines to reflect the current formatting rules
> >   doc: apply synopsis simplification on git-clone and git-init
>=20
> This topic has become quiet.  I still find s:["someything you really
> want to say"] notation a bit annoying to my eyes, but its may be the
> best compromise we can come up with.
>=20
> So unless we have a strong objection, or (even better) an objection
> with an alternative that is less yucky, perhaps it is time to
> declare that this is the variant of AsciiDoc/Asciidoctor that we'd
> adopt for our documentation.  Comments?
>=20
> Thanks.
>=20

I understand that you are reluctant to include a change that, as the=20
maintainer, you do not feel comfortable  keeping alive.=20

The whole discussion thread tells me that other developers are not ready to=
 go=20
down the "full markup" path. Understandably, this makes it more difficult f=
or=20
everyone to propose changes and review them, as there's no tool to track su=
ch=20
formatting errors and we have to rely on careful manual cross-checking.

I would like to thank you for pushing so that the markup can be simplified =
as=20
much as can be. It can be simplified further one step further: it is possib=
le=20
both in asciidoc/asciidoctor to override the formatting of inline verbatim=
=20
texts, so that everything that is backquoted is processed as a synopsis=20
string.=20
This way, strings like

`<commit>`
`diff.statGraphWidth=3D<width>`
` --dirstat-by-file[=3D<param>,...]`

are automatically rendered with the expected styles.

However, contrary to the s macro, this is quite disruptive as it forces the=
=20
new processing on all existing manpages. Another drawback is that it is no=
=20
longer genuine asciidoc, but it seems more in line with the critics. I'm=20
refining the regexp at the moment to check for side-effects.

Is this proposition more appropriate?




