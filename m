Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2F5E1F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 21:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732777AbfJVVQr (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 17:16:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44970 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfJVVQr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 17:16:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id q21so11408265pfn.11
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 14:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=64ZKeIa0GzfLE8QA6OC+HU6WzaJ4+tlU47KbC0T7Rqs=;
        b=m4NNug5fKjtflaKo9rCQqZo8PEpc/ozFCZDHM09iHgVdtiAbrEHLelEw/IcOETjHdG
         A9FEiObOeN7hnxKLJMoXhGRpDD2HLsfJL3kj+t7nM+nsmosQKVXQL6h2Zn3UQRGXInPC
         ZZdoCtNSYyF3BlukmTcN6jdd1uUROvhCyH2teKvy6hUhzCcRX/fHtl4yYpCpc0tpZFet
         s7w+QzQzjK22Hnd07G+tLrlEiUiI1X/KLJ+iwMW+YxwaHJAsHpO2L+upoVVsW7X6E3S6
         CjLxV85JXfgYc+zFEDvN1rSn41I+Tgnn4kP0h4SuNLwXs/dRYB2kOspjG7ElW11Dy9gm
         EijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=64ZKeIa0GzfLE8QA6OC+HU6WzaJ4+tlU47KbC0T7Rqs=;
        b=eRcT8dBsc5FY/p6HVuN4uS//31vMcTZWgSxcFeGbCH4WkGJQQAKx/T89nTY7D8z2UE
         jjaNJID5yqddVsrxEw81vV/vDhDbn//IIXIPeSESwX0lkEGOAWQ8DA9fMrnsWCZqjgHv
         1kVmh99nh1wPhxu/IYY3cwKU0eUFUif84W9P/l2u1EBwjqTfQWMu5G/hPu3gESlt3ID7
         k/5/T4rKneQNHhdJIzoptwA4TQXfbG5ZzqdW6a3RTbJ4/ys9Y8sS7O1kwwJqiI0snnCw
         3b/ts41m1ntTI8UDRfNbKxLa+ORR3QaGetKLkepcBcss8fn+QOs2nTaEYbNigZ0zLc07
         B1ZQ==
X-Gm-Message-State: APjAAAVQYr6KmPZ3ptJV1dkKfnZhOwH2Kq262O7hVgKZjAL0STe0A0c0
        T+RLXoq0B/YFtjv67wsrn6cHDQ==
X-Google-Smtp-Source: APXvYqy3IDxwh6/m8eSyNBjkALhNJuWLYbwnbRzpnPEEYZpDY42Gmf7L8UszG973H7o0fuJTpMZUXg==
X-Received: by 2002:a63:8f41:: with SMTP id r1mr1623668pgn.83.1571779004518;
        Tue, 22 Oct 2019 14:16:44 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id 4sm18968806pja.29.2019.10.22.14.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 14:16:43 -0700 (PDT)
Date:   Tue, 22 Oct 2019 14:16:39 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     peff@peff.net, git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20191022211639.GF9323@google.com>
References: <20190913205148.GA8799@sigill.intra.peff.net>
 <20190920170448.226942-1-jonathantanmy@google.com>
 <20190921014701.GA191795@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190921014701.GA191795@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 20, 2019 at 06:47:01PM -0700, Emily Shaffer wrote:
> On Fri, Sep 20, 2019 at 10:04:48AM -0700, Jonathan Tan wrote:
> > > Prospective mentors need to sign up on that site, and should propose a
> > > project they'd be willing to mentor.
> > 
> > [snip]
> > 
> > > I'm happy to discuss possible projects if anybody has an idea but isn't
> > > sure how to develop it into a proposal.
> > 
> > I'm new to Outreachy and programs like this, so does anyone have an
> > opinion on my draft proposal below? It does not have any immediate
> > user-facing benefit, but it does have a definite end point.
> 
> I'd appreciate similar opinion if anybody has it - and I'd also really
> feel more comfortable with a co-mentor.

I know early on in this thread about Outreachy projects some folks
expressed interest in comentoring. Is anybody still interested in doing
so?

For context, I've been in contact with 3 applicants who have either sent
their first patch already or are getting ready to (and have needed some
involved discussion or help) plus another few applicants who have
inquired and may or may not send patches in the future. I've also
received quite a few mails outside of my timezone working hours (I
usually am awake/working 18:00GMT-02:00GMT), which I feel badly about
not being able to respond to in a timely fashion. If anybody wants to
comentor I would be so excited to have the help :)

 - Emily
