Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B5CC1F453
	for <e@80x24.org>; Wed, 26 Sep 2018 07:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeIZOLK (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 10:11:10 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:41223 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbeIZOLK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 10:11:10 -0400
Received: by mail-pf1-f178.google.com with SMTP id m77-v6so4349936pfi.8
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 00:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aC90OkfFH7LlxtnBGAFth9wvr3dr6Gm0DKmxJaYwXRc=;
        b=LsMtc573ZwTds+8PkkgKdqo6rcnQL9jlGMYeK5bYzzbUptwUYBwHIBhO4p+EwGG8lh
         jY8oLCYKKtO1n/tKjFh3mKPkE5yuOus0JOnhw9rK8hn3LK+k64CoNlyS4XxM1fZdcNdG
         If0TRtt0FHc21yK6G5pEhxF67zGlFaGu3Kdwi4fU+Mr2F297zD5/43/F5TPKYiQ9FBPy
         kBT8RDNph34kTqxRprXaRaBl+3zrRU+f5YrDIvrIxtREVS3qswRlOb26zlidwuhdBLzv
         /6EtxCnwbYU9/lknOVld54VxcUJRbSGTLbDGFhCqIl+FfAceN7ylkSp8RMuU5wRwtOE1
         f2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aC90OkfFH7LlxtnBGAFth9wvr3dr6Gm0DKmxJaYwXRc=;
        b=UF9ZuRQAEXPhiqBH4fLTf3bRdEQNARWcKJJRoqDz8Co+4iJvegu7rIgWwOohFZFprI
         mi9iZOOTvXjf7rsLi4CEPPwxoidxuuo+ihpoHMo5tcFQtABAls/D7QwMn01QBKuj5q3X
         xQmL6tTKnvjf2ITrqmjnlfNDFBXcaNqDgRCEydj5/bUKNEzC6r66/su+10vxf3x4rHP6
         alks6lgu5hWanLmfyEkC9vJErpWp+1l20KPNXt7fioY4g5W/rXql0HdXX/tDzr6/RcV1
         jX8bfGQ95j241+MC5U3qT0X/FhC94M4hAQj1qx9AR5XBBliLrycvurFEjSK33FSRRkgH
         QGGQ==
X-Gm-Message-State: ABuFfojjwBKhJgEsh14TeVrAiucR32GB+Tfn4bAI6eGgkNSCHQHOdSNz
        m0VEma+sUCOg5cdHtDvdB8V2n4Bi+PeYjs/P6c36k/eK
X-Google-Smtp-Source: ACcGV61k2SIs3pDchSwv14TsPpDXS6R+MsIbKbMJbT3KCQsXHzFaGzisExklAQ1tYHjMhTp8s0Mu6AOKySn42Is1N3o=
X-Received: by 2002:a63:b95e:: with SMTP id v30-v6mr4417279pgo.221.1537948770466;
 Wed, 26 Sep 2018 00:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <CALOYryFX4PPR+=1L+sjEqPsdmNh_+vNxGf0wwuAgoYzau=GShw@mail.gmail.com>
In-Reply-To: <CALOYryFX4PPR+=1L+sjEqPsdmNh_+vNxGf0wwuAgoYzau=GShw@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 26 Sep 2018 09:59:16 +0200
Message-ID: <CAN0heSrhaaP0ds8K92g9w5DAnbwuq8mM6WLKrTQ7e_a8Fku9KA@mail.gmail.com>
Subject: Re: t7005-editor.sh failure
To:     apyhalov@gmail.com
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alexander,

Welcome to the list!

On Wed, 26 Sep 2018 at 08:54, Alexander Pyhalov <apyhalov@gmail.com> wrote:
> On updating git to 2.19 we've suddenly got t7005-editor.sh test failures.
> The issue seems to be that generated "e space.sh" file can't handle
> files with spaces.
> Instead of 'echo space >$1' it should be 'echo space > "$1"' or git
> editor fails when gets file with spaces in name.

Thanks for finding, analysing and reporting. I haven't bisected, but I'm
guessing this comes from 4362da078e (t7005-editor: get rid of the
SPACES_IN_FILENAMES prereq, 2018-05-14), which only happens to have to
do with spaces in filenames. But in rewriting the test, it introduced
/another/ instance of spaces-matter-here and didn't quote $1 properly.
Cute. :-)

We try to snuggle the filename to the >redirector, so it would be 'echo
space >"$1"' and similar.

Could we have your sign-off for this? Please see [1] for what that
means. If you want to re-submit as a "proper" patch with commit message
and all, great. If not, I could do it for you, with you as "Author:", if
you just let me know.

By the way, could you say something about which shell or which
environment this bug triggered in? Just so we can better understand how
this snuck past us.

[1] https://github.com/git/git/blob/master/Documentation/SubmittingPatches

Thanks
Martin
