Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 915B01F462
	for <e@80x24.org>; Tue, 28 May 2019 20:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfE1Ub2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 16:31:28 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:55443 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbfE1Ub2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 16:31:28 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45D58t4D9Rz5tl9;
        Tue, 28 May 2019 22:31:26 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C3528208D;
        Tue, 28 May 2019 22:31:25 +0200 (CEST)
Subject: Re: [PATCH v3] userdiff: add built-in pattern for rust
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc:     git@vger.kernel.org
References: <20190520170403.16672-1-marcandre.lureau@redhat.com>
 <e1c4c2ab-927d-fff9-b9e7-13943cba2273@kdbg.org>
 <CAMxuvay3ynFuP3fu57T0f9NEhjbCfM2hCUrdBHvxw-d1Jj54FA@mail.gmail.com>
 <xmqqtvde4jxv.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <a7d42d82-7d84-bf25-55ce-5c57a7ce70e9@kdbg.org>
Date:   Tue, 28 May 2019 22:31:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqtvde4jxv.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.05.19 um 18:34 schrieb Junio C Hamano:
> Marc-André Lureau <marcandre.lureau@redhat.com> writes:
> 
>> Ok, I am adding:
>> ...
>> sure, I thought it was already covered.
>> ...
>> I think that would be fine, ok I am changing it
> 
> Thanks, both.
> 
> The previous round has already hit 'next' (which means that we won't
> replacing the patch wholesale), so whatever you do, please make the
> update relative to / on top of what is queued as d74e7860
> ("userdiff: add built-in pattern for rust", 2019-05-17).

Ok. So, Marc-André, would you mind resending an incremental patch,
because the word-regexp that is currently in 'next' would catch certain
expressions that should be multiple words as a single word?

-- Hannes
