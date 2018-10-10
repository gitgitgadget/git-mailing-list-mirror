Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFFC41F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 09:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeJJREZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 13:04:25 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46565 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeJJREZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 13:04:25 -0400
Received: by mail-qt1-f194.google.com with SMTP id d8-v6so4864264qtk.13
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 02:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v1DhEeoDB1xvYa1kRXtTbATRcpc0BuWxRAQjnrals5k=;
        b=Dt3OtUgvECPgtjfeJ77LFAtf6y2uAYjSCJj8+0QJ6a7zAOSpkmf6oOi8Sjxg6S8QZQ
         H/cFcTkyYSjWCMTEKIgh1fPT21ep7yuGp6csjwrbIdyUX266RyqQEMfxPiQUiaH+21R9
         YDyZL4hv3zkvzSJfJYVZ46TDWL5PXmqMgDH5LpfNTXJDbzduvf2mmIcS/7fVDycBHMW+
         CsTnibK+7qc115FlkKsiznM5/WB0Cq3iqej72UWUtgR15B0KzQTWFHHI0cxIfr8Mq8kd
         KMnK/34ajwzDLZiNxY5AfN75LEO24f9JoXOi/1yLbD8c8xSN5GwEXmSDijsQtWPtxGFr
         Xktw==
X-Gm-Message-State: ABuFfogxpY7cJKlOBaZiie/MtFMDtAJmuEXlTdxTZbFAvqCvXi+cbLNQ
        4gbtsqzA63YKq6fG+2D5z0ciFrc3SBZmMs5XPwU=
X-Google-Smtp-Source: ACcGV61BeLJO9sq4gV82lCC7sxQdTV+93tWqbhD8+WT3Oqr5z9KXb6mDMObVoMIJ/annNKp8hLgvITqsu988Kf1syyk=
X-Received: by 2002:ac8:73c5:: with SMTP id v5-v6mr3212985qtp.352.1539164583394;
 Wed, 10 Oct 2018 02:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <20181009182006.9446-1-daniels@umanovskis.se> <xmqq8t36q1k6.fsf@gitster-ct.c.googlers.com>
 <CAPig+cTp-cFKX2Kqj-yV7OtgmxDo7Mp7i0TUXU7JGYdgtbHiug@mail.gmail.com>
In-Reply-To: <CAPig+cTp-cFKX2Kqj-yV7OtgmxDo7Mp7i0TUXU7JGYdgtbHiug@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 10 Oct 2018 05:42:52 -0400
Message-ID: <CAPig+cToXS+pT4Kp0uejtRkvJdSmso9a_Q=Odrhox5htzqBvTw@mail.gmail.com>
Subject: Re: [PATCH 0/2] branch: introduce --current display option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     daniels@umanovskis.se, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 5:29 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Oct 9, 2018 at 4:59 PM Junio C Hamano <gitster@pobox.com> wrote:
> > My inclination is to recommend to:
> >
> >  (1) name the "show the current one" not "--current" but with some
> >      verb
> >
> >  (2) display nothing when there is no current branch (i.e. detached
> >      HEAD) and without any error.
>
> Sensible suggestions. Also, please documentation any new option(s) in
> Documentation/git-branch.txt.

Sorry, I was expecting to see the documentation update in patch 1 and
didn't notice that it was being done by patch 2. The reason I had that
expectation is that a change of functionality and the documentation of
that change are logically related, thus (usually) ought to be
presented together. Therefore, when you re-roll, you may want to
consider squashing the two patches into one.
