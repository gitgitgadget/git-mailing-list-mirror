Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73309191F99
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 22:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731967792; cv=none; b=ss4Cey3OctHws8Gny4scgL/jNVNt0Hqac9ynyyQvTnIoIYaTRVqn2tjWKYIvJ+AwNK/hBMgUVVEDAOewQoHUPT3Rw5zGf+9LAtHiN9hT5p+7Rk/BAWJHzkxngYFXQ5mpcp+4CC/8RnmiXAqFkOhYBVaR+TLPtKc0unKxznGcOQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731967792; c=relaxed/simple;
	bh=vRszQsqtq4KS/A7D9ZmBp1WyfjMyiV3nc7BpWXTXHPk=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C8dXd9WimLo+eiPx1Adgq+PKDi6ZKZi14n86+N0BSzqs99Xz5drsfkMx9Zf4v1tAJ4nGgCtPt0omISosXE4V6SJ6YwIxQB56XXb4PkBqbbiY+0dug9azz5IJ3q410Qdg+W0CiGi22YLayByIIZHARq8yerQFNMfbjXnFbNtO6IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=YMkJoSeN; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="YMkJoSeN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1731967788; x=1732226988;
	bh=vRszQsqtq4KS/A7D9ZmBp1WyfjMyiV3nc7BpWXTXHPk=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=YMkJoSeNmpFzcxLYInX/j7yNecBYjC8vSIwomvCvwu/o0yJJYyr3RXltSg0lZXbLM
	 0YgIWbxWGHysccEvoO8HAN+VFSr3LPgS+DRBqzfs+t95BmCZ6rvkohfe/6pTiSH6Gv
	 Xw9wInmq8at/pBMGCuFPMjezlBLNwLC8c9XK4a1TLM+1/PoypQqdPLD1pemyEOSx+g
	 RJ/vcK/3vhUeFPWok+j841csma1API1WQ6u17VVr0hHCqA4S/4rH2WLVRHPsZkpWGz
	 0uIAbo/LD2l20VsYA2w6R5Ix1xWC5UGZw/9mubVqRPbmqlhJK9+53rCvLuuZ9kR2Vc
	 QQ2PV6VYgjzbQ==
Date: Mon, 18 Nov 2024 22:09:45 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: A bughunter <A_bughunter@proton.me>
Subject: Re: How do you undo an add
Message-ID: <MBCJkxhVnx5AhlKkq15aTn5FYI6cG-wdqqwQ84mVH9zjf-YehSrRWPgd-UwdTMrYhS2Sgofbyn2bS7iMlANyyYf_Z6b6_e3FH0hRm5VYciU=@proton.me>
In-Reply-To: <4hiTc8Kx5yNhYuN8abv3QFJBuptM6VWZ9OKvkdZFlSI5y0zoK-lN_VHf-QCSEjllmSWvu9V-tbrvFOx17_P0Nq8UKxEcK3Rs2d02FjbYuUc=@proton.me>
References: <4hiTc8Kx5yNhYuN8abv3QFJBuptM6VWZ9OKvkdZFlSI5y0zoK-lN_VHf-QCSEjllmSWvu9V-tbrvFOx17_P0Nq8UKxEcK3Rs2d02FjbYuUc=@proton.me>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: 0b0562aa860c5b12a3b1a5a3eb7b2c7c29b0a6c9
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_Qd9IBo6KzeajOEqs4SWMKwgvVRuuKHIGkppEcxE"

--b1=_Qd9IBo6KzeajOEqs4SWMKwgvVRuuKHIGkppEcxE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

BROAD OVERVIEW

bugreport[A], question[B] and use-case[C]. These are all related but separa=
te threads for the purposes as labled. Please do not cross-post or cross-qu=
ote. Focus on productivity and solving these. You are welcomed to view and =
participate in all of these as I contribute more.

use-case[C] - git question (short) rephrase with use-case added.

ADD, ADD, ADD why cant they get that: ADD. ADD tracks files for commit. It'=
s already been commit : push failed. Failed pushes piled up. I need them un=
tracked. How do you undo an add ( many adds): simple question. Without dele=
ting any files, to repush 1 by 1.

I suspect the answer is: "you can't - git provides no means to do so" - a d=
efect, bug as we call it. The answer to this use-case question likely will =
confirm my bugreport and I get the feeling this is why they will not answer=
 the question they do not want to accept my bugreport and have a bad spirit=
 to argue. The excuses they give for this will be that it is not typical: T=
his can normally be solved by repushing. However it is still a defect and i=
n my use-case there is a slow or intermittent connection and no sha-backups=
 yet because this is the initial creation of a repo.=20

The above question is a use-case[C] seeking how to undo without deleting fi=
les. There shouldn't be any need to know a use-case in order to answer a te=
chnical question. I am open to discuss my use-case on this thread. The use-=
case if of this repo github.com/freedom-foundation/kjbible

My original bug report is that the user " may be cornered into delete files=
" bugreport[A] Summary as of 20241117 brian does not believe it's a bug and=
 begins chattering to Peff about how to fix the bug "There are Git-level ke=
epalives during the similar compression operation".

The full question[B] which is a child of the bugreport[A] is here. Summary =
as of 20241117 my question was mostly sidestepped and spammed whilst the th=
read devolved into a political drama about code_of_conduct. I am not open t=
o discuss my use-case on this thread.


[A]: https://lore.kernel.org/git/20241115093214.GA1749331@coredump.intra.pe=
ff.net/#r

[B]: https://lore.kernel.org/git/xmqqr079xty7.fsf@gitster.g/T/#t

[C]: https://lore.kernel.org/all/4hiTc8Kx5yNhYuN8abv3QFJBuptM6VWZ9OKvkdZFlS=
I5y0zoK-lN_VHf-QCSEjllmSWvu9V-tbrvFOx17_P0Nq8UKxEcK3Rs2d02FjbYuUc=3D@proton=
.me/#r
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmc7uycJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu
8pkAAAUrAQDMBzGR0iQAyWfP3whiWEph0CyU+Yoveqk3jmFe7o1GMgEAm+6P
fa5TtaggX7+jcAWmRh7NvUWl6H9qFlCdxSflEQY=3D
=3DEHWY
-----END PGP SIGNATURE-----

--b1=_Qd9IBo6KzeajOEqs4SWMKwgvVRuuKHIGkppEcxE
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

--b1=_Qd9IBo6KzeajOEqs4SWMKwgvVRuuKHIGkppEcxE
Content-Type: application/pgp-signature; name="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"

wnUEABYKACcFgmc7uycJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu8pkAANwPAP9j9oGS
6EN80EHA6VCq2OgA0t1yQ967/iGAuqAioM6ORQD+PeN5sGArlHXVmiZqLs6o/N4YyNEiSugsNb7/
bRc7YQs=

--b1=_Qd9IBo6KzeajOEqs4SWMKwgvVRuuKHIGkppEcxE--

