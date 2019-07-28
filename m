Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FD7A1F462
	for <e@80x24.org>; Sun, 28 Jul 2019 20:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfG1Uep (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jul 2019 16:34:45 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41251 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfG1Ueo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jul 2019 16:34:44 -0400
Received: by mail-io1-f66.google.com with SMTP id j5so111532302ioj.8
        for <git@vger.kernel.org>; Sun, 28 Jul 2019 13:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yg7EVn8eppN6tFYg85enTazZMkWdhSM24i7v7pKoIZY=;
        b=c9Vivlvi5nWce9WKGhFe7T3tMCIUcHIHvbdv3NGIne8e71xSUBBpvdIlgcZtpDRiFm
         TPf/yNA3rfrhQYoqpd2QKPHPpqIWloSKgApJYNDy3k6fVY9VOWPOE2ApPr/o9+vYoLyM
         U+SbPU7fMALhcS4sEnoqfI6gSENTkeR8Wh/EYXZOOiV/f3HfVgNVl+uH5T4i58QorHOU
         C6Jt78yqK9srQ38qxlCFzd0c19OBGgdZRqdqtjRoKCVWifKez52CMEzw4G8GS3DWocco
         y7902Hq13sp1a5EdN9sPqrl9t5AKes/OSl2z3hYl43c1cKd6iF5WJdiXvbdSMRFHiRug
         c1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yg7EVn8eppN6tFYg85enTazZMkWdhSM24i7v7pKoIZY=;
        b=CPM2NriauvFuDR8znupydJkeDYcxg6qHWHSN73VJ7vp8fy+KlIF5uBcihxYdf30Wxh
         0JAyL0iiYq76j0sPFvN3kTH0vmKj3PWDG4QI6QtuoFhn+ohNa7hg/Tri6GRuADk/WOuQ
         Dkp7jTpvEcnDFj6Br2sWw95psOF9uPvOk60xBn01eVSXS7HFl1XsS1jHOaN1Xr6vu9KV
         SLq4LtSHGPFWxc05k5ZMQHnio+nT+ew2cACkxDTRaZJSKg+w/B9Zj1dv55tFtNa6t/rT
         s7jdu5KRlE2mY2vqgTDduJ2O5Axf4hsFGCw0xz4O6tmMlmVIYAxZmeujwqyrfDwE7AFS
         Ca+w==
X-Gm-Message-State: APjAAAW6iYtYg00zZkE03AlWjxbb0h9Qr9vU+ERbdPmAbe8LeEUFolC9
        uDizzjYL3aBobo5UBQurQQX6vzWNI7NN4V5yWx0=
X-Google-Smtp-Source: APXvYqynOnndAnytFOY67CvyzvQSKJ6XfmhLTorEDBdqx24OviH4uEmSvF3Q6ggMDT7/r0NeC79Bqe4V3gOiJNCvKo8=
X-Received: by 2002:a02:6016:: with SMTP id i22mr83766155jac.56.1564346083813;
 Sun, 28 Jul 2019 13:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq36itprzo.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36itprzo.fsf@gitster-ct.c.googlers.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sun, 28 Jul 2019 13:34:32 -0700
Message-ID: <CAPUEspj0fNkRJLRhLkA1arOq58QpZZG_29=sAu1eNe9aHrAtfA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2019, #06; Thu, 25)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 25, 2019 at 5:19 PM Junio C Hamano <gitster@pobox.com> wrote:
> [Stalled]
>
> * cb/xdiff-no-system-includes-in-dot-c (2019-06-19) 1 commit
>  - xdiff: avoid accidental redefinition of LFS feature in OpenIndiana
>
>  Compilation fix.
>
>  Will be rerolled together with patches from the
>  jk/no-system-includes-in-dot-c topic.
>
> * jk/no-system-includes-in-dot-c (2019-06-19) 2 commits
>  - wt-status.h: drop stdio.h include
>  - verify-tag: drop signal.h include
>
>  Compilation fix.
>
>  Will be rerolled with the above.

a merged reroll of both topics was published in:
https://public-inbox.org/git/20190728200724.35630-1-carenas@gmail.com/

apologies for keeping Peff's patches hostage otherwise

Carlo
