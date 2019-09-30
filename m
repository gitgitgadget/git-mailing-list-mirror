Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3D901F463
	for <e@80x24.org>; Mon, 30 Sep 2019 08:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbfI3IHc (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 04:07:32 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:37344 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfI3IHb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 04:07:31 -0400
Received: by mail-wr1-f46.google.com with SMTP id i1so10094925wro.4
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 01:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kRckqbMXYSN8ejcAbp5Ep4BMWy5bxZDXeX/gc+rBWW4=;
        b=SMGMOVV9o1iXc6yChVEUJfZaVXY/x7FRl1GjM+rpjB5AuL9giCTAY1OkPxjdt0uSZJ
         wN/YNai74Z5HcYW1Jv/T7sBFBvpN+qo+h8FjQyPAjlt6wYYcbR1t7EGHahVqX+/3uX1l
         0DeLb6E+KrHAHU7Q52r+fefqDERebLpnYZNQd3b5KiXawFT8NeWwVxXQXDal7ggXFWNV
         lbiUhP9LfI0kfve6zHWW7aK/POto7Xzu6lh+OdpTjd5fYr+GCjTqVUtizRVeNW3g6Txk
         bZ+wZy7FcurTchrSz7XBB1S5DuFvc+fWNCd6o99KfRCuTZ6HkIf7G2hcpyLmXgqP3s66
         IVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kRckqbMXYSN8ejcAbp5Ep4BMWy5bxZDXeX/gc+rBWW4=;
        b=mSDS2U0R8EsyfZsGkDCKOs+R17TJ45TTkU+zqz5tfLLdBtBd0DYXQlXQiq1m3dB5jj
         K2cgABLHhXy7bRhi2jqXnL7cOIfubZoEEHe3UzCsTOLzoe+xH1D1tS64HDeBtMIDx7CH
         F28CdypuEaUXgkJwDux1Pw/I6+dJ3BU8v7GYLoeszXEjAZRRAcXb1C4rjuifomxscVMV
         zyQQ2pyOwDNT0gCgoGURL8KxDMoSNS0Cz77P83WF3qWChXn1Indx7BUV19/poWN9sHac
         5HNLSEvbFoKmU/iZONlzCkK+MdB9cjaJljIKdsyPt5ELACP+HzBWroqcyiefVSUo3Gia
         MAdA==
X-Gm-Message-State: APjAAAVs6MPkyjt/BZOBO4cNHhpTXm2r07EREcDZgfm3zZ1FaBN4C8Gx
        FdE4cv8eH5dyi/bVrfPmqYw=
X-Google-Smtp-Source: APXvYqzF066A7zORPnqNRoZFnL7MpRwBk8Rd2jpEt9OraTdT/9Hrnb935fXUIxWmnZVHI0t7Y54v/w==
X-Received: by 2002:a5d:69c7:: with SMTP id s7mr11888520wrw.295.1569830849304;
        Mon, 30 Sep 2019 01:07:29 -0700 (PDT)
Received: from localhost ([2.31.128.161])
        by smtp.gmail.com with ESMTPSA id l9sm13737132wme.45.2019.09.30.01.07.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Sep 2019 01:07:28 -0700 (PDT)
Date:   Mon, 30 Sep 2019 09:07:27 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Bi-Weekly Standup - Time/timezone in calendar?
Message-ID: <20190930080727.GF11444@cat>
References: <a56e5ebe-53ba-5f20-5606-b4b17dc660b5@iee.email>
 <20190925143247.GD11444@cat>
 <xmqqk19skg24.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk19skg24.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/28, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> >> I thought it was to be 1700 UTC, which currently is 1800 BST her in UK, and
> >> 1900 CST in Europe.
> >
> > That's my recollection as well, and what the calendar should say.
> > Thanks for flagging this!
> >
> > I don't know.  I'd be happy to keep it at 17:00 UTC, but that might be
> > a bit early for folks living on the west coast.  I don't have a strong
> > opinion on this, but I'm happy to update the calendar (or not
> > depending on what we decide) once the decision is made.
> 
> By the way, this is sort of off-topic, but should I add this to
> tinyurl.com/gitCal (or even better, should I add you as another
> editor of the said calendar), so that people have one fewer
> calendars to follow?

Yeah, I think that would be awesome, thanks for offering.  One less
calendar should definitely make things easier for people (and give the
standup some more visibility).

And I'd be happy to take care of adding/updating the events if you add
me as editor to the calendar.

Thanks!
