Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA1B16C847
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 08:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718180803; cv=none; b=BvXyidlIxNnNxK0jtfwn4qcMTVBCK2DybK1FqCJblBbLakM47MJ6otlyMB0b2p+tD6fOhyRLAw3c0cf8pY1L67uaWvPleK2pouFFM0Airrgmoo4AvzjY1uYfTEOuvYoYIKcsC3sYYN+LzT0tq+kmAXW9zn+QGkwiX7hTGtoAsvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718180803; c=relaxed/simple;
	bh=KfsZOQzb8WWbb1Q9q7pfQFtd7e8AIb6kwFOeKCK2zV8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=M1rrfDL9p9pJ+0wmREmImpEFbftg15LyAc+NusoDs3tglkSYRTtnXR/0qdw/eTJhd60MoKNInBpkSCTwtgUYF8knSpeJgjDGwnR9QEIL95mh8z7Ghc6Ma8wPRpQI/UaY0Q6Skd/tAEdtpmF2FhLVTpuVzFbklOmbhmv/gEXe0mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=h7m/MXdl; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="h7m/MXdl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1718180795; x=1718785595;
	i=johannes.schindelin@gmx.de;
	bh=FSYwBRGderVQetw67vtCsUQlstH8mtB5fvi/bfhh6i4=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=h7m/MXdl0emT5Jmn9CFEDCvWyqQnJCrGNXJloqqrrL3lpS5JiiRD3mvQLSpSG/GY
	 HjiIJbNqkbILPWMEgw0Ru9Pm40vpkcfGlvkyjDgm42P2UurAu4FKnEosBL19h5iFq
	 dOuRPm+bd4DgC2oCxSJBw/B1Td5LqNHKfia21UIpSzmGpfLXVSeLus6B2UffWdnIj
	 Ms91Neh4M48MMGV2Lo33K9H1dNN8QrdCQr7wqJN26MCwyx/9t8nYb8zzkdPaiE3Z1
	 JMfcQh1zcvD2zRTmpUVI++ZsmEYtR7itBl00uEGEK2EIBfUIeQAChwkIBHm7cjJB4
	 AedZPlESmj1enmCNNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.216.58]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5VHM-1sSvzt0HiE-00r1rJ; Wed, 12
 Jun 2024 10:26:35 +0200
Date: Wed, 12 Jun 2024 10:26:33 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] commit-graph: increment progress indicator
In-Reply-To: <ZmlK59HYWY_aXgv5@tanuki>
Message-ID: <515d055e-a785-6d25-237d-bdfe06a2a69c@gmx.de>
References: <pull.1743.git.1718118555197.gitgitgadget@gmail.com> <ZmlK59HYWY_aXgv5@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0m9EamwCEszdx5S3z7DjmGkMgzIMsG08Tb27kczgPQQfAjQbltp
 yDEyp3yKWNcb0ct+LfIlhpMqjtBBBj+ShUpxIvGZqMZrhzXKofdG8aEnnF/I4gHp+pVmGDf
 4fu08L7Sf2q2Cj4jaz2xJZ8i31qgxa1aUwEAcADbOKUCcQ+6Wp+L7HApphaf246fUHd+xP/
 8+QgKfgAC/dGoJHudAI3Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LMMi9Z7DaYw=;vbxW+aYTwGT/cR6nJ+jDH6dGnuv
 Ih5t0irEa08ra+u8g7wCmWqmA8tIjL7by8h5R6oheR6OPMoMT+pzt4Lb71y4riAiRH/5Tr4Z7
 NmrJHXBwEQBGY2m2t2DcEYYG/q8SGDJB3l+4O4Rh02WlP2qOo7nYtO7v4hvKl3kBeyYhD9+Th
 62t8eQPYr+dUsmclqMn629tHUSQ+PQQtGg+/CJVfAzXtPWSuRVtbTJiXx38kxU9fei36wHcd8
 Gu4pnqf2ClMGam9vZF94eTfdurlXt1AevXAueV68yfgEf8DzNaxTiVUjAnxZI3/ombKTE8otL
 kLGR74Uw/O280PtsFMzNEkZUKgWrILWJgALIPnVgecrzV43LjGmWuXjSfMHwNfp9QkBEC0jI+
 1M/YIQsbNs/GO7WhRtTSXeFlCT0Zh4fLtHCaHDvHAQ0nrEc/Btu1mTIUDJBbcCPc+TgRExHNf
 n51oqnGrhoDEdTtBK3YigJ4pb6Yot+FjZudRoJeA/8GmZeexILiBVOt3IxrCAfn+zQ1QAwjWG
 wSOBi7V0T1xEbmaMgPcDpyD/fZOchZFOP4MPIZPqGofZHKSZwM/L4xRc12VCvzfaZh+4oDscj
 NKiuxhqA82jyiCoIDxj1tRd6N18n0N7MtXYKiytMvp//yNOEbCrLtkS9iQeU0OJupXZOpRPxs
 CjGSylSGGym1VF3mrs1NDrBqSc94QROY2rmv9tl4l0g819DOMOHB79dzghQD8RCUAycG2rMoc
 uzA547cSvyTJs5/t5H720e60K3vsJX1upD2Z3LXgB77OjoE1akL3IozaraKTB0mnXlr+GE4+9
 Ugde1aCDZgq4bJXlwoBBpOOnG6Eyu6l1lhpamUpyTdxNk=
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Wed, 12 Jun 2024, Patrick Steinhardt wrote:

> On Tue, Jun 11, 2024 at 03:09:15PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Derrick Stolee <derrickstolee@github.com>
> >
> > This fixes a bug that was introduced by 368d19b0b7 (commit-graph:
> > refactor compute_topological_levels(), 2023-03-20): Previously, the
> > progress indicator was updated from `i + 1` where `i` is the loop
> > variable of the enclosing `for` loop. After this patch, the update use=
d
> > `info->progress_cnt + 1` instead, however, unlike `i`, the
> > `progress_cnt` attribute was not incremented. Let's increment it.
> >
> > [...]
>
> The fix looks obviously correct. Do we also want to amend tests? We have
> e.g. "t6500-gc.sh", "gc --no-quiet", where we already grep for the
> progress report without verifying numbers. The output there is:
>
>     Computing commit graph topological levels:  25% (1/4), done.
>     Computing commit graph generation numbers:  25% (1/4), done.
>
> , which clearly demonstrates the bug for both callsites of the buggy
> function.
>
> The following change would thus detect such regressions in the future:
>
>     diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
>     index 43d40175f8..1b5909d1b7 100755
>     --- a/t/t6500-gc.sh
>     +++ b/t/t6500-gc.sh
>     @@ -158,7 +158,7 @@ test_expect_success TTY 'with TTY: gc --no-quiet=
' '
>             git -c gc.writeCommitGraph=3Dtrue gc --no-quiet >stdout 2>st=
derr &&
>         test_must_be_empty stdout &&
>         test_grep "Enumerating objects" stderr &&
>     -	test_grep "Computing commit graph generation numbers" stderr
>     +	test_grep "Computing commit graph generation numbers: 100% (4/4), =
done." stderr
>      '
>
>      test_expect_success 'gc --quiet' '

Good idea!

Thank you,
Johannes
