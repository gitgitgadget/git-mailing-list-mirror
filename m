Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1CD13D53D
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484816; cv=none; b=anF8xsh/u/mugp66nR/lWiJQp2UuZInnjT5dMDEWNzUIQ81glEc2mqBj6hhqpyLAL9rExLSzgcX0uckRvvoIN1294yYb5vNAUUK/bNxNnbRIm7Od5wVuvlOyCE5OZf1xLrRz5MUq3c5Fpni+/HnE9gDq96i6i5ZF53lf298EPe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484816; c=relaxed/simple;
	bh=kOYnLml3v5HWR25WU1NppNIBvBAudesU/Ftxe8w+Feo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JaocJRWY9qBp26pu55UQwjDyLvITKAkI1I25lroWhAM94Ug+0dSrizkBjtkU1YYr2Uz6VGxQJIHd1e6A/JTJ6sPo77qmQsXI+j3NLk3jKnLsSWv5490r+/GD45VGziU0Sxok8dSYHNsiX/NfBs7r+qgsHf8qlimpUq9jcoFhFOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=WM8Ml+SC; arc=none smtp.client-ip=212.27.42.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="WM8Ml+SC"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:9225:6fd8:b89b:1501])
	(Authenticated sender: jn.avila@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 3416719F576;
	Tue, 26 Mar 2024 21:26:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1711484806;
	bh=kOYnLml3v5HWR25WU1NppNIBvBAudesU/Ftxe8w+Feo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WM8Ml+SCkJmV7WkEyYtoxllcl9SsKcg709yuwcvwrKqA71Pa8j+0ZwkuZDibEPxaP
	 TG5zORVHk7RO3eKEdvIjD4H/4btxktqzZTkSgXox8yz83alPEvWatvzDlZTGXs42Fw
	 cZpzopPMcDmcPGrajAwc9gjUTppxWhXbRWbGeiTlhGEZngmISNcl71GwQVlQqg6A9j
	 vh+4ksfFLG85RnsQHqRRTaNALbON+5pBmqpnSKh5XyzBDdhTNY0vtGB4KKGHu/ttWp
	 Rjy+BfbYSJ3693xdLcQXnDJ+IUgo2b/Rb/X05tOENVWfivnaGg1dLotlviXAdSFljt
	 hEaE0DkPCVhRg==
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:
 =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>,
 Martin =?ISO-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc: git@vger.kernel.org
Subject:
 Re: [PATCH 3/4] doc: git-init: apply new documentation formatting guidelines
Date: Tue, 26 Mar 2024 21:26:43 +0100
Message-ID: <12408886.O9o76ZdvQC@cayenne>
In-Reply-To:
 <CAN0heSpVLAw3iYiCcgTnOtO9saY0KXR+00r7mR-PfqU+EcfPoA@mail.gmail.com>
References:
 <pull.1702.git.1711318739.gitgitgadget@gmail.com>
 <310f09fc81c75ef03eb00629db6302d1904585fe.1711318740.git.gitgitgadget@gmail.com>
 <CAN0heSpVLAw3iYiCcgTnOtO9saY0KXR+00r7mR-PfqU+EcfPoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Le mardi 26 mars 2024, 21:18:31 CET Martin =C5gren a =E9crit :
> On Sun, 24 Mar 2024 at 23:19, Jean-No=EBl Avila via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > -umask::
> > -false::
> > +`umask`::
> > +`false`::
>=20
> (It should be `umask` here exactly as you did, ok, good.)
>=20
> >  Use permissions reported by umask(2). The default, when `--shared` is =
not
> >  specified.
>=20
> >  _<perm>_ is a 3-digit octal number prefixed with `0` and each file
> >  will have mode _<perm>_. _<perm>_ will override users'`umask(2)`
>=20
> It's a bit of a mix whether umask(2) should be `umask(2)` with backticks
> or just umask(2) without. That's pretty much the only thing I noticed,
> everything else looks really nice and consistent. I guess it's not a
> literal, since we don't expect to user to actually type the 8 characters
> "umask(2)"? If you do decide to drop the backticks, notice that there's
> one instance (seen above) of "users'`umask(2)`" with a missing space,
> so you might want to fix that up at the same time.
>=20
> Martin
>=20

Ah. Good point! As we are referring to the manpage of a function, this *is*=
=20
indeed a case of verbatim text so, it must be backquoted.=20

So, I'll add it the guidelines and reroll with changes in the man pages.

Thanks




