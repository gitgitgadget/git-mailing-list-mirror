Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55B9C388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 22:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EDBC2137B
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 22:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FOczWPXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758358AbgJWWtc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 18:49:32 -0400
Received: from mout.gmx.net ([212.227.15.15]:58617 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758354AbgJWWtc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 18:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603493370;
        bh=Xrf6GA8Wltm6XQYrmtFDvDqmGtGw/hcARAduo11yjm4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=FOczWPXFigkvnm0XU9ZUhIQ3yREvg5H9u+xawiYNYxn+CIIQIayy+sYzyFf3BwRAP
         epBLK86oas2BiE9a0neqdPBZ3EZBQgHSeYdJEgQF1XHly2f5Jc4sANQWsyv/z9wJEE
         blovg9crW6vOxjtP8bGlaZVxUfnKCRjepOUUO06Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az767.5i32r34sfccedp3ryyffs2gw5c.bx.internal.cloudapp.net
 ([40.88.32.124]) by mail.gmx.com (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1N3se2-1kNOe13o92-00zm4q; Sat, 24 Oct 2020 00:49:30 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.29.1
Date:   Fri, 23 Oct 2020 22:49:27 +0000
Message-Id: <20201023224927.7224-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.29.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:wVshTucey0D1D7bfDG0KCB/Qf050EIdWOIarDhWv1jETOlyI81/
 /SowgXpQrQgI5BDUWMCQi8mDBSH/PSnvoKOJgOFjYqAkRe9MrkHp+nyDuBCZZTDB2zyKg7k
 0/XEIHywfzYlu7gKdWJoQMqLcZo+zL9MDjdIHQb0xQwtEByFjaREfnpqZfu5Mq1oNIKj1sj
 CdWfdDspyLwGcCn5dmU4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tIH+/PH0j5w=:AeKXkA46Hd8gZUAZvV43N/
 38Kiv10Co+Z4s+jAAQPJ8sDUTm1f7CaDpY9EcCfZnG7L1nJKcItTM0S8f1G+5ECAP/AlN57Op
 9dkuA4FnUu2Jn6gOs+NNRy5llWkjMk5ij613PHqQ8nk97OezeM2rf6/S5YJ3NXpxuSpSsszM2
 LxkXMgXpz2s0kQNpZEoCUj1cWjg6p2M3uahv5vkqn67dfwg/leY214QMU72talCfAaMULx0HV
 1oUTTby/E2nD41Gw2dAwHgSadrpzAlaBsfvQ+RgemUYOgqoIfMdREyzfnm/hlcexp2gqysLhF
 6kDApvr0i3Ef5DX95dDEBQaEIQ+kUoEDQSUxZ4uOqnUaHLOF223+wKJjYcMAWtr0OOHRw5Y3z
 5BIq6ZUvbnFTgrC/vyDnrM0sqTAg2ZwlLgXKl6tQWdvJOuGiB4qspLCFv6DjY1SPStOainB09
 oDi556D3jBf45/e7Qoboc00HJ6q3d7R9CvKMs5/G/c1twVAt5p/SJ2SYfHlQ9XikQuNStvwWR
 JOHQJkTfcFmYSMphyYP7vQmOlcKn4hs0uxzzYRV5e6lGn0HbGBqghaXjuzyHG7vT3u2lY801P
 fNPVKlTnU4v2h/k2WeM1r0NompuQye9/7BemuBRDXsVUl9TF2pyAKFMvJTjvAKRrJzOrslsAc
 2ADUwjspbnVzyz5hFL9SwUcqfexhHiP/pa3SYcde1E4/wLCyv4UoA8qTDjnjmUAUBgucaVYb4
 syWXz9RKAdoftWmWd9fX2JIAR148iH245n2H2Dot6VsGuILDPHanC7b/FVncbzxh5wQXn+42y
 V/YXaBbq2YsFt0bY0oLkJTmvz2qlt2QRSCXkwB8BduhQf9LDnS4TzWkdqxFE1QxwZHKt5CoOH
 zufgGRCtVtoGwC2n3U0yzIV4qKOP0xkJJNGDorkNk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.29.1 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.29.0 (October 19th 2020)

Important note: v2.29.0 and v2.29.1 upgrade existing users of Git
Credential Manager for Windows (which was just deprecated) to Git
Credential Manager Core ("GCM Core", which is the designated successor
of the former). This is necessary because GitHub deprecated
password-based authentication and intends to remove support for it
soon, and GCM Core is prepared for this change.

Also, as of v2.29.0, the option to override the branch name used by git
init for the initial branch is featured prominently in the installer.

New Features

  * Comes with Git v2.29.1.
  * The MSYS2 runtime now optionally supports creating Cygwin-style
    symbolic links (via setting the environment variable MSYS=
    winsymlinks:sysfile).

Git-2.29.1-64-bit.exe | a24d4069ae1267bc302556c49cad50a4f1672d70794e5d4d25b20d1cccf5c4c8
Git-2.29.1-32-bit.exe | 1b75f2c56041b048b197ee1d11af3d0875bb414d63e734453dd4b05b9fd24e28
PortableGit-2.29.1-64-bit.7z.exe | e4ddaf8d7ee1ef633c6631747a12624ffb1f076e91e22cad1add322fee6bfedc
PortableGit-2.29.1-32-bit.7z.exe | 9edab85c5383680a64c98ddab9354469e675e0b3fd4afe18c62f65e758540ae6
MinGit-2.29.1-64-bit.zip | 6aab2a1acce11a765d4dff2b9b5c8fe0feda5ff4067f16a696893786a3bf94c3
MinGit-2.29.1-32-bit.zip | d67d7853552c39267216869de4ca5a95557c4001f6bd6f221bb4eae9aa8a66c0
MinGit-2.29.1-busybox-64-bit.zip | 7890ab11efab10af4a1a075289c9b34e95666e6c208ab791d6d52697d4c03797
MinGit-2.29.1-busybox-32-bit.zip | 91e55d05213d0d0b86e9290c76e112c6de72cacd991b96b827224060f3912353
Git-2.29.1-64-bit.tar.bz2 | cfe155a6f63605fbf3c378cbe010d7a31913302842bef798dd6beaa7f9e958c5
Git-2.29.1-32-bit.tar.bz2 | 5add752eb3a3461e888d3289025079253a31ad96a8bc381b11006231795a9219

Ciao,
Johannes
