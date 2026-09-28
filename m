Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7463BCD1A
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790628746; cv=none; b=Y9ncA8fRHh3o6Zs1vbBSO7/8FbHSLxi260h+ozjM0H6cU3n7unxx6CFkKyj7+lC5aKzvQxr//zTpF9o71GqyaFSJy+6mBDkcBFxn83hjA6TUohhwhGmKsLdNStob20AqqsFGm2wcNQY5naQs7i5xLwYzkuyS2Qj3t4ZHq9i8bgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790628746; c=relaxed/simple;
	bh=fkhzhvi12HfL9Dr2gSbHSKrwQHq6fNdMvNnD8j/p0Aw=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=uerCTK8RlNwMDjZnDN78xop7UTZBGSREycRs58LN2/X+dFCoFeuWqwAIUxAfaGVSwVlLa+CllGgi8v4wYD2WNhLR3E304BmChhiIuGP1Ch2ZgnIu9DaSctb5+HNbhAXyoqYt3JTNjBRk/1uHGEdl9JcBXAPTcMMqwM+fLUkTpOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=My+6g4f2; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="My+6g4f2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790628742; x=1791233542;
	i=johannes.schindelin@gmx.de;
	bh=urdpkMb19IyCzluhAhK+O3GydLZkRELCVemD+ITsmIU=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=My+6g4f2OhasNC9G9Td93dNgpa63ZHF9cjldYccUkAKwdOmFQ5IMm2IEYemm2ry4
	 VvxSzC6j7MioV28P0Hu0QkJwj1bworJ3zz1/1EPFuboaYpljFJTZef1B98X/82qlw
	 PVvEoWvu3r36y08+bOswuEPSk5/5ak5TkB+T1In3xQp8wWt1g0ESg6nLT4+qIVaCu
	 e704/8b6zTS77EIhKQVqYZIbv7JNvqgJR4W+1vOOg3drwqopG0PF1wNUc01QL05rH
	 GWvY/EaaTUYwmG5/IQ8iibPaaZ/WzSJwypJMNZQt4KOtoPnkLe1V2UZMX/z0KEY22
	 8r0HpYt6ZWk2na58aw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiJVG-1wY5tw1jnC-00bjla; Mon, 28
 Sep 2026 22:52:22 +0200
Date: Mon, 28 Sep 2026 22:52:21 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.56.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <1MPGVx-1xNaxf235h-00IPfN@mail.gmx.net>
X-Provags-ID: V03:K1:vHLFv05XrHJBOJCr1nhRlnLLVlFgdvRU88oxtzDweEADnHCEkhE
 M7X1mjlqL7IQlT+jOfRORff+t2eUl28JRcqj2ENTUEfWZOmm4whQ17Xf3CDcU/nyWY2J0rR
 yqs5HeEbaqvLMjmw9vRzvbim77IITBY/p6lhzei8shhkyobhF1s7Izmczu5V/7rmXpiXQRO
 ipK2qxKPt0GnbtGoPy0yA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9vqkvaHTlIk=;LMmvbYPmwoXoKmLuZIrnjKADluj
 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

Dear Git users,

I hereby announce that Git for Windows 2.56.0 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.55.0(5) (August 20th 2026)

Following the MSYS2 project, on which Git for Windows is based, Windows
8.1 support was dropped; In doing so, internal paths changed (/mingw64/
bin/git.exe does not exist anymore, /ucrt64/bin/git.exe takes its role;
if this breaks your setups, consider switching to /cmd/git.exe instead,
which is guaranteed to stay stable).

An issue with the installer for the previous version
(v2.55.0.windows.5) caused the "Use external OpenSSH" option to be
disabled for some users. This caused the bundled version of OpenSSH to
be installed and overwrote any previously-saved choice of external
OpenSSH. If you rely on an external OpenSSH installation, and you
updated to v2.55.0(5), you should consider re-running the latest
installer with "Only show new options" unchecked so that you can
re-enable the external OpenSSH option. The bundled version of OpenSSH
will be uninstalled automatically. If you do not rely on an external
OpenSSH installation, or you did not install v2.55.0(5) specifically,
you can safely ignore this notice.

New Features

  * Comes with Git v2.56.0.
  * Comes with Git LFS v3.8.0.
  * Comes with cURL v8.22.0.
  * Comes with OpenSSL v3.5.8.

Bug Fixes

  * The installer is now actually a 64-bit one, which fixes the problem
    that the external OpenSSH option was broken in Git for Windows
    v2.55.0(5) (see notice above).
  * It is now finally possible to commit 4GB objects or larger in Git
    for Windows.
  * Fixes a bug where parallel checkouts could abort with "* stack
    smashing detected *: terminated".
  * A bug introduced in Git for Windows v2.55.0(5), which caused vim to
    often open existing files with the first line missing, was fixed.
  * git difftool will no longer crash upon encountering filenames that
    are illegal on Windows.

Git-2.56.0-64-bit.exe | bfe94e7b419b16eee9fecbd1253a98e3d4f49ba8f029630549052278ffe286a6
Git-2.56.0-arm64.exe | c130c04301d06995ef08f1cbd895342844d1fbb3312f5d32cb27cc05b4b394dc
PortableGit-2.56.0-64-bit.7z.exe | eceb5e061aa90df2f69ddd3e90f0030e1b8037a7829934bc40e4be1caa1accc1
PortableGit-2.56.0-arm64.7z.exe | edd9bd32aefa5d2bd4b938c38c18ceca306a7f6b29a6951cd6a4bb16d9d28d8f
MinGit-2.56.0-64-bit.zip | 064b440ff870ed5198527e8f3a92cdf5bd2fd0fedf5e718af95e3fdaddeff718
MinGit-2.56.0-arm64.zip | cb3b0f2d486ea52673227151a5baf5bc13861ff80e74e94e46d614d1bfcd5c06
MinGit-2.56.0-32-bit.zip | 9f8266486c8818b91cbb6b719e35972a406f7560e86b82fbda2f3dcb7c069f12
MinGit-2.56.0-busybox-64-bit.zip | 2d432c98e9eee92161f49006a18cba24b33e142c6050be321236910805466f37
MinGit-2.56.0-busybox-arm64.zip | 6e58f3338a4445ffd30a738359ed2eff1e31273f643d996f26bf663f05850663
MinGit-2.56.0-busybox-32-bit.zip | 853aea4977c510f9b2f60da0fab0607ddc4111193f266ee8f1c1fc36429e8a70
Git-2.56.0-64-bit.tar.bz2 | fdf531fb5c003fff0fed1b3ef282134c9186518f284c2e10860214ce127a973b
Git-2.56.0-arm64.tar.bz2 | c86aeb1afe43d2d5afc27c4586a10795a3e28e4ddf03cdd944dfb248526bae3d

Ciao,
Johannes
