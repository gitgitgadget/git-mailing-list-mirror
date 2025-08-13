Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF6333DF
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755114361; cv=none; b=bh9NG7EgkaN2hsqQuKVEioE2CBnIY+0p9lfe65BQHdxO+1QCWG+FKojhVh/T+GS7AOywfD9K7QOZ37RS6ZGVd5yXASCyJE7TWpXo42+1lT/T1RE46lMkk962yNUqB1YQpkAT+zt+KD43KbjPanumMj5wzEq8CThjOTqClSpyfYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755114361; c=relaxed/simple;
	bh=mEq125R6vCh49T+UOMlFYMwNFqveJZSL1ViKzpqio38=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=m9vrGgA2dIqugxMF0UlyIUbqe1O4C+gFEGw0gKuDVcFOXwJiJCydAENbZyR1VmB9ts4eMLwZKZQHs6nU45eC2/eUZt94TBf+dhcBNrj+rvmyfxCauuOeqxzrHNQKoZ1pEndQQJ8oMeAwUbrsEqzyrg3SWEOQbip//LCp6IH7Lbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=IYb7Vf77; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="IYb7Vf77"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1755114356; x=1755719156;
	i=johannes.schindelin@gmx.de;
	bh=QJbcRfxoJksDhrZWBe7aW0WdEerC/duC0VYlHhk/jNQ=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=IYb7Vf77rA/q1qrFf6J8s35wbtzhdJYn8WOq33ToPWfOut6mhwm90Qdc8ZXql7GP
	 2vUQ5SetOvWkUM8yREt0Z5wWY7ueIsAwgbZctBlnVwPQhwUutvyrVcSnOwKV22heU
	 8EHm+7I/o2R8FwChSI1oNvvQACnYY3P3bELhOXSMvBRSK6+stmMa7oXMUE14syj2v
	 scV+cYQRiaWlveDNJau5aNfO2NwDHS/QpHSqhmmGtbeuJZHV2i6j7OAg0Z7cnOS9u
	 Fmy3XC6n9YF3S/zbMGGPX7bdbeNEx7nPqhprUpB8zJME0Lq4QYujwM9sZwvUWgO/P
	 Ye6U/9GY94gbcuBfMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.154]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfpSl-1u6d0X2CEL-00hWzH; Wed, 13
 Aug 2025 21:45:56 +0200
Date: Wed, 13 Aug 2025 21:45:55 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.51.0-rc2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1McYCl-1u9unZ2L9R-00c2nr@mail.gmx.net>
X-Provags-ID: V03:K1:ZPdEDVNlOESJPngl2l8LuShs2rCrcdFTKiljnmyWceqhVClKvsF
 Kzp3LKtCZmYGK9UflCZwOYb+r26H300VB9nwe9jzrLBH1to1EMM20fyyK+2RIpqld/JBzxL
 7sIl7+Vi8Zg29JxWuaiRKuJYauTNdf7iMv6o//dnJnndm8p0A8Jin79LKaJOyB4rDSPu3Sd
 3Uhs0vjTyHLPZKkBG3eww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:go99wWMoqvE=;etdMLIbGrGdJn1yiRJHZwtU6PVa
 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
 1d/9bJhqW9Br5D5jkFO9M73qrMymFRfg=

Dear Git users,

I hereby announce that Git for Windows 2.51.0-rc2 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.51.0-rc2.windows.1

Changes since Git for Windows v2.50.1 (July 8th 2025)

New Features

  * Comes with Git v2.51.0-rc2.
  * The Portable Git installers (which are self-extracting 7-Zip
    archives) are now based off of 7-Zip 25.01
  * Comes with cURL v8.15.0.
  * Comes with the MSYS2 runtime (Git for Windows flavor) based on
    Cygwin v3.6.4.
  * Comes with MinTTY v3.7.9.

Git-2.51.0-rc2-64-bit.exe | f62cd3143a03e496b64468f9833434be19df4b2428fc5d058774d3ee394579f1
Git-2.51.0-rc2-arm64.exe | 846e317ec5bea38e9164d627bd6f4e6881acb7bd136660e1c1ce9be7a54d8406
PortableGit-2.51.0-rc2-64-bit.7z.exe | 01a8ab8481362c230f18cef8966a612f760d4ea40d539e9d8cb419e517a8ac20
PortableGit-2.51.0-rc2-arm64.7z.exe | 4d44e057f7d6596d6671f413f694d5ab04cb02392b05d0a9cf929e4acf0155e3
MinGit-2.51.0-rc2-64-bit.zip | b73e8059a6c2380f84ff1483dbffcdbcf1d97bec28de24a1c3d0d503a872a619
MinGit-2.51.0-rc2-arm64.zip | ac5690ffeab59eb177d2091d68eef17e4f063f4b3f904749cdfa632a455f93f8
MinGit-2.51.0-rc2-32-bit.zip | ca5585924690f62cbfddf317111eb1d02a9fca03f9a13fc15573b20c2bb9b754
MinGit-2.51.0-rc2-busybox-64-bit.zip | 720914cae321f172d6546134624aa29b974bed00c8edfaa952b58f5c0193ffe4
MinGit-2.51.0-rc2-busybox-32-bit.zip | 0ca7c6985243899b441474cd5a7cfb7cf994a0e57160e776a9170db7b4444da2
Git-2.51.0-rc2-64-bit.tar.bz2 | 5804070e7e8fed5e624bbb74e5ea6f286367a698384681152dbb31eefabf9a3b
Git-2.51.0-rc2-arm64.tar.bz2 | 5218e4574410a80a6f0fcbfb905522909eaf91729ce26138b1985578e0823a33

Ciao,
Johannes
