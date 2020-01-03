Return-Path: <SRS0=XQOF=2Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B947BC00523
	for <git@archiver.kernel.org>; Fri,  3 Jan 2020 22:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7B521835
	for <git@archiver.kernel.org>; Fri,  3 Jan 2020 22:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="SxV1CuWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgACWIQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jan 2020 17:08:16 -0500
Received: from mout.gmx.net ([212.227.17.21]:45419 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728549AbgACWIP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jan 2020 17:08:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578089290;
        bh=1fp8bkOuLfN0nLD4w+662ZJiLPaDIN/oj9ZPgb7pspk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SxV1CuWneI8hZSbWaQStLvwgrnsGn5h1s2CpMirQf4DQVOZXuFbOLat+WuxXdPxoy
         A3ETs9IsyAa8xqlh4Nr8ikXfv8ZAdbJ3Ago5ZkRD7ZeUaYcG+v5hhkn/NUXuLRNPhN
         AcnPxFmotDrgnJvZwHJ6gmBDhyLpxfQHUEH8HKPM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mo6ux-1jWflx2pb9-00payH; Fri, 03
 Jan 2020 23:08:10 +0100
Date:   Fri, 3 Jan 2020 23:08:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Git for Windows v2.25.0-rc1, was Re: [ANNOUNCE] Git v2.25.0-rc1
In-Reply-To: <xmqqpng1cu2c.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2001032306580.46@tvgsbejvaqbjf.bet>
References: <xmqqpng1cu2c.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xlG0sCua6pMOwjk4jTmLT+EXPd1iBaWHFCrfRbvvVoGrLgBLii3
 ax1wqrZ/O47DCXmjDJeratR3vw86DYqTBy7+Coqwdty+j0j6Zqxq+60Ll8AgUnXwn0yx1Kx
 9g7R0QWahSpcpTEzNJo8fxJAXlKzVLcCN0jkLJB1qKvfwmIRmV2bimnTitz9J/SJbiku13l
 ePtaqOMokuLJm7w2hHW3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4+ARG5ZYWnU=:/HmutMIvlY7awlDZl40JH1
 yDdmxwOvuWxjboaMCdRlVizpXc6Uz5dZbXOFx0mpywBUoqPgvo62MIN+VIJYh/QDUkFPrtDGw
 zMs9xxwLX29Rpyi5nKz4DP5pi0p/23oBBlqxZC9J1nRNVBGZiozKkOQs/KJs56wGs/5K5PKsf
 JwKXhaeMSFpZOGu/B1SgnRpz0OVcB9yvibIypI+FDHtqgrUB7LVjoSf5q6RXTS8hVxcfLFvtL
 7RS6N6tKh2xseKlhQ08LXx0nsFttO+gCqHr7kXCG9Wq4ZbbbSaBZBYJUuBFj8VAHg6xWrPHRR
 86T0PZ+O7IxWc4Jbp0GKJDWEtgQIRyeXgK4nhKH8uP8ig4Te/J5k6vPMPY0x2cBVffvVPjelq
 Yr01NWRTxc4wRlERi7G+HNCxCJuJSyjGpW3sacm19PdXWcXNCSh7VGVPGTYjiFELSmUoufRgj
 d/0wuKssOHtK6k4TlKiAI1QaInZrAmGuOIUCflsJGTdLe1pxVN/LNzDPXD6LNlVdbWcuYMuEE
 KOwgUZlBnbOlC6jfWzCLCh9RuPaE0Fjyn6kls5O16Sh3Tj3Hhaf8BKqMys+EmwRDT7ss8YQqT
 vei9UkBpoHYm5ykYaf9JKTNppz3OYLxa5rn75eWidua2cQaDq8dGSRylixV2EKgYCohB7rMAA
 nNWFFuthFyefrrnwgCYW7NhULRjIoSPMxmqMrSTeiG7MNrkO3Z7QfLGEevIzntIVbZSeykETn
 BrSdbyI0F5Ajl9hy3URzfcex7m+5t4YsN/ThywuojxQ8gDWq4HN9GtaPjry5OCnHkTnMzkzhJ
 rl75F7E9BcR1yneTw3Y8MO2pnda1+g8nWze3SmduSD3q2wb/MpoFSQR99aYO/p/C8uy9rBJlR
 OgzKDOPIoVrYhgn9trwlc6rL6a74cqdiHB27ECJuC3ULgC2HA7Gj0zeWqBbLslKDuRw3CXOQS
 4WyJKhvQhmtrwHGMp6IDhCrGk1nPvZUAH/R+SMK8fKvlyybL+va8FJwMBEib4VEZolHq0bNVy
 4SjwB5CrkBPq6YLzZcLPZvidxsROaYtS9FiveVmmAWpOMLlGylGRnY2kclGbYUIez7GoLkskx
 CtPGeuD5/3xkWG2DE80rD5C3FgAtzLA2qPtC+qokx1g4dx6vC9IdFR3XpFK84sxpNjs6vgQj1
 OH9NVWmGtXC5sKMjX9Y7PQOrL70bj9kav3MD8yzxkQ/cs0u1VIWcTqn0p2ToErVdCwASVguOn
 rJmIHJ3FMPkqbtecrGd8g42RvxEGHJFT8GwX4MUV1PzOo3JfWhaVaRr9b+zM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Team,

On Thu, 2 Jan 2020, Junio C Hamano wrote:

> A release candidate Git v2.25.0-rc1 is now available for testing
> at the usual places.  It is comprised of 540 non-merge commits
> since v2.24.0, contributed by 63 people, 24 of which are new faces.

The corresponding Git for Windows v2.25.0-rc1 can be found here:

	https://github.com/git-for-windows/git/releases/tag/v2.25.0-rc1.windows.1

Please test!

Thanks,
Johannes
