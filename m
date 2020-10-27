Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D805C4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 21:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3405E2222C
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 21:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373528AbgJ0VBB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 17:01:01 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:28613 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S373514AbgJ0VA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 17:00:57 -0400
Received: from host-89-243-187-160.as13285.net ([89.243.187.160] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1kXW5O-000Bc8-Aw; Tue, 27 Oct 2020 21:00:54 +0000
Subject: Re: [PATCH] documentation symlink restrictions for .git* files
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
References: <20201005071751.GA2290770@coredump.intra.peff.net>
 <20201005121609.GA2907272@coredump.intra.peff.net>
 <6c0a0036-e217-a334-2a74-dd59a4592c1f@iee.email>
 <20201023081711.GB4012156@coredump.intra.peff.net>
 <8bb54778-507c-2e3f-d35a-5e32edb8bee7@iee.email>
 <20201026225300.GA23128@coredump.intra.peff.net>
 <xmqqo8kod0ms.fsf@gitster.c.googlers.com>
 <20201027072648.GG3005508@coredump.intra.peff.net>
 <xmqqk0vbcxtb.fsf@gitster.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <21e4bac1-b3ef-e28f-586d-fe17baf6b15e@iee.email>
Date:   Tue, 27 Oct 2020 21:00:53 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <xmqqk0vbcxtb.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/10/2020 18:45, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
>>>  DESCRIPTION
>>>  -----------
>>>  
>>> -A `gitattributes` file is a simple text file that gives
>>> -`attributes` to pathnames.
>>> +A `gitattributes` file is a simple text file (it cannot be a
>>> +symbolic link to anything) that gives `attributes` to pathnames.
>> I worried that even a short mention like this would be distracting. Not
>> because it's so long, but because it's right there in the very first
>> sentence, and I really think this is a corner case that most people
>> would not even think about.
>>
>> So it is helpful if you are looking for info on symlinks and these
>> files, but probably clutter if you are looking for something else.
>>
>> I have to admit I don't feel all that strongly either way, though.
> I don't, either, and as I said, I found that the placement of new
> text was OK.
>
>
I do think that the extra text above is the right thing to do.

We should be informing readers early about things that are expressly
prohibited.

Leaving just the note till nearly the end of the rather long
attributes/ignore man pages makes it very hard to discover for
frustrated users, which would accidentally reinforce the idea of the
docs being poor (rather than being focussed).

Philip
