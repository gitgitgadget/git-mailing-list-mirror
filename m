Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158ADC07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 10:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA89661242
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 10:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhGKKHy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 06:07:54 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.43]:32282 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhGKKHx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 06:07:53 -0400
Received: from [87.152.144.190] (helo=[192.168.2.202])
        by smtprelay01.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m2WKo-0007FH-Sl; Sun, 11 Jul 2021 12:05:14 +0200
Subject: Re: PATCH: improve git switch documentation
To:     Sergey Organov <sorganov@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
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
 <87im1ieaba.fsf@osv.gnss.ru>
 <1bd36aa2-ac90-f7d4-9d48-1aa39159b263@mfriebe.de>
 <87a6mudt9b.fsf@osv.gnss.ru> <60e9ff4430c57_7ef20815@natae.notmuch>
 <874kd1gr0q.fsf@osv.gnss.ru>
From:   Martin <git@mfriebe.de>
Message-ID: <6ffd7f1c-97be-a57c-b738-31deae26e8fc@mfriebe.de>
Date:   Sun, 11 Jul 2021 12:05:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <874kd1gr0q.fsf@osv.gnss.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/07/2021 11:04, Sergey Organov wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
>>
>> I don't see the logic in here.
>>
>>    git branch topic # here 'branch' is the verb
> 
> Not to me. I assumed the "branch" is always a noun in "git branch", and
> the actual meaning of this command is:

Well, it is easy to see it as a noun. But for "branching" creation of a 
branch, it can be seen as verb.

Yet in
    git branch --list
it definitely is a noun.

But then how would/should those work?
The action/verb is "list" or "show"

    git show branches
    git show tags
    git show ...

That completely tears apart related topics.

Or is it enough if the subcommand is a verb?
     git branch create
     git branch list
That be ok for me.


>>> is "branch" a noun or a verb?
>>
>> Both.
> 
> No, it's rather noun plus lacking subcommand, sometimes making it look
> like verb :)

As is
     git stash
for
     git stash push

And I should guess lots of people like the short form....




> I.e., I'm in favor of universal:
> 
>     git <command> ...
> 
> syntax to Git commands where <command> specifies an action. [Why things
> tend to drift to Lisp all the time, I wonder?]
> 

Because humans are more about the "things".
The way we interact is more ofter derived from the object, than the 
object being purposefully made for an interaction?


>  From that POV, for the commands you mentioned, "git bisect" is probably
> fine, whereas "git worktree", and "git remote" should better be split to
> operations on them, e.g.:
> 
>     git new remote
>     git new worktree
> 

That also makes documentation harder. People who want a worktree, want 
the documentation for it in one place.

So a manpage for "git new" is not desirable. It would have to be split 
into the manpages for the objects. But that is not good either, or is it?


> Once that is regularized, we may as well consider allowing for inverse
> order of the first 2 arguments, by making
> 
>    git new remote
>    git remote new
> 
> the synonyms.

Having even more ways to do one and the same thing....


Btw, missing from the discussion:

    git log

"log" can be a verb, but not in the above.

Because "to log" is to write something into a log.
But "git log" is to show (i.e. read) the log.



