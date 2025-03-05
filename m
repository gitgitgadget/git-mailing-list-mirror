Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B9E2475C8
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186358; cv=none; b=V8WBO6tWJ9iamGUYmJlD/KxNZ3JmwwH16WOobT0oL9mu1vwlTFPifutUqbedI71l9v1N42+T/YZimjtuCQx/g14fQXLhX0oUGZqW6ZSFM0lWnfPIhVP0Jb1jdsDVsLBPjrsLjfoXo9sJxlRDfEDkKzaB0nSaR1kwbpGVjXyJSqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186358; c=relaxed/simple;
	bh=lRBf7UK3SdX8KVqS5lr5B2hZlh4A5i+PyCKHExO+lPA=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=mBZRTQ04SnF3+vhJ7Q2NPidIG8DPJDybsKzQuXLQa08eXVdjYJqiRrPvbKfjsSpb34g/Ah+phF+00Gdd4xdrVmeeHExOrGavsw1zmMMhAwXSr7S40d2z72BAyS9G8WIrUDbiU6XWr3sBXz3I3sGvf78fi02WKwnZCjrbHquf8T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=cWUTa6SA; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="cWUTa6SA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741186353; x=1741791153;
	i=johannes.schindelin@gmx.de;
	bh=Oan+UvEVl+Kn5Fil6DgJ8j9TVW+YkW0PIdmKJClvG/M=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=cWUTa6SAMAv/J8IIv8rjbR5Bsn7qpTNIw3zioHWC//X9iFBaA7wiZSWvQdry+qtf
	 Bwc/sFJtqsbzftgqh2Yd9B3CwwV0us+cKtrPTVCSDUFnJ32OyZfZCcL/cmhGCwq9x
	 Jz1Tv4F/KC91eDQk9V9ZBMQH4PQ14GENkeg/CdkVi56XDcpm270gbGvcEQ1KnNJbd
	 Fw0lJfPD3JIxz18V1QKvEEPWRMKaA7Rq96swFhQLFw3rw+OjBqofSgEa7v0+m7Wuh
	 EjdXD8jtv4ZvAMyHAgDzUDDuLLNkhSBshh2j4htqHIpPpPUvZGol67m5wJDbKlGA6
	 l4Lhf8tqCS0IdO+DXA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.101]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfYPi-1tJ0OX2UTg-00Zu3a; Wed, 05
 Mar 2025 15:52:33 +0100
Date: Wed, 5 Mar 2025 15:52:33 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git-for-windows@googlegroups.com, git@vger.kernel.org, 
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.49.0-rc1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1MmDIo-1tPXph2dbU-00pKOM@mail.gmx.net>
X-Provags-ID: V03:K1:5+3cESmHgbj/XfrPDc1kOBHrJclp33fbwO5rgCtkLES5d0weMK0
 d62a+DEyBKxFyVibR7SEj0jcYhfyW+MLNoB4PIMLHyibCkagJeaWRZGCeq9YSahhywzes+0
 hfIey+2VbAzwwJ5yaIb+B+hmySxlDD0gmXOEXFmS63WvM26dw0McCEqkN09h8MXbGf93L3I
 hYTnDhc6qLBT/sfHoD5Ow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VYMlGc2uxNs=;TYUxkkZmfJM1w4QmQ/aA9KTyLRe
 NLw5Woni4dDIeGjUJyasgFQXLIzTK+CqyNhI53uhaQvMXEHPnX8xvpD3+pzDnKYMtBLeXevtO
 aQ5ZJZn6fyfYLBc65NDAaDc3yhTx24mGe2tgf7C0BtPUQa61a+q5PxNA4IKF1XRFezwUntJCl
 WBbfUuZkPjBb89zHb6HfJrGk1i7hPPJHXT2B3LaUNyYLjWlYD/clnDdq069fc4WVAnSdnNdwb
 uqwqXkj0ypCYIfzzi4Pu452Kq2xySkJabrEilZf+D2Zm1PVA4qo6KkxJl/AxCgR6DzPTOU396
 CDuMhUkKv6ssf34IyX4ZWyqclCvzlG8rZQpr049dLBpHdoO0aoFsj78GuTwRMcALwKHX2mOCQ
 6G+uCVwYgAVOye5KC0/8/yuTQl/2OwmCMxNwksXQ0KkTctDlNqoxslbzl+hYPem9NHkvtbWUe
 t3T75ql4uoho03fKFRnsIKUAsIJdvOyHXI/pXng49m2n7bvgJtPn51K85nB5bhBovhwaO14/t
 /CnwezWAZrR2BHVjiluiotI+PGwD08DgEdBDsL03ogRm15jaWH457N3lR91mpJz9ZJEwFmj/V
 jMoMvADcH1vOOHr9t0booA8nhlgS3NMZX8N4OxsIUDnkeZftd8A6Ega4nPEgJdOL4OtuwhfRh
 DWbnGGv/pFM9F+nJgjWfX4f7xRPVX/pHwpTtPnymiPvCve8gDcZST9V4sOgve0mUN0lx9xpM8
 15u2E1LXRcFQ8u2UqO/lO1LPxHaf/byDXRAIaeLZLYmcF5dyzh4OuMSZSNiUjqNtQMN3+ZvUf
 TbW6bG+G9nqqg+/rlBnN779oMYOW9hkcmlou/FytR4MtEfHyve7Yv4GKLkQS9uOX7GpQHvzEC
 unFehT3lv+iEMqazYOat7emYb4jieKnWOiCKNkdp7DoQFVHiZryebnbJZtJbuvdD7TNiFWycb
 +L59BiL09yKsm8M9hsJc0dZ7mSoEjpqMdDS+Dfc8BDcQtafSWj1InOysyWPEwyXYC6HIsQg0u
 hq4aedWQIrF49cR2K7MM0JDAP/yaC5Yh74rTVb+ynG3YUFfc7FDsJr0RTFjpmpoaTwQxbCLqN
 YiGnOeB2nIKHWUTIH8Lhh9QlPwWa8pAz/A9upp7m4SSlcEGzCKtybFzLhs8KUmLUNjkowbvfd
 cKBhglt5gFzT2EUUZeNZqoskqQ3mo/Unk8TjSHwIprunLx7snaBUfDRe/K6/M3rL9y2+J1GFm
 AzueJKq2f7F9BzIlpHmysq4Nycy/kJo8xStie6yjC+iBDAVYGE6Di0/QclbLHFvl0zvLAN11F
 /E9ewLgZYLCcYkCqncYrCLmAML3t/jxVy8rac5tBLimdfJnh+NPJhnzMEbXqphLZUIocg6bO0
 u+Iv0a9lkL8wQDLqmnWtuT+R84typZKK4NoBDm+sWUcxgDoNDDYsFiRM9Rmp573Ia4oauo72M
 hygXMV/7bn2+Y+zdIglMRZrYhwKKX9FvdInU8BF7tjT8f0Hoi

