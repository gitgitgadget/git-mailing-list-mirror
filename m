Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C5F14A60D
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 18:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998205; cv=none; b=fICz+mCgTDqN2NcG5Ab25P6iwqjBThSJsSJ3/Szb82PQe9s2sdbSnKrV0V4myCkPhdD+LRbPwaBqRV9bybtI0mXCQWQbytMHM9RmUOyPziiWbbiiNI8rmy0PEtb5HJwz+G6TzUu6rXsMuqqjT+qId5MNhkrwkN36W9UMSMXhCjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998205; c=relaxed/simple;
	bh=2gIWIE0L0CQDjpEhwFgopVQ8HJPH0faFdWDTJNuGXTE=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=lzNOoo8cjNvcZuBX7iFJEPCrpnsyXCkCY84H73CIJHIRIXn0DtMBoDHsB+XUidxOuO5WcpVyHToWBdR/ibHckvUDdebGg+3nVgaHaQLKxpDRsUnXkS21B64scluERkq/+/yg4pPDi3v/EeckKXP0QChHm/W3pm0VwfwgJyeSBKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Vq471jAw; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Vq471jAw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751998201; x=1752603001;
	i=johannes.schindelin@gmx.de;
	bh=shNZK3cNCF2AWfgGvl2wZCqGCy50dhoL16EnK2DpK5w=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=Vq471jAwL76wqCJV9MeFpx4+EMfmBrtzgsYjvAod9zGhgoORrvbWtTOJJ5Pwxzns
	 nHNDUKleRNJqFXNRj65mNgJt+YckY7RRli9LTHLMNjhqJkrSq2KmzZ7wOaWJWdFr2
	 RuMlD/pRppkpy01U5jXrEEJbFKfAu8ZByIsVhiCjif/6JPvA7hZcwCNYZWrlCzrjE
	 KBY7BQ0GGLlnQYxAL+X6GOUG0GTp2I0qyR7eytMv1T0ADpxG49nyKNqrIaasjFHHO
	 ZRXxc+fhJRM2FguVvgR6bpxGdFrhRzPOKWxv3eqR15Sn1k3qzInc107G212Mev0lh
	 eAK5Jq/s5sVj4flzkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.119]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTiU3-1u5BXo0TnR-00S3C1; Tue, 08
 Jul 2025 20:10:01 +0200
Date: Tue, 8 Jul 2025 20:09:59 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.50.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1MdvmO-1v7z1L0dvS-00d1Pa@mail.gmx.net>
X-Provags-ID: V03:K1:92JMMKl01RZOSQUdSM1mN565E8DAVcWq8B/PQIuuxykHPTLkkdY
 8Lx7yRMJDjl06fmkYWDoSWXOF51Wk/zSiikaO5GW7/GYxtp0q8B3cELCbBthAo3kTCYGSBo
 FNiKFvAc5/DAPOF/zzEY91q5wwo9aJlZUOBqcfF+Fdn46DQ+czLeGnItQbh/FIb1VE+taAB
 qXybxyldfrOzaEv6zkMLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QKklJGhpGMA=;RA79pqOP7RDbwXkGVGzGINLCYzE
 +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
 b4pX26JMFfw==

Dear Git users,

I hereby announce that Git for Windows 2.50.1 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.50.0(2) (July 1st 2025):

This is a security fix release, addressing CVE-2024-50349,
CVE-2024-52006, CVE-2025-27613, CVE-2025-27614, CVE-2025-46334,
CVE-2025-46835, CVE-2025-48384, CVE-2025-48385, and CVE-2025-48386.

New Features

  * Comes with Git v2.50.1.

