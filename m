Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A535E1F461
	for <e@80x24.org>; Sat, 17 Aug 2019 22:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfHQWcS (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 18:32:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:39767 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfHQWcS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 18:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566081136;
        bh=Lb0ZXVX5HYUP0piYfOyB43WSq1dlAARkhf3EVLoAiUQ=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=CLF2RFgxPhaTQqH7ysPkAI4LqQ5Wba3BmJUqm6arj/nwtuJH70Kd77GenyDdp9EjJ
         zkH/7qdgJ7yQIlSzrHnWUCgkmC+4cP5mDWxaiF6kylwINseJvnSe+y3yt+4Y8e8GLm
         Ig47Xuu/yttCixvZhkazoVJuPdZQ6F/B+PZEsw7M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.63] ([77.165.132.136]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LsTjw-1iNHxH3roG-0122tO; Sun, 18
 Aug 2019 00:32:16 +0200
Date:   Sun, 18 Aug 2019 00:32:01 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.23.0
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <0LsD9n-1iPDlI4B7n-013yZJ@mail.gmx.com>
X-Provags-ID: V03:K1:QCMMcV6V7ugCscwoFoOhV9+EC+CCK2SiB8cKyYhHOw3wMlWTFFc
 dfc2YxzN50lNRD89/HDr9SiLSJLMTUhsvwpAXLkUKjgpeYxpwUot+WSTxh/c6y8cjOuhbDo
 BQi2fkQEX9vgc2DwXtysi3gWk3XC7nmEefXBe8ZtZPxZtRLvxU4pHgPNA+ghUDtMdntzuVi
 IKYSXihMZy8xGGvKplQ6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3XaqSNCgGLU=:NozMOwPBop9DvHZeFlHNAJ
 9HVXH/7BpbTiaAw/0NTRJoNM6OnmnFRccEzoEdaBIlu8SlRpEKOHFmHcFOHW0wiCcqMK1HbIE
 1lVEBGSABZ4dpqPK8nlzYr4Y6zNffIdx5R4RHq0Ugeh5UB686zD/u0eAvK2CATTDi4Q3KpqTR
 T2o2ODmx2K0ezMC3m4HTAv/qxuXVbKqfc3FF7iLqE6jeR7R+dPJuutFScq/JbVm9VObCoyWZT
 078yffmCCv6uWi5qQkHhko2TxKAklV4yRNFafyg4sZ3hrKqkmqKZvztTa6awvOFDu9qkafGLm
 JAU8y1LZHYIf1QdlUZSNo09MpVfaBSWliE0+2D+39CPPJffOlm/epHaXJ8C2EyRafndcEaoyC
 4lSwUO/fWIJrfS46lpdviZ2nBPJUW1tbgmxg+Mi8QmtKnhBK3AclSELygvOqSC+73PIeBEf0t
 rTohJPcBCvtMDJKa+uSC2B8FnOlm3gm9hmAWaWOeu7yba2ernC8CFFA0Y4T3pKLT+lJFABMAS
 9BVq8zJskF3jW2xQh9hY68XGIOZPwpgDMtOnCcY2PuWMe+8B3v6OO9Nk5yTCFFWaFOS/kjLpd
 6yWVEiUwqqq1i6quHWz8LOZoqA0t0L/U0Uwt8bFl2dkhzWVH0KNTR1Pk04DkyiWqE98S2MVW6
 D6K2IjJO9+h9wYePeODjy+3mSZ15qaniOf99a5WX+RSTBGtKfoztQTONtHjXCgwn7pRHKiLHa
 10Z1u4w/etXsmRUj94Gazmw1NjbxOTj+dg3F/wLN+ria7LBOIPKdo6pKg97COcVavPhr9jRUC
 GaodTInkaVeOde3t/O1oNAMr/YtJ2pXk+vogt69VSvnWVcZV02T88GaZqK97EwbirOD6sN3Cf
 SVtX620i18pi/NhyhG0mFw1oR4KrAa6bY6q3WsG+y6AXLI74o9YbaVKfQep4DK8nA+qq7Z9gC
 9jkVzpd+U6+9W60YOFJ4DeJMZeerEq50Ylk9rz8GWlA3W9z6fKqyw4UhBrTlABtLOSM5mn+I8
 dZ1+g/K9KuKZRQyM9PeV7LLpDonm2lQZjHHOhA9HnsPqewvzCsic2nx+38Mon6QAfAmlPiXav
 IDNSvgr8mltZL6U5x+eQK/K6sDZmtvj0HRm9Asg/xk3xu2L8yzrd+A/2Ul3BY5gQVgi+pYa4p
 DCCuY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.23.0 is available from:

	https://gitforwindows.org/

Changes since Git for Windows v2.22.0 (June 8th 2019)

New Features

  * Comes with Git v2.23.0.
  * Comes with patch level 3 of the MSYS2 runtime (Git for Windows
    flavor) based on Cygwin 3.0.7.
  * Comes with PCRE2 v10.33.
  * Comes with GNU Privacy Guard v2.2.17.
  * Comes with cURL v7.65.3.
  * Comes with Git LFS v2.8.0.
  * When configuring Git for Windows to use plink, there is now a
    checkbox specifically for TortoisePlink.
  * The FSCache feature is now used with git checkout and git reset in
    sparse checkouts.

Bug Fixes

  * Git for Windows' MSYS2 runtime was patched to fix a bug where
    setting the environment variable SHELL to an empty string in a
    shell script would not only fail to pass that setting to non-MSYS2
    processes (such as git.exe) but also completely skip all
    environment variables that sort after said variable.
  * git clean -dfx no longer follows NTFS junction points (also known
    as mount points).
  * A workaround now allows cloning to certain network drives (e.g.
    Isilon).
  * Fixed CVE-2019-1211 in MinGit/Portable Git by being more careful
    about validating the Windows-wide config.

Filename | SHA-256
-------- | -------
Git-2.23.0-64-bit.exe | 555cc19797fe6869fe60c156a59e9a29028f78476353775c3f6bca8e841940cd
Git-2.23.0-32-bit.exe | 0cfcde18ebb3bf53304a78a92f3245b77377360dad85e9fbd33990843a88ee81
PortableGit-2.23.0-64-bit.7z.exe | 501d8be861ebb8694df3f47f1f673996b1d1672e12559d4a07fae7a2eca3afc7
PortableGit-2.23.0-32-bit.7z.exe | 33388028d45c685201490b0c621d2dbfde89d902a7257771f18de9bb37ae1b9a
MinGit-2.23.0-64-bit.zip | 8f65208f92c0b4c3ae4c0cf02d4b5f6791d539cd1a07b2df62b7116467724735
MinGit-2.23.0-32-bit.zip | 55d6c73c942767cacfe0191af10f5dcae6b597d2791271f647c66570d75d7047
MinGit-2.23.0-busybox-64-bit.zip | 8efcf9d493b3172dfbac885e532e1fc20569c5111a02aa8d7397f2b5e8a28ada
MinGit-2.23.0-busybox-32-bit.zip | 517a23df6ef828f3059e43bde95e772bca6bda44b51169e7c5e9fd1f0ed20427
Git-2.23.0-64-bit.tar.bz2 | 88076579c843edd1d048635b552ff4899818f9bdbeedf5e1e3cf8b5dc93129f5
Git-2.23.0-32-bit.tar.bz2 | c2e95e31b633c66845aae7ffd4cff8a8e3202137ae5954199551c09b164cd266
pdbs-for-git-64-bit-2.23.0.1.4db2e5cc9e-1.zip | 57917935a2b30263dfa3988cdfad6e1bb4aec05a3665b9aa35f6e9397d0b0abe
pdbs-for-git-32-bit-2.23.0.1.4db2e5cc9e-1.zip | 3926cc81bd9b068c00738a2199a60f1579447bd4429821831cf8531037b0051a

Ciao,
Johannes
