Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B90DC2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 09:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 357CF6121E
	for <git@archiver.kernel.org>; Sat, 22 May 2021 09:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhEVJNa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 05:13:30 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:59438 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230086AbhEVJNa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 05:13:30 -0400
Received: from host-92-1-139-132.as13285.net ([92.1.139.132] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1lkNfw-000BS2-DD; Sat, 22 May 2021 10:12:04 +0100
Subject: Re: RFC: error codes on exit
To:     Alex Henrie <alexhenrie24@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Josh Steadmon <steadmon@google.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <YKWggLGDhTOY+lcy@google.com>
 <60a5afeeb13b4_1d8f2208a5@natae.notmuch>
 <CAMMLpeScunGg5WM4N90vG+yN3tOATqhsL2iRLsJ43ksNyTx_wQ@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <7f0c9ab8-c1ca-171b-8247-6d921702f3bc@iee.email>
Date:   Sat, 22 May 2021 10:12:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAMMLpeScunGg5WM4N90vG+yN3tOATqhsL2iRLsJ43ksNyTx_wQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/05/2021 17:53, Alex Henrie wrote:
> On Wed, May 19, 2021 at 6:40 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> It's good to not include many initial codes, but I would start with at
>> least three:
>>
>>   OK = 0,
>>   UNKNOWN = 1,
>>   NORMAL = 2,
> If you go that route, could you please pick a word other than "normal"
> to describe errors that are not entirely unexpected? I'm worried that
> someone will see "normal" and use it instead of "OK" to indicate
> success.
>
> -Alex
Typical <== Normal

Though abnormal and atypical often have different implications ;-)
P.
