Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EA638422F
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776711770; cv=none; b=OQQK6pQkgL2ZetB/liLDz2dwzsXztLBzfpzx9G5SjdmKnQNTdbNevLZwjk9MqFr0/zAdKtmitvJGz9A5X83TXGU71MAGl4/rFZyV5Bk9HuWlwT1c7IEmV+WaQ+NqPZksMn/ix9I14GUopyt8TA5xmlagvCP/C21kkzAcYhA13MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776711770; c=relaxed/simple;
	bh=KNJyttt/itDSePBZMQy3MzAoTbSUnlFlSEKj249gfCs=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=U+Wwj0c5cBpbdzTIQ6NMY733KVnKPm4zXRNHywp5RVtPaxrx/mYOjFu7evTmRcamE4nsOlZ17xfnL74Ho2Zc2XrW6PS0dppTmW8Q4M8BmsXUKBXDcsRy8q0c1tQTpJq5kYpbM4jq6RVCOvILLB7RgzQGE+gb8D4u8mB++E8eAaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=fyGLdfv7; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="fyGLdfv7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1776711766; x=1777316566;
	i=johannes.schindelin@gmx.de;
	bh=CcF5UT9pdX65k4RXyWsOKb9NOoC7sTMqC2LgiFCFUBg=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=fyGLdfv7egppJr5vJBKxeuRI4dOdPZrA69tTTyqy7c3QIBYrkxpWdRALrOC6ybqx
	 55LEKLbC13trfKMaGrislkoTRwqmpII7wYaCmVSy47yIy8nSjppk7qQLHzvu1m/xo
	 hRzVCIBfVC+VudO4fXqfQlz5IHDt7DtjaU/bDSwH+XCME//8Ql6WS1BJDXqDJRpkv
	 lGEWQfLJl7Zv6tUgg9f/afEs/24vujGM+SQFioofj0gU4VLxzHf2UkXcx5lBFuJ1x
	 D66E58SRHjjgBUzYPuhIdj8xbZZ77Hd1sq0DfBOpP+Vj6Bm1APndN0Uoo1oH46TKb
	 xHtdEzjXTF1plKMFBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXp9Y-1vtsRG14MW-00JirL; Mon, 20
 Apr 2026 21:02:46 +0200
Date: Mon, 20 Apr 2026 21:02:44 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.54.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1MpUYu-1vcU941GAO-00bFmF@mail.gmx.net>
X-Provags-ID: V03:K1:aL4MUrM9gD4tfS7UxmCfG1tOreLvL79XECVnLJJEzHWiNZQo2JQ
 muSCddxN7pZj1hsHAk7ll736Qoy8V94nUoM9/qwRuskTwRvFZCWwYIwPhRCEE0V+nIihiS+
 3YJw5sP5TbR2QhvQMKbhOS1vBxHGkKvmWBbwe3B7qRar1Mgd+cCYBQZ6uC4ugNCJins1iIw
 Iw6G7o4HacKt2Puf1UzYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1rfLElUCE1g=;jmFZXe8mKnfQQNvVh8IteWD4JUo
 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
 rqEQ9iQaNtxBjUvcOFoeWQjQ==

Dear Git users,

I hereby announce that Git for Windows 2.54.0 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.53.0(3) (April 14th 2026)

Due to persistent maintenance challenges, git svn is no longer included
in Git for Windows. Users who still need this command are highly
encouraged to use a Linux version of git svn via the Windows Subsystem
for Linux instead, or switch to a regular MSYS2 setup: install MSYS2,
then run the following command in the MSYS2 UCRT64 Bash: pacman -Sy
mingw-w64-ucrt-x86_64-git-svn. After that, the git svn command will be
available in that Bash. On Windows/ARM64, you will want to use the
CLANGARM64 variant instead (and install
mingw-w64-clang-aarch64-git-svn).

New Features

  * Comes with Git v2.54.0.
  * Comes with Bash v5.3.9.
  * Comes with Git Credential Manager v2.7.3.
  * Comes with MinTTY v3.8.2.
  * The shell aliases in Git Bash that ensured that interpreters such
    as Python and Node.JS are executed via winpty are no longer
    necessary, and have therefore been dropped.
  * Comes with the MSYS2 runtime (Git for Windows flavor) based on
    Cygwin v3.6.7.
  * Comes with cURL v8.19.0.
  * Comes with OpenSSH v10.3.P1.
  * Comes with OpenSSL v3.5.6.

Bug Fixes

  * The iconv executable, which was inadvertently dropped from Git for
    Windows v2.53.0's installer, is now included again.
  * In some circumstances, when typing while a still-running program is
    about to terminate, the typed characters could arrive out of order
    in Git Bash. This bug was fixed.
  * Similar to how git clean already avoids traversing NTFS junctions,
    git worktree remove now does the same.
  * The number of CPU cores is now detected correctly on multi-socket
    systems.
  * When fetching/pushing via Secure Channel (the default TLS/SSL
    method), the timeout to renegotiate (e.g. using client
    certificates) was recently reduced to 7 seconds, which was too
    short. It has been extended to 60 seconds.
  * The recent security bug fix that disables NTLM by default missed
    the NTLM fallback in the Kerberos protocol. This fallback is now
    disabled, following the cURL project's guidance.
  * A really old bug which prevented Kerberos authentication from
    working with the default http.emptyAuth ("auto"), was fixed.
  * The git instaweb command is no longer distributed with Git for
    Windows because it would require GitWeb (which has not been
    distributed with Git for Windows for quite a few years).

Git-2.54.0-64-bit.exe | 2b96e7854f0520f0f6b709c21041d9801b1be44d5e1a0d9fa621b2fbc40f1983
Git-2.54.0-arm64.exe | 97bf63e5c65152c14b488e191c107aa1ccbeae2435690693241be4b2b5edd0d2
PortableGit-2.54.0-64-bit.7z.exe | bea006a6cc69673f27b1647e84ab3a68e912fbc175ab6320c5987e012897f311
PortableGit-2.54.0-arm64.7z.exe | f8e92cd3359fcbb96998cfd606a536ccc6dbfb23c04e12b29042f9ba45b6b0c7
MinGit-2.54.0-64-bit.zip | 04f937e1f0918b17b9be6f2294cb2bb66e96e1d9832d1c298e2de088a1d0e668
MinGit-2.54.0-arm64.zip | 68f6bdda5b58f4e40f431c0da48b05ba5596445314d5e491e7b4aebb1ec2e985
MinGit-2.54.0-32-bit.zip | 52fc36c9b22611f0a6a7fabdc68c763b914400e3af0e35ad822468dc64cb7981
MinGit-2.54.0-busybox-64-bit.zip | 1a90b2cc07f0d2c155d68dc9fe4193088f98a022ce37f93dec1212846b402692
MinGit-2.54.0-busybox-32-bit.zip | af3263141bff2f3a44d858a6a1008915b48586fa91f2f83daa702fd6df3c478d
Git-2.54.0-64-bit.tar.bz2 | e1819cee60d09793dde322cdb1170e03663c41cd9265cf45246219fc5e6aeecd
Git-2.54.0-arm64.tar.bz2 | ce10b24c74ac9c724ab81e2ee30d06e7ee693977a552b8da4e434e909a641847

Ciao,
Johannes
