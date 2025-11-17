Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF693222587
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 11:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763379950; cv=none; b=Fac/IrUyEidak0zVYH/1MMLINbDroMx/AL/33OZj018svZm4ZxRz6andKj8jXA8idV3G6Z3OwI58lNlM0rKJ3xYkGwUI4C4fKrZb7ARZ4pKFiLKRBCKOgIPmOWlFbo3VTZ40HGF3nMiRyNC3cHk5pEMKnVJEjdRFMBkytil8fwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763379950; c=relaxed/simple;
	bh=4u8qIdBf0y4p1eG9ZjYz530L1ztjddzWer1QP7xdypY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LyvEDY/2XErXvLpygYkqIl06Z/C7qFmFAMJTNun4l6thN0dUvIrOOr3xyoKdi6Nn5XP6XAp1GKRFpMe076m4sb1JHV3qwWO8sm20uJlcJcUlriI114DuUmCWhYvTcC754f0cUcq792H/FJA/+M3t5HHF1QA0Y7DXaw2cDYQquzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Xp0jFNqr; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Xp0jFNqr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1763379946; x=1763984746;
	i=johannes.schindelin@gmx.de;
	bh=l8jJs4eumJxVmZLk40sBljRHJzpgPToM4bd/Fq1rEDg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Xp0jFNqreBU6F3H2j2sHd6PJZ2co5hJSFX0N3JYk5e4zl1Vf2k5rc/ABn7EVUCTr
	 forNF/eKZPZYwuSB0E8WPBA/CQKHeZ9sq19KxOoqDocU8lxeSUGO6555rr6ScRcOO
	 fsE2vf68PvxOFVBrO41dzd4h5Ack3HYBcsW5K2TokD+wOHdC5mjyFgtAbE1UXV+fd
	 4rabHo8Uns+kUMv+u6HmXvyW0yMqrths8EC/vIUw1CJa5Xzg/BJJcbiXO+5f4we4G
	 3Fhul1ZMonz23CG0FAL2Jifipj0smgormsEe3x9aJ8kzaEV/20Yza5DdudT5oQQVB
	 NrR5WwebUpHG4jIs5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.224]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mn2aN-1w3PMk41BP-00otx1; Mon, 17
 Nov 2025 12:45:46 +0100
Date: Mon, 17 Nov 2025 12:45:44 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] l10n: bump actions/setup-go from 5 to 6
In-Reply-To: <pull.1975.git.1758623999720.gitgitgadget@gmail.com>
Message-ID: <cb24b29c-1fa4-8f01-88ed-c6f02a1bd990@gmx.de>
References: <pull.1975.git.1758623999720.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1555176784-1763379946=:14379"
X-Provags-ID: V03:K1:9Ai+DYGzDz1RjrRYhzBCeDX9s0YHHSc3o1OKc97f/+PCKoJAAc0
 VyB35bomXKiHXwbhdm+deeIH1B+YmqgooZDSg2/e6MDBm3wiZI/ihgUyCLdKOSWjY8EF/56
 J0e5lod4ApUSu4B23U/ItFOCYFt5RIF6bRkV9gep6qKAbSsMY25Gwzyw/78wF+D+XxOxdEJ
 Qf0mYNRhcMrYsmT2zgPzg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VhDWZg3ppcA=;A18OmkVlFHy3RX6mVjRRDULPQVp
 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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1555176784-1763379946=:14379
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jiang (or do you prefer to be addressed as Xin?),

gentle ping? I think that your missing review is blocking this.

Thanks!
Johannes

On Tue, 23 Sep 2025, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>=20
> [Originally opened at https://github.com/git-for-windows/git/pull/5811]
>=20
> Bumps [actions/setup-go](https://github.com/actions/setup-go)
> from 5 to 6.
> - [Release notes](https://github.com/actions/setup-go/releases)
> - [Commits](https://github.com/actions/setup-go/compare/v5...v6)
>=20
> ---
>     l10n: bump actions/setup-go from 5 to 6
>    =20
>     (Originally opened at https://github.com/git-for-windows/git/pull/58=
11,
>     then at https://github.com/git-l10n/git-po/pull/870)
>    =20
>     Bumps actions/setup-go [https://github.com/actions/setup-go] from 5 =
to
>     6.
>    =20
>      * Release notes [https://github.com/actions/setup-go/releases]
>      * Commits [https://github.com/actions/setup-go/compare/v5...v6]
>    =20
>    =20
>     What's Changed in actions/setup-go@v6
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    =20
>    =20
>     Breaking Changes
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    =20
>      * Improve toolchain handling to ensure more reliable and consistent
>        toolchain selection and management by=C2=A0@matthewhughes934
>        [https://github.com/matthewhughes934]=C2=A0in=C2=A0#460
>        [https://github.com/actions/setup-go/pull/460]
>      * Upgrade Nodejs runtime from node20=C2=A0to node 24 by=C2=A0@salma=
nmkc
>        [https://github.com/salmanmkc]=C2=A0in=C2=A0#624
>        [https://github.com/actions/setup-go/pull/624]
>    =20
>     Make sure your runner is on version v2.327.1 or later to ensure
>     compatibility with this release.=C2=A0See Release Notes
>     [https://github.com/actions/runner/releases/tag/v2.327.1]
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1975%2=
Fdscho%2Fdependabot%2Fgithub_actions%2Factions%2Fsetup-go-6-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1975/dsch=
o/dependabot/github_actions/actions/setup-go-6-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1975
>=20
> updated-dependencies:
> - dependency-name: actions/setup-go
>   dependency-version: '6'
>   dependency-type: direct:production
>   update-type: version-update:semver-major
> ...
>=20
>   Original-author: dependabot[bot] <49699333+dependabot[bot]@users.norep=
ly.github.com>
>=20
> Signed-off-by: dependabot[bot] <support@github.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  .github/workflows/l10n.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/.github/workflows/l10n.yml b/.github/workflows/l10n.yml
> index e2c3dbdcb5..95e55134bd 100644
> --- a/.github/workflows/l10n.yml
> +++ b/.github/workflows/l10n.yml
> @@ -63,7 +63,7 @@ jobs:
>              origin \
>              ${{ github.ref }} \
>              $args
> -      - uses: actions/setup-go@v5
> +      - uses: actions/setup-go@v6
>          with:
>            go-version: '>=3D1.16'
>            cache: false
>=20
> base-commit: 79ee0dce2a61b7552f9b5c73f0cf2d974a20a029
> --=20
> gitgitgadget
>=20
>=20

--8323328-1555176784-1763379946=:14379--
