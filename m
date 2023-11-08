Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DEB37165
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 19:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="arFgTFo8"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B90211E
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 11:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1699473199; x=1700077999; i=johannes.schindelin@gmx.de;
	bh=uOf046pfLSNCFeYSJs82EdC0MzG3P+HoTIUI/LhzJiw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=arFgTFo8Lj4Lfn9goJTWkuya8/Mp7NDGaVwvElCXFjd4BYHU1ixUF2Pr7DypMSNG
	 SfRoJ6UCCEGhnb2okKrXP9Ow1b0hZbdY0g4nRlq/+jj60NmEQ3cTtDS8RSvW3N9+A
	 vyUhb1f2xzN8GQ5meFi0CqhNvfqoZU2agUFsi6W/l30NCRXjK8h8vvkASjQ42nlVB
	 JL5N3PfptxwvDoZrBQJQzTq8X6BCrIDc6gwgGMZTOfr3fPsgeXi+kRsHEMdSWRWZt
	 4YqysUxqbN822qWKhrIqgsF56U9uIwDtPw2EFdb9UBqsaS91UhQ67di5KyzDegf4n
	 6wYZBZSlzVRYoGvHaQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az881-188.kxqfgnpkrxgetcyd3drl2yrtfd.ex.internal.cloudapp.net
 ([172.183.154.191]) by mail.gmx.net (mrgmx005 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1N9dsV-1rWD620y4D-015Xh8; Wed, 08 Nov 2023 20:53:19 +0100
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git-for-windows@googlegroups.com,
	git@vger.kernel.org,
	git-packagers@googlegroups.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.43.0-rc1
Date: Wed,  8 Nov 2023 19:53:16 +0000
Message-ID: <20231108195316.3690-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.42.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Fcc: Sent
X-Provags-ID: V03:K1:1a2CbQMDoscpwMzqZKQEmMh65iUyuJzXrO608ueZCWCvg+9euXo
 o1/YBuYwcgw27ZX4s7RurRR+g+3zu0a+Vgl6s9OMh3+/pYXKtVwvd+Ld8MWuBV4pdXbuBY+
 +U2mGUDcCkjXpQw3gmSyhO00btPIy5eBWd+Q+xRb/42rGG9zqv87oI46NJjzxH4dhidk450
 w+k05yn9S+QmBkzZq8wkw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iezD/TEL2VM=;1mjvdzwz6aSs9ohkxQ6rkmdTlkS
 32kFLvILxwkqCV88xHYUPDQ//ftrQwJTobBEOg8kovZmeEMiNsI94bEQ+sz+6sC2qnj/+f/Np
 W3xI1A9ont3quT3RX93twNYTPFk/fKKxn2Xxgrya7hSuFJO85U5OwKghv3snoX1Aa1+Dp0cNZ
 NucmRlA2MH0iTRnxRt7UtVTdPrrk1MIsRWs3qX8ya3NbvmrXrOpBZxVMRxzWqvPmDUUrF/gHK
 MUnfxxvDdVEwhFKdand/kkeNaI4+pTamWiLaGPfsZL8d53OBHjbR8mlAni9Bdj7grSbTXj2R2
 tfvmd6AiNko2UPjBWK9Zy31/3BEjuPNLyCuwKiievfTa2rBUSX8OS0ZPUVFKnYWdWMK1uA3Ks
 1RaYZgtV8JTcZTqTu8MdsQY5lK4yXj5HEdSCyXnSs6cn6/hHrikfSHxbCW3ppJYU3H2o0JClB
 WvGiLFTBF5c+zkHvSSk+dvkJoO5vi2E2dKHWHfyBfY15jsUTPzy7ltvYGt1QbWablwvmm1Fqf
 xGeUZOoSaFF59E9yrYbtFs5/Ee++VGT0FctkBuwDiQThRY+751X18XqkawTjXXGqcXfre3agV
 BhGvAVBFw57EDl4k4aIqGjLqSNOUaG/4h10iQYmTNPeweWjZMrtME4/dW+IjtgNVSBTAb13+2
 X4XqhHLG42giVt8BTABDkzyryzdfX/KNGMGCgJMF+dgoEQp7Hx6hsgMmCrAvCwcnuZkgv2Rdg
 /l/0QCjrk1DUS8ZNtT7R7x66G0aXWQmvDxhJFJK2D4n2KiHJY8bYEYxwgXgGv3rGhXh+vdlla
 wzc04OJ3Dyn3f5KNNY5qa+IEnsX13NayaqccAqu9hIqPOwL4HuvbiGfHnyrIrNLb53zrPh0ya
 jz4uF4lvlLVSp+e4JImTCtYTaitfaEAS9acxr8gG0ysWFKaKlCdaXDEoxaaEQy3gHO2zbnw91
 bsB02JPOYUqnpTzNp2zj3iG15OA=

Dear Git users,

I hereby announce that Git for Windows 2.43.0-rc1 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.43.0-rc1.windows.1

Changes since Git for Windows v2.42.0(2) (August 30th 2023)

New Features

  * Comes with Git v2.43.0-rc1.
  * Comes with MinTTY v3.6.5.
  * Comes with MSYS2 runtime v3.4.9.
  * Comes with GNU TLS v3.8.1.
  * When installing into a Windows setup with Mandatory Address Space
    Layout Randomization (ASLR) enabled, which is incompatible with the
    MSYS2 runtime powering Git Bash, SSH and some other programs
    distributed with Git for Windows, the Git for Windows installer now
    offers to add exceptions that will allow those programs to work as
    expected.
  * Comes with OpenSSH v9.5.P1.
  * Comes with cURL v8.4.0.
  * Comes with OpenSSL v3.1.4.
  * Comes with Git Credential Manager v2.4.1.

Bug Fixes

  * Symbolic links whose target is an absolute path without the drive
    prefix accidentally had a drive prefix added when checked out,
    rendering them "eternally modified". This bug has been fixed.
  * Git for Windows's installer is no longer confused by global GIT_*
    environment variables.
  * The installer no longer claims that "fast-forward or merge" is the
    default git pull behavior: The default behavior has changed in Git
    a while ago, to "fast-forward only".

Git-2.43.0-rc1-64-bit.exe | 88ede07be3d3cee256f180130ed69e978e93271e835d31078e75ec8c0b13b77e
Git-2.43.0-rc1-32-bit.exe | cf66dda600bf0d1dbb7e4ae85c33cc81fd3a5aefc09ea43bad8737f2c7043644
PortableGit-2.43.0-rc1-64-bit.7z.exe | 5027018b1274ff5164f9ca1277838aea867c78c521a0a7d418b005dee651e00b
PortableGit-2.43.0-rc1-32-bit.7z.exe | 42a771402c47e0f0bc10100107fc5427951e95b309e5c3f53e48aed033165e98
MinGit-2.43.0-rc1-64-bit.zip | e3ca213c6f6f4acc08b249032770b5a061310473444c59628f0732bee02e15f1
MinGit-2.43.0-rc1-32-bit.zip | 375e8ec3c1d91536c3a2800db52c851d06e9273c0f0e13bc7cd54f32159e06d3
MinGit-2.43.0-rc1-busybox-64-bit.zip | bb4f22761110411d519f7c05bdd0655938db9d056dd929074d68603ff2f3713c
MinGit-2.43.0-rc1-busybox-32-bit.zip | 8eabb4f8b16018fe4124841957aebc1e2a9de9ed12c40b20b2bae59a69bfb088
Git-2.43.0-rc1-64-bit.tar.bz2 | fab6adea4a09a079a783aae395cf8c5963bca97095f16790f4c30f54ced8303c
Git-2.43.0-rc1-32-bit.tar.bz2 | e29cf087c9c5456092a53736b563d4c84c9ed4100552b532a7cf6abef232bef7

Ciao,
Johannes
