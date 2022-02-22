Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839C1C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 07:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiBVHsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 02:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiBVHrv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 02:47:51 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7272668
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 23:47:24 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id q17so34969620edd.4
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 23:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r4Z9Ge95V+LtLeaEMVfOjApYXYzV0+Kx8X7ihcqLzt4=;
        b=WQQZIE5/VkpPjShmFbbaI+9w3jhekq/teVaDE0vGTkiIUl8r1fW6Yl4JipBEazK62l
         dfnZNzBJHUgZZ+xhiZpw8f7/0/zWRr4djBhPmGDyN7hBu0/4XEOPF0v9pOOVCx+zWNx9
         Bna9Xmb0xbLsBJ1UmrBGAPGz66+sP82sOhj5HlklqQd6OKL6msijijYTI2cnJF0cE0V6
         xvSJZhGHEEMzv4DJea72LLIO5NCa8aUs/4ZlcE69a6uMPN0M1CjncfrwB9cfV0XchF7/
         +A5LUDTXl0J7Y+JXcAACq3jDUGUP44QluxSa4eBkSHy8HV2tnFwiy0D7EampDYKRHVyK
         mS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r4Z9Ge95V+LtLeaEMVfOjApYXYzV0+Kx8X7ihcqLzt4=;
        b=XyvkFN6u2dgHVOhoF3y5Pd6PnYh96qR7Cm/G6m6eJhpdNoLKW9jb7Qlz0kT3pfwJ/M
         D+0kw6pZHboyAVy+D5lyu91CB4ro7/bXsarGTd90fULPdTLPVLvv6yTbDs3hq/U92VtG
         FKzRPutYkDNikVnnm9Lvkn3xcQn4XAh2bUeUknJMq7wOJ9WT+9GCPXzHEuc8OIv9ZC/G
         7lZ37NCWsgSqs1tHZG2AMmAptbhrqCHQhVmnMCWM/+GFqOos+aHjyktIbbJttSze6DNG
         vQPPHVz65UR4+nPG5Xqw74n+S74wQhV9V8QosyDDqXhoVIHVCn5OPezEQAylHEdSuP7f
         6l1A==
X-Gm-Message-State: AOAM530DTbdGWdFXNtmGZIloRnLm+mpbEPk/dLaKKvnaoyuLAsHyhmAl
        lrkoTcto/Df+ITg8LIoFQUmicaB+hJy6jvNwm+PlQeRoa0M=
X-Google-Smtp-Source: ABdhPJxsO4jfdrRd2/snY/MrRKzwOL49rRnJsVEIvV6GHRwD+Vs1pl8nYNLlMDj79cr8vf419ZIYuiL63KKXko8ySNM=
X-Received: by 2002:aa7:c7c4:0:b0:407:52cc:3b32 with SMTP id
 o4-20020aa7c7c4000000b0040752cc3b32mr25020939eds.397.1645516043259; Mon, 21
 Feb 2022 23:47:23 -0800 (PST)
MIME-Version: 1.0
References: <CAC316V7M8bziK207tuFbctAqDdz+GC8OGaxM+B0earJtqDvBSg@mail.gmail.com>
 <YhLvdjghyC+WQI6e@nand.local>
In-Reply-To: <YhLvdjghyC+WQI6e@nand.local>
From:   Shubham Mishra <shivam828787@gmail.com>
Date:   Tue, 22 Feb 2022 13:17:11 +0530
Message-ID: <CAC316V6Y6zCT1MACHnaXbh+EEmQPz4_fLRFdK90tBsdkX2h41g@mail.gmail.com>
Subject: Re: [GSOC] Student Introduction - Reachability bitmap Improvements
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thanks, I have started working on it. I have a little doubt, I can see
we are using pipe with other commands too (not just git).
I wanted to ask why we are only caring about error codes of  "git"
commands which get suppressed due to pipe. Not for other commands?

Thanks,
Shuabham

On Mon, Feb 21, 2022 at 7:18 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> Hi Shubham,
>
> On Sun, Feb 20, 2022 at 10:39:13PM +0530, Shubham Mishra wrote:
> > Hi,
> > I am Interested in Project - "Reachability bitmap Improvements".
>
> Great! I am excited that you are interested.
>
> > I am going through the blog [1] and I love the technique we are using
> > to fasten the queries. I have still not decided which one idea to pick
> > out of many mentioned under "Reachability bitmap Improvements" but I
> > think I will figure that out soon.
>
> Let me know if you have any questions about the projects listed there,
> and I'd be happy to add some more details. Alternatively, if none of
> them pique your interest, that is OK, too, and we can brainstorm other
> potential projects.
>
> > Can someone please tell me if a micro-project - "avoid pipes in git
> > related commands in test scripts" mentioned [2] is still available to
> > take?
>
> Oh, yes. Here is a command you can run to find some of them:
>
>     $ git grep "git[^|]*|\($\|[^|]\)" -- t
>
> There are some false-positives, but that should give you a good starting
> point to look for potential spots to touch up.
>
> BTW, re-reading [2], I wanted to clarify that "The git command should be
> on the left side of a pipe" is describing what we should remove, not
> add.
>
> I'm looking forward to your patches!
>
> > [1] https://github.blog/2015-09-22-counting-objects
> > [2] https://git.github.io/SoC-2022-Microprojects/
>
> Thanks,
> Taylor
