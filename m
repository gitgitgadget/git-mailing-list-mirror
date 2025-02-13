Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991FB23F439
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739453582; cv=none; b=AjYjntuVLOV/SSsd1FAolahH9ydinjDp4RleplB2tU4JPNJq8NgVA+EXMaeayfhJFq4lnfrXO24W+sTDMdW/tmvVoMcNcTUDrORHCycfuYp3Vx5NUKIp8AM5gENXJyloUZK7JKvVR0r6sBPWscWDoDSacdZKhRgmWPObKsxuDkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739453582; c=relaxed/simple;
	bh=uqhWKgDYj38LJXFr62mB+YsoSNDHT93DHYoFRW8Yj7k=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=JgrcNyAaItOZwuZbpPvoZ9EwCDJFnLJmNc7n6CCd2nA8TxiInK1/HMCMvHW3q2zsq0JJT1wZZEXwDuvi5RUZ2ZfPzBxK2J73qb5BaZzawEu2Ckm1gwAmstDun0c2CCdeqBD1zw3nWqYARrpet8euJO9IZd/9eCf3/4HRPpul48U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=jHn/fmZ0; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="jHn/fmZ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739453576; x=1740058376;
	i=johannes.schindelin@gmx.de;
	bh=1A86Rk2+OvdUEgMsz1NX/imglGUsYHLMa732C9Zv6So=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=jHn/fmZ0K6KJkYaHtwO1PffrQXcDt1E58889UVtl54RDlmpwzvVnH0WJRyL7crBf
	 aNZenSH4unrU7rC8+VNjynZ+CUJpLuTggWhm+AGPrDRFFV83sm7tfKI23bzL/8bIT
	 G3lx6vTQs0s3j03h7yncvCH7L6T1qWOnaYIKGRl4oFNNFJd9J6//8MzzqfreLK0p3
	 WwUwcgZ/1PbzpK0xgkk1uAFwsfYXK+gBZ+RbkbSFxc/MPFjGdwZScFI2eq9+z8wqa
	 60Npx98SbM8W0+x6AQg2DypPdHJWoqr0vOal1ut7OYwTnuaHdwF2uGN0SedHNtbvt
	 m7+/PVURVRtR4vrNUQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.128]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MA7GM-1tY61C31wo-003MQK; Thu, 13
 Feb 2025 14:32:56 +0100
Date: Thu, 13 Feb 2025 14:32:56 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git-for-windows@googlegroups.com, git@vger.kernel.org, 
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1MVeI8-1tqA4S3Dsq-00IHDK@mail.gmx.net>
X-Provags-ID: V03:K1:DXGKF4pBWlNFvSs2VETJgFQxoIvL+IgEPri/P5p56n133oAW0R8
 oTDyHhojz0/aQkFbYtMslB31SDd0b0QBq7vPxxf3XfpHwKM2t/uIH8sO406hEbt3gbV9O9n
 PJCKQdTaLGXt9poCLnTn/sbB9nTSV9R9b0q7sSI/zyzjXYPtNw4SiEMtRodwyw2LN6ckYL7
 xCRh3rarn3tWoLgv7nQCw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uak+NqoI4PI=;R6QhG2gft2tjZLWuK8YOe7GAnYi
 y47g5g24yPajRkM64CtuzR2Y8N2QM1WQ2TUfwS7qeEwO00xpYzBDg9UaBKBCpOdVrQy9p/loV
 D9NUBFVFnRa/TUbu+U014w/tBBoDZ4bNwMFdHRxAL4GOQTOngWFiCQNYB8KybpgzSjciB1Dez
 8rwE7OQ0YOcXDnEjp6GpLKFLtuJYueje24yttXj2Ji+AvkDA+1oqG5+Ad3cTuKhdwfHswv/Ue
 2KXlkjY+MOztfXMb1SylsjF2hzTHzISSYRCDb6qqVyBgmvtuOg/7/ZKfRESOBYm00Pf1Uh3Et
 yKw/GyZ6F9VflK61yTcU7FsKRxttKVQrR7kCKsPissjnFoLOVXdZ0+KWArGtAHLHoPuN2sY1p
 yfBu4HcZxrJzhxgFXptcapdsMvU37jrg6uWnbvbZ8mHlJfTOqNnHsMQ1EBJM94fQcJfvnieR5
 Xx6yxODICiI9sDWAkSKanypLZFJUuVwUCfa/9v0N4C3eYdtjznCWrZnoOfoM4jiNIMnGLmTnN
 ZgBykCQJmnbPNYjXv/+aHzlhzHfokLf/LBykMsjYtu/8rA44HprBbd/MgTruRJJK58XA39Uyk
 rD+3dBv02PUsF3y/In7cqUQQHPf5x/EUUBdDyLEzDjDNQDAuAYHSCF9+hEakqilNpR/N3HSTU
 YAzd6oVEXrosDKZn8W0uq8uaniSoZRA467vdDVGiad4IgRuwdzM0wBECRJCjneky2TTYs81Lo
 GGpHAKLbVLyfRNiZb/Y2yLuOP+N9F9Cfkag1zGsEEFh9RHGzf593CAzF234LcVnWWkfF0qFVy
 Nr0y3A8wW7NOAV5e/lZlC6gCt1xsK8qqtEPLIlKsfuzoN56cbSAYFCLblBLFWMKTandlIL1LX
 DHio8/vkFdZRxbhnPUcBl/Zbi4Nbr/gxKRBEKJZaflNbMRfG2xro2rzKUfwZIHAB0xQPvGork
 7R5POn8lWNQ4YiN+2iOByQYXw4wJ/nCpSafJ6DQ3X8aDxQKiStSINDwiwH/WlkkB3byb/k8kY
 Hgi4XR056m/KmHcYwfaakDMY74rzE6WuvC7KweCFTPpGQOqBjNly0kg4VjoLHQtXtPffdaQ7B
 Xs+D1VqUwUnV13QQNaG7XbDG+UI0aNnEnYCrMzjvPuZgFD2COAVuoXCmHJDtKEkmwCjFziHMf
 O7NNNaipFgNakwUZHrEMlEFsdL/i+IQLwHxpyUqpP+bjr1HGagfjzeL0YSfLBVlQd8FxQvgI4
 shmCbL0JJvrAt6acUOz7sheZ3PCvsZeiXqfXw9SLPuzANbKAHIynYCSEu25yi+AyYryiqK4TO
 306pomSnNK5mzyV6EzL7EadtCiRysF3eV0LWpqwuEDv+qB++9cX4uEznYX5/7NyDSqGzNK2LP
 ypxrgyUb5M7ERjJXeFQpKtNK6kxTTkTyUO/8PHSiIUnMI64GHVEKdX/gALvoaYbRWpAQT9liK
 Pphhxqw==

