Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D422F85265
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 20:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708721887; cv=none; b=UYiG2INi/F9xECLJF0n2e2HL6pCr+YrrET47MGPFTTLyJX3ACB1X8wLXqQu/DfP86AhVhQB6ZCdBmSKU41HwMUjrIH2e04gcg8EoYva4NdSdpzLpZCkP2ETDiTMGq2Yqgp05dqP2BFyK3//ghaSDu57FZ/zYOCTRwKjv8ysomv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708721887; c=relaxed/simple;
	bh=lDKsTNSOIyhb+O+HWkpJIHJ8xR51/xQaSz6GOne4RNE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NbUl6kqY0rcWU5BezqfUiWvMvu3O5uz6lgQvBvH7StL5b5mMt0fla6tTFSw2iOp913sE1vkMPyKULYJ7f0Yvv2E4nYTA6zALeUpi5306uY6bDAVLWWuBF3Q0fR+wRfu/B2Bjs1cgQYp6mDFVmjgdj5J28J6fJley7sYtjYf2reg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=OV2miMi5; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="OV2miMi5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708721882; x=1709326682; i=johannes.schindelin@gmx.de;
	bh=lDKsTNSOIyhb+O+HWkpJIHJ8xR51/xQaSz6GOne4RNE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=OV2miMi5Ojw9E9jQ6YhsCUB3VxcBA4EM7w1bjAjuze0I6rrJJ3jvfDH7M1oSbNdf
	 UmZr4I0/Qx73XJoApj7L9maq3MAbcpwOWGIBh64YqT6Sm3HF29AtfTxMjEVl6auv/
	 HcPUqw8vxj1LJ6nD9kb5dCKRC5sHrxC7DRPPQOfFjSCX+HT5anuEklfu0PSI2l0yW
	 Q0srsC3cTuPtHOcKFm9tHEk4QTTdlqeA7zip0oOvyTITaLjLqr+ogbevE/Xaote0k
	 ajcLAe7jrrwFXyVcVSj4oA3rRrO2dSoFMAl/pMrrFNr5jRsHc3UsfaxrsqADy82ln
	 pHULPnfe/HSNLehDXA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az1538-722.upsp13a5k4ou3ds4kr34xzh2lh.cx.internal.cloudapp.net
 ([74.249.13.178]) by mail.gmx.net (mrgmx104 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MK3Rm-1rLXlf3JTK-00LRtR; Fri, 23 Feb 2024 21:58:02 +0100
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git-for-windows@googlegroups.com,
	git@vger.kernel.org,
	git-packagers@googlegroups.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.44.0
Date: Fri, 23 Feb 2024 20:57:59 +0000
Message-ID: <20240223205759.3596-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.43.2
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Fcc: Sent
X-Provags-ID: V03:K1:RyrsEgdqe5dihV3hVwI3PT7P1vAHNNua39r4d7q5ZVG9KKbIotU
 W1R//L+u1Tk3cQizPRxiKqj4WpateLQzTEyYph97B/C82TgbdjjkSsoSmMrXWfMnbxvnMXf
 6Q6P/deoHGFRd4PPnwoX1ml8T2tWmotOBROzpCOBuazrdVeZuYnpaR9EAFtwCTQDA8aZKyv
 2y3cTbHUwDXhTllpQZqlA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BMaV9WxJkvU=;WaxwCOtmegvTDqqhWRd9rr3Pgr4
 IhkQ9W8TN6Jn94HXKLg0RXrf0BHskm6MF2GJx14U0vIhvV2lU/1ZpMy05MyNlm53+QyISIkm1
 op1jODoz5QE6rIHr73WRquT8r4eZCd9V7UNNhpB1qQHxoF78kUvkKO8YRqpstijM4NTr25jhR
 2Q0EDBYEty39gOQDJ9/8qZbQjCzI1FeOIQt4WMWVx8uQ+Niw9SCMCvM/FZq8XKkAWSWqa8uER
 EezWzDgXNoIfMyIqB7QrJ8MqIPs5JM3f/0B8b9wXqVi6me/NWkZGk+qy3nVzQgw7fVo5gu4HS
 MZMMF0K0SoeelUC6p2GhKN3rjzt02piFnE9sMF6FnCJ3Fl6PdhePSAfcH+mmlvGoCS6jijBZE
 2ty16hadRssc27nIrg8MQlPqdMh6CTAxuL/dycGH595gIzCMiR/pmT8FnPcD1MUvdkH5QOlxS
 cf7wqMPaRUL/hjAnrr09PPnISA4z5p6Htxlq0P0zco0CKy/k5956T/5ACnN7WbJjPo7BRr/2e
 7Nfp543c4wDyPnaMKnJ8WO5wM+HDYhRonDFMA9g0P0W9g1KqOstQp8YNjNs5XmsRBs9TGhwCC
 C3F3FX1qDAxtwaTqNGCv1rjBUsR/OVAGF+qDTuZOdIkXYMCMyiCH6GsFxjJ2xVeIh+d5G5VLo
 RGzUJF15kJus4YD7ERkBPkfB61hsU3ymb7ief07XYCNOwG2M83/xkt0pgn51eiBHwetlpmms3
 7zpmo1ZSYN3WmbakXkc/b5u+j4kTMbCLupFsjBXqXXtwT0D2Uv7+BtUqxl+5qDEbcEKAcdIEL
 S8+HsnlIfgLL0SlYscNXV2eXc2OsTQ87lZgxUQSNBROW8=

Dear Git users,

I hereby announce that Git for Windows 2.44.0 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.43.0 (November 20th 2023)

Git for Windows for Windows v2.44 is the last version to support for
Windows 7 and for Windows 8, see MSYS2's corresponding deprecation
announcement (Git for Windows relies on MSYS2 for components such as
Bash and Perl).

Please also note that the 32-bit variant of Git for Windows is
deprecated; Its last official release is planned for 2025.

New Features

  * Comes with Git v2.44.0.
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

Git-2.44.0-64-bit.exe | 914ffc96cee0631d09049b9d87d4cd8ac9c98ead9a9f9a094d3341348324a9ec
Git-2.44.0-32-bit.exe | 5ba23d73e861d872416175ac6a05304875d6ec420c08d0217329580ca1ea0fff
PortableGit-2.44.0-64-bit.7z.exe | 1fc64ca91b9b475ab0ada72c9f7b3addbe69a6c8f520be31425cf21841cca369
PortableGit-2.44.0-32-bit.7z.exe | e70c80672069907961f6db68b0db5e14ea0447f39c74cfd3c385882f3b934c6f
MinGit-2.44.0-64-bit.zip | ed4e74e171c59c9c9d418743c7109aa595e0cc0d1c80cac574d69ed5e571ae59
MinGit-2.44.0-32-bit.zip | 3c946898cd78c5106b1672dd80051953bdb245fb46352a70606f271d8b0233c7
MinGit-2.44.0-busybox-64-bit.zip | a2377f6e4214f16afa1a5a23d9a291d09a2234bcac67c5aeb36d9cce4b7b4d5b
MinGit-2.44.0-busybox-32-bit.zip | 83dd7903f8a4b2a035eda510d6d1394acc9ff36ce45b9e55efd7dd48c83471a4
Git-2.44.0-64-bit.tar.bz2 | d78c40d768eb7af7e14d5cd47dac89a2e50786c89a67be6249e1a041ae5eb20d
Git-2.44.0-32-bit.tar.bz2 | 14541119fe97b4d34126ee136cbdba8da171b8cbd42543185a259128a3eed6b3

Ciao,
Johannes
