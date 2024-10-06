Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652621C6B2
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 22:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728254240; cv=none; b=ogVyoBr+XSsokN+Tg7GRzy5cIX1w8qw92AmiypACt/3sOSbN637EW4qe3nYjVN6vnLsI6eV+wYTgOLJKSBXPpJRHM9AU3aSbR+5NSugsND+1SkG6zkCN1qSEtfmnZKI7aYVBYjnu8+X5vslGZAR949MSwMFsSVBkTW0l5NA7Xcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728254240; c=relaxed/simple;
	bh=FiCh7lD6TVmNPwVmbT2JJFuHLyDn+DK1ihZ+HOj5dzY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MFwHG+hD5qi41sTApweRc3gGbaxVnwD9j3iPyuZIROQVAijCSL6B31tVTAi717llpG4jDYAlT6d8BOZLzxbVOG88FJLjrezilzEbMYQEXSmmCpqkDNuyzgyBbE+zvLt4KEdWcayBHSmPH6iAcBMpewOSRS7ePtpnbK+tZCsyAO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=F/9cQ49H; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="F/9cQ49H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728254233; x=1728513433;
	bh=FiCh7lD6TVmNPwVmbT2JJFuHLyDn+DK1ihZ+HOj5dzY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=F/9cQ49HSL3A2VE4qW+Wv0ylPMD3vhjroGmUlQk1AmgzlL/OMQGvAQ61Gt/OIOjeT
	 /A+hzbXoB5+GaeDUTrYtL7rYdi6TTHCrHpjc2TzuR+//zCEr1gYPB/7TqjokE/tQlF
	 vf/xmpOpag2aVEAgZFsFtOhIGIpo6A+AeaEtXqOqpeezRNH7ud9iglAobJo5qeBNx3
	 rmtsuIq9QGypqbH+zE0DoJx3fWct2hq3cd7NJBrhcPAi+H2j6nRaXDEcEyHOxJoDg+
	 NwpTpkOcJN7HT0S1uReE2otyyBlhELGs2hNEbCISJcrblmyerpLaWjJk11E39LCkAb
	 Ip+RnKmedHUjQ==
Date: Sun, 06 Oct 2024 22:37:10 +0000
To: Eric Sunshine <sunshine@sunshineco.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] worktree: link worktrees with relative paths
Message-ID: <Iucjq772bnnbBMdH1gDVwBhFAV3BVYQ7ZUdnWArbWM1wq_9x3-OTG8DsOUatJh7GORNRYWDDZaVVlSj4VQy1y4RysqlFKvdpNiVswDdfQ5A=@pm.me>
In-Reply-To: <CAPig+cT5BHuWMrjefP9BMocE7EFXgzRyHMFbUmEZv73F4g+XEQ@mail.gmail.com>
References: <20241006060017.171788-1-cdwhite3@pm.me> <20241006060017.171788-3-cdwhite3@pm.me> <CAPig+cT5BHuWMrjefP9BMocE7EFXgzRyHMFbUmEZv73F4g+XEQ@mail.gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 4bcb97b721ed6abd862766742408fca6755e80d5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------7618e347f1231aa3d9d2d56ae46be976739c1461e4e91ff988f3a4a1eed4f93e"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------7618e347f1231aa3d9d2d56ae46be976739c1461e4e91ff988f3a4a1eed4f93e
Content-Type: multipart/mixed;boundary=---------------------d972f08b5f557e25759c9382d99d9ebc

-----------------------d972f08b5f557e25759c9382d99d9ebc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Sunday, October 6th, 2024 at 06:05, Eric Sunshine <sunshine@sunshineco.=
com> wrote:

> When you reroll, please extend the commit message to give a more
> detailed overview of how this patch actually changes the behavior both
> at a high level and at a low level. This is especially important since
> this patch is sufficiently long and involved that it's not easy to
> glean these details at-a-glance from the code changes themselves.

I will do that, I was not sure how much low level detail I should dive int=
o.

> Regarding what you wrote above, there seems to be a good deal of
> redundancy between the first two paragraphs; combining the paragraphs
> and folding out the duplication might make the message more
> streamlined. I do like the discussion about containerized environments
> being used as (at least one) justification for employing relative
> paths, and think that may be a good lead-in for the commit message.
> Please see [1] for some helpful hints for composing a good commit
> message.

Thanks, I will clean up the redundancy and add more detail to the commit.
-----------------------d972f08b5f557e25759c9382d99d9ebc--

--------7618e347f1231aa3d9d2d56ae46be976739c1461e4e91ff988f3a4a1eed4f93e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnAxEHCZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAAAWNAf9Ewiw3aSOYGe5544LYzqlP6qQCrQ/Br7ewrZlE0JTMuvpNveR
J8wAkwHVnUdUZQbVBmwLO3dH3yGEh6U3iPeHJF2oWc5vEUTatIV+A4b/EIN5
fk7ddIi83QFVccmkhnr6y7sX9Wgz4Tbf1Lc18KjorA1SazNSKh/HuOqdxqqk
ZlG/IrU7b5rEkb0HzXvM1vPb5Sq0kYgqr7h04RxWWgeA6nVPlwMyDu2A2+qF
KhXJjnsGu5BpLdrZzdZOwLXb+Gy+kopPGM+nJ+YxjNn8eFANyu+SUsOPLD+e
cq5dtRi96R839z3Bz9vj5s2AfX+uJPFULqOb8gb3ZCvSNj1vA+AxwQ==
=A5cp
-----END PGP SIGNATURE-----


--------7618e347f1231aa3d9d2d56ae46be976739c1461e4e91ff988f3a4a1eed4f93e--

