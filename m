Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2E6C05027
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 18:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjBNSPB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 13:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbjBNSOw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 13:14:52 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7B283DF
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 10:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1676398486; i=johannes.schindelin@gmx.de;
        bh=+DNgKkqvv85wmMvc935TpzC7RQiYPveRzGjW3VIigUA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=P7vU0xFiIhYwyy0jfDtxfDlnRS1GybdYuv7Hoizezrh/OLaSpl389eWVwj5xDpnhO
         d6sF7Wzql/pKjhljWtrnhZSG6cW3HJfUpNKjRfPRRYoH2yBOcUfKFKBlyEv9vspHDv
         tv6/uk1zKfw+YivignBsyWop8iGHQfU6MzT4/1vrbnAIa7yxKQLFvYOO+lkBzUkjnn
         d83gUyxaB8HL+tA6YQ2j7wAGUQaNleIuZY3Itx5ZLpbFzWD1E5wW+buuCqmCjbKW46
         X6GN5rASfI31SMCsfTOUSacAFv/PKxq0HKwVKBXnE+G0nNvn/mNpJ9AFcz2ADOhJLb
         j83RT/GS5VLcg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az703-730.qjxmrcqukxzejbqhl0udth3dcc.gx.internal.cloudapp.net
 ([40.86.12.16]) by mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1N9Mtg-1oXjyj2alI-015MYH; Tue, 14 Feb 2023 19:14:46 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.39.2
Date:   Tue, 14 Feb 2023 18:14:42 +0000
Message-Id: <20230214181443.3645-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.39.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:DPIgkePO97FTvpuTU+xg9gRUaJVPtqGl4XSvXghg4Q3i5UdRvk7
 +ANJ/gyed09HnBS2uGyaMG2Acf8U3xBMdC61fzHTmQVJWdE9bggJGO6BlczkxU448bMavc0
 4wRIZg1p5GDUcgtkkr6i7Pg1HPTMH2sIPPe1iXKTMqdJJzFYLbzd6ZkSsObWdK8OXkQLEvO
 WFOHQCwOCIAbnElXKIZBw==
UI-OutboundReport: notjunk:1;M01:P0:1Vmykn3dpJY=;IhwyR0oir/XTIolCPTEPO7iWviB
 uVJ7WJ5sdmW9hV4/XaPmMUSPX0oaKMKSq1i8bHKOH8UzcwrQ5fTPh7OTDl/wqoxXpq4ZUV7P3
 KKEJRMmup+lxoVWP9CysQgPD1ocNS2oacHH5nKQFA8uTw838YXeoD69h0E5otUgwzyVeyo0N1
 mZQWQTf6uoIad6DrwHEwP3vztuiffBd6VuYaFbwpx91x7aH8ctxxzQoA0+imr1nHrbx9VdG0d
 iDrq/gGE574OlHtCA18vab9fMsDufm5nhnv+pYqf+u6RCcVb38Nj2o8UrZi+HNmWXJU/f3vc1
 wOOxNwV+GyQYuEMreVcOwwgwilRlGB/u3xMMtM/xSjYCfw14yA5jo9qW9kvdSWkXFI8XRDBHu
 4bBiPjBI/p2MQjRELm+zhkY4Q164+ieKyKJxhA0RKqqqvUC5JSXTGL9chdu5Y1kWWdceO69Z5
 /qkVmEMiCk47iITOEZHtB2Bv6uPoDBeXFLZejOWZ8fOCSzrzTQUAKuwB+wJxEcUSbFK1tyU8t
 2abB0BNQ08x0Go6j56wFhXImIH0nPgDx0nw+L88YL1MFJGgDqzGHdbGPjay8TeMWCHfJGTgXH
 sz2y33dCIhxEK76o49066ms6QOn6k6huPUKgWDBit4nglzrPs6j0eHyTwIdzFaU2Xp+/Myh6u
 hOL60AxFtI7VFLXLKXcb5B3NpYlyS3DLmVbBDprrq72zuEJPtIZD2B6VDM9f1/IEpRZXIF24w
 O0+ItBfM2GA16hC95AM3P10dwQwSnoFf0986ioHcH5c3hLj17RfeOo774lS8ccZVdw6cu0OA8
 PJGx1usPhxIx5Wd1fDw1VSPxg5ea+mI85/3YG0nChDOWCYHmhRasB4z6xD2hLUoHCHtAcCPdC
 tgbao8wDjl/hACL9LRFMePjSbKQqadVlAOVwASAzk9ESopzan8ZWu1R5L
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.39.2 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.39.1 (January 17th 2023)

This is a security release, addressing CVE-2023-22490, CVE-2023-22743,
CVE-2023-23618 and CVE-2023-23946.

New Features

  * Comes with Git v2.39.2.

Bug Fixes

  * Addresses CVE-2023-22743, a vulnerability rated "high" making the
    Git for Windows' installer susceptible to DLL side-loading attacks.
  * Addresses CVE-2023-23618, a vulnerability rated "high" where gitk
    would inadvertently execute programs placed in the worktree.
  * Addresses CVE-2023-22490, a moderate vulnerability allowing for
    data exfiltration in local clones.
  * Addresses CVE-2023-23946, a moderate vulnerability that would allow
    crafted patches to trick git apply into writing into files outside
    the current directory.

Git-2.39.2-64-bit.exe | d7608fbd854b3689102ff48b03c8cc77b35138f9f7350d134306da0ba5751464
Git-2.39.2-32-bit.exe | addf55b0a57f38a7950b3ad37ce5c76752202e6818d9f8995b477496b71fb757
PortableGit-2.39.2-64-bit.7z.exe | 20e3959d4e310a79b5cf4138797aa247d473d1f7b077a6c433cbfc4ddc5486f1
PortableGit-2.39.2-32-bit.7z.exe | 84ea6be01df896f6d50192ba4cda85c38ab995154f7aa9d3849492a15f21b500
MinGit-2.39.2-64-bit.zip | a53b90a42d9a5e3ac992f525b5805c4dbb8a013b09a32edfdcf9a551fd8cfe2d
MinGit-2.39.2-32-bit.zip | f2027f51f8b12e5bd3c94782edddcfe277e26a3fc7c014707a72b04714f3b90f
MinGit-2.39.2-busybox-64-bit.zip | ee36c33719ad2f4b23f00e40469045ac4d3ad30e4321fe6d2adbcf3176b747b2
MinGit-2.39.2-busybox-32-bit.zip | c6c0b7fd055a968bb89bff1af6d8cad846f996664ef2aa1b5fdbab6b77c77679
Git-2.39.2-64-bit.tar.bz2 | 14012aba35914970ace948a11b8749847f0e180d4e47eaa72dd091d56dbc7586
Git-2.39.2-32-bit.tar.bz2 | fc0a304f933a7690e45187261ae9132d6586a62a79f540234ce836c000df3f56

Ciao,
Johannes
