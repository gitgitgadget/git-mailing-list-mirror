Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5147D207EC
	for <e@80x24.org>; Sat,  1 Oct 2016 01:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752802AbcJABdr (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 21:33:47 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:35892 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752736AbcJABdq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 21:33:46 -0400
Received: by mail-io0-f179.google.com with SMTP id m79so75703764ioo.3
        for <git@vger.kernel.org>; Fri, 30 Sep 2016 18:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AhBx3mklMZJtpqDDrl8n5K4OhFLJ2JBlSxiqrgbaiRU=;
        b=Ek07mfbSxX71cMSOHrbrZ/S7HVNsnILQVFeMv2T5Sh6uQSWcV4Wwkxx+OJnXnrN61t
         jVmMfuhbEuzX1EAITDioJ82QUIWb+Kbx/nLw2xl3cPQ+jf++NDzBM12S5CBWFgzzj037
         NDvIw3RjoAeYik7ySi8vhuaBdrP8/qxY+TopEWQ3dRk1JRJoHQi3Yv/eto5rbBYQ9L8Z
         2+5TulI8qkqhg9OuKzUtewfGjragwAQWgZPVgeJ1ijjYMlPFKYvS4vKQz9B6KsZBrQrP
         bvNhZfqO/JQn9k+WYS5E5N+qydkTMbR4a8S7poWlJ4qnjpKN875jvCaBYgWsc2Q+NgMb
         m2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AhBx3mklMZJtpqDDrl8n5K4OhFLJ2JBlSxiqrgbaiRU=;
        b=QTEzykfYdqTxvKx/HUQwnRHXqaQppnnZuL2z8xgimpsRkt/ZTCqZ7J8af9pcqCzvhG
         IhzTwNufkpsIcbWqbVbg8G71Xpj66xMKLdcW+Mo4LIPmyhcKN5nCBze56M8VaVhrMe6n
         yFylv0FpJwqo98pJbftc8PxD86JF8yMFJtNRmhORmZm74mK6w+L7fo4Hclwqh1KPNhFd
         5fgjeL9gkFHsOIxTWqYUTBbH84rXB04ew5xpCazBzvEAZ0ZxFYoZfP5NrlCZGUwu6rtR
         7mp5CIi9n+ypJvKVUdyKvOEuosof6OcPuU6CV4yiTqrW+vR+hS6WgHMk9RqMZ7t9NThr
         PMXQ==
X-Gm-Message-State: AA6/9Rm/UFiTwRXZqN0PHJMS0szeAgjYpe/Kr9cJFIpyPMTnaTC0youJpPsDJlyuay+BlmTDtFLCiIuvOlSgwEoT
X-Received: by 10.107.14.72 with SMTP id 69mr11887244ioo.125.1475285625121;
 Fri, 30 Sep 2016 18:33:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Fri, 30 Sep 2016 18:33:44 -0700 (PDT)
In-Reply-To: <xmqq8tudkjvn.fsf@gitster.mtv.corp.google.com>
References: <xmqq8tudkjvn.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 30 Sep 2016 18:33:44 -0700
Message-ID: <CAGZ79kY6c-vwSP7-1Gz4jwWO-z_yT2oFbG4cgZb-JAae=Sk-cA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2016, #08; Tue, 27)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
>
> * jc/attr (2016-05-25) 18 commits
>  - attr: support quoting pathname patterns in C style
>  - attr: expose validity check for attribute names
>  - attr: add counted string version of git_attr()
>  - attr: add counted string version of git_check_attr()
>  - attr: retire git_check_attrs() API
>  - attr: convert git_check_attrs() callers to use the new API
>  - attr: convert git_all_attrs() to use "struct git_attr_check"
>  - attr: (re)introduce git_check_attr() and struct git_attr_check
>  - attr: rename function and struct related to checking attributes
>  - attr.c: plug small leak in parse_attr_line()
>  - attr.c: tighten constness around "git_attr" structure
>  - attr.c: simplify macroexpand_one()
>  - attr.c: mark where #if DEBUG ends more clearly
>  - attr.c: complete a sentence in a comment
>  - attr.c: explain the lack of attr-name syntax check in parse_attr()
>  - attr.c: update a stale comment on "struct match_attr"
>  - attr.c: use strchrnul() to scan for one line
>  - commit.c: use strchrnul() to scan for one line
>  (this branch is used by jc/attr-more, sb/pathspec-label and sb/submodule-default-paths.)
>
>  The attributes API has been updated so that it can later be
>  optimized using the knowledge of which attributes are queried.
>
>  I wanted to polish this topic further to make the attribute
>  subsystem thread-ready, but because other topics depend on this
>  topic and they do not (yet) need it to be thread-ready.
>
>  As the authors of topics that depend on this seem not in a hurry,
>  let's discard this and dependent topics and restart them some other
>  day.
>
>  Will discard.

So I just realized this is a big hint for me to pick up that topic; I assumed
you'd want to tackle the attr subsystem eventually, so all I was doing, was
waiting for your motivation to look at attr stuff to come back.

So what is the actual lacking stuff here?

Thanks,
Stefan
