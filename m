Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27647126BFA
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 19:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732046102; cv=none; b=JW31JRG1IvvM4bL3PtYYqKb9jtkwMKZQH9ZVTeTR35p40n3cuso//2N92j8Eq3XkyUfhDegv2d/ikn3+tgRVMuTVksPtLRNiSn0gxu15OZ6Immc0ameViJYgk14KGqp3ADWFG2chg5Zknf+m+fvsZ3oS3g2Sv+vmw8sePLw1GzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732046102; c=relaxed/simple;
	bh=032DbENqA7pAN1ieHMjP5KggTysxI/ZosiHxZz2GZBY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rHU4AiegDYj7txE6Am2VnYNDMQkn7T0Vylrc39lGHYKz3S6lPXbUJTOdQNDwNw9QB7cvbtO87jYzqZDouqklRLCrTwP6dhl/ANKCLcVyFNyKietT2kAuPBR31V4Xst7xtk1sjDDOXv4omvDS5FO1p9Ojaw8b2GdTh21pmoxW57k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=AhxVTiPI; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="AhxVTiPI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1732046082; x=1732305282;
	bh=Zl0rq0Q9IlRdqkvUcCrsgvM4y1wuJSyDJW3brvacE4A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=AhxVTiPI1JDP8rWfWo297WwKNtcH+IFn0w31v9VA4S80mCLsGr+iMoiXS8oZq2SLl
	 vUjEjE4xLTrUQ1PwqyY/iusyMzhK5DASti4908F1mCjC5y+tPEedq3UR4mItvG68BO
	 BxhgFfObT9nNaMt+SECn6l205gtPJWKA/jfvbIx8U7SolmQ6/2p0DyRS+XTM5S/mEz
	 cgAk2+E8tnu5+kYAVqBQIKj8cW351BRMsiLmoL1qRm3UjtLl3jU6zI2AUwyjHcuuYR
	 duDkSYH3p2NuqWnnGHs9KL2XO0/Cyv5nmHlVEia5O+s3Xrf/GFL4rAynu4+lZ3b2gA
	 /p3BLDO1R9uNA==
Date: Tue, 19 Nov 2024 19:54:38 +0000
To: rsbecker@nexbridge.com
From: A bughunter <A_bughunter@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: How do you undo an add
Message-ID: <ntVGkqDvxpzqdRU8m59c7JnXVKTTM_KY1zbMOsxBX9l1sPYeAArSdod3cNaRYLavceX-XjsU8pIM3-qFHW2GJQbs-t-RbJ-2fL7mrGl4tMY=@proton.me>
In-Reply-To: <022f01db3a10$7fe28140$7fa783c0$@nexbridge.com>
References: <4hiTc8Kx5yNhYuN8abv3QFJBuptM6VWZ9OKvkdZFlSI5y0zoK-lN_VHf-QCSEjllmSWvu9V-tbrvFOx17_P0Nq8UKxEcK3Rs2d02FjbYuUc=@proton.me> <MBCJkxhVnx5AhlKkq15aTn5FYI6cG-wdqqwQ84mVH9zjf-YehSrRWPgd-UwdTMrYhS2Sgofbyn2bS7iMlANyyYf_Z6b6_e3FH0hRm5VYciU=@proton.me> <022f01db3a10$7fe28140$7fa783c0$@nexbridge.com>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: f2d89b6cbef2bfeb778568a72e1db38b0b4da041
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_40c2atcosCTKojDCGCcnMv9EB0OUY19NBQSYn3Jyw"

--b1=_40c2atcosCTKojDCGCcnMv9EB0OUY19NBQSYn3Jyw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Monday, November 18th, 2024 at 17:20, rsbecker@nexbridge.com <rsbecker@n=
exbridge.com> wrote:

