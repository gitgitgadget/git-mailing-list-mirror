Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41DD11F404
	for <e@80x24.org>; Thu,  8 Mar 2018 16:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756077AbeCHQVk (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 11:21:40 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37477 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754578AbeCHQVj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 11:21:39 -0500
Received: by mail-wm0-f65.google.com with SMTP id 139so367167wmn.2
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 08:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jX9mdZqEIhSQ0Jc848aznE/eYQfYut0IihpexmipzeM=;
        b=b2Ghcx1nqHNTdwu7VL31BoSMAe/itS+59DPhPd7NKQpoK3zyJiJyvNoCcxh/ctvZnS
         f2RSokjY7+4Coy1ddpTyDC3OZdeJsWevyXMqB9LB63qarrv+8rxF1Bw9pRIIVKqK7Kq1
         veBXd48v0FbRgnjrR+hYlra2zalvKDRWRg4J4hkjlLAHgFkTvQY5ZKyLqrBxNtdLfHXP
         ZvlTd14mkM3wSspN8igf9GmkFmMHVKDjk4BTymv9a+n3KkHdg9d86G8mA8JuLo6rsqt7
         7dx1MS5D8eYzWjfoIWw5D7MqVDdh88ZRuqC2rGt4NEPmjEKeOfXsN4Bp06PkDAaCDEWE
         2Qyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jX9mdZqEIhSQ0Jc848aznE/eYQfYut0IihpexmipzeM=;
        b=BZmu0DfuahBbOF30WwuY5l8quMu/JmUp6Yb60/ncKm2sY4C6Acf+nT0Hb6QCuEI2WR
         KOL089Q3at3nhaQozpAmbTzRHHp2ooxgLHgwH4U240viLH6SjaFLLxMk+O9x8OjiZOeM
         aW3UTieAJvshJ/zgFZIrkKqPfYTQayWlJKC3Q7vqRWK8ovpsUK3QzrqD3/4h3NA9Q+rs
         kpPMUcDIXOkvRyynrEhk+OEbMLeuV8lBH//nebfOwYu8PdPIdgaJFImanjSpN/TH31p8
         96uXMLYOKakvPukMk8XNMPM7TcG6CVm+ru8ywtExq1Q3Jin6tbPwZ4jnAFzq4ufo9QZk
         8SCQ==
X-Gm-Message-State: AElRT7Eh1AXVKa92+2NMrxXFWaw9YRtGHzSV1iXpbYopGs+TFp+IoLnX
        CBrKK96yMRLjjKRhOtdWCgBuzy72GUg=
X-Google-Smtp-Source: AG47ELtbsEhEaPsVDp9OF125XofjlEFo6OPDIsp9HEigIxBCpN+0Hh0Az/vkldFmm8bCJsjOwi+HTQ==
X-Received: by 10.28.194.2 with SMTP id s2mr17379329wmf.55.1520526097960;
        Thu, 08 Mar 2018 08:21:37 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id 35sm18930639wra.4.2018.03.08.08.21.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Mar 2018 08:21:37 -0800 (PST)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
 <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com>
 <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
 <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
 <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
 <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
 <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
 <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
 <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <2749ce78-8917-c821-6116-0c8d67b5e16e@gmail.com>
Message-ID: <230856e0-7056-6273-cdd2-2e9969927271@gmail.com>
Date:   Thu, 8 Mar 2018 17:21:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2749ce78-8917-c821-6116-0c8d67b5e16e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/03/2018 16:16, Igor Djordjevic wrote:
> 
> > Unless we reimplement the octopus merge (which works quite a bit
> > differently from the "rebase merge commit" strategy, even if it is
> > incremental, too), which has its own challenges: if there are merge
> > conflicts before merging the last MERGE_HEAD, the octopus merge will exit
> > with status 2, telling you "Should not be doing an octopus.". While we
> > will want to keep merge conflict markers and continue with the "rebase the
> > original merge commit" strategy.
> >
> > [...]
> 
> The thing is, in my opinion, as long as we are _rebasing_, you can`t 
> pick any merge strategy, as it doesn`t really make much sense. If you 
> do want a specific strategy, than that`s _recreating_ a merge, and it 
> goes fine with what you already have for `--recreate-merges`.
> 
> On merge rebasing, the underlying strategy we decide to use is just an 
> implementation detail, picking the one that works best (or the only 
> one that works, even), user should have nothing to do with it.

Just to add, if not already assumable, that I think we should stop 
and let user react on conflicts on each of the "rebase the original 
commit" strategy steps (rebase first parent, rebase second parent... 
merge parents).

I guess this stresses not using real "octopus merge" strategy even in 
case where we`re rebasing octopus merge commit even more (and aligns 
nicely with what you seem to expect already).
