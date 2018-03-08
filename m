Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59E761F404
	for <e@80x24.org>; Thu,  8 Mar 2018 15:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755618AbeCHP4X (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 10:56:23 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34948 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754052AbeCHP4W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 10:56:22 -0500
Received: by mail-wm0-f68.google.com with SMTP id x7so232916wmc.0
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 07:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pzf7ra+RR/7kbWX2Y4LGw95XvAu08o26lT0rTvCB+e4=;
        b=PN7KznhmhQl2MeykFjsg8CpnWzS6r/EqSEC110xWZvhAdci41eLhRNpR7UngeIQloJ
         Fe6uxUSnZWnFUKZKzqB9ClfEYqU5SBTqyfjR2gJ/tNhUrSsvxtNNoFuYAeNR5dbVJJby
         E/shhuh6rfegZrXIUESvsW+i4LJqgQVEVc9sbI92Lw5BQoOJ6nq9A9shx4bLxgOwSxa6
         yX9L4RMlJ+eYxbzqAkP0TCpcbgIQobTlxu4St8iM2WjzN87fKUZebXhY64ZPkVHGP9Bs
         pcZYmtsb2oNRN5w3IKmXUSTGpUe++toa5nvMJ+TOZsjPf6gfaSqRy+Qs6f5LZ9OpCPS+
         oNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pzf7ra+RR/7kbWX2Y4LGw95XvAu08o26lT0rTvCB+e4=;
        b=LB1BMU5vAdY/OLwKMGEatZdHd026thixfoxpegmO8fo1rEPiBg4ZNSm5bJsPlNwLqi
         pMmXzWA3WmT/dIICfC7eOLz9sXKdWRDWEjuUa0nYaBrAdKPaSzowyNKEYYe1dOBiscIv
         6A9VrypWdwTFqI4zTjaQ/9MxZLirvPcmvHhget9bE2BgZar/AmOFDY3+ebRPXgr85Y89
         oxETYxBA3dHn3P5vN97PfUg4NWIS75FJKGywREJGQQpIOvixkLoQS+4/re+U3SH4i7eJ
         lAdvkUy3Yc16fcuh1Y2OO/YGO//9bBOdWq9ZwKbJTVzvXmuhJCkmOlGFZZOsF1D6MTPy
         7DwQ==
X-Gm-Message-State: AElRT7HmBBwjlSrAtcbbXxhWGfE+xG9Y8ak8TqvzuvInvIlYMGwfzxVN
        PCofm73F0hFqBoMMhR/jAw8=
X-Google-Smtp-Source: AG47ELuxmLW9UP7XM93Ed5MeY/oxqueGNh+cZunSaZT4dH1Gmx5mJTvxM0rSohTzZTOj87G/chUVAQ==
X-Received: by 10.28.130.1 with SMTP id e1mr17101619wmd.45.1520524580946;
        Thu, 08 Mar 2018 07:56:20 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id b81sm12793281wmb.36.2018.03.08.07.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Mar 2018 07:56:19 -0800 (PST)
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
 <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <f3872fb9-01bc-b2f1-aee9-cfc0e4db77d6@gmail.com>
Date:   Thu, 8 Mar 2018 16:56:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip and Johannes, 

On 08/03/2018 12:20, Phillip Wood wrote:
> 
> I did wonder about using 'pick <original-merge>' for rebasing merges and
> keeping 'merge ...' for recreating them but I'm not sure if that is a
> good idea. It has the advantage that the user cannot specify the wrong
> parents for the merge to be rebased as 'git rebase' would work out if
> the parents have been rebased, but maybe it's a bit magical to use pick
> for merge commits. Also there isn't such a simple way for the user to go
> from 'rabase this merge' to 'recreate this merge' as they'd have to
> write the whole merge line themselves (though I guess something like
> emacs' git-rebase.el would be able to help with that)

Hmm, funny enough, `pick <original merge>` was something I though 
about originally, too, feeling that it might make more sense in terms 
on what`s really going on, but I guess I wanted it incorporated into 
`--recreate-merges` too much that I tried really hard to fit it in, 
without changing it much :/

And now that I said this in a previous reply:

> The thing is, in my opinion, as long as we are _rebasing_, you can`t 
> pick any merge strategy, as it doesn`t really make much sense. If you 
> do want a specific strategy, than that`s _recreating_ a merge, and it 
> goes fine with what you already have for `--recreate-merges`.
> 
> On merge rebasing, the underline strategy we decide to use is just an 
> implementation detail, picking the one that works best (or the only 
> one that works, even), user should have nothing to do with it.

The difference between "rebase merge commit" and "recreate merge 
commit" might starting to be more evident.

So... I might actually go for this one now. And (trying to stick with 
explicit mappings, still :P), now that we`re not married to `merge` 
expectations a user may already have, maybe a format like this:

  pick <original-merge> <original-parent1>:HEAD <original-parent2>:<new-parent2>


Here, original-merge is a _commit_, where original-parent and 
new-parent are _labels_ (in terms of `--recreate-merges`).

Everything else I previously said still holds - one is allowed to 
change or drop mappings, and add or drop new merge parents. Yes, in 
case user does something "stupid", he`ll get a lot of conflicts, but 
hey, we shouldn`t judge.

p.s. Are we moving towards `--rebase-merges` I mentioned in that 
other topic[1], as an add-on series after `--recreate-merges` hits 
the mainstream (as-is)...? :P

Regards, Buga

[1] https://public-inbox.org/git/bc9f82fb-fd18-ee45-36a4-921a1381b32e@gmail.com/
