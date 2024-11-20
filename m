Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825C3147C79
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732132923; cv=none; b=nFyD7eM1ZSHOUVz451A65DRx4Jm59yrGcpNTR3tSMyTt4K8NsBhcj7zC+4Nz2XBfBt/zcQLLbHdRcbwRr9S4+1JWHQR2xitYmJ6KMVJaYS8rIWGeQAnEhAgRdvBc65wM/ec4hJle0IkzxtOgX8u9qneZxSS14s/NfY5XWb+D2y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732132923; c=relaxed/simple;
	bh=eX2ziznr8bSQQ6TTbq5BEEiHm7MpcNnEFMB16eFcrlw=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jT8e/p9tjJl0ztWnzIjPEfBH7LqfHXPX8bD7oyk83rQDeaDuKu6Tzj4V/mJ49v3gRp4YODL5qohCJQuPJJlnNJaf0A3ybxAospEoKjvsEXrrYTq3d0VvNmthBWGNud1aoBAC1Ypr/ZgGY0GDj+LPgnfkKQGx4mSfac3kBrDb2I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=a8GN+szF; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="a8GN+szF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1732132903; x=1732392103;
	bh=uh9xLqeTDOIa5EHpUaPMBhVRGHc2OJl/y4GeLN2lQTQ=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=a8GN+szFeRRAq1hKu1evrZnSdnXCQgjxMk3k9XRxMHfEKUGpAQ7EnRsFLV/dRWPFg
	 /TRIJjrlHXg0mT9p56VVZBlqKGsitC9cCEuJ+ut6x06KwL4/roKaRradwgwwHy36cE
	 v9lnP6BJ77f+/CxQMkcZ3SKsuq1Fkk6XukGjdPXxAWoOZz9d5vKlkJiNdQz4PJl+nq
	 BUAhM5DedzjyK1d+lTYxFdhWWF+eyn2NOnOrX7tQHCxUQqaHdk8zRo0OhSbv4AT5WT
	 cfyKc+6rIuttQTbWqml1504ECo1Z83GZmnh5NoaUjW3SsThxY4jMQ8K8CXoUcljO3/
	 0YbJIpBUzKzbw==
Date: Wed, 20 Nov 2024 20:01:39 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: A bughunter <A_bughunter@proton.me>
Subject: Re: How do you undo an add
Message-ID: <0ATsUGlsstLIpL-SRj2TaZ_LH0y2vDNYRledGKNf-Fkvn7OcpLUm4uvUzcQyeEZ3XPVbrqTbbU7j64bSg9GAaSvcmzYd_O9z9X4K4TE4o_E=@proton.me>
In-Reply-To: <4hiTc8Kx5yNhYuN8abv3QFJBuptM6VWZ9OKvkdZFlSI5y0zoK-lN_VHf-QCSEjllmSWvu9V-tbrvFOx17_P0Nq8UKxEcK3Rs2d02FjbYuUc=@proton.me>
References: <4hiTc8Kx5yNhYuN8abv3QFJBuptM6VWZ9OKvkdZFlSI5y0zoK-lN_VHf-QCSEjllmSWvu9V-tbrvFOx17_P0Nq8UKxEcK3Rs2d02FjbYuUc=@proton.me>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: 08434735c48f210d1733997993aad00388e05893
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_wXL8dlnIAvlSAqcM1CIZmxuwx2qyDlrUYeGqrpwfE"

--b1=_wXL8dlnIAvlSAqcM1CIZmxuwx2qyDlrUYeGqrpwfE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Sunday, November 17th, 2024 at 05:24, A bughunter <A_bughunter@proton.me=
> wrote:

> Maybe if I ask a queation a different way? What is the problem?
> ADD, ADD, ADD why cant they get that: ADD. ADD tracks files for commit. I=
t's already been commit : push failed. Failed pushes piled up. I need them =
untracked. How do you undo an add ( many adds) simple question. Without del=
eting any files, to repush 1 by 1.

A. You can't fully undo an 'add' because it creates a sha-object and object=
s are immutable.

While objects are immutable, if I do mixed mode reset switching to an old-c=
ommit under HEAD then 'add' the same files again
Q. Will it keep two copies as objects?=20
A. No because when an identical file is added the object file is identical.=
  These become tree entries pointing to the same object.=20
Q. May this overwrite the same object file because it is the same file? or =
because it is immutable will it reuse the old object file?
A. When an identical file is added the old object shall be _ANSWER_HERE_

I need to delete (or switch) the commit tree object to undo the 'add' (trac=
king) and delete the index (staged) that references the files which failed =
to push. The objects can be ignored because they are the same anyway when r=
e-adding. After the tree and index are erased I can re add-commit-push.

I need to identify the tree-objects to ignore and which tree to revert to. =
Use git status to compare with remote. For repush the commit-id should be r=
everted to match with the commit-id of the remote. This resets the HEAD to =
reference sha-id-something for the tree-object of <old-commit-id>. Effectiv=
ely untracking and leaving the git ready to re-try those failed pushs.
Q. how does git status compare if it does not ssh
use git log to find the commit-id?
A. git status uses _ANSWER_HERE_ to compare with remote.

In precaution I moved the files which had not been pushed out of the git wo=
rking tree to a safer dir. ( important note: this is a precaution which the=
 user should not need to do )  So still not sure if these files would be de=
leted by reset.

```--mixed
               Resets the index but not the working tree (i.e., the changed
               files are preserved but not marked for commit) and reports
               what has not been updated. This is the default action.

               If -N is specified, removed paths are marked as intent-to-ad=
d
               (see git-add(1)).

git reset --mixed <commit-id> worked but had some funny results. The result=
s were git status showing only the file of that revert-commit marked as del=
eted - presumably compared the last index from before reset, however the ne=
xt 285 files were not mentioned - why  . Because the status reported a matc=
h with remote I proceeded anyway not knowing why all of the files not menti=
oned.=20
Q. After a reset why does status only mention a single file of the many fil=
es which are now ignored?
A. The reason git status only showed, after reset, a single file marked as =
deleted is because _ANSWER_HERE_

Then I moved the files which had not been pushed and resumed working: worka=
round complete.=20
Use-case[C] workaround completed. bugreport[A] and question[B] remain with =
these more questions here in this post yet unanswered.=20

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmc+QCAJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu
8pkAAI99AQDhOYZBjPexoTNI3Vtk1kMk3fncUaR4AwmI5cWbTJzfQAEAjGKQ
fZ6e65REGnoEoSq5Ml3czcG9tI+sEK+SI2f5ygA=3D
=3DFW62
-----END PGP SIGNATURE-----

--b1=_wXL8dlnIAvlSAqcM1CIZmxuwx2qyDlrUYeGqrpwfE
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

--b1=_wXL8dlnIAvlSAqcM1CIZmxuwx2qyDlrUYeGqrpwfE
Content-Type: application/pgp-signature; name="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"

wnUEABYKACcFgmc+QCAJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu8pkAAIqAAQCuWr1u
6edIKpjJ6bW6KdHaSF/3PEl388xOmgmzJG8m1AEA8c2JXXOjEJXcYiYZVOhzGko5tPvDW5fkkMMG
e8QQJQc=

--b1=_wXL8dlnIAvlSAqcM1CIZmxuwx2qyDlrUYeGqrpwfE--

