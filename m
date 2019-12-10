Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA54C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 19:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D569320652
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 19:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="jwPuurmQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfLJTu7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:50:59 -0500
Received: from mout.gmx.net ([212.227.17.20]:34509 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbfLJTu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 14:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576007457;
        bh=MrVfNdXbZJ9/rh/VZEnIboQL6jxdPhD9tydg2P5Kq9A=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=jwPuurmQA3eZ6v2GQ5KxlL7bb3xxX6glGtRB+9AIS9M1XSU7Gx8LM7IXGH3t065WF
         336A3m3IKVNUMOxV9cGcNEAMZvNxPjsdATwxegGaK1ZFQarQOxUJIEwLOormiDm5w2
         16azDvwJzMtMMpcmqIXobqs6TnnIQ6sU8daPbGoY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLzFx-1iMp2f3BPV-00HxoN; Tue, 10
 Dec 2019 20:50:56 +0100
Date:   Tue, 10 Dec 2019 20:50:36 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.24.1(2)
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1N4hzj-1hcztX3aQZ-011mQT@mail.gmx.com>
X-Provags-ID: V03:K1:o4WNqKCx5D3socqcXFKnqgVf+8BUYpJFaoP6wXDWGPgdOv+cbg8
 1/ornLObdcDrs5CwBOiGBPqAH6vhE9erVCrbxWrVPMbokZN5aRsazEgtih3yVnCBOQY1iv7
 wdUMmQoG9me2KHGdRmiIaog9s9E8uVq35MsKDSKGPmEgt8QoQjuq1hOY4NOQPe8cyK40e7e
 slbNDh1SFmkJosk565SMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uTZcwPvapd0=:7ALA0mO/lhIucoAT4oKVp0
 YTFElWMpraqVJUbPbZnZ43R+HVk3gpVdGqEtZ9NWJMlKZ1YFU9MqRBl3cWYdKf8DQyauAazQj
 Lph7LEifBPY/dHx9sbMxOCkKVbVw28eTuO+Bux5YsYYf9BUAD7y+Y8iC9aUWqlSPdjQaJGjOu
 XlkiuquhnK3LiexjHtxc/BM+MD9Em352QG0fNt/Jvv9qRjpH4xkbiKVRkxiM3k1ff2ebG0+Ec
 Uu2WmI1INO7RofQpL6zP6MM6JniXpupfDL2T50Ki4dvd8Qjc8m20aY7Hlyr+l7SYLExkcCw4y
 4v6A1kp4+E8+6cyPu4eNaJOfe2LKjuERYiUQkngh42lCHcsq8AyU7Nq2fnV4Ifr7FsVewGRp9
 nXLsy/55WeLgNzWWDv/M7JG5HtLqvQe+hM/VSlMAKenlDePRiIyU/2xiSKZY+uCV0E2Jlpu2V
 RfZFp8SDMxbcbHwoLJYuXEhSNah9pYoq6Jwoj/gXC76ER+AIXjURcrjnRvwuz4uspq4vuympB
 B2blBvHgjNeoenlt5eqPAtFIrCA9P2XazKnsmEx57JyV+hf04BqtR2qS0bODzEa0OAtMCBp7t
 c7gQVdBg2bkLskuQOIFWat4HXmaV/xAQbeRc9ySWqoOfEcDwOLXsbZBkWZYqTmOaxQW5SFNxi
 AJQMTA6VGi6vlnoJAJUahKXZpkHCpo455UIUqJWgxWKNOdsz6iRzIu00oWp5PGqEVp2V6NDfj
 wF0nmx7UTOsOq68accsy4tuAJaUUaWEYmgHblJe+bBjZMP14bndJtHAOKTnRKFX0CejlI4LqW
 vN2ig8jdWZkpEibnLLnLjbuxlPGiju5P4PkmI5JDVM4GI9toNK8mzngQh8W8sDgrSS7sUjENI
 mBhI1nETOZYE91qQAbqOYocmEMSYqT1nog74PkCQ8XczEA2l2BmZmT07KfIBmCi4sj6CO3NXN
 s6pWPCqZuve81O9+tygOb2/3jG4d9RNSzY65YARiDItNOxZ4A+oeCwzQW0R3XD+0m5XTY/Q7M
 oK/Re2JITcafBiDvBGlgWVaghf9p4lSWbU2A7aSVLbtGQHWo1aEJluLr7vq0Cnml5u91OP5ds
 EfdKwYzyXCuGHHn3eUXhOhTu9s1gj6CX2MKzXLogG0SjXkraiW+SKVTjpzjVy5u4/shnbsHX1
 wx1HfBvuDrLGbiUk0kxgEdCwNdh70l67C3Z7Pw6daPBRx4LSY3pjLKbd8B+8kzyPJ8QM7qGt8
 fzitbykuRfpRzBVL+22iojqTBj1FHw1yXWfkIVSu7rV4lBYSddRgLdN8Ji3o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.24.1(2) is available from:

	https://gitforwindows.org/

Changes since Git for Windows v2.24.0(2) (November 6th 2019)

This is a security bug release that fixes CVE-2019-1348, CVE-2019-1349,
CVE-2019-1350, CVE-2019-1351, CVE-2019-1352, CVE-2019-1353,
CVE-2019-1354, CVE-2019-1387, and CVE-2019-19604.

New Features

  * Comes with Git v2.24.1.
  * Comes with tig v2.5.0.
  * Comes with patch level 4 of the MSYS2 runtime (Git for Windows
    flavor) based on Cygwin 3.0.7.
  * The command-line options of git-bash.exe are now documented (call
    git help git-bash).
  * Comes with Git LFS v2.9.1.
  * Comes with cURL v7.67.0.
  * Comes with GNU Privacy Guard v2.2.18.

Bug Fixes

  * MinGit no longer overrides an installed Git for Windows' system
    gitconfig.
  * The "Check daily for updates" feature uses the Action Center again.
  * When associating .sh files with Git Bash to allow running them by
    double-clicking them in the Windows Explorer, shell scripts with
    non-ASCII characters in their file name are now supported.

Filename | SHA-256
-------- | -------
Git-2.24.1.2-64-bit.exe | 34e484936105713e7d0c2f421bf62e4cfe652f6638a9ecb5df2186c1918753e2
Git-2.24.1.2-32-bit.exe | 611b29cc8f29241ee6a096f5b9951ef95650368c93dfe1e95f8408d97b86d50b
PortableGit-2.24.1.2-64-bit.7z.exe | cb75e4a557e01dd27b5af5eb59dfe28adcbad21638777dd686429dd905d13899
PortableGit-2.24.1.2-32-bit.7z.exe | 88f5525999228b0be8bb51788bfaa41b14430904bc65f1d4bbdcf441cac1f7fc
MinGit-2.24.1.2-64-bit.zip | 83f2983fa7689109fd7be0f2a54b178ca3d5b2f5519d99aada84f5e00c3ef4c9
MinGit-2.24.1.2-32-bit.zip | 2796a28bad7a02c72a3855eeabfc7ecf0ee346c9fbc60ece3447a4c5f549282d
MinGit-2.24.1.2-busybox-64-bit.zip | 87adb065a254e379610c07a5b8b025469597c7d0da84fd2cca0e4376ad1b7fa4
MinGit-2.24.1.2-busybox-32-bit.zip | abd0d3683d587e7535490b9833a253a477eca185e31c3531efbc63903977212d
Git-2.24.1.2-64-bit.tar.bz2 | 2a023cd1cd5fca6b241225da317795a2aece9c298f736425b4fdc768a7d33bf1
Git-2.24.1.2-32-bit.tar.bz2 | 523dd18aa5c3c55ff3c312a42b52899a410fe6b2e39a9ebfef3ec17a04681090
pdbs-for-git-64-bit-2.24.1.2.992f077302-1.zip | b0af4f0c7d89ffb12fbda444e6b9eaf6930683ffe469a5f8c6bde45b49d4e3b7
pdbs-for-git-32-bit-2.24.1.2.992f077302-1.zip | 2537df43b6569b232449126b6c304c299c6a95b88a54d54aa9d9d2b7ccc20a90

Ciao,
Johannes

P.S.: If you wonder why this is v2.24.1(2) and not v2.24.1: The initial
rebase broke the built-in `git add -p` and by the time this was noticed, I
had already asked helpers to test the version, and to avoid any confusion
"which v2.24.1 do I have?" I decided to simply not release that broken
v2.24.1 and jump immediately to v2.24.1(2).
