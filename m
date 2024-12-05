Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C827B5028C
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 21:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733432923; cv=none; b=t/qv7VKvqE9pmSa6dnOA8XpG6u2XpM/w0GtE8lOLbEcAxXp+otBH8VbTwqE47LZbtKx7DC8JEOWslOweMMK8HTnZIYg9y/voVyRRiDSitPkjHIvpxwV/Yk7g7yJdDf3S9v4QlPu9Vkz9tqNcLvJDOJj/2aNsq2ywdLnQ/2pWzDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733432923; c=relaxed/simple;
	bh=19ZIV+gsSvXUuXbp6agX1G1MkFWnd7QkDNlYRnzAOac=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/VB3GRVUd12KjT7u+GDNDYv2IR2CoR1aGLxfUtVTqrUMerPTY+ufhPW28qqyL0FUZuyctkx7+/1BpWhHE8ipywllp/opXpmYxfGI3oYktH5aBDpDW9mibjbjpw1CnF4T8SbCuNO6smZ2iAeRLp53/5glzz1tKBneB4x9lTKTpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=FM3sTP0X; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="FM3sTP0X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1733432913; x=1733692113;
	bh=19ZIV+gsSvXUuXbp6agX1G1MkFWnd7QkDNlYRnzAOac=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=FM3sTP0XnojLBs9938S4jeoIVAIRofkpg+6G+s38ZTxv6uZZytU2v3pY4JXMhOfAn
	 wV83/bPByf+VT/iQDO1dB+PM2eUpESJm+ptIgJisBm1eouOm8uMw7FJGyodzyEXOzn
	 oZF/i4sr2uixFhQMhq7kAFTvYnWuY0M3wtUoVqBKdA+RvyRpCoUVtdee9/NMgYn/F4
	 1ZdgiimpU+zSTjE0KafvA1erpLPxF9Nxsrfd97GamiIhxY7VE5osWLrhCNxTP3Tn3c
	 DWAfurfyy5GMTDV1Zygy9WuT/Fhft3icsvulu+VjINo7ejTGEcTYt0a2G7RIeL6Jq/
	 qcICHtPuQTbcg==
Date: Thu, 05 Dec 2024 21:08:28 +0000
To: Jeff King <peff@peff.net>
From: A bughunter <A_bughunter@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [help] git status doesn't seem to work.
Message-ID: <LgXFUHKOZ9fW4415YWA5y3is9qOJfG04kXCgoAtEB5Oe7YrvY1RuzfogI4ISvdjV76-bn1orZp8FG7KkDlJ5CC0zkWTqMaXDwkAenywEqJM=@proton.me>
In-Reply-To: <20241205201952.GB2635755@coredump.intra.peff.net>
References: <n8KYxrArhb3MywPvDHVmEz0dka8QYYWikLDZE_aboUX9GBgF2X9uomuxtrPA6VmS33TxXyltJB4xqjALIuprVvE12prKd_ZW4MYM9kC4Qds=@proton.me> <20241205201952.GB2635755@coredump.intra.peff.net>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: 9eff3a9584d09b661a43f14082e9e8182c49ec74
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_HwZL7UER8wNzDTzJ5PoROqYQZjMkdiTrwbQpEji9E"

--b1=_HwZL7UER8wNzDTzJ5PoROqYQZjMkdiTrwbQpEji9E
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512




Good answer Peff. It answers a lingering question here https://lore.kernel.=
org/git/0fyZjFuLfvDKSV32a70rBZ4q-iPMLmZtv4ITVBuqoUbtyUiD9CAbaCFgOKNsSh9Rq0t=
MszzyT1-kqf9bsWroZxEJXW_-Fg-VvBHKUqfCZZM=3D@proton.me/

from A_bughunter@proton.me

Sent with Proton Mail secure email.

On Thursday, December 5th, 2024 at 14:19, Jeff King <peff@peff.net> wrote:

> On Thu, Dec 05, 2024 at 07:52:37PM +0000, A bughunter wrote:
>=20
> > [help] git status doesn't seem to work. See how a pull caused updates a=
fter status showed "up to date"
> >=20
> > ```
> > ~/Peeranoia_Framework $ git status
> > On branch main
> > Your branch is up to date with 'origin/main'.
>=20
>=20
> This is comparing your branch with the local tracking branch we have,
> refs/remotes/origin/main. It doesn't touch the network, and that
> tracking branch is essentially a cache of the last value we fetched.
>=20
> > ~/Peeranoia_Framework $ git pull
> > Enter passphrase for key '/data/data/com.termux/files/home/.ssh/id_ed25=
519':
> > remote: Enumerating objects: 17, done.
> > remote: Counting objects: 100% (17/17), done.
> > remote: Compressing objects: 100% (15/15), done.
> > remote: Total 15 (delta 4), reused 0 (delta 0), pack-reused 0 (from 0)
> > Unpacking objects: 100% (15/15), 6.41 KiB | 312.00 KiB/s, done.
> > From github.com:freedom-foundation"up to date"/Peeranoia_Framework
> > 03edf66..4cf4f51 main -> origin/main
> > Updating 03edf66..4cf4f51
> > Fast-forward
> > README.md | 24 +++++++++++++++++++++---
> > 1 file changed, 21 insertions(+), 3 deletions(-)
>=20
>=20
> This pull is doing a fetch under the hood (since pull is essentially
> "fetch + merge"). It updates the tracking branch origin/main, at which
> point a "git status" would show that your local branch is not up to
> date. But since it then immediately merges the result, you find that
> afterwards:
>=20
> > ~/Peeranoia_Framework $ git status
> > On branch main
> > Your branch is up to date with 'origin/main'.
>=20
>=20
> ...your branch is now up to date.
>=20
> This is all working as expected. If you want a more up-to-date view of
> "origin/master" when you run your "git status", try "git fetch" to hit
> the network first.
>=20
> You might also find more information in:
>=20
> https://git-scm.com/book/en/v2/Git-Branching-Remote-Branches
>=20
> -Peff
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmdSFkoJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu
8pkAABrFAQCbDOZHArmE9Tb1IEfKiptP1L2sKGjWvMRq2HcVzC1yfgD/Q83n
S+eVEQTC65XKGxb4a3v9RSOiXgFxfrAE6dBd+wY=3D
=3DZGvg
-----END PGP SIGNATURE-----

--b1=_HwZL7UER8wNzDTzJ5PoROqYQZjMkdiTrwbQpEji9E
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

--b1=_HwZL7UER8wNzDTzJ5PoROqYQZjMkdiTrwbQpEji9E
Content-Type: application/pgp-signature; name="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"

wnUEABYKACcFgmdSFkoJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu8pkAAHWhAP4oNV7Q
HY0dI5dqkv4BpurcgB6EtxhOu4uvihowQUQkwgEAj54nHUODA745Kqhs8BMfTF2HMJjV888xma9q
VPliHgU=

--b1=_HwZL7UER8wNzDTzJ5PoROqYQZjMkdiTrwbQpEji9E--

