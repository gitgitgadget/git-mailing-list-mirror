Return-Path: <SRS0=LEOb=ZX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3819C432C3
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 17:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1532073C
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 17:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfLARJT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Dec 2019 12:09:19 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:53344 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfLARJT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Dec 2019 12:09:19 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 47QvqJ04pRz1qqkc;
        Sun,  1 Dec 2019 18:09:15 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 47QvqH5GlQz1r4n0;
        Sun,  1 Dec 2019 18:09:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id npmXzERMOGRa; Sun,  1 Dec 2019 18:09:14 +0100 (CET)
X-Auth-Info: V2MXY8mpwlOqoXsK/VBeqqnEXSgfq3FcjDDXLm07CivKheH5FuVh7p5kuFGQr2l+
Received: from igel.home (ppp-46-244-172-29.dynamic.mnet-online.de [46.244.172.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun,  1 Dec 2019 18:09:14 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 0FC0D2C0CE5; Sun,  1 Dec 2019 18:09:14 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Todd Zullinger <tmz@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] t7812: expect failure for grep -i with invalid UTF-8 data
References: <20191130004653.8794-1-tmz@pobox.com> <87a78ddc9o.fsf@hase.home>
        <xmqqo8wsypit.fsf@gitster-ct.c.googlers.com>
X-Yow:  I'm having a BIG BANG THEORY!!
Date:   Sun, 01 Dec 2019 18:09:13 +0100
In-Reply-To: <xmqqo8wsypit.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 01 Dec 2019 08:33:14 -0800")
Message-ID: <87o8ws55xi.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Dez 01 2019, Junio C Hamano wrote:

> So, which one of JIT / non-JIT sides did the test fail unexpectedly?

The non-JIT was the one that wasn't actually tested.

> Should I do s/on big-endian arches/with PCRE with JIT disabled/
> while queuing the patch?

Right.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
