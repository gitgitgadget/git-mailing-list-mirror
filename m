Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36F4B1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 13:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753690AbeDPNIg (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 09:08:36 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:35542 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbeDPNIe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 09:08:34 -0400
Received: by mail-it0-f54.google.com with SMTP id q85-v6so11467447itc.0
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 06:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qbV7amdmbHpIh46/i9fvhS/PPhzp3LFlARvKr1eOpag=;
        b=uaFHQzWDGIh3i93XjyjblVcmkECjxvtC61yKnubHTRsuMiu3XPMuxp/zg0BiRcBuE6
         NC0ZVvpZU8RnzbJh3qHES8JZWqzAj0KPzbZrqhEwScKKzR5TLfad50izO/rK1P725Gjv
         Z3iPioMpAyF4wu+sFIYGU2OME3m263YpQ477lRy1cC7scsdhNuDTGxL8Zmktcp0c8dCS
         C4aFRDoO3mB+3UHOKFx40RcLnpKM6aM6Ao/9LITc5xhxD60md3wkCdxr/ubE3nl7Ikoe
         arxVdV93IjIQFDUxUjsCc/hkYwarbT5YxcFZN/tO4ohBWVKu+KUj53u+mrSH0RcminII
         87/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qbV7amdmbHpIh46/i9fvhS/PPhzp3LFlARvKr1eOpag=;
        b=igdtohpW9EutFjYnHCzJwPHLVEKujh16aMkF2QbdULQZ9XNN7KBsjG1snYYhDVBopC
         uRL+CEE8CxqXOZuF4o7HmBORdqo9vp4FCtWE5t6/fCb+ws+NrEKQa8/AbqWrJ7HIYCs2
         EQ/ZEfUa5RGwZzsobUhdgD5q9BAW4nLiTX6z4ng82Id/wlb6D+OL8n4YirX0pGHzzvJs
         jCYwNndLj55qea51JK6DQwuZIxGmbZPk5NLLsgPqpi6RICKscVXE0dCVdQ5pDhjxIeCP
         gRAmMp5IXZnkyFitIi+Af/+QNntKM3e6QhOnYVCFMdz7WfVodhpqOI1OGOZJg5AXWVhM
         0r/A==
X-Gm-Message-State: ALQs6tDqZTvCpRg6tm8J0fMt777orKxfD+btR1bBpyhWmCRONP6CYXlb
        h+I3nOJXu34HV2EKNtbMvVALH/mS2Tio6GnEP9M=
X-Google-Smtp-Source: AIpwx4/GnFiO3Wbllf/TTWdcQskhl7DlId6yQQyD13skYrigqAD3gbOuga1mhXhmuFDsxZ+T8Qwurx64QQwRABZtCc0=
X-Received: by 2002:a24:1308:: with SMTP id 8-v6mr14782266itz.96.1523884113810;
 Mon, 16 Apr 2018 06:08:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.219 with HTTP; Mon, 16 Apr 2018 06:08:33 -0700 (PDT)
In-Reply-To: <87in8rz65t.fsf@javad.com>
References: <CAP8UFD0DagacfeismKoVgo=O1guRUV=u1=EbbwRyrY3g1MeQ8Q@mail.gmail.com>
 <CAP8UFD1vFM8k-1Po=2QXZdBOuCca1Dg_FGaPnSi85hKp1je54w@mail.gmail.com> <87in8rz65t.fsf@javad.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 16 Apr 2018 15:08:33 +0200
Message-ID: <CAP8UFD3JwHfyr=bByvjDrxboFL+yHVdZnbkXztsUuOU0aRD-9w@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 38
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On Mon, Apr 16, 2018 at 2:29 PM, Sergey Organov <sorganov@gmail.com> wrote:
> Hi Christian,
>
> Christian Couder <christian.couder@gmail.com> writes:
>> On Mon, Apr 16, 2018 at 12:11 AM, Christian Couder
>> <christian.couder@gmail.com> wrote:
>>>
>>> A draft of a new Git Rev News edition is available here:
>>>
>>>   https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-38.md
>>
>> The draft has just been updated with 2 articles contributed by Jake
>> about rebasing merges, so I am cc'ing more people involved in those
>> discussions.
>
> I find this section of the draft pretty close to my own vision of what
> and how has been discussed, except for a few issues.
>
> [all quotations below are taken from the draft]
>
>> Some discussion about --preserve-merges and compatibility with scripts
>> (i.e. should we change or fix it? or should we deprecate it?)
>> followed.
>>
>>    Rebasing merges: a jorney to the ultimate solution (Road Clear)
>>    (written by Jacob Keller)
>
> What article by Jacob is actually meant here I have no idea, please
> check, as this one, and the RFC this refers to, was written by me, not
> by Jacob,

Jake wrote the article below the above line. His article summarizes
the discussions that happened following your email that is linked to
in the above line. The above line is actually the title of Jake's
second article.

> and it is the outline of potential method of actually rebasing
> merges that is discussed in the next paragraph, so it likely belongs
> right after the next paragraph:
>
>> After the discussions in the above article

Here "the above article" means the Jake's "branch -l: print useful
info whilst rebasing a non-local branch" article above the current
article.

>> Sergey posted an outline of a
>> potential method for actually rebasing a merge (as opposed to recreating
>> it from scratch) which used a process of git cherry-pick -mN of the
>> merge onto each topic branch being merged, and then merging the result.
>
> The reference to:
>
>     Rebasing merges: a jorney to the ultimate solution (Road Clear)
>     (written by Sergey Organov)
>
> belongs here, if at all.

You call it a reference but it is actually the title of the article
that Jake wrote. Yes, it contains a link to your email, but that is
just because we want to make it easy and straightforward for people
who are interested in all the discussions to find them.

It has been like this since the very beginning of Git Rev News. For
example in the first edition
(https://git.github.io/rev_news/2015/03/25/edition-1/) the first
article was contributed by Junio so you can see "Promoting Git
developers (written by Junio C Hamano)" where "Promoting Git
developers" is a link to the following email (yeah the link is not
valid anymore because Gmane is no more) that I wrote:

https://public-inbox.org/git/CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com/

> In addition, I'd like to see a minor edition to the following:
>
>> Sergey replied that he thinks the solution produces the same result as
>> his updated strategy.
>
> This has been said in the context that assumed lack of conflicts during
> application of both strategies. Something like this, maybe:
>
> "Sergey replied that he thinks the solution produces the same result as
> his updated strategy, at least when none of the strategies produce any
> conflicts."

Ok with this change.

> Next, this is very close, but not exactly right:
>
>> Further suggestions to the strategy were proposed and tested, ultimately
>> resulting in Sergey proposing the addition of using the original merge
>> commit as a merge base during the final step.
>
> This was not an addition, this was a fix of particular mistake in the
> original RFC that has been revealed during testing. I didn't get it
> right at first that it's original merge commit that must be used as
> merge base, so my original proposal ended up implicitly using wrong
> merge base, that is the one computed by "git merge-base U1' U2'".
>
> Something along these lines may fit better:
>
> "Further suggestions to the strategy were proposed and tested,
> ultimately resulting in Sergey proposing the fix to his method,
> specifically using the original merge commit as a merge base during the
> final step."

Ok with this change except for s/the fix to his method/a fix to his
method/ as I think it reads better with "a".

> I'd also like a reference to the final fixed [RFC v2] be added right
> here. The reference is:
>
> https://public-inbox.org/git/87r2oxe3o1.fsf@javad.com/

Ok to add this link.

I just pushed the changes

Thanks for your comments,
Christian.
