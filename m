Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E293B2F531F
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770060180; cv=none; b=swmDczXsxmPaGpi+Ph26kxCwFzrzyb0ZrWUX0XgE4T2zIRfz1hhWva4QeoMCcVdkpLrWQBOlXskRbX3ojCnnFA/r08qDV+yjhy/t5uwMTBWw8ix3+l5eoR2zl8ilZrvrSw/JKrKuRaP7vMqf2WwlYqTapt6786BSzy3L2KGGHKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770060180; c=relaxed/simple;
	bh=kFd9OYh8Dir36DDl15tie1/cMk/6XVSytZIp1qpaYM8=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=q1LxSus5Q8RVt1xF8aEUxOBTnABn5fQoJOsd4IJXnlTZwZB/EEx4lcz+lMoX8lMxdyl6WAEsza5oE+sRYxgK+p4D5kLsUS9WTgDD1uxWM1YmTA7z13OY5TDUoJxZ3O3bxNys9P7WtYL9n6T3XBK6VseNclT9iVn6nRANanHAZxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=n3R87JEk; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="n3R87JEk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1770060177; x=1770664977;
	i=johannes.schindelin@gmx.de;
	bh=caqgh5p0Ba9waDUPvegk3e0S9Gj/zVGvuvWXT93wEY4=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=n3R87JEkRYat0hkOnEM+nGRgoaZC+1VFuqNTFyuywrQ77qaLIl5UDcjW/JbVCWKO
	 27gIP7hz6I2ifQIixR0ZBjkcN1FsLTckHLETqfeq6Nb+I7GVtoeW8l/Bc0n/roH7I
	 xBxuT/YK28mbnvPCpGAHp4HKe2qz/7L4N4glK+KYkLrxA1Vk5qNGYjvP9GdYCDokb
	 +/VE4TRkU2e0ODcQGFwcM9LbGh2TSrrZLZRHepovhyGFpCwDqcecWv0LDpt5npmRW
	 lxR7dxQtc37+W9T+r4AWos25Ip2tiWzKRAzjCemdLmNsAgKUkTCd9HGhGb0JDulZV
	 751grvC8ZVDLSqWlmQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.112]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MybKp-1vd8ay0DqH-00vjyS; Mon, 02
 Feb 2026 20:22:57 +0100
Date: Mon, 2 Feb 2026 20:22:55 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1Ml6mE-1vPiST0O5M-00i94b@mail.gmx.net>
X-Provags-ID: V03:K1:3IcYKx7YzKRARWOuL9EJUt0oNvBaT8BEubiAI2Q1i8Kt7yjZQ1x
 kINz6K4U3GUhY96iYnCcmKlO1F0wVme4i3gYMmdtLFS4QEl0FS4IMSDqZhwX39ietef22lp
 ehSj1d81/Pzxo5gMf3FU46eilNOPoz37R5xjhDCAKIXPPMXDcyckcilj/J8xxHTFjFGgMXH
 zekdNgLfG4f2i460df5sg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Qy5l48a8TEE=;v7DjKNdwF6k//G9f4KSbCqt7Nbo
 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
 /0dScElg=

Dear Git users,

I hereby announce that Git for Windows 2.53.0 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.52.0 (November 17th 2025)

New Features

  * Comes with Git v2.53.0.
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

Git-2.53.0-64-bit.exe | 3b4e1b127dbebea2931f2ae9dfafa0c2343a488a1222009debfe78d5d335e6a9
Git-2.53.0-arm64.exe | 8eb369bd00582699da1b9afff4e99dc92e8ce984200b424e8b058d79152eb61d
PortableGit-2.53.0-64-bit.7z.exe | 08713a710ec91ac90de1c09f861289a3b103175f098676e5e664c04dd6c6bf23
PortableGit-2.53.0-arm64.7z.exe | dc59b7383104d57110e370638854cc1b1fd50de0fa6d293dc941f35094594298
MinGit-2.53.0-64-bit.zip | 82b562c918ec87b2ef5316ed79bb199e3a25719bb871a0f10294acf21ebd08cd
MinGit-2.53.0-arm64.zip | dd03826524767f228c9131bc4b2f4d29bc6f550a39fef9bec240f3e312210a1d
MinGit-2.53.0-32-bit.zip | ecdac7d32670aad730222eccf389a7e07803b7716728d9473d3afc24dc098113
MinGit-2.53.0-busybox-64-bit.zip | 5b0acffe1d1aab3c5d99884aba5858a89300076f2d1cba906ea1350a3873aad8
MinGit-2.53.0-busybox-32-bit.zip | 9e4c6523c684558973169071e4a6a3ec5acf0f94a353a5e3f00914672ff72b2e
Git-2.53.0-64-bit.tar.bz2 | d0a44fba2cc47e053ed987584d8392675c12a1465690ad1a36f09743a2ffe15e
Git-2.53.0-arm64.tar.bz2 | 30e958eeb59c7f481a56551bcd3633a643b9ff1ef024aac3254c478b0e6d4182

Ciao,
Johannes
