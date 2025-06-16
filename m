Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB001E2823
	for <git@vger.kernel.org>; Mon, 16 Jun 2025 21:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750110947; cv=none; b=q9hmuYMoao1Ko+w22mxlAMbsfYVVGzuQnnymn1aZ1r6uRjlb86Dgn6IzoXFPIY3bMeosG7PtYFuaB6gEy0NHJWcC9JBaGUhmcXE6OdTDAzWr5NqcM79T3YrCDXE8nIBmYBTnNYXXFljivvJM4GDMXzAgSvyQGZyPTOGRbkAw+fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750110947; c=relaxed/simple;
	bh=UgTMLsQz5n77MPSWib5kF6PDJYrK3/sShPpdXa90A0w=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=JmPAas8qLIrZkTSDQhEazp5lSB3RYEUIyTYexkNtaDeSJWHjU5Wl3qudxC+XW1uz7AgRIk3YaTU4GoGpfxBtP9VYA1PQXNkx9FentVyLcYQLjE3miEF1QtGB7trZ/qPYhI0WcyCIravHyGCTGFx2GnrlEN3KMXf0NLMCKjU7xe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=tFVeXnM7; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="tFVeXnM7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1750110942; x=1750715742;
	i=johannes.schindelin@gmx.de;
	bh=L5ZZQu/tMJr4LUGQBCcep20DzAbccQQBGKjvL98sMPI=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=tFVeXnM7MNzjxpmtKe5niCUAQPT3RJkzIKqykBzwZ8W32Gk3FMdZzyRIQ/GxnByi
	 KpXQ2WSEuMvDjmbZEI+UAUwKh9o2hws9aJLAp/wU895CynUAU0kSd77ZAZYtNzuzJ
	 TQ9qtYVylgxMG/xadmkRkPagtGbrE/nzBL90brv7FG9kQtxU9n9fPWfNxDFps79cg
	 QN07WEkiQlDsjCYFnHUIlhUx2vulmzdWUj2JdZAklSNzhPdZX87mgrC1PCMycJhJ9
	 jVJ8WVFXsbmMdNcDI8fFsF+s1dBMI8YRaYQf4zpxqkctkCy+P6TCpfcfVZlGxhJhw
	 /O4jjZFbC/vdp/JBfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.53]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N49h5-1urvRP2Oll-012mmd; Mon, 16
 Jun 2025 23:55:42 +0200
Date: Mon, 16 Jun 2025 23:55:40 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.50.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1MPXhA-1u5t1w2Yr4-00OF2y@mail.gmx.net>
X-Provags-ID: V03:K1:oWQi6V+zwgDhWi0w3o4/RS09bvWa4y3cVlmxhoUzVsIT0tS5sGx
 scxTWqJC1JO3TriOgMl6H2wV0+3qpQ6udypZWkeclY49DBs9uri1DiH6+WRfxqaLIHiq0na
 vt4pgF8tWBgfGOyO6ulMMvo3ukpB8vQ4nP7pTpX8Q4E6WP7XEWifrYYCf/jbzw5+WYvI3vi
 C8Z7VsI6MTthV8W6AOCXg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pzXp2bNadwI=;d8rmIr9C8pkEz+fMaGISCRHnxnU
 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

Dear Git users,

I hereby announce that Git for Windows 2.50.0 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.49.0 (March 17th 2025)

New Features

  * Comes with Git v2.50.0.
  * Comes with MinTTY v3.7.8.
  * Comes with OpenSSH v10.0.P1.
  * Comes with cURL v8.14.1.
  * Comes with the MSYS2 runtime (Git for Windows flavor) based on
    Cygwin v3.6.3.

Bug Fixes

  * On Windows Server 2022, Git v2.48.1 introduced a regression where
    it failed to write files on ReFS drives, which was fixed.
  * Git for Windows 2.48.1 introduced a regression when fetching long
    branches under core.longPaths = true, which was fixed.
  * Git for Windows' installer used a non-writable file for testing
    custom editors, which was fixed.

Git-2.50.0-64-bit.exe | 817a905f261b399580f476206a74bac1dd5aafef0e3e69d1263b7434c4c78b47
Git-2.50.0-arm64.exe | 39a7807393e8829b31581a1f3553592875139f9e1f25d3d27d1fe1d778336b06
PortableGit-2.50.0-64-bit.7z.exe | 0a16ff4699b62f171309dca221bd90f0dad5d4e68668d49b3ef0889bcb6da370
PortableGit-2.50.0-arm64.7z.exe | 227392b7e1a564af3cdeb3f301944712431dd9ed67d569a18fa67eba3f7db4b4
MinGit-2.50.0-64-bit.zip | 69b1a81f881077d3c89806d2cd13cfd0f2b31a4e934e6fb9f8370435aaa7a94e
MinGit-2.50.0-arm64.zip | b73a74019f16512bbefc86b9019b3dac9732ad64de8d99396fcc3647b145a11a
MinGit-2.50.0-32-bit.zip | 0ba70e3aabb99210f02caa02d31031cc6e26ef4770438cb59e6941276805c1a3
MinGit-2.50.0-busybox-64-bit.zip | e2f4e682b3894b55287609fd1889f671864d7f6324d7ef76329d340a33366660
MinGit-2.50.0-busybox-32-bit.zip | b6066cdd591ea6fe818db88b837436e2321309ab8dbd41d99167a301e5ed4783
Git-2.50.0-64-bit.tar.bz2 | 401528b4e6ff68dc370fc9b16b3a84094f47699d7bc6549b716c5918ab604357
Git-2.50.0-arm64.tar.bz2 | dcc0ad9983ecb4d56690b6df0634cab24241c5f6610b9b2a597b6e3a6d29149e

Ciao,
Johannes
