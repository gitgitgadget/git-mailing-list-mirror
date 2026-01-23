Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D134631D36D
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769181617; cv=none; b=qngFWBrZTNMLz2maTqeaC5Urs0KzEHZX5ioccJym47pi2WnPbmzxg57m46coUXXiqdmXpMgXvp61GirquV4x49Y/xwRzENEvz2/Hnj3M/GOiO9dN/RX8SDWVVIkqopXpos9dcnZL65rXWi4SSaWN8XEtEjZclP13JJCc3zHoxnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769181617; c=relaxed/simple;
	bh=b3qo6lhFolopSKhqHGZfqiqaBDvwLXET4/wk0Jha7T4=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=erCOYhS9a0ZY4Yl/Ze+21bE3gMx1oGilNqBqPJqCHKmjRASqSGvuYKy9FI24XRzyK2LNKwzkEyQelak7Y3+9sDRQ89IwN3JjVQINL6pQwFjhih+5lUvNKuWDpe/9XIVNM7brVjHtyw9XiW/tMj+Puic+5QALuS10T8GFdI1xT3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=hI2R18SQ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="hI2R18SQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1769181606; x=1769786406;
	i=johannes.schindelin@gmx.de;
	bh=HFmLF5Y6YfE6igbhEVEAn0aovxgCIhLeFmX6vxt9lCw=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=hI2R18SQFjeWKT1G69EPbDr9TYRTZ3FyGMnepir3YCUooDFooti8DoQFWVAviAl7
	 ANkSoXCS4iwjgcshdoUb1j1KbL/VoK549lbpbMOyUxT9/DdK3arxf+oD8LIqp1Um5
	 yUtcJ4QfhIeg+xn41xjpD0JzckpuKbMndG9O9CMsxONOqjaKMpbqwGV9o4Goh9svW
	 KJBBp6YntWK+ZjbXTxffYFg5UWAUAVK3XMCi0yvc8AfMMppaeBVQjOhf29Frby+km
	 vQO0OM71o/hKClE+Wh4ulEh8GulBdljdzVZmLTF0xC1U4VQ5ki/g6cnNCH0SIAMSy
	 JOyWELb7nw9NLDTPSw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.108]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxUrx-1vyLlv2tKr-00vHcK; Fri, 23
 Jan 2026 16:20:06 +0100
Date: Fri, 23 Jan 2026 16:20:05 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.53.0-rc1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1N0oG5-1vxFJ536aT-00yb0K@mail.gmx.net>
X-Provags-ID: V03:K1:AoC9MU3xtSmVKHl2eNyKlPsBWEKwuJnsNENJ6ztSsgLsJzhCXQT
 P0+AAa6ojRIw8eEOFxYlyaI1as4g7BCdamqw6f33DqjfaHH7W0vprBaGnD5xJM4DfZMfSMw
 vKsuDSZRgJ8Otin3pb382EgB0KFzmh5RTjnhW1rkQ5kXeM9TGDjZ5Ca18SboqaB6UuuX7zQ
 1XuGtqb9yG3PdZIoAGgtg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UH8fzzyR4bs=;3JKycKnr0V8T5REglu94uAZMYXc
 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
 aOfMx9mtTZEFVygQg3D0PxjVcUkz1

Dear Git users,

I hereby announce that Git for Windows 2.53.0-rc1 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.53.0-rc1.windows.1

Changes since Git for Windows v2.52.0 (November 17th 2025)

New Features

  * Comes with Git v2.53.0-rc1.
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

Git-2.53.0-rc1-64-bit.exe | f096761d49f49a28ecde93931ff9ad6a224f6723e01cce280fceafe448395643
Git-2.53.0-rc1-arm64.exe | 902cf8b5ac724f560c97d562a20b5408fe7ed10e090892758cb65068206c6396
PortableGit-2.53.0-rc1-64-bit.7z.exe | ee0a577cb05c7d4724d1e46c37a343db1a20b8d0296961ebd26e2354146f8493
PortableGit-2.53.0-rc1-arm64.7z.exe | f0d9da4591cfe3c4ea9776486a4efb5b172b3505f0da46195cd842bf656c8e49
MinGit-2.53.0-rc1-64-bit.zip | a5b6e44e6a26fbd331735834d42e78415e2656f54dba3ed693d55697c609bfcf
MinGit-2.53.0-rc1-arm64.zip | 024dcd91ca2d25956136db047a07b3da0b11814ca2553bc049f3ca714f2ea3be
MinGit-2.53.0-rc1-32-bit.zip | 826ae0958f038d196dd285ed1545c246cfab7f34f8f8d3ea8d94e837ca2bd92c
MinGit-2.53.0-rc1-busybox-64-bit.zip | fc4447e513c77288b2c654b77dd6918484541b9df2c4d550e2a5b18dca9e3617
MinGit-2.53.0-rc1-busybox-32-bit.zip | 1ac1a46b656ac55bc982b5c8be2ae0a5c1e13c82ea138d2d7c0582700f51c2e7
Git-2.53.0-rc1-64-bit.tar.bz2 | 59c23033cc5e14dd25c6ab9ac205db395d5f68949a1a37353c755cc336e089e0
Git-2.53.0-rc1-arm64.tar.bz2 | 8f96cb5dbc7418157c36935f304e6d99c37af5b3b2c8455a643850afebcd44f1

Ciao,
Johannes
