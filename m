Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E3EB1F406
	for <e@80x24.org>; Wed, 17 Jan 2018 20:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753023AbeAQUFb (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 15:05:31 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:36998 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752667AbeAQUF3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 15:05:29 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3zMJ3p6V4Pz1qqkT;
        Wed, 17 Jan 2018 21:05:26 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 3zMJ3p6301z1svMj;
        Wed, 17 Jan 2018 21:05:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id nWVZ0TgvtuZg; Wed, 17 Jan 2018 21:05:26 +0100 (CET)
X-Auth-Info: LN1r4QH+78fmPVoU2tcShGFoyHYvZfgiQHe0YFdUsLbYNdigCj5iskMDG0l1XyEH
Received: from localhost (ppp-188-174-154-147.dynamic.mnet-online.de [188.174.154.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 17 Jan 2018 21:05:26 +0100 (CET)
Received: by localhost (Postfix, from userid 1000)
        id A9AD42C341D; Wed, 17 Jan 2018 21:05:25 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] enable core.fsyncObjectFiles by default
References: <20180117184828.31816-1-hch@lst.de>
        <xmqqd128s3wf.fsf@gitster.mtv.corp.google.com>
        <20180117193510.GA30657@lst.de>
X-Yow:  Yow!  It's a hole all the way to downtown Burbank!
Date:   Wed, 17 Jan 2018 21:05:25 +0100
In-Reply-To: <20180117193510.GA30657@lst.de> (Christoph Hellwig's message of
        "Wed, 17 Jan 2018 20:35:10 +0100")
Message-ID: <87a7xcw8sa.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jan 17 2018, Christoph Hellwig <hch@lst.de> wrote:

> I've lost data on development machines with various times countless
> times due to the lack of this option, and now lost trees on a

Too many times. :-)

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
