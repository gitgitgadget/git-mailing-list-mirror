Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D01C433DB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 04:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D22E216C4
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 04:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgLWEln convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 22 Dec 2020 23:41:43 -0500
Received: from mail-qv1-f44.google.com ([209.85.219.44]:40937 "EHLO
        mail-qv1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgLWEln (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 23:41:43 -0500
Received: by mail-qv1-f44.google.com with SMTP id p5so2931955qvs.7
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 20:41:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lgD7ec6sKsxqVaFXjrplHbhIj9MGV1LLuJXO0O5De9c=;
        b=ScEg64SYCxOCTrOhtafB6Taf4qvrFbHuzUxaUMxrql0/14IX6h5VgBny25CoDK4udh
         fNsL5xKIaXmy2Do8irxhSZ5gWplRC5Ml/xKc8S5sSniRBbxZV8gPkBCHuuJaUOMKR7MZ
         BBsYaxzT38XDneCCWHt/TXNHBKMCYU/xacB3qq/JHvS4U2CpAiuoC7CiRj/HXnURZNbJ
         8p8/AZkHQmeaiPj9x2aqNt8xSGtZ2nCVNab2xICv692quPvBPtPEBymsC5Wm+B3YLJ3v
         qofmsKLOlMoCORnBu53YCq9gaBdPrDdOJVD2NW9erPO6kg+D4t00tSYp8/Nm9V/hXFJI
         tVwA==
X-Gm-Message-State: AOAM530MCDg8iC2h51GyDodHo4dnuwhz01tIv368FrQr3YWSsQfj4I12
        wpjn7Fgjypcu9nB2m/bavK+GrnOXPng=
X-Google-Smtp-Source: ABdhPJyqlFcfwtwZKg3H0IH3Z14HgB0NHRv8HdxLbzc/qyXq91qbcQGQ2NtQ719xhYzoR1UrtbNAcQ==
X-Received: by 2002:ad4:4f11:: with SMTP id fb17mr25477097qvb.46.1608698462072;
        Tue, 22 Dec 2020 20:41:02 -0800 (PST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com. [209.85.222.170])
        by smtp.gmail.com with ESMTPSA id p13sm2209357qkg.80.2020.12.22.20.41.01
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Dec 2020 20:41:01 -0800 (PST)
Received: by mail-qk1-f170.google.com with SMTP id 19so14033661qkm.8
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 20:41:01 -0800 (PST)
X-Received: by 2002:a37:aec2:: with SMTP id x185mr25050233qke.64.1608698461438;
 Tue, 22 Dec 2020 20:41:01 -0800 (PST)
MIME-Version: 1.0
References: <CAEs=z9Pajgjnq56+umA+g9-NFv-Rzo9m5sa-7cow_byckLiJ0A@mail.gmail.com>
 <cover.1608537234.git.martin.agren@gmail.com>
In-Reply-To: <cover.1608537234.git.martin.agren@gmail.com>
From:   Ross Light <ross@zombiezen.com>
Date:   Tue, 22 Dec 2020 20:40:49 -0800
X-Gmail-Original-Message-ID: <CAEs=z9Pjh=4mLoW1m9dnNuLL7HmpD3u-rdEmN41ONBOhr474ZQ@mail.gmail.com>
Message-ID: <CAEs=z9Pjh=4mLoW1m9dnNuLL7HmpD3u-rdEmN41ONBOhr474ZQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] pack-format.txt: document lengths at start of delta data
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looks good to me, FWIW. Thank you! :)

-Ross

On Sun, Dec 20, 2020 at 11:55 PM Martin Ågren <martin.agren@gmail.com> wrote:
>
> Hi Ross,
>
> Welcome to the list and thanks for reporting your findings. I haven't
> looked at all at the first issue you brought up, about the protocol-v2
> doc.
>
> On Sat, 19 Dec 2020 at 18:10, Ross Light <ross@zombiezen.com> wrote:
> > 2. In the pack-format doc, the Deltified representation section [2]
> > describes the instruction sequence well, but neglects to mention the
> > two size varints [3] at the beginning of such an object.
>
> Would something like this be what you have in mind?
>
> Martin Ågren (2):
>   pack-format.txt: define "varint" format
>   pack-format.txt: document lengths at start of delta data
>
>  Documentation/technical/pack-format.txt | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> --
> 2.30.0.rc1
>
