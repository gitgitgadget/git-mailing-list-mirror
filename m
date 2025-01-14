Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A05720C48B
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736878512; cv=none; b=nPdRxPUOI6JEqDh/g5V85Z4KPFYBKk/8U0K19jgIIbBS5TT8mGY7nvUzwzFI+jW82AXf+BmA7BlmdNbdkGNXPUv49zKviRUmwbDJ8Pjj/87cE+atEC841mNdQw8LrtCTb58BrNKvq64HEn15EF6dRJ+wTbeNYj+wLPwByXQa1kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736878512; c=relaxed/simple;
	bh=ny3R0XQwBlzui/VTTBc8npBUM+qMOfzGxlIiyZs/V/k=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=HGom9fdG7yp6kw4apzvyE3BRzeC8bR4yY1aRLl8nAT0j1R2Z67pqWbH9nJrXgQU8wl8Dk2Bf36rhXcw4ROXRTyFMZfWkIZMNJ0kzfVXFKz6mKS4e5n1BD/3x3shuJ1X21m9aqeypTA9IDwOhv1gtkVfKxQGWSVsuP94Q4n2TaVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=L8igp2tw; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="L8igp2tw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1736878507; x=1737483307;
	i=johannes.schindelin@gmx.de;
	bh=MAcKJcP8gKD8kzILLJREdRIsacTcMKo1ojTnolCdA2c=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=L8igp2twekqG9hL2cctCnbcayeAzagrK6ObcZpYdBeKz9xc7cPdGSBV6CZgOR+ZI
	 lggvpqu9vWINCSBWULzDg29zEHgcWi/qmov4HWBbnes0pAsHDqEYymJB44preIlBN
	 hqTLdLKbVYa1bCWQ+FpJiVAtlf1n3LDZhSDe+8x7KzLTFl/mTSkUg5d5V+N2skF9L
	 2AGwBT/8kxjiwqy+vDa9O5+O6pARPTMoFfz1dTpLE9Hum3jSJCYjtINUYr1Euv5EO
	 e/dvFQA3RmZGMKMidaGh8BQJPZZBihyxab32Fp1u+WR1YHSNDcU7d0NWix3rQl/du
	 suJfWQ9dmdN4pCGlhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.189]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEUzA-1tmabx1mMk-0074ao; Tue, 14
 Jan 2025 19:15:07 +0100
Date: Tue, 14 Jan 2025 19:15:07 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git-for-windows@googlegroups.com, git@vger.kernel.org, 
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.47.1(2) (security release)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1M9FnZ-1taoNo1wwh-00ESSd@mail.gmx.net>
X-Provags-ID: V03:K1:gH4WM3ctnIrgkFMICgfl4sDm5z9tywsorRN0QN4ORcVKsAyut8u
 tXsMkEWsVc71evz/Qbvt/gQzeuAaseVEpNeNwmkT3I2somm6pHQgCIGyYd5mifec+lFN+9R
 epyxVqQfgSOVuz7umnu4zkB/vOggBeKLL9qSCV2KA/oXOJkXQTm2+5vb+BmFcTD1M/o2zWc
 NQNnEQPx54guQ8V/2YHoQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gcsPCCUJLLI=;A1iE+aywCR9pP1+axsJXv4taT18
 JVpPfoHThfRzPmBnAtuc8nMF9T9/2NOizASt2lNK5gW88tFNnWaWICq2Ad6LqUDmwICCpHGvh
 5hjpkArXZHyp/DaH5YDidRqE+BUxn944KWsSyuk21sy2IeQ4lFqxgCs2LTMF8p1519Wl/IJ0F
 lszK+csXC2oPuJHNUCd9LVREcu/06gEVOS+pvtDgu0ZTt1ofIQdytKyEhP/6+C5ZtoxXw4hrW
 G0kD781S5RXfpmwu9SRxYp+efQjGXR1n7xgZ6q+TGQdjove5LVizl55UBWitI/U80DDMY+9OZ
 KjHFIA18R0QP9bmQWU0jkVrMzJmsBY5JQql+f2jf/HE6Dqip3zxiR7N6n4pjfOO7QQ/PWaw4R
 OFdTEFcHp21nxtJ8q8r2Lnevtp2OI4xcr13rGkYAnXwZTJmIeyTH1rVhgnyzVtQ9Efb67muYb
 GxOB3GggEoCZk+yCixRCs2ZbP9ZXQsfJzYtIHMwKcJTrnh4UmfBRHwtePMbxhbXnXlaRo2vcL
 KG24xByQiGtYD1fs00Bu0Ka5VKxVeGy1/NOKz7u3W1DmGTAR9N6s/xmBitOfUnMlfviDO8qwG
 eA9kD9hOZdatQErAgDQXg3q3UaiVkMnNa7NHv8DiooRaigRhV6b8P4iddy0vpcJkSDlNKaErQ
 J9F4rXqYvesaiTb6Lfau+UokM5Y7dJaDGFeX4QR4MA4i4/o0deXbm+O9POoiZYlZVKsEw+mf8
 1LRBw1WDW2xDnQZcskRzfgfbb8KtWKVKbeM7lpkBMGrmdbUfVbzdXCywMH1RcFHQBnTo0Qtu1
 +TZJGc8uq++dWFyMt87LK65AttgFBOu3SYOggRfo3uWnTdFQex4tx1Q6ICjbEwSD2w/Zbwg7V
 ZjB7J8X1aP9k/xIpaXE/GUMpYqAqjBBJNXzn5FRt5H9ZKLC+kSVTpLxMnezhCJ6S7X7fzwUZs
 ENhj0l1TySSY5oFaIVQq5FRUXmfNfS+ZB2p7ffey7i8Q0fkW8d3hMdj4cF3SQnw3lTk/12JF0
 u0mHK1tIP3B7FXzVmnq5dbNuImRD6HfGGaQNUkpWvUuda0ErBtsb+xCUxrUPn/uZAnxQnZd04
 vmo/ZoVb4vthU3+gNV3BBfPbmD32Fubs2cFefOD9yUBTvf49F/PixjGMpCPyYOCl1w17pGFck
 =

