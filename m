Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8A218BC1C
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 22:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728252114; cv=none; b=IZ2OCD0rdBoukqrfoAXPStWOyIqE82rJU0gM2+t3vE2A5v7qMxITJ9jfvd3n6KBLoGIrZPpqrBaYMtO/0vuGXxeyysP/HgAG0h4UH/sb+JQor9tswtJbmm9vTH6lJn8jGHn/nXVFot4PS8BkUbY2Iz95UfrCRndGkgP/M6Nlt54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728252114; c=relaxed/simple;
	bh=g+eIAoLBZoB9T6iCxIMLzmPMm4QmVL7C6Fc0TSfts00=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jWdJc4G058spJhGKru4QraNDoPyEz5RaYV8B9kglcQiGNSLuZ7MFJLzOTTrfuJsaYmHe1rUZNBtRZFwRsq67LTaZ+Rbqws5D48hdH+zEcQqOLn6JKKJOyL+R/9/y8CvMLKBmNFsALAfM4WipjymsAWxyUgG1Phk/xcq1UhMFr14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=oT7yPdPd; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="oT7yPdPd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728252104; x=1728511304;
	bh=g+eIAoLBZoB9T6iCxIMLzmPMm4QmVL7C6Fc0TSfts00=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=oT7yPdPd/YnrT0WVeddlvZN6tkv37gNbboJHJfOG4dqq0PxOeGRxtg2QRDn0himm4
	 FGwIBVQR/8OrEuTgvAVPaGXhvX6n9e8o6KCvjM0giJseuu9TKKTA+QofrsJ85p0pgw
	 ry5c1nSda3+Y6DEvtXGPKiBNMCNlwMz3M9uVd65l9dDo1IDmoXYlgxFqHpuDQ9zc4t
	 SHH7zPMzrveLmFKbs8ZW9StQvMx16d7c8gI5WFuibo5nwmi+dOo0cXwkH7I9/nNbe3
	 RC3b+QzgCuQ+z3ektqFpp/kddaLDiBZSMcu9fyKQeC6Cgx/xt9DpVAiC0Syi94gQvA
	 2z/SKEh9Ak3pw==
Date: Sun, 06 Oct 2024 22:01:41 +0000
To: Eric Sunshine <sunshine@sunshineco.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] Link worktrees with relative paths
Message-ID: <gZ9_OcXpHKqABP0c_FH7EVpjzCD92RASyYoDkrhhrxzrbKvx5duIaXIrVOK45bmglyrLHrQ6SR4YVtMwU6BGqw1_TWs7rHk_lNderVONljY=@pm.me>
In-Reply-To: <CAPig+cTVbXVffSeyNAV3c0zuSUozY7giWtMw3GpHs+xVEpaNvA@mail.gmail.com>
References: <20241006045847.159937-1-cdwhite3@pm.me> <CAPig+cTB-sA-g4cdhfEjWwY1mnbWJ41e=bOCNwp=Y8JKvpmpRg@mail.gmail.com> <CAPig+cTVbXVffSeyNAV3c0zuSUozY7giWtMw3GpHs+xVEpaNvA@mail.gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 36de8182cf84fc0a1f89790d4670517469e86901
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------4337a435b40049114c0967100ff26e1c5b6bd411570729f01032f355e812b221"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------4337a435b40049114c0967100ff26e1c5b6bd411570729f01032f355e812b221
Content-Type: multipart/mixed;boundary=---------------------02f86827e435d46dea55a46802ef020f

-----------------------02f86827e435d46dea55a46802ef020f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Sunday, October 6th, 2024 at 00:11, Eric Sunshine <sunshine@sunshineco.=
com> wrote:
 =


> Also, since you're touching infer_backlink(), see [1] which makes some
> changes nearby.
> [1]: https://lore.kernel.org/git/20240923075416.54289-1-ericsunshine@cha=
rter.net/


Thanks for the heads up, what is the best way to move forward on this?
Should I base my patch series on that topic branch or bring in that
particular patch?

> And you might be interested in [2] which may indicate that there are
> some holes in the tests around worktrees which might need filling.
> (Since your patches are whitespace-damaged, I haven't checked whether
> your series succeeds or fails in the way the series to which [2] is a
> response fails.)
> [2]: https://lore.kernel.org/git/CAPig+cQXFy=3DxPVpoSq6Wq0pxMRCjS=3DWbkg=
dO+3LySPX=3Dq0nPCw@mail.gmail.com/

I just ran through the scenarios you described and everything works as
you would expect. This is because internally the code handles both
absolute and relative paths, and the worktree.path has been updated to
always be the absolute path. I will make this clear when I rewrite that
patch's commit message.
-----------------------02f86827e435d46dea55a46802ef020f--

--------4337a435b40049114c0967100ff26e1c5b6bd411570729f01032f355e812b221
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnAwi2CZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAABNVQgAqAaiSSDnx4/Mqn9IcHt0AD33SQ50wDd/yBLotbynZ75LAQBd
+/+18Fyp83eWQZGHiecGWieaa1WJU6OmI+NdjLpl5i9LXF3aIp69RV+tAmjT
89Or50V4+PpiNNKoj9vGBOxDh+876XpsxB9WR1Id2Nkd6aJ3Erx7KYk2iEDF
d/8d1FWJaF0pDxB3xQXABhxolHFNZTmqHjzbj/9xw/Q1T4vhN77VZx09cls+
BSlby7gCs8TIE7/+vZGU2fKl0jxwxEFEYSViNC+IPLGa5lJo5UobD7RUb9RR
tFujFPnVwm21Xexcz+cphvWhmEol3uNXTyQ73Pn1V/6XMKEzxdS47w==
=X68u
-----END PGP SIGNATURE-----


--------4337a435b40049114c0967100ff26e1c5b6bd411570729f01032f355e812b221--

