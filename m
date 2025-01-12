Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46652A8C1
	for <git@vger.kernel.org>; Sun, 12 Jan 2025 08:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736670316; cv=none; b=mJV7eV8VM4PtQrvDtYk7SpCzRxdstFyoSAjS4w64pGlhwiN+I2kAhcBjRtET/3eZmdJrZLvAoA0frWB1if3PmR50fx7L8pxigC/ZFMujOfTi3qlNFzJOozmWUjAQ4BY1EvPaQIs3ccFC6xKXVREQzBW+eumALJe/Mkmc1oI24Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736670316; c=relaxed/simple;
	bh=H0vwYYhvb2Da+3XytQaHSyiTTiZtGi1DpbKSdwfzxTc=;
	h=MIME-version:Content-type:Date:Message-id:Cc:To:From:Subject:
	 References:In-reply-to; b=YUECWGJmcZKvSDy0dMzsNHHDG8Zruv+RbvCE9G0DVxEhPN4I989WMxVnmNMKkduEq4ra2z4u1Lpk5Jr7aRoQOIfzUwHetaqQIpik0+XF5mozsrQgVVvXQhDP+86RmIsh57I28BHpCrvj/zbjEGhEFEuIATF+oVR2ZhvlYyhz6dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=bRm3IzL3; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="bRm3IzL3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=7USyrA/aNiCiKNUgEs5l7dKq3pChR3JJGb20A0oCLR4=;
 b=bRm3IzL3AzVRoWRZKiJljEDp/HX9Q4tmkDOkCXFdUg4f7x4x7aa+DCMITeJ8fGk8VlqIPfOCdJ5A
   umVC/DaT7pu4O9uB37d+skkpqbrQDSvCDG9NhbqqRea2mip7dfIWcIdbhliyu73L18CKh6UyuAPw
   YZGSDhFjst+22BUmr+FhVyRqbI3mQPAB5jtIc2WSojdoNYGUUueBE2nR1QkVVslOrPbHfP04Y0us
   lCWHLz/ULIqZ8xB1W3c4zzpAOIn3JN550xSFWamFz8m8NGwn8NCA1wmFxn/HkSkOuQqRZe/XG8py
   GNnoPnusqsmoHfpbuH6KCOXC5FiOJlj+cPOYyg==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SPY00CQZV5FEO00@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sun, 12 Jan 2025 08:20:03 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Sun, 12 Jan 2025 09:19:39 +0100
Message-id: <D6ZY4MU53E2I.3LWESUZX6TR5A@ferdinandy.com>
Cc: "Jeff King" <peff@peff.net>, <git@vger.kernel.org>
To: "Caleb Cushing" <xenoterracide@gmail.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: git remote set-head automatically
References:
 <CAAHKNRGv19rhnqCkJMpE2FomNQBHvSS36aC=fh0UwO+9-6RRfA@mail.gmail.com>
 <20241116033616.GB1782794@coredump.intra.peff.net>
 <D5NOZMMISX44.2PTTMY57J5EM6@ferdinandy.com>
 <CAAHKNRF8JDUTH-QzPG1b4-wafzU+MXaMNinfBRu3JfCssfwGUw@mail.gmail.com>
In-reply-to:
 <CAAHKNRF8JDUTH-QzPG1b4-wafzU+MXaMNinfBRu3JfCssfwGUw@mail.gmail.com>
Reporting-Meta:
 AAF62PhZqJDlvC+yRQP3/8oM/CcrCO0/J3Kc0XhZNbt+2CBm3tyoLuHUzd5LX8h1
 gLAWljDco5X9jZpC3R1UZ7o3WG6mAx6zwN/VZ77S3BRIGpiQIbEBQT8pBMMHGUE0
 8M++sVej6ZFTkKGRKRO0esl51KtPaAW+OoZio68wRj5/QXnYkcVKIVqyNXkVejTq
 cvYY3mf61JHO2qsePu/NvQiMvzbwLBqUdG+O8fb1ZHfM7dXXwRuUWfUR5lgOawEC
 u+3IeVxV5sMpRU2bhaKj3Kw7g0ww2W6r9ssSZGfSixIILY3Et8AcMKa7aonxSwul
 M1a83YK3uy3SBaf083pg/y9pKjwO9zPhQeHrizSarNd8atf+qMn80JbioBM7dvi8
 6MUK+4k8MLlFzsTg6AfgjPKCzqdj6BJW4NfyXIBV2t9zKEwIycyu/ifkWLRntd2Q
 v3OIBigNKYmFKQnVy8Bzqxsgo1VTJaM9lGQcw0V+8d6yuFcNNadaJLs=


On Tue Nov 19, 2024 at 16:40, Caleb Cushing <xenoterracide@gmail.com> wrote=
:
> sounds great. I think I realized why I didn't have it. It's not done
> by `git remote add <origin> https://...`  my experiment was `git
> remote rm origin` and then `git remote add origin ... ; git fetch
> --all --prune` I think I also tried without the prune option. git
> version 2.46.1
>
> What I want mostly is for that HEAD ref to always exist. As far as
> there being ways to configure it, that's all good but I don't want to
> explain doing that to consumers of my code. I'd rather it just work
> for them, on clones, and add remotes or fetch if it's missing.
>
> I'm not super worried about it being updated as I feel like if that
> ever happens it's something loudly communicated, and I'm more willing
> to find it ok to make that an FAQ, if this breaks because that changed
> you can manually update that. Mostly I'm of the opinion that what I'm
> doing needs to work in various CI environments out of the box.
>
> Thanks for the info, hopefully soon (tm).

It's in the new release now, it also got some configuration options, but th=
e
default should be what you want

https://git-scm.com/docs/git-config#Documentation/git-config.txt-remoteltna=
megtfollowRemoteHEAD

Best,
Bence
