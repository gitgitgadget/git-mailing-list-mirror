Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5078C77B75
	for <git@archiver.kernel.org>; Fri, 19 May 2023 22:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjESWCJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 May 2023 18:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjESWCH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2023 18:02:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3B0B8
        for <git@vger.kernel.org>; Fri, 19 May 2023 15:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684533723; i=johannes.schindelin@gmx.de;
        bh=VTcT2k/OWrSzHDSqU2OtPnLLW870D1zLMWvciPz8RvQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=T/6EeEH7LaxWIguh85rRc/NjZNT8w8dvl6XdqtBUzwkPikXhyKUD7t+3PEPMEN2Dx
         UZNXJp24S++Q2EQb1PtwOnu7hY0j745Qe9/bXg1o2U3KXw0RtEvtFwDuiIQjR2Ytm5
         Nqz42C17FJvOtRXdMKtOh4g+Yx8ZPUjwwCGFaEH9LA46QIoxgbj5DVbGJMgTli78Kx
         68LZD/XwZORpLj6VTI4SQSteweBlwi2GQDa4hTwibzrlg6+e1/IIs5eyHfyhaZFcTF
         29ppYSh8oyF0GUT5UPudqgk/xoaVjPgC/zDAr3msVTEFouqTMPhc5W0NEJ32SgUzwH
         0VsuQeW6stpPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az363-260.0qefokmwsevehmldsb4n4mgtje.cx.internal.cloudapp.net
 ([172.177.96.32]) by mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1Mq2nK-1qUBw10jjO-00n7Fm; Sat, 20 May 2023 00:02:03 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.41.0-rc1
Date:   Fri, 19 May 2023 22:02:00 +0000
Message-Id: <20230519220200.3563-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:FGKGCnf7lyTh39WBVJSGWQy/f4xjZtfLZqjLQhFF9yjqgoLBZXv
 6nJcRWs838EhchjkUBLEwGNAXDDA6F3E6vFO/Da6Kj0weRhHyJ8Rm/YhgjFauOyI/xFApTb
 xvSI97wTgMhQoOl+IoiJXAlHLHQpONWenaXzAMVO7ISj4eiEM55NwExuIZak1qsQ3qj3KjL
 hlc4N1lBEoNYQcVl6yiKg==
UI-OutboundReport: notjunk:1;M01:P0:91tzYwhMiIc=;nttnjsm5KslMl4DBWehOxAUD/Zj
 xGOv6FzUC5CttSTdLTlzjYL6w/NpM7ZPwm8Z3Kkte29IFcAqBCn/oop678kRjDSTQdBieFmC/
 yZbk7m8Rs/HUjamhayqyvXVZUNKk213uAZTa4fTaEuY3Ie3+V2pgpo/pcbwr7k1KdkrCuT2h0
 Tnx36IAM7fa+LPz8T1Yom3kIzZKjpgux1BUGWpt/OYRRtQb4IRrjp7FZppaYF+6mPHXDLDB5r
 GqaGwSySPuY74ykTtGhKf88iSx5oFLGHnoBeynkDhm8c0wSBXgEZ5rCHypHsKDmzn0JwprURV
 8rRaxJEvTYeGnA92u4RX4rLynIfeVj8maNgSTRXALSvVrEY0DbL56tBsjHbBnwLT0CgRjoqUg
 HKzAPvW1QOTAXINPuTrwAV3AzIXvfbb55h1EiWvDe7xVPmjrfvApj9odMZmOuckWkuJPOqhpL
 xSybpn72W9yk6gJNVuo8iSm9QQODGoM7lwU1Gub+ib1JcEI2WTRjYKr1NxY8V6q/DbQpXNjgE
 LCOxyjSi5eLDMV65xPegPlxYeGAIH0wo3PXQr6D86tRr4IodDyCOY6NtpL8E7CyDTLYvu/QEe
 2CW3Jf1Ejm9T0czpjrR1fIdh5uZ5PRM4DHT+iryYM8BqQEq8Lldhaq4BQQIAvtEDvM8IwRKpK
 1H+8XxGes8d1mXhisqOMwSQkG58KvHvmGvdMdAxSzYr4x30YVaxs1LCCC9WFsj+e3NK6tNsZx
 73dZy3lpT8ST2jICidmUWAN2O1gJFz+Yal1oLuNybZ1cXLXGs1lPnl8rO7k/PoJbyi9riezRn
 zRGA2qgOr+7zSpbtMbTmoCGwLMcu1KeDDPJctfA4PRtZhRvcp6AeFFoCVfJV0mZ/8UnB9bcqq
 VhzNkjCJhieV1gjO8ATIvtWQI+GDr+2kgqwcQBVtSM+XwPRkop6MXIq6spPgEVPaKlrrfbB9e
 NgdhFHcyDCJc5m1gyXo66b7RxC8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.41.0-rc1 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.41.0-rc1.windows.1

