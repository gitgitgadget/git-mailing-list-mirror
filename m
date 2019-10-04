Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B4781F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 16:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390414AbfJDQJl (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 12:09:41 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:29197 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389835AbfJDQJk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 12:09:40 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iGQ9C-0002VZ-5V; Fri, 04 Oct 2019 17:09:39 +0100
Subject: Re: [PATCH 2/2] git-gui: support for diff3 conflict style
To:     Bert Wesarg <bert.wesarg@googlemail.com>
References: <97013a71289857767100d6a4adcb39ca99b2b21b.1569443729.git.bert.wesarg@googlemail.com>
 <f1477ba53a03484a0440202065a5293c8795d3b7.1569443729.git.bert.wesarg@googlemail.com>
 <20190929150406.s57pmb3dggfbcqhr@yadavpratyush.com>
 <CAKPyHN3nOL6qy4RhwwHrh2m3EJuJ1-rt-8+0+=z2oJi96Nigpw@mail.gmail.com>
 <dc210bf0-eef3-ed58-f596-0999fd9d9a98@iee.email>
 <20191003205407.uaguw7qyabfy3aym@yadavpratyush.com>
 <e5ae969c-6d82-ed13-b309-f8010288fbd9@iee.email>
 <CAKPyHN0_AUqLpPVDNJUZqNV8zRQzaDOMXJV4AbnK969AdtGpNg@mail.gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Pratyush Yadav <me@yadavpratyush.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <c1d27317-3ca7-14c6-7fd8-047282894c68@iee.email>
Date:   Fri, 4 Oct 2019 17:09:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKPyHN0_AUqLpPVDNJUZqNV8zRQzaDOMXJV4AbnK969AdtGpNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/10/2019 16:22, Bert Wesarg wrote:
> On Thu, Oct 3, 2019 at 11:40 PM Philip Oakley <philipoakley@iee.email> wrote:
>> On 03/10/2019 21:54, Pratyush Yadav wrote:
>>>> My only remaining bikeshed question it prompted was to check which parts
>>>> would be committed as part of committing the whole "hunk". But haven't had
>>>> time to look at all!
>>> I'm not sure what you mean by "committing the whole hunk". In a merge
>>> conflict state, you don't get the usual "Stage hunk" and "Stage lines"
>>> options, but instead get 3 options:
>>>
>>>     Use Remote Version
>>>     Use Local Version
>>>     Revert To Base
>>>
>>> You can use these to choose how you want to resolve the conflict.
>>>
>>> These 3 options seem to work fine on my quick testing.
>> That looks like just the answer I was hoping for!
> note, that these three options apply to the whole file, not for
> individual conflicts.
>
>
Hmm, maybe not as great as hoped, but it's a start.
Philip
