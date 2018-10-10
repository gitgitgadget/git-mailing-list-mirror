Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D63DF1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 13:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbeJJVVA (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 17:21:00 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:15956 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJJVVA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 17:21:00 -0400
Received: from [192.168.2.240] ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id AF0Zg33ribZX5AF0agfC1x; Wed, 10 Oct 2018 14:58:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1539179920;
        bh=mvz3kVxT5dF+MavblxPOQ++hKjC7h7MhsQfoEsKUePk=;
        h=Reply-To:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=k2EXGakJTEfIqmRIWekJA3qeUijt18kSMpqqZw+eaoqconAYF45uojSBzjPA8kX8u
         f7V2OZOJIJZMy93pleq4KBuxefQ5K6wlPtJ0Mw8AmeJbIwtT+lXthwcVMpDMEVpPYF
         5Avyo40zL4Rtrjnvf9EftKHo+aPPT085u8YDKQh4=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=IkcTkHD0fZMA:10 a=TlrTnCPvLR3R2mFbQ5oA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Oct 2018, #01; Wed, 10)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
Cc:     Stefan Beller <sbeller@google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <42930bb1-502b-b168-be12-92aee526a258@talktalk.net>
Date:   Wed, 10 Oct 2018 14:58:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJxOQMoN714bA7uJ8bqxZxMzSA0cT8XtSLckC7s9bJcix3XtgrbnMZ3wVQONMeP8aKZ0e8+suTujH4RapyY3b1o8mrHrxjs1RXtecSL6vRO/IC6za8O1
 v90/Py9ubqGb1invqiHFvKYkswyZOmgE0KxV7JZngn/7z4Vvcl5PA7vrVDEYYdBCRjwn2za0KAdt2Q1ql7MD2Si7YXogf5x5KMnROwbRXVpBNuj5r5L5PA5W
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10/2018 06:43, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
> 
> * pw/diff-color-moved-ws-fix (2018-10-04) 5 commits
>   - diff --color-moved: fix a memory leak
>   - diff --color-moved-ws: fix another memory leak
>   - diff --color-moved-ws: fix a memory leak
>   - diff --color-moved-ws: fix out of bounds string access
>   - diff --color-moved-ws: fix double free crash
> 
>   Various fixes to "diff --color-moved-ws".
> 
>   What's the status of this topic?

I think it is ready for next - Stefan was happy with the last iteration.

Best Wishes

Phillip
