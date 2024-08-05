Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E681316A397
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 19:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722884583; cv=none; b=KCDdUq03Oy/UDRV/dzn+T0+HF3d93nGn/zOJKd0lyuk7NiMPGt4JFYFur0sibi8VqaQ3WN9TrTx94R6j/4GUnTqDmQkjC5WwBo7y1Mbfi31t8hSQZzElR9e1Tuj9bucSdbd0854uXQ/CqQmvJJ/rs4O2MivBWVpbXaxoEPFx03o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722884583; c=relaxed/simple;
	bh=lfdLGdTiMH0bBynYIKiJbKzf/a3c6ktDP9XeTbyMD9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oxn+Zqm8ApZfu5e19FzUxjni6uS9GYE7wZlv6fO4y7MTNYwfK41y2Qn6cQ0TvNpaUNpnPWIZjlhWZbpNHV5z9scLmccf6EtcOZk8lSfiTJZ9oLcG9V7wujZ5rARZyTQGZFi3TuVyOjxni8auVzmLbYqpy4YxTccIemGweR4Zw7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=SI6wENku; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="SI6wENku"
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 573B773C16
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 20:51:30 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:30d3:2eb8:e210:da4b])
	(Authenticated sender: jn.avila@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id 46FDA6016A;
	Mon,  5 Aug 2024 20:51:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1722883883;
	bh=lfdLGdTiMH0bBynYIKiJbKzf/a3c6ktDP9XeTbyMD9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SI6wENkuOoONHF0ueCg1+wleuwwynrlpntxBtYmX5zF3WU3cRNMT87s50LXXzViDM
	 clcBLu4txOc7qSte4OOE3qLKG/U8LTdFucDo5TAlEnWhAj1xW1PimZDhcazLx7ZVvm
	 hJByXH0dkTQ0XF7tP+pW+NbfAdWUsyVC+aX+ZWlpyhCihItjfA9YBk4+aSTJveEKUf
	 0v8upYTpbQqa+gj+a90iMpoHbQ8RaKIouv7GBVL8VZ++QIyYidc8j2RBQ0fF8QVK7h
	 7K4EHP0QQ1yv2S9WNxyMAkicni01fqx+lRbjTluFvsBi3LEckWL8DPEz/FfVb82apw
	 /yBAtSvSpck1Q==
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:
 =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] doc: git-diff: apply new documentation guidelines
Date: Mon, 05 Aug 2024 20:51:21 +0200
Message-ID: <5803739.DvuYhMxLoT@cayenne>
In-Reply-To: <ZrCXK8AmGSFwyqI4@tanuki>
References:
 <pull.1769.git.1722801936.gitgitgadget@gmail.com>
 <515ddbf1dceacc0c186e3d31c13e76a5afc6c45f.1722801936.git.gitgitgadget@gmail.com>
 <ZrCXK8AmGSFwyqI4@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday, 5 August 2024 11:11:07 CEST Patrick Steinhardt wrote:
> On Sun, Aug 04, 2024 at 08:05:32PM +0000, Jean-No=EBl Avila via GitGitGad=
get=20
wrote:
> > From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
> >=20
>=20
> Nit: please provide a summary of what adaptations you made. It would
> certainly help the reviewer to learn about the recently-introduced
> `[synopsis]` style and why/since when we use backticks and underscores
> for formatting.
>=20
> The same also applies to subsequent commits, providing some pointers
> would certainly help an unknowing reviewer such as myself.
>=20

Thanks for the remark. The context is effectively missing, so I'll restate =
it.

> > @@ -225,11 +225,12 @@ CONFIGURATION
> > =20
> >  include::includes/cmd-config-section-all.txt[]
> > =20
> > +:git-diff: 1
> >  include::config/diff.txt[]
> > =20
> >  SEE ALSO
> >  --------
> > -diff(1),
> > +`diff`(1),
>=20
> This one looks curious to me. Why is this item formatted differently
> than the next three? I would have expected it to be formatted as
> something like linkgit:git-diff[1] instead of `diff`(1)`.
>=20

Here we are referring to the 'diff' command, not git-diff. That is why we d=
on't=20
use the linkgit macro (which is used to generate cross links for html outpu=
t).

Still, the general format of a reference to a man-page is to put the comman=
d=20
name in bold, which our filters get by backquoting.=20

> Patrick
>=20
> >  linkgit:git-difftool[1],
> >  linkgit:git-log[1],
> >  linkgit:gitdiffcore[7],
>=20

Thanks


