Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 654641F453
	for <e@80x24.org>; Tue, 16 Oct 2018 11:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbeJPTpZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 15:45:25 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46979 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeJPTpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 15:45:25 -0400
Received: by mail-qt1-f193.google.com with SMTP id d8-v6so25211165qtk.13
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 04:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pdtaSje5dRTisH+HAGHWBZTyIiO62g4q+y+wQWTT1YM=;
        b=jEuaPqpH8WZlWWNbdAC7L9WQQ02R7UD0WVgtXa+mwuOhb1liY+HeFfk/U2F6q4lp5L
         Si30c+8hMCXi5PkBdhoHaqZBip9268zUMymvbAFBdM77F/LAScoAgarJVEJrrJsMS+6C
         0pNmUCqlxFPmV+GPRAJP+QsWwOuFEIdG1ZjGwzSgOCq23m0irav6lvNYoQhHlvUTGwdN
         8lsiPfZiqZ/QbX+6uMOboHQqhI3dkF7oI+YKCUQuQywdeks5kG2j+IeuR/GaWigamTvK
         /phngEkYvwg7j3TVbKpEpHAWBNks17mi8sqnEwotw8djtYMbNS0gstxNh+4ug/8x/qLr
         nr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pdtaSje5dRTisH+HAGHWBZTyIiO62g4q+y+wQWTT1YM=;
        b=fjA6L/seqTa7UE9jE4rDqRID7cRzVDCX/XZcSfQvK9dqayiK1y4SWK42xj9I/FGFVH
         CgU+rpXPVMrBIKgtFm3lE9jqilAt1G5pEMxIBuI0hvrq9bCu5RAQRAsmj4nkvzh5Sgf2
         bKr6o/ffOd+JpfDhweGunQn/y7qh38c6uMdrFJPDhJn9wuBmdNhNCZCMjDjM5rSH0UFg
         Y4aLB970Bi5zXt0kL/cdEprh4OS70sehlj9p2lCb76gKeNQbYifuM2ZGWLhgPWTj2SJ+
         6yioUdSnyz0HoFm4Xm9EulCAeiuXirE1wQmJF0iazegOcxh0HRLw+8hm/yhsLwul6loi
         fZvA==
X-Gm-Message-State: ABuFfoiyAgISdWFOoIP220Kq4aUfRGRcR//qPAfQXNpsPvuq+YgMPYHU
        7qZhLFzASTagLQv1WjRWjBJjGjerIdmq/5wpNDE=
X-Google-Smtp-Source: ACcGV62tlHS1wMKTFmUpasg5xkYvXFjFpxC0QWX4xP5h2y8TZvAu91InIsXrWdLHhiFnE99cCwPwzPOjpDA5RkhJvaI=
X-Received: by 2002:ac8:3e91:: with SMTP id y17-v6mr19605827qtf.314.1539690918150;
 Tue, 16 Oct 2018 04:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.31.git.gitgitgadget@gmail.com> <pull.31.v2.git.gitgitgadget@gmail.com>
 <20181015142215.GB1764@syl.hsd1.wa.comcast.net> <nycvar.QRO.7.76.6.1810151636510.4546@tvgsbejvaqbjf.bet>
 <20181016025328.GC90754@syl>
In-Reply-To: <20181016025328.GC90754@syl>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 16 Oct 2018 13:55:06 +0200
Message-ID: <CACBZZX42Y2LAUsNT0dcmDy7ws+MaXtShD8K1YoUXx2kEBLH+aQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] Offer to run CI/PR builds in Azure Pipelines
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 16, 2018 at 4:55 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Mon, Oct 15, 2018 at 04:55:25PM +0200, Johannes Schindelin wrote:
> > Another really good reason for me to do this is that I can prod the Azure
> > Pipelines team directly. And I even get an answer, usually within minutes.
> > Which is a lot faster than the Travis team answers my questions, which
> > is... not yet? (I tried to get in contact with them in late 2015 or early
> > 2016, and I tried again a year later, and then a couple of months later,
> > and I have yet to hear back.)
>
> Certainly a good reason. To be clear/fair, I've sent in a number of
> support tickets to Travis CI over the years, and have always been
> responded to in a short amount of time with helpful answers. I think
> that we would really be fine in either case, TBH.

Was this in the context of "I'm this random dude using Travis" or "as
you guys know I work for GitHub, your biggest? customer..." ? :)
