Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 994792035A
	for <e@80x24.org>; Wed, 12 Jul 2017 02:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755516AbdGLCGy (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 22:06:54 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:32874 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754512AbdGLCGx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 22:06:53 -0400
Received: by mail-pf0-f176.google.com with SMTP id e7so5016033pfk.0
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 19:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+LcA+5SU7HysRdSrBCDKR3LXyJF0AFTZhNGstp4f9F8=;
        b=TiyyphJwg8j9RxYy3M9Cb3G7DDDV4rKpkGdJZwPDxCI4JXZT250k5MzV/2tC3ExpI6
         srlbfdhwzbqrRfBzCwX62TvXZfauUU2llXa0ryE6TRCKbuzlwKyK+niz+3YzBxuVWMSK
         n/q0yX/ixiXGGdl5SGIuMvnH6/ZMT7MsFPSXGo2Zy27PPbUEixyOX6OkqEJNdegj07Re
         bfVR82YNCV9TCNjjEjGAap8/73R6uxcwvenQysQ1jctqFQX8/TgRdkBRc/C6A4/tpz8U
         a7rBL/AEemA+ehKIgF1ZrLU4D6WzyhHiOoXBpxuf1z9s46mg0CBbiSJyEeXtsDUfic9H
         Wpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+LcA+5SU7HysRdSrBCDKR3LXyJF0AFTZhNGstp4f9F8=;
        b=cvT49p4fuWKPqj9xJtUIVblTTPpcwMxjX0Pbmn98ijAGiyQUJNU87yGdRrx3x+PVXS
         fjIwBpO7prtoM8hZ6EvF++JAq47Pvj3C65Z50eklbRkBFcTlWVuCD2KdM9kCSOq2xQ/E
         r49y2Pxb2IUOWzod+MPxHSKwY5alfGgH8+/aBxLygs4F35DTrj4/RuYBgz2HWhKyV79B
         WvuYmUaA1vE5kbvAlCLO7Haq4EIJNQS6P8tNiNqhXtmTIiXjHQQ1twP+IvR8gpeQ1SSK
         wfjPqs+7xTEfMXjGkeaRUGUY/D5P5BZLYtIDnuKqQGRRc/hnyeu+1hJPIZo12Dy0m9Vo
         nwDA==
X-Gm-Message-State: AIVw112VQJRXqZVrYazusx4aj3p9XunWMKAuFa12a/x/S+E4DXZNgOls
        f3KmpmSq0j16a9NDvwtcyS9yL6UiBw==
X-Received: by 10.84.195.131 with SMTP id j3mr1522550pld.147.1499825212770;
 Tue, 11 Jul 2017 19:06:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.176.173 with HTTP; Tue, 11 Jul 2017 19:06:12 -0700 (PDT)
In-Reply-To: <CACPiFC+Lc+ewmPe6u=dUo4rJRcgLqRfG-EG+vudg8mapnH-d9w@mail.gmail.com>
References: <CACPiFC+Lc+ewmPe6u=dUo4rJRcgLqRfG-EG+vudg8mapnH-d9w@mail.gmail.com>
From:   Andrew Ardill <andrew.ardill@gmail.com>
Date:   Wed, 12 Jul 2017 12:06:12 +1000
Message-ID: <CAH5451mGTkVVoNJS44Y1AMwvHVeuYNZv5Tp89LDp0skx8ZNeYQ@mail.gmail.com>
Subject: Re: Dropping a merge from history -- rebase or filter-branch or ...?
To:     Martin Langhoff <martin.langhoff@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin,

From the sound of it you really just want to revert the merge of the
pull requests. A really good description of options for this is at
https://git-scm.com/blog/2010/03/02/undoing-merges.html

There is also a section there about bringing the changes back in at a
future date, depending on how you do the revert.

Does that page describe what you're trying to do?

Regards,

Andrew Ardill


On 8 July 2017 at 07:07, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> Hi git-folk!
>
> long time no see! I'm trying to do one of those "actually, please
> don't" things that turn out to be needed in the field.
>
> I need to open our next "for release" development branch from our
> master, but without a couple of disruptive feature branches, which
> have been merged into master already. We develop in github, so I'll
> call them Pull Requests (PRs) as gh does.
>
> So I'd like to run a filter-branch or git-rebase --interactive
> --preserve-merges that drops some PRs. Problem is, they don't work!
>
> filter-branch --commit-filter is fantastic, and gives me all the
> control I want... except that it will "skip the commit", but still use
> the trees in the later commits, so the code changes brought in by
> those commits I wanted to avoid will be there. I think the docs/help
> that discuss  "skip commit" should have a big warning there!
>
> rebase --interactive --preserve-merges  --keep-empty made a complete
> hash of things. Nonsense conflicts all over on the merge commits; I
> think it re-ran the merge without picking up the conflict resolutions
> we had applied.
>
> The changes we want to avoid are fairly localized -- a specific module
> got refactored in 3 stages. The rest of the history should replay
> cleanly. I don't want to delete the module.
>
> My fallback is a manually constructed revert. While still an option, I
> think it's better to have a clean stat without sizable feature-branch
> reverts.
>
> cheers,
>
>
>
> m
> --
>  martin.langhoff@gmail.com
>  - ask interesting questions  ~  http://linkedin.com/in/martinlanghoff
>  - don't be distracted        ~  http://github.com/martin-langhoff
>    by shiny stuff
