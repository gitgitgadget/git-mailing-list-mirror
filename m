Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0078A36132
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707560370; cv=none; b=rbtnEPhYPNYv9tRLOBiGCh0q31qbC7h3YVK73WLS7X7FA9V1LPm33lYGDb4zDL4CMZWrmGLZly+DvFMM01HVsmJ6xRX7Vc7O/hUAUmf6JPNhwdHzrsUhcpPCkgKTh130MZa88UQqR5l4KyvtVEBVJYLDguCJNak/QKNOobf303Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707560370; c=relaxed/simple;
	bh=OB2mqgjpHKX+AnvIlU9j9G+wWAk9ewVKuYiTrbUZ/PM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=D4Ufe6v5HCtFEP5TzOeLvJ75ZSg/kItnfXKt5M7sh9wmtvu0++k3AiHzS2j61PPbspEenI2uNtaUChRbT18QOUC9+O23ypu1V2Q7digYkHEkLAv4cetunO1PUI8htPIyYffl+F7U2czl6pnlvDTSqK0EbzHIQ6SpAk6xGfje6lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=LoU14k3n; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="LoU14k3n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707560365; x=1708165165; i=johannes.schindelin@gmx.de;
	bh=OB2mqgjpHKX+AnvIlU9j9G+wWAk9ewVKuYiTrbUZ/PM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=LoU14k3nRMXRUCBvhfOMLZTGGjfIWtuQFYmbkiIcE+Kx2HNgLjQppGgFddSiDrjk
	 Ev/e0Gw5TWB7pPfPnysawZc9lLODE6DPzYrl0h/Y+2umhWklpzB9CAlQrSXZ374rk
	 5UqysppFIlLmqEigJJ+++FNuCe2gmUSA+Yigmjgq4S2/bRcKUizOmbDQ+qAyQOis/
	 EuJqeElZnLVxj76M5W7b2lMal4pEecbPRW0ROrIez+/NcJz5TDV0fUC+Jz/rSKB52
	 p9ZCKxUDXzagyTrq5l/HXDmlviwO6JjzCTtYuqgD2I4/FqnvhWYJ6n0qRtOjYU+P+
	 tKZ12CpPGtM0nqop0g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az736-619.alpbqrzxv30uzkvtn2qktnuusd.cx.internal.cloudapp.net
 ([74.249.5.226]) by mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MI5QF-1rk4S33r1z-00F9T6; Sat, 10 Feb 2024 11:19:25 +0100
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git-for-windows@googlegroups.com,
	git@vger.kernel.org,
	git-packagers@googlegroups.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.44.0-rc0
