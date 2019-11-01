Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DE5D1F454
	for <e@80x24.org>; Fri,  1 Nov 2019 09:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfKAJtW (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 05:49:22 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40508 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfKAJtV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 05:49:21 -0400
Received: by mail-ot1-f66.google.com with SMTP id d8so7886433otc.7
        for <git@vger.kernel.org>; Fri, 01 Nov 2019 02:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+qeZtF75NW5P1AiXVNwAt15VESyYnz+D1x++8hYL50E=;
        b=Sjc+kA1R6eDSsqIrxqg4kTaeC8EQ3du+8rNtdWNhnvEX2ArI5ZyTGzNT2XCNi0V+W/
         CTqizu5DU1lEXJPenL7VIFGuQkueWXYuvQj7dJklHhvy9tGkZHlU7osQs7yMu+ISv/Su
         wrOeuDZ1lZvEJbY832aAo+igKP+DOHmGS+9xywl4LadSZVeDeyLphPSc+arquY+ZE1dG
         V1Ws3rCyhMo4TeRK1XOwNuHYuEnZfn9qLy8XmGDQHi5PZdQjxr+SznnCkBaQpaSGEtjD
         ig+WIpmdBle/gtV+9q8XPy6KSLs0ML4rcFptB4rN5eU/jUblmz+3Qh6fNpWuEzYmeXhZ
         t3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+qeZtF75NW5P1AiXVNwAt15VESyYnz+D1x++8hYL50E=;
        b=IpguhDeSn49UfZK3l+KuH4zVbBFZ6tS4f3vmkaSs+cETSmingVahlxlzFtcyOegeaY
         n5rnnKV2TVyWj1GPLI7bQwyDSrl8w25DpEU1ybftXc2WMDip3hB08ky59vmOfQJ8Pzyo
         ZeeXCSF4YUBuXVcol/MggUdXRflFvuEvH8uxTmBf/kesP8f8zZ6lBYO0no/JwBcYYXqQ
         Tn6HCha3alQQuite2XXoCPlcwKHXw3aq6fvChEghjQKro3E8k0nDTaU3iqLaqsbj+PLB
         VmR0TjTCCYF8lBYyCOsbodTim4FyHhoayLrieTBeD9HYzyY11BXYOsRvdU3476gC62ua
         YsFg==
X-Gm-Message-State: APjAAAXC2FW53ZafEcMfs7zVaAaDTQ+GJqySzPEV2l+O6TII7WLJxA9R
        xBEOF+xsRGARWjgjBAQqpWXlgm7qrC/aE1UdLvw=
X-Google-Smtp-Source: APXvYqwo6mEsPmS53qXmaZVapSgLZGMwojGP3UHIYA9M5ZZNz0jHmgku79f7cVmJKGZ6799ACDKLXjNxFT358iyUr+U=
X-Received: by 2002:a9d:4801:: with SMTP id c1mr3600383otf.32.1572601760879;
 Fri, 01 Nov 2019 02:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.441.git.1572554506.gitgitgadget@gmail.com>
 <70f10fe44716e50765a9d8f7794116f390f09dbc.1572554506.git.gitgitgadget@gmail.com>
 <20191031225310.GA211076@google.com>
In-Reply-To: <20191031225310.GA211076@google.com>
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Fri, 1 Nov 2019 10:48:44 +0100
Message-ID: <CAN0XMOLDZo06Xa-Q9qVrVNk_J3+b2sP5e30f=_9s3nUw-B_JvQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] fetch.c: fix typo in a warning message
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Ralf Thielow via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Do., 31. Okt. 2019 um 23:53 Uhr schrieb Jonathan Nieder <jrnieder@gmail.com>:
>
> I wonder what this warning is trying to say.  How would I go about
> triggering this message?  The comment before says
>
>         The relevant upstream is the fetched branch that is meant to
>         be merged with the current one, i.e. the one fetched to
>         FETCH_HEAD.
>
> So is this about when I'm fetching with a wildcard or something?
>

The message shows up when multiple refspecs/branches are passed,
like

$ git fetch --set-upstream origin master next
From https://github.com/git/git
 * branch                  master     -> FETCH_HEAD
 * branch                  next       -> FETCH_HEAD
warning: multiple branch detected, incompatible with --set-upstream
