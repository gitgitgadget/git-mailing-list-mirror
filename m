Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1D413C8F3
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 12:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909743; cv=none; b=X2O1HzSpdXo9UuiB2Ti9mWMJU6GxJ4GyjNfr9EC8utUM2Y+3mG1FsHGDZioJ+1O04VchD/NpTJVQl2iYem8thiB8NzkTytbYeMM9o9bMLrXsGm3HwiFWT2uiF4+PFvOdq7QGt0xzepjtumnwOepZ5WGcJ8ecbaDtZs+wKFAVhfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909743; c=relaxed/simple;
	bh=9s7Px1/dEwV6uzKqsf80M6/uUYmpE1EHDEFGNxrOzJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WeRew7qzteM66FcC3/vZAc86oDmEjxrdOo5I3xP3lEcXXCUjy3Ms03H114LP7NnQlC7k66gqP4CTQH2LLWfYbFByskE/8GcMAiMPTVD0fmnhWZ3qSbKrPxqMPF1NL4lCPJmNivX0QNYhJ1LYkosTklJ+RZhLxbksPWr702zxxrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=W6yVazhk; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="W6yVazhk"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:73c0:a48d:4729:5cfd])
	(Authenticated sender: jn.avila@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 1543313F8D5;
	Thu, 25 Jul 2024 14:15:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1721909733;
	bh=9s7Px1/dEwV6uzKqsf80M6/uUYmpE1EHDEFGNxrOzJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W6yVazhkuPpf30kxD6srVvL+UG353hzrZtEpgtdnHfzcgGHg0Qvv+1FkhtQEZA5yA
	 dieTWdxdpYnCCEbAB0BVHiU+cyWa+kj35vu4POy/YTtIjEXRhhDzqaU0jJg7iPnVcD
	 Hb/UQLsFKTFHdecNgkuM4g/LfHp5bGudcyuenxr3Zy9GkAShisEU7lZLvIpmfxW7uG
	 GHXWEZwlsmRaSeVP/5EmASUWCEmHp4lu5FRTN71hyDQqJ9lVPE0MqHBKJ9ew1nnpU4
	 2jzIT040EC4VE3TWMzSTcQT/fD7J5AeSUXUPuXlVYq3CYIwZiTWC26TWWw1EjVu0pC
	 ue0B1/IBC34Dw==
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:
 =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] doc: introducing synopsis para
Date: Thu, 25 Jul 2024 14:15:30 +0200
Message-ID: <13562033.uLZWGnKmhe@cayenne>
In-Reply-To: <xmqqcyn2s7ob.fsf@gitster.g>
References:
 <pull.1766.git.1721774680.gitgitgadget@gmail.com>
 <pull.1766.v2.git.1721855179.gitgitgadget@gmail.com>
 <xmqqcyn2s7ob.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday, 25 July 2024 01:15:48 CEST Junio C Hamano wrote:
> "Jean-No=EBl Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> > Following several issues with the way the formatting of synopsis is don=
e=20
in
> > the manpages that were recently reworked, this patch series introduces =
the
> > processing of a new custom paragraph attribute 'synopsis'.
>=20
> The rendered result looks OK but the source being just like what we
> would write in plain text files without any extra mark-up makes it
> look quite nice.
>=20
> I wonder what we want to do with some oddballs, like git-shortlog
> that uses "|" not as an alternative but literally a pipe (i.e. "feed
> the output of this other command via a pipe to this command"),
> though.
>=20
>     git log --pretty=3Dshort | git shortlog [<options>]

I must confess that while reviewing my patch, by switching all [verse] to=20
[synopsis] , I looked at this line and understood the pipe as an alternativ=
e=20
from the grammar, not as a shell pipe. I also noted a few spots where the=20
grammar may be misinterpreted e.g. parenthesis in git-grep.

In theory the typesetting should tell the keyword apart from the grammar, b=
ut=20
for signs such as pipes and parenthesis  the rendering does not change enou=
gh.

>=20
> There may be also some page that indicates "this command takes its
> input from its standard input" by using something like
>=20
>     git cmd [--foo] [--bar] <input-file
>=20
> which we may need to think how to handle.  The easiest way out may
> be to say "don't do these to indicate/force where the input comes
> from".  I dunno.
>=20

The form=20

    git cmd  [--foo] [--bar] < <input-file>

is completely acceptable , would render correctly and would remove the use =
of=20
the pipe. The thing is that this pipe isn't even part of the command. It is=
=20
just an example. Maybe it should not appear in the synopsis at all.

=46or keyword signs that are already used in expressing the grammar, we cou=
ld=20
quote the sign to indicate that it is a keyword : "(" .

Thanks





