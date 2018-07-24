Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4E8A1F597
	for <e@80x24.org>; Tue, 24 Jul 2018 19:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388552AbeGXUYg (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 16:24:36 -0400
Received: from [195.159.176.226] ([195.159.176.226]:39299 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S2388471AbeGXUYf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 16:24:35 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-3@m.gmane.org>)
        id 1fi2lQ-00079l-DD
        for git@vger.kernel.org; Tue, 24 Jul 2018 21:14:28 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v1] config.c: fix msvc compile error
Date:   Tue, 24 Jul 2018 21:16:33 +0200
Message-ID: <559fda9d-80b4-64db-e8a4-a886902f28c3@drbeat.li>
References: <20180724153010.6693-1-git@jeffhostetler.com>
 <235ae68c-f764-ba3a-c641-ef5f99507564@drbeat.li>
 <xmqqwotkxzn0.fsf@gitster-ct.c.googlers.com>
 <8fd2fe53-ff42-5e21-a485-a38c97331b9c@drbeat.li>
 <xmqqr2jsxybd.fsf@gitster-ct.c.googlers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
Cc:     git@jeffhostetler.com, git@vger.kernel.org, peff@peff.net,
        me@ttaylorr.com, Jeff Hostetler <jeffhost@microsoft.com>
In-Reply-To: <xmqqr2jsxybd.fsf@gitster-ct.c.googlers.com>
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24.07.18 20:50, Junio C Hamano wrote:
> Beat Bolli <dev+git@drbeat.li> writes:
> 
>> On 24.07.18 20:22, Junio C Hamano wrote:
>>
>>>> This was already fixed (differently) in
>>>> <20180705183445.30901-1-dev+git@drbeat.li>.
>>>
>>> Thanks for saving me from having to dig the list archive myself.
>>> Yes, it is already applied to the tip of the topic that originally
>>> caused the breakage.
>>>
>> Just a general question:
>>
>> Is it OK to refer to patches on pu with the Message-ID, or would you
>> prefer the commit hash? The hash changes whenever you recreate pu,
>> doesn't it?
> 
> Either is fine in practice.  The commits themselves on a topic
> branch that is not yet in 'next' usually stay the same once the tip
> of 'pu' that contains them gets published.  Even though I often use
> "git rebase -i", "git commit --amend", etc. to fix up posted patches
> while turning them into commits on topic branches, I usually stop
> doing so once I push out day's integration result.
> 
> Until a new version of the series is posted to replace them on the
> topic branch, that is.  But at that point we are talking about new
> patches with different message-ids that got turned into different
> commit objects, so either commit object name or message id that
> refer to older iteration would still name the same old version, and
> new names would refer to the same new version.
> 

Ok, thanks!

