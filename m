Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D7F149C6F
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772381; cv=none; b=dKrs7D+YnCoieAI2aXaIXEgNQXgmb5OyVabbbXamfkPd7fh/n2K+6n+17DwpMEmBfKrcMIvYpeS9c4+ltwod1TvUiAAMyXeqrV68eg/V+u04V76O6GeJ5/oD5W4/Ld35vzoJEn8EFBU8panuK/hlGXdSoDoehQdvsf+oT2TYS7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772381; c=relaxed/simple;
	bh=3HMYngusorC/9Mvpfv9sZvsEbbmKt36bFmsiNPmJ/UM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Qw2KL0y2VlbJ/wM7Te0LuXNHDhcqPiKvFBDywysdabRA1hc67YTtTXYYDOIyPHyLnJItlnDEKedBSvcyfEUAVKr7Pi5wGNNKsy1GTPeVyhsuOg3qsZV1CNLLU1Em6NtGP7hKV/S3zpv8L9Bj6V+ZUOtMoLKMSLqNzTQ4zm4YDI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=SLklk8FU; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="SLklk8FU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1752772377; x=1753377177;
	i=johannes.schindelin@gmx.de;
	bh=CvtOPdW1VxOVLcR8O7GnmXV1IEeNqCF0z9Bc+3CHqvI=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SLklk8FU0p7Kl/37EN7y5cYrCVZkllcSsiSbR4VBJumcKj9VYVAW4BINul+9UstR
	 QSVWy5Bq1syj5NhJSL1z/r1CKzAEUB9QNKg/d790xM5KDX8Rd2sC2bh4QS4eG69qK
	 KwbK5y/zQLfU2emgBiAO4uG5hG07m6+XHnaMW8K5xF0iwNU1Im2TOnuMkNhpnAx8l
	 RJJm8QcuRagV1TvsJYH5IBA6IoOVEztv5izDDn5Mk2EA6x/2De0nqkuMRTeC09/bx
	 EM2/gkD7Ti03l6OPS8EjiBFmBV79W8OyrK8Pq+VoYsDR5wrJzfUOHbUJus56/DSO5
	 Cp1XNG77UsEkvbWQQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.246]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfYPY-1v5CKn0VPE-00afoL; Thu, 17
 Jul 2025 19:12:57 +0200
Date: Thu, 17 Jul 2025 19:12:55 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Timur Sultanaev via GitGitGadget <gitgitgadget@gmail.com>
cc: git@vger.kernel.org, Timur Sultanaev <str.write@gmail.com>, 
    Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] docs: correct mistakes in git-merge
In-Reply-To: <pull.1940.git.1751737158670.gitgitgadget@gmail.com>
Message-ID: <6518dd3b-ca05-1ce8-e700-81167cd2e88e@gmx.de>
References: <pull.1940.git.1751737158670.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-19420943-1752772351=:7408"
Content-ID: <f5022c4c-ef16-8af8-7ba2-d5b66cdbd355@gitforwindows.org>
X-Provags-ID: V03:K1:osi+0J8tdG3JlnkdCrCP/suxmwhbgD8dKbppyOuDqYENd1ruRob
 gGsXdTkod9en4jUaMNuvifjXrtgQvWRdREMHoFsEexA6mKqG5caU2tgkOr0xAmFQCEnbIdV
 pYWk96F57Dk9t0HhngXgsRcnCDV3gKzqEWUuVWd07UW2SBQOd9+OxBbtdTQhL/CVMgQT2Nv
 1VpH/8orYFJRkrpa3ciUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XM0NR8VIqvY=;WCsHNngGCMVgLlAEWgkFht8Gof5
 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
 ljzUf2pMTR4Vz32ub

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-19420943-1752772351=:7408
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <c2d3d6d8-4fa8-c0dd-1960-ecc7bd79b3b2@gitforwindows.org>

Hi Tumur,

On Sat, 5 Jul 2025, Timur Sultanaev via GitGitGadget wrote:

> From: Timur Sultanaev <str.write@gmail.com>
>=20
> Documentation for git-merge incorrectly notes that
> tip of the current branch on ascii diagram is C
> , while it is actually G (current branch is
> master, HEAD on diagram is G).
>=20
> Additionally diagrams on the page are adjusted
> to use spaces instead of tabs, so that they align
> regardless of tab size. This is in line with
> diagrams on other git documentation pages.

To be precise, you could add to the commit message that the faulty
description was introduced in 0c514d576685 (git-merge.txt: mention
'ORIG_HEAD' in the Description, 2023-01-10). (I Cc:ed Philippe Blain who
authored that patch.)

> Signed-off-by: Timur Sultanaev <str.write@gmail.com>
> ---
>     Correct mistakes in git-merge documentation
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1940%2=
Fstrowk%2Fmaster-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1940/stro=
wk/master-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1940
>=20
>  Documentation/git-merge.adoc | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/git-merge.adoc b/Documentation/git-merge.adoc
> index d53923c3b73..a055384ad69 100644
> --- a/Documentation/git-merge.adoc
> +++ b/Documentation/git-merge.adoc
> @@ -28,8 +28,8 @@ Assume the following history exists and the current br=
anch is
>  `master`:
> =20
>  ------------
> -	  A---B---C topic
> -	 /
> +          A---B---C topic
> +         /

This replaces tabs with spaces =E2=80=94 though elsewhere in the file, tab=
s
continue to roam free. The change assumes your pager or editor shares
Git=E2=80=99s long-standing view that tabs are 8 columns wide (a conventio=
n with
many loyal followers, even if not universally embraced...). That said,
while correcting the description seemed fairly straight-forward, this
white-space change appears to tread on more delicate territory. It might
deserve its own patch =E2=80=94 though I wouldn=E2=80=99t be shocked if it=
 quietly joins
the fate of the dodo.

The same applies to the white-space change at the end of this patch.

>      D---E---F---G master
>  ------------
> =20
> @@ -38,11 +38,11 @@ Then `git merge topic` will replay the changes made =
on the
>  its current commit (`C`) on top of `master`, and record the result
>  in a new commit along with the names of the two parent commits and
>  a log message from the user describing the changes. Before the operatio=
n,
> -`ORIG_HEAD` is set to the tip of the current branch (`C`).
> +`ORIG_HEAD` is set to the tip of the current branch (`G`).

This is obviously a good fix.

Ciao,
Johannes

> =20
>  ------------
> -	  A---B---C topic
> -	 /         \
> +          A---B---C topic
> +         /         \
>      D---E---F---G---H master
>  ------------
> =20
>=20
> base-commit: 8b6f19ccfc3aefbd0f22f6b7d56ad6a3fc5e4f37
> --=20
> gitgitgadget
>=20
>=20

--8323328-19420943-1752772351=:7408--
