Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7808C636C9
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 10:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8945E613D8
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 10:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhGQKKd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 06:10:33 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.100]:10358 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhGQKKb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 06:10:31 -0400
Received: from [84.163.64.100] (helo=[192.168.2.202])
        by smtprelay05.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m4hD6-0004rD-S2; Sat, 17 Jul 2021 12:06:16 +0200
Subject: Re: PATCH: improve git switch documentation
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
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
 <1997ca3b-117a-e19a-0dee-7342a2f1a0e7@mfriebe.de>
 <60f1f4c3dd8b1_14cb208c1@natae.notmuch>
 <fedbfe1f-9e6d-f46f-ca41-e176a30e938c@mfriebe.de>
 <60f22aaa6a4f1_1f602081b@natae.notmuch>
From:   Martin <git@mfriebe.de>
Message-ID: <e57f1d19-d574-5ba5-efc1-abb8ab2a8c01@mfriebe.de>
Date:   Sat, 17 Jul 2021 12:07:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60f22aaa6a4f1_1f602081b@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/07/2021 02:56, Felipe Contreras wrote:
> Martin wrote:
> It is the Socratic method. If I tell you "the user will think X" you are
> not going to believe me. Therefore I'm asking you what the user will
> think.
> 
>> But no one is taking them by the hand. No one is asking all those
>> questions to them.
>> So they (new users) will not always make that conclusion.
> 
> What conclusion would they reach?

You realize that your question makes no sense?

If the user does not enter the state of concluding, then they will not 
reach a conclusion at all.

If you want to challenge my statement, that the user does not start 
concluding, then you could ask me: Why?
To which I have to admit, I do not know, I did not ask those who didn't.
And frankly it does not matter. Lets assume we knew "why". Then to 
remedy that cause, some change would be needed. So most likely the doc 
would need to be changed to have some trigger added, to overcome that 
reason. In the end, that means more info in the doc. Same as what is 
already proposed.


>>> What do they think it will happen?
>>
>> They do not think about it at all.
> 
> This doesn't make any sense. They used -C instead of -c for a reason.
For the 4th or 5th time (not going to count the exact number of times I 
have answered the exact same question)

The reason is the branchname was used, and the wanted to use it again. 
The doc says they can use it again. So that is all they want at that moment.

Why is there an extra option for doing this, good question but to them 
at that point in time: not relevant. The doc of the option does not say, 
that there may be any consequences, so that is good enough at that moment.

If you want, you can call them ignorant. But in their defence they may 
not even know that. They have whatever other issues to solve at that 
time. They are happy to have found that option, and they really need to 
return to whatever other stuff they were doing. So they trust the docs, 
and the docs have no explicit warning.

Frankly all the above, is a very common pattern that lots of people show 
at some time or another. Whatever the problem, people go for whatever 
*appears* to be the easy fix. No thought on what will happen after that. 
In German their is a saying "Nach mir die Sinnflut".


>>
>> Because they did not correctly understand what the net protected the from.
> 
> Users should not be executing commands they don't understand. If a user
> doesn't understand what `git delete-this-branch` does, then he shouldn't
> run it.
> 
How can they check they understand it?

See also the example of the person that makes *two* the conclusions. How 
can they tell there is nothing further that they need to conclude?


> If the documentation says a command overwrites a branch, and the user
> runs the command anyway,
So is that an admission that people may not always come to the conclusion?
I.e., what I said: They do not think about that part at all.

 > and the branch is overwritten, git did what the
> user told it to do, and what happened is the responsibility of the user.

Well, that is a matter of philosophical debate.

It does not say "commits may be affected".
I think or hope, that we can agree the effect on commits is something, 
that is to be concluded. The discrepancy we have is, whether it will be 
concluded by all users ("all" is to mean a high percentage leaving no 
significant rest).

If we agree on that "conclusion" statement, then the discrepancy we have 
can be further deducted on whether there is such an "significant rest" 
amount of users.

I believe there is. You do afaik not believe this.

But if there is (or "if there were") such an significant amount of 
users, then it would be a valuable addition to add text, that add the 
result of that conclusion.


So then all the "what would they think..." question do not really 
matter. It does not matter what they think, if it is not what they are 
expected to think. If there is a significant amount of people who for 
any reason whatsoever do not think this, then I believe the 
documentation should respect the fact, that those people exist (and more 
than just as an exception).





>>> Let me try yet another analogy.
>>>
>>> If an alarm clock has two buttons "snooze" and "off".
>> How exactly is that connected?
>> This is a random story. Not an analogy.
> 
> The fact that you don't see the analogy doesn't mean it isn't one.
> 
> Did the user click "off" for a reason?

"Off" is not called "force snooze". Off does not require to conclude 
info, as "-C" does.

Lets say, there is a "change timezone" and a "force change timezone" 
button, and the first one would reject to work, if an alarm is active, 
the 2nd would work even if an alarm exists.
Then that would be an analogy. Because then the user has to figure out, 
that changing the timezone would change the displayed hour, and as a 
consequence clear the alarm.

In your example, where is the conclusion the user has to make?



>>> Mistook it for what? What did they expect it was going to happen?
>> I have answered that in great detail, at least 3 times in this mail thread.
> 
> I'm sorry, but no, "they'll think nothing and they'll do it for no
> reason" is not an answer.
Well, that is not what I wrote.


