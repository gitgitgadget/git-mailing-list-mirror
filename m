Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1E321F731
	for <e@80x24.org>; Wed,  7 Aug 2019 21:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbfHGVDs (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 17:03:48 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:41611 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730045AbfHGVDs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 17:03:48 -0400
X-Originating-IP: 157.45.36.172
Received: from localhost.localdomain (unknown [157.45.36.172])
        (Authenticated sender: me@yadavpratyush.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B0ED4E0008;
        Wed,  7 Aug 2019 21:03:44 +0000 (UTC)
Subject: Re: [PATCH] git-gui: Call do_quit before destroying the main window
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190804143919.10732-1-me@yadavpratyush.com>
 <b7cbe50d-879f-68b9-30b2-181c3058297f@yadavpratyush.com>
 <xmqqftmejgr1.fsf@gitster-ct.c.googlers.com>
 <549ad583-5ca1-7096-f4ce-10e8a836f7f9@yadavpratyush.com>
 <xmqq5zn8j25p.fsf@gitster-ct.c.googlers.com>
From:   Pratyush Yadav <me@yadavpratyush.com>
Message-ID: <9a425bf6-1138-48db-3506-6bee1eff21ee@yadavpratyush.com>
Date:   Thu, 8 Aug 2019 02:33:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq5zn8j25p.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/7/19 11:20 PM, Junio C Hamano wrote:
> Pratyush Yadav <me@yadavpratyush.com> writes:
> 
>> So if I fork the project, will you pull from my fork? If yes, what
>> exactly would I have to do? Make a set of changes and then ask on the
>> list for you to pull from my fork?
>>
>> I am a relatively inexperienced programmer, and it feels like a kinda
>> big responsibility that I'm not sure I am ready for. But maybe you can
>> look at the changes from a high level POV before pulling, so there is
>> someone sanity checking my changes.
> 
> This patch as a one-off thing may not be too bad, as it already had
> exposure to the list (and there probably are more people scanning it
> than it would have been if you silently made a pull request on
> GitHub, because they saw messages from me in this thread).

I think you misunderstood me. I do not mean to create a GitHub pull 
request, because as you say, no one other than me and you will look at 
it. What I meant was that I can pile up a bunch of commits, and send 
them on this list here for you to merge. I can explain those changes in 
the cover letter, so people not very familiar with git-gui or Tcl/Tk can 
still get a general idea of what's happening.

> BUT.
> 
> If I make it a habit to pull git-gui stuff from random people who
> are not committed to and/or feel experienced enough for working on
> git-gui, the result would be even worse than taking patches on
> git-gui directly from the list.  At least a patch on the list I can
> see how others react (or not react).  On the other hand, I do not
> know how to interpret lack of comments from others on GitHub pull
> request---perhaps nobody thought it was a good change, perhaps
> nobody is paying attention to it, or what other possibilities there
> are.
> 
> So,... quite honestly, I'd rather not.
> 

I'm not sure what the bottom line is for what you say. Does this mean 
that you'd rather not merge patches about git-gui at all, and if I want 
to improve something, I should just run my own fork (at least until 
someone steps up to maintain it)? Or does this mean that you'd prefer me 
to send patches here on this list, and you'd look at them and merge 
them? Or is it something else?

And again, to make it clear, I do not intend to use GitHub pull requests 
at all. What I meant by "pull from me" was just that you pull (maybe 
fetch is the right word?) changes from my fork and merge them in your 
tree. But as you said, you'd rather not.

-- 
Regards,
Pratyush Yadav
