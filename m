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
	by dcvr.yhbt.net (Postfix) with ESMTP id E39B31F731
	for <e@80x24.org>; Fri,  9 Aug 2019 18:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437307AbfHISFt (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 14:05:49 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:41809 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436829AbfHISFs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 14:05:48 -0400
Received: by mail-lj1-f180.google.com with SMTP id d24so92846181ljg.8
        for <git@vger.kernel.org>; Fri, 09 Aug 2019 11:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pxuSpQxM1fSvvBnWWhZG5TpcLTULUueqboXva4TZato=;
        b=KIBnzje05xViMYzjVdyjJ4UtMvZcII91Xz8y+Lt8OCEfKA0VAsdjQGcxsB0uJKAPUN
         gFIOMuxLd/6Vfl4CfmSAmf4SYNGT+eavMJDq11eM+33+3ziicaMclKlyhu0l7ii8pgJU
         EpLsQZ/MrTH0ySm+s9mZtfjVCe/4qi19OOI6vy9DGxWo8xsxj6ZQhKrNTOjYgrC6RXhw
         zmTJ/5zfgdQcm5rYNxqz+JcriOjlznpygjRgmVUQXznfhrdyD8pycht/UekDc6kwva6H
         a8hlYJcZV0dZNN1bl8FYCaVdZ2Y9XeYM16QQbF/BH480FtDHkMTDlRmR51nR5NtxxNj1
         oLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pxuSpQxM1fSvvBnWWhZG5TpcLTULUueqboXva4TZato=;
        b=MShL1w4Vj54t8d2MgFJZi0QJOhl1EmFSh4i6gpbftwk3L6hVaFGwTO5DsNYY8SH1Mu
         /2tGW+lovYThnQpN7MoKx4Y3udh/n4Z9d4whP7P3zKZ8MVCpfmcn0yis0rnd588tg7fa
         mX6P5HXd+XgJVC66ShsOczfeneiaaWSz0v2n4qXP9x9IgN7yVFZUN0sZboVPbdT6nQHA
         x3Bck9ie6CayBsnSWXa4mJjRhFjmScb32xR3nSQqCHGBg2ZgeQSWix1SQMwQyjuDET5L
         nngXez/EWe1rbqP+cyt87Zd4iqEyCgPkDFgdPUXa4tzTQM9UNUElZ3O40cItl4QPbYx1
         LySA==
X-Gm-Message-State: APjAAAUajb9XEz8mM9ygcL/8rTccJOO9MKGP+RkzXeeCIZqDWp0chGoY
        D0f3F9NYakQydfnqO7cPejseW6QdWwupV7x93BM=
X-Google-Smtp-Source: APXvYqxrVy/4vFYspFoFrTfUXO/nj7wXe5/oI5JyxofQD8ONNw+i+GoGhkT92MAZ9cmuHWaiN8j9gI/xbnxqbw9AyS8=
X-Received: by 2002:a2e:b4e2:: with SMTP id s2mr3542945ljm.35.1565373946556;
 Fri, 09 Aug 2019 11:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq36itprzo.fsf@gitster-ct.c.googlers.com> <20190809001315.GA87896@syl.lan>
 <3C7105E5-5DE1-42DC-A9A4-65C061FD6139@dereferenced.org> <001e01d54ebb$9a1ab4b0$ce501e10$@nexbridge.com>
 <20190809162900.GA9094@sigill.intra.peff.net> <xmqq36iadygk.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36iadygk.fsf@gitster-ct.c.googlers.com>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Fri, 9 Aug 2019 11:05:34 -0700
Message-ID: <CABURp0pb4QY+Qbvn6YAtQ=bevSQW+vQXFMChyd_phtUK4P5M7w@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2019, #06; Thu, 25)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 9, 2019 at 10:48 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > I don't know of any plans for checkout in particular, but I think the
> > docs for restore/switch make it clear that it's way too early to start
> > scripting around them:
> >
> >   $ git grep EXPERIMENTAL Documentation/
> >   Documentation/git-restore.txt:THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
> >   Documentation/git-switch.txt:THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
>
> Would it ever be OK to script around checkout, restore and/or switch
> Porcelain commands?

Users who wish to get their job done will script around porcelain all
the time.  I would be surprised if even 1% of build scripts use 'git
checkout-index' instead of 'git checkout'.

No, this doesn't make it OK. ;)
