Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF7941FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 21:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932379AbeARV6n (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 16:58:43 -0500
Received: from mail-yw0-f193.google.com ([209.85.161.193]:41815 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932191AbeARV6l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 16:58:41 -0500
Received: by mail-yw0-f193.google.com with SMTP id b129so12497602ywa.8
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 13:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bT1r3V/9YfoVgJbZUnluWTYLiNE3YVwq7OoiPV9nHRg=;
        b=leGBJChPWCyWf8yCN3nX12eO595ZCTWapQr/KZqmYJT3o31BV1X20DvrwmjZINHK4h
         qv865K4iYziERYLSNLl+UBLO4RXkyuwZOUh361+Ld/It8t8D1LbgYSPM3UyqzY8dUkva
         KUYwtl7ZheXfD9Pbig18Cbh7x6bdilwj+2wsNPuOIlUy1RBNdEOrzbqqmLl1i4EsIUsj
         9525aRuxtjL4+B3sc82Sbc/WIUO3DYN4VJSbCJ2R/ndz2avC5KHVv5bHp0zTXTUxEHtJ
         V9fQKPO4Br/YiZKCGGioqOEpf34sqIdizLL0nIXAYj+UD3U2UdVzeFh4B4kfGXQUPocM
         heBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bT1r3V/9YfoVgJbZUnluWTYLiNE3YVwq7OoiPV9nHRg=;
        b=JKKt7ITx/DxLjdBLBFnHJJ5C5eexKaYFaMh3wpPDaaPWp4XiUfx0WgpLJFckoxHIgx
         fGqPP06M2H6kgwGDbEVuyuFLhwtlVeXVLVsOd3kUvdmx3kvYTaP2/HF4i3+RwC2MwgBb
         BBoe4/weoIXu4FEzJ2/CNynPL88b5DJnzx3OMaQX5/hdh5glZ0KwR+HWVLcoLQ0Ask3y
         KPdLkKaNrK0ZFtPdAadKRN/NQfW84b9ne8owH6nSZYi4vqHPlBbzrRIl7/ueGM5rmcSy
         8kAlVomGy4OZD60vGRMQVB0vpeXm7nbrmwET4ZYcZRxnS/wwJQCyjCoASbQd8Tj/MjBz
         i0Gw==
X-Gm-Message-State: AKwxytfWj17wbCQvOgdwvc2UprZPEfOr4QMseS/eD0l4ULB7y9IKgW7X
        ciUoWUpwPxMrb28UYMHTYrYxZFm6PgDWfrR/TH7QbQ==
X-Google-Smtp-Source: ACJfBosjC5vqlCJgK5wHOPSLjJhoIuo3/jsqtcxgUTg4ju/GcISw938avi9FSL1PqgwSTXuK7yGIXWqNCpWSxUF8GoA=
X-Received: by 10.129.86.139 with SMTP id k133mr7167429ywb.253.1516312721004;
 Thu, 18 Jan 2018 13:58:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.134.197 with HTTP; Thu, 18 Jan 2018 13:58:39 -0800 (PST)
In-Reply-To: <nycvar.QRO.7.76.6.1801182233480.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
 <20180118183618.39853-1-sbeller@google.com> <20180118183618.39853-2-sbeller@google.com>
 <nycvar.QRO.7.76.6.1801182233480.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 18 Jan 2018 13:58:39 -0800
Message-ID: <CAGZ79kak8u0fuKW5Jg5+hjERCL+RtSCVhMjJz38qQbAG0KKG=w@mail.gmail.com>
Subject: Re: [PATCH 9/8] [DO NOT APPLY, but squash?] git-rebase--interactive:
 clarify arguments
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 1:36 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> Good idea! I would rather do it as an introductory patch (that only
> converts the existing list).

That makes sense.

>
> As to `merge`: it is a bit more complicated ;-)
>
>         m, merge <original-merge-commit> ( <label> | "<label>..." ) [<oneline>]
>                 create a merge commit using the original merge commit's
>                 message (or the oneline, if "-" is given). Use a quoted
>                 list of commits to be merged for octopus merges.

That makes sense. Thanks for being precise at the the user facing UX here.

Thanks,
Stefan
