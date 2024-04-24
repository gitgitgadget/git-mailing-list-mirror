Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944D91F5E6
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 19:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713988258; cv=none; b=GDI94p/icx/4eHHsvv1y1YN2m7BefuQ/ImllYSak8xBDX/6/YW1HBiIiIcUZQtRhfX76zLJ9KnreaU5thtdKIbkZxEfC6WDk+voj+/ZxQgPgw/W8/eeowVMBoZ66wM+LswwB8aJanc7M66vNV7uz9IsmzYmExqDhKrG12LjnbmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713988258; c=relaxed/simple;
	bh=mx8hhQcu3xmq3Ylyj3KGc3bvdHWI/UAAkvRsMs+d14s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TseAHikgMsPY5qneWP1xThe2FhZ8VwFn1+THiR4+/LVoBDKZiNTa6R4602xTziV5ewcZ5hvtYpb7Bt0TqMRQi7xLeZmsCjGY2oyVs0dvmR4GSGLXTkU5zzBkor4eJ9O8H2I0ScB16rtsx6Mve/UrAwFj0+ie8KZuOyxZrMNbYJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Y1EthVB1; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Y1EthVB1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1713988253; x=1714593053;
	i=johannes.schindelin@gmx.de;
	bh=VKeUOGncXEzhiU6rQVrxLWE9RvsA/4ETEqbi4GRjYyM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 Content-Type:MIME-Version:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Y1EthVB1u9l7i2aN8WcxngQ4BSltAgEt2/tfHHVdQxpWBgZC8iTI7RH/ndn+wM1O
	 d9b2KYij+897TS5P2EinJ/5HELlBliciZ11F6uxZS320/sUWpxQl/ibDDe2V7QvaS
	 c2npsQp9HOkTMjgVwM3oXECV9Low+bc4sE3ZB5+pVkGCGroHZEOCJN0mHyhOjud+N
	 5LVRLgHx7eAk0uo+rJ0GX2NRcZc+GXf8p2orUZI19nhd4m6B7rJuioxZlOd/wT6Ir
	 Cr+GP5He/N8sKZYYopRIOYc8WF1J2M/fc0p9S+/kEI4/p081NQw2QwvxMuAzqfApM
	 iiEMgYHM34A2t6Icsw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az736-586.alpbqrzxv30uzkvtn2qktnuusd.cx.internal.cloudapp.net
 ([74.249.5.237]) by mail.gmx.net (mrgmx104 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1McpJq-1sZbMF1Xvu-00aYiT; Wed, 24 Apr 2024 21:50:53 +0200
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git-for-windows@googlegroups.com,
	git@vger.kernel.org,
	git-packagers@googlegroups.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.45.0-rc1
Date: Wed, 24 Apr 2024 19:50:51 +0000
Message-ID: <20240424195051.3591-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.43.2
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Fcc: Sent
X-Provags-ID: V03:K1:WdDMM5mekjLXvDfmicPJI9ciznTvdXokKboJp70wJ4bT9fuL9xz
 XXMh25s8kzlRfloPxTrHOFgyRXrj/JMGyar12oN//Lw9YDxPqkUvxsRXqVaAqzF2NT4Ue/B
 KtinpH5fH8xrb1I4Hm8mwZ7ecjXwKW5ggt/c1koVg/lCfmnTvm7aKhj9/Vm3duInDHKm6ln
 tAOhZO8bia+ckTrdx81Sw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gq1Ii4H3P7I=;GPzI9Vmq2hCHk0VNLMJXVDve/Ed
 +hHCgnYeX7Q3F2xEgOK8/EC2y37eMh06wTcQ0juYqFd6ygmB0jSfZuvNpnhhWCTrkwwMZF+YM
 CY8C4FnztrzqccykcclNwsDKB+f8Ln5KcI8aDWPTUq7siNEEGx9cF6CkUNvGJ1zGxQ8f+liwG
 JougJ/E76mYRW6yRbJYBLuWeQ1LbLJ/xYzKKib8Ir/zm8dk9oyty0e+mm2reSHEE4KZCV89/P
 4z/hcDNPBiV1MZXBGUdgWMRTYhWmLEffexHwYNaqRHuUZ2dmWgYuxx7imtIAxIpdQpc1kUYpu
 7YsP6Ls5WJZck67oQiuIyyr62TvQVkVLWLX6tAd9ZTeZBnm24uXZ4diD7CG+A3n0bTU9UUTP4
 Jpx0rh8oKGYZzO34VWVrhii59zvLZml5X2E4UDxCBPyQwSCaAzdF8gNFbjEQjDfXS3PBm48UV
 xfEINNgzZhLsj4iiwkMs0FLRuYimqT4o5IO35zc/5jGmRTSrrS5yoM/NhFGlYberUMJkvh2Ma
 deG8jhK0fOeaLozkwHKt7Ge4KXo//mSRN6cxq0pbPf9sL6nHyPodrADB26oandWIiPMnrXgo1
 j+6W/rDTOypdQqU2OOs9rdoizuLGdyIvzHon/nTNHsD2HOkxNIMdPMhyFlRL5X+kJam7Kzkbh
 me2J7U9M8IBdpIBgbmG1QFLy6Pb2cm+kdcuXjWCnKUuIp0KUVeqyxhA2SV6rEgdbQ5/+L//uh
 T4MAz1gziPPGgjLJD3WN6IsCz/qHljNoPhbRn/vtcBL67I7f5/jtHIBxEFiSBNNs1A1wpRd5M
 3UFgru3JW2fCfy/6iO4AMgDDXXfiBPTuUjUVuDTqIW9us=

Dear Git users,

I hereby announce that Git for Windows 2.45.0-rc1 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.45.0-rc1.windows.1

Changes since Git for Windows v2.44.0 (February 23rd 2024)

New Features

  * Comes with Git v2.45.0-rc1.
  * Comes with PCRE2 v10.43.
  * Comes with GNU Privacy Guard v2.4.5.
  * Comes with Git LFS v3.5.1.
  * MinGit now supports running git difftool.
  * Comes with OpenSSH v9.7.P1.
  * Comes with GNU TLS v3.8.4.
  * Comes with Tig v2.5.9.
  * Comes with cURL v8.7.1.
  * Comes with Git Credential Manager v2.5.0.

Bug Fixes

  * Since v2.14.0(2), Git for Windows' installer registers the Open Git
    Bash here and Open Git GUI here context menu items also in the
    special Libraries folders, but the uninstaller never removed them
    from those folders, which was fixed.
  * A regression where git clone no longer worked in the presence of
    includeIf.*.onbranch config settings has been fixed.
  * Apparently some anti-malware programs fiddle with the mode of
    stdout which can lead to problems because expected output is
    missing, which was fixed.

Git-2.45.0-rc1-64-bit.exe | f009e47d00a22d3052c37f3abd2d94870f54b03990f6070b4ff68f255f802f4a
Git-2.45.0-rc1-32-bit.exe | 6963e04a881cce9b6246911c01da222197dfb3fab8db63806623fd38d5673570
PortableGit-2.45.0-rc1-64-bit.7z.exe | 39ee6f9609a0955026fb347bb44a38eaf419be5d3ff9b1681711f1dfd3b778e6
PortableGit-2.45.0-rc1-32-bit.7z.exe | 945c60406fd4176905bc524c600acd21c35f5d41cb32c88101d6cd6178364433
MinGit-2.45.0-rc1-64-bit.zip | c2bbdb51194584932cfbca7a8720d7bb5c91cc952a66212a362df93740d37918
MinGit-2.45.0-rc1-32-bit.zip | 61ca022034ba7745912f423d672aad61620dcefb3ac024d04bd12608e1197b1c
MinGit-2.45.0-rc1-busybox-64-bit.zip | 031c18270e340dcd66c72391142d4069d4b2319c3a82c3cb47167ac9df82ebe8
MinGit-2.45.0-rc1-busybox-32-bit.zip | 7bbcf8077c410ab658f3dc28bd422227e4cf85b5d49db39698282b2f2769c10b
Git-2.45.0-rc1-64-bit.tar.bz2 | 4eeb340066cf392c434df5d09cfeccc76024f158b2ae3de64798155c6d4b0b3f
Git-2.45.0-rc1-32-bit.tar.bz2 | 710ec0ae24d47602b93ebb75cc7a87ba8486c967e4ce2cbaa124473c3d5d5225

Ciao,
Johannes