Date: Sat, 10 Feb 2024 10:19:22 +0000
Message-ID: <20240210101922.3663-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Fcc: Sent
X-Provags-ID: V03:K1:EM+jAoToWEQd2IQCEerC2qmtxtVOmofsw/m9rUMpGxyICWCwz9c
 Bd3e0mnyILUzuANiUrGL50IfdiFY8lqo4nvrI1XlE9yGaR0CSwQOQLOy3YXNb0piuni+pMN
 hCLPZV40mOd3DRTaWPMFMUsYS76gT19mq9jF0eAFwGa1k61Lk5tA+sQvFjt0Dt+SAvFbwFA
 FngLZcRLZ8KyR11TdsJ/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pvLLmCe2/jQ=;fy6Zfvdch93yj98YmwkCMxj9erX
 ECR9aYnb8Tpxxv+casJFGeFJgXc6fRCZhnNE4G2xlVS30egWToWud5ileUVjMqzpEvKp4T/Ol
 6uw6n2frj0bckAez19xNl1uAcl5hFWIG9SJo0W+e4141HAtSL7Rox4kkIDivq6ZX/lH7Kd7vi
 FriFnLmNOU2bIgAf1dCGB6j7Ogei5UlwcHCKSgxvJYfGBMjN2uZQI27ZxQH4tchsLzhjZ8faX
 S3Dg73opa6C9BNp6wWn+SVEnPKedBLFr+B+cQhf90Il+Wc8uDMxTwd+RWZu4ux5ronbra0U1H
 iiw6tkWyk/YEurCgJnWmFx1yFgOUGF20UX90/4mO8fph3Oa/eTwOxO8f+WJpKFi0/84pivMIS
 JR5rrsClkqfEkZ/+V7vfTx76QedxndCpuLBnjhQnI8KYYcfF3G5XogFJ35UgRWMGDegu8AhjC
 mk+qxPXHQ9k6etPxqwc64FKtah6nMT4mtq1cDNIXIFulGnRxNFVxzev36YVkGUZd44aQ7ShTc
 BU+I8XUAyutnwsucJNZa5fBDomn5X+7b9DiUcnaOLZl13pXtXrNVYgWaU8UySfATkdaEyEMnI
 06SuF5XGfHWZRZRh+bklt4wCF1iYV5X0opfbnd5I+YidwGul3jpFOyR7cSmgbKCfovVNfF+0D
 PfIu5UYjv2nm257YtJE3YouM5o7tXV+tvqxSoS/dYOYJE+QlsIkVLh0xV7qSeAGGKkl6vVCY6
 5dRAXx8m4TOurKKm84mm3w35BeB2S8sQ2m+HA1d1S0UMgYXKWAQ5ye+LAGVtQs6Nr4cKQUnra
 ynHcPzVyBScYEdA/5GbZDgSRGAp9oVRoa/mMtkPSTeGqs=

Dear Git users,

I hereby announce that Git for Windows 2.44.0-rc0 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.44.0-rc0.windows.1

Changes since Git for Windows v2.43.0 (November 20th 2023)

Git for Windows will drop support for Windows 7 and for Windows 8 in
the next versions, see the announcement of MSYS2 on which Git for
Windows relies for components such as Bash and Perl.

Please also note that the 32-bit variant of Git for Windows is
deprecated; Its last official release is planned for 2025.

New Features

  * Comes with Git v2.44.0-rc0.
  * Comes with gnupg v2.2.42.
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

Git-2.44.0-rc0-64-bit.exe | b3674c6a4fc010dda9065130e06d9a3c8a4b900d2c3b2bdf8183cc47919940a4
Git-2.44.0-rc0-32-bit.exe | 344039b0f71bcd07a19747ec58944cadc175c24f37365e4282d60cc77c77687d
PortableGit-2.44.0-rc0-64-bit.7z.exe | b5b29161c2f80d7b0b9183fff274f545f0c4290e9ce1ef820107da44bf424a07
PortableGit-2.44.0-rc0-32-bit.7z.exe | d1b6c533e5ec7df93870c085b960ad2112a44e1fc9d52cd97c530984892e5cb8
MinGit-2.44.0-rc0-64-bit.zip | e3e2d8f601bb80b6472cd9d58a3ca7704f245b015e236d9b56231b4ced08169f
MinGit-2.44.0-rc0-32-bit.zip | 953c76671644727df28f1b78a80c97266a25d62857afa36e7aacc88ff365fb97
MinGit-2.44.0-rc0-busybox-64-bit.zip | c65698f812ba3090215591978bdd62523922fcaaca31d8fdcaf27c6b75ec8ec1
MinGit-2.44.0-rc0-busybox-32-bit.zip | d614f5b893c8d8784c8e78c22470540eb050946500e57aac65e08e4c403510eb
Git-2.44.0-rc0-64-bit.tar.bz2 | 4ad88d90e553cf31b90381c1ca880509c7c51c91e330ea1b9b73733f31598eee
Git-2.44.0-rc0-32-bit.tar.bz2 | 28f4fa7ff42bd210e944173417f6efcf3b055bfb0ef149941ced91f03ab1560d

Ciao,
Johannes
