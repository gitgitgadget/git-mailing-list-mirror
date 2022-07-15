Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F99C43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 22:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiGOW1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 18:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiGOW1a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 18:27:30 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB38065D4C
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 15:27:29 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id i14so10771117yba.1
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 15:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Km2sc8jaaURctr/0FF9esmj8Tze/iZfSbireITcUnHw=;
        b=KxbllFgFvfGV2Cfyjyb24bxDnOKCOnMtEmgx6YOJ6pRFMFoMIe93/FMf8hElL0DuNw
         m1c8eFzFLosRMTG2in8J3DfbFmbsWu3QlDWcFW7ecWtBKJ2MHQNQALL+SsdYF6X0lMRy
         jkLUgTfb49hizUiU7Y3YqPypEPDZZTQtZyuvD/oWnboLN4bTPmMr5yFcUsMsIEbNOi3M
         tgfg7HvEZn4Ln+MbSqWnWI8a+PlBge8xe2KGl2y83UAg1JQHteCmd3Ys1yKHWUwnw3me
         N8x+xA74iXjgnJB9XjWOewP7qf994gXTwAwlU8ZhkyGC43phxTTr+TV2GYHRE87Dk9zn
         s+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Km2sc8jaaURctr/0FF9esmj8Tze/iZfSbireITcUnHw=;
        b=5lDgbD26Lir6awQdc1oBD52Y+9I9ll4YrLaqCTF1Z8DL8N4waVLB09UVmNFQARHMKu
         4VDocC27G+rcksjOR9CnyBvFr+lqebdd19t1c0rAIJmXiLYwjb+zr3YeXeu4nGb9Z/MF
         iq7N+0QDhddqD6gzk2Yxl1eouAZdVHkG3WQ5fHgakOsja6lpCMNXP9SjUbwfQDhxnlQq
         kuYv3tV2MUFkwCiPgsOAV3zrjD0hHPgRUUS/1Ol3TLqaiLPDbhx5We7QH0/5hkO2evfa
         F7SUW3fqgdaBotlC1YWXFTwgVp2+KMY3MkyegSBD4FxEdGzjrqEuS7DuZ4je3zwPA6mP
         OxbQ==
X-Gm-Message-State: AJIora++AYlbBf7xK1WbPc3BqWx8kCJgFznfIup0nghVJrE5Z+zaw0pf
        ONmKYJlSu7nLXZFdLvxFo4dgb+VOjUlcXA/32yE9w8+bf4tVMg==
X-Google-Smtp-Source: AGRyM1ts2z09JwLA7XzPeJBqyMljjWq79AL/rTUShSX3DQPHkmEv+3hAz0jWxRAeVYhZGyecN25d0P+ng8FPLcvelQY=
X-Received: by 2002:a25:f508:0:b0:66f:3c5f:c39f with SMTP id
 a8-20020a25f508000000b0066f3c5fc39fmr15739538ybe.374.1657924048815; Fri, 15
 Jul 2022 15:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <YqjEAEPYEJMUx8Wu@nand.local>
In-Reply-To: <YqjEAEPYEJMUx8Wu@nand.local>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Fri, 15 Jul 2022 15:27:17 -0700
Message-ID: <CAJoAoZnXyyZZxexyEeNjTrOBq0FkJ+EVhYT8YeqHYLHnJ1xASA@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git Merge 2022, September 14-15, 2022, Chicago
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 14, 2022 at 10:23 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> Git Merge 2022 is happening on September 14th and 15th in Chicago, IL.
> The Contributor's Summit will be on the 14th. [...]
>
> Note that this year we're going back to having the Contributor's Summit
> take place the day before the conference. For the Contributor's Summit,
> the plan is to have an A/V setup for folks to join remotely where travel
> isn't possible.  I'll provide details on that as we get closer to the
> actual event.
>[...]
> Other than that, please be thinking about (and feel free to discuss in
> this thread) topics you'd like to discuss, or any general thoughts on
> the format, venue setup, etc.

Any chance we could open up a topics and voting sheet/doc early? Once
in a while I've been saying to myself, "oh, we should discuss that at
the contributor summit" and within a couple hours forgetting what
topic it was :) (I would say the thing I want to add to the doc ...
but I've already forgotten. I think it may have had to do with
libification, but I'm not sure?)

 - Emily
