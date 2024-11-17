Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700FD23AD
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731861874; cv=none; b=kZXJA1BsQwq1FyLRSmr+odPfxQ9FZsz1ttG10ozxEmRT3bNvNjgKXZp/Xg67YdWDh8OFJ4AP4MFGwwXI5KFKuqS92fIX1BfSkFozpZaVuPdih8rhzdT5lZxA8YDMORZhSs+uHnueyBL+962HB6Ck+hmNqDuOWbR88TYpnlC+NPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731861874; c=relaxed/simple;
	bh=Bp55XiWFgWy8d7PeJmDYbb2JTYGvTl6ta/G/RmVKvQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vAQ21w4oab/EnV+S9m91nrqFgNmOFA/FIorYBf4YH73v1KsIDGci+BGRvwh/490IOpqCb2NXoaLNSqN12/3q6F++7Jp5/rnmV7jCoqH3ooOUZGBYQ1NtmeEo794QEa4Tq7Uvrw9M9LVOj54orlaaTnl+AuZKOmBTcrl80IK6vNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=j529Z72u; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="j529Z72u"
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 62DFA428689
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 17:44:22 +0100 (CET)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:9148:6a20:82aa:d298])
	(Authenticated sender: jn.avila@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 99D6219F5A5;
	Sun, 17 Nov 2024 17:44:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1731861855;
	bh=Bp55XiWFgWy8d7PeJmDYbb2JTYGvTl6ta/G/RmVKvQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j529Z72uuz/uNMiDs5/2U5W7yDTGrsX3r9lliKuvdQ5qosLLUC8Ma4PEbmk5561d4
	 B7sIskuGzKg//FdnJqHNWtxLItTl8zJxoAF+Dt+cUNX5KKtTz+3jPsVwSnlrJyTBLP
	 3LSwkSCViwdLZC7Gq3t1ZUkQ8pDJ+JVGP02p0pT12HznMTqKLLpNF1fmkyPooYgpcn
	 N/VmrYbnJBemsihbMAFi7oFGqpBG9NBVCjTdNxyVPNHBkIgR/vgXp18kEFKjRSmMS7
	 PHO+POOuir6F4gUxr/mhC05IZt7yxB4FxW5n+/qwCBVkPmLp0L1Xj0bSZaRWVpxlux
	 emVsBpbrjEnMw==
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Patrick Steinhardt <ps@pks.im>,
 =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/5] doc: git-diff: apply new documentation guidelines
Date: Sun, 17 Nov 2024 17:44:10 +0100
Message-ID: <2365334.irdbgypaU6@cayenne>
In-Reply-To: <7f24a030-bae2-4712-8593-61a9d4089cfb@kdbg.org>
References:
 <pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
 <6841bd5825be8e7b17c2f9c3a997de29ffa3a540.1731785769.git.gitgitgadget@gmail.com>
 <7f24a030-bae2-4712-8593-61a9d4089cfb@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday, 17 November 2024 15:04:13 CET Johannes Sixt wrote:
> Am 16.11.24 um 20:36 schrieb Jean-No=EBl Avila via GitGitGadget:
> > --1 --base::
> > --2 --ours::
> > --3 --theirs::
> > +`-1`::
> > +`--base`::
> > +
> > +or `-2`::
> > +`--ours`::
> > +
> > +or `-3`::
> > +`--theirs`::
> >  	Compare the working tree with the "base" version (stage #1),
> >  	"our branch" (stage #2) or "their branch" (stage #3).  The
> >  	index contains these stages only for unmerged entries i.e.
> >  	while resolving conflicts.  See linkgit:git-read-tree[1]
> >  	section "3-Way Merge" for detailed information.
>=20
> Having seen this new proposal (which I am not a fan of), I reconsidered
> my take on how this could be formatted.
>=20
> First, I wonder why the pre-image is not
>=20
> -1::
> --base::
> -2::
> --ours::
> -3::
> --theirs::
>=20
> like we write in other cases where multiple options are described by the
> same paragraph (e.g.: -p -u --patch; -W --function-context; --textconv
> --no-textconv).
>=20
> Next, since with such a scheme all options are treated equally, we have
> to ask whether the description in the body text makes sufficiently clear
> that they not all do the same thing (it does), that there are actually 3
> distinct groups (it does), and which options mean the same thing. The
> latter is rather meh, but it is the fault of the text and can be
> remedied easily.
>=20

OK, I'm not fond of my solution either, but I strongly dislike mixing synon=
yms=20
(which is the usual meaning of putting several options in the same=20
description) with incompatible behavioral alternatives. But, for this one,=
=20
let's consider that the alternatives are just like `--[no-]bla` option=20
descriptions, for the sake of ending this PR.

I would still rephrase the description to make it clear, how the alternativ=
es=20
are  working:

`-1`::
`--base`::
`-2`::
`--ours`::
`-3`::
`--theirs`::
	Compare the working tree with
+
=2D-
 * the "base" version (stage #1) when using `-1` or `--base`,
 * "our branch" (stage #2) when using `-2` or `--ours`, or
 * "their branch" (stage #3) when using `-3` or `--theirs`.
=2D-
+
The index contains these stages only for unmerged entries i.e.
while resolving conflicts.  See linkgit:git-read-tree[1]
section "3-Way Merge" for detailed information.

> Finally, with all this considered, I think it is not so bad at all that
> all options are lumped together in a single line (or remain on six
> separate header lines, depending on the processor). So, I would no
> longer mind seeing this transformed into
>=20
> `-1`::
> `--base`::
> `-2`::
> `--ours`::
> `-3`::
> `--theirs`::
>=20
> for consistency, or

To be honest, this is the form I would prefer because it can be automatical=
ly=20
processed for translation as "do not translate". Any addition involving hum=
an=20
language to a segment requires translation.



Thanks,

JN


