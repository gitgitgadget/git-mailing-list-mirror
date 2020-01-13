Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C38C33CA9
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 22:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616D02072B
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 22:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="g3KG9O4n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgAMWCH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 17:02:07 -0500
Received: from mout.gmx.net ([212.227.17.21]:51989 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728769AbgAMWCH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 17:02:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578952925;
        bh=1frCRe1U9mxZY8CRCSRRw4BOiSKzhH+Go2JayQk2cV8=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=g3KG9O4nvYl7o1DHiBTR7CKiTj7q4OWlhSb/o014cA5JZO038o6a3Ab44z1pwerjh
         OuhADtvM0n8+05gI+mxsZigrdxkZsit/D0a0klHCvKnAwo6/BbD/3Cp3mu7T1b9IHj
         Q9gCWJ+/ulmihcbaIfSZO1Vls1bNSFB0SpNKspi0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmKX-1j6ipA0nph-00K6PY; Mon, 13
 Jan 2020 23:02:05 +0100
Date:   Mon, 13 Jan 2020 23:02:05 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.25.0
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1N5VD8-1jkRMd1ES2-016vQB@mail.gmx.com>
X-Provags-ID: V03:K1:wE3cykHzj5TUxi9ytII2fLDmWZn3OE4rwBG+5Wlh8R9LemK9dG7
 rhFBxgo1nacOggn7otQvs1Gba8rVnUevoEA3/JGchY7Y0nADa4A06PFfS78xBCFgTMkBoPK
 K2Iy6Fhd41HHTlt1s2ngmi7Pry0L6wopjyiiCvtBJI1Dv9iKHMB5Wa8oR96jtN5BRVWpnpI
 okzdAp3G52QqYJuNEmuqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cH9mcc2HCuA=:oPhoYcKkW1StrVSPrbV83V
 /OGGV+jfh6ALEL39CXVN3qyBxkS8kGcIRNaQm8xvaLUIo+AUojZJeDhUW9sfUVRzZfvoIJUhS
 nOvvHhizwBuo6ZFchqW0wcYW8jQWX+69qQkLls4wZ1giYSIqFLS8g05cnU3SSMeKbfPtzdNxE
 3oIIFjiIpQXJbxNksjQYRJH5IbiQD3zZrAwE015chfv0b+cqDPkz8+GqDPix6vtyVDdRfwRdS
 QqaTx9S8aQ5EL/QUfgwXYXnwWXmSn6Vi992wigFC9eeVanFtKSHoEIgZCjm1YIMgT8WZnA/Lb
 SmtZqp0D9bod4vmwSAeJCYVZ/CxArqRA26gx08z7mXJvOMfaESaZRk1P9DLU0I0dVUmtMf7Kq
 uOZaBD+y7UDVzxna82KWqcWVAY2jgKqRvfdSJKV8bIUlIfcoIXtZFuEVdu+/QKf2K6dugx8e7
 yKrF9X4n+xDB/d1eS0g3l+kZQTcphRAw78v3HIJeX56GOVOQDlgY1aVsA11feBRacksxDz20J
 UE+OLUINFF38TrZuxdjbsg1ZIvGqCc7VyWDsF6M2S8kwhJ2Fyrzbbjzg0N1t6JJ2zUuTl1ril
 J8bAgJxNGe7TIifou3eQ/dxUgceEET42cx6f+l8f86PdUJvixoiHhqs2rSGrehQM769XhhjkH
 vWelLkfGrC0BUqhOIoWNossTiZpgAegIW4wzNfKwhuNujMho/N+rH9dgqFlZlADXXcuZK1N8q
 HTqUoIC8KA7ZlzNN0FVtIXLrnZR8J1XdfFvvmUhKJOao7RMZU5AqzOQ6x+fGj6jx/NyOjJmCH
 3iGNdR4BL8eoaJBkvCY+44sV1xIgAAcb0Wgj2qjMQYncIe1rAKH8SOEjf/YX2drdl6Lv5fj6a
 dyqz037Hp5G91/ImlX3jYaxkZjM+S88+3Fd0sZ5Q6D4qIU9CZpGG3Frtr8tQGXTIDqhdwRaiC
 Y1rL3ctMF+NZNThXhgtDFtQEQMQf+RIiIx0skx9yqww8Z9W+CvqJJUuIhbz5WxckucjN6dof1
 rBvmoDT3SMya+dFCWZzMPU8J0j30gneDxrpLohh3X1kJRDVRXSmfb0fTMSGt/XVSymWGscVIg
 +6VTllhA5dSAnCAsSPFthj4dwpB94NjAqYNk01b/2Wc/hC5E4k4Y5DE6QYfuZYDJ9foOiuHyR
 AAqIhvjiF+mdI1ZglmtF5AbOx7MVjMPGs6K3+efCuVEg44RwzbROJ5L51/REMIaPICQ1OibvW
 WtZy47rTtFJMczcdVgkzHfYA/veB627kbmGImNIblNuBUbUH9oZm/IEsS7W8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.25.0 is available from:

	https://gitforwindows.org/

Changes since Git for Windows v2.24.1(2) (December 10th 2019)

New Features

  * Comes with Git v2.25.0.
  * Comes with GNU Privacy Guard v2.2.19.
  * Comes with Git LFS v2.9.2.
  * When upgrading Git for Windows, by default the installer now only
    shows pages with previously-unseen options.
  * Comes with cURL v7.68.0.

Bug Fixes

  * The startup file for GNU nano, which had been included with DOS
    line endings (and therefore upset nano) is now included with Unix
    line endings again.
  * Git for Windows now fails as expected when trying to check out
    files with illegal characters in their file names.
  * Git now works properly when inside a symlinked work tree.
  * Repositories with old commits containing backslashes in file names
    can now be fetched/cloned again (but Git will still refuse to check
    out files with backslashes in their file names).
  * Git GUI can now deal with uninitialized submodules (this was a
    Windows-specific bug).
  * It is again possible to clone repositories where some past revision
    contained file names containing backslashes (Git will of course
    still refuse to check out such revisions).

Filename | SHA-256
-------- | -------
Git-2.25.0-64-bit.exe | 6ffb0674a5f5fec2a328dd40456ede87ed3c7de653ecd6950f9cf132bca2f94c
Git-2.25.0-32-bit.exe | 6c02f1a1f95e286df8b87c2812c9460f4c2d333bab7a654751e01e9801994045
PortableGit-2.25.0-64-bit.7z.exe | c191542f68e788f614f8a676460281399af0c9d32f19a5d208e9621dd46264fb
PortableGit-2.25.0-32-bit.7z.exe | 5ad97ff1e806815aa461ab39794e42455f19c9a6ead08ca0e5b8f2bb085214a6
MinGit-2.25.0-64-bit.zip | 30bbd4ba6ca21fe97d43397a3d4e0e24be6ae2660b517cc1b96350195e48adea
MinGit-2.25.0-32-bit.zip | 0075b80e868cff4a00f7d328c9406bd35dbebbd28ef2f5f594dde03e2256a88a
MinGit-2.25.0-busybox-64-bit.zip | cd1e0e2fe8b2dee9e1ffd826501c1453532e01be5739f364a588560b26f6dc91
MinGit-2.25.0-busybox-32-bit.zip | 8edbcef08bdf206c890b7e17bcfb1f355ee6304e9b80445b076200c14efa71c2
Git-2.25.0-64-bit.tar.bz2 | af4cf57901098f3f36a4a75e4c93ce1078553433e69fd7a54b2a872bc8c2c7a1
Git-2.25.0-32-bit.tar.bz2 | 977606f93b58146126dc2c7b7ad19985eaa812852b08dd3354b5e40887cccd34
pdbs-for-git-64-bit-2.25.0.1.7c71c859c9-1.zip | 700f817cc66ae46309d8ad0bf535122b11276e1be67ccd91acfd9b54bf3a6fe5
pdbs-for-git-32-bit-2.25.0.1.7c71c859c9-1.zip | 7ee0a2a2a6a755169821b6e58bf313edf0436bbf26c5cbfb8efc2d7042488ffa

Ciao,
Johannes
