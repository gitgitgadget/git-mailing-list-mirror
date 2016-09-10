Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF74B207DF
	for <e@80x24.org>; Sat, 10 Sep 2016 00:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750976AbcIJARU (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 20:17:20 -0400
Received: from mail-ua0-f178.google.com ([209.85.217.178]:35345 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbcIJART (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 20:17:19 -0400
Received: by mail-ua0-f178.google.com with SMTP id 35so2404996uaq.2
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 17:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TXyP6hsWNfdxFfaJydertCmRrCt6huhniGJBz2DVfRc=;
        b=ot2l+2Kqwz/G5KqAlbvuqv679007+alycgft6ytUHK6u++MuAYfVndSwTSxplxDZk1
         SE7RL4HdpDV+5zt5w5by6pgs4QdY2JghUxPy87kjWRTu32rHZPPoTdtHmEs3a2hVRQU8
         +ZOmpMajhyLFpGH8vNRaQfvTYDdNrNRfViP4b+Gf31WACSxktYgRXn5OnMXhTu1ZJAVo
         MmRzXtOVDV6scLyg2h7KJpfu0vMypAAbb9UjaVjVbCQS5wA749XwRxE5oFrFKq3AxZ2M
         DugsOAg1GL7O7b+5L8U9Wfxb3AATJV3oA28TXMgt/QIieQB+xCyzh5C2OAg8masdj9Ka
         CsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TXyP6hsWNfdxFfaJydertCmRrCt6huhniGJBz2DVfRc=;
        b=lsChRgvaVjtw5esKWBKiRue5MPezJfxgxXqtzAyjkzoTBlHKSVpSUHi9KyQmk7rqqd
         oPLRVjG3HIABBcxHX0YWxYyEfASSRm/ynkGljBbyqVzY07PrnWtWNJa6HKnOOSLHVoSa
         dH7qY3i65WMAPhBxGJGWxnQmykDbiK7flOohxSvSvNgfPWGt1klCX8hocQZvx3lHZaq+
         Y9Zh2jyO0WyA8HOcBZGOQ0aJ9CTsV50Vt5RP0LHwJvoqZFtWlz/N7GRUCqTXqT6U9zuQ
         QVuyg+hSbnRWcrIo6rKcT6zZtyT2C0fbz25KggatpF40Zy+6UfeVL9lbEa3haOKmAtp8
         DFxA==
X-Gm-Message-State: AE9vXwMr9pc4IR9PR3anIKnFRSkh5gOattFZsIOM5ZfuHMkmptIzuIsZiMqpHDAbsbWPE51oM8/ykeuhtFinPg==
X-Received: by 10.176.64.229 with SMTP id i92mr4476720uad.122.1473466638842;
 Fri, 09 Sep 2016 17:17:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.50.213 with HTTP; Fri, 9 Sep 2016 17:17:18 -0700 (PDT)
In-Reply-To: <CAGZ79kapz7PR7vO2oyWE8WygXr+hTSJeZfZgpyeERv+Z1jTjCQ@mail.gmail.com>
References: <CAG0BQX=wvpkJ=PQWV-NbmhuPV8yzvd_KYKzJmsfWq9xStZ2bnQ@mail.gmail.com>
 <CAGZ79kb=LyusFH6tGirGP9qK1k-cov2UubEbKPfeyPRThUsa-Q@mail.gmail.com>
 <CAG0BQX=FFWqR=45g6buujzK2jknx8aZnQoiV_m-QZhcx4Dd52g@mail.gmail.com>
 <CAG0BQXmyW-Hzdyj4rTviToEVbJ73d94P9GcfFVR6P2XCsA2t-g@mail.gmail.com> <CAGZ79kapz7PR7vO2oyWE8WygXr+hTSJeZfZgpyeERv+Z1jTjCQ@mail.gmail.com>
From:   Dakota Hawkins <dakotahawkins@gmail.com>
Date:   Fri, 9 Sep 2016 20:17:18 -0400
Message-ID: <CAG0BQX=ym399NzJZWk=emKfsPqKztDBeYS4+GXpYKhcTmtkJTQ@mail.gmail.com>
Subject: Re: If a branch moves a submodule, "merge --ff[-only]" succeeds while
 "merge --no-ff" fails with conflicts
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>, mwitte@ara.com
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> As you know currently the checkout doesn't touch submodules, i.e.
> you have to run "git submodule update" whenever the submodule
> changes. So when you checkout a different part of history, that moved
> a submodule, this will fail as the submodule still resides at the old
> place (and may have path name conflict with another thing)
> and is not there at the new place.

I _think_ (may be wrong) that you can reproduce this without ever
updating the submodules at all. I may be missing/forgetting something
in my config: I normally have global post-checkout and post-merge
hooks to run a submodule update, however I realized that and (I think)
disabled them for the second more concise reproduction I sent. I moved
them to a "no" subdirectory in my hook directory -- git doesn't
recursively look for hooks, does it? Anyway, I don't think that's a
difference in my case. It may be, I agree, if you happen to be
reproducing this issue locally in your working repository for some
reason.

That thought process makes sense to me because as I mentioned
initially these failures presented on our remote (bitbucket server, if
it matters) for a pull-request merge. I don't know for certain but I
don't believe the server's copy of the repo would need to update the
submodules at all, ever.

>>
>> Also, I'm not too familiar/comfortable with mailing list etiquette,
>> and I don't want to be a bother by continuing to ping this thread.
>
> Pinging is fine, as it is rather easy to ignore mails on a mailing list. ;)
> I just don't know if it increases likelihood of someone responding.

Apparently it got you on the hook! Thanks for taking the bait :)

Dakota
