Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 157F91F404
	for <e@80x24.org>; Wed,  5 Sep 2018 18:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbeIEXPq (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 19:15:46 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36206 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbeIEXPq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 19:15:46 -0400
Received: by mail-qt0-f194.google.com with SMTP id t5-v6so9335520qtn.3
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 11:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=voGEsaDIaqS4Cec6JNpX4HjdYXTgMLKKAU2aKFyhskw=;
        b=UmwnLkGJsVc9s9q10TKHOsxK+eHMVGAU1mVHViXYyAJnBDcimCpzvWYoV/AnAbE6Bx
         C6IDdieqiAZ7m0UjX6+qx0fy0mMn00T7l4iukoTgC1eBqtM0uxFZZSYLfdL0SNe7dqPL
         bS+yL2Q+0Kk1hX2IVAQb0gh85Uptlq1b7XCf/ONHbpcjgY2EkhWY7sHeGnNwIulU1DTQ
         WWpD/15B3j278UZLKnnpHHcGeV2a+Zz0t+eXY3SnkfqjRG4FNdP7jo5HWSqMTeaEYds+
         P8CqKvEQrznvaWmqEZJIXSqMOr9Oj8y3FOtzjviSepf8w3+SvgB2RoVnjFG3Jdr6wDyG
         sEHA==
X-Gm-Message-State: APzg51BZ2Vnd6bXmkcD7MUt4bsoZ1u1ro37IPFTvUgkQK5DQ7fy1rr1M
        Wd0p8mL8TMCu+hf4eOSGr7TvPaHLqfMJ4UJMubY=
X-Google-Smtp-Source: ANB0VdZqwEjTorwVoj0LhHUcepWGsepx9n4oLMDKtzMqdmV4mFW1UwaIso8+oNMjlJr0qRWjJT1iJXh7SWQ1IPAHAww=
X-Received: by 2002:a0c:b88f:: with SMTP id y15-v6mr33891136qvf.203.1536173060592;
 Wed, 05 Sep 2018 11:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqmusw6gbo.fsf@gitster-ct.c.googlers.com> <CAPig+cTQLED6P2AWrxU=pvNc6WzO-5YVsPNh3fg28LdZqU15AA@mail.gmail.com>
In-Reply-To: <CAPig+cTQLED6P2AWrxU=pvNc6WzO-5YVsPNh3fg28LdZqU15AA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 5 Sep 2018 14:44:08 -0400
Message-ID: <CAPig+cT-qZPRg2gjKU2o6TAzZDpdXm-mg6yk-LfsL+_a9jC5dw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2018, #01; Tue, 4)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 5, 2018 at 5:14 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Sep 4, 2018 at 6:36 PM Junio C Hamano <gitster@pobox.com> wrote:
> > * es/worktree-forced-ops-fix (2018-08-30) 9 commits
> This description mischaracterizes what these changes are about. [...]
>
> So, perhaps rewrite this description like this:
>
>     Fix a bug in which the same path could be registered under
>     multiple worktree entries if the patch was missing (for instance,
>     was removed manually).

Bah, typo: s/patch/path/

>     Also, as a convenience, expand the number of cases in which
>     --force is applicable.
