Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87288388868
	for <git@vger.kernel.org>; Sat, 23 May 2026 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779536971; cv=none; b=XM60j2qw2ZXNRXgXMf1O1Ghy/VXo6lKrXjrIinZ0TG+2Tbhy8ODQuhBRIdl1scEMwY9iQzSwfZhSLLOJAGI1bw4Nphpmf5WB3OKmX1Jw1lF0NR1DwKe1kBR3k0Vlausfxt/K7tEw9PmEFZJpEQ2fFvC60A77YaWVDGM5h2g12/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779536971; c=relaxed/simple;
	bh=05DOtS6A5ynCCDVhehvvqe7X8b+Aih1ezlilMtRn77E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OdDEPvurgYvvf/+/YFgWcoN/PfEWpzgxnaJDXvSi93F3Mg0HkjhvJfdRQrg2DWyOTcaLda62nvWKDeFS2cwKqIfFgOVk5YGurGpEzstLX74Rp/SSjyXEw7noIFNV3HLoDp7tZnhwYFvDZpWuyGWe1hdgX0sES/STwUsdFETuI1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=d76/q8uB; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="d76/q8uB"
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id DEF824CD7C
	for <git@vger.kernel.org>; Sat, 23 May 2026 13:41:20 +0200 (CEST)
Received: from piment-oiseau.localnet (unknown [82.64.51.39])
	(Authenticated sender: jn.avila@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id BB9FC19F5A7;
	Sat, 23 May 2026 13:41:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1779536473;
	bh=05DOtS6A5ynCCDVhehvvqe7X8b+Aih1ezlilMtRn77E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d76/q8uBSElii5m4x2CWy1KOF7r7yi/YKWFcmm3TC/qOq3Vh43+4XToKUVvcmRcwx
	 Asp45E+Qv7KexRJ/V6fo72RfSPDMr/mmD3ToVeM2xwXzEJhkMVD12tdFozkI5YvVLq
	 YOAPWs9riXQjHhxxw3gVy7H5nFzK2PiDoMU/SHrbviFBtxHXfJ59BKTkBij8dgKrZN
	 O/Aa5zYQEtU/iTDfo9lhTXU702JaaUVSdUg6Mx5LmBIMRxsPKohqpH/JpNRXHOpKZ5
	 Zs10hGiSgtJJUS0bWi78j4idk1PCAI/WDbiNXPjAxRt7edv17Ciq1gF26UTdJje73d
	 a1sfvsp0U5WkQ==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, kristofferhaugsbakk@fastmail.com
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, adrian.ratiu@collabora.com
Subject: Re: [PATCH 0/4] doc: hook: small improvements
Date: Sat, 23 May 2026 12:24:13 +0200
Message-ID: <2832179.mvXUDI8C0e@piment-oiseau>
In-Reply-To: <CV_doc_hook.6f0@msgid.xyz>
References: <CV_doc_hook.6f0@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, 21 May 2026 18:25:54 CEST kristofferhaugsbakk@fastmail.com wro=
te:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>=20
> Topic name: kh/doc-hook
>=20
> Topic summary: Small improvements to git-hook(1) and the associated confi=
g.
>=20
> [1/4] doc: hook: remove stray backtick
> [2/4] doc: hook: consistently capitalize Git
> [3/4] doc: config: include existing git-hook(1) section
> [4/4] doc: hook: don=E2=80=99t self-link via config include
>=20
>  Documentation/config.adoc      |  2 ++
>  Documentation/config/hook.adoc | 19 +++++++++++++------
>  Documentation/git-hook.adoc    | 11 ++++++-----
>  3 files changed, 21 insertions(+), 11 deletions(-)
>=20
>=20
> base-commit: aec3f587505a472db67e9462d0702e7d463a449d

This series looks good to me.

Thanks



