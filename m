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
	by dcvr.yhbt.net (Postfix) with ESMTP id 77D6E1F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 16:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfJGQnT (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 12:43:19 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:36055 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbfJGQnT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 12:43:19 -0400
Received: by mail-wr1-f52.google.com with SMTP id y19so16157554wrd.3
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 09:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1QT/Gm4vX0q8ViWqOrKMYVnJYJYEnsoQdKB5MWwyQnc=;
        b=U6Fc+XtT8Q61QeYVpAWtYoPCUZhSA0XWezXgqZBADK8Ofbd8z+rny1KrOOHsmTkDlF
         ZgWmueh+3w7lxFqTmp/+dpio8Ye/oy8QovXxDIXbJDvo3wd3LtYfzse7JK+r0rF6VgAU
         R1NyTbonyf5VUcELHez8+QeS8j0cH1brBcaqIug+yQ3NmD4d8J5umoVa7UOA6Z2TIxKO
         rTWHnK2fcsc9oHRpfNDsnY0g71uhFB/5jA/psxD+pjBt7V7D1mLomHFZfnslGjDdVsMd
         ZS5nkDtiLuOUalNCj4kvU0R5CJTuAh6t6Ij06YK6GMGdBcg3KuEjUM1q/1jWsLRw7GQY
         LYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1QT/Gm4vX0q8ViWqOrKMYVnJYJYEnsoQdKB5MWwyQnc=;
        b=pxgJlBNq7SgKOTUh5UXx0GhFwnJeY+wf3d3G0UQaXWBRzudK5LD0L/l8Qy3Es+DPYj
         gl34C/hbhFgrrM0sdwfQQ5ZhoOEhBg3+DnuyK6CNvm/h1FRwNb31IGNbOCa83gbeSul8
         P003gRm3q164q5tyPUFVjfANAlmXWoy0E4RpEMh75Ijc+3+3NiiGajGLJ7SpG+vCkf3c
         UjjdLlJwFTfItiHKKCFA2pTGHphDQ3rSExJ1JjIpLIeEDOAyOeq8BLM/6kAx1XS8zWjv
         CtY7ajHCG93zobN+8VBpp85OcCDPOud3trWbz2lGf3/bYJAd/DtIcpoZ8PU8jDfKMIAs
         ihHw==
X-Gm-Message-State: APjAAAXAznJSeDiE+grJs3e6bptatHhnqsva7VWjC3X3rnnAngAHAX4N
        FYyiyj+sVbuHUonXB41AR6M2FvFX
X-Google-Smtp-Source: APXvYqxuEatkpac06b+7/+qz/uYDVfo9/kmOxrT0TURiQi7fzgjVKrQ/YjHrQyEGH92eX1HIRWtAzw==
X-Received: by 2002:a5d:46cc:: with SMTP id g12mr16896794wrs.101.1570466597227;
        Mon, 07 Oct 2019 09:43:17 -0700 (PDT)
Received: from szeder.dev (x4dbd6b2d.dyn.telefonica.de. [77.189.107.45])
        by smtp.gmail.com with ESMTPSA id 13sm137877wmj.29.2019.10.07.09.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 09:43:16 -0700 (PDT)
Date:   Mon, 7 Oct 2019 18:43:10 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Semyon Kirnosenko <kirnosenko@mail.ru>
Cc:     git@vger.kernel.org
Subject: Re: log -m output
Message-ID: <20191007164310.GA11529@szeder.dev>
References: <ee1f00fd-715c-5ecd-bc29-5e5a2de2d0f9@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ee1f00fd-715c-5ecd-bc29-5e5a2de2d0f9@mail.ru>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 07, 2019 at 07:14:25PM +0400, Semyon Kirnosenko wrote:
> I have a question about log command.
> Probably I'm just missing something but anyway.
> I can illustrate the question on the repository of Git.
> Let's look at revision 1ed91937
> It is a merge based on pair of revisions a9572072 and 294c695d.
> According to blame these parent revisions have different content for
> delta.h file.

I'm not sure what you mean by this statement; what blame command did
you run?

> But when I get log with -m flag for merge revision, I can't see that
> file in the list of changed files.
> Why?

The contents of 'delta.h' is identical in both parents of that merge:

  $ git diff a9572072 294c695d delta.h
  $
  # no difference

So 'git log -m' does the right thing by not showing 'delta.h'.

