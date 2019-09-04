Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 260C01F461
	for <e@80x24.org>; Wed,  4 Sep 2019 20:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfIDUbb (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 16:31:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40040 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbfIDUbb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 16:31:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id w13so180279wru.7
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 13:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AuM6bBQp9fuHGEBngEnBg53dJe97KZEtt0B4GoDcQCs=;
        b=lzjtWE3UNmwESyyJ5sEVvygRLjII2cQX80PbRhgc3gP/mtXgo8wm9Xu4kVUW+V73YY
         AX1PzWEOVK+XGvA5egDqexviLqP/pYyweHMCnKFLOGTMwFyd5HGGcgv5Jvk6GJubtv30
         tEsECzwn12UgeKTTv4PRjfp18DQPLbr9hQzLEIix+qlr7/dy5JJLHR4Mpawyi6eQFPTV
         H1+PPlGZL20NmakZ4XHr+JJcv/8LXc7YB2+IWOG1Vgpje835IAP1N0SE/2zsaNNKIU19
         E2B2SUIuZ7V/MAy7Fp3rxSs1qN5IdI+1vjRABfhoEyV2A1eS+qJ09TvZwUakamG8sFLO
         EqLA==
X-Gm-Message-State: APjAAAVAIn2GbNg0IsXgRWklGckk/yUgf/IcgC9eRqxXGNxCEFfw0a1v
        N4U8gKboNZwYcLVHv+6T92nCDpTBfYo77i/Y23U=
X-Google-Smtp-Source: APXvYqyVnKDVo6wxBiq0cBLhQKlf4IiKj8d51X6UY1SD/PfEdjxNOxmMM+I+qX5VSslt2e0PreEh4XlSOEupeqE8L50=
X-Received: by 2002:a5d:6647:: with SMTP id f7mr19740026wrw.170.1567629089334;
 Wed, 04 Sep 2019 13:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <7da71d89f9fa987eca2e25974e4cec382c146e44.1567627609.git.bert.wesarg@googlemail.com>
 <62ef03a2938ac0d2158b1c3201c7f10e52e30ecb.1567627609.git.bert.wesarg@googlemail.com>
In-Reply-To: <62ef03a2938ac0d2158b1c3201c7f10e52e30ecb.1567627609.git.bert.wesarg@googlemail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 4 Sep 2019 16:31:18 -0400
Message-ID: <CAPig+cTZiOBwaM-BE-19CzJuZ4NwCZTaDc22WuY+bv8BLP=rrQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] git-gui: add horizontal scrollbar to commit buffer
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Git List <git@vger.kernel.org>, me@yadavpratyush.com,
        Birger Skogeng Pedersen <birger.sp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 4, 2019 at 4:10 PM Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> While the commit message widget has a configurable fixed width, it
> nevertheless allows to write commit messages which exceed this limit.
> Though it does not show this content because there is not scrollbar for
> this widget. No it is.

"No it is" what?

> Suggested-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