> On November 18, 2024 5:10 PM, A bughunter wrote:
>=20
> > BROAD OVERVIEW
> >=20
> > bugreport[A], question[B] and use-case[C]. These are all related but se=
parate
> > threads for the purposes as labled. Please do not cross-post or cross-q=
uote. Focus
> > on productivity and solving these. You are welcomed to view and partici=
pate in all of
> > these as I contribute more.
I appreciate your understanding.

> > use-case[C] - git question (short) rephrase with use-case added.
> >=20
> > ADD, ADD, ADD why cant they get that: ADD. ADD tracks files for commit.=
 It's
> > already been commit : push failed. Failed pushes piled up. I need them =
untracked.
> > How do you undo an add ( many adds): simple question. Without deleting =
any files,
> > to repush 1 by 1.
>=20
>=20
> Once you have pushed an added file, your only option is filter-branch to =
prune out the
> invalid content.
I will look into filter-branch. I will let you, rsbecker,  know if it works=
 for the purposes of displaying the solution to the entire git community. I=
f you have any more relevent specifics about the use of filter-branch you a=
re welcome to post. Just as you form a response, to focus, pin my question =
in front of you as you write about filter-branch.

The rest of this slightly peaves me because none of it has to do with the T=
OPIC my question.=20
> Prior to push, before commit, you can use reset HEAD.

This delete's files and if it is the only option in my given situation it d=
oes CONFIRM my bugreport[A].
> Following a commit, you can use reset --HARD to move the branch head back=
 to a
> Commit where the add did not happen.

Seek grace.
> If I did not understand your situation, I apologize.
>=20
> > I suspect the answer is: "you can't - git provides no means to do so" -=
 a defect, bug
> > as we call it. The answer to this use-case question likely will confirm=
 my bugreport
> > and I get the feeling this is why they will not answer the question the=
y do not want
> > to accept my bugreport and have a bad spirit to argue. The excuses they=
 give for this
> > will be that it is not typical: This can normally be solved by repushin=
g. However it is
> > still a defect and in my use-case there is a slow or intermittent conne=
ction and no
> > sha-backups yet because this is the initial creation of a repo.
> >=20
> > The above question is a use-case[C] seeking how to undo without deletin=
g files.
> > There shouldn't be any need to know a use-case in order to answer a tec=
hnical
> > question. I am open to discuss my use-case on this thread. The use-case=
 if of this
> > repo github.com/freedom-foundation/kjbible
> >=20
> > My original bug report is that the user " may be cornered into delete f=
iles"
> > bugreport[A] Summary as of 20241117 brian does not believe it's a bug a=
nd begins
> > chattering to Peff about how to fix the bug "There are Git-level keepal=
ives during the
> > similar compression operation".
> >=20
> > The full question[B] which is a child of the bugreport[A] is here. Summ=
ary as of
> > 20241117 my question was mostly sidestepped and spammed whilst the thre=
ad
> > devolved into a political drama about code_of_conduct. I am not open to=
 discuss
> > my use-case on this thread.
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmc87P0JkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu
8pkAAPviAP4uP8OEMcmzOHpuCEaByLjVudqKuqPNzI2s/UXBZHNoYwD+Kg3m
U9IuHANF21RXERRYLiX+mjcQzLEdmov/dpjXOw4=3D
=3DvuRu
-----END PGP SIGNATURE-----

--b1=_40c2atcosCTKojDCGCcnMv9EB0OUY19NBQSYn3Jyw
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

--b1=_40c2atcosCTKojDCGCcnMv9EB0OUY19NBQSYn3Jyw
Content-Type: application/pgp-signature; name="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"

wnUEABYKACcFgmc87P0JkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu8pkAADAKAQCf6v4B
K3+Ja4G3bsO+gqea7ozneg10TPvJt114p8VbrAEArBaJEfpih2YQLCSJbgC5Tj5wPMh2niMWFb/l
jBRd8QQ=

--b1=_40c2atcosCTKojDCGCcnMv9EB0OUY19NBQSYn3Jyw--

