Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483061F0E26
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 19:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749066180; cv=none; b=j3srProVYNC26J08qS3YUag6ijbSULTVDsP5ZuZsxPCd8Ty2zi3emdmIhGJBmJ8sg5LOgpOZyKLnrpP53A9s5okXc9sy2vN0ONo0bclcZVh74zGNVYUnfEffzYpBndDFJ3aJBLN05rpPeULJDPOMOD6ajwfg55Pt8VXu95wk24E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749066180; c=relaxed/simple;
	bh=jDaks2NmOJsJfv/uOf1cGK+yFlDHAvPXHT7Pw9qt2Ms=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=bgmmVEA6vCd4rx4bxLTv95xKValxDZcZtpcqQvRiPNEhHVoGa8ChLRjNm/rWpo/6MNLYfdVSYxNRbDnCfF3SpQrRIY+GuknwuP24m4jBQ23VMRsON5Ysw6VrRHvRJkQGIoAnqKMaf+6ZvrWSUjpDUA4/5eHUsGgDzjtKbgg9YNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=OZ0dHrp7; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="OZ0dHrp7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1749066175; x=1749670975;
	i=johannes.schindelin@gmx.de;
	bh=KuXrilGf5Y9+fsanfts2uD0GU1X1T2G9xHv6wMU9KuA=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=OZ0dHrp7PBM0l3IFL7ex96bqwUKB89xO1MNto6MVlA2DEta9uPME6QXCwNPCN34J
	 UaPAlEWI4FxARI4OHpTKzfZ7z97yBQ76f9avcyjcaT5vrnAC3hwZcZ/WLWsQyWjqK
	 gApp6NLdXjupvbPE0p95fSW3odlY7Os4SvME1tgTTkN9fdnZdU2Pj0OO9L7zDrxMT
	 qSFi7du1fpi1DZOE6ysfXPafDVqFowCAG3yidXyYxK746nqnFgsSjg+5gZstcUnoh
	 P5/lWxo8FE6GY1+b9Glzfweqzx1YAQLQcAqQ/Rpdg7bAcWiDb+4sV/ybNBofnrCjv
	 wG4Y6PKyOW53iJfyag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.53]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbAh0-1uyAdT185w-00aHgA; Wed, 04
 Jun 2025 21:42:55 +0200
Date: Wed, 4 Jun 2025 21:42:53 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.50.0-rc1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1MmUHj-1v507a1K1R-00kz3r@mail.gmx.net>
X-Provags-ID: V03:K1:CJfCfGOdAH9Hgf/kNsnCXvFNFjiMKc8/pzxTMhA5JaODjZYDA0i
 k/3+PIQo44IYGwJ0RhOMgzVMHa5/LgelXIrPW1LWkQm0LcIxVX9SldgX5BHo80Humu+HKfE
 sKJFTzTFZybXFiWz7ZVEiF4k0oeTCrbNB/12EW9Q91Ilcs55AWLQvBF5wWQ8ZGHr9uopFnV
 tLGT1zptOBAthWlmoa7NQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:47k+/MYK7fI=;3tPLqzUHTI8XS4786FWjOsXe+3H
 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
 RFOoyYByDpwM7Nzj

Dear Git users,

I hereby announce that Git for Windows 2.50.0-rc1 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.50.0-rc1.windows.1

Changes since Git for Windows v2.49.0 (March 17th 2025)

New Features

  * Comes with Git v2.50.0-rc1.
  * Comes with MinTTY v3.7.8.
  * Comes with OpenSSH v10.0.P1.
  * Comes with the MSYS2 runtime (Git for Windows flavor) based on
    Cygwin v3.6.2.
  * Comes with cURL v8.14.1.

Bug Fixes

  * On Windows Server 2022, Git v2.48.1 introduced a regression where
    it failed to write files on ReFS drives, which was fixed.
  * Git for Windows 2.48.1 introduced a regression when fetching long
    branches under core.longPaths = true, which was fixed.
  * Git for Windows' installer used a non-writable file for testing
    custom editors, which was fixed.

Git-2.50.0-rc1-64-bit.exe | 4946a0762c4773153e96797473184d94a1649651d7ce9d87ff47d2800f4747a9
Git-2.50.0-rc1-arm64.exe | c7d7da0f2a78c5f7ee760f1d1b132cf8ce1c64f568f6d062fdb1a1c2d9fe5628
PortableGit-2.50.0-rc1-64-bit.7z.exe | 1e5f17d255622424dbb7954545c3ab4de5df11243f2fbb4ac60bb4d6ade09d22
PortableGit-2.50.0-rc1-arm64.7z.exe | 2493fd9e1168d5126a73b35763cb84aadc3469b681ee56f885d8aa0971a4a4e8
MinGit-2.50.0-rc1-64-bit.zip | 75762d02fa0833e222a9bfdbcbe07e45e40b434234dcf72a8c91a7703f1e32d5
MinGit-2.50.0-rc1-arm64.zip | 8fa9ce7af2066d46da0dea6fbe735e062b8eacffce0104619ad89cfca8494ec9
MinGit-2.50.0-rc1-32-bit.zip | 422099ae16744fff2a76d12bbe238b05936fe722171c6792ff322ce044bac799
MinGit-2.50.0-rc1-busybox-64-bit.zip | 4f557c8ae906d4770a055c323d2d0c43360bb7310743ff4412bf7ef1ed34aa1e
MinGit-2.50.0-rc1-busybox-32-bit.zip | a176f99d074cabefface32a76493c24990f8fdbbcf887a46aad5ddbe02b009b5
Git-2.50.0-rc1-64-bit.tar.bz2 | d29e17b2e8d531f1b8deca33b3eeca925d3109e4d6c61b1359cb36fbf6222d3b
Git-2.50.0-rc1-arm64.tar.bz2 | a4e0daf8300f4ee56f6483d18abc018cb497c1f0da367a558375d0508dbfa780

Ciao,
Johannes
