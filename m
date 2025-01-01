Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9163207
	for <git@vger.kernel.org>; Wed,  1 Jan 2025 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735723415; cv=none; b=DNRx0ZRCpjhT++thlT9833D8yw4jvmeOGyl/L5ROxtsWWql5H3CzzIXnh6HVZhMZPOzmVk3KBOyk/laBZ2mtpbIyYQ9+Gm8uxEjENFfhdIIlBOCe7sWCCeuUTttv2Fyn8qH+oUFIW/13TmCLx1xesY3QTwhMGTHv4MPi+WEYTIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735723415; c=relaxed/simple;
	bh=8q+NnZtXP1Cf0xo9udAw3YryrEC0FvYR/dkm08FMiI8=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=BamiOUUIcgKToGwmSJOP7gnmpuu36QLqgZNg9dvlhRJFr8xWy95u4epTZnpbrQxmWAkrdp52+nUndb36KVZqat3ouSNOCNxxQLEih/yrRHsbupY6ByrK7aaoOS+p3aoCHxX4oIlak18d/kGIWA2PCM/u7nun7oJChpLK7SjN1g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=FD8jML3u; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="FD8jML3u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1735723410; x=1736328210;
	i=johannes.schindelin@gmx.de;
	bh=7NApFs4nbqLxh8bbSNHzuyTKUSWfQQMoRxNN+tAQHFg=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=FD8jML3uH1njIvmRKaEtViPL+Aj71A4xNQFMfPHqrQXObTs1mfk8JYezu9bf8wPd
	 SnG64CFqwJUFrJbdfH6imzwPlOwnfJp4eLYl7R3k3T7Y6qixG+mwMo2lk/OnPDCOC
	 VWM6xk436jPvq+COSAdXdf8NxMETsu0J2s9olZ4GV7Lk1X6Bdn8ICwLpTlQUOnjkg
	 KQBylDC+U7Lgq1dyvIOwLCOSXsszrrPU6UOKXdODcXbU4C1kAGI4Af3sL/lhLjpxU
	 6IfiUHW3iv+HHvpJDs92allY/zxvc0UrQO8fN3loPoBH1RHpoLTKt53PX7r4n60iT
	 UfbNBFgB4IMCM7Jpag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.7]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfpOd-1tzmix0UCv-00l2yN; Wed, 01
 Jan 2025 10:23:30 +0100
Date: Wed, 1 Jan 2025 10:23:29 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git-for-windows@googlegroups.com, git@vger.kernel.org, 
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.48.0-rc1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1MacSe-1u4zn60o7G-00obkK@mail.gmx.net>
X-Provags-ID: V03:K1:G5sycC6x69KaEOMfkJ10ZtUQP8eq2LiHbT30O0UkkZk0aAf/fLx
 uEwrREWFTEMXJrGW66cBrBBNkbO0zJ5rZgidCAawXeZSEleIA4IG7Qsr6addePOXD7dkPlF
 Za79hTK3IUm9aXFh7fZGOueDSIn3q0CHdcd6gM1+i8FW7CuoXlXH+NeEtUnoJwFGYGue+FT
 7SnFtg5usXgwF99lPa3bQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mqANAg8/NkY=;yrUhlBW+csVE5ejKb9TA51qu6Zr
 sPcaIHZLqJhOniC1P4wDZOF+FNekS40Pbuqc2VLtJpRboUileE11PT0qg93X5kqe5VjjRf0Dc
 ULlZs9L9k80zGHGQyO0+54yVIKlU/PqHBW0GwauxIgrHF5llzuatTLq+PQr1D5+XykE79/9zk
 FllEsSztjxcGIxgB/7i4X9W5AoYfT8nMfJaNOG43KM9Uf0Yt4sZxhSyhphU2VuNZoMIiWv3Zd
 KhR65/S+DajjKkMxSKuTEVh9DSsdKafMdA25VKRGZ1Ci+pvxsMa9UQ5i4n8Mps/OgpNXVOY1I
 nmdqUs07js61FGlKgnhIDOF5oDAoVcJRmuCcmw9yUz5aUSeLre6Ue3rKRoJ+RFL6x/vkfUH3u
 fjoqTz3ni80gUpgymJfmppdiAgENED1m33CRfybKc8V7yY4phdCap0NlMXVvYdepamXU7nhu0
 h2rA1MM1zmUhGxGnOKBw0Z9x6IqIEP6ZUd+kkzwYCLI9J5oGY5fNuy5IlZamau5F4B/MuRUR6
 KzB0jgAWYUgQEeKXEs57NwRNDrGzXBaA1dbv7JLFyNXcOGxrJ+l7lgBiMVrb+UUcOFQXTsZ39
 CyaCTijQoilAmOMsVcqHwJ0HMMx2u+sUepq16uefc2uDewSlF0MLQGoMvN3h9mIELU7JNWXU6
 OsMLa5tnLwVTUiD/T1ttdZQqEGx5xL//gEC6AbqlFdlWfPm9i2I8yhkr3qcgkSsxDKd0KUj4M
 KtoJ2VtxEUIzbhhBfcHnLnzHXSWZC+TDzobWvf8JzXlAjh/9BEsLnH0YkxPfAKjpZbApHR3or
 s4Mix0DssK4JKsKUJvZwKY8UpRdrxISaciWmFEAmlnoyXPYeTSXBrk4zdEychLPK2Ub/gxy5q
 hIXSPFQtpv3n18lrgCY6pCY3xKCFIFisc8XVxFKbQyF82/qGgI+otOhBbveJX6cEx+eOONyXH
 F0IpZQNOiPTbjWnJsI4VZtCZ8qGf/wPIyy9O1a4hB40PW/oeAHF1eIChD2b/6++7ussFtgqzX
 rMd5QHeKeMgWwVnZg3qmC8IbLUBGsgRSOkuiR0CCSmMxva8Hj2zl+ZDsy6ctzZW2yxptgXvJZ
 BquO6Yw1tf89tyZRThaHRTrqDvmpVAQoQ0RGdF5MpaN2UKijf7EP/D72+q6JMTTLHgY7YaL8s
 =

