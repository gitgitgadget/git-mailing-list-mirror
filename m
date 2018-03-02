Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BF8E1F404
	for <e@80x24.org>; Fri,  2 Mar 2018 23:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934686AbeCBXdN (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 18:33:13 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39252 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934230AbeCBXdM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 18:33:12 -0500
Received: by mail-wm0-f66.google.com with SMTP id i3so5777822wmi.4
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 15:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eg7nKU9MLXGRNm56FJSqL0h4CUNmS48XWIk8752CcCM=;
        b=Ipk3+zrk4xK7RU9uiC/hiisOpXsy0L8ThbvKM9coViHHibqDS4wreEW/7N5VCoVDXs
         BVXWq1iEZkoerNJueDuqnhMcLDrHzjd5KPtlGVrj6C53DSAJwt+DQuVWnb2rG9eDAbay
         NlITAjK/GisI5rXVNXGVbDZkCXu9K9ILmc+fASYo+7Qz7SQfT8M58UDeI+4XVSTtOaK/
         t+cs9He/ilxJ9j36w8n6Sh+0+95dgzbBCwGhuzl7Wrhs7do3vA3/MfM7BPgspVRiMvjL
         AEfnCF/EraSPeosnHyXnGD+CDyANxQ5kHGB9WtVg4i0kGP6x9Ikxyb+UnvQF74OPIDkg
         5VSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eg7nKU9MLXGRNm56FJSqL0h4CUNmS48XWIk8752CcCM=;
        b=XWEQ2Vo+ppHIwZI0eb0gsbMrYmKyHh4v0pUu8m3DWwpfMKNMXhucxvFxIERhCS5zbP
         gxl5q7VQ4HbcfB3AW4DGQSvl8jWh70itPNboT/ATbbi8kzQp/VMY+jiEeZSjGvwhloz6
         lkrmF0+vyLCUR+uAk3fN8VvfOGeU8roBr9tKFgrrbY5dlMAAMrvY3644Q/uOIMdqMCte
         pnrKm148Vokx7cRNELpiaKmxCVl/H25h9ZLctk5/YxJxaZCbaLcI+AVuaQrd9O4crlaZ
         o0/T5JiGLUGQKdxAkbfzgl0DI3YH2u8jtAGnrN8WSMet+77LCfQaQVfyRRlnnujZ5FoZ
         OgsA==
X-Gm-Message-State: AElRT7GhWPIfC9Lw61KSz69Yb3BM72wI+havQ8ANuqXhbJyloZPPjj3E
        dM2E+0jFaZ4D92zJboP23Ck=
X-Google-Smtp-Source: AG47ELv0vjQ9zqkHs3jUfDe9sK4P/zx0IeOCO8J9Ms06ibU95cXa9k/hDEQu6W6mm5cws1HHtW12ew==
X-Received: by 10.28.6.205 with SMTP id 196mr3015890wmg.136.1520033591141;
        Fri, 02 Mar 2018 15:33:11 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id z197sm2681848wmz.24.2018.03.02.15.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Mar 2018 15:33:10 -0800 (PST)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
 <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com>
 <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
 <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
 <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
Date:   Sat, 3 Mar 2018 00:33:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

> On Fri, Mar 2, 2018 at 4:36 AM, Phillip Wood wrote:
> > 
> > > It is interesting to think what it means to faithfully rebase a '-s
> > > ours' merge.
> > 
> > I should have explained that I mean is a faithful rebase one that
> > adheres to the semantics of '-s ours' (i.e. ignores any changes in the
> > side branch) or one that merges new changes from the side branch into
> > the content of the original merge? In your example you add B4 to B. If
> > M' preserves the semantics of '-s ours' then it will not contain the
> > changes in B4. I think your result does (correct me if I'm wrong) so it
> > is preserving the content of the original merge rather than the
> > semantics of it.

Yeah, I understood what you mean, and I see you noticed that B4 
commit, for which I did anticipate possibly bringing up a discussion 
like this ;)

I agree with Jake here, my thoughts exactly (what I wrote in that 
other subthread[1], too):

On 02/03/2018 17:02, Jacob Keller wrote:
> 
> We only have the content, and we don't know the semantics (nor, I
> think, should we attempt to understand or figure out the semantics).

Hmm, I wanted to elaborate a bit here, but that sentence seems to 
summarize the pure essence of it, and whatever I write looks like 
just repeating the same stuff again...

That`s just it. And stopping to give the user a chance to 
review/amend the result, where he might decide he actually did want 
something else - so all good.

Otherwise, I would be interested to learn how context/semantics 
guessing could provide a better default action (without introducing 
more complexity for might not be much benefit, if any).

But in the end, I guess we can just discuss the "most sane default" 
to present to the user (introduce or obsolete that new commit B4, in 
the discussed example[2]), as we should definitely stop for amending 
anyway, not proceeding automatically whenever U1' != U2'.

Oh, and what about situations where we introduce new or drop existing 
branches (which should be possible with new `--recreate-merges`)...? 
"Preserving old branch semantics" may have even less sense here - the 
(possibly heavily reorganized) content is the only thing we have, 
where context will (and should) be provided by the user.

And I guess being consistent is pretty important, too - if you add 
new content during merge rebase, it should always show up in the 
merge, period. It seems pretty confusing to find out one of the 
branches "declared special" (even more if it`s based on uncertain 
guess-work), so when you add something to it it`s just "swallowed", 
as the whole branch is always obsoleted, for now and ever.

I might even see a value in such behavior, but only as a conscious 
user action, not something done automatically... I guess? :)

Regards, Buga

[1] https://public-inbox.org/git/f26cdbe2-1bc3-02ff-7b99-12a6ebab5a70@gmail.com/
[2] https://public-inbox.org/git/f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com/
