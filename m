Return-Path: <SRS0=RoqO=ZW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7906AC432C3
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 20:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3782084E
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 20:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfK3Unl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 15:43:41 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:50761 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfK3Unl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 15:43:41 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 47QNd80F8Bz1rGRb;
        Sat, 30 Nov 2019 21:43:40 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 47QNd76lTrz1qwZJ;
        Sat, 30 Nov 2019 21:43:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id QnE1ybdjbffb; Sat, 30 Nov 2019 21:43:39 +0100 (CET)
X-Auth-Info: Sn+WsSxn8A9qMEhzH1YrfTrI3m5i2obWhVsfixepm7EZ13zMd10pgCw597p+Qrm2
Received: from igel.home (ppp-46-244-176-84.dynamic.mnet-online.de [46.244.176.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat, 30 Nov 2019 21:43:39 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 14F292C0102; Sat, 30 Nov 2019 21:43:38 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] Brown-bag fix on top of js/mingw-inherit-only-std-handles
References: <pull.480.git.1575063876.gitgitgadget@gmail.com>
        <pull.480.v2.git.1575110200.gitgitgadget@gmail.com>
        <xmqq5zj12qc2.fsf@gitster-ct.c.googlers.com>
        <6beaf25f-1369-3e77-fd54-fdb5a1e63707@kdbg.org>
        <8736e5t98b.fsf@igel.home>
        <xmqqwobh15c7.fsf@gitster-ct.c.googlers.com>
X-Yow:  Do I hear th' SPINNING of various WHIRRING, ROUND, and WARM
 WHIRLOMATICS?!
Date:   Sat, 30 Nov 2019 21:43:38 +0100
In-Reply-To: <xmqqwobh15c7.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 30 Nov 2019 12:23:20 -0800")
Message-ID: <87y2vxrt6t.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Nov 30 2019, Junio C Hamano wrote:

> IOW, we cannot take advantage of that POSIX guarantee in the
> codepaths that use our internal API.  So...

But it's still a good practice to follow.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
