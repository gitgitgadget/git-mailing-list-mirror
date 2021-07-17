Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AB0C636CA
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 07:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EEE061103
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 07:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhGQHFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 03:05:32 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:62821 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbhGQHFb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 03:05:31 -0400
Received: from [84.163.64.100] (helo=[192.168.2.202])
        by smtprelay01.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m4eLa-0006hl-TS
        for git@vger.kernel.org; Sat, 17 Jul 2021 09:02:50 +0200
From:   Martin <git@mfriebe.de>
Subject: Re: PATCH: improve git switch documentation
To:     git@vger.kernel.org
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
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
 <54644739-2138-8086-1696-d3c52960216c@mfriebe.de>
 <60ec74c513b2b_a45252081b@natae.notmuch>
 <0d7bd249-2aba-236a-9f93-3a5b30182d15@mfriebe.de>
 <60ec93155663f_a231f208fb@natae.notmuch>
 <3a84e4c9-4e48-1cbe-4fe6-150ff56c8508@mfriebe.de>
 <60ecbe577a086_a6b702082@natae.notmuch>
 <d3678ef6-1bcd-2666-87dc-751aef2ca1a7@mfriebe.de>
 <60edb8ff814cf_ab6dd208d9@natae.notmuch>
 <02f1f12a-0ff3-ef46-fce3-e222b2867309@mfriebe.de>
 <60f1d650e2667_330208e@natae.notmuch>
Message-ID: <db554ab1-11b3-d7e9-6b64-799bc79cb622@mfriebe.de>
Date:   Sat, 17 Jul 2021 09:02:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60f1d650e2667_330208e@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/07/2021 20:56, Felipe Contreras wrote:
> Martin wrote:
>> On 13/07/2021 18:02, Felipe Contreras wrote:
>>> Martin wrote
>>>> You and I will make the connection between "something happens to the
>>>> branch" and "something happens to the commits".
>>>> A lot of people with less experience, who a busy looking through lots of
>>>> stuff to solve their problem, they will not make that connection in that
>>>> particular moment.
>>>> Heck, I've seen highly educated people missing far more obvious things
>>>> like that.
>>>
>>> Once again I'm not talking about what they could miss, I'm talking about
>>> what they are thinking the command will do.
>>
>> Well they think it creates a new branch with the given name. And that is
>> *all* they think.
> 
> No. You are avoiding the question.

I did not avoid it. I answered it, as I understood it. Seems your 
question was not very clear.

> 
> -c creates a new branch. Obviously -C creates a new branch too.
> 
> Once again, *why* would they pick -C over -c? What do they think it will
> do differently?
> 

They think: it makes go away that error message. They can use that 
branchname.

What they do not think is: If I take away the old branch name, what 
happens to the commits in it?

I know, you firmly believe everyone must surely make that conclusion.
But that fails several times..
1) It assumes everyone has enough knowledge to make that conclusion.
While I agree: "they should", I acknowledge they might not.
But, ok. lets say: "there fault". And we don't give a sh*t if others get 
into problem, because they did not read lots of pages and memorized 
every detail...e

2) It assumes the can.
I.e. they have the experience and skill to make the connection. Ok, 
probably 99% can do.

3) It assumes they do (the attempt to make a connection)
And this is my point. Many people will not attempt to think ahead.


People at that moment think about the branch, and the branch only. Many 
will not an all think about commits.

And why would they. In git there are plenty of situations where you can 
delete a branch, without loosing anything else (i.e. without loosing 
commits), because there is an upstream or another local branch.
Until they day that you pick a branch where there is no safety net.



> 
> Bothering 99.99% of users with a useless warning just because one (who
> is not the sharpest pencil in the box) might make a mistake is just not
> wise.
> 
Well, I see you did a survey over a representative group of randomly 
picked people?

Well, yes I cannot tell you any final number. But from what I observed 
from those people that I know, there a quite a few how mistook that 
documentation.
Many (almost most) of those where lucky, in that they had yet only done 
it, when indeed it was safe. But upon question they were surprised that 
it could have gone another way.

Yes that is not representative. But even if I say that in real live the 
quota of such misunderstanding is at only 10% of what I saw, that would 
be a considerable total.


> 
> That being said, we don't have to agree. And we don't have to
> continuously discuss forever. At some point you need to send a new
> version of your patch, and I think that point is long past due.

Yes but part of this has been educative.

(and some of it a bit of fun too)

And I said I will.
But right now, I have things in my live, that prevent me from doing so 
immediately.
They should prevent me from spending time on those mails too, but I 
can't always withstand - so some shortened nights ahead.

I will look at sending a patch, when I have good time to do so without 
being in any rush.

