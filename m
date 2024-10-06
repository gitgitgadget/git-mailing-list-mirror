Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046105733A
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 23:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728259050; cv=none; b=LOTZJtp4f9HsKbVLS2p8zAZiP9mA7/ZWuE6XZaNGscY+dyR23hSvzCZW44WhYDQDzGT703bWX1czCA8cc1BfQi+kabIAeo9muGBNaQqS2/t/NohALCqVks7bRUA9QFusxWMC/Fj9GrGmEEWVt88fcgyG9eP77dK323D6aBr3geQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728259050; c=relaxed/simple;
	bh=i7JxQtrvFMNAkJ9CsmdnV8gbGT0keYkAp3sjEG8c8YI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g8KTXXal1ctgI2RpHG2vF2sr2C0/CLZSyIQyJD1It+zU2DzBjFH3F87BS8k6jhtaTNyidbGrqrOmEnUtqnM+my46sqw8TmGdXly3fGp9aRQdVu/gX1ndMHVEHWwjsb7yytUCvNiftq8B1GhWpo+17u1AtPhVKyZ7Jncjyrur+Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=GKmyJbOX; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="GKmyJbOX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728259046; x=1728518246;
	bh=i7JxQtrvFMNAkJ9CsmdnV8gbGT0keYkAp3sjEG8c8YI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GKmyJbOXNexUgiK/BqufeXr24jYZ/QiJFHg3wMgHt2WXtiX5dD7BHBCc7TTdIeY2Y
	 eNnWT4wxd6ggcI65DYXO8OEwHnn/P7jZU+1k9VvywZUg623SnZM2Gec0lRvaG2bxQ6
	 IUnQQtdN9Z1kE3tPUEhKSF4OrYh8N8D2KdWqQyR9oDlSZQqWEA7KuZMyAre/K8AiJd
	 Z+HzOIa0iQgkD7m53vwLSOxdrabe0CZ24PEB6i6yvcnSDpWPEKzPDYRm220em6yyNh
	 tB6FVrKaBD5h0kirVs5HAxt4Hpc+n9mNTgXiL5PF82S9f4JEdU56rRUjFxjWxu3yHN
	 gAQgNLJzpUlDw==
Date: Sun, 06 Oct 2024 23:57:22 +0000
To: shejialuo <shejialuo@gmail.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] worktree: link worktrees with relative paths
Message-ID: <I3BmSHTyOELt2DzfSaLhRYLouu5iAPZIZGZ2Ne73AygO35CM0mq44INa68t6VD4XV61DgzbrfUW0m8fivd3N9Rejgm-tecXQHXQRs1BP9CQ=@pm.me>
In-Reply-To: <ZwKuptTMf9ECd-kf@ArchLinux>
References: <20241006060017.171788-1-cdwhite3@pm.me> <20241006060017.171788-3-cdwhite3@pm.me> <ZwKuptTMf9ECd-kf@ArchLinux>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: ac3013c9570f61b0e6cfcadfcce62ad657d22ec0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------1ee573ac3c9a81a9d72ff0472dbe6b6ed661adceaf512f0ae341327b40f74ad5"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------1ee573ac3c9a81a9d72ff0472dbe6b6ed661adceaf512f0ae341327b40f74ad5
Content-Type: multipart/mixed;boundary=---------------------f6cea190bbaf674df6eaf9684f0ba307

-----------------------f6cea190bbaf674df6eaf9684f0ba307
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Sunday, October 6th, 2024 at 10:37, shejialuo <shejialuo@gmail.com> wro=
te
> Eric has already commented on this commit message. I think this commit
> has done a lot of things which make the review painful.

My apologies, I will do better on this commit message.

> Do we need reset the "sb_tmp"? I guess we do not need, "relative_path"
> does not care about "sb_tmp". It will always reset the value of the
> "sb_tmp". So, we may delete this line.

You are right, this is reset by relative_path(). I originally encountered
a bug and I thought not resetting this strbuf between relative_path() call=
s
was the cause but it must have been something else that I fixed.

> Still, we do not need to call "strbuf_reset" again for "tmp". But there
> is another question here. Should we define the "file" just in this "if"
> block and free "file" also in the block?

The style this code uses seems to place most / all of the declarations at
the top of the function and frees at the bottom so I think this fits in.

> And I don't think it's a good idea to use "xstrfmt". Here, we need to
> allocate two times and free two times. Why not just define a "struct
> strbuf" and the use "strbuf_*" method here?

I can use strbufs, I just wasn't sure if I really needed a strbuf for
each of the paths and was just trying to reuse a var.

> > strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
> > strbuf_addf(&dotgit, "%s/.git", wt->path);
> > - backlink =3D xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
> > + git_contents =3D xstrdup_or_null(read_gitfile_gently(dotgit.buf, &er=
r));
> =


> =


> Why here we need to use "xstrdup_or_null". The life cycle of the
> "git_contents" variable is in the "repair_gitfile" function.

This what the existing code used and I saw no reason to change it...

-----------------------f6cea190bbaf674df6eaf9684f0ba307--

--------1ee573ac3c9a81a9d72ff0472dbe6b6ed661adceaf512f0ae341327b40f74ad5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnAyPSCZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAADSdgf9HNGDeXkl9xDP+9zsVTJ8fOroNalH9zFNt/FTHECOjB1vR+Nl
HIvhlpcSJ1/vGlGjTl4mHut/CNOYhK3rXUaO2l/nYJwfz1Jy48ij7zK6kKHd
ZvATSHLWkj8KtL+CjIoDt+yxOT8AUYY087WSm92ohxTpflyBq40475wjSl9I
73xF2bA3HoJhtxRapolfM+AN+APkpTmaPpeNZFWXgk01v5iYXnrRcQLrojDP
zDonR9K68SH2FefE1PbWMkkUqS679fO1yNq3r4eRe9Wcl/B1l30LEJPfP4WN
4Fbw0QexYjZ/dH1/zdEMCJX91BQKtVuA50eZ26Y8HKMsC77nzsInUQ==
=nryI
-----END PGP SIGNATURE-----


--------1ee573ac3c9a81a9d72ff0472dbe6b6ed661adceaf512f0ae341327b40f74ad5--

