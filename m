Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 731E11F516
	for <e@80x24.org>; Tue, 26 Jun 2018 09:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932323AbeFZJON (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 05:14:13 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33161 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752606AbeFZJOM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 05:14:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id z6-v6so14740573wma.0
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 02:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jtkH1XgbrmL2NEbp4mVhiOcPoJJBhw0WmfzXMN9iLf8=;
        b=jnaweo1NhdlKpDczU683zE4YYn4+tvub4nJ1MnRZu6+TC642WbtO2JGHsXseR2tZiN
         VvS0fJxP7hPZ+ANfegDeQd1N+WEdWrgXMRnkgT7EfMSY5NZxT1O7In79KYdRbiS9d0ED
         wtpTy84Gnr3tlbJjSk9ELrwHmzRJUCXte/rW19EIM3vZKrxAYgBGCACPjfAcSRWa6DTU
         75+Oz30marRjd1Hk6wNDqRB6N4YzFFFzklwN8AuLdx0qoBF9XtMCjp5Ee5uuo7QCXZcC
         TwDTRi4LykV0ssS/g1eX7mskmM7BZbFe6Vn3jeKis+ssb7Y1uSG5cbH3D8TwmMl3UZBj
         SSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jtkH1XgbrmL2NEbp4mVhiOcPoJJBhw0WmfzXMN9iLf8=;
        b=f0IEVSUfRhc67vFCj0c5GxauytUUGrVkhr9y7mWWkWWU1FjQ4UNJWX3VZqJvtxvXlX
         mK1B4/LshDyLvkN441Ni7NqzkrNcUF+f9Dd9QMDIaWhZOnBqNRQuTBTR2NSOooE9zdXU
         44nOQIZEhNitTeyY4CM/H5kTXvxtNE0SU7U3mPR5FHm6Uyiz3eQcMVWYNbI1QoX86DDd
         qqFjFiiFkkTduHqyM/HuizSiso0rFsviLI73UISohRIs9nSZZ8EhtDAODbvKzosJucp3
         3iWUOKof2FSqExlmNwVoO1pAuDEq5mS0nESOdw0NVe+q/+I2sICzS+SSlZyWl1YDz2nA
         Pgjw==
X-Gm-Message-State: APt69E0xUF6Psn28OmEaAiJB/mLXWNBHHHcUvVVE03Vd0RloYB6CoM5+
        OPxLeK/3Mu4cFpXaG/Rlu6RvlT1SaBGnldlSNACYlj1/
X-Google-Smtp-Source: AAOMgpdOHe8FnyS60ihcV6zFloZjmNrEEKjdT4Z2fBoduBeScCmY+yzHh8dARWPGNcZEa1Dnt9s/NSipdBshG6aN4AY=
X-Received: by 2002:a1c:5e95:: with SMTP id s143-v6mr890257wmb.19.1530004450846;
 Tue, 26 Jun 2018 02:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180619154421.14999-1-alban.gruin@gmail.com> <20180621141732.19952-3-alban.gruin@gmail.com>
 <xmqq4lhurdl7.fsf@gitster-ct.c.googlers.com> <7094810.i0lmrLi0k7@andromeda>
 <xmqqr2kuq3qg.fsf@gitster-ct.c.googlers.com> <4dfaa8d4-09d0-1156-43a4-687c3389e039@gmail.com>
 <nycvar.QRO.7.76.6.1806252313140.11870@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1806252313140.11870@tvgsbejvaqbjf.bet>
From:   Pratik Karki <predatoramigo@gmail.com>
Date:   Tue, 26 Jun 2018 14:58:59 +0545
Message-ID: <CAOZc8M-oYND29eiZOfmKk7O-b34dxWphdgix0PgeryfYpu26Ng@mail.gmail.com>
Subject: Re: [GSoC][PATCH v3 2/3] rebase -i: rewrite setup_reflog_action() in C
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        phillip.wood@dunelm.org.uk, newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Jun 26, 2018 at 3:00 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> Pratik refactored some code from sequencer.c into checkout.c/checkout.h
> today to do exactly that. It is not polished yet, but probably will be
> tomorrow. It provides a function `int detach_head_to(struct object_oid
> *oid, const char *action, const char *reflog_message)`. Maybe use that
> directly, once the commit is available?

The commit is here[1].

[1]: https://github.com/git/git/pull/505/commits/47031d4706bd1eccd2816ecdaaf6e9cd700909aa

Cheers,
Pratik
