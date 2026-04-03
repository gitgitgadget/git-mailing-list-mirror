Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606CE2DCF45
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 07:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775201844; cv=none; b=BBeWP7aIigl99lEkw/aaqfrm0lf10i2r2EK3yhfO8CvdSX3pMonaPMbLuKT0z0jzwRehIjOEReewcQP2FuGNwTzBbzEiEB2e7zwkjuW8IGNwt3NieFcyc1EA5nv0vVhKtiaTUbB3Hh8PwQSgZewqPDb+wXv8pMw7sfzkz0852dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775201844; c=relaxed/simple;
	bh=zfEvkq0GqbMT7ZPmXUTpmU7CJsHaws9cXxTb3A584rU=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=jBf1Gr6nbIFbMVRDGoQ3Q3ecAQGkEBI2+J/zHj8IqcMBezJu30KfxttgiZD9P0o5CrST/cpxxbnmBdanOwO1doIZb9+CLnqNeKC21PTHouNA5uc3+lJ8VzQSVE15Rn937BKBX1VkIcNEutQ8mGTLbc6FdMHnI6KVz3Zvvw0AfP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=fjZRo3jY; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="fjZRo3jY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1775201840; x=1775806640;
	i=johannes.schindelin@gmx.de;
	bh=wLgzuhs98epVBPVSK62Usrw+hdJuMrKUQYHRbU/yPhw=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=fjZRo3jYbZLGY7puB7cHcGk+3iN2NpULTG7tltm/7ihumERggc1f5yZEwtJ8lkRZ
	 GPjiqDWJWO32SzthSXiOLtaxF0BgDT7dJA+P2aaBwQzFWVzIW5r7cUgrXE9Ze418G
	 9SLaNQEdBrRmKH1bfKGwA7veI3YHmhqCjgrLe7KTPfEea2lW3QRL22euIwXyOtX7+
	 1lcQ+DR7QrK3cJ5g4yR3+yEQQCGuQyeyoIPQfy69SSMQyb4WxefkxnzKZUZv8vWgv
	 sxO615JJ9xDsPSi5VPP9QgUbnCdFQXn5raJPxGH16nqXi8cFt3NzcD4VOmiEuBSBI
	 nx4uLGT8/vq5tTiAww==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3UZ6-1w80rS0Phq-002LYV; Fri, 03
 Apr 2026 09:37:20 +0200
Date: Fri, 3 Apr 2026 09:37:18 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.54.0-rc0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1Mirna-1vcolw0b48-00hTnF@mail.gmx.net>
X-Provags-ID: V03:K1:RRf6I5UMaMkmZ5XS2zBwGiJEALcpLvYQTI8dlhFtiXP6ESKrsnp
 1yfzD+lsdufTUozB484QgtfGn9F2YLqZfgMfmTKijTq4GdqdgXS7I+WxkO7J2GJeBM6RysS
 SUpV5IBsYeOpdgE96ayADePS+5DNUOWvaFAfK2u8UJdJBE6GjvPOVpnfSpvEd6ek1B7kHXn
 5epNYE8BOxJRi09ypPXTA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Se5EKvprsuI=;Sav98/jVeTY4MRUtdjzgE79//bs
 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

Dear Git users,

I hereby announce that Git for Windows 2.54.0-rc0 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.54.0-rc0.windows.1

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

  * Comes with Git v2.54.0-rc0.
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

Git-2.54.0-rc0-64-bit.exe | db8edf68657e844cb15650b041f0d28468e8038e462ddaa96165b1d3b345e3bb
Git-2.54.0-rc0-arm64.exe | bf7852a67c8a989bec41211a31896a77a3baa3c91a09ee7a4b5e790250108d8d
PortableGit-2.54.0-rc0-64-bit.7z.exe | 0c7a7d1103df903321d4676024253bf7ee9dfd180c8843d95fc8870c24b12366
PortableGit-2.54.0-rc0-arm64.7z.exe | 9c6ac02567c47bcd6ad619f3b6b5e9d46563f9a9cd83e7813a508c3b98e3752f
MinGit-2.54.0-rc0-64-bit.zip | 4cbc310160af57ee498a9ac667d0a21f27d2676c6bd82231c2ca3e77dcdf173c
MinGit-2.54.0-rc0-arm64.zip | d3adccb272076e76117749b6015f4ab0165b618b223ca013e1900ab342eda462
MinGit-2.54.0-rc0-32-bit.zip | c9d1126454801e7db7aad9a97b8f598252aa5d35cc57689780b9089d99bb33b7
MinGit-2.54.0-rc0-busybox-64-bit.zip | 2deed9be4e5478dbb463461ad8f48260bb70b9ba96422178bf08a40e455e3460
MinGit-2.54.0-rc0-busybox-32-bit.zip | b523bd7cde5e348e2a91bfe4a48737338d4fe5e2f92110d3d5f4b3bdc950e7fb
Git-2.54.0-rc0-64-bit.tar.bz2 | 3aaca6ff93ce34ffc9a59cb967e35196cf1b47127757578213e82b483382230b
Git-2.54.0-rc0-arm64.tar.bz2 | ec7da2001eff841be84811b787c97e5b95ed5646fa0c0ce97e9af8e1f9cdadfa

Ciao,
Johannes
