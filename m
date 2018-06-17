Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 498841F403
	for <e@80x24.org>; Sun, 17 Jun 2018 03:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754597AbeFQDqw (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 23:46:52 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:43156 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754082AbeFQDqw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 23:46:52 -0400
Received: by mail-yb0-f196.google.com with SMTP id w3-v6so4858912ybq.10
        for <git@vger.kernel.org>; Sat, 16 Jun 2018 20:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GEFGXHjOOWkN25q6rVTf/1DMVLRKDTm/DtTSwuH1W2A=;
        b=PD2UQ3W7Cw45n/9KdGh6GO5IJDg8IrtGUtbnxLj5P/nKtVfLyZykC95iqICa2+3tLh
         K7QuR92RxqvQEqRn4dpFOqdFqNpf+/9WFvKmItntn9kUel0k15vLICUOljIeJaJNuIrd
         9zeuzvLi3i9vu44Cq4t5vffNAos6iJmmd5xnFqPD274kucA+AOj2b9GScRP4WZT/K8KS
         uz2Q1wD4GsHPEEtPAzvJKyhOllumA+EpgKFvbfwpPEx/Iny2LVxwWUIxitMID/OyQKXD
         aBYo0bj3891ubM1oiRz0m83H7wwYVbpRqscmkno/mZKYgzIEOhgufQWfhza/UgEcNnSp
         oPPw==
X-Gm-Message-State: APt69E1RLj7zS7pRlrRvo5BswGAa+kpx2UdZHKRSQy5Sr8SRVOU327On
        Cn6DHOUNdRpjuata7t1IfxNjuq+OIhAkJx3O0hE=
X-Google-Smtp-Source: ADUXVKKxsD2sr/LbdjE7qjyD7hwtWbqsFJu06HPAT6eRzo8JbilZ3JTxMNnVaf/0k1vns96YuyGDiJZKFFPi8kzmLmc=
X-Received: by 2002:a25:1f02:: with SMTP id f2-v6mr3933569ybf.76.1529207211606;
 Sat, 16 Jun 2018 20:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <0102016409c877f9-58c13d7c-4d25-43e2-8d64-c13d98b88ee7-000000@eu-west-1.amazonses.com>
 <CAPig+cTJMNw9JhqCQtqqU+MV7rzfy_yEQ_WuNaBdo-VVZf-9LQ@mail.gmail.com> <CAAjsFLS8tz_123B453UP_mnjzH2_3osESMPFpC+y941F7x5eiA@mail.gmail.com>
In-Reply-To: <CAAjsFLS8tz_123B453UP_mnjzH2_3osESMPFpC+y941F7x5eiA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 16 Jun 2018 23:46:40 -0400
Message-ID: <CAPig+cR98YaygqfPXP0Nqy1Tb2h+rBNojt+hppS+AcPwgCwmog@mail.gmail.com>
Subject: Re: [PATCH] doc: fix typos in documentation and release notes
To:     tir.karthi@gmail.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 16, 2018 at 11:36 PM Karthikeyan <tir.karthi@gmail.com> wrote:
> On Sun, Jun 17, 2018, 8:55 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>> Please sign-off[1] your patch so it can be included in the project.
>
> Thanks. I am a beginner using Gmail and I have used SubmitToGit for
> this. Is it possible to do this using SubmitToGit or should I do git
> commit --amend -s to sign off and make a force push to submit it
> again from SubmitToGit as newer one?

Amending the commit with sign-off and re-submit should work fine.
Alternately, you can reply to this email thread with your sign off
in-line, like this:

Signed-off-by: Your Name <your@email>
