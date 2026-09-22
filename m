Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EA9544D5C
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 21:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790113246; cv=none; b=Bj64uq+5uWeAWS7cfowOBwSiyRvcJfgc+AqShaSJehY0qH1IIiMBydP51P+EZO4TtBxma+EAhEYYbGkhzbQx+2jB9zbZ2mrpixewqQ3IYYf/+eCaUrr/LXOUKXAgdBRwIyMYRTc5mZz2p6pLiueDEo/37NArTjFKqSCUPwmLggw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790113246; c=relaxed/simple;
	bh=XA4r6TxM7b+p7/2owD2EtRA7ecBTq4k8IPdzwdHBhp0=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=oDSQwjswGLXk2JaY7jTH+DdQ5omDczUeY8FIVR3J1x+TIlaRYm/10fPEw3nq4Z2NnhuQzSvmwG13xFxgxGKnyB8DGmkm/NuTW4FoKvD/8Ba5Ey6qjLLCKzg67u2tp/hMmUEKRQ+C8frbWPKzfqQrysY4463VWem2g7RcMfS0fV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=VJu0XCJX; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="VJu0XCJX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790113229; x=1790718029;
	i=johannes.schindelin@gmx.de;
	bh=zGkIjtKhvOYV9hEVaa5hH0yko15FAFPmb0RW8o6ymho=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=VJu0XCJXMbwQtUisTlpwOMJY+vF6fXElguvVa2BP5508kI0BdXWboHDQwO+rzUpy
	 yhy8yKFfZ2I9XeAeo1ahqg7q3Ee6Bv0L+tlZlxcbhju7OUB/h9/SIv4qBHGcY/VU8
	 obm46eDQuSF55OlHatwAdeyRY6Or+fHj5cr6wMkOiROJq3uDfK1j7HWCMG4QKIBPT
	 ILS6YQURqw5xuZhRvPgyWRME8X4O/LWKxr+8T//MhTmIfnFJr0OyHhuuoFGnUIbNi
	 Dsa5mitWef4UddLIyrxUgqdZoLXlR/ZgEB4j+JI4u4mwgEd6oivRZ02ei+P35Ytlp
	 mPSu4Yf2Cv5ERqby1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Ygz-1xB4AI2XyF-003rV8; Tue, 22
 Sep 2026 23:40:29 +0200
Date: Tue, 22 Sep 2026 23:40:29 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.56.0-rc2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <1MRCK6-1xNLA12nEy-00MMUj@mail.gmx.net>
X-Provags-ID: V03:K1:DfPCOggDGoortmSbwqprJUBVQpnSWvbdW5XvVB9ny1+CHBbAQs4
 rZYR6snElbCnwsoyS5e9SVr4utrgb7Q7Dp4KktrzaZDXNPmrn67aEGZtMldqg7GKDAhCe/F
 BWTUt+QEWonFofnqgEs0UX/51fDoKo2KyCKpe1qpBhYKij4vdgbPPFAA1QIhToPqphzXq06
 k5hscmgHd3dcDp3BKIlrA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:c/lRWSjR2L0=;5xHJaptXmx7NydTHp+tfvWQLI9C
 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
 jVgY2wzgbRFeek/WNSijIZYepDWLkev+7LA==

Dear Git users,

I hereby announce that Git for Windows 2.56.0-rc2 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.56.0-rc2.windows.1

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

  * Comes with Git v2.56.0-rc2.
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

Git-2.56.0-rc2-64-bit.exe | 8e281eca0b4d911903ae6545016aa248d6a8322f0f794303d54039cfbe1707a2
Git-2.56.0-rc2-arm64.exe | ee47e6b1706554c574875ab143584e323971ae6a2c2089fc0ecf14b679b30d5c
PortableGit-2.56.0-rc2-64-bit.7z.exe | 81f2718f7110bafefaaa8a996ae2236115ab20eaca86e3b00688981f967b1d59
PortableGit-2.56.0-rc2-arm64.7z.exe | b2ee9d4c4ebc260f798e40f02beaf9e0513675a10c97cd6f9470e53e73d41229
MinGit-2.56.0-rc2-64-bit.zip | 30fb85a3fbdca441bbe9ec330f4ff0fa7a946f4ef6ade28ff8075ee16d584d47
MinGit-2.56.0-rc2-arm64.zip | 3ad9ca61b8d69a4dd1e0e2abfce0f98dc261b0325038734d94997faa5af27f3d
MinGit-2.56.0-rc2-32-bit.zip | 27d1e333008eb57b863a3b83f7f4f915397a52642d224faae658b109451ba698
MinGit-2.56.0-rc2-busybox-64-bit.zip | d90c636e0665ecbc5efef8aee9b0c6981c495b41f543a51d40eb7a3882a8fb40
MinGit-2.56.0-rc2-busybox-arm64.zip | f33b8f0603bf2f629eefa62bc8ed89490766f7a93946d62eebb84d38e1811716
MinGit-2.56.0-rc2-busybox-32-bit.zip | ca6fe419616abdc3c6d0758f11eba1afdf57e10194f76d5171309f802273463c
Git-2.56.0-rc2-64-bit.tar.bz2 | 1cf1e95599ff3534ae39bdb60d4fda2384382696148785b3c5e807ce0600b19d
Git-2.56.0-rc2-arm64.tar.bz2 | 1b07b5e7fb3f57de51e076984933480fda23243b060ed6afa5f74b12bbc22683

Ciao,
Johannes
