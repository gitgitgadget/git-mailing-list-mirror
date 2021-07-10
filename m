Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490EEC07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 22:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2486161248
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 22:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhGJWQ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 18:16:29 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.104]:13968 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhGJWQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 18:16:28 -0400
Received: from [84.163.65.41] (helo=[192.168.2.202])
        by smtprelay06.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m2LDJ-0003ki-IL; Sun, 11 Jul 2021 00:12:45 +0200
Subject: Re: PATCH: improve git switch documentation
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <87wnqaclz8.fsf@osv.gnss.ru> <60e5f3981de5f_301437208bc@natae.notmuch>
 <87bl7d3l8r.fsf@osv.gnss.ru> <60e61bbd7a37d_3030aa2081a@natae.notmuch>
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
From:   Martin <git@mfriebe.de>
Message-ID: <30e4c874-6b87-b03d-fa33-fde5b7e50b2a@mfriebe.de>
Date:   Sun, 11 Jul 2021 00:13:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60ea07e3495e8_7ef2081d@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/07/2021 22:49, Felipe Contreras wrote:
> Martin wrote:
>>   From the docs (and similar on git checkout)
>>> --force
>>>
>>>      An alias for --discard-changes.
>>> --discard-changes
>>>
>>>      Proceed even if the index or the working tree differs from HEAD.
>>> Both the index and working tree are restored to match the switching
>>> target. If --recurse-submodules is specified, submodule content is
>>> also restored to match the switching target. This is used to throw
>>> away local changes.
....

>> If the working tree is made to match the target, then it can not retain
>> local changes. That can be concluded.
>> Yet, it is explicitly mentioned.
>>
>> Does it really hurt to mention it?
> 
> Yes it does.
> 
> Time is the most precious resource we all have. We should not waste the
> most precious resource of our readers.
> 
>    Throw away local changes.
> 
> That does a much better job.
> 
> If you want to be more explicit, you can add a bit more information:
> 
>    Throw away local changes either in the staging area or the working
>    tree.
> 
> Why does the user have to know what HEAD is? And why does it matter that
> the staging area is held in a file called "index"?
> 
> The current explanation is just bad.

Time is precious, but to really save on it, you have to invest some of it.

About the HEAD/index stuff => that was not at all related to the point I 
was making.
But I agree that bit can be shortened

The thing that I was pointing out, is the last sentence only.
 >    This is used to throw away local changes.

But even that can be reduced to your proposal
 >    Throw away local changes.

It still supports my point. It does state explicitly that data is (or 
can be) thrown away.


Now, if that can be stated on this option, then all I ask is to add a 
similar statement (as short as possible) to "-C".
It should indicate that *commit* may be *dropped".
Find a better word for dropped: lost, unreachable, removed.....

Currently only the branch is mentioned.
Currently nothing does explicitly say that *commits* can be affected.

At the end of the current or rewritten "-C" doc, add:
 >     This can drop commits

4 words. All that is needed.



> There's only one person you need to convince.
> 
> So, what I suggest you to do is take into consideration all we have
> discussed and send another patch, because that's ultimately all that
> matters. Moreover, it usually happens to me that while I write the patch
> is when finally the previously-discussed ideas start to click.

Well, I will see to make some time and put something together.
Might be a bit before I get to it, but that gives some time to think about.

