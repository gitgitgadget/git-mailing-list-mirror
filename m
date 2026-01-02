Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E090D207A32
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767362189; cv=none; b=ImOlnuUGgMSIwlnxjwFGiaS5IJAQHxAaJfSBbCakV7bysIOk6NM5fl/j21YOGAPPAzrK/K5G6EpQsdxhaTXGKdvsIvoFgIK8F/htbIkZ6wSXBN6BtmCb4ne7wUG6VPCge5Zv3h1T2HXsX7yTfoArY8M2uCCZFPPoSf6ap2s3zc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767362189; c=relaxed/simple;
	bh=9WStvtVUE53Ps7prFMs9ZtQ8U2xc34LJHZ9MzU1RF2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BfNKIHbSWqzeom0ae5ILiXG+UMcn7KSySmXImmqMmvQW+GUAP54PK+e9MU7gU/B8RVaFI3g9XXD6jYvbH2IP49jQIQEWvCiGxFRRc11ZTSkoiOfeNGjXHvpbu5Ihav/PUMy/fkqYmoEoIA8q0h7BFpNVqIPzMWmj25Fp56kPAfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=lpdr38/B; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="lpdr38/B"
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 5D4C2DF9386
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 14:49:57 +0100 (CET)
Received: from piment-oiseau.localnet (unknown [IPv6:2a01:e0a:d1:f360:4bd1:2f22:1bf8:44cb])
	(Authenticated sender: jn.avila@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 169182003E8;
	Fri,  2 Jan 2026 14:49:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1767361790;
	bh=9WStvtVUE53Ps7prFMs9ZtQ8U2xc34LJHZ9MzU1RF2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lpdr38/B85B5Yfb10UBm5+JcGMEV7cd47taOYbCBYuiq6OO0wbiOMz6UyqCYWyQgA
	 BPRyogX5jlu5UvuqJkK3T7Fg1Mg0DQQRfic2nQWML99+5nZcC3sxehfad/8+mis2Gt
	 pSyQ3OlG/HfB8InOxq4Oa28vlwMn6zmcjFU+Rp3J6wmsYUZg6MKUMW3uzQxfJln7Ib
	 jLns6F27yBq8/Q24Ues1HRwUqnDJw7hnUs4RaeNzGPxTLyeG+NIqdiEHL80jyPXio0
	 PBS/cUOF5pJcsVofkEGhb+9S3Sc0Yx5gIKa6gU+rlb398I3OL6w1s9ZWDmjr637av9
	 faR4il4PkWwcA==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: Julia Evans <julia@jvns.ca>, Junio C Hamano <gitster@pobox.com>,
 "D. Ben Knoble" <ben.knoble+github@gmail.com>
Subject: Re: [PATCH v3 2/4] doc: git-reset: clarify intro
Date: Fri, 02 Jan 2026 14:49:45 +0100
Message-ID: <5953760.DvuYhMxLoT@piment-oiseau>
In-Reply-To:
 <f90be8559f7d1d8362077a6f888687ee8be063b4.1767307382.git.ben.knoble+github@gmail.com>
References:
 <cover.1766103827.git.ben.knoble+github@gmail.com>
 <cover.1767307382.git.ben.knoble+github@gmail.com>
 <f90be8559f7d1d8362077a6f888687ee8be063b4.1767307382.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Le jeudi 1 janvier 2026, 23:43:57 heure normale d=E2=80=99Europe centrale D=
=2E Ben=20
Knoble a =C3=A9crit :
> From: Julia Evans <julia@jvns.ca>
>=20
> From user feedback, there were several points of confusion:
>=20
> - What "tree-ish", "entries", "working tree", "HEAD", and "index" mean
>   ("I have no clue what the index is", "I've been using git for 20 years
>   and still don't know what a tree-ish is"). Avoid using these terms
>   where it makes sense.
> - What "optionally modifying index and working tree to match" means
>   ("to match what?" "optionally based on what?")
>   Remove this from the intro, we can say it later when giving more
>   details.
> - One user suggested that "The <tree-ish>/<commit> defaults to HEAD
>   in all forms." should be repeated later on, since it's easy to miss.
>   Instead say that HEAD is the default in each case later.
>=20
> Another issue is that `git reset` consistently describes the action
> it does as "Reset ...", commands should not use their name to describe
> themselves, and that the word "mode" is used to mean several different
> things on this page.
>=20
> Address these by being more clear about two use cases for `git reset`
> ("to undo operations" and "to update staged files"), and explaining what
> the conditions are for each case instead of forcing the user to figure
> out the pattern is in first form vs the other 3 forms.
>=20
> Signed-off-by: Julia Evans <julia@jvns.ca>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---
>  Documentation/git-reset.adoc | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/git-reset.adoc b/Documentation/git-reset.adoc
> index 9843682e81..71e8f52430 100644
> --- a/Documentation/git-reset.adoc
> +++ b/Documentation/git-reset.adoc
> @@ -3,7 +3,7 @@ git-reset(1)

There are `HEAD` that passed through the style checks.

>=20
>  NAME
>  ----
> -git-reset - Reset current HEAD to the specified state
> +git-reset - Set HEAD or the index to a known state
>=20

Here

>  SYNOPSIS
>  --------
> @@ -15,10 +15,13 @@ git reset (--patch | -p) [<tree-ish>] [--]=20
[<pathspec>...]
>=20
>  DESCRIPTION
>  -----------
> -In the first form, set the current branch head (`HEAD`) to _<commit>_,
> -optionally modifying index and working tree to match.
> -The _<tree-ish>_/_<commit>_ defaults to `HEAD` in all forms.
> -In the last three forms, copy entries from _<tree-ish>_ to the index.
> +`git reset` does either of the following:
> +
> +1. `git reset [<mode>] <commit>` changes which commit HEAD points to. Th=
is=20
makes

And here.

> +   it possible to undo various Git operations, for example commit, merge,
> +   rebase, and pull.
> +2. When you specify files or directories or pass `--patch`, `git reset`=
=20
updates
> +   the staged version of the specified files.
>=20
>  `git reset [<mode>] [<commit>]`::
>  	This form resets the current branch head to _<commit>_ and

Thanks


