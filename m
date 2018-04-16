Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96B1B1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 15:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751172AbeDPPwy (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 11:52:54 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:34515 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbeDPPwx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 11:52:53 -0400
Received: by mail-wr0-f173.google.com with SMTP id d19so27455670wre.1
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 08:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DNYZ+LjS6Db/L1z6o2a5809c1tGMHW5GEXlz/RMqUA4=;
        b=Vqk56daqo27zWEU7kRvBnRCpMGNJ7AE4hTOTQ18m6k+K0jp1qwmBTPBQd3R5mthgcL
         tmmgu9lKD+IK+tXqd+hoYdqgCv7s75CWkuIgsFRuyb8YZHCkT5WZ3Wx96l/hYSeaxGOO
         SRgSU+3USK9KX2rlTyYBPgIIwJ2ZPWbhHP1LQNeWvnhO4way3vjnzOJKQSpvC5JmWMHU
         ITO4QLlRfT/XXDiGnkv0ImiXF71iy0gAgJuYg6rlmtqJTxBNLdPxfcjsSUBdmAzdjgAS
         n/TBcSW5ZF8vbggmHPJRn/2NmmeT8log0ZXy51gvgXL5hYz5DAfQC24qjkeptA4MGfPy
         COuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DNYZ+LjS6Db/L1z6o2a5809c1tGMHW5GEXlz/RMqUA4=;
        b=A2wnDuCdqfR4q91dbcE0tSY0ZQJDWzo4sNnI4VtwCXGHqYG1BPYjicRhxcDfQHthLZ
         n0LBFnhZp6SKCbyb02u1LJbPIaSFDyM4aWr8nkZlP3xsnfoveRY8HFbgb9vURN6wFzm6
         vcYu5zCgDrMG+MJaVEXg0QUki+iUWhjTCa7gmM16OAeOi7DVzyMMC99DdqW5MiJqWIiN
         YMeO+gMPvcpjTSovmvR9BkijEzBZdwH5l+VLO6fWc5chsBYx4/ZIxCxV19ZHX6hybUDz
         4i3aAGSQbBxYEo97dZlak+XmAy0z+SiUYLE4YhYpa1u7pHWUWKY4Akn/v1oIB8buirTx
         LsMQ==
X-Gm-Message-State: ALQs6tBmG5F9HKDsG9cLVXKuK0issz/jv9u4VkwmzpYN0BpEwC4f+Y3z
        AaZ1lteW2fieew3LfRSNQ9rMphOI6yxWFN9loqc=
X-Google-Smtp-Source: AIpwx494t/hypTvMjuQTvZOc4hMBdGdPhtUIypJKAieMySryGBlbHfhitdq0GYlPKC14NA+XYE2twOCOLkQxM9IGVpw=
X-Received: by 10.80.171.72 with SMTP id t8mr1711428edc.133.1523893972235;
 Mon, 16 Apr 2018 08:52:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.180.180 with HTTP; Mon, 16 Apr 2018 08:52:31 -0700 (PDT)
In-Reply-To: <87in8rz65t.fsf@javad.com>
References: <CAP8UFD0DagacfeismKoVgo=O1guRUV=u1=EbbwRyrY3g1MeQ8Q@mail.gmail.com>
 <CAP8UFD1vFM8k-1Po=2QXZdBOuCca1Dg_FGaPnSi85hKp1je54w@mail.gmail.com> <87in8rz65t.fsf@javad.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 16 Apr 2018 08:52:31 -0700
Message-ID: <CA+P7+xqLeO_OSURv+Zhw_2=DP6Gx3+C=rdA3MkCYzLxtVO4WMQ@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 38
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <worldhello.net@gmail.com>,
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

On Mon, Apr 16, 2018 at 5:29 AM, Sergey Organov <sorganov@gmail.com> wrote:
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
> by Jacob, and it is the outline of potential method of actually rebasing
> merges that is discussed in the next paragraph, so it likely belongs
> right after the next paragraph:

I believe he meant that the summary on git rev news was written by me,
that's all :)

>
>> After the discussions in the above article Sergey posted an outline of a
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
>
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
>
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
>
> I'd also like a reference to the final fixed [RFC v2] be added right
> here. The reference is:
>
> https://public-inbox.org/git/87r2oxe3o1.fsf@javad.com/
>
> Thanks a lot!
>
> -- Sergey

Yep that all sounds right to me also.

Thanks,
Jake