Dear Git users,

I hereby announce that Git for Windows 2.48.1 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.47.1(2) (January 14th 2025)

Git for Windows v2.48.1 is the last version to ship with the i686
("32-bit") variant of the installer, portable Git and archive. Only
32-bit MinGit will be built for future versions, until April 2029.

Due to persistent maintenance challenges and the community's limited
engagement and usage, git svn support in Git for Windows will be phased
out over the next few months.

New Features

  * Comes with Git v2.48.1.
  * Comes with MinTTY v3.7.7.
  * New Git for Windows installation now default to the Windows-native
    HTTPS transport backend.
  * Comes with the MSYS2 runtime (Git for Windows flavor) based on
    Cygwin v3.5.7 (Git for Windows skipped v3.5.5 because it failed to
    pass Git's test suite, and Cygwin v3.5.6 was superseded too
    quickly).
  * Comes with Tig v2.5.12.
  * Comes with cURL v8.12.1.
  * Comes with OpenSSL v3.2.4.

Bug Fixes

  * The installer now correctly blocks the installation on Windows 7
    and Windows 8 as these versions of Windows are no longer supported
    since Git for Windows v2.47.0
  * When using the cache credential helper, it could error out with
    "fatal: unable to connect to cache daemon: Unknown error" under
    certain circumstances; This was fixed.
  * Git for Windows used to issue a misleading warning when .gitignore
    was a directory, which has been fixed.

Git-2.48.1-64-bit.exe | ce45e23275049f4b36edd90d5fd986a1e230efb6c511e9260a90176ce8e825df
Git-2.48.1-arm64.exe | 09e3b2e844c3186567fbdbc16f0e6b483571dc7f964dea1c66357f585df454d9
Git-2.48.1-32-bit.exe | fdf9be6795afd911b4ed87417f2d5ac547798b5b47441b9f71984cddef943c3a
PortableGit-2.48.1-64-bit.7z.exe | a4335111b3363871cac632be93d7466154d8eb08782ff55103866b67d6722257
PortableGit-2.48.1-arm64.7z.exe | 095c68dd2d64d05415534c1b98c9d8b1b661c1a5e553a7aa83381fa136fa9454
PortableGit-2.48.1-32-bit.7z.exe | 63ddbc7ea11ea8a1375f39f45d38f928dbec564360ad12dd11d0d649474063a0
MinGit-2.48.1-64-bit.zip | 11e8f462726827acccc7ecdad541f2544cbe5506d70fef4fa1ffac7c16288709
MinGit-2.48.1-arm64.zip | 601b8b780669636577ad1eb821019d101f640b65075f34e1701a55a94e86a3a5
MinGit-2.48.1-32-bit.zip | 6a8c7acd63e2f0e7c901082c287ac3f0f94ebd1598cc02440979f411cb7de81a
MinGit-2.48.1-busybox-64-bit.zip | 9b628f0eac45ede891f9aeb2ef9247f29331db3b8f1dad36a93119e61323ac4b
MinGit-2.48.1-busybox-32-bit.zip | 4c5ffdeba8228ec89ab1b2f18569faf67345bfe1b619b8c431f87680f3c787e9
Git-2.48.1-64-bit.tar.bz2 | ec46b07acc431dcbe64ef5665582b934530b09b8f7ef3b39ad912832a3fefa6b
Git-2.48.1-arm64.tar.bz2 | a20498913b1c68ca491a8565789e2862ca7894276f2200d577404d7b9c919afb
Git-2.48.1-32-bit.tar.bz2 | 41af3c80fd618855ad20b441f5f47763cece1ed07f6849ecbdb43066d0aa1dfd

Ciao,
Johannes
