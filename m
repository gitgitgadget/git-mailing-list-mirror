Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E20A20A29
	for <e@80x24.org>; Thu, 21 Sep 2017 15:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbdIUPjg (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 11:39:36 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:54802 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751957AbdIUPje (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 11:39:34 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3xyglR1X22z1r3bZ;
        Thu, 21 Sep 2017 17:39:30 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 3xyglQ3jN3z1qrll;
        Thu, 21 Sep 2017 17:39:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 1HxIdy39fnyi; Thu, 21 Sep 2017 17:39:29 +0200 (CEST)
X-Auth-Info: lCRI2xoeN3YvFJny0rlxt4DjESK211EDFLpI/pDJQQS0Q3PehRyckLglN1+DsyW4
Received: from igel.home (ppp-88-217-30-250.dynamic.mnet-online.de [88.217.30.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 21 Sep 2017 17:39:29 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 3F0F12C2317; Thu, 21 Sep 2017 17:39:29 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] for_each_string_list_item: avoid undefined behavior for empty list
References: <cb2d4d71c7c1db452b86c8076c153cabe7384e28.1505490776.git.mhagger@alum.mit.edu>
        <20170915184323.GU27425@aiede.mtv.corp.google.com>
        <b8951886-feab-a87a-9683-3c155cfa98a8@alum.mit.edu>
        <b03c7b09-853f-a2ed-f73e-7d946c90cedb@gmail.com>
        <20170920023008.GB126984@aiede.mtv.corp.google.com>
        <xmqqd16mowig.fsf@gitster.mtv.corp.google.com>
        <20170920052705.GC126984@aiede.mtv.corp.google.com>
        <87vakd2v22.fsf@linux-m68k.org>
        <20170920173134.GZ27425@aiede.mtv.corp.google.com>
        <87lgl9rqbq.fsf@linux-m68k.org>
        <xmqqtvzwn9bj.fsf@gitster.mtv.corp.google.com>
X-Yow:  NOW, I'm supposed to SCRAMBLE two, and HOLD th' MAYO!!
Date:   Thu, 21 Sep 2017 17:39:29 +0200
In-Reply-To: <xmqqtvzwn9bj.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 21 Sep 2017 10:12:48 +0900")
Message-ID: <87y3p8uklq.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sep 21 2017, Junio C Hamano <gitster@pobox.com> wrote:

> Now you make me curious.  How would that variant be different from
> option C. in Jonathan's message?

Only in the parity of the condition.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
