Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6127A1B85DD
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 13:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727182934; cv=none; b=kMYvgCm6KDnzEgXDIYB6r9KD9Akd8SfscfxxKDw89ERi+Qi3+jBb/bUcyp9gn5wvFtkdiLLSiG4AvdQpZU53FKywj6tdw8vb5yveXhcWbmRpySTsC76f5oB+jNZdg8x+GDsPL+2V8kwm9LuHG/wZ5dJNgxaN1uFBhs2mdpwwbtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727182934; c=relaxed/simple;
	bh=RjDYpzysGNpK9x5ySOK9L1HxcFC+VLSTTK/fQf5yJDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IxO6AyQeOwh0ky2VdgqZ5v87bIJNPeqRF0aCrMa/5EMnaBd9xcv4+S/Qu+EsAWivl1NiQJhv5W7IoUMdGHpHvkM74DLgxH71v+BzozoJnGrjz2XVKaoTVT0grTPAXCtKTB3Out63WTK5W1E495Bntb3pF1KLJvoBrnA2kBzUxl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=oCZIT99U; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="oCZIT99U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727182929; x=1727787729;
	i=johannes.schindelin@gmx.de;
	bh=2UMDA9H30Jzyw+zVtO/F8ZCwmqSnWghIwRAGUn7IGZc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oCZIT99UrLl0tnXcg8pgaMzD3lsQs3Mi36jND3eJ+Tvzr6sngeQ2SyN2GLaVDPVk
	 QHUkGCPtPnS2BsPH78+hP87lhLFXRXiZXrPOgKNJg5NWeKHBa5UvN/zz6Wj6gCTfg
	 NZyKlvmrG8K9U1q6FgIpqn0KvxiCmJlZWdzLthYBQqHqcsfY3gaHXAi4dDfdhuA5z
	 obT310KA6GVBuGcq9L11KPZQ566CLsm+ALgkIsFaXg46EzxYG/YbKzSQWt0L8xH1J
	 xurh7R9m+4BqW88iW+W6Pdvw4x8maDv1bJ8Pfyx8tox+xo3lySDnn4EJCMgZ96Bk2
	 ZRzw+TQot6HNys50/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az1437-693.avgarbrzbkkufof5kjitkfpntd.dx.internal.cloudapp.net
 ([52.234.40.29]) by mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MSbx3-1sVBaC03I1-00Iv7b; Tue, 24 Sep 2024 15:02:09 +0200
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git-for-windows@googlegroups.com,
	git@vger.kernel.org,
	git-packagers@googlegroups.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.46.2
Date: Tue, 24 Sep 2024 13:02:05 +0000
Message-ID: <20240924130205.3298-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.46.1
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Fcc: Sent
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IwZIxlJMBq5oKudowreSAEUdvnr0Kl+Buu+yo0wjatU1OexfMDk
 iA8SM2+Xb5mWQvyTt1DJe1LQmTnsLcSq/aOfAJqUuTSyNWTIQ591jMaRYvAJRRmNDJ941Vy
 p4TTIROuPH0rZInG9UrOsVioYudLFk/okL2ZhHe4NI6cEJBMvBGj4yY6z9DRgaHHfW5cFPY
 i+MPCSfs134uhdaUSV/ZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3bDiSoPEqk8=;3dzmbbnVDkWTt7Zhef5DRFhLVs5
 MKPvOswRzpzj84SpyZcYgRfQZYheOUHMnkGWR2rWFY6B5oqV0UGd+sFx4X4C0tY7YSI020gHW
 0MFKDUdU3/rT4qXEvKfDlqazmJTf6ScYLM5mzc8XAXfK+f/yV4QW+l84thNCMY/JnthooZMmx
 G2gWDimCaZvQ2ysvggjfpnFXcIQiNEpc2Dacs63inEassHJFf4y5u7A29yDOeNYxxmRnFiJKN
 kJdPO+WL2Ajr0Mn4tl8v3Lepl27Et6AwtNFerjyFWoHCTpwoHEufx1J5fmDCHRTD5nJR/mGZr
 Tj8CQLty/2rLZRvgnwi64YaSb0sB2edKfE6umkD3/lP5cqjGY73siFbN5UT+4MuUpBngBnJ2q
 PrprpBJrX8INtCXE8i3ZocFLJUuhyh8oBJsH+7hBV62oqnpchFCwMqVz0nIleQdfIgwe5x511
 TLVeaINNHUi821sm+KZIR2BKTHJbe2rldw6/CjK9XAttTtFs2VWb6NhLhS2qGs0beM5m/tIGH
 JjZQM8qI6y8O9hVG4eo9RjHAwmB9XDWM7L2ZPY8iL2Gr8lQW5aJPiCVxyMchbnOZYBxyq/S89
 ZKt36yyXJaxGgDMPOzmLGtdidePqUxbVxxWr/7Ld14uLpTP7acHlJfqLPVRP5N1ut4VaNDAKM
 uZ3UGtbTx9+hwdhEDDqBDrfhucCA1TuFNQuy/ILRFuzWSCwjITr36cbDqNOYzebAY/nBtFHCa
 jq8R6vbQHfJJWn+zDPc9Nek9JLQP+ccU+JRNhVLmFfTSDU+KSPfgCfB7B9RBuXi431W3teVK3
 diuuDHVZ0nw86rqJLWeyFSig==

Dear Git users,

I hereby announce that Git for Windows 2.46.2 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.46.1 (September 18th 2024)

New Features

  * Comes with Git v2.46.2.
  * Comes with OpenSSH v9.9.P1.
  * Comes with MinTTY v3.7.6.
  * Comes with Bash v5.2.37.
  * Comes with the new, experimental --full-name-hash option for git
    repack that helps packing monorepos more tightly.

Git-2.46.2-64-bit.exe | eac009616605ec7207fbe1990627f453b826a1f23a33d54d9b0be8f4b0cb2094
Git-2.46.2-32-bit.exe | 6ca9019abb3aa963d81414d46fc054707efdf36d68b946ffdde6af8a6a374e46
PortableGit-2.46.2-64-bit.7z.exe | 58ae5c1a27d3f9ce8518c1a187860973cfa4dd604f518350e84f7baf418fc9fa
PortableGit-2.46.2-32-bit.7z.exe | 7351e28f498010f0aa2fd63abbd704698db38cf6f881e2417fb3d73e5a7e6f87
MinGit-2.46.2-64-bit.zip | 0dca60869825ceb8b6108be69f0c536174fbca45e11300f2c14c34632d8238ed
MinGit-2.46.2-32-bit.zip | 21a85dde40b3cb162ca6d0f6eda4007c3fac7243e2c63c34de979fc8cc4b9134
MinGit-2.46.2-busybox-64-bit.zip | a5c3ef14d4011324fc8b66e6e8943d8470b6d0606778be4d1f73f03ff9973c71
MinGit-2.46.2-busybox-32-bit.zip | d12e006af9c4d4f520a86a6c3cf03a1426433a19281574fc8f7b6d9d49f636ab
Git-2.46.2-64-bit.tar.bz2 | f05cf325a8bfaad6da2411e03065b5a4f2a1a69b9d1f9a258db1404524613610
Git-2.46.2-32-bit.tar.bz2 | 6fe9c7faf1e088b4be37945fa81bbc5252a8a7cb38c617925d5cc6c269cbc3dd

Ciao,
Johannes
