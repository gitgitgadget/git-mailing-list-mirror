Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFFCC1F463
	for <e@80x24.org>; Fri, 27 Sep 2019 18:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfI0S6h (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Sep 2019 14:58:37 -0400
Received: from host02.zombieandprude.com ([80.82.119.138]:56484 "EHLO
        host02.zombieandprude.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfI0S6h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Sep 2019 14:58:37 -0400
Received: from [176.12.107.132] (port=61969 helo=[10.101.2.5])
        by host02.zombieandprude.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <cb@hashpling.org>)
        id 1iDvRl-0000fc-8U; Fri, 27 Sep 2019 19:58:29 +0100
Subject: Re: [PATCH] CODE_OF_CONDUCT: mention individual project-leader emails
To:     Jeff King <peff@peff.net>, Emily Shaffer <emilyshaffer@google.com>
Cc:     Denton Liu <liu.denton@gmail.com>, Git List <git@vger.kernel.org>,
        git@sfconservancy.org, Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, garimasigit@gmail.com
References: <20190924064454.GA30419@sigill.intra.peff.net>
 <20190924171214.GA11452@dentonliu-ltm.internal.salesforce.com>
 <CAJoAoZkw08A_nkJNMwgTTFvGMCRUqR2UqEckOp65Vg_TW7K8bg@mail.gmail.com>
 <20190926072046.GB20653@sigill.intra.peff.net>
From:   CB Bailey <cb@hashpling.org>
Message-ID: <442a1736-d935-6033-c59a-e88c1ac179e9@hashpling.org>
Date:   Fri, 27 Sep 2019 19:58:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190926072046.GB20653@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/09/2019 08:20, Jeff King wrote:
> On Tue, Sep 24, 2019 at 04:52:56PM -0700, Emily Shaffer wrote:
>> I helped my other FOSS project to adopt a Code of Conduct earlier in
>> the year (https://github.com/openbmc/docs/blob/master/code-of-conduct.md)
>> and we got around this by asking for volunteers from the technical
>> steering committee to agree to have their contact info listed on the
>> escalation path; at the end of the escalation path we also listed
>> someone external to the project (which we were able to do because we
>> had been adopted by the Linux Foundation, and they have someone for
>> that).
> 
> Yeah, I think this is sort of the same thing except that I
> pre-volunteered the whole project committee. ;)
> 
> We could have a separate list of contacts for the code of conduct, but
> it seems simplest to just use the existing group that we already have,
> unless there's a compelling reason not to.

I, too, wondered if it might be more appropriate to have the list of
names and email addresses separated from the repository and just linked
from the CoC. Perhaps someone would need to expunge themselves from the
list permanently, or perhaps we'd want to protect against a hypothetical
person in a position of control changing the list to their trusted
cronies. I cannot think of a realistic scenario or practical setup which
would actually guarantee any such benefits and this solution is simple
and practical.

Overall for this proposed CoC patch: ACK

CB
