Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D69B23DD
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="oh8skMRZ"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25D2D47
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 01:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1699001729; x=1699606529; i=johannes.schindelin@gmx.de;
	bh=geyn7ZpYy6VZjUGHBzRSpuhhtcy1qfCtpoQ8PHDivi0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=oh8skMRZ6x5WTQ04I/zPyCfQMQttuGjseBesNWr9d6aI6RlYB35nFAfP1rKJ5P5C
	 TvPC2huJ3A0WhINAtd8U1xg7mMcYWDRZ8dNgB41Hzx0BgMIpjRlLZiQKJxf/2ImA/
	 0mCb8W4GWGbbRO/B198gfin+KJ8CcX4hX3To/8N/QJk1P5akU8WX/2wQ4VABmnjyQ
	 e2HkW/5H5XHEcCHn90FDRJrFK003ojDyDUIwPhhZUF7iAcpJ525FF5DJpvTxeZvfO
	 VQ++qw7laRTfPd0R15KHjn0osoYZYX8C2Z/uzlnxyxlX5odENhL2Tddqf73S0QmW4
	 88WnaoJElxMvRWElww==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az404-794.fclqd05oofmu3jo3usbz0f0p3a.cx.internal.cloudapp.net
 ([172.176.163.152]) by mail.gmx.net (mrgmx104 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MJVDM-1qjW2K2m2S-00Jt54; Fri, 03 Nov 2023 09:55:28 +0100
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git-for-windows@googlegroups.com,
	git@vger.kernel.org,
	git-packagers@googlegroups.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.43.0-rc0
Date: Fri,  3 Nov 2023 08:55:26 +0000
Message-ID: <20231103085526.3655-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.42.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Fcc: Sent
X-Provags-ID: V03:K1:C5Dn/AFp4rQqXwxkq0S+zJtfy69vQwSP5UE2C0YvynqmNKq46Ld
 tJzDkc16xDLAmgs26amrUZ+3WjoopNDPV9TaeUq+PZEbaL9ZrZ5mUwHzXY1iLMDTd/gjVw5
 xkqitfSSSZ0AmWr0IYXkImDKbQDwggMzgcR8S6fz36UxFqKXwr3ARbnHxEUTb16tbOs2BL0
 yxTnHZ1+eCsfuSSP23qVg==
UI-OutboundReport: notjunk:1;M01:P0:umoc6uLentE=;g0I1UKFXTK/HBwpjTnSZxS+Vran
 fZE5UaF1v0pHHITaPg5aXjPp0R7Xb7a8Fba5dvEN//EAUxdK039KoofmLYC237ytdSnWFFCQv
 +wFb7FKWQQgKWnKw4JUbYd4TGlGiNYYYDeV+X1jDzLTZbH6NSS93psUuf5YrgnruYDQW9Tj8D
 /XsCjLzgdeviuSIph0eFO97S1fxqlUxUhWzKJRJWx7xFC2defuh0tJY2vMy9cMk/Hoin33XKw
 qfsQ8bB2vV0+UmWMTF5v8Vfqj870BN8IevoMXowIvSRzHb2kFiiGr2i+AE/3AvwkXC+wEOH8F
 gl2js5srA5Nmb9OBcGabk6BoZAmRXbcpplwJAEZxSP+3dYuDPWQJXZNFWO1Eu5sH/UveWXMVC
 /WyBc9zmf0/E3pEN8p5KeUIfU/TXWmJUEfiFy98YfRIXUoRnApak3P5FH9rA94hL8SKTeYwyy
 5cBeUSlvLr/r4IA2CBO9mfpjEHO8BWxR8wm0x00qHAtp83WsEexzU/v4JczMtQ19+SIi6+PP9
 WweXTjGfiyo85vVhsJqHuhdn9G/u1b6SeOCHd1DSCTuDA26fjnvI+MNXJwlYXUWBaZF6iVO0D
 LizQt/wULc5CaMLQiGC76XqMJaSQXny/+7BcqxLWmxhses6yxzGZT95omW218ijCLOkr7Qeom
 PW1JChuHXcnfLc1ctYK+o+SgJL8KHoeJvMtT5VSFFiFsXUQhsu7pDXltWqsCcPZKIMTCdY6cY
 Sw29L/qhW1NmmWVOv4pMoI61+DgR0nqy1CYl1Q3B4Vj/7yL/ifBOQvCKaDYIzUwAUu+V7ItV9
 NCsNgT+9NfUr2lcxGJkPk+ZlNFIHhvUEvRQwpUmAPnAA+Yb5npazInsxTjOhpWzyM9qWPwHNy
 sICClpwLnCEBIAdIq1gVWqKdC4sAr0/CuMLiGA5/nrADMZgauOH6JyTmxNEWjHfbEMv5+kB83
 zkc8uaJJidBOrvVnVTlQ6/2YRTM=

Dear Git users,

I hereby announce that Git for Windows 2.43.0-rc0 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.43.0-rc0.windows.1

Changes since Git for Windows v2.42.0(2) (August 30th 2023)

New Features

  * Comes with Git v2.43.0-rc0.
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

Git-2.43.0-rc0-64-bit.exe | 11a41993a28a7f6dcf0381dd6b92b0ee013c1acf227a332074bb323c0a479e2a
Git-2.43.0-rc0-32-bit.exe | 924e10b97571ce4810434fc1464a63f97946def7a0492283abc03bc84cba35e7
PortableGit-2.43.0-rc0-64-bit.7z.exe | 697bcdf0e182a551221048f4447baf2f4cbc9bc54718830dde33a497192f0bd3
PortableGit-2.43.0-rc0-32-bit.7z.exe | 35eaed402eb541c7892323eae5b85604a5fa1f86741850c43fcd7745ab14bf31
MinGit-2.43.0-rc0-64-bit.zip | 216006c249857c6c2aa9b2d44b06b0dbc89d4bd52202dae6a3201cfa432fc430
MinGit-2.43.0-rc0-32-bit.zip | 50fea5aeee4b2ba97e300ca973b1a85c3bd9618e030079a49aa849cbbef1db17
MinGit-2.43.0-rc0-busybox-64-bit.zip | c633050b43896e8bfd318f2251b3e66a4161287e00e0ad2b92de25c8c6ee511b
MinGit-2.43.0-rc0-busybox-32-bit.zip | cbfdbf1f148aefb04c51327ef6642e4c6366b86c105c3de0fd846f33dd79c120
Git-2.43.0-rc0-64-bit.tar.bz2 | bdd7e890f297c351f16e262ab94ad1e77d18c5b647e54d06a1b80a7dda6ac60f
Git-2.43.0-rc0-32-bit.tar.bz2 | 1765bc7a4f33984a209dca4570ff964af3f4ca68e00d4528c50ce32a9e955e0c

Ciao,
Johannes
