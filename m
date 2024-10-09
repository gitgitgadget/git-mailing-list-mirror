Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6AF52F9E
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728498865; cv=none; b=e+e8sNBaFzh7Bb2DukFzFWzrjYzV92EVn1HioiObik3kZ4EhzJSjfO7/SsmIrH4CJInj+OWWTa1bnlVA0wtszHJVhytIDGzVMoOBM+ofSdT3+K+GUCpXMAaOJda5bdjCqPhDbGb5Fn7vC5ilJo3S/K85rOyn5N7b7c4c4BRFL5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728498865; c=relaxed/simple;
	bh=nzF7/gZnqex0G1GCJKdgvIrovum8baRJ0hZY3GEBIhc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTtA4qMxPU0j8QFAbVO2GOU0tnMepKHiqXOIROcu8fCA2DV8wT3PmtA88y4C7cLQ/uXYG6149SL9mSqEUkjzUzQt3C/abGqpY/B0UocT06qRDyrOVBP/on25od0jeJ8ImsNGgOWd0f7X/Ury+0tbYUfV74UOv3WUv00EpU6R0nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=H4/rRdXu; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="H4/rRdXu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728498855; x=1728758055;
	bh=14J9LVAbE/pmZYZtJ3pVK3hv2kWHkgBmz0zWwy5u87k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=H4/rRdXuGHtp4L4dIFguoRBR9XBF0xVFNwZvaqqWeX0C7GFJhhN0RtbGs68JyhmxB
	 0cGB8ab+a/iFUHZ/8mWg7r2nu0QuyeCk9/2DRpW/Jp0+q4uor2CBA+ktCRhUYEVNhE
	 5jWU60bRBaiNIxyJtuBMlB45ofHAz8tZQdjxlF2vHwxvKtExwjmm+sIuFd6zmXQIGf
	 LaxYxuraGikSAiNAw8DfqWsTgo1MV066/WYrZdhohdrbuDTayiYO2bSac6zxQl1PX/
	 jvVoK6XZR+FLbByJ3gGFSBFEh3lE1zrNLruCR1Xr083yama/Hs7dimwm1qNyA7fDuK
	 LJDrsOBFSd4zw==
Date: Wed, 09 Oct 2024 18:34:10 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Caleb White <cdwhite3@pm.me>
Cc: Caleb White via B4 Relay <devnull+cdwhite3.pm.me@kernel.org>, git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] worktree: link worktrees with relative paths
Message-ID: <k3X5W4US76LBJ_IUq-quVRha2jd-4iWJ9yX6Ukh6-ifZdWC3iajoUJ8VUyTDfkJHSqiD1RJlqIuVlDGIsReR_SDREVWyHGIqsXhazvJu1ek=@pm.me>
In-Reply-To: <xmqqmsjexkcg.fsf@gitster.g>
References: <20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me> <20241007-wt_relative_paths-v3-2-622cf18c45eb@pm.me> <xmqqmsjexkcg.fsf@gitster.g>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 7419193fc0094a70924004cdeb65f571b3e7cd2c
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------be1c9fc96d97a2e3d6c0bccfed5abe3fc8fc46df0a006f3488f46f84580c3764"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------be1c9fc96d97a2e3d6c0bccfed5abe3fc8fc46df0a006f3488f46f84580c3764
Content-Type: multipart/mixed;boundary=---------------------dbb4a239b2cfd1593c00f17b69328661

-----------------------dbb4a239b2cfd1593c00f17b69328661
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Tuesday, October 8th, 2024 at 18:09, Junio C Hamano <gitster@pobox.com>=
 wrote:

> Caleb White via B4 Relay devnull+cdwhite3.pm.me@kernel.org writes:
>
> > From: Caleb White cdwhite3@pm.me
> >
> > Git currently stores absolute paths to both the main repository and
>
>
> As always, drop "currently".
>
> The usual way to compose a log message of this project is to
>
> - Give an observation on how the current system work in the present
> tense (so no need to say "Currently X is Y", just "X is Y"), and
> discuss what you perceive as a problem in it.
>
> - Propose a solution (optional---often, problem description
> trivially leads to an obvious solution in reader's minds).
>
> - Give commands to the codebase to "become like so".
>
> in this order.

Thank you for the feedback, I'll reword this. This is my first patch serie=
s
to this project (and my first mailing list patch submission, so I've been
learning a bunch), thank you for bearing with me! :)

> > linked worktrees. However, this causes problems when moving repositori=
es
>
> The above claim is way too strong. When relative references are
> used, you can move directories without problems only if you move all
> the worktrees and the repository in unison without breaking their
> relative locations, which is an exception and not the norm.
>
> The repository knows where its extra worktrees are by their
> absolute paths (and vice versa) to allow discovery of each
> other. When a directory is moved, "git worktree repair" must be
> used to adjust these references.
>
> It however becomes possible, in a narrow special case, to do
> without "git worktree repair". When the repository and the
> worktrees move in parallel without breaking their relative
> location, the repair operation becomes unneeded if we made them
> refer to each other using relative paths (think: tarring up both
> the reposity and the worktrees at the same time, and then
> untarring the result at a different place).
>
> or something, perhaps.

