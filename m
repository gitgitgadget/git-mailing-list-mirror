Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B22051F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 10:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeJNSAT (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Oct 2018 14:00:19 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:39477 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeJNSAT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Oct 2018 14:00:19 -0400
Received: by mail-qt1-f176.google.com with SMTP id e22-v6so18464042qto.6
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 03:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1LZpGwQwjDwXqJTprrOFdqrpVy3L+DWuwrXoM+x+OpU=;
        b=rgyUfeMhB6jIF8oiQQ3t7LVqZUjqnh9uaoSFka9TL/BVnGwCBeROqa/TGctZqNrgUP
         ANKEFKe5Xnbs96mEYcnBnpfn3vCYUCDJ9Qooy3F/4d8TLg4c3fxkSq1/+uU8I8dy3t+5
         RyH1UvUsFF+/fmiFeWv+HcmTiBMFkuLb8c6d4em5SiLb5p/gCr7APHNyDeYGszjAIsGR
         mzL7ExM3jyOH9XtnhZlNE7xlzFmqY+0PWwgiQthWiFevnpl0TtkN499s8hMqpysXSDXJ
         tCi68KUGTDLayJhz1G0+2lKIfl8p1II2Y8jJlxcXqE+GwFW4FJ+zhr76JDtMA9KWTmnG
         1JeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1LZpGwQwjDwXqJTprrOFdqrpVy3L+DWuwrXoM+x+OpU=;
        b=kvtvWz30BV3b6H/fqN9J/qcM5catFSaA/geWualHKosYrV2uLn1LdzbkBU+v/teGH5
         GVWOgCYcPRfEoJtUrgsYrWWoZ/quGNQyzB3kHXrzTpCG+aC8Vi1vlYj+ZneI69uYpToc
         l42haN40am3PBfplFZWrFKC3/JiqibRcK3bEWyqaENYLpUErD8CqFti15fGy11BcLFMG
         nNBozxoqfcR6yoyZ5j8GbaHDlj49q6ePVGjO6RBTlb6vsDzywACqzZPLNQkGdmSN5WRc
         WRDKDBGAnxtHJCY3ciazUGXJAldoSDyJOCssEY4SwbIlUf2bqHf7GeDnfyfQcuuTW9wL
         J7cA==
X-Gm-Message-State: ABuFfogmG6LHWt4HZeBaSAdD4MAQQLIPpyVtF7DxamlSHww6T70Wd1Xs
        gy9au5T3ahUtQ7k/qNsbJ6WNUE+4NryRlwJvgfu0Cw==
X-Google-Smtp-Source: ACcGV61FfpXipYYamTvAZv3EmlUSa0bbZpX97UD6NJL3+vwqD1phOyYCbiupzrF88AkYxCqIFu3WBJG+A6DEG35loiQ=
X-Received: by 2002:a0c:f8ce:: with SMTP id h14mr10152521qvo.177.1539512387197;
 Sun, 14 Oct 2018 03:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181013081101.6602-1-taoqy@ls-a.me>
In-Reply-To: <20181013081101.6602-1-taoqy@ls-a.me>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 14 Oct 2018 12:19:35 +0200
Message-ID: <CACBZZX7i-Uob9EJ8GeDKYVTyKtdRiy=qPbxSOe=FGh2cbHG9Zw@mail.gmail.com>
Subject: Re: [Question] builtin/branch.c
To:     taoqy@ls-a.me
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 13, 2018 at 10:12 AM Tao Qingyun <taoqy@ls-a.me> wrote:
> Hi, I am learning `builtin/branch.c`. I find that it will call `branch_get`
> before create and [un]set upstream, and die with "no such branch" if failed.
> but `branch_get` seems never fail, it is a get_or_create. Also, it was
> confused that getting a branch before it has created.
>
> builtin/branch.c #811
>
>     } else if (argc > 0 && argc <= 2) {
>         struct branch *branch = branch_get(argv[0]);
>
>         if (!branch)
>             die(_("no such branch '%s'"), argv[0]);

From my reading of the source you're correct. That !branch case is
pointless. The only way that function can fail is in the x*() family
of functions, which'll make the function die instead of returning
NULL.
