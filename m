Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F406C07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 13:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3357561178
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 13:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbhGKNmM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 09:42:12 -0400
Received: from smtprelay08.ispgateway.de ([134.119.228.98]:40942 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbhGKNmL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 09:42:11 -0400
Received: from [87.152.144.190] (helo=[192.168.2.202])
        by smtprelay08.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m2ZfR-0001N1-3c; Sun, 11 Jul 2021 15:38:45 +0200
Subject: Re: PATCH: improve git switch documentation
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
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
 <6ffd7f1c-97be-a57c-b738-31deae26e8fc@mfriebe.de>
 <871r85f39n.fsf@osv.gnss.ru>
From:   Martin <git@mfriebe.de>
Message-ID: <33af677c-8fec-5b49-0e00-878918c4ea1d@mfriebe.de>
Date:   Sun, 11 Jul 2021 15:39:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <871r85f39n.fsf@osv.gnss.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/07/2021 14:23, Sergey Organov wrote:
> Martin <git@mfriebe.de> writes:
>> Because humans are more about the "things".
>> The way we interact is more ofter derived from the object, than the
>> object being purposefully made for an interaction?
> 
> I don't see it, at least not in the usual human conversations. When one
> means an action to be performed, they name the action and then the object:
> 
>    "Play football", "Go home", "Set your thoughts straight", "Wash your hands"
> 
> No?

1) the order does not necessarily indicate the significance.

2) That is English for you. Afaik there are languages which have the 
verb at the end.
Also, in German it is perfectly fine (though not very common) to use 
"object verb subject". Fussball spielen wir.

Even in English you have: Woe is me. Yes "woe" is the Subject.


> Anyway, it's more the consistency that matters, not particular
> convention. Git problem is that is has no convention at all. "Just do
> what feels right today" seems to be the motto.

Well human languages are not as rigid as computer languages.

> 
> Finally, the problem for this particular discussion is that if we decide
> that it's rather:
> 
>    git <object> <command>
> 
> that is the way to go, that I'm pretty fine with as well, we should
> simply *obsolete "git switch" right away*, rather than spending time
> improving its now almost useless documentation.

Actually then we would end up with

    git branch switch
    git tag switch   // detach
    git commit switch   // detach

Well it could be
    git worktree switch
(ignoring the effect on the index / and bringing "worktree" into a 
single worktree setup)



The problem is, that IMHO forcing either verb or noun, ends up with 
grouping commands in ways that create unnecessary dividers between 
related actions. (Continued, next paragraph)

> 
>>>   From that POV, for the commands you mentioned, "git bisect" is probably
>>> fine, whereas "git worktree", and "git remote" should better be split to
>>> operations on them, e.g.:
>>>      git new remote
>>>      git new worktree
>>>

This is what I mean with dividers.

There may be some relation between "new branch", "new tag"

But I can see none between "new branch" and "new remote" and "new 
worktree". None at all. Yet I can see relations between different things 
you can do with a worktree.

I also think that, switching to a commit or branch are to closely 
related, and should not be divided.
(There were even suggestions that switching to a commit, is an unnamed 
branch)

As I said, I have not read any research paper on that topic.
But to me, it severely disrupts the intuitive aspect.


>>
>>> Once that is regularized, we may as well consider allowing for inverse
>>> order of the first 2 arguments, by making
>>>     git new remote
>>>     git remote new
>>> the synonyms.
>>
>> Having even more ways to do one and the same thing....
> 
> Python was aiming to have one obvious way of doing every single thing...
> Did it succeed in that, I wonder? Maybe this aim is only good in theory?

We are way away from having "one single way". But aiming for the extreme 
opposite may not be any smarter.



While there is nothing wrong with going our own way in the end, maybe we 
should look around before?
How do other vcs do it?

svn has at least status and log, which I would consider nouns, the way 
they are used. And it has verbs too.

hg as "branches", "files" which are nouns. And "log".
And it has verbs too.

So there seems to be a pattern to using "mixed" verbs and nouns.