I can reduce the strength of the language and add some better examples,
however, I believe this scenario is becoming more common. There's been
a rise in popularity with using worktrees in conjunction with bare
repositories that take the following form:

    /path/to/repo/
        .git/ (bare repo)
        master/
        develop/
        feature1/
        hotfix/

Essentially, you create a directory to act as the the "repository",
then you `clone --bare` the actual repository to `.git`, and you
create worktrees (there's some other steps that need to be performed
such as updating the refs to point to origin, but this is essentially
it) as needed. This pattern has the following advantages:
1. For high volume projects, this allows you to use worktrees to quickly
   switch between contexts. I might be working on a feature at work
   when I quickly need to switch focus to hotfix something that broke
   in production and I don't have to worry about committing / stashing.
2. This avoids polluting the parent directory with the different
   worktrees. I tend to have a directory that houses the various
   repos I work on, and I don't want to have worktrees intermixed
   with other repos.
3. This keeps the `repo` directory clean so you don't have worktrees
   intermixed with your source code on the main working tree.

In this pattern, everything is self contained inside the `repo` dir.
Moving this directory or tarring / untarring it (as you mentioned)
should not cause the links to break and require repair. Granted,
this is not the only use-case which is why both absolute and
relative paths should be supported.

> > Although Git now writes relative paths, existing repositories with
> > absolute paths are still supported. There are no breaking changes
> > to workflows based on absolute paths, ensuring backward compatibility.
>
> Good. Being able to work with existing repositories is an absolute
> requirement. Are there good test cases? I would imagine that you
> would need to force a worktree and its repository to refer to each
> other using absolute paths and then try to access with the updated
> code, perhaps moving one of such "old-style" directory and then
> using the updated "git worktree repair" and observing the result.
> To allow such a test possible, you might even need an option to "git
> worktree" to allow it to create these linkages using absolute paths,
> not relative (and if you need to keep both possibilities anyway, you
> might make the newer "relative" layout an optional feature,
> triggered by a command line option given to "git worktree add" and
> friends).

The tests passed before and after, but there's no tests that explicitly
use absolute paths. I can add a `worktree.useRelativePaths` config/cli
option. I was trying to avoid this, but this may be best to offer users
the most flexibility. With the addition of this config value, I might
split patch [2/3] into two patches: the first will handle reading
potentially relative paths from the files, and the second will add the
config option and handle the writing of relative paths to the files.

What's the best way to parameterize the worktree tests? I would like
to run the same tests for both absolute and relative paths and I'm
not particularly a fan of just copying them all into new *-relative.sh
files.

> Have we considered how badly existing third-party tools, that has
> learned to assume that the paths are aboslute, may break with this
> change, though? Or is this "we won't know until we inflict it on
> real users and see who screams"?

The `worktree` struct that's used internally is populated with the
absolute path, and `worktree list` and the porcelain options return
the absolute paths to the user, so third-party tools should not notice
a difference if they're using the api. The worktree docs even include
the following warning:

    The rule of thumb is do not make any assumption about whether a path b=
elongs
    to $GIT_DIR or $GIT_COMMON_DIR when you need to directly access someth=
ing
    inside $GIT_DIR. Use git rev-parse --git-path to get the final path.

so third-party tools really shouldn't be reading the files, and I'm not
aware of any that do, but we can monitor for feedback once users start
using the change.


Best,
-----------------------dbb4a239b2cfd1593c00f17b69328661--

--------be1c9fc96d97a2e3d6c0bccfed5abe3fc8fc46df0a006f3488f46f84580c3764
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnBsyTCZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAACKNAgAl7k2rxkJeeVbWUxe/pms36In5aD0RK8LcV5Q1CzM4dBab+8Z
zp4ZQVP0BUwj1oOnrwxplWPlq3qzBNeYLwrDziB9jY3fKmnABT79rggbmYtI
6rNHIsNDJW3hS75pEstLkw4Ff5z2TjCdR7OM0u9xM6xVchB/Sy8v+vuCcTnF
8+4dkATRxgnr5A01KSZRk48xs4Q4jxM6NrmYfm8lINu3HnQg7cj3qijFGgxp
TUIpSFCzAOPoPdvjRSXm+wISDKqHN/KGBT47btMMV7j+F1Q5pgkTHZ1WOqou
HFqetL973X0CqqAvrWlhRospCA2O6Z5xcvxtggbtDyg+onifaMj60g==
=sNPX
-----END PGP SIGNATURE-----


--------be1c9fc96d97a2e3d6c0bccfed5abe3fc8fc46df0a006f3488f46f84580c3764--

