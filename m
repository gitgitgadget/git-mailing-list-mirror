Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1726C636C9
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 21:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8862561176
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 21:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbhGQV04 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 17:26:56 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.43]:42446 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhGQV0y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 17:26:54 -0400
Received: from [84.163.64.100] (helo=[192.168.2.202])
        by smtprelay01.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m4rnB-0005ma-Ah; Sat, 17 Jul 2021 23:24:13 +0200
Subject: Re: PATCH: improve git switch documentation
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
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
 <e57f1d19-d574-5ba5-efc1-abb8ab2a8c01@mfriebe.de>
 <60f33f8a7c39b_507220823@natae.notmuch>
From:   Martin <git@mfriebe.de>
Message-ID: <1cb8774e-2489-e8aa-12ce-8d7e34b700ff@mfriebe.de>
Date:   Sat, 17 Jul 2021 23:23:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <60f33f8a7c39b_507220823@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/07/2021 22:37, Felipe Contreras wrote:
>> If the user does not enter the state of concluding, then they will not
>> reach a conclusion at all.
> 
> If they had not reached a conclussion of what the command would do, then
> they would have not typed the command.

Please re-read my previous answers.

> 
> But they did type the command. Therefore they reached a conclussion about
> what the command would do.

Please re-read my previous answers.

> Just like before I click "send" I had already reached a conclussion
> about what that command will do, otherwise why would I click it?
> 

Are you sure that a
- all your information was by conclusion, and none by other means?
- your conclusions where complete?

For the 2 above points, I pointed out several times that the users had 
partial info, and did not realize that it was incomplete.
They were happy with what the partial info was, therefore they run the 
command.
They never realized there was more.

By clicking "send" you have therefore revealed, that you have either not 
read, or otherwise not realized the content of those previous 
explanations of mine.
Did you really conclude that before clicking send?

> I do not want to challenge your statement. Either you see what is
> obvious to me, or you don't.
I think I do see what is obvious to you. Unfortunately however that what 
you (afaik) think to be obvious, that is wrong.

You appear to believe a partial realization of what -C does is not 
possible. That for some reason, a user either realizes the full extend 
or nothing. No middle ground.

But that middle ground exists.

IIRC It was you who suggested something along the lines "taking steps 
becomes walking".
Well, when I walk, I do not think about the steps. I do not realize 
them, nor conclude their existence.
So it is possible to overlook important parts of a given whole.



> To me it's obvious that effect comes after cause.
Which has nothing to do with the issue at hand.

As soon as you see any part of the effect, that statement is satisfied. 
You cause something, you see some effect. All is good.
But if what you saw is only a fraction of the entire effect, then you 
may never know.

When mankind started burning fuel, did they do so knowingly that it 
would destroy the environment, which they need to survive?
According to you they must have, its an effect. They did the cause, they 
burned the fuel. The must have known the effect it would have.

Well they would have, if it had come with a documentation including a 
proper warning ;)


>> For the 4th or 5th time (not going to count the exact number of times I
>> have answered the exact same question)
> 
> Repeating "I have washed the dishes properly" multiple times doesn't mean
> that you actually did it.

Yes, but you repeat the question.
Rather than pointing out, what in your view is incorrect in my 
statement, you ask the same question again hoping for a different answer.

> 
>> The reason is the branchname was used, and the wanted to use it again.
> 
> What does "use it again" mean?

To them: Create a branch of that name at some commit.
To me: much more.


> It does matter to me. Unless I see evidence for the existence of
> something, I'm not going to *assume* that that something exists.
> 
But you assume that the following exists: "With the current doc, all 
users are fully aware of all consequence"

Yet you have no prove for that. You only can have prove that this 
applies to those you know (or those you ask).

So, since you have no proof, you can not assume that a situation exists 
in which the current doc is sufficient.


>> "Off" is not called "force snooze". Off does not require to conclude
>> info, as "-C" does.
> 
> It's a "yes" or "no" question. Did he have a reason to click "off"?
>

Well in the sense that I understand your question: Yes.

And it did do, what the documentation said. Exactly that, and nothing 
more. So there was no surprise of any kind for that user.

If you mean to say, he fell asleep again, and the doc had no warning 
against that, well good (the doc part, not the falling asleep).
I also do not request, that we add warnings to the git doc that say "you 
may do something wrong, get angry, and in your rage destroy parts of 
your work". No we should not add that.

Those are personal issues. The lost commits are a technical issue.