Dear Git users,

I hereby announce that Git for Windows 2.49.0-rc1 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.49.0-rc1.windows.1

Changes since Git for Windows v2.48.1 (February 13th 2025)

Due to persistent maintenance challenges and the community's limited
engagement and usage, git svn support in Git for Windows will be phased
out over the next few months.

Git for Windows v2.48.1 was the last version to ship with the i686
("32-bit") variant of the installer, portable Git and archive. Only
32-bit MinGit will be built for future versions, until April 2029.

New Features

  * Comes with Git v2.49.0-rc1.
  * Comes with OpenSSH v9.9.P2.
  * Comes with PCRE2 v10.45.
  * The previously-experimental --full-name-hash option has been
    accepted into upstream Git as --name-hash-version=2 and is no
    longer experimental.
  * The git backfill command has been accepted into upstream Git; Its
    --batch-size=<n> option has been renamed to --min-batch-size=<n>,
    though.

Bug Fixes

  * A change in upstream Git v2.48.0 broke renaming symlinks, which was
    fixed.
  * On a recent Insider Windows version, users experienced the message:
    "Cygwin WARNING: Couldn't compute FAST_CWD pointer", which has been
    fixed.
  * A bug has been fixed that, when calling git add -p from VS Code's
    internal terminal, after using the edit command, caused the
    internal terminal got stuck and no further command was accepted.

Git-2.49.0-rc1-64-bit.exe | 81bf3f20c85c0ca82de760da8ac28eec53523edfb24a7c71f925e1c1e11bbe40
Git-2.49.0-rc1-arm64.exe | 1b527f8e80c10a09d561908fd8cbe8acefb47bd1f61da5048188808deed64183
PortableGit-2.49.0-rc1-64-bit.7z.exe | b387c7ae0ce0eb751e5ca812fd47dddc8b53f0cc1148b4ba67b66071e5933f1d
PortableGit-2.49.0-rc1-arm64.7z.exe | 80a7a186150ff22b695e54b20e55684f6c1a6abeaf2f32c9c256263a8901465d
MinGit-2.49.0-rc1-64-bit.zip | bc0d31dcb8a04eb5b0645ef92f132c3e3b184817b3d840806c06accb51e47ef7
MinGit-2.49.0-rc1-arm64.zip | c0244edc063ccb23aa425c88a591d2e90e6967725e168070ca64aea55e78ebb1
MinGit-2.49.0-rc1-32-bit.zip | b7edc701e8b874bca635896e0e9653bf1be5f6098d7046120c9a1a9af2f7844f
MinGit-2.49.0-rc1-busybox-64-bit.zip | dbeef21bf998c8094a936180251b51731040fccd0fa414c68a37b475b2ecebea
MinGit-2.49.0-rc1-busybox-32-bit.zip | aa516fe9904c406c29d9f030e80bf17de08aae009124fffad0249afd669da756
Git-2.49.0-rc1-64-bit.tar.bz2 | 65c1104bda7fa199829967a3f941c482721b983ffdb1132e76d2282a0e3f8c01
Git-2.49.0-rc1-arm64.tar.bz2 | 528e9c6759f30367e2cac04231c141d7973240ed7212d521bd2495d25878736a

Ciao,
Johannes
