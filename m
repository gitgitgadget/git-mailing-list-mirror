Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 492FF20248
	for <e@80x24.org>; Sun, 31 Mar 2019 22:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbfCaWTV (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Mar 2019 18:19:21 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:23613 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731324AbfCaWTV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Mar 2019 18:19:21 -0400
Received: from [192.168.1.12] ([2.101.245.142])
        by smtp.talktalk.net with SMTP
        id AinOh9a8HgI7iAinOhOSbB; Sun, 31 Mar 2019 23:19:19 +0100
X-Originating-IP: [2.101.245.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=KYisTjQD c=1 sm=1 tr=0 a=mQgiQ6BlbOv19lEfDgieCg==:117
 a=mQgiQ6BlbOv19lEfDgieCg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=xtxXYLxNAAAA:8 a=5rxgeBVgAAAA:8 a=pGLkceISAAAA:8
 a=uPZiAMpXAAAA:8 a=wBFLdvVfQhUmNWd9B_QA:9 a=QEXdDO2ut3YA:10
 a=xts0dhWdiJbonKbuqhAr:22 a=PwKx63F5tFurRwaNxrlG:22
Subject: Re: Google "Season of Docs"
To:     Kapil Jain <jkapil.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>
References: <8bb78ce0-9b32-7c49-e4aa-ce9f31662627@thingbag.net>
 <572677cc-eef3-345b-e970-cd6cc80e8e96@iee.org>
 <CAMknYEP2m7fJ9o5dybEibmMwJJ9-wMStThwU0YN6f_QZzK=z=w@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <70eeea8b-230c-1f33-f52d-db0e69870a76@iee.org>
Date:   Sun, 31 Mar 2019 23:19:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMknYEP2m7fJ9o5dybEibmMwJJ9-wMStThwU0YN6f_QZzK=z=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfCiC5Wcsehaih4tWSdauCk5C01fEd23lbT1tBUkUR0moslqlGy/aBJR4uNlQQw8m+hg2GilWupmL65fHqFtxT1wMO0t13SQdEkHNz4CNxkh9EDP2UfIF
 fd9qRws/AdNwmO+CijLZtmA/HlcmjGiF3M1h02MyxPHpD6i2Fub/kyKO9Iq9CqTfs1nyIvdLr6/VvoLSrfiFZBpFNzJ+C676A/g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hi Kapil,
On 31/03/2019 07:41, Kapil Jain wrote:
> On Sat, Mar 30, 2019 at 10:48 PM Philip Oakley <philipoakley@iee.org> wrote:
>> * Developers rarely want to write documentation (it's too obvious to them)
>> -- Our code base has become larger than the average brain-full, maybe
>> that (developer education) also could also benefit from some further
>> structural documentation.
> by developer documentation you mean, a doc explaining what each function does ?
> agreed, such developer education will help a lot.
> i am currently trying to do that for `pretty.c`
I was especially thinking for that point of architectural descriptions 
for the code to help new folk (devs) learn about the codebase, rather 
than it potentially feeling like a bit of an initiation / indoctrination 
activity. Often the tidbits about the architecture, organisation and 
coding approaches are buried in the email archive, but are hard to find 
for the new comer. For example there are various times that one gets say 
a "Junio explains" email that contains a wealth of information, but 
unless recognised and book marked at the time, rapidly disappears under 
the email pile, so finding the right way of improving that part of the 
documentation would be useful and is something that Technical Authors 
can guide on.
>
>> -- if stack-overflow is the go-to source for 'real' users, why not mine
>> that source.
> this point is unclear, please elaborate.
> I mean stack overflow is searchable already, what kind of mining are
> we talking about ?
Back at an email on the new switch-branch (etc) command [1] it was 
pointed out that we can discern a many things from the sorts of 
questions asked [2]. In that case it was about the User Interface (UI) 
for 'undo'. There are many other issues that crop up that should have 
been easily answered by our extensive documentation, but even when folk 
do try to read the manuals they often don't know where to start or when 
they have found the right nugget. The idea of 'mining' the stack 
overflow (SO) data is to help with that.

It should also be noted that the manual style is in many ways dated - it 
was developed back in the 1960s or before, and was in the days of paper 
reference manuals for those already experienced in the art. We (the 
folks interested in documentation) possibly need to reflect on whether 
the approach is enough, or even sufficient, for the modern world. The SO 
data provides an insight into the questions folk actually ask, and the 
answers they need - perhaps if we had that support structure in place it 
would complement the manuals (there isn't even an index for the manuals, 
nor 'did you mean/want' prompts should folks land on the wrong man page.

We may want to ask if someone has a 'Simplified English' converter 
(AECMA did a guidance of aerospace/pilot/tech manuals). In the same vein 
we should also appreciate that as devs, we are by definition poor at 
user grade documentation, so getting help may improve things.

I was mainly pointing out the opportunity, as I hadn't seen it mentioned 
elsewhere on the list.

Philip

[1] 
https://public-inbox.org/git/CACsJy8Dg06DbbSLuuVHKgQUwHXqqVZLjbmkdkN=m=Vx-QeP6zQ@mail.gmail.com/
[2] https://stackoverflow.com/questions/tagged/git?sort=frequent

