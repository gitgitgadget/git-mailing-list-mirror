Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA49337B84
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577443; cv=none; b=K8FcQoq65hnJrVLqRLcmaz/6HnddGZWwQsNcHmHVFEzPN2IbQGVJFkbKQ4WA5mVdWhCIEX5lvnGzvgy+4NCx0U10FK5p4ixfef3KKx4EbLf/+X+tZcXn6paPjF1QnsBIFtG/cPQhZC46ErEq8buOdfy/6zn325QQT0EY4m+ThZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577443; c=relaxed/simple;
	bh=UFp/9XVZiybQ6ewvBVccz6SAxn3mbJV8mLuoAI+QjNM=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=XA1fQaOTdkYnoTkI3YyzGDNXZHyZ3TnqM3IegNWmZc9IZftOuY4MsmP+ew6lfzHRx5mJgd7vaJ+rIhPmi6QiYB+lUNorbZbxgfMMD8G1ylokpqqf/ePdtfUZTzDEZ8iiD+hSRDeaXopvk1RNyES+DUPMDHbmJ5phTjoiabjmfLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=KWTX63B2; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="KWTX63B2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1768577438; x=1769182238;
	i=johannes.schindelin@gmx.de;
	bh=mSwQFds+OJk2Zl3fZHv7fHG2kRdNc6Bd/lla0QCJsvc=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=KWTX63B2CNF6J4WlrmSV6GR+548xcpsar+/VwobtZEh19/CtGdvlJ7SOeDdrA/VX
	 O4t3AGE2N//amOM5eKRJ1Pk5dACHksv3VvLwwHBo0sai8rrt+BeubkMm7ufVKQLyN
	 FPjY8W4GiQL+cfWGEIEKv7SnWmnXhNKDVaeUzQg3l4LVnDORf3knrROSwyvhZT7pt
	 KkWZk+S45Knnz8b5+eC5ED/Ay+Vpg+4LCjE9pWL4RiTbPaw6LRZfZdiDEfy5nPrti
	 U3P2w5Vy+GaGnfExed14Xb2UuoEtAS2RjGOH8wtTrYihycXQTDpr4rSqXVvN7XZpG
	 qHtuD4SI92HXFk1aFg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.21]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsZ3-1vb0cb1Sr1-00A0gY; Fri, 16
 Jan 2026 16:30:38 +0100
Date: Fri, 16 Jan 2026 16:30:36 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.53.0-rc0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1MbzyP-1wEj5N1dfD-00evZm@mail.gmx.net>
X-Provags-ID: V03:K1:BGTVJ1XDqPRjOUoR2jEhFsmSc9X/tUbDCVI0s/go4l5yB7dh/e2
 GVP2ZLSVK800CGiAGrrdLS29APbJ5AqJ12ETxSqa+1PNdy9KKk7+lt8mOJ+AoQE/oC2cW1b
 zSFN74fKTrRStmtrrAwEWjZbbh4n9t18qmwYbTB+GlAsApAkUV4BcxiEOe2/YcbQvNb2V69
 P+aTI1RcjWqyPRNilXcTw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:knf/Ks6Ae0o=;KOR5tJIApuRsf4VXen1YVHO6GB3
 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

Dear Git users,

I hereby announce that Git for Windows 2.53.0-rc0 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.53.0-rc0.windows.1

Changes since Git for Windows v2.52.0 (November 17th 2025)

New Features

  * Comes with Git v2.53.0-rc0.
  * Pressing the Tab key in an empty line in Git Bash no longer causes
    the session to "freeze".
  * Git for Windows' installer is now built by InnoSetup v6.6.1.
  * Comes with cURL v8.18.0.
  * Microsoft Edit can now be specified as Git editor.
  * Comes with Git Credential Manager v2.7.0, the "anniversary release"
    after one release-less year, which brings native x64 and ARM64
    binaries for the respective flavors of Git for Windows.
  * Upgrades the memory allocator mimalloc that is used by Git for
    Windows to v2.2.6.
  * Comes with the MSYS2 runtime (Git for Windows flavor) based on
    Cygwin v3.6.6.

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

Git-2.53.0-rc0-64-bit.exe | 714b50a253602b2e854ecc283c1755a6498f751fbf80db7ba48861417c5bd229
Git-2.53.0-rc0-arm64.exe | 1d065239b58f9ed97a52f0d0d8f80ed76b205974d4eb953a21efe8375695c233
PortableGit-2.53.0-rc0-64-bit.7z.exe | 46047a303ada6cb981d67720a8243cfdc3c664d77044d410158c1608e7301b66
PortableGit-2.53.0-rc0-arm64.7z.exe | 594e7a5eb5821e7aa2d204893cd9dd2073dda72c6e2aab0746adca93afc6b1b5
MinGit-2.53.0-rc0-64-bit.zip | 7e74f4c1a210769a9e44440aa2fdfa836875e92e64774f512a8cf250345bafa4
MinGit-2.53.0-rc0-arm64.zip | ee2508dd6bb3d87112e8288612fcf3eb3e13607fcb03a8db1e22a820265774ed
MinGit-2.53.0-rc0-32-bit.zip | ddff1fb9cb73d41c90bb7d9c8c463d8104eff305c74e17e43419fa2a3873cb41
MinGit-2.53.0-rc0-busybox-64-bit.zip | aceb7c886eb63e6f16aa8ba48bc02828138309908ca8a647883d5945471262c2
MinGit-2.53.0-rc0-busybox-32-bit.zip | 5ea2d68a294b7d52266259bc5558a3824e30a31e972fd3a9a2c40d3f55dff39e
Git-2.53.0-rc0-64-bit.tar.bz2 | bbdd83073894a08a2089051b496ec7c6845c0a25f9bef3e35bcc63cb3f4709e3
Git-2.53.0-rc0-arm64.tar.bz2 | fb74602f5c8023e90e334235d85c5dda175903c9e6d74a43ef89fb6938baeee7

Ciao,
Johannes
