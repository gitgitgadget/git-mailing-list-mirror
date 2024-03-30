Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266B71E497
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711820250; cv=none; b=Cb3fhCGXnpCJOpvGJJRJ70ILHbvr6O6E7BLJdlekwBP9BWCwTzuFg3VrWhX+H0X2TXjH27L+xqaqqrZX3rryHLb5M59rtRK1cmN7UqewRYRTyamoyHMDOVAqPfMR20iOQyDdRLYxqzY2WHoXwMFEWQCAIhdz01DhfMyE3pNTq6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711820250; c=relaxed/simple;
	bh=ZABSqIJ01pO7+MTemqy3XYkxM8QXjyaTkVq994xJ6iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xps6r3Bbzm/Wd237tk0vRiAN9cMvOnMHd3xIeNHWi7FSjnMuIwX1VUjeOwGAfkHfKJZLW5OmON1BIVoVKYxT706VbmiPWon0KQDq3nspo+1cgFL7qsGkNhh7WIw9+xa6yaXFx0/tRabwtUqh+7a8poJfKToxoeQWNGFHjS70nok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=A6pCW1PD; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="A6pCW1PD"
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 3AC63DF8242
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 18:37:10 +0100 (CET)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:c2d2:c7d2:a4cd:bda7])
	(Authenticated sender: jn.avila@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id E8B9613F89C;
	Sat, 30 Mar 2024 18:36:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1711820222;
	bh=ZABSqIJ01pO7+MTemqy3XYkxM8QXjyaTkVq994xJ6iY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A6pCW1PD35Z95eE7v+IyAPo6xceEULoWaF6w1fijt62ugCjX2O8FPllAHDr5R8O9s
	 DFMJ7BdxyTOoZ7qlRF0j5zRgEn+usM2M+39rpnJEiEM5K25/hcsBMk3wFaVu0Ofq9F
	 GlkzbidARoFcpGCf7+YUYogbduUsKspe2YtJVoOiuQjH09YtCqG+cyM83sdjThrLCY
	 YWeaZ7qCE3YcLpy760gYfH9a+gOA7JBup6hsxwODhOILsEucrvjFeKpPyX0v2CB1Cf
	 UUF+4nNShTWfCoiWys0DhgpPswAiMQhy7fxHm46DITZlfAfNjYYmppaSiFBymJDorr
	 Czh0ng3TVEgiA==
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:
 =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org,
 Martin =?ISO-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
 Jeff King <peff@peff.net>
Subject:
 Re: [PATCH v2 1/5] doc: rework CodingGuidelines with new formatting rules
Date: Sat, 30 Mar 2024 18:36:57 +0100
Message-ID: <12414787.O9o76ZdvQC@cayenne>
In-Reply-To:
 <CAPig+cSzqUcTfnHBFTQWxjMbUZQBKahpD7eafmL=QvUDYtXTpw@mail.gmail.com>
References:
 <pull.1702.git.1711318739.gitgitgadget@gmail.com>
 <8a25ab1c3b61ebea9942fe106d4e0547a81743a4.1711711181.git.gitgitgadget@gmail.com>
 <CAPig+cSzqUcTfnHBFTQWxjMbUZQBKahpD7eafmL=QvUDYtXTpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Friday, 29 March 2024 19:42:28 CET Eric Sunshine wrote:
> On Fri, Mar 29, 2024 at 7:19=E2=80=AFAM Jean-No=C3=ABl Avila via GitGitGa=
dget
> <gitgitgadget@gmail.com> wrote:
> > Literal and placeholder formatting is more heavily enforced, with some
> > asciidoc magic. Basically, the markup is preserved everywhere.
> >
> > Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> > ---
> > diff --git a/Documentation/CodingGuidelines b/Documentation/
CodingGuidelines
> > @@ -682,68 +682,118 @@ Writing Documentation:
> >   If a placeholder has multiple words, they are separated by dashes:
> > -   <new-branch-name>
> > -   --template=3D<template-directory>
> > +   _<new-branch-name>_
> > +   _<template-directory>_
>=20
> Having two separate examples made sense in the original because it was
> illustrating a standalone placeholder versus a placeholder coupled
> with some literal text ("--template=3D"). However, in the revised hunk,
> there is no reason to use both "_<new-branch-name>_" and
> "_<template-directory>_" as examples; the reader does not learn
> anything new from the second example which couldn't be learned from
> the first. As such, I'd drop the latter example.
>=20

A few examples don't hurt. Anyway, if I have to reroll a v3, I'll remove=20
_<template-directory>_ which would be better located in the next paragraph.




