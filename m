Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B97B1F954
	for <e@80x24.org>; Mon, 20 Aug 2018 17:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbeHTVBk (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 17:01:40 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:40017 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeHTVBj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 17:01:39 -0400
Received: by mail-qk0-f176.google.com with SMTP id c126-v6so11419672qkd.7
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 10:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GqKvzaIVyZUJab5s4KLwGrLSsXvGN1ffX6V6ESMVt/E=;
        b=sN36Hw0Vyw/IzODlNtjABxfMLBfBrajfPS3/jcml7Nt6cW08JqwvfC7Rx8jomxZfiA
         /vUaXUk36Auohc0w5//UE+sKC//WnjZUfIJceYeypdv5/S+Bx4duEzXI1YnkSkSjDsyO
         kopj1dxO8jc0AwjoOm1/UyJoCYDd4BcsbFdGHSzq8A5H0CkHuHtYfCN8rt8h+Syjkw05
         gYP5pBcYOVnQzZWbnHJB0g39/2t5c4jj92tw+99/nXRpbtSqwXCaOTOw99D1UKuxvt1A
         Gi4QIP/IS/WypgSkgkBloBlKobMi872hiSAnN/HHtj0fYSms15KvWA55NeaTdCE91GNj
         lT+Q==
X-Gm-Message-State: AOUpUlGhIqQkWm+XVpveQLYQs70gkEKw1y2btlcZBIq9IpG9AyM8ZM05
        K5RN70SjBs9cvwz/gSn2s2K6ySqxNvfq65uFFy8=
X-Google-Smtp-Source: AA+uWPwuGHj+wTexsN++Xbj7gEzfIOu/NDZyXB3cpX+xtQteFYsgjsAdASzP4/i60QIBkzHpT5XAJD3+axe6zUJ5NJY=
X-Received: by 2002:ae9:de05:: with SMTP id s5-v6mr40437664qkf.145.1534787104968;
 Mon, 20 Aug 2018 10:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqva88aa0c.fsf@gitster-ct.c.googlers.com> <7b340c01-f57d-1a71-e4d5-0346bb042d0c@talktalk.net>
In-Reply-To: <7b340c01-f57d-1a71-e4d5-0346bb042d0c@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 20 Aug 2018 13:44:53 -0400
Message-ID: <CAPig+cS591C+A5zTMwaYFmq+_SCvmY7RUHeDn6sRvMbqKDke-A@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2018, #04; Fri, 17)
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 20, 2018 at 6:23 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
> On 17/08/2018 23:44, Junio C Hamano wrote:
> > * pw/rebase-i-author-script-fix (2018-08-07) 2 commits
> >  - sequencer: fix quoting in write_author_script
> >  - sequencer: handle errors from read_author_ident()
> >
> >  Undecided.
> >  Is it the list consensus to favor this "with extra code, read the
> >  script written by bad writer" approach?
>
> I think there was agreement between myself and Eric on the last version,
> I'm not sure anyone else has expressed an opinion.

Phillip's v4 [1] does take backward-compatibility into account, but
with minimal extra code, which seems a reasonable compromise between
no backward-compatibility and the heavyweight approach of v3. I left a
few comments on v4 [1], but none were blockers, and changes based upon
those comments can be done later, so I think the series can move
forward.

[1]: https://public-inbox.org/git/20180807093452.22524-1-phillip.wood@talktalk.net/
