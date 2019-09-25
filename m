Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0CB41F463
	for <e@80x24.org>; Wed, 25 Sep 2019 14:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407550AbfIYOO2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 10:14:28 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:24482 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406676AbfIYOO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 10:14:28 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iD83l-00032m-Bv; Wed, 25 Sep 2019 15:14:25 +0100
Subject: Re: [DISCUSSION] Growing the Git community
To:     Pierre Tardy <tardyp@gmail.com>, Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "gitster@pobox.com" <gitster@pobox.com>, garimasigit@gmail.com
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
 <CABPp-BFXs4qes20S+9AZd++p3epW4eJ7Vu7zU_PdDysZ_D-yrg@mail.gmail.com>
 <CAJ+soVcmMwy7GgLcV-m1kNEsHYirHMQQeFuEYZanbCNUK4_zHg@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <b6835484-62a4-6f89-b6b1-f43afe794272@iee.email>
Date:   Wed, 25 Sep 2019 15:14:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJ+soVcmMwy7GgLcV-m1kNEsHYirHMQQeFuEYZanbCNUK4_zHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pierre,

On 25/09/2019 14:36, Pierre Tardy wrote:
>>> As a community, our number one goal is for Git to continue to be the best
>>> distributed version control system. At minimum, it should continue to be
>>> the most widely-used DVCS.
>> I'd rather we stated our goal in terms of what problems we are trying
>> to address rather than accolades we want sent our way.  E.g. "Our goal
>> is to make developers more productive by providing them increasingly
>> useful version control software".
>>
> Agreed.
> And why restrict on DVCS?
> Isn't it admitted that the distributed version control is nowadays
> much better in term of software productivity?
> Is there some use cases that "traditional" centralized VCS are better
> on, and on which we gave up as a goal?
>
> Regards,
> Pierre
As an old engineer, I do remember and still see the vast range of areas 
where the Git DVCS is probably never going to help because it doesn't 
solve the engineering issues that regular VCS (e.g. Mil-Std-498) have 
solved for generations...

What modern computing, Linux style, has is:
- Perfect replication, at near zero cost or time.
- Line oriented, Source code based basis.
- Computational efficiency, at near zero cost or time.
- Crypto-algorithms at strength.

If we go outside those areas we are less and less likely to manage. 
(digital video? Every binary to be serialised? bit rot resilience? 
traceability?).

We do have some Elephants in the room regarding What the community is 
about (limits and goals), as distinct from How we conduct ourselves 
(CoC), but that probably should be separated out.
