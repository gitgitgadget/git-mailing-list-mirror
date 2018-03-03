Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C31DD1F404
	for <e@80x24.org>; Sat,  3 Mar 2018 17:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbeCCR3p (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 12:29:45 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46664 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751800AbeCCR3o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 12:29:44 -0500
Received: by mail-wr0-f196.google.com with SMTP id m12so13117517wrm.13
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 09:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2QIaGqgFbMkWf9tS530jjuyWOmRurABd7y4Y2zaE3cA=;
        b=TTBbKGiwDurCXSMNLMIi0DfWdVCt2AT2v6tJSe6qQlnEjv9j7l2T1pIJ1B6D0wubME
         cxBMDjqMrU7KYbRKi+rMfBHzvLqnGaluOT6yKyfBveBGphvmvomVTtQXX68visyRauKi
         HTO2Xn3KxYGRzwk9WdZaacW8GtSmejIHB5la/rYyvKbk4vAAT5UTnIIwrjZuQmNpzUkO
         ak5QCN8h7dk4TAKUcniyMtq7kipWEhplwo+AleFaI+jWT+htl8qn8diPzB0v2wJvXZEd
         0ed/TnniFZ3JgzqXC6viZIchjcZ8NPBFxzLw7xYFL7CFFLbA2cDhn+deh58s/5LKQ/v5
         vBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2QIaGqgFbMkWf9tS530jjuyWOmRurABd7y4Y2zaE3cA=;
        b=ErAk85iom5TTRCC6HcN5mOnlMcWongNQ2I6ZHUAAvUEo2cRFPRYUZnLsjUGpCb3zWt
         8dKMQankrBpzQcttpT1J5OuTlg4no9QePtDnVf72zuzLBe/OurdfCopzXyjP03uk+r4U
         f3qVUg4U62wJVA0hrp1lherLloqaDt0YU8kO64uu4ptd31ZMU3GxztNh7AULfRL73TEo
         4o80VQVQpPaDSZysERKagfT222JIbhpRLRgyMLkLHPirnZBKfZmuyMO2vSrbcyKkssFE
         OwgPK0ya/cOWT27qtooWvKFF82oVqvIUUw5PO+KKUKpqzemqmfeNzaHFBWiQ9okOsIg1
         E51g==
X-Gm-Message-State: APf1xPBZ8WSa5A+X0KTd9TbYb2Inpl9yJvx5ZZcijvq8DJB0eO4XpACq
        0ALQaG7jcHRvzWGN7CB9l2A=
X-Google-Smtp-Source: AG47ELsCeaXCHlD4EkenUFQmk2XOGXtSFmVZ+IosAg2B7NS/qA2rn9dfp+TTsuva1dP8ugH6ZOVvsw==
X-Received: by 10.223.154.49 with SMTP id z46mr7943216wrb.143.1520098182723;
        Sat, 03 Mar 2018 09:29:42 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id s21sm7594123wra.45.2018.03.03.09.29.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 09:29:41 -0800 (PST)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
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
 <CA+P7+xrkAKB621Na3V-tE9cMtbnADX94FvTrJf26SkQYbXqMGw@mail.gmail.com>
 <f26cdbe2-1bc3-02ff-7b99-12a6ebab5a70@gmail.com>
Message-ID: <39aebd06-6022-7803-e27d-c1793fd72955@gmail.com>
Date:   Sat, 3 Mar 2018 18:29:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <f26cdbe2-1bc3-02ff-7b99-12a6ebab5a70@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/03/2018 19:14, Igor Djordjevic wrote:
> 
> > > It is interesting to think what it means to faithfully rebase a '-s
> > > ours' merge. In your example the rebase does not introduce any new
> > > changes into branch B that it doesn't introduce to branch A. Had it
> > > added a fixup to branch B1 for example or if the topology was more
> > > complex so that B ended up with some other changes that the rebase did
> > > not introduce into A, then M' would contain those extra changes whereas
> > > '--recreate-merges' with '-s ours' (once it supports it) would not.
> >
> > Unless the method of merging was stored, I don't think we *can*
> > correctly automate resolving of "-s ours" because all we store is the
> > resulting content, and we don't know how or why the user generated it
> > as such. I believe the "correct" solution in any case would be to take
> > the content we DO know and then ask the user to stop for amendments.
>  
> I agree with Jake, and for the exact same reasons.
> 
> That said, I`d like to see what mentioned '--recreate-merges' with 
> '-s ours' does (or would do, once it supports it), would you have a 
> pointer for me where to look at?
> 
> But if that`s something yet to come, might be it`s still open for 
> discussion. I mean, even this topic started inside original 
> `--recreate-merges` one[1], and hopefully it can still bring 
> improvements there (sooner or later).
> 
> [1] https://public-inbox.org/git/cover.1516225925.git.johannes.schindelin@gmx.de/

Ok, I went through mentioned `--recreate-merges` topic again, and I 
think I see one crucial merge commit handling difference.

In there, as it is at the moment, merge commits are really to be 
_recreated_... as the option name seems to imply ;)

In terms of interactive rebasing, it actually comes from "todo list" 
becoming much more powerful, gaining ability to create (new) merges, 
which is wonderful from the aspect of history rewriting (what rebase 
is all about).

But, I would argue it is a different concept from actually _rebasing_ 
existing merge commits, being what we`re discussing about here.

Yes, you can use merge commit (re)creation to "rebase" existing merge 
commit so the end result is the same, being what `--recreate-merges` 
now does, but that only goes for some (uninteresting?) merge commits 
where not knowing the deeper context of how the merge commit is 
originally created is not important as no content is to be lost (due 
to missing that deeper and utterly unknown context).

But as soon as you try to do that with more complex merge commits, 
like holding manual amendments and conflict resolutions, it doesn`t 
really work as expected - which I demonstrated in my original example 
script[1] in this topic, original merge commit amendment lost on 
rebase, and even worse - that happened silently.

Now, not to get misinterpreted to pick sides in "(re)create" vs 
"rebase" merge commit discussion, I just think these two (should) have 
a different purpose, and actually having both inside interactive rebase 
is what we should be aiming for.

And that`s what I think is important to understand before any further 
discussion - _(re)creating_ existing merge commits is not the same as 
_rebasing_ them, even though the former can sometimes be used to 
achieve the latter.

Regards, Buga

[1] https://public-inbox.org/git/bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com/
