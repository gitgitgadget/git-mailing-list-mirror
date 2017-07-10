Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96B9020357
	for <e@80x24.org>; Mon, 10 Jul 2017 17:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932496AbdGJRcW (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 13:32:22 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:53960 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932221AbdGJRLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 13:11:09 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3x5sDh57HLz1qwRL;
        Mon, 10 Jul 2017 19:11:00 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 3x5sDh3btMz3jgXt;
        Mon, 10 Jul 2017 19:11:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id fenSspNZxos5; Mon, 10 Jul 2017 19:10:59 +0200 (CEST)
X-Auth-Info: Lf75n1QG08dcBeO588amlnAInX/8zT5GXx+ilmqrQL5QyENZqmtocutM9mIHtM/g
Received: from igel.home (ppp-88-217-21-192.dynamic.mnet-online.de [88.217.21.192])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 10 Jul 2017 19:10:59 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 0C55E2C4600; Mon, 10 Jul 2017 19:10:59 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
X-Yow:  We just joined the civil hair patrol!
Date:   Mon, 10 Jul 2017 19:10:58 +0200
In-Reply-To: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 10 Jul 2017 03:03:42 -0400")
Message-ID: <87wp7g9pzx.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jul 10 2017, Jeff King <peff@peff.net> wrote:

> If this patch can survive a few releases without complaint,
> then we can feel more confident that designated initializers
> are widely supported by our user base.  It also is an
> indication that other C99 features may be supported, but not
> a guarantee (e.g., gcc had designated initializers before
> C99 existed).

Note that the GNU C designated initializers initially used a different
syntax than the one C99 adopted.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
