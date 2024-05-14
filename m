Received: from 20.mo583.mail-out.ovh.net (20.mo583.mail-out.ovh.net [91.121.55.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7945B1802A1
	for <git@vger.kernel.org>; Tue, 14 May 2024 19:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.55.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715714821; cv=none; b=FU3MuB/cbQyV5LLXPxF115WstTd0SkxKgeky4eX5XO/3zfAkAsxH00Irw2di24bQyWlXp1QTppF9PYokkyoLKWh+O03u1lCXpi6f24sAHqU0DMzAADw+0NoLrv030upEFN0m0nNczVbu8zbghPqvK3uy0SlcQn9ycNBHFWLVN0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715714821; c=relaxed/simple;
	bh=sY5L7R5vOvkNsq00lEGIY2QKWOQxPxpF6yIXqeNMguY=;
	h=Content-Type:Mime-Version:Date:Message-Id:Subject:From:To; b=bvlmRSpKDjdsVEcZEvENikgFzcDgrdgoyB2EknqQjl1LZDQ65CHiTQL8DyLzmfkHJQyi4LnYkDWMsMB1kYC2AhrvrOVl2qBMG7ON03Y0fHSX5qvNwD1zTvOFDl5GwHBKiHxHyzL2gJ/Z+xOon66Gc14IYpq50cxom/o3ADZ7AI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strongly-typed-thoughts.net; spf=pass smtp.mailfrom=strongly-typed-thoughts.net; arc=none smtp.client-ip=91.121.55.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strongly-typed-thoughts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strongly-typed-thoughts.net
Received: from director5.ghost.mail-out.ovh.net (unknown [10.109.176.72])
	by mo583.mail-out.ovh.net (Postfix) with ESMTP id 4Vf4hD4lXWz1DPF
	for <git@vger.kernel.org>; Tue, 14 May 2024 18:31:56 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-x8rbc (unknown [10.110.113.129])
	by director5.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 7ECBF1FE02
	for <git@vger.kernel.org>; Tue, 14 May 2024 18:31:56 +0000 (UTC)
Received: from strongly-typed-thoughts.net ([37.59.142.97])
	by ghost-submission-6684bf9d7b-x8rbc with ESMTPSA
	id Tqy/HByuQ2Yw1QIAVddejQ
	(envelope-from <hadronized@strongly-typed-thoughts.net>)
	for <git@vger.kernel.org>; Tue, 14 May 2024 18:31:56 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-97G00223fcc50d-9769-43b6-bfa1-6ae73d753498,
                    DD3B9C83DD9E44B838259978FAD451B914511980) smtp.auth=hadronized@strongly-typed-thoughts.net
X-OVh-ClientIp:193.250.76.216
Content-Type: multipart/signed;
 boundary=40eed3404897462763e9a80a690e74a1ddba21adca4e12fa1d86e6db438c;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 14 May 2024 20:31:55 +0200
Message-Id: <D19KZ1CBA7JF.27PYPL5X68543@strongly-typed-thoughts.net>
Subject: Author signature
From: "Dimitri Sabadie" <hadronized@strongly-typed-thoughts.net>
To: <git@vger.kernel.org>
X-Mailer: aerc 0.17.0
X-Ovh-Tracer-Id: 12545902664953835515
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdegiedguddvgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurheptgggfffkuffhvffosehgtderreertdejnecuhfhrohhmpedfffhimhhithhrihcuufgrsggrughivgdfuceohhgrughrohhnihiivggusehsthhrohhnghhlhidqthihphgvugdqthhhohhughhhthhsrdhnvghtqeenucggtffrrghtthgvrhhnpedtieduhedvveekkeegteeihfejvddtueejleegffefjeeftdekjeduudeikedvudenucfkphepuddvjedrtddrtddruddpudelfedrvdehtddrjeeirddvudeipdefjedrheelrddugedvrdeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhephhgrughrohhnihiivggusehsthhrohhnghhlhidqthihphgvugdqthhhohhughhhthhsrdhnvghtpdhnsggprhgtphhtthhopedupdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekfedpmhhouggvpehsmhhtphhouhht

--40eed3404897462763e9a80a690e74a1ddba21adca4e12fa1d86e6db438c
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hello!

I=E2=80=99ve moved away from the PR/MR git workflow to the email one and I=
=E2=80=99ve
been delighted by it. However, there is one thing that feels a bit like
a regression to me.

On the PR/MR workflow, if someone wants to contribute to my project,
they can simply make a couple of commits and open a =E2=80=9CPull Request=
=E2=80=9D or
=E2=80=9CMerge Request.=E2=80=9D Once reviewed, I can decide to merge via s=
everal
options:

* Creating a merge commit.
* Rebasing their commits.
* Asking the UI of the (centralized) system (GitHub, GitLab, etc.) to do

Whatever is decided, the commits end up in my repository and the author
might have signed the commits and their signature is still there.

With the email workflow, from what I understand, `git am` has no way to
keep the signature of the author =E2=80=94 and I have not found anything go=
ing
that direction with `git send-email` and `git format-patch`, and I think
that the reason why is because the commit is modified to introduce the
committer (committer being me here; the author being the contributor who
sent the patch), whence the commit SHA changes. The author signature is
simply dropped, and `git log --show-signature` only shows my GPG
signature; not the author=E2=80=99s anymore!

So=E2=80=A6 I was wondering: since we can only sign commits, is there any
way / work in progress to attach the author signature to a commit? To
me, it would make sense to have something hierarchical: the comitter
simply signs above what the author signed, and the author doesn=E2=80=99t s=
ign
the whole commit (I guess?), since we want to be able to change the
commit hash.

What do you think?

Cheers,
Dimitri

--40eed3404897462763e9a80a690e74a1ddba21adca4e12fa1d86e6db438c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRsmRqgbXp8KFc3mc6pQ4aopiUuywUCZkOuGwAKCRCpQ4aopiUu
ywt8AP4jHsqTs/9SjOmOzGvAWv+YOIoaHfNaDGLTF92B4pEk3wD8Cj73VceyH4RS
Kh2b+WwsO7b1QjfsAyG8RmjW0tnm5Q4=
=BUXJ
-----END PGP SIGNATURE-----

--40eed3404897462763e9a80a690e74a1ddba21adca4e12fa1d86e6db438c--