Changes since Git for Windows v2.40.1 (April 25th 2023)

As announced previously, Git for Windows will drop support for Windows
7 and for Windows 8 in one of the next versions, following Cygwin's and
MSYS2's lead (Git for Windows relies on MSYS2 for components such as
Bash and Perl).

Following the footsteps of the MSYS2 and Cygwin projects on which Git
for Windows depends, the 32-bit variant of Git for Windows is being
phased out. As of Git for Windows v2.41.0, the 32-bit variant of the
POSIX emulation layer (known as "MSYS2 runtime", powering Git Bash
among other components shipped with Git for Windows) is in maintenance
mode and will only see security bug fixes (if any). Users relying on
32-bit Git for Windows are highly encouraged to switch to the 64-bit
version whenever possible.

Please also note that the code-signing certificate used to sign Git for
Windows' executables was renewed and may cause Smart Screen to show a
warning until the certificate has gained a certain minimum reputation.

New Features

  * Comes with Git v2.41.0-rc1.
  * Comes with OpenSSH v9.3p1
  * Comes with MinTTY v3.6.4.
  * The Git for Windows installer now also includes the Git LFS
    documentation (i.e. git help git-lfs now works).
  * Comes with Perl v5.36.1.
  * Comes with GNU Privacy Guard v2.2.41.
  * Comes with Git Credential Manager v2.1.2.
  * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
    3.4.6. (This does not extend to 32-bit Git for Windows, which is
    stuck with v3.3.* of the MSYS2 runtime forever.)
  * To help with Git for Windows' release mechanics, Git for Windows
    now ships with two variants of libcurl.
  * Comes with cURL v8.1.0.

Bug Fixes

  * Git GUI's Repository>Explore Working Copy was broken since v2.39.1,
    which has been fixed.
  * The MSYS2 runtime was adjusted to prepare for an upcoming Windows
    version.

Git-2.41.0-rc1-64-bit.exe | 37d36db30796e6401ab76f4a5f3fa0b80e914b9af4b0c5d97be9fcf1642fd36c
Git-2.41.0-rc1-32-bit.exe | 3deea54ce26fcba56434c3cb36b074e1c451927cb43e0f60cf58d8e581c2b03d
PortableGit-2.41.0-rc1-64-bit.7z.exe | 0a28381184492f971223cafeb71e1a1cdb9d8ece71c4f57f765d6fa5a60cd97a
PortableGit-2.41.0-rc1-32-bit.7z.exe | 1b94097071c50ad6b8850eb83292099d27ca0faa854c3586a910610f34987279
MinGit-2.41.0-rc1-64-bit.zip | 58829de797032949eb0b72439b20faf820f2ff392351decb075c7104eea586ab
MinGit-2.41.0-rc1-32-bit.zip | cdaeac00ae4c54e1b965cee38651bf4c4c2c252244d3ea43cb2dba4e21d8994a
MinGit-2.41.0-rc1-busybox-64-bit.zip | febe0ce127ecca8beb81b12896bf59fe13a729ee88930eb6881bfe66a3afbdac
MinGit-2.41.0-rc1-busybox-32-bit.zip | 6a796b8c131c65d9cb18be384297c8ac8c3a3fd28bf85443a19ec9faf65f77b7
Git-2.41.0-rc1-64-bit.tar.bz2 | 4a596eff01a7d431c6365628d523ab513faf186060dcdfd67c2021ae2e08ac10
Git-2.41.0-rc1-32-bit.tar.bz2 | c3f6829c1f975e738f96a2b1721e1cdd6d0aa3ab427f5e20f3526e0798403b50

Ciao,
Johannes
