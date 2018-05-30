Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05EA41F51C
	for <e@80x24.org>; Wed, 30 May 2018 10:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeE3KUP (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 06:20:15 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45185 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750854AbeE3KUP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 06:20:15 -0400
Received: by mail-pl0-f65.google.com with SMTP id bi12-v6so10812327plb.12
        for <git@vger.kernel.org>; Wed, 30 May 2018 03:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yYYnJLme2LgNIsZxsy/BECF0bm1ylcdC+2AX7KZuuJo=;
        b=K+4VCEc2S/z+wZ1PYIZKnrM0o3c8KZnbJY22uAnoDXTS34GYn+l3W3XgkxL4Qj/PFa
         Wi8XPzIdxa9YkP2d1CGqhaKWZuLBXuOjENji2VV1OZw4FyAEr3qE8pGfQ6A5OVS+gjM5
         1J4PaFFtEGnRZzD5qiEvvWAcMljWNXkMnNPe8zDwjy9RW6YedX88uhB9h+pE874or2xW
         g+ZC/pmDjuNGPizs2bMLKcP5vetyq1EoJJyjDFy6SafoLKTuDOEa8jhtDVJigpilKLh7
         w5Fj7ZXQVIeXvDoNNXynndZJaDTlUgKw2yfB7ySbX66UOPNJ3d1EPoVH7yRDShhYOpJZ
         dK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yYYnJLme2LgNIsZxsy/BECF0bm1ylcdC+2AX7KZuuJo=;
        b=cCEvoUFLqHtnUgrVaQ6UmGVEW5O7JI5mYTrktDTYSl3qZpUZfeUo/FZtIxjgocYYlR
         NdWOedI1CpcA9IZN7voRU/X5tnTBiQ6Kzyy98HeXWV6hdi2R53TvAiIvuulSw7+y/mKx
         bwcNOCcMxBUlQRK90NE3h7DrsZEjmKj6bP9dNCMRh1OVh5bFnugSw5I3FAQXJzrrWJLO
         D7zfKISyT0N/BFF5q1A7wcu21BzXwLdUcm+VldnAzVtEQ/iWbcZHYP9Jqvfqrd08ZJXD
         GFrccd788XcA5FCaaOuqHZFU5+T+iwzyKq8M8q0Yu3BwvYnKOkMp55psWOOLhLQHLX3G
         w8uw==
X-Gm-Message-State: ALKqPwdBynih1bzQojttEJCZ4/KwEcajI6ZjE8DarliZ0/iNpiAoz+NT
        jKikSBVCN7MK4z8yobHqrJEKl9CF0I41DyTV/9w=
X-Google-Smtp-Source: ADUXVKKdmPl8XlJtkVIQ/OMlb0zN0XUJgHWSm4mU6ZptkqItdhr9pdzwpm5rJVRHnWD1tcoMPcszuDyQz6tVHF6LxLo=
X-Received: by 2002:a17:902:1c7:: with SMTP id b65-v6mr2252396plb.298.1527675614669;
 Wed, 30 May 2018 03:20:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:760e:0:0:0:0 with HTTP; Wed, 30 May 2018 03:20:14
 -0700 (PDT)
In-Reply-To: <20180529213244.GD7964@sigill.intra.peff.net>
References: <xmqq8t88nllj.fsf@gitster-ct.c.googlers.com> <cover.1527279322.git.martin.agren@gmail.com>
 <ef5b4e28e00ad0c95dbe625d2e7305957f9fe5ba.1527279322.git.martin.agren@gmail.com>
 <xmqqin78jfnl.fsf@gitster-ct.c.googlers.com> <20180529213244.GD7964@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 30 May 2018 12:20:14 +0200
Message-ID: <CAN0heSoSYZaui5xSaJ=FGMjAFyhRWDCmGH=hXo0VCRf8RSqNHA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] usage: prefix all lines in `vreportf()`, not just
 the first
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29 May 2018 at 23:32, Jeff King <peff@peff.net> wrote:
> On Mon, May 28, 2018 at 06:25:18PM +0900, Junio C Hamano wrote:
>
>> This shows the typical effect of this series, which (I subjectively
>> think) gives us a more pleasant end-user experience.
>
> Heh, that is one of the cases that I found most ugly when I looked into
> this earlier (and in particular, because I think it makes cut-and-paste
> a little harder).
>
> More discussion in:
>
>   https://public-inbox.org/git/20170111140758.yyfsc3r3spqpi6es@sigill.intra.peff.net/
>
> and down-thread.

Thanks for the pointer. I had missed that thread entirely.

Martin