Bug Fixes

  * CVE-2025-27613, Gitk: When a user clones an untrusted repository
    and runs Gitk without additional command arguments, any writable
    file can be created and truncated. The option "Support per-file
    encoding" must have been enabled. The operation "Show origin of
    this line" is affected as well, regardless of the option being
    enabled or not.
  * CVE-2025-27614, Gitk: A Git repository can be crafted in such a way
    that a user who has cloned the repository can be tricked into
    running any script supplied by the attacker by invoking gitk
    filename, where filename has a particular structure.
  * CVE-2025-46334, Git GUI (Windows only): A malicious repository can
    ship versions of sh.exe or typical textconv filter programs such as
    astextplain. On Windows, path lookup can find such executables in
    the worktree. These programs are invoked when the user selects "Git
    Bash" or "Browse Files" from the menu.
  * CVE-2025-46835, Git GUI: When a user clones an untrusted repository
    and is tricked into editing a file located in a maliciously named
    directory in the repository, then Git GUI can create and overwrite
    any writable file.
  * CVE-2025-48384, Git: When reading a config value, Git strips any
    trailing carriage return and line feed (CRLF). When writing a
    config entry, values with a trailing CR are not quoted, causing the
    CR to be lost when the config is later read. When initializing a
    submodule, if the submodule path contains a trailing CR, the
    altered path is read resulting in the submodule being checked out
    to an incorrect location. If a symlink exists that points the
    altered path to the submodule hooks directory, and the submodule
    contains an executable post-checkout hook, the script may be
    unintentionally executed after checkout.
  * CVE-2025-48385, Git: When cloning a repository Git knows to
    optionally fetch a bundle advertised by the remote server, which
    allows the server-side to offload parts of the clone to a CDN. The
    Git client does not perform sufficient validation of the advertised
    bundles, which allows the remote side to perform protocol
    injection. This protocol injection can cause the client to write
    the fetched bundle to a location controlled by the adversary. The
    fetched content is fully controlled by the server, which can in the
    worst case lead to arbitrary code execution.
  * CVE-2025-48386, Git: The wincred credential helper uses a static
    buffer (target) as a unique key for storing and comparing against
    internal storage. This credential helper does not properly bounds
    check the available space remaining in the buffer before appending
    to it with wcsncat(), leading to potential buffer overflows.

Note: As a courtesy, this release includes a last, unplanned, "after
warranty" 32-bit installer.

Git-2.50.1-64-bit.exe | 47fe1d46dbb7111f6693b04a8bd95fc869ce2062df7b4822b52849548fb457e4
Git-2.50.1-arm64.exe | 26e71db68bf5dd2ad47e13a07fb050fa0e8ab7e9802401b32bb55f2626f15f55
Git-2.50.1-32-bit.exe | 5191529725d9f0c1ffe6feb23f3d72b7abe585be84e09cb2e6b353adb280d35b
PortableGit-2.50.1-64-bit.7z.exe | c45a7dfa2bde34059f6dbd85f49a95d73d5aea29305f51b79595e56e4f323a3d
PortableGit-2.50.1-arm64.7z.exe | fa1c1df0d8bc9ccd36105964cfd2e088b50f3db974906c926dd1a4d271e1f90b
PortableGit-2.50.1-32-bit.7z.exe | 7692d9af16b08150e28dae6c63106a46995fb44e5f4c85182ac7eb1b840543c5
MinGit-2.50.1-64-bit.zip | 6f672aebe9e488a246efd6875f9197dbc0d9a40100e218acc3877cba2b206c45
MinGit-2.50.1-arm64.zip | 25d45da2f84c5faae01e55129498b8466ad26966f775964be761f14f24d11d75
MinGit-2.50.1-32-bit.zip | d312bd9d9ff19bc85dd6dc46d3d1c10f63ab65f29a3d595b6376074025dc0809
MinGit-2.50.1-busybox-64-bit.zip | 6d586bf5093baf312cd8141bb59d150416ee89a8e58240d8c1e9ae31a4be7758
MinGit-2.50.1-busybox-32-bit.zip | 7d138de6edf6f001f131de55b02d97ca9e240c51a2ec61f631b0fe5e9f2b266b
Git-2.50.1-64-bit.tar.bz2 | 9131f40e26985205432a1aa8583b3a90b5a64f3c6cc9324b2b63f05cb3448222
Git-2.50.1-arm64.tar.bz2 | 1edc852521562483eebcf9fcb016ffe5936a93099088de52fcd9b082d289396c
Git-2.50.1-32-bit.tar.bz2 | 796d8f4fdd19c668e348d04390a3528df61cfc9864d1f276d9dc585a8a0ac82c

Ciao,
Johannes
