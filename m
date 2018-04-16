Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF3DC1F424
	for <e@80x24.org>; Mon, 16 Apr 2018 08:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754352AbeDPIzP (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 04:55:15 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:50712 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754157AbeDPIzO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 04:55:14 -0400
Received: by mail-it0-f44.google.com with SMTP id r19-v6so10447628itc.0
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 01:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RrLAffuaogQwivXkyVAobIcY7xRD0CdolPvmYjAwsno=;
        b=iJZEqeEkvtcoziUBpU3wxXIcW8GK4esFg57JJnSpcx/P3TqXj52S0qlAGETKY+SqUp
         4r51eJ93riGf/6Gs2FhUp7IDHhkVAqcgA5YA/rKVvEFxQ0U9HMrobnG0d1O6ijnLdCgT
         GmWTbSBD9RLzxTdoah0M7WfKT+vVyn/vB0ZB9reMJ0gsPW8dJCICSm8ca5aVgyQ9BbSk
         iffjUFoVCBPX4EU/SfbJrTbkWkNNPqaG/Krzfwtu7+FXd76os+uq5gZ+Va9eWVGrIoqD
         HfR2OQtXPWUFk2LyOYJcjo1N5SySqw13s0zc2b9KnC8mMZE+pj7Kke83KDS2bLOtlv5M
         u55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RrLAffuaogQwivXkyVAobIcY7xRD0CdolPvmYjAwsno=;
        b=U3Dy/mP/996ICHu9Ts6Tm58FJpl2ZLXo5fBIubEDEpkaJOnx5CFiIUsUp+HjMCxrR4
         E8XSdaEL096Tla6rgz3vjtaMR0sRZrL6nIiuRNEXJflIDS4OUB21QYW0Wk5vnA67DyeE
         fU7EOUckom162wWJ4RC51KkhOJEdg2i8aBSrShd5PnvwY6DJ/dwZDLaYvXxJdcALDJLZ
         C53WFLoyxCMGsCnzxnapnP/sWPslIwGvrECFsY/0tL1mPq6dUw6pC3WxCYd5wgV1W+B3
         kbjiwqkQb466Sw67fj891ke85xKsu6iIlU7xLTB7ZHmxelW0yurbFx7S/bglpW/dTgCY
         kV4A==
X-Gm-Message-State: ALQs6tAgjL7psMvsePMSCyAn8uMeKcTBQ+gIzE12LBOWNpiBaTkVyxrn
        US3zS9kZy1/TW2tiaPCpv5Bu9H76eR/bInYyDrU4OQ==
X-Google-Smtp-Source: AIpwx4/K34tOTQMZPW0zZVs+nkcxHShreKUb234YGI/cDKwWUqaHNGmHFaUaNFhH16V1+7lrciLqpiKX5Au4xBkqvWI=
X-Received: by 2002:a24:fa89:: with SMTP id v131-v6mr14052935ith.40.1523868913600;
 Mon, 16 Apr 2018 01:55:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.219 with HTTP; Mon, 16 Apr 2018 01:55:12 -0700 (PDT)
In-Reply-To: <CAP8UFD0DagacfeismKoVgo=O1guRUV=u1=EbbwRyrY3g1MeQ8Q@mail.gmail.com>
References: <CAP8UFD0DagacfeismKoVgo=O1guRUV=u1=EbbwRyrY3g1MeQ8Q@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 16 Apr 2018 10:55:12 +0200
Message-ID: <CAP8UFD1vFM8k-1Po=2QXZdBOuCca1Dg_FGaPnSi85hKp1je54w@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 38
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 16, 2018 at 12:11 AM, Christian Couder
<christian.couder@gmail.com> wrote:
>
> A draft of a new Git Rev News edition is available here:
>
>   https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-38.md

The draft has just been updated with 2 articles contributed by Jake
about rebasing merges, so I am cc'ing more people involved in those
discussions.

Thanks Jake!
