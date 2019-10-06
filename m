Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5B741F4BD
	for <e@80x24.org>; Sun,  6 Oct 2019 02:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfJFCnS (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 22:43:18 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45496 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfJFCnR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 22:43:17 -0400
Received: by mail-ed1-f65.google.com with SMTP id h33so9323136edh.12
        for <git@vger.kernel.org>; Sat, 05 Oct 2019 19:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kUEMpnEZ8iOmYH48ZPfAEhi68YS6Gp8FZjYy2f69JxI=;
        b=WZNwV/X3WronpleRD5PqQzHwIkFQMIM4OltAihgYAbrapvT3PHhN8sCDn6Dm+3UCXN
         OSaOcu8ZPVBuaZqefVOddcImj2Ns5nBR3TZtK2Xid90RvFL/WWGzb394k2FdD1ZpCaXr
         7R7dwagOJUiwmsbXq8RX4E4oVLBeFCtRC5MtSzITV7ztrez+yqaxIffQs1At2p/fPA/Z
         rDNG6sKePUJgCJhidamFhGMqqpNIYlOMWFYbxszF4Ni3UefaKyQUfO8wP0H8OeajtN+Y
         +F27caUv9EtjBVaaMTvZ17mVYOzf3RX96roi4IlhKvM9TBwPwCCesFaUBdR+SEzjG2GI
         ac/A==
X-Gm-Message-State: APjAAAWqoiSU7sTeJeGgb2J1nAcgz1ZZxI4GhG4F5jBErV3qTMKDk8Ge
        jj47gWZ3AZL8iQlw3Y8SwL5VMEd2Rep6EtHb9Y0=
X-Google-Smtp-Source: APXvYqyVlk69HBV13+wf2m2u+PvLLAJq0JXco5oGLJILE8M3Xwt5LAwi2SvjFCWM2K9L1rXsOgze9x1xUBG/Vs3G+M0=
X-Received: by 2002:a17:906:4a5a:: with SMTP id a26mr18431580ejv.154.1570329795420;
 Sat, 05 Oct 2019 19:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.303.v2.git.gitgitgadget@gmail.com> <7e59b5cec2f267820feeeeb63a20814fe67d61e3.1566876175.git.ahippo@yandex.com>
 <xmqq1rx62qbe.fsf@gitster-ct.c.googlers.com> <CAE5ih78iSO+yu0KC8gg450iv5iY1gJusN33uatFdRgp_1ToALw@mail.gmail.com>
 <10209481570324845@myt6-4218ece6190d.qloud-c.yandex.net>
In-Reply-To: <10209481570324845@myt6-4218ece6190d.qloud-c.yandex.net>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Sun, 6 Oct 2019 11:43:01 +0900
Message-ID: <CAPc5daXU=fcjYJ4p6wQH-Ljz1Y8j=sBiwcN96hkxhP4CP_k8uA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] git-p4: auto-delete named temporary file
To:     Andrey <ahippo@yandex.ru>
Cc:     Luke Diamand <luke@diamand.org>,
        "Philip.McGraw" <philip.mcgraw@bentley.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> >> ...
> >>  Luke, does this look good?
> >>
> >>  I know Mazo is the only other contributor who has multiple commits
> >>  to git-p4.py in the past 2 years, to make Reviewed-by carry some
> >>  weight ;-) but as we have so small number of people touching this
> >>  script anyway, I'd rather see what the main contributor in the past
> >>  2 years thinks.
> >
> > I think it looks reasonable.
> >
> > Ack.
>
> Junio, does Philip need to resend a v3 with Luke's ack or will you just add it yourself while queuing the patch?
> (sorry, if you already picked up the patch -- I just didn't see it in the last What's cooking update)

Sorry, I do not recall the details of this old a thread but if I
recall correctly there was only a corrupt patch that I cannot use,
so somebody would need to send a patch that actually applies. With a
patch that applies, I can tweak the log message
with acked-by etc. just fine.

Thanks.
