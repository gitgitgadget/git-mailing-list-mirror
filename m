Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AEEC2BA2B
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 14:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC88B208FE
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 14:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgDIO2S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 10:28:18 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:50607 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbgDIO2S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 10:28:18 -0400
Received: from [92.30.123.115] (helo=[192.168.1.38])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jMYAD-0000Vx-79; Thu, 09 Apr 2020 15:28:17 +0100
Subject: Re: [PATCH] revision: --include-diversions adds helpful merges
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <pull.599.git.1586308923544.gitgitgadget@gmail.com>
 <xmqqv9mapxw9.fsf@gitster.c.googlers.com>
 <5f1c6868-303c-ccc1-553e-e54d0fa8e24f@gmail.com>
 <74562b04-b1ce-cad4-da18-4af030a3dc29@gmail.com>
 <xmqqzhbloj4u.fsf@gitster.c.googlers.com>
 <20200408200526.GA2270445@coredump.intra.peff.net>
 <9eab6c60-3c99-d6ac-9206-02ce37f7a479@gmail.com>
 <xmqqv9m9oe2p.fsf@gitster.c.googlers.com>
 <91fafa17-c58f-dcd0-320d-48c4512561f6@gmail.com>
 <xmqqimi9o705.fsf@gitster.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <7d84fc45-786f-7a2e-5889-ef26916627ef@iee.email>
Date:   Thu, 9 Apr 2020 15:28:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqimi9o705.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On 09/04/2020 01:08, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>>>> In my latest attempt at documentation, I called these merges "diverters"
>>>> yet still used "--include-diversions". Here are a few other words that we
>>>> could use:
>>>>
>>>>  * diverters or diversions
>>>>  * redirects
>>>>  * switches (think railroad switch). Synonym: exchange
>>>>  * detours
>>> ...none of the above tells me that they are not no-op (in other
>>> words, they do something meaningful), so I must be coming from
>>> a direction different from you are.  What redirects from what other
>>> thing, for example?
>> The merges do something meaningful: they "merge in" a "real" change.
> Yes, but "redirect", "switch", "detour", or "divert" do not quite
> mean "merging in a real change", at least to me.
>
>> I'll just submit my v2 as-is, which includes a significant change to
>> the documentation that should make things more clear.
> Thanks.
Can I suggest "--side-merges" as a possible descriptor for these
non-mainline diversions?

My thesaurus had suggested detour and sidetracked, which led to the
side-merge view.

Philip
