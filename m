Received: from mail-40138.protonmail.ch (mail-40138.protonmail.ch [185.70.40.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DD15028C
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 21:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733432626; cv=none; b=loCDvxmPndUPupVkSu4tJWskfR/753c7fSZJva7p7jUtfxRs+4OI2JJ9UQp3C+qgIk3g/m60+NyXmbprU4jYsb2sKwmb9KziBk3ki+3SsKOJQg902Q1si3NpHwmuQvJNi76PivyLT5EZQAwNRMTcwniXC/ZJCLPWpE/unBQ+VIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733432626; c=relaxed/simple;
	bh=42mHDO3FB7G3srjSPVY+Z5dfHw+QVAVvR6aBtUmhoSc=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mL4oCKTuZX+sP4693jim248w9TYi1rTFC3Bcc5ipSatqmPgQWXs/j9r50p1wLQvaONQPfQ0ReRpADuBHXIMLIDWjJXpL3rtRR6km740knOtjgOJPsURMVv3OioC4HlLfw1tY8gPOhSJ011TfmQ725Zk4GsokSRsTw20VJlzOibU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IQ2/30lU; arc=none smtp.client-ip=185.70.40.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="IQ2/30lU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1733432616; x=1733691816;
	bh=42mHDO3FB7G3srjSPVY+Z5dfHw+QVAVvR6aBtUmhoSc=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=IQ2/30lUEFYFnB43pQ5OnDjD/N40AFqQzXLmF04cF7vrrOX1A5qWsh46Bq9Hkukib
	 akqpD788E77UvBD2cRjaUmGCliMCpTGp8a84bQiuWM0/AhpSvBvBc7QOYsAXQUTl4L
	 YL7ltCDTv8GBmg24lIOEJidFYKHDWMXO9UxFTA0XzbxX7MpGvZe8Nw5KdTskB45zdn
	 /pT+NuOzqx6vOk6k5sKO6wLI5d+VRYCkNgeGiY7ODR1rUz7gowPm4Wj3kLK5TgSiCt
	 80tYaWd5ABOy01tIoggwbEuyB75NAdkaceAI4EshU4Aa86gLjvn2L9NEcibO9Nex82
	 txqF2whSeTr7w==
Date: Thu, 05 Dec 2024 21:03:33 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: A bughunter <A_bughunter@proton.me>
Subject: Re: How do you undo an add
Message-ID: <0fyZjFuLfvDKSV32a70rBZ4q-iPMLmZtv4ITVBuqoUbtyUiD9CAbaCFgOKNsSh9Rq0tMszzyT1-kqf9bsWroZxEJXW_-Fg-VvBHKUqfCZZM=@proton.me>
In-Reply-To: <0ATsUGlsstLIpL-SRj2TaZ_LH0y2vDNYRledGKNf-Fkvn7OcpLUm4uvUzcQyeEZ3XPVbrqTbbU7j64bSg9GAaSvcmzYd_O9z9X4K4TE4o_E=@proton.me>
References: <4hiTc8Kx5yNhYuN8abv3QFJBuptM6VWZ9OKvkdZFlSI5y0zoK-lN_VHf-QCSEjllmSWvu9V-tbrvFOx17_P0Nq8UKxEcK3Rs2d02FjbYuUc=@proton.me> <0ATsUGlsstLIpL-SRj2TaZ_LH0y2vDNYRledGKNf-Fkvn7OcpLUm4uvUzcQyeEZ3XPVbrqTbbU7j64bSg9GAaSvcmzYd_O9z9X4K4TE4o_E=@proton.me>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: ae8f0cba1276509f343ef85690f1e64736959464
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_7hUBIYpgMMDlVg1KpbvT41DE54ZI1TdAKAL3f8wiFYQ"

--b1=_7hUBIYpgMMDlVg1KpbvT41DE54ZI1TdAKAL3f8wiFYQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512




A lingering [help] question answered interspersed.

from A_bughunter@proton.me

Sent with Proton Mail secure email.

On Wednesday, November 20th, 2024 at 14:01, A bughunter <A_bughunter@proton=
.me> wrote:

> On Sunday, November 17th, 2024 at 05:24, A bughunter A_bughunter@proton.m=
e wrote:

> Q. how does git status compare if it does not ssh
> use git log to find the commit-id?
> A. git status uses ANSWER_HERE to compare with remote.

Q. How does git status compare if it does not ssh? A. git status uses essen=
tially a cache of the last value we fetched to compare with remote. See als=
o "is comparing your branch with the local tracking branch we have, refs/re=
motes/origin/main. It doesn't touch the network, and that tracking branch i=
s essentially a cache of the last value we fetched." ( https://lore.kernel.=
org/git/20241205201952.GB2635755@coredump.intra.peff.net/ )
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmdSFSIJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu
8pkAAIzzAQCCC3GPjxGsJu/OE51LuIBbmhZ7o3FwxuRo61m9l4V0rAEAjn82
cLmBej/67p7s3eYLzQdtqfBP1LQz3bloa9uXjQE=3D
=3D5q/u
-----END PGP SIGNATURE-----

--b1=_7hUBIYpgMMDlVg1KpbvT41DE54ZI1TdAKAL3f8wiFYQ
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

--b1=_7hUBIYpgMMDlVg1KpbvT41DE54ZI1TdAKAL3f8wiFYQ
Content-Type: application/pgp-signature; name="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"

wnUEABYKACcFgmdSFSIJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu8pkAAClaAP9v1Z9U
aOF+J5keOj25wtCbKBCG9zRm3WJpc660tuX8mgD/dR1ugsC1dxdjXNcszMk5kSEEU+pbPFVYz1Ls
ZSMU6AQ=

--b1=_7hUBIYpgMMDlVg1KpbvT41DE54ZI1TdAKAL3f8wiFYQ--

