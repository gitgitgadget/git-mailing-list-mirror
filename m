Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09F821F404
	for <e@80x24.org>; Fri, 31 Aug 2018 08:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeHaMXH (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 08:23:07 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:54911 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbeHaMXH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 08:23:07 -0400
Received: by mail-it0-f52.google.com with SMTP id f14-v6so6101710ita.4
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 01:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2XCeqaODZ9cDD232fRHiHyv5AX9S+DAjhyPdGagJLWo=;
        b=mOc4AiWaqko2+eGKDOCjD2jbZhVWd1V4PTJUky+O6PxT2x6k4spbTMRGqhEPWPIQgy
         9brPweeQx7Jk3Ddw8/dGdTiA0baQIXyJwiQU6YwM6iCsB+5Fgc1j+XCZtu4Dd6tpemnt
         24BpZgFJL7mmTq1aOeVqadYQ05i74jyDwIhrEWRpxZORouoI+DhbYfTS1LzOyRZMWC7Y
         UT+q6PoRKb8uYoYae/LPqU6oiwJwYo3m4VivFkdhfB01zvzEj5fWHvGw8HWNL/Kua3I3
         uZ9xJjkfddXOuyldtFdPm83MF+9U7jebD/vtJ9R4IX2vOmMB7PhV+nl4MdcrrP2NV5d9
         4D9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2XCeqaODZ9cDD232fRHiHyv5AX9S+DAjhyPdGagJLWo=;
        b=kI5FLqZKhvS4ej2Kfz3FXaAS6CUNvpwvM/qkKl3JuKT4QqZyPofb4pwBgCiuKVWRLk
         WEEu6sL/6w+7myjFRJjJAm4FebXuqfub51UiS17ckkZyKqIth/RYmG4M/UMtkz6abnIp
         a6tsh40dE+ioaExo1V3+WAYgqSLK6ydCYbtcNNA81ZqqMeY6Ajluv3hv7ivk1Th1Nar3
         XMB4xEr3jo8pwhJf8jmI9pP/r7MJXBB3UHETspY2ROV2GqKmZ36WKsoFHhv4Fr0lTXE1
         Oc98LiesBGfB2ZaTg9387+98tMKD4XrI0h/DLdW2Vrx0Ob2ABjDe9WXLTonwC/VB3YrG
         yPCw==
X-Gm-Message-State: APzg51Bd2cO1CBKxtrLfEdIBDpV0rxtZBwAoTz5LuZ7p5QFBjQfBUKvg
        Iwkk0t/snjIbUh7ghXwI/77vZ1ypAnz8DTbQ/9Y=
X-Google-Smtp-Source: ANB0Vdavr8mPz/PeuoZfR6ZKQgD4Z+xpeAylbDplb1Ql1s0ln6maoleM8GdtE7AqSsa8KZv8IF09+A7s5ckCKE3pH84=
X-Received: by 2002:a24:cfd7:: with SMTP id y206-v6mr4460366itf.112.1535703410486;
 Fri, 31 Aug 2018 01:16:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22a7:0:0:0:0:0 with HTTP; Fri, 31 Aug 2018 01:16:49
 -0700 (PDT)
In-Reply-To: <20180828151419.GA17467@sigill.intra.peff.net>
References: <20180828151419.GA17467@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 31 Aug 2018 10:16:49 +0200
Message-ID: <CAP8UFD0SYECLk--7JsZkxBdQeJPuG1Ut5GMLsCJHqM+jG7C0jQ@mail.gmail.com>
Subject: Re: Git in Outreachy Dec-Mar?
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Aug 28, 2018 at 5:14 PM, Jeff King <peff@peff.net> wrote:
> The Outreachy application period is set to begin on September 10th for
> interns participating in the December-March program. Do we want to
> participate?
>
> Details on the program are here:
>
>   https://www.outreachy.org/communities/cfp/
>
> If we want to, then we need:
>
>   1. Volunteers to mentor. This is similar in scope to being a GSoC
>      mentor.

I volunteer to co-mentor.

>   2. To get our landing page and list of projects in order (and also
>      micro-projects for applicants). This can probably build on the
>      previous round at:
>
>        https://git.github.io/Outreachy-15/
>
>      and on the project/microprojects lists for GSoC (which will need
>      some updating and culling).

Ok to take a look at that.

>   3. To figure out funding (unlike GSoC, the intern stipend comes from
>      the projects). I can look into getting outside funds (which is what
>      we did last year). Worst case, we do have enough project money to
>      cover an intern. Last year[1] opinions were that this was a
>      reasonable use of project money, but of course new opinions are
>      welcome.

I can also look at getting outside funds.

My opinion though is that it is probably better if the Git project can
use its own fund for this, as it makes it easier for possible mentors
if they don't need to look at getting outside funds.

Thanks for sending this,
Christian.
