Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch [185.70.40.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9698F19C54E
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732049939; cv=none; b=W5Nyp/UHBn90ZfglQM1lO2UfveqYbbcqCrEBlJ805BY8hXZmtn6bGBrX+wOJNwuFTMotzhj4dg0zruc5tETCx+6lVvSluGZXmL82jgbFW8x3qO7sosu9xVTtH6W5lJ/Cyf+5lsMwMAnjzsRtdA5N8UijUSx2aXe3QBUSH0SkRjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732049939; c=relaxed/simple;
	bh=sGrrPGzUr1GQ+egcKLHCGNIKvehtsfkuSByX8vm0z9o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GQE/KyUSPm11Dcp/VxVkEERjnV5is+WMTYPdpKju+qC7dq2VDQV4S+ny7o30p0B+JxTdg41aZolsy7/cia7MIXYLjbE58Kt8Ya9g/Kxzl769CEDEa6FlxrHnHa+6uuSl63nnAKizg+0a5+ypAY60DKPsAgG+QbSvoTH6r2gfvAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=I3Gihm47; arc=none smtp.client-ip=185.70.40.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="I3Gihm47"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1732049935; x=1732309135;
	bh=sGrrPGzUr1GQ+egcKLHCGNIKvehtsfkuSByX8vm0z9o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=I3Gihm47ju5EPYZ86La0oOvT3UuoPneWbKTfbWzf34CIS2UFBUWLIx5nJ4q6G+0fE
	 l8ob3m4b16VBrtzzEth6kUE2MyjMCNGBgqCjO0/itPgc1MAU02roiKy4Zk/z0buvRx
	 V7lk8JD3aZre33Aa8J8rY+7xSTthu/hhN4Y63B+MY4p01AuCe3Ye/s6C7G7ABfY2W0
	 OGYV51nutUUb90wQLC/7ixF8ZO3lA9NiIVIQF88vceVotwtEqk02VT4qUSirOD4+ys
	 keL8rLzbotCAysJmg7Itd8nkRPByuVzk4zizZR/SRp4Y8qcD18dk/IioqMSJulKaDn
	 Iv3dUv7TScXGQ==
Date: Tue, 19 Nov 2024 20:58:51 +0000
To: rsbecker@nexbridge.com
From: A bughunter <A_bughunter@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: RE: How do you undo an add
Message-ID: <6arLzsCWhxM8QTlPRbNStMLfz5ZqVJTTUSX1E1NXLiy_n_d0v0wFMiUK5brfkqTV3chUOp9OLYyBpIbe4tYQ6qvrLKDzfg5el0EWnqDIYDM=@proton.me>
In-Reply-To: <022f01db3a10$7fe28140$7fa783c0$@nexbridge.com>
References: <4hiTc8Kx5yNhYuN8abv3QFJBuptM6VWZ9OKvkdZFlSI5y0zoK-lN_VHf-QCSEjllmSWvu9V-tbrvFOx17_P0Nq8UKxEcK3Rs2d02FjbYuUc=@proton.me> <MBCJkxhVnx5AhlKkq15aTn5FYI6cG-wdqqwQ84mVH9zjf-YehSrRWPgd-UwdTMrYhS2Sgofbyn2bS7iMlANyyYf_Z6b6_e3FH0hRm5VYciU=@proton.me> <022f01db3a10$7fe28140$7fa783c0$@nexbridge.com>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: f2252d663489e70e4d892899fef7570d3475e2c4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_Ae2jmwJKh1ryKzapMujESzZqH7IjYnHmfj0Xw3FA"

--b1=_Ae2jmwJKh1ryKzapMujESzZqH7IjYnHmfj0Xw3FA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Tuesday, November 19th, 2024 at 02:13, Kristoffer Haugsbakk <kristofferh=
augsbakk@fastmail.com> wrote:
> On Tue, Nov 19, 2024, at 00:20, rsbecker@nexbridge.com wrote:
> > On November 18, 2024 5:10 PM, A bughunter wrote:=20
> > > ADD, ADD, ADD why cant they get that: ADD. ADD tracks files for commi=
t. It's
> > > already been commit : push failed. Failed pushes piled up. I need the=
m untracked.
> > > How do you undo an add ( many adds): simple question. Without deletin=
g any files,
> > > to repush 1 by 1.
> >=20
> > Once you have pushed an added file, your only option is filter-branch
> > to prune out the
> > invalid content.
>=20
> git-filter-branch? Why not `git reset --hard` with `push --force-with-lea=
se --force-if-includes`? Maybe I=E2=80=99m missing something.
Yes you are missing something "Without deleting any files," a bunch of irre=
livent and wrong answers is SPAM because literacy is necessity for particip=
ating in any ML.=20
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmc8/AgJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu
8pkAAGtoAQCghq6jVJrxOy2d3LX80E5gfvBKRSdl/x5UERVdELIq0gD+IjmQ
dwe5xB0oFdnlMivj1EFpVEzFYMW2GO1oCkukKgE=3D
=3D2nFM
-----END PGP SIGNATURE-----

--b1=_Ae2jmwJKh1ryKzapMujESzZqH7IjYnHmfj0Xw3FA
Content-Type: application/pgp-keys; name="publickey - A_bughunter@proton.me - 0x66540805.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWnUwWDF4WUpLd1lCQkFI
YVJ3OEJBUWRBSDBJNDdqRHNQWjZndmIrWVVHQm5BeDdKeWYxNEFWT0gKeGE4eTArZG1ONWJOTFVG
ZlluVm5hSFZ1ZEdWeVFIQnliM1J2Ymk1dFpTQThRVjlpZFdkb2RXNTBaWEpBCmNISnZkRzl1TG0x
bFBzS01CQkFXQ2dBK0JZSm03UmZYQkFzSkJ3Z0prS2tXWlRsUXJ2S1pBeFVJQ2dRVwpBQUlCQWhr
QkFwc0RBaDRCRmlFRVpsUUlCY0F5Y1oybE85ejJxUlpsT1ZDdThwa0FBRDlGQVA5L2RkVDYKNTZH
a2E5TnRNdm1kb1k1a3ROZ3FiWTVYYmQ5Zng2a1BFNS80dFFEL1hpaWFsS1FIam13QXRiY1NlMVEr
CjNjeFlMeE5oalU3bXluUXNwdjlkeEFET09BUm03UmZYRWdvckJnRUVBWmRWQVFVQkFRZEFuZnAv
ejJGdwpSa3B2VWdmN21xWUk5UktuVFZhZHdHZmdhUUxobXdnM0x4TURBUWdId25nRUdCWUtBQ29G
Z21idEY5Y0oKa0trV1pUbFFydktaQXBzTUZpRUVabFFJQmNBeWNaMmxPOXoycVJabE9WQ3U4cGtB
QUppOEFRQytmbk9tCjRWajlRbUg0SDBHVnQ3UnVPUUsrd09RMVBSdnB5bVNqZXlCSk93RDlHWXV2
eE9BVks4aUF1cEorcHB3TQpyMzZWdWtJZTFwWHVIbzlSaGp2ZUF3MD0KPUZRRncKLS0tLS1FTkQg
UEdQIFBVQkxJQyBLRVkgQkxPQ0stLS0tLQo=

--b1=_Ae2jmwJKh1ryKzapMujESzZqH7IjYnHmfj0Xw3FA
Content-Type: application/pgp-signature; name="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"

wnUEABYKACcFgmc8/AgJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu8pkAAG/FAQDBAgjj
a/7Io8Dd6ZL9YdNeIaN/t8IGzzQl1EasuskWmwEAgrvbdz0KxHinrCpHM6p/CifTeboqUntwI2pb
vk0hTQ0=

--b1=_Ae2jmwJKh1ryKzapMujESzZqH7IjYnHmfj0Xw3FA--

