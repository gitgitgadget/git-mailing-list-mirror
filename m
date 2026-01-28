Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73412267731
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769610435; cv=none; b=HBUKBU3vHjFqTHORirWLkRb3ErskbPXeVmbUD1cK/+/smPgnxFQZM6PmRSsTqSsCREqqxe5jYEiT11WKF8pIqyaOhg5H2Yz5OZnGpsqgI+EvnVOusELLIf79dEJkW9DIJIZrH1FLKR2kMsYJOQ33S6vsbhLqrS1v1viE3O9m56c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769610435; c=relaxed/simple;
	bh=7A1wjtawYW4OEwBnv9zmpxYEE93WVJ0BT+/Jkpr3DsU=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=tRXZm/0Q8hXSoUVieHGn/zfWUApGuAYTZWwaCMp+FBUUQqJtwKAGmtwtKE91r8CV0aDHfHNVgA9kUw1ehB76pbRI3sURrweB0MFwHbNJxF20DSFJU4JKgi0YBwDzkqaLmd83+C1QTNvH+CcSODFDKtSPUaozUgEW8BRF1nf9fNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ZyXGxd3h; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ZyXGxd3h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1769610430; x=1770215230;
	i=johannes.schindelin@gmx.de;
	bh=s6e0vWHp5Ljj54+pTjlP7zCNV0n0yjb5S1JHAfL2mYU=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=ZyXGxd3hMGew7M3wsAWQXvMWPToQ4WWuj94y/kXmmYImDW+eRuVn9lF4e2dcfreA
	 aJedczfJ/ZES/VT4Meqb+BfOyW5ldWXsCotKkp4NBgArak/r7ZvUrMKd5mdWwhCwQ
	 Vw+1nKZP0J78x8gzp3lnecvFVBfgRmpUEYgCOdUfx+Ua5c1qjXohZ50svUgp1OiaP
	 az2RA0cNOlNc3lbobFKBaLjM7IZQovZqJALzW3c03XodviltnYjNnPbI2d4n4vHMp
	 sY37F7Fa5G65noLRDRAb0fCbkp/L652hxq+7wZJQgnHzMtk8Phy/rrb+V46URET1N
	 eU46z6c4gWIH2oZjuQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([167.220.208.56]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2f5T-1vjifB1qLn-008bU1; Wed, 28
 Jan 2026 15:27:10 +0100
Date: Wed, 28 Jan 2026 15:27:08 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.53.0-rc2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1M3lYB-1vkpf32K7H-005Id3@mail.gmx.net>
X-Provags-ID: V03:K1:4Ka0eChd1Z/XuATxTxbdhn711L9D/M/ofZcVa44D9M+Z+TaxS40
 41vS0+cShPt8+bipd1i8gn95aqUaT+460mZ/4RvfTz4ZK9mlbRYWVQB0UjmwJzqpnRO0Sq+
 1/4iayy0FpWdM9LViFDhGlVzJAOx3ae1JqHGi31v/CzFmZX2BM6eM9yC7NdT36smBYBLjzz
 JIeFCnvuYOMQ//xkTK8nw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j54R2NsoQXY=;tXK47lFkHxHdp2kXj8ArcqA0HcX
 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
 EOAyAa+g=

Dear Git users,

I hereby announce that Git for Windows 2.53.0-rc2 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.53.0-rc2.windows.1

Changes since Git for Windows v2.52.0 (November 17th 2025)

New Features

  * Comes with Git v2.53.0-rc2.
  * Pressing the Tab key in an empty line in Git Bash no longer causes
    the session to "freeze".
  * Git for Windows' installer is now built by InnoSetup v6.6.1.
  * Comes with cURL v8.18.0.
  * Microsoft Edit can now be specified as Git editor.
  * Comes with Git Credential Manager v2.7.0, the "anniversary release"
    after one release-less year, which brings native x64 and ARM64
    binaries for the respective flavors of Git for Windows.
  * Upgrades the memory allocator mimalloc that is used by Git for
    Windows to v2.2.7.
  * Comes with the MSYS2 runtime (Git for Windows flavor) based on
    Cygwin v3.6.6.
  * Comes with OpenSSL v3.5.5.

Bug Fixes

  * The installer of Git for Windows v2.52 showed clipped text in some
    setups, which was fixed.
  * When calling Microsoft Store apps, their standard I/O is now set up
    correctly (meaning: You can call an interactive Python interpreter
    without the winpty hack mentioned in the release notes' Known
    Issues).
  * The astextplain tool (which is used by Git for Windows to generate
    diffs of .pdf and .doc files) used to handle empty files
    gracefully. This behavior is now reinstated.

Git-2.53.0-rc2-64-bit.exe | 8d04f1be821342971d0b0b21e6c5345298849b69f0be018e93c770f027429fa5
Git-2.53.0-rc2-arm64.exe | 8abca21317aa6686e951a7adf18badb7c99d08b92cf3c126fcb96f1765e52482
PortableGit-2.53.0-rc2-64-bit.7z.exe | 24668b9ab15bb83becc0b6c2aecb622236473be741b5b6de94aa678008f9189f
PortableGit-2.53.0-rc2-arm64.7z.exe | ef8dd7c8b3583e62786ed491c5daa9294bccc3d03b583d3bccc40c7c2942df65
MinGit-2.53.0-rc2-64-bit.zip | b2b148f2489e1cc93ccf8f12ef67266b60e45790b59b0438ca700cd2c54226ea
MinGit-2.53.0-rc2-arm64.zip | b719fac6ec206b029270bdbf6a5ea9a301897adc69093d30fcc0ccfd3dcd76ef
MinGit-2.53.0-rc2-32-bit.zip | 52ca2e283cd20acbdb03628e6067dc5e83c56d884c7ea315fdd7e383532b07c5
MinGit-2.53.0-rc2-busybox-64-bit.zip | 343b9859def91cef588c50d279c18bd7fb8406a87c9ab85890ed2415d512eed9
MinGit-2.53.0-rc2-busybox-32-bit.zip | 4f7bd12a9979eb13d490c6136468be16c6a789fbbaf775bff7420b2f8d3fd5bf
Git-2.53.0-rc2-64-bit.tar.bz2 | 6087e25459b821df57294cd905a3a2e5f4403f132c5508b50983a0d3c5f294f9
Git-2.53.0-rc2-arm64.tar.bz2 | e4bb529efa52cb759e1c72b53d9ade65a5774eebba723b52eefd7aec074c1620

Ciao,
Johannes
