Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCAE01F404
	for <e@80x24.org>; Thu,  8 Mar 2018 16:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933415AbeCHQFQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 11:05:16 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34424 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754580AbeCHQFP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 11:05:15 -0500
Received: by mail-wr0-f193.google.com with SMTP id o8so6223400wra.1
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 08:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eUxwLnmlwv0dPT1VgoOlJnXs4gQB0wvpqmZZc1Wzp3U=;
        b=bEvNbZAuimAyfT1hTK0YOrMYoAlZWPyLK+e6DrCDD6UT5zGfBsp1uyt3Pja1cTriM2
         ye2BoUhFAw7FGuD8rYOLr8jEI9I2AcKv8Z57V8usSjCpNvTem/VG4Yw7js2sWZCPEg9X
         ah/AR6iaGfUfR5TSUHVijdbkXx90nioxAQV+X/9KIcJGia/yiDB8ABGU+xv28YILah1X
         iJe+R0At018XOaxPGES4D3KbJMc/xyUI1zuW32mLqrKjhxtCOidmxfiZ4cIraooxmi+R
         FKL2FIgFSfFTox+LZMD8N4z6IAjbgUSLVcYrqf/FMlGD+OxALU0XMMLI8QxSyUX5W8ua
         fxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eUxwLnmlwv0dPT1VgoOlJnXs4gQB0wvpqmZZc1Wzp3U=;
        b=f9g8SnZqo7YeHbOqgFI71lrySLW5P3L9fZFx2PeH4twjo9MVjEXlZCdR2jYvxnJYFr
         DOsBPvNJfv1nhXWyJgs52qbzPhi5QfxJn9QQOgQLUeegIRnKZIAjg7/YS3fAaf/OtECR
         IrOm8b78BwOx0y+YpRP+LLsvA6uur8Eg7wJAbxO8aRmNS4ktoaqX6AJjC9XAtpVTXRuj
         nVKYidA0X5lqP8rQRtcOvlFGQQR1W+75y822zZsASJ4CqsiQZXH082GTdXwMdE4spV1P
         US16XPENYTtr+ehQKU2apf/kf6J0ZjfbBa+96a9oht49MMFQxHcFIviJbGiyupZhoh8A
         giPA==
X-Gm-Message-State: APf1xPCqPgb9hM9OZcxIWECdYOxtUg9j1fyWJRZ7TNro10itY8jMt70s
        xXbsW3tmCxaOAPO8R/9eNnM=
X-Google-Smtp-Source: AG47ELvIPg7zPB1yK1S8XytdTZ7uf0U0d0aAUXodQ12AoruXxIlH6WhvxN497vV8hrxfT3KUSO7RVw==
X-Received: by 10.223.192.74 with SMTP id c10mr24652249wrf.145.1520525114275;
        Thu, 08 Mar 2018 08:05:14 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id f127sm12210567wmg.46.2018.03.08.08.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Mar 2018 08:05:13 -0800 (PST)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
To:     phillip.wood@dunelm.org.uk,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
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
 <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net>
 <483674f8-4097-a374-c8f3-cf56cbb92042@talktalk.net>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <29bc6661-1d78-8f89-194e-1dcc9d88c34e@gmail.com>
Date:   Thu, 8 Mar 2018 17:05:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <483674f8-4097-a374-c8f3-cf56cbb92042@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/03/2018 13:16, Phillip Wood wrote:
> 
> > Side note: I wonder whether we really need to perform the additional check
> > that ensures that the <merge-head> refers to the rewritten version of the
> > original merge commit's parent.
> > 
> > [...]
> 
> Oops that was referring to the first side note. I think fast forwarding
> is a good idea. I'm not so sure about checking that <merge-head> refers
> to the rewritten version of the original merge commit's parent any more
> though. Having thought some more, I think we would want to allow the
> user to rearrange a topic branch that is the parent of a merge and that
> would require allowing a different parent as the old parent could be
> dropped or swapped with another commit in the branch. I can't think of a
> way to mechanically check that the new parent is 'somehow derived from'
> the old one.

Exactly, we must not depend on exact parent commits, but on parent 
"branches" (so to say).

And that is why I think explicit mapping would be pretty helpful (if 
not the only approach).

> > I did wonder about using 'pick <original-merge>' for rebasing merges and
> > keeping 'merge ...' for recreating them but I'm not sure if that is a
> > good idea. It has the advantage that the user cannot specify the wrong
> > parents for the merge to be rebased as 'git rebase' would work out if
> > the parents have been rebased, but maybe it's a bit magical to use pick
> > for merge commits. Also there isn't such a simple way for the user to go
> > from 'rabase this merge' to 'recreate this merge' as they'd have to
> > write the whole merge line themselves (though I guess something like
> > emacs' git-rebase.el would be able to help with that)
> 
> Scrub that, it is too magical and I don't think it would work with
> rearranged commits - it's making the --preserve-merges mistake all over
> again. It's a shame to have 'merge' mean 'recreate the merge' and
> 'rebase the merge' but I don't think there is an easy way round that.

I actually like `pick` for _rebasing_ merge commits, as `pick` is 
already used for rebasing non-merge commits, too, so it feels natural.

Then `merge` is left to do what it is meant for - merging (or 
"recreate the merge", in the given context).

I tried to outline a possible user interface in that other reply[1], 
elaborating it a bit, too,

Regards, Buga

[1] https://public-inbox.org/git/f3872fb9-01bc-b2f1-aee9-cfc0e4db77d6@gmail.com/
