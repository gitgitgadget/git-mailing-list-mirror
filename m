Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE21E208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 06:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387788AbeHGIna (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 04:43:30 -0400
Received: from mail-yb0-f169.google.com ([209.85.213.169]:46879 "EHLO
        mail-yb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbeHGIna (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 04:43:30 -0400
Received: by mail-yb0-f169.google.com with SMTP id x14-v6so451094ybi.13
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 23:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=esu92/PXQnO3qON2puH4Dc9nfei/J/VIx7zYaFD11rw=;
        b=dbu7S8fGx3RXUrSzgROmdzmjB37pkfjtImYBs4EmnAJExGYLs/OZtrKU3d5iPscyNu
         BgtvJYXBHeN2y0e8p4XjM8oyAtxiGOQgjKpcTYfoQVjpqOOf2ok19GwOtMhvGp52HIp3
         Z/DStllufBx6ysBapjy1f60B/uGrH0p7ipdJXBKMW2KFOsBzT+eScQ5gzi1stRb+rYJn
         XUAXUDjzPGMhnz1LkU28kZbki2IBn0S3QWZtUA3ziUDne7k0P/Zv5FpbEMoJSh1Cht1V
         imN9v8+v2zo+tjOuJ7Hk4FdlrpEfzTmKYgo26xhj3xyPEhCkyziIeZPAfq/pmYblRcHx
         wHOQ==
X-Gm-Message-State: AOUpUlGAZY4yOk2P9TSITLhmrCxWAUAQbBBLiQF9Ab7VjFnPwbJU1e3X
        ge0h087B1hKlJDnc5ISLGcNAJlcvSZ38Bm15xOg36vIs
X-Google-Smtp-Source: AAOMgpd1rd9KNOpxOdpR6z4/6rFXMld1DFzDeJ25j0Kb1KviqX8HwWKVONNqIR4Hqk7oNBqDKFlwhg0bYw7IE/CkIzs=
X-Received: by 2002:a25:9d81:: with SMTP id v1-v6mr9188757ybp.76.1533623442426;
 Mon, 06 Aug 2018 23:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqtvo7m8c0.fsf@gitster-ct.c.googlers.com> <CAPig+cRoxiPUhXFA2vdZWh0iLfitFeN5CbUDduJuRZ0JGw=fvA@mail.gmail.com>
In-Reply-To: <CAPig+cRoxiPUhXFA2vdZWh0iLfitFeN5CbUDduJuRZ0JGw=fvA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 7 Aug 2018 02:30:31 -0400
Message-ID: <CAPig+cRGVaJqP7XFzb9RQDqr543auoawMUmkynXar-paTeL9BQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2018, #02; Mon, 6)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 6, 2018 at 11:47 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Aug 6, 2018 at 6:36 PM Junio C Hamano <gitster@pobox.com> wrote:
> > * pw/rebase-i-author-script-fix (2018-08-02) 2 commits
> >  - sequencer: fix quoting in write_author_script
> >  - sequencer: handle errors in read_author_ident()
> >  (this branch uses es/rebase-i-author-script-fix.)
> >
> >  Undecided.
> >  Is it the list consensus to favor this "with extra code, read the
> >  script written by bad writer" approach?
>
> Phillip's original "effectively one-liner" backward compatibility[1]
> seemed a reasonable compromise[2] between the choices of no backward
> compatibility and heavyweight backward compatibility of his
> re-roll[3]. His reference[4] to an earlier "one-liner" backward
> compatibility solution given similar circumstances bolstered the case
> for his original approach.

To summarize, I think Phillip is planning to re-roll, going with the
simpler backward-compatibility (though he was waiting an "okay" from
you[2]).

[2]: https://public-inbox.org/git/455fafb5-3c92-4348-0c2c-0a4ab62cf2ce@talktalk.net/
