Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A96C282DD
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 21:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583EE2075D
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 21:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FPgE+FVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgAIVrY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 16:47:24 -0500
Received: from mout.gmx.net ([212.227.17.20]:42183 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgAIVrY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 16:47:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578606436;
        bh=Zv0Ldq35zpEE7wOyZtR8VAx/JvNE3ms3tiRdPRwnN08=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FPgE+FVL1eN0spbGgH9a47RJ2/U/rBj62P+Ad/w3/CjO4mANYGC//K9Kvp62y6UHd
         LjAYgMwBiN+q8qTcxjEoxxKi7dv7aXrNmyQmbI8ZeOo/QH/0v/0IummJRt+GyEsD8/
         ifVxwc09yTlP9jQUqT1jahtfWAoeVUrG7k3iblR0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYvcG-1jBkrk1biy-00UpII; Thu, 09
 Jan 2020 22:47:16 +0100
Date:   Thu, 9 Jan 2020 22:47:15 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git-for-windows@googlegroups.com
cc:     git@vger.kernel.org, git-packagers@googlegroups.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Git for Windows v2.25.0-rc2, was Re: [ANNOUNCE] Git v2.25.0-rc2
In-Reply-To: <xmqq8smh1t3m.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2001092244250.46@tvgsbejvaqbjf.bet>
References: <xmqq8smh1t3m.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FXgdCLDaIs/j1SWAUu6HYagzc45zRTZY8tA/9MtPu5+uOp7aMQu
 bi9q5am6q7jtJTVLSAdhAzYqq71+XOzcM3qhUJfJJ21aQxHjMZrGq0U8COgdTvzwCghKvY/
 V85IxPej1G4zBBUiAQ/437ZEzOnEr+xFgX7UxqdU/VeeO7nQ2p7zSeflJcQel5oP4ubFsZg
 24qmEqr1j9D5VgYmKATqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GBYKgvR+0qk=:6EvAXOAf0IoWxMPBhSWGgd
 Rgyu587OLKZbOnCWDRWnyDoyxaZyxltM/Q06C54IaHyvp5rZNt+Ctqviu1+HHqsyddONMKJPu
 haiDKlPWiBdXNuxWp46DDr6lflqxk8ZSjwDLePjfpSs4TyTAH0rwpg1nl3lYC/GdHMnbJ3o1l
 nkCjff8yZQISL1GuJGKFD/ApUO7dzKidqh6HSlYmo/vup29hNyAUX03K4LW4sitEgxG4CisEa
 UGpct9ra8Mh4xxYiovda/BxLRcYacCBXAzQ1Q3gctdpV7cAoJpLZRroNeh53Ynz6mfai9L/2W
 gfn+6JslsmDsVH4OFfTizd7Ct/obhByNk8sdcoL+lxyEtLp5wqr9F5Xd7XQix3f2MYmN9mJqu
 +eGluXxgyklE+C48lvAMrQQTUnUBUDFpbNVuY8mcc1v77moYeqIRtq32hOdauLqoo0CC8HUhc
 /ONb9Kxz0IYk2m2PxOrtRujAwajsCWIY/xb6U+vJT1uPrWtR6bQlLQ2slBdrVDd42SzFAO+jH
 TFdd+L8WfdFprWv/g/i6pnQdydL5NshNurhIfHx7ZUhz1B6fT9EUXmhUMeBpm+iNulqUKANOa
 pBnWXsr88vXwqHLtw0bdMWPlUX8M4gNd30DUOyX94PwbXzFd/ItEyaLKe18pInMQ+TsTr8lCe
 A0rMlRFortDwgPxv+mybZFGdVcOHMQKQ7n9krqiOAIuCzWDkIk+tv4goPNr07uh92jJMet1iS
 zgqc+3wpA4lSd55VPwII5sLAe4bEk+ZdTC/KfLIM06Mv3km1oLmWY8pv/QTT2hirVemGn7Zst
 71u15mCqVxWcCy+JGRlF2zFyzsJfOEzTSMT93eZ2ZePGApiL+0dwAqihHQ1SH0YzdADG3wvR1
 NeOxi2jNgY9cMWQRzgnMn2Zv3xg4Fong1W6+OMaM6vLtf+0jsZ4RKvmhX2krbCKNXTs+TpX86
 bas0+oVKxLf93/sJpr9sJAgsXXVgJ2LV+pRrUQHr3Ah2fZ59Pfd57ZFO5OHtpIIrRVfekVJaz
 /DWs80aK2eQmJM0UY5gOog5s2FWFupfcv3PSu6he3Va06fnVS6Qv2l7woY8ilnWuIGnuJg7ne
 BLWORn2sWQbaQseJezqTpOrIWsjw/TkpnS8c7pkqffUBv+eV8vxglJZYenr1zk1WW8ghC4izW
 EYW5DDDnJ4723VI25edrWg1oa2FEA/Mk3s81KkjDPVx407CyjATcNmm6/IrsvT1blor6e1pHW
 NRdB/wFBAq+kVU+DD3ILgbizOGtESBXeIiU/wuxpJuztojH+q076VxhI4jC8=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Team,

On Wed, 8 Jan 2020, Junio C Hamano wrote:

> A release candidate Git v2.25.0-rc2 is now available for testing
> at the usual places.  It is comprised of 517 non-merge commits
> since v2.24.1, contributed by 70 people, 29 of which are new faces.
>
> The tarballs are found at:
>
>     https://www.kernel.org/pub/software/scm/git/testing/

The corresponding Git for Windows v2.25.0-rc2 can be found here:

	https://github.com/git-for-windows/git/releases/tag/v2.25.0-rc2.windows.1

In addition to rebasing Git for Windows' patches from v2.25.0-rc1 onto
v2.25.0-rc2, this also includes the "mingw: safeguard better against
backslashes in file names" fix that I sent upstream in
https://lore.kernel.org/git/pull.690.git.git.1578576634678.gitgitgadget@gm=
ail.com/

Ciao,
Johannes
