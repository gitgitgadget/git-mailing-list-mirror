Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEA741F404
	for <e@80x24.org>; Fri, 26 Jan 2018 21:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751532AbeAZVOv (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 16:14:51 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:47203 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751363AbeAZVOu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 16:14:50 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3zSs9g2636z1qs09;
        Fri, 26 Jan 2018 22:14:47 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 3zSs9g1dr2z1tPh8;
        Fri, 26 Jan 2018 22:14:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 8JzXeFNEQC41; Fri, 26 Jan 2018 22:14:46 +0100 (CET)
X-Auth-Info: HQ3IoUXXh2Zh4Uhs1PykdQ5zXQRzy7giqYOmmzFIouT4Y1v6AyXfqvrWhdKTAtW0
Received: from localhost (ppp-188-174-151-205.dynamic.mnet-online.de [188.174.151.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 26 Jan 2018 22:14:46 +0100 (CET)
Received: by localhost (Postfix, from userid 1000)
        id A673E2C10F7; Fri, 26 Jan 2018 22:14:45 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        peff@peff.net, git@jeffhostetler.com, sbeller@google.com,
        dstolee@microsoft.com
Subject: Re: [PATCH 05/14] packed-graph: implement construct_graph()
References: <20180125140231.65604-1-dstolee@microsoft.com>
        <20180125140231.65604-6-dstolee@microsoft.com>
        <xmqq607o732t.fsf@gitster.mtv.corp.google.com>
X-Yow:  YOW!!  Now I'm playing with my HOLOGRAPHIC ATOMIC SIMULATION LASER
 pinball machine!!  WORLD PEACE is in the BALANCE!!
Date:   Fri, 26 Jan 2018 22:14:45 +0100
In-Reply-To: <xmqq607o732t.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 26 Jan 2018 12:55:06 -0800")
Message-ID: <87vafowce2.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jan 26 2018, Junio C Hamano <gitster@pobox.com> wrote:

> Also, would >>32 be a problem if commit.date is an uint32 (and
> shifting all its bits out to the right)?

It would be undefined.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
