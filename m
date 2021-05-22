Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC1CC2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 12:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A003761164
	for <git@archiver.kernel.org>; Sat, 22 May 2021 12:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhEVMpQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 08:45:16 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:22768 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230244AbhEVMpO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 08:45:14 -0400
Received: from host-92-1-139-132.as13285.net ([92.1.139.132] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1lkQyq-0007Qs-9X; Sat, 22 May 2021 13:43:49 +0100
Subject: Re: [PATCH v4] help: colorize man pages
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Leah Neukirchen <leah@vuxu.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
References: <20210520040725.133848-1-felipe.contreras@gmail.com>
 <842221d6-51c4-e08a-4299-c4efb8bf1dcb@gmail.com> <xmqqbl94smjb.fsf@gitster.g>
 <YKdy5jhHgG2who27@coredump.intra.peff.net>
 <60a7f57fe3301_5503920831@natae.notmuch>
 <YKgXXCvWYI9rjKJT@coredump.intra.peff.net>
 <60a828cebd2f1_77e4f208b2@natae.notmuch>
 <YKjU+/mGzWoqe88V@coredump.intra.peff.net>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <362a8b5b-84cf-079d-a4c7-c714ed3a2f07@iee.email>
Date:   Sat, 22 May 2021 13:43:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKjU+/mGzWoqe88V@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/05/2021 10:55, Jeff King wrote:
> On Fri, May 21, 2021 at 04:40:30PM -0500, Felipe Contreras wrote:
>
>> Jeff King wrote:
>>> On Fri, May 21, 2021 at 01:01:35PM -0500, Felipe Contreras wrote:
>>>
>>>>> I still don't understand what we gain by making this a Git feature,
>>>> What do we gain by making `git diff` output color?
>>> Huh? Git is outputting the diff. Who else would output the color?
>> Do you think our users know or care which binary has the final
>> connection to the tty?
> Yes. If we are telling them that "git help git" is using "man", which we
> do, then I think they should expect it to behave like "man".
>
> Moreover, I think that if they like colorized manpages, they'd probably
> want them when running "man" themselves.
>
> -Peff
And we have the whole Git for Windows community who don't have `man`
anyway...
It's a bit of a conundrum, especially when considering all the
'terminals' Windows folk maybe using.
