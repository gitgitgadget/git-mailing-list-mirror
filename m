Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 714FF1F597
	for <e@80x24.org>; Sun,  5 Aug 2018 18:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbeHEUms (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 16:42:48 -0400
Received: from mail-yw1-f51.google.com ([209.85.161.51]:43616 "EHLO
        mail-yw1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbeHEUms (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 16:42:48 -0400
Received: by mail-yw1-f51.google.com with SMTP id l189-v6so2819324ywb.10
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 11:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HbmvKkruRALnWDGwOleErR6nEpMRjZCTnDbVln9DNdw=;
        b=i9GPsSB9Sy+X0+gWqcwBY2TFV4fcpsmI1FqGUGKjgnCbOowpfuSGVehpJ01MyaeIuM
         tAmQg8H732bcV2QnlfbLZfQXoBAgIYKdk1RZCsBdVuJCUAqUTQuYEg+wXuYI53LkgNg1
         4z7rDJ9lhTOxrlOhAZXKaqJwfbUl6u6HK3yBdwHkK2X9RuEozbKn4PE5++bLQgUY7RpX
         AbxMX0e97xKKtMYfcMe3or4OulK8iA2ytVw31fhPyv3uMf9o0LbBEVyeAeC5zawPW6fJ
         ZPxMybDIoX0+Nfh6s/SC+dcQiBqluE8bDYzG2qNL648D5MftZEpGo+Pep5APtnv9V3qJ
         HvgA==
X-Gm-Message-State: AOUpUlEGUuRJyT6rw25Tlbnha3g3SMCiKRDur5RYL5xqClrHeG/Fr+RX
        jTEPsDTY7u2OkS8g27nlTvjHKx/h3E+pBmjEGJA=
X-Google-Smtp-Source: AAOMgpdTNrFMujRxPMbpM5fWFkd0ynztR6D5RbPP/Fx4CvExhDlJc41eraJjov5MsXPjlIXFDy+omUyDYxzCsv7KGgc=
X-Received: by 2002:a0d:f3c7:: with SMTP id c190-v6mr6264964ywf.98.1533494239951;
 Sun, 05 Aug 2018 11:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <02659385-334f-2b77-c9a8-ffea8e461b0b@codesynthesis.com> <20180805150117.GG2734@hank.intra.tgummerer.com>
In-Reply-To: <20180805150117.GG2734@hank.intra.tgummerer.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 5 Aug 2018 14:37:08 -0400
Message-ID: <CAPig+cQdTjf1oWzxSFx+i5YcfWs04oPefAqY0FtVKzrGf8Qw4Q@mail.gmail.com>
Subject: Re: git worktree add verbosity
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     karen@codesynthesis.com, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 5, 2018 at 11:01 AM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> On 08/05, Karen Arutyunov wrote:
> > What's quite inconvenient is that the 'git worktree add' command prints some
> > output by default and there is no way to suppress it, as it normally can be
> > achieved with the --quiet option for the most of git commands.
> >
> > Could you add support for the --quiet option for the worktree command?
>
> I think a '--quiet' option would be nice to have. [...]

Indeed, omission of a --quiet flag was not an oversight, but rather
considered an optional feature "awaiting demand"[1]. Apparently, there
is now demand for it.

[1]: https://public-inbox.org/git/1436203860-846-12-git-send-email-sunshine@sunshineco.com/
