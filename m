Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 507FD2027C
	for <e@80x24.org>; Mon, 29 May 2017 07:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751046AbdE2HXL (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 03:23:11 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:34311 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbdE2HXK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 03:23:10 -0400
Received: by mail-io0-f177.google.com with SMTP id k91so36780501ioi.1
        for <git@vger.kernel.org>; Mon, 29 May 2017 00:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ub5iepIJH+ML9NCzgofKcjmSyxsaAhi/Acr/Vwc0cwU=;
        b=i2/nsrcs4iDrAzEwSKgnNz+r+a3bSovcQDIYGnIJh9je1QFHac6/N16xLxmaiJ+/9V
         NzkMvOwt9KcNC2WC9MaNXaXc9mlj3lHgBWp6LurXzlIptAyXF3jxRLmbpspl55ZP26zA
         QFolxqYMHqhH0ltJ3zK7dOnscESLlBKYoBW0EPML5smACCx4H/iNNjVbTUqsZIHrBkuI
         HHuZINYFQXDxAMQtHBt4pHfeB2oyt39rQnpM+imUucZf0ykN1EFzPiztETHQRhaY4Okt
         z2kNCXNEwauaEPr67RTDdt5S2taySC3ePw0G+Q17livFubQaNsFluQNbiFxy1MlV3opr
         iIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ub5iepIJH+ML9NCzgofKcjmSyxsaAhi/Acr/Vwc0cwU=;
        b=P2+ZDj1RXGjadfJD9CHOG0GOpF24xfZ5tuV8qj+HvM5ivaAN4pto4/loHJpkgZXaVL
         7VI8XW9TXBLEWLzd3tGu1yZNeSrO0MvhtKS5dWILl4o5JsDOLz7K+rF3EQ+03y61sG4/
         +foMPgoqqGdyyQFLv+oELQJneYg42cOxWVllKdFL4gHpIO2shBUAtWLamQ8D+EOOvgBu
         T1dsqR2oZOcfWXhZmQv0aJUPPrG9/v3bUfNLrwlQiDIizmU91xG1CcQ0c/2mgSINx7ku
         zDDKzWYwwtQgNKdFpojHgKTpocjXzpIO3u4zCK7xjBsGJVHEuf35Ftc8/YbZentfrrSn
         cA1g==
X-Gm-Message-State: AODbwcBAin3A2I8IFHu1QkGO+HfIWvYNdealV0X7TmImgTmH9lMZgKug
        ZuUZFT3Fc18OidzVNXxtloNdHDLewlN2
X-Received: by 10.107.201.131 with SMTP id z125mr11010577iof.160.1496042589623;
 Mon, 29 May 2017 00:23:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Mon, 29 May 2017 00:22:48 -0700 (PDT)
In-Reply-To: <xmqqd1asa3ea.fsf@gitster.mtv.corp.google.com>
References: <20170526205657.15006-1-avarab@gmail.com> <xmqqd1asa3ea.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 29 May 2017 09:22:48 +0200
Message-ID: <CACBZZX4ptB4_45D425cEzzCipt1Y=_TVskG+73hzwmar12Ai=Q@mail.gmail.com>
Subject: Re: [PATCH] wildmatch test: remove redundant duplicate test
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 29, 2017 at 2:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Thanks.  Did you run "sort | uniq -c" on it or something ;-)?

I've been writing a new backend for wildmatch(). Was wondering what
the difference in these two failing tests was, turns out there was
none.

> Will apply.

Thanks.
