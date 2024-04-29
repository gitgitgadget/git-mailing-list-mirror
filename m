Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702F81B94D
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 20:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423001; cv=none; b=jDgTS8PRODnq8B4NRc7f0s18kBmPCFUVMVmpc3EAip9NHES+VpC1sjkG1dHqc7XeZsMAF+1fU4QW2Ntdmd05TxNla3Zhr6jLcGQywbEE1HTXBm3BMDkYy5gG4hmLaSWkSSIkL+d2urVkXxXSzplodcxkCJmIO/y0Dy5B1A41up8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423001; c=relaxed/simple;
	bh=yjHuMI2mj+7eWvhuTJfXk5oudoCS5/Wgq9mf6xnj1iA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tL/YxHmiTNrAqGeNfmqXnbf73TwN8k8QJjhbicOvSg5lGNvQCr0BTdgjTI08waEfcn8XBTC/r9Xu1yeHWg+f7ChnNEF7TaBOfpTPt1ZERiM9PC4qLIs/2Fy46HmE7S2YahHWmgnR9QTlk2+T2H5uAZAvP5xUn6MpuVuoFNs99RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=QVsOGLfe; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="QVsOGLfe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1714422996; x=1715027796;
	i=johannes.schindelin@gmx.de;
	bh=ahhAxH2Qsxt9Ek7u+vPaL2plf3Uk5ambclFYm8DEeZI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 Content-Type:MIME-Version:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QVsOGLfe7BfHBwMt4HaKjeatng2gIqwXPRR4G/nwVLdRrHx4uztD8CCzKNogXfC9
	 0P/qqLseDwaaixyuUFthPT9CNWIRf1ohNPYGdNUo48x3IPOpys6DCRu89I+da+7lk
	 lfHsUJCTZd3cUVg3U16LBkQzDM1/CrRQSDeQySZTVsKb8PkIy1w30NORkUWEbBq3t
	 nLwgEhyTry0t9l9qb1sN2f1gyoGG/uXhZdlvPjhSfWYlXbAOMy3v/o3LyFV/0n2nM
	 zcL/2wUiDNiq51vinEO5JH4h9kpX2J5VKDiAA0l9ounQtcWMb8P9e46oOQaq2ewEE
	 4vTIpYKgOViOoxUBrw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az984-392.r1dl3knd25iuznqlwxibdlge2f.cx.internal.cloudapp.net
 ([104.46.193.233]) by mail.gmx.net (mrgmx104 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MvK4f-1ssoyr1aoT-00sv1q; Mon, 29 Apr 2024 22:36:36 +0200
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git-for-windows@googlegroups.com,
	git@vger.kernel.org,
	git-packagers@googlegroups.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.45.0
Date: Mon, 29 Apr 2024 20:36:34 +0000
Message-ID: <20240429203634.3627-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.43.2
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Fcc: Sent
X-Provags-ID: V03:K1:H0iVHkNl007MfLwlhfI7T3piey/qYxFylwqmAIAKnr4mhS8gHL0
 9aG9rd5+Ww+8ObgJ4ZCrAVXqSZO2u82bWAqouTq61EfO5UO0WmhbTSS0VFgFIGjDm/AFvw+
 2tgeEqNCK00Mj/tJsgdw81YQbG6rLSCWH/QXR+nc6LJ2b6xbTRYsEzUWe1TAn5rvU3rWJ0/
 IG9ha2ksIwHDvmy4Sx+HA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4jaCBvmfcqs=;/Nob62ZkKHMasomnsTHHCS07qJk
 4wReVS0NhxLLfM19L2uwuBjdyidYZzLpTuFVbcJDNwTNl8G5RQVScrk4hmjjIAhlqJQeePRls
 w+4ycZT3lGhLT5pe7JviQVNN+XmqHHM5Lvk75bKCCjvTB5sMdkjbsNY3IBR5Z4PPeXQ/x9Nzb
 3Z1v1xtavnJn3p8gPcfWt80ZtNiASGztLd0HlQhVOseipCbFQ6EOB+zLKkefjHF6mOqORliRz
 +a1AplXBYU6mfu81llL0Z8U8x8fR3ktuzbnFLVZs5Lcw2j/ONOAZGMZ3sSNeWBjuSePQK+od6
 hB9X1yib75JJEUjxmklRpsUo1z+HsCUo7RGRtG5pIb2QgQVvHz5ZM/fyv6WjIKpkI0y4qCmyJ
 BMa3nSphhFvq7d8VmNF9747viLC4PpONhDGAjVgMNtQJJ3Qd/86HMylORjXSmyTx16dZy0VOm
 oSL6JeBKcJf5VDZtKzDxMjzvIyNcytNLbyfhDXPwJCbN4+WA7qjeqrEKe4YK5bu/GpkhDf48H
 SKCFB8vYsJtvaBSlRrGYf9hTfoXTiJQQbMHaa1++LKEgNSwPwGx8/1Y+YaXcozbZz1lHYdw5O
 2iNhrb9xB4fDBktrAIS1cyHwK765/Krtl3hnTUher2lEr/nBFDglrmpXKF26cma7p5D92ZDcy
 +N/6vmICUcQBC5BebPMO+85vEjrWfnUUpqaC/JDvQ4YSvT15cxNiY5VeAwJDUGMLRaJWbozZM
 a+mLGPNBYrEToGghj13pPIAc7t0Tlcogudk3oYOatOfLBJhXn8uReKuSVXQ8ALPTvwT5NsgKy
 2E6SzfbkqyHMLwTGvCB3GPIfycQNPGBCilp0TFyucn+g8=

Dear Git users,

I hereby announce that Git for Windows 2.45.0 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.44.0 (February 23rd 2024)

Git for Windows for Windows v2.45 is the last version to support for
Windows 7 and for Windows 8, see MSYS2's corresponding deprecation
announcement (Git for Windows relies on MSYS2 for components such as
Bash and Perl).

Please also note that the 32-bit variant of Git for Windows is
deprecated; Its last official release is planned for 2025.

New Features

  * Comes with Git v2.45.0.
  * Comes with PCRE2 v10.43.
  * Comes with GNU Privacy Guard v2.4.5.
  * Comes with Git LFS v3.5.1.
  * MinGit now supports running git difftool.
  * Comes with OpenSSH v9.7.P1.
  * Comes with GNU TLS v3.8.4.
  * Comes with Tig v2.5.9.
  * Comes with cURL v8.7.1.
  * Comes with Git Credential Manager v2.5.0.

Bug Fixes

  * Since v2.14.0(2), Git for Windows' installer registers the Open Git
    Bash here and Open Git GUI here context menu items also in the
    special Libraries folders, but the uninstaller never removed them
    from those folders, which was fixed.
  * A regression where git clone no longer worked in the presence of
    includeIf.*.onbranch config settings has been fixed.
  * Apparently some anti-malware programs fiddle with the mode of
    stdout which can lead to problems because expected output is
    missing, which was fixed.

Git-2.45.0-64-bit.exe | 7694a2118ac80146636be1ee751ee81d2aea7e9106d29dd8fed06c32cff0c59f
Git-2.45.0-32-bit.exe | cc880827837e773835a51a32099cc919d37d10ce090734c183dc6713681dc382
PortableGit-2.45.0-64-bit.7z.exe | e9caf1cab7d2c1dc531a07c48445d84a8b27fae129ca7244e0d4f7b1e4949f60
PortableGit-2.45.0-32-bit.7z.exe | 652b5d6cb381ee9df6d6d411d8e6c02284d3b84ac6c5b5ced50a1d167d9f825a
MinGit-2.45.0-64-bit.zip | f607bbd459bae73369e6509fe849c4c48152f4d33b0021d5881e1e9e7ae79e26
MinGit-2.45.0-32-bit.zip | a9a76b14f3d80be346e93e053d65a0ea6d45cfba310076ac033b7f24a09e700f
MinGit-2.45.0-busybox-64-bit.zip | fccc3749e5412330c191da686a9d4bd817ca0844725c9ab80a73c5918af9b232
MinGit-2.45.0-busybox-32-bit.zip | 1c89a0a7d7d9c8d17e6cd861893e8a6b864b436fe8241532c53748c1308890fd
Git-2.45.0-64-bit.tar.bz2 | 6d1bbeaa92eb351e483c8be98bb0232ba4eedca938172761bc4efd9902e0a40b
Git-2.45.0-32-bit.tar.bz2 | 1316509c7c6e6b09d1cebe7e1ed9fc463a79455e8f5379cb840ef3e8dcc5634e

Ciao,
Johannes
