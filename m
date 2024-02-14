Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AE4145344
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 22:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707950238; cv=none; b=GeknlNJy06y6L9RTuNf9SK7iaH/RumX91ClQkSc6wEq+JdvQ40wwZENVosQ3LRxiR1MViAHy6OakKztR69PaXzjB6rqOYUe1yrpTCO8bGifraw2jvEwZ9por1IhoGgf+RN2/pz6XNEbgSO2SB5IDabreomCaaAHcgeWq/JMHgSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707950238; c=relaxed/simple;
	bh=or42E000obSXwT47C3PHfLs2gxUOB1nAXt8cHpDmj9c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fo9uXrZDGq6ZBoxe6zPwb5+ssTePNhsRyCR6lWanLSK5hwrxbTQu9xUhwNGR4vl87tVQzej9otYx/IZofHmT5vUr7lVtfTf70XEObeCW12NgIq+Fx9asjUllwGM+bn1uGIq9N8aXo3yx+Y55S/puhdlwRvXtuxWz9brbfXbNP50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=oqFYwrhD; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="oqFYwrhD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707950232; x=1708555032; i=johannes.schindelin@gmx.de;
	bh=or42E000obSXwT47C3PHfLs2gxUOB1nAXt8cHpDmj9c=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=oqFYwrhDtZkm3ps7JgF6zvxrXTXEy8cvm7noDptavuMcSiN1Iny6vRoCU2+Hhlnq
	 huSToR4a3oKoga3o6DNvRuW2dIsiliaqpzgfYdCefmzUBGZYUDqrCxJcR7mMw4mHs
	 ChOOUIMdghHwZvLGTFc3E7cSlfQTcsPOWQ8YMC36CaQddYijTF30S0HoONivPhHft
	 XoPOtKE8fOvjZP1WKjGbWqJ5KOTGDeyJOimnXAuFV7EslXtq8vltSteyhvZ8foR6G
	 G2ECIFrgxHTJo7lH9lL2ol6jwF7gSOc35PM2T7BJYFQ7R399HWpKfcwopRUbxZ+mH
	 jzctRvhmtkbi7jjrEw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az1251-410.04bx5wyvw5tenjekzxp54pa3vd.cx.internal.cloudapp.net
 ([40.67.141.243]) by mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1M3UUy-1raw6k0t8s-000bMa; Wed, 14 Feb 2024 23:37:12 +0100
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git-for-windows@googlegroups.com,
	git@vger.kernel.org,
	git-packagers@googlegroups.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.44.0-rc1
Date: Wed, 14 Feb 2024 22:37:10 +0000
Message-ID: <20240214223710.3664-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Fcc: Sent
X-Provags-ID: V03:K1:tl0DQN7XilIvJg6yPOfx4E6iFUHZ7mQ3YpjSLgvCgoAvSsEGEZt
 Ug/zjJmddz26uoUqrvFd5wJ3/nt9mWzSE7GHkxq+SzEic6il4TsGhkMr0CZSiep/eqlYKnI
 ZZ0nBzohRAOuADDpn/rcaEqxD57dZYonuHWNamjwdxwjDtAIVIyrOTgYeX3JhflH+7FxEzC
 QFKCAgKA3jr2Hnily6v6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZFWW8jBT/iQ=;xWInumylxZpvSsDE1vozavMuAKo
 w1wFtw77osSp5E2S2DEodDYpyRdTfo68Cdiqr0F0n12jrTImQRJffH9HvN+19KFC7TD65HqzY
 rF0+mpusSNUsyWUY5XGT0JFyoaR+9poYnSuIEOlfFQe5yX1XG/2foTcCnVWKUUgQR408VLAtJ
 hiKVpk4SehM0nQoxL4Jgwp3vtyzsWUJc/gmxxcg4NUujWs697z7kNSd7jgSOmXslBAqbPNhqG
 cR2hFGj7jOf3o/8l2ez47Sn/YdEDQ9gwaGez7okLFDFiOh6v85RNrYBxvdIwC/fvpbaQoaXZ4
 57qNNmzkVx1eY6n4AMHlPvIQ7rE3+Z80g4aEkOnn42tTsEmwtWGkNYAEFtAwce+0Kssk3fVfM
 8xW5lxvTbXaApeR+MnbH2AxujgYUe6JQI/6zEGnrN7ogIKU0XoYNDXKLAV+GXHPOrbx3Q9EjS
 tylj9ZOQIfkp76lMrWDtHBa3xBjsX38FhFVQryawqkfAnjPznaewb9oVDLym3Wsr686AGed3m
 QW/mg8ZNAH0Oe80FGu4esejOsHx+SbsVUEiBm5pr6kBzLqdH+LxeX41G/EfDK+xUb6G0vLfHI
 +ucppBHfG0z/zFM5B4a7mH42yY2YqsxHqmauwuiEgvl4N1WzelKysfHguYPWCIoKvJ8WsoPx8
 uCFRe23GKGQsEqXWAlxHYs/nsdTr5fuhXYZCRhkx0yuAUPXB0cy8FRpEmPQQZWEYbqctmlALx
 R8mDzpB4etQLnj+zayl+ac5DY30XpPUy8QcuiHlvb+b7IAP+3NqdUQ9OKL+3Lp6pZEsm6HiwX
 8Q4CvVZg8GAm67jjg/vihUvgH9BlJfnFyGXJJTyf1PE1c=

