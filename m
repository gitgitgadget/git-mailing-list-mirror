Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D544BC4707F
	for <git@archiver.kernel.org>; Thu, 27 May 2021 11:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B349D610A6
	for <git@archiver.kernel.org>; Thu, 27 May 2021 11:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhE0LWJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 07:22:09 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:19530 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhE0LWI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 07:22:08 -0400
Received: from host-92-14-216-189.as13285.net ([92.14.216.189] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1lmE42-0001B8-8T; Thu, 27 May 2021 12:20:34 +0100
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
To:     Varun Varada <varuncvarada@gmail.com>
Cc:     git@vger.kernel.org
References: <CAD2i4DBj6fNvq=Lc3KiXJj5uBpteyKfEKp7ATOWrTE36KUeRww@mail.gmail.com>
 <63dca3b2-1858-6708-5fb7-5a072b7b62f3@iee.email>
 <CAD2i4DAbBiVRo2Zk_cSYbgXGmm0SMUJZxSqYWhQr3tjwHxCYHQ@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <571aa879-4f34-751d-b2e7-33d4042656c1@iee.email>
Date:   Thu, 27 May 2021 12:20:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAD2i4DAbBiVRo2Zk_cSYbgXGmm0SMUJZxSqYWhQr3tjwHxCYHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/05/2021 00:52, Varun Varada wrote:
> On Thu, 13 May 2021 at 05:40, Philip Oakley <philipoakley@iee.email> wrote:
>> Hi Varun,
>>
>>
>> I've seen the rather extended discussion about word choice. However Can
>> I suggest an alternative split of the patch?
>>
>> If the patch is split between:
>> 1. Test shells
>> 2. Code comments
>> 3. Manual pages
>> 4. Guides and How to's.
>>   then it should be possible to focus on the precision aspects first,
>> and only later get into the imprecision of modern colloquial English.
>> For the manual page changes, having a direct link to a test shell or
>> code comment change would provide important support to the clarification
>> of any precision aspects of the changes.
> I'd be happy to split it, but I'm not sure I follow what you mean by
> "precision aspects".
Hi, I was using precision in a similar way to the accuracy/precision
sense that you had highlighted about affect/effect not really being
interchangeable (i.e. my 'precision' is similarly inexact;-).

You are right that there is a distinct difference between affect/effect
for the grammar pedants and that in the vernacular (common) usage,
because of the many dialects and vocalisation here in UK (and likely the
Americas), many folk ignore the spelling (esp if spoken;-) and just look
for context.

My suggestion was to start with just the test/code comments where it is
likely easier to identify and describe the affect/effect mistakes
(accurately and precisely). By splitting the patches into separate Test
and Code changes each review gets smaller and easier.

Then, for each of the test and code patch, see if there is a (~exactly)
matching issue in the documentation. These can then (hopefully) easily
be justified by reference to their code/test change.

This should leave a few (~small amount ;-) of residual affect/effect
potential changes to be discussed/argued over.

Philip

[the _average_ number of residual changes won't be an integer, so maybe
it is a small amount of changes]

