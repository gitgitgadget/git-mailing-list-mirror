Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59EFF20248
	for <e@80x24.org>; Thu, 18 Apr 2019 06:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388082AbfDRGyT (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 02:54:19 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:35874 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfDRGyT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 02:54:19 -0400
Received: by mail-pl1-f179.google.com with SMTP id ck15so707213plb.3
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 23:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c0TNE96LUALB+aUtT9qpRAc2D66DARECgaGFayiWpy4=;
        b=No3ooF7IgtPtqs5M3Dkbj2q2TM/NodODEVt6RK+ltwYU3YEwD+Fsm+yYZj8rgroIYm
         IYHXXAjDVTO2mCCviaCEsmEuEgeQaQFuT4adbDVmld8rHiTcAQFmEDuxRiVDvHbOCcZW
         dBT0w3FprWM1MH0wq2gpv2vBJ0EJEpUsXpPkad2Bj6OPDoKtTlLqGwP/jNZu/np/Q8o6
         0Pl51/7zNxruDAT+kM6X6N8kt3HbFOlFHdrmzS1mu0q7a1M3mCfZCc8MY3l3ZdIUhLVz
         aVo/lXqU5tYMmml2qtF7dFHjuWrL3uGrttX3OmD7Pda9Oo+JeemUkYpsPPy4h/mOCskq
         /Z5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c0TNE96LUALB+aUtT9qpRAc2D66DARECgaGFayiWpy4=;
        b=FTIIIfIqdzcyO5Q0MyQ09UEB1p9JcJ7LnyHK3O6UbNNqAaUmvbJ+Z9cBgOrVdStSuo
         TECXW4w1j2l6EChTd5c958N1bPi6c7ON7gClvNVykDAgT9nanbmymkAqWRY3hbL1Zp2/
         msb3/+kYWK5HesB1suyPY7A0ndtWozkUGLUaa3wcpiDeEh24xtH1kMCpgx9IBghQg9zz
         c9O3f9gDLKcOMavxmF9u87VOmrDfK2nMSwJrMRwI6qVDiVWxDeUWwyt8F5oAwp7dwJbN
         cmQSIX6NvfwQcTK8FkgjfxBeVt3Ld3GPzrAvrQmIxa5p64OtxdeOQVegjSnAUWZp0GO+
         dHMg==
X-Gm-Message-State: APjAAAXp6KsYELZ9QhAnSnBztIC1AX5C6/Q7SjnE/Y+USEH/pYRJm+0f
        8BMYay5Q0aqgTwdt8EzMCgEdsw==
X-Google-Smtp-Source: APXvYqzOPPKQMfShctt17GCuJ+m8Mpf/2m8BCq815qizRxkwubzFiKuULxvNnOzPWlViGu18N/8kxA==
X-Received: by 2002:a17:902:781:: with SMTP id 1mr92197956plj.300.1555570457740;
        Wed, 17 Apr 2019 23:54:17 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:f465:c3b3:d727:caa5])
        by smtp.gmail.com with ESMTPSA id e193sm1283926pgc.53.2019.04.17.23.54.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 23:54:16 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Wed, 17 Apr 2019 23:54:15 -0700
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2019, #03; Tue, 16)
Message-ID: <20190418065415.GA87809@D-10-19-246-32.dhcp4.washington.edu>
References: <xmqqef62ozny.fsf@gitster-ct.c.googlers.com>
 <20190417023706.GA86159@Taylors-MBP.hsd1.wa.comcast.net>
 <xmqq7ebtkx7p.fsf@gitster-ct.c.googlers.com>
 <20190417054250.GA98165@Taylors-MBP.hsd1.wa.comcast.net>
 <xmqqwojtjgzf.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwojtjgzf.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 17, 2019 at 03:14:28PM +0900, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >> That's this one
> >>
> >>     Date: Tue, 9 Apr 2019 19:13:06 -0700 (1 week, 3 hours, 23 minutes ago)
> >>     Subject: [PATCH v2 0/7] harden unexpected object types checks
> >>
> >> which I think is what has been queued and what is listed in the
> >> message you are responding to.
> >
> > Ah, perhaps you could clarify some confusion I have about the "What's
> > Cooking" emails (or at least point me somewhere I could un-confuse
> > myself).
> >
> > This topic is in the "Cooking" section with a "-" (which I recall means
> > that it's in 'pu'), but there is no "Will merge to ..." line below it
> > from you.
> >
> > That makes sense to me, but I'm not sure whether or not that means it's
> > queued. Do you say that a topic is queued once it's on your pu, or once
> > you have written "Will merge to..."?
> >
> > Thanks in advance for your clarification.
>
> Hmph, I guess I shouldn't use the verb "queue" if it implies a lot
> more than there is to it.  I create a topic branch out of a patch
> series on the list at some point in the iteration of a series and
> merge it to 'pu'; I can say "I queued the topic to 'pu'" after doing
> so.  The verb to me does not mean anything more than that.

I thought that there was much more to it than it seems there actually
is. Thank you for clarifying what is meant here.

> The fact that a topic is queued on 'pu' does not mean much.  It can
> be taken as a sign "Gitster thought that it may become 'next' worthy
> material, either as-is or with further polishing and replacing."

This matches my understanding that 'pu' is a precursor for 'next' and so
on.

> Once a topic gets discussed on list and it seems apparent that there
> is a concensus that supports it, I may mark the topic as "Will merge
> to 'next'" in the What's cooking report, but I may not realize that
> the list already reached such a concensus and may leave it unmarked
> in the report.
>
> So "this has been battle tested in such and such environment" and/or
> "this round was reviwed by the thread here and they were supportive"
> etc. is a very appreciated response to the "what's cooking" report
> to help me merge the topic down to 'next'.

That's quite helpful to know in the future.

For this topic in particular, we've been running a nearly-identical
version of it at GitHub for a couple of weeks now. It went out smoothly,
and hasn't caused any trouble since. (In fact, quite the opposite: it
fixed the bug that caused me to look into this in the first place. That
is, the repository that SIGSEV'd after a `git rev-list --all --objects`
no longer does).

So, for clarity I think that this can be considered "battle-tested" and
ready to merge onto next.

> "I have sent a reroll at ..." I typically hear when I miss a
> rerolled version and what is listed is still from an old iteration,
> hence my "Eh, you are pointing at what I have queued" reaction.

Understood, and thank you again :-).

> Thanks.

Thanks,
Taylor
