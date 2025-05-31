Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059C51ACE0C
	for <git@vger.kernel.org>; Sat, 31 May 2025 21:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748728025; cv=none; b=MJdiPvib8GOlbHyNLPCKJkVtQSdobO6gPq6d7+izf5Jzy0ghWKStlsI/esRl1k4lqnK3OF0oFfCbmHvSIgpVF2anNp/9tIOGGnBu/sVnfT284vTs0Dn1khyFePLecT8mIsItQOgFhExvzm7xJpCETTSooNDBIFnmi/ksTCx7I2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748728025; c=relaxed/simple;
	bh=iv633nMiFX0BWVImWbNatGk7fIBNdaMqRPyf9gz8CXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qcPTQHssD6dVde+1zM+aZi32l0HkdplE6kNsz+P1E10LUI6Mrg7mxpfrFGuBN5A/niFGQrFoPzxq3uZ5yGJE2wDP5Ag+6bBXeTEeu7B0XCtOUYmZ1H9uwNg8XQzXCQVvPnw5eActz1p8Gdg0TwP4U3yLCUJnSzqQ/AKzAnv1YeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=OXZ/QVpR; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="OXZ/QVpR"
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 120E7DF918C
	for <git@vger.kernel.org>; Sat, 31 May 2025 23:46:52 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:394a:7566:a911:2f3f])
	(Authenticated sender: jn.avila@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 7E8AB2003B4;
	Sat, 31 May 2025 23:46:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1748728004;
	bh=iv633nMiFX0BWVImWbNatGk7fIBNdaMqRPyf9gz8CXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OXZ/QVpRQF9UFbb/PwSPMhIFLjvzgEdk9BK2lAJkTdv3xA35elJCvQspqYPJRWS6F
	 6N7dSqkcxbUdDq/FyypuqwLyvlOCz+yxVg6WbExqVDVc8uXDmePwnrfHPfGxBZM1lL
	 MVi11vpKqS0CdqRlq4ixQhYEPX1tguYQ/b+NBz9canrkl6xGHgsoA1SUDf1r3Vxx2H
	 s4vjg4LAonroYH60mgr81aSkXB2Y70/v0qAB71gotHYjvoKu2kvgtPw4RegSPqfqxo
	 wFsqVwmyCCrqAV8poNToV1ooeAR/P6T/ek2KrSBALfBrzQJ4utKArlk2vFRZQPH9rR
	 HNdhakvMtCSKA==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, kristofferhaugsbakk@fastmail.com
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH] doc: column: fix blank lines before block delimiters
Date: Sat, 31 May 2025 23:46:42 +0200
Message-ID: <5891508.DvuYhMxLoT@cayenne>
In-Reply-To:
 <b493b07f88bc5562e03c249006f01091afd7b5fd.1748725662.git.code@khaugsbakk.name>
References:
 <b493b07f88bc5562e03c249006f01091afd7b5fd.1748725662.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Saturday, 31 May 2025 23:08:09 CEST kristofferhaugsbakk@fastmail.com wro=
te:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>=20
> 227c4f33a03 (doc: add a blank line around block delimiters,
> 2025-03-09) added blank lines around block delimiters as a
> defensive measure.  For each block you had to mind the con-
> text (like the commit says):
>=20
> =E2=80=A2 Top-level: just add blank lines
> =E2=80=A2 Block: use list continuation (+)
>=20
> But list continuation was used here at the top level, which
> results in literal `+` in the output formats.
>=20
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  Documentation/git-column.adoc | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/git-column.adoc b/Documentation/git-column.adoc
> index 5a4f2b6fde9..8e0047214dc 100644
> --- a/Documentation/git-column.adoc
> +++ b/Documentation/git-column.adoc
> @@ -50,7 +50,7 @@ EXAMPLES
>  --------
>=20
>  Format data by columns:
> -+
> +
>  ------------
>  $ seq 1 24 | git column --mode=3Dcolumn --padding=3D5
>  1      4      7      10     13     16     19     22
> @@ -59,7 +59,7 @@ $ seq 1 24 | git column --mode=3Dcolumn --padding=3D5
>  ------------
>=20
>  Format data by rows:
> -+
> +
>  ------------
>  $ seq 1 21 | git column --mode=3Drow --padding=3D5
>  1      2      3      4      5      6      7
> @@ -68,7 +68,7 @@ $ seq 1 21 | git column --mode=3Drow --padding=3D5
>  ------------
>=20
>  List some tags in a table with unequal column widths:
> -+
> +
>  ------------
>  $ git tag --list 'v2.4.*' --column=3Drow,dense
>  v2.4.0  v2.4.0-rc0  v2.4.0-rc1  v2.4.0-rc2  v2.4.0-rc3
>=20
> base-commit: 7014b55638da979331baf8dc31c4e1d697cf2d67

Acked-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>