Dear Git users,

I hereby announce that Git for Windows 2.44.0-rc1 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.44.0-rc1.windows.1

Changes since Git for Windows v2.43.0 (November 20th 2023)

Git for Windows for Windows v2.44 is the last version to support for
Windows 7 and for Windows 8, see MSYS2's corresponding deprecation
announcement (Git for Windows relies on MSYS2 for components such as
Bash and Perl).

Please also note that the 32-bit variant of Git for Windows is
deprecated; Its last official release is planned for 2025.

New Features

  * Comes with Git v2.44.0-rc1.
  * Comes with libfido2 v1.14.0.
  * Comes with the MSYS2 runtime (Git for Windows flavor) based on
    Cygwin v3.4.10.
  * Comes with Perl v5.38.2.
  * Git for Windows learned to detect and use native Windows support
    for ANSI sequences, which allows using 24-bit colors in terminal
    windows.
  * Comes with Git LFS v3.4.1.
  * The repository viewer Tig that is included in Git for Windows can
    now be called also directly from PowerShell/CMD.
  * Comes with OpenSSH v9.6.P1.
  * Comes with Bash v5.2.26.
  * Comes with GNU TLS v3.8.3.
  * Comes with OpenSSL v3.2.1.
  * Comes with cURL v8.6.0.
  * Comes with GNU Privacy Guard v2.4.4.

Bug Fixes

  * The 32-bit variant of Git for Windows was missing some MSYS2
    runtime updates, which was addressed; Do note 32-bit support is
    phased out.
  * The Git for Windows installer showed cut-off text in some setups.
    This has been fixed.
  * The git credential-manager --help command previously would not find
    a page to display in the web browser, which has been fixed.
  * A couple of bugs that could cause Git Bash to hang in certain
    scenarios were fixed.

Git-2.44.0-rc1-64-bit.exe | d8157edf354afc66326db927de04e2dae054f55adbf3035bc9086478a5ecb423
Git-2.44.0-rc1-32-bit.exe | d53b5043216f5be5b154c5fe79e9cfd8c3d2ef2e6263cf3f3a9d358fc60843a4
PortableGit-2.44.0-rc1-64-bit.7z.exe | 1ee36ef5676e2536f869e6b89efcede826960b78f83cb1a685b9608f045a1582
PortableGit-2.44.0-rc1-32-bit.7z.exe | f96a638497b19d9d8c578fe1a6b54cb29c793c08ceaf204cbaa91ecd3583ee07
MinGit-2.44.0-rc1-64-bit.zip | bf13ebe8626699656e5adf659c905c6306b87917bb664fc52377011054771783
MinGit-2.44.0-rc1-32-bit.zip | 468b33306aca3f605e9fb64075a45a057ae2b72bb5aae42c2e37cf2a9846e37b
MinGit-2.44.0-rc1-busybox-64-bit.zip | aa667eb43187b7515d539d70ffdc3f12523a03f9bb546584f46342f6673170fc
MinGit-2.44.0-rc1-busybox-32-bit.zip | 5f902ec741b3e10dcce1e9cb06ed82f04668c9ea680030f52a194a7d869b2aa3
Git-2.44.0-rc1-64-bit.tar.bz2 | 7b6481465f1080c70e80df448b1fe7ece09407b3d580a8986f7934b6b3529e60
Git-2.44.0-rc1-32-bit.tar.bz2 | 8eded6886d07440084ce29dac6ce66dfa31795861d33c1a6aeb56bad0e0b31e6

Ciao,
Johannes
