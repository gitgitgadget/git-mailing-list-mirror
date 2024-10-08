Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293232AE77
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 04:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728362923; cv=none; b=amm3CeH8/3ESl98p++JARPji+vdIuGAm8inqP6MsmZdEwN5JQXwpboakd4EnkbJloIbNreS8Q2k3EdFK3GzA9zhx7u4sVcgQs2tjAnAJWIDXq8DWz8OxvsuUtXuQHuYuNGreevIBiBxU2U72qMszvdHgBS1YDLKO1BS/7G5E4IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728362923; c=relaxed/simple;
	bh=n8Bc5P3pDMdNnylIGIBCbDzQQWNEk9oYab3X6voypk0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Och0OL+9N6UKGvS6vELYFm9L1xXDJdW/WahIz9vtTzONbdo0/r38af+F2Cnqpl7dclPsvwMJ5qge6bLKv5xQbS+7PxfL7lF3cCmFTaRrXI2U5LF6F3Yv4az/svVP+w4CA6GKJ21Wo5Tif5CUrfvR5lBc7j/AxKtdImexan1oTZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=om94WaUW; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="om94WaUW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728362917; x=1728622117;
	bh=n8Bc5P3pDMdNnylIGIBCbDzQQWNEk9oYab3X6voypk0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=om94WaUWmfdMnD8Yl80k3G3Uv5JoNDXeplSyXdQpLyOm21MhoNJnotLEZ6wOLBogh
	 FJLyLBgZs9yvZeU6aUwNrxcbxKOg8Uf1i4/0mmuUVgpc0EC9+sNcD9facuWzjR1ggt
	 7HENcZckn7SV7XkEzbh1Cwh6hiKztc/RwzbOW/IS8K3t9IZN0p/hiYglO84FdGM4fD
	 E520OxAhzpBWf8siZR4eW/9mCyKPdNpoSl6udWpWxYOgQQcylr1jzf5Yk2p2G3ct4v
	 mrI3B9Dr3kpwUZFfv3J0MZHi1wU/KBDjPStuq73ZqL7UZHC0djdB/xt47yS/GJTA/K
	 7paqktH6J5mLw==
Date: Tue, 08 Oct 2024 04:48:34 +0000
To: cdwhite3@pm.me
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, "shejialuo@gmail.com" <shejialuo@gmail.com>, "kristofferhaugsbakk@fastmail.com" <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 0/3] Link worktrees with relative paths
Message-ID: <u6rg54FdIvyFm4NUV46fJMur4T3aUYUpz2Pim2cw3gHd1966FysdkWjm_awEmjoWrFo8KNmC3_IL1nLmFquHNNtMc106AyMmUvNgZScK84o=@pm.me>
In-Reply-To: <20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me>
References: <20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: bedc4e81b92a2fa8340353388b028f7b4aef1f48
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------5a27aa2a625743c39bd16344d1bb3f90eb6bdc6615468461f5558a3ea69a1f21"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------5a27aa2a625743c39bd16344d1bb3f90eb6bdc6615468461f5558a3ea69a1f21
Content-Type: multipart/mixed;boundary=---------------------78467c442d7652b5ccefaadaf2f1457d

-----------------------78467c442d7652b5ccefaadaf2f1457d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Monday, October 7th, 2024 at 22:12, Caleb White via B4 Relay <devnull+c=
dwhite3.pm.me@kernel.org> wrote:

> Changes in v3:
> - Squashed patch [3/4] into patch [2/4] to streamline changes.
> - Dropped patch [4/4] as it was no longer necessary.
> - Rebased onto 20240923075416.54289-1-ericsunshine@charter.net
> - Updated `infer_backlink()` to return 1 on success for consistency.
> - Swapped the order of `infer_backlink()` arguments for clarity.
> - Clear `inferred` if error occurs in `infer_backlink()`.
> - Renamed `git_contents` to `dotgit_contents` for clearer semantics.
> - Cleaned up `dotgit_contents` logic in `repair_worktree_at_path()`.
> - Replaced multiple `xstrfmt/free` calls with a single `strbuf`.
> - Added a test case covering a failure noted in a separate patch series.
> - Improved commit messages.
> - Link to v2: https://lore.kernel.org/r/20241006060017.171788-1-cdwhite3=
@pm.me

All, my apologies for the patch corruption in the first two revisions (I s=
uspect
it was due to my SMTP server). I've submitted this v3 series with b4 using=
 the
public submission endpoint and I think it turned out much better. But plea=
se let
me know if you have any issues.

Thanks!
-----------------------78467c442d7652b5ccefaadaf2f1457d--

--------5a27aa2a625743c39bd16344d1bb3f90eb6bdc6615468461f5558a3ea69a1f21
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnBLmSCZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAACUuwgAr4cS8s2f2A028nPYFv4VrhCK6B3hyvQ+kvUZLQBugGYnyBwD
d9lUPi7nJeTgaLL+qs3cjqlIMfHjura8dFgCtXX0g1IsSvMO9as2ztlxw8KK
2G7FvIFDccL0kiz6N65cz4wZLCbPmjSGJrYLIj3IoIypmlhPqU/VRrzJYdy7
v+NtBKXahkSqYUbAzlgboR8M22ij0JCGTik4W6332JyLwTxnfK4hsIQ0uT7m
QiT7ysGBKAI2Y3HtYxWT4C+Xrv4aWbOtiUAMiACUwtwm7d9LPwOiE37nYMdo
3H3+/IqRLnerOIK0lAIlHJqPH/kDlGV5tuR6fLkXW1Y/yJ2kpXzyhQ==
=hRZI
-----END PGP SIGNATURE-----


--------5a27aa2a625743c39bd16344d1bb3f90eb6bdc6615468461f5558a3ea69a1f21--

