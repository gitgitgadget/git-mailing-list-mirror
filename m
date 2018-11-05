Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5069B1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 07:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbeKEQTy (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 11:19:54 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:3067 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729000AbeKEQTy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 11:19:54 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 42pNrj1F6Wz5tmD;
        Mon,  5 Nov 2018 08:01:41 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id BB46D221C;
        Mon,  5 Nov 2018 08:01:40 +0100 (CET)
Subject: Re: [PATCH 1/1] poll: use GetTickCount64() to avoid wrap-around
 issues
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Arenas <carenas@gmail.com>, shoelzer@gmail.com,
        gitgitgadget@gmail.com, git@vger.kernel.org,
        johannes.schindelin@gmx.de
References: <pull.64.git.gitgitgadget@gmail.com>
 <69bc5924f94b56f92d9653b3a64f721bd03f1956.1541020294.git.gitgitgadget@gmail.com>
 <c9e001de-3598-182d-416e-1e94f234c249@kdbg.org>
 <CACbrTHctZejfDTjqWqVfPYdb=ssD253Cd2isr3BxWsL1AqsH2w@mail.gmail.com>
 <e8b7b173-eaa1-0fad-7e6a-771389872886@kdbg.org>
 <CAPUEspgF0GjJPtMqmZjUmsEeaJpQQBBwOV9YOg8A6YBdwbdaFA@mail.gmail.com>
 <46aa1893-095b-9f0c-4989-e63ebaa88705@kdbg.org>
 <xmqqefc0mnlh.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <8b22754b-89ec-ae04-c839-83810f93872f@kdbg.org>
Date:   Mon, 5 Nov 2018 08:01:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqefc0mnlh.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.11.18 um 00:26 schrieb Junio C Hamano:
> OK, thanks.  It seems that the relative silence after this message
> is a sign that the resulting patch after squashing is what everybody
> is happey with?

I'm not 100% happy. I'll resend a squashed patch, but it has to wait as 
I have to catch a train now.

Appologies for the sub-optimal submission process.

-- Hannes
