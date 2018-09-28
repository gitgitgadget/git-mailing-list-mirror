Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92FDB1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 16:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbeI1XU5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 19:20:57 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:33833 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbeI1XU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 19:20:57 -0400
Received: by mail-wm1-f51.google.com with SMTP id y3-v6so2264093wma.1
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 09:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=UpALi1z0PO+d9RjPiy8GFXP9JQJ4C63kR09TORv1t+M=;
        b=qn19l0wyGMlnX98/Pv5M62gP/eNLECJUvtl0fXRjEpBLx5g8kXDLMqWfPOIbr+hWIL
         O1UHWPrs8UdTQUPjEUWvy8UhQO98dpT+5Qjf/mPllduB5PyhlYyxZt1xV5EfqskdgIQC
         m+oQ3nvx26j6Q3u8Y7f4XTtwOY5kIm11L74Q4yvzxAZhH/AjF/B67CCcFFOr374vlkbq
         TVbtyHKfqKfS78JNjhX3Ns8O51ctW23ojWYeXv6DPzSYmSt625LG/b8YNEeCOVKzwXlv
         5/nPnc7FvBd2nCtMXzd175Zq0hytMhr+qupO3w00vOQlTnuaTe0k0fAPdLjgnys1Qb48
         D0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=UpALi1z0PO+d9RjPiy8GFXP9JQJ4C63kR09TORv1t+M=;
        b=q4F8mg9vNRpTjP6zj3qq3Ux95j0u2ASFyitKEuhl2YvnLHORwq0b4Xv3yGa+wa8eu9
         zpNNjoMnHjcQQPtzad/cTTvP/o9wOppAN4XqexVsP46jVqcphZM9WGam4MwnlZ1Do+yp
         6xz094HRAQmt4Ib+vVdUjyiAtj+rmjuHfhd/2sCWOAB6wYziacnRDgtJUziwh3jYHq4b
         BWCFzHqHsr1rHgV2dWoViI+ZPGK4uxAq3gTx076e3RNrsotIBQGsV+o7XWp0QVG9jMtA
         BLXHq6eXRSCiHWxAgnff2giqhNYrej1f8SP4DQDYeWZ18nun7J/usAU+CQZ717IX3XsX
         s8SQ==
X-Gm-Message-State: ABuFfojRlEWNiMHvvaHPoR7ckVPSBvFMqLVeUmz39ZgP3t0z3xZRjuLU
        ElYb5JOKR1OQ/hWB+ntzMdE8EAQo
X-Google-Smtp-Source: ACcGV61bX0tbUxZiM9BIgrQfYqCOWOIL/r3mgi9MsYmn9K/4jlEVWk3dX+CiYfUTfgcjypPWHqsmdg==
X-Received: by 2002:a1c:318b:: with SMTP id x133-v6mr2528497wmx.145.1538153776399;
        Fri, 28 Sep 2018 09:56:16 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g2-v6sm1790792wmh.16.2018.09.28.09.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 09:56:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] git.txt: mention mailing list archive
References: <20180926134717.GC25697@syl>
        <20180927055018.6683-1-martin.agren@gmail.com>
        <20180927063735.GC220288@aiede.svl.corp.google.com>
        <CAN0heSpG2jewXuzcZQAeFydW4zanzymSGVqVz2u0myW3Z7Wcrw@mail.gmail.com>
Date:   Fri, 28 Sep 2018 09:56:14 -0700
In-Reply-To: <CAN0heSpG2jewXuzcZQAeFydW4zanzymSGVqVz2u0myW3Z7Wcrw@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Thu, 27 Sep 2018 12:35:53
 +0200")
Message-ID: <xmqq1s9def2p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

>> Hm.  I think this encourages a behavior that I want to discourage:
>> assuming that if a bug has already been reported then there's nothing
>> more for the new user to add.
>
> It was my hope that all of these could be inferred from the above text:
>
> "I'll just drop a mail anyway."
>
> "I wonder if there's a known solution to my issue."
>
> "I wonder if this is known and I can provide some more details compared
> to the original poster."
>
> "Maybe I can find some thread where I can just say '+1'."
>
> But what a language-lawyer reading says is of course a lot less relevant
> than what a fresh pair of eyes (yours) reads out of the text. Thanks.

I agree with your reading; the most neutral mention "archive is
here" is not very friendly because the readers do not know what we
want out of them being aware of the archive.  "Ah, I may find a
solution already there" was the reaction I wanted to draw by saying
"If you want to check if the issue has been reported", but any of
the above is a good reaction.

And from that point of view

>>         See the list archive at https://public-inbox.org/git/ for
>>         previous bug reports and other discussions.

is just as good, and there is not a big difference between that and

>   If you want to, you can see the list archive at, e.g.,
>   <https://public-inbox.org/git/> for bug reports and other discussions.

this one, at least to me.

> We might also conclude that trying to delicately word-smith something
> that doesn't scare off reports is tricky, and we're better off just
> avoiding doing anything which might raise someone's bar for reporting an
> issue. I'm leaning more and more towards "it's not broken, so don't fix
> it"...

Yup, in short I think any one of the above three is good enough.
Let's just pick one and move on.  Unless somebody sends in an
improvement that can be applied readily, by default I'll just "git
am" the one Martin sent, as that is the easiest thing to do ;-).

