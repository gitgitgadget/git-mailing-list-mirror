Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE69F1F463
	for <e@80x24.org>; Wed, 25 Sep 2019 14:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730916AbfIYOcv (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 10:32:51 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:42768 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfIYOcu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 10:32:50 -0400
Received: by mail-wr1-f48.google.com with SMTP id n14so7227092wrw.9
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 07:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+sSLHI5L0uaNl3mCFndieYAPZYKdmDufG0QArf5LnB4=;
        b=TSZXyEQAIE0i91lGNxlww58K06R3uhVUF5gvPFRYBa9+5oWu8DTZQm5f80eX8M654v
         Rmn6neuDtSuRebrbkIhTGwAu1PozjRs3mKGzN0YLQbWtOgmPeqNuuRSX0SFqp6GiSRY5
         DXOq5Hg+7mscUVqzJLgSmKhLfnGxZywsiea04Q4q7t5E391mgfoTQFgiDUy0ZEiGk2tX
         k/jloJ7Lu6YDIn6lXARssDMLs5E52CdCgAQGLaM3mvmg8lMUyWmU3lfs4Qu3mOvaYxuI
         m+GYbzOSUCbU9L/X2uZty13w0L2rPsyK//iU1V8wNQDtYHxkj5761SZ3ZXoM8yapaVPI
         fxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+sSLHI5L0uaNl3mCFndieYAPZYKdmDufG0QArf5LnB4=;
        b=ANHyI3ZJaLP7WsXVXfOospKuriM5ir7rdbMM4bclPmBvp1SX9eSB6q2sFemoVqhb36
         K9sngG3h/BMxoZuc9g30QwMM9i8QvvUGG3ZXNzuyUC06iU2xBcIqRu/YyqHmBb+VE3gt
         n9N3oxbLZuRPqGDQ0u1owaSetuoAAXGowWBxUkC3bdiUyyNBgT+uhLYHM+QFjuHwiYzo
         lTsBMLaOW2u9jyUkG71oTeNyqzVw+ggBuue3dcvEECdWFUUs7lexjLZ93D7IHenhMQNX
         XOU8kkFczS2iXFAZ0VwAD0aDlZTZuqZrAjfXZpS/aFVfQTg1sWQSwzT0FmmLWAnvvTFM
         HWtQ==
X-Gm-Message-State: APjAAAWkQGiUDUjeblMeadXgookvR/6P+MV/I8+Y14FU2+hfuBX8SEo5
        bPkhZFtZyYoT2bE5Fi1bXeI4KB/X
X-Google-Smtp-Source: APXvYqzerLvvz4EVesyU0z3EFuTb5QSJ6yABhJmtLLabbATSxDQff+tC9pkDG8svs8fmKBeKIaGlJg==
X-Received: by 2002:a5d:5552:: with SMTP id g18mr9631982wrw.386.1569421969190;
        Wed, 25 Sep 2019 07:32:49 -0700 (PDT)
Received: from localhost ([185.53.225.150])
        by smtp.gmail.com with ESMTPSA id v16sm3988136wrt.12.2019.09.25.07.32.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Sep 2019 07:32:48 -0700 (PDT)
Date:   Wed, 25 Sep 2019 15:32:47 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Bi-Weekly Standup - Time/timezone in calendar?
Message-ID: <20190925143247.GD11444@cat>
References: <a56e5ebe-53ba-5f20-5606-b4b17dc660b5@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a56e5ebe-53ba-5f20-5606-b4b17dc660b5@iee.email>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/25, Philip Oakley wrote:
> Hi,
> 
> At the Virtual Git Contributors Summit we discussed (#13) the bi-weekly
> standup meetings (mentioned in the Git Rev News edition 55 under
> 'News/Various').
> 
> The Git Events calendar [1] that's linked from the Rev News doesn't actually
> say what time zone to use for the stand-up start time, so at first glance
> one can get confused by summer time and national time zone differences.
> 
> Currently it's saying (when clicked on, via 'more details')
> 
> Git Standup
> Monday, September 30⋅6:00 – 7:00pm
> Every 2 weeks on Monday
> 
> I thought it was to be 1700 UTC, which currently is 1800 BST her in UK, and
> 1900 CST in Europe.

That's my recollection as well, and what the calendar should say.
Thanks for flagging this!

> If I hover over the event (have to restart the calendar), I (depending on
> view) do get an indicator in the lower left status bar that
> "Events shown in time zone: Coordinated Universal Time". but with a 5pm
> indication in the calendar sheet.
> 
> Is this google calendar trying to be too clever, or should "1700 UTC" be
> included in the event details? I don't use Google calendar except for
> occasional reference.

Yeah, I think the embed view of the Google Calendar is trying to be
too clever here.  I did set the event up to be at 17:00 UTC, and I'm
not sure why it showed up otherwise for you.

I have now updated the event with a few more details, including that
it is happening at 17:00 UTC, and added that information to the title
as well.  Hope that helps!

Also replying to your last question in https://github.com/git/git.github.io/issues/394#issuecomment-535030810:

> Also given Dscho's comment at the summit about late evenings, are we
> changing the time for those dark winter nights soon to come (N
> Hemisphere)?

I don't know.  I'd be happy to keep it at 17:00 UTC, but that might be
a bit early for folks living on the west coast.  I don't have a strong
opinion on this, but I'm happy to update the calendar (or not
depending on what we decide) once the decision is made.

> Philip
> 
> 
> [1] https://calendar.google.com/calendar/embed?src=nk8ph2kh4p5tgfcctb8i7dm6d4%40group.calendar.google.com
> 
