Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4BAC433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 07:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F8BA21744
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 07:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgHEHAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 03:00:37 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:52253 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHEHAg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 03:00:36 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4BM2ZQ3hxNz1qs3X;
        Wed,  5 Aug 2020 09:00:30 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4BM2ZQ1CrQz1qr5L;
        Wed,  5 Aug 2020 09:00:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id l0rFupu2_Zoc; Wed,  5 Aug 2020 09:00:28 +0200 (CEST)
X-Auth-Info: m8KKhZJfop5T+/fwLy2WX6dQ7Uv5R62m5uM4YNm75aPvquhrjVS/8U2itFye9xaj
Received: from hase.home (ppp-46-244-173-159.dynamic.mnet-online.de [46.244.173.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed,  5 Aug 2020 09:00:28 +0200 (CEST)
Received: by hase.home (Postfix, from userid 1000)
        id 5A76510386F; Wed,  5 Aug 2020 09:00:27 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Birger Skogeng Pedersen <birgersp@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Damien Robert <damien.olivier.robert+git@gmail.com>,
        Damien Robert <damien.olivier.robert@gmail.com>,
        Ed Maste <emaste@FreeBSD.org>, Fangyi Zhou <me@fangyi.io>,
        Fangyi Zhou <fangyi.zhou@yuriko.moe>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <xin.jiang@huawei.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Kevin Willford <Kevin.Willford@microsoft.com>,
        Kevin Willford <kewillf@microsoft.com>,
        Peter Kaestle <peter@piie.net>,
        Peter Kaestle <peter.kaestle@nokia.com>,
        Sun Chao <sunchao9@huawei.com>, Sun Chao <16657101987@163.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH RESEND] Update .mailmap
References: <xmqqy2muqddg.fsf@gitster.c.googlers.com>
        <20200805065408.1242617-1-martin.agren@gmail.com>
X-Yow:  SHHHH!!  I hear SIX TATTOOED TRUCK-DRIVERS tossing ENGINE BLOCKS
 into empty OIL DRUMS..
Date:   Wed, 05 Aug 2020 09:00:26 +0200
In-Reply-To: <20200805065408.1242617-1-martin.agren@gmail.com> ("Martin
        =?utf-8?Q?=C3=85gren=22's?= message of "Wed, 5 Aug 2020 08:54:08 +0200")
Message-ID: <87eeolo9v9.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Aug 05 2020, Martin Ågren wrote:

> diff --git a/.mailmap b/.mailmap
> index bde7aba756..b4e6eb7dd7 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -18,6 +18,7 @@ Alexey Shumkin <alex.crezoff@gmail.com> <zapped@mail.ru>
>  Alexey Shumkin <alex.crezoff@gmail.com> <Alex.Crezoff@gmail.com>
>  Anders Kaseorg <andersk@MIT.EDU> <andersk@ksplice.com>
>  Anders Kaseorg <andersk@MIT.EDU> <andersk@mit.edu>
> +Andreas Schwab <schwab@linux-m68k.org> <schwab@suse.de>

Neither of them are more recent.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
