Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92851DF25F
	for <git@vger.kernel.org>; Sun,  1 Feb 2026 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769951665; cv=none; b=eXEWiyQVDZnNPlrvStzgGq5aSxRwmZiyQ9NOP+l8PMbEmIK/vKXWPQCglT663xgEfwDPqP1qCWjkavGtx1repo8E3nJqK4JHQErxl8PVLNrnpuK1r6WzLAp6GX5prjY4JYlFMbyTESBpeoHtOepBWRmMAbCDbwZVudBOjX1kal4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769951665; c=relaxed/simple;
	bh=OOcA0aiI40g1KOCaFwH410C3a/QKRuaG9WuXOV+YtIM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3I/mwXzqCvFdzqtkAw1wPFgBbgM1o9lnSBBklu9bbYxSyF08wPpVPx634p4moEim/wL90MKPNcE+ipwpgFIYWlEPLhjnEWD9wruwSBHNAWt03sbEomVHua2VVTHXemzE+YUJX0oK2GCyioFPRogsGz0Q+YEimzExO/86zw0X3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=o1603lVE; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="o1603lVE"
Received: from piment-oiseau.localnet (unknown [IPv6:2a01:e0a:d1:f360:3d51:7a10:3981:3744])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 0DBE1B00572;
	Sun,  1 Feb 2026 14:14:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1769951661;
	bh=OOcA0aiI40g1KOCaFwH410C3a/QKRuaG9WuXOV+YtIM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=o1603lVEgIfQPhWV6BqQMTeZfFv4wWnAa1zxypY/zt2ijKNmhZbgwjkuhQNfpWwXt
	 JSDaiU6tveoOVhMy5mdBlJo4MAJYNVuCoTgaVhkVWbpgnY+rb8UcIXDYA3Mh9ZZ6SK
	 dN99jLkczQfB2smrEq/g8DOdgebiszj14pVzNLIaFbn+UeDK4mnYKO/CZdTK6zOuIr
	 nKbVIFqvTKn1XAGd5vXLK5I6l+e7wuo+NJheABJ1M3vO9eIN1MGctaGSsBZ5ISWwnh
	 pJ+et8KayPpdBCTDlqBF+hzjd/brBI2ltGH7xjFKfDkAl90UEMwheIvnNm/Xdvx700
	 dsO4jCKZDQ2zA==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: =?UTF-8?B?SmVhbi1Ob8OrbA==?= Avila <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject:
 Re: [PATCH 2/4] doc: finalize git-clone documentation conversion to synopsis
 style
Date: Sun, 01 Feb 2026 14:14:18 +0100
Message-ID: <13939780.uLZWGnKmhe@piment-oiseau>
In-Reply-To: <6f7d027e-088a-4d66-92af-b8d1c32d730c@app.fastmail.com>
References:
 <pull.2036.git.1769202903.gitgitgadget@gmail.com>
 <3a5b642d05b9fcafb684631a0026959bfc362d2b.1769202903.git.gitgitgadget@gmail.com>
 <6f7d027e-088a-4d66-92af-b8d1c32d730c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Thank you for taking time to scan through the changes.

I will reroll to fix all your comments.


On Sunday, 1 February 2026 13:04:13 CET Kristoffer Haugsbakk wrote:
> On Fri, Jan 23, 2026, at 22:15, Jean-No=C3=ABl Avila via GitGitGadget wro=
te:

>=20
> Doesn=E2=80=99t need to be done now in this series, but the =E2=80=9Cstuc=
k form=E2=80=9D of
> `--origin=3D<name>` is recommended by gitcli(7) for long optoins. This doc
> uses a mix of unstuck form (no `=3D`) and stuck form.
>=20

Is this something that is automatically available, i.e can we already conve=
rt=20
and advise so to writers in all pages?
=46or me, these synopsis series are a chance to push forward a larger range=
 of=20
reworks on formal formats such as this one.


> > +`--config <key>=3D<value>`::
> >  	Set a configuration variable in the newly-created repository;
> >  	this takes effect immediately after the repository is
> >  	initialized, but before the remote history is fetched or any
>=20
> I was curious if you can use `--config=3D<key>=3D<value>` without tripping
> up the option parser. And you can:
>=20
>     git clone --config=3Dcore.editor=3Dsomething ...
>=20

OK, will also rework.