Dear Git users,

I hereby announce that Git for Windows 2.48.0-rc1 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.48.0-rc1.windows.1

Changes since Git for Windows v2.47.1 (November 25th 2024)

New Features

  * Comes with Git v2.48.0-rc1.
  * Comes with cURL v8.11.1.
  * Comes with MinTTY v3.7.7.
  * Comes with the MSYS2 runtime (Git for Windows flavor) based on
    Cygwin v3.5.5.

Bug Fixes

  * The installer now correctly blocks the installation on Windows 7
    and Windows 8 as these versions of Windows are no longer supported
    since Git for Windows v2.47.0

Git-2.48.0-rc1-64-bit.exe | 205d78a134419d8c4cae8a8287f3cd43df1577e3548f9aa298023c95bbafec2b
Git-2.48.0-rc1-32-bit.exe | a0333a4a5f4f91aa91587efc0b2171940059445c39dde54284f320eec0b3975b
PortableGit-2.48.0-rc1-64-bit.7z.exe | 4547c8db412d7a1b840074701e16354458181a54b7eff838eec3ba3023e079ea
PortableGit-2.48.0-rc1-32-bit.7z.exe | 6fd50d8726793006d1961fd9d03c1cfc94a4994f78bacfd835c1ab58f1d5b56c
MinGit-2.48.0-rc1-64-bit.zip | 139255b6f7cdd14c696da58e17bd3284cd7f0975fb7c45f20f8cfca8115acdd2
MinGit-2.48.0-rc1-32-bit.zip | ea5eb4332d51455dd5850c9a4a265d158b8a7bd8d9d280a0bc7c485d4e77dcc5
MinGit-2.48.0-rc1-busybox-64-bit.zip | 769206ce840d18ad1d6185ba2fb56c8593aebfbb9a26aae9850dbd35b35a2a6b
MinGit-2.48.0-rc1-busybox-32-bit.zip | 92a16a3b491ba4c6c6f68d30ba29360bb75db014a834c8947cd543d427be784e
Git-2.48.0-rc1-64-bit.tar.bz2 | 399e604024fc3c3c476aea8d817c39a31d509c82741379a5c7cd49b50ba75b42
Git-2.48.0-rc1-32-bit.tar.bz2 | e055a18ac811ac77a6372eefe1833dacc91a0add9c8cd2d971b22a226a30f0b4
Git-2.48.0-rc1-arm64.tar.bz2 | f37ce1adbd91c195cf333f8713ae7964dbf169b1de5882353e03b727f4ec8e79
Git-2.48.0-rc1-arm64.exe | dcbf2a6ff870d498ae8aeb53c0d173a393ce6d7218bd6daa7ce2c416b78b743b
MinGit-2.48.0-rc1-arm64.zip | 8f56c87ceb5c5b41a5690554fe091b8b9aa08748bb20c39e933b0a2c8546ef01
PortableGit-2.48.0-rc1-arm64.7z.exe | 594ab37e5e378efb30a97796fa38f3a5d833f82da223d4056e596f311270fe21

Ciao,
Johannes
