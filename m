Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B8C34AB1D
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 07:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719489; cv=none; b=seC5yUWx+1kd4Vo2F6BH7wudZeGozgUyWxQczlNZpzjpTBu/jtIKHsJ5VJq4JM7uOdjbH9qNuuDzFcQOOm2CCJ4q0bu3SF7fW9ujSCdgorXim4jj4jMvKYbE+T1YzUsMUTrqvNyMeQV11chA1pB8IxQGxbhivHuKHJbRg7xAKMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719489; c=relaxed/simple;
	bh=yxnYDbTuQcnIZ/K3qNNNIuA4UFTFSn/1FsoF/oWwRag=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=GYuSV26aJ7/Ad9xn6c1ci3GR0+Yd6z7d6pqHFzIv//VBOAHWJcgXgt4wlf62W5HKRU0mrVSFFJoKbCR3ca9gP3f2Cg7YiT5kqOzDfLZxl7l3s+sCo5CGOJpWMs5YLx5c1SlzaAntVGq94xKaEMeWp38vMLPXLV9zCeV4dJcAvko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=TIfnWUrz; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="TIfnWUrz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1775719486; x=1776324286;
	i=johannes.schindelin@gmx.de;
	bh=IoKBqxMhSfGaAOGh5foVAk2V9tt+H5dg3IQxR7WLntk=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=TIfnWUrzuph1HULkQfH5Wv/w4PElPIwx3pauVpYLYt/tY4AKBdsT8w6W4O8E9A5K
	 f193lvD0jv5wASF9mP3QLm7pXH2jQh2TUPXgcdq8nb7hW1OWZSRWsqbsJAbeooke1
	 6ZxMBizBBmxoesslPTNAjyNDjw8qI60+RSE0kYFIgURrKuKusTuqjI8x/fiabu45f
	 spyJCefLPXp0dZgvtlFfc00ojGdew3n+4pqHV+d0yZxPNxYA8Oql862ZJyyCBrdyo
	 6gKvLtI28OcTMcu5mewn+T6/Zqdboug04IY0Jcad5zoWuJFFM87dfBjYlS16DZY8I
	 zaqpIvzLYb2sujb8og==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRTRH-1vnH563UrV-00Q4l6; Thu, 09
 Apr 2026 09:24:45 +0200
Date: Thu, 9 Apr 2026 09:24:44 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.54.0-rc1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1MdNY2-1vbg3J3vmK-00cDtd@mail.gmx.net>
X-Provags-ID: V03:K1:Uigk1GlPSU+bbcWQfJAzIevVAWi6HyDsV/4RCfWiK+mqnC2rPWf
 6jo5IZKlAAgGg83D0zWcHttfXS/968XSkf1E8mILEpmP36mWA+XHAr91v5GmGHkmA8swzFQ
 jhJnSnOIjK0rdyFXz8EGV8lS8bwc4fwzZwb+GvYywROjT6HfOvIUi3PdBeHwgMm2jjylPHy
 nlBMdqc0ZdSZsuvuA/sZw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aYAHliM34iQ=;cuPBBTPdm+C1LCOnUkjAMPfsmC2
 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
 qSY+p5jxVGs+qDE4oqC9927+UuqFoMaeQ==

Dear Git users,

I hereby announce that Git for Windows 2.54.0-rc1 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.54.0-rc1.windows.1

Changes since Git for Windows v2.53.0(2) (March 10th 2026)

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

  * Comes with Git v2.54.0-rc1.
  * Comes with Bash v5.3.9.
  * Comes with Git Credential Manager v2.7.2.
  * Comes with MinTTY v3.8.2.
  * The shell aliases in Git Bash that ensured that interpreters such
    as Python and Node.JS are executed via winpty are no longer
    necessary, and have therefore been dropped.
  * Comes with the MSYS2 runtime (Git for Windows flavor) based on
    Cygwin v3.6.7.
  * Comes with cURL v8.19.0.
  * Comes with OpenSSH v10.3.P1.

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

Git-2.54.0-rc1-64-bit.exe | 43429081e61b76ce9e506f74f43dd2445448064bda924687237aa78b1094e94c
Git-2.54.0-rc1-arm64.exe | 68075cb3a6565cd1e75fe5e443245720585715efb74f226bff7960d819820eea
PortableGit-2.54.0-rc1-64-bit.7z.exe | b52ec158bd6918ab0cfa454daf43e1607364735a138e85a09beefba6710a219c
PortableGit-2.54.0-rc1-arm64.7z.exe | 3e5bdfc99b35b1313fb43a00519cc5051387a922854b2d7a57550744e0dd8eb9
MinGit-2.54.0-rc1-64-bit.zip | 573efea0679b9101c630d062d9f37632bd03cd924ccc34e69f6c3d379f8318ad
MinGit-2.54.0-rc1-arm64.zip | 52ace6d7762e9c3d802a232c95ef32808a0337c96d374378bdb3af8501a9cb92
MinGit-2.54.0-rc1-32-bit.zip | 86b7dc25cda70beca56830ee31b7a553c0a1667c9013f2c2f310822272e93794
MinGit-2.54.0-rc1-busybox-64-bit.zip | e73d1a08520d278809ebf51c9b3a1e577b9789a7f1b6b1ddaf1c9a7485643b70
MinGit-2.54.0-rc1-busybox-32-bit.zip | 442ae55b0ae267e062cc3a6f59f4541bc9459ff9c7a7c58166f86e5f86ae012c
Git-2.54.0-rc1-64-bit.tar.bz2 | cc3745830eba95bb4d370b69aadd239e407efa67e23dc779a403d6cb4a110784
Git-2.54.0-rc1-arm64.tar.bz2 | 3c006b86582ca1db240b729aa46a613beab1e3da0f1c646d975601f1df43588a

Ciao,
Johannes
