Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB516C49EA3
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 16:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1AEC6144F
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 16:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhF1QtU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 12:49:20 -0400
Received: from siwi.pair.com ([209.68.5.199]:52515 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231742AbhF1QtU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 12:49:20 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 43C983F413A;
        Mon, 28 Jun 2021 12:46:54 -0400 (EDT)
Received: from AZHCI-MGMT.azhci.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 258C33F40F1;
        Mon, 28 Jun 2021 12:46:54 -0400 (EDT)
Subject: Re: What's cooking in git.git (Jun 2021, #06; Thu, 17)
To:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqr1h1mc81.fsf@gitster.g> <YNZW/zsk93Oi/8uY@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <96e78b85-ac9d-6fcb-f1f1-319f514c7800@jeffhostetler.com>
Date:   Mon, 28 Jun 2021 12:46:53 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <YNZW/zsk93Oi/8uY@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/25/21 6:21 PM, Emily Shaffer wrote:
> On Thu, Jun 17, 2021 at 11:55:26AM +0900, Junio C Hamano wrote:
>> * es/trace2-log-parent-process-name (2021-06-09) 1 commit
>>   - tr2: log parent process name
>>
>>   trace2 logs learned to show parent process name to see in what
>>   context Git was invoked.
>>
>>   Will merge to 'next'?
> 
> I've still not seen much in the way of reviews on this series; mostly
> Randall and I have been talking about ramifications for NonStop, but
> those conversations haven't resulted in changes to the series itself.
> I think it's fine to merge, but I wrote it, so you shouldn't trust my
> opinion. :)
> 
> We've been running this series internally at Google, though, and it
> looks like we do want to look up more ancestors than just the one
> generation, after all. However, I'd prefer to send that as a follow-on
> patch, compared stalling this topic further.
> 
> We do have some early insights from these, though. One interesting
> observation is that it appears Git is more often invoked via some
> wrapper than interactively; that's not too surprising given that we have
> a lot of builders who perform Git operations.
> 
> Anyway, all this to say that we've found this trace useful at Google and
> it's working well for us. Anybody interested in a speedy review would be
> very welcome.
> 
>   - Emily
> 

I just took a look at your V5 and made a few comments.
Jeff
