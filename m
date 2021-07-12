Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23585C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0510461242
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbhGLQf5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 12:35:57 -0400
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:1560 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbhGLQf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 12:35:57 -0400
Received: from [79.233.237.92] (helo=[192.168.2.202])
        by smtprelay04.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m2yqT-0006x6-6j
        for git@vger.kernel.org; Mon, 12 Jul 2021 18:31:49 +0200
From:   Martin <git@mfriebe.de>
Subject: Re: PATCH: improve git switch documentation
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <877di13hhe.fsf@osv.gnss.ru>
 <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
 <60e67389a4adc_306ac1208fd@natae.notmuch>
 <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
 <60e736e72da68_30939020850@natae.notmuch>
 <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
 <60e762243aab1_30a7b02089@natae.notmuch>
 <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
 <60e79c31aaa72_30b8a4208c1@natae.notmuch>
 <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
 <60e874e1c6845_215320861@natae.notmuch>
 <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
 <60e88a4b8592f_16bcb2082b@natae.notmuch>
 <ad58bd54-a9dd-59a9-4fce-f90be469cd60@mfriebe.de>
 <60e9f8d462bd9_7ef20898@natae.notmuch>
 <6f43b36b-abe1-41f2-6138-e820c974b1bd@mfriebe.de>
 <60ea07e3495e8_7ef2081d@natae.notmuch>
 <30e4c874-6b87-b03d-fa33-fde5b7e50b2a@mfriebe.de>
 <60ea2eb562f26_2a69208e8@natae.notmuch>
 <1e18c4ed-6975-5041-4b4f-75c4d3d21860@mfriebe.de>
 <60ec6d91deced_a452520825@natae.notmuch>
To:     git@vger.kernel.org
Message-ID: <54644739-2138-8086-1696-d3c52960216c@mfriebe.de>
Date:   Mon, 12 Jul 2021 18:33:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60ec6d91deced_a452520825@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07/2021 18:28, Felipe Contreras wrote:
> Martin wrote:
>> On 11/07/2021 01:35, Felipe Contreras wrote:
> 
>>> Do this:
>>>
>>>     -N <branch>::
>>>       Create a new branch like '--new', but if it already exists reset it
>>>       like '--reset'.
> 
>> Or even shorter
>>         See the --new option.
>>         Allows to re-use a branch-name and may drop commits
>>         [resetting it].
> 
> Yes, it is shorter, but now it doesn't even say what it does.
> 

Ok instead of " see the --new option"
use "Same as the --new option, but allows...."