Dear Git users,

I hereby announce that Git for Windows 2.47.1(2), a security release, is
available from:

    https://github.com/git-for-windows/git/releases/tag/v2.47.1.windows.2

Changes since Git for Windows v2.47.1 (November 25th 2024)

New Features

- Comes with Git Credential Manager v2.6.1, addressing CVE-2024-50338.

- Comes with Git LFS v3.6.1, addressing CVE-2024-53263.

Bug Fixes

- CVE-2024-50338: Git Credential Manager can be tricked to exfiltrate
  credentials for a trusted site to an untrusted site. Since the URLs needed
  for such an attack look suspicious, this usually requires a recursive clone
  or fetch.

- CVE-2024-53263: In conjunction with CVE-2024-52006, Git LFS can be tricked to
  exfiltrate credentials for a trusted site to an untrusted site.

- CVE-2024-50349: When prompting the user for a password in the terminal, Git
  does not neutralize control characters.

- CVE-2024-52005: The sideband channel does not neutralize control characters.

- CVE-2024-52006: Similar to CVE-2020-5260, affecting credential helpers that
  interpret Carriage Returns as newlines.

Filename | SHA-256
-------- | -------
Git-2.47.1.2-64-bit.exe | 5f2350757f9781125cd660478b31c37698d9662aed25b4b02e92da393289564c
Git-2.47.1.2-32-bit.exe | 4e6d9f309f4f877a779aee9e80fc1ef5d6f03aa79d5eb4cac103d39f02ece1e9
PortableGit-2.47.1.2-64-bit.7z.exe | d73f0c1a42afbabe43862bd5abf5a646798125bc33cc02b7da7bbaeddae948f0
PortableGit-2.47.1.2-32-bit.7z.exe | b1b1715676b1aaf0cdffe7287c70c37a94408fd872d538f4b00834d278a9e02f
MinGit-2.47.1.2-64-bit.zip | 5bafb35dfb249b89d726b37824eeb5022379f0e51f5fbf9c29f49bef57e85b42
MinGit-2.47.1.2-32-bit.zip | adae5363e224be913af65b3b8c454463e220dd12c811bf5f298952ba4106589a
MinGit-2.47.1.2-busybox-64-bit.zip | e27f8fda56942a1c57911dfb2ad71ca7a6d227db733c921216402eb5d10da41d
MinGit-2.47.1.2-busybox-32-bit.zip | 00269b04f0b61572b2fc4e20220ff74496b44c5ec23f2753ac7de0867419fdb8
Git-2.47.1.2-64-bit.tar.bz2 | ee718e13e1f6c772ab918c0c8897c4d73c792d00bc6e3de3cf1092504b737b7d
Git-2.47.1.2-32-bit.tar.bz2 | 7ad65961762bf328574ab73d5b0442beb1e9bee81d73cfed6429ff927057e27c
Git-2.47.1.2-arm64.tar.bz2 | 8b3c4548346d7af2ee9e4e835e8baaea2bde2bca3d2df123a69e7b76ae7b8483
Git-2.47.1.2-arm64.exe | a6f68a3e74349e71ed0030fad7bad87806093a4063b3b1fe2a2c0be233201ce4
MinGit-2.47.1.2-arm64.zip | c74dd8e25b2337bbef059440966ba7bf96da4b4a8bc9bf9c759a2bc5a868da2b
PortableGit-2.47.1.2-arm64.7z.exe | 6f554b6f0fb9e76448f42c2b0dd9c4c59f0a1d0df0c38c1a9029ebd9c49532b5

Ciao,
Johannes
