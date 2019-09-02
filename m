Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 397B51F461
	for <e@80x24.org>; Mon,  2 Sep 2019 18:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfIBSII (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 14:08:08 -0400
Received: from mail-ua1-f52.google.com ([209.85.222.52]:39238 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfIBSIH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 14:08:07 -0400
Received: by mail-ua1-f52.google.com with SMTP id s15so1415040uaq.6
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 11:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nsGinoBPuT7mLg1ArgWVeXvSqtvpDcH0dN+B026PaI8=;
        b=ve708UKHUynzFUufkY/frc4fGBpyWV4Imv9NupOnHeP1ez3+i28KoCBImtL86tDAFL
         mOD/1vI45smU5yg1SNmvSZ8q9y+P4Be13ify4AIbSP4UthorTZ9M6Po+eP1DPd/cnbJT
         IdoccfmylnMfiJY57aCkFO7j9DYrOsuKKkNXoFXJgDuYat+gdd8tjYa9ojATOHHrJJTY
         +mMmiaZ3c/6z/6c5ECnN8IVpgH14YVOMrjmgsKNXfqG5zcsaDTu7k2jbSKOIAuPE2wt2
         I119lM3Z1JK0277Am3d++ubMjpcAo4oZjNgmS+1aruXhxjY0Enzy8XoW9K7WLhMfzBxd
         YP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nsGinoBPuT7mLg1ArgWVeXvSqtvpDcH0dN+B026PaI8=;
        b=nv5plJio5UqsX/xfN/8bpsiUF/ZC8kC5u6BiFSKTg/QO2S69aQsPR8QHY7Rdog7Jcp
         0rnhi+9eMqUAmfYye+ihQYHP2eygYKBSkdskqq2uvdLABuFbnKLwaD4Y7YgM/8pWT4kt
         q1od2pWe0y3mVIJbzj4lh1Suml3RcYSfFXKg7sQbX5nGvcr/2mHo9Ez7dtvq+8G1+owj
         GhchUIs1WIvqeNFSijt132Cr/rP9xKm6k8E3sspwXd98vN2ygI57a/yMHp7+pQUZnzWb
         Krx/FF0YA4GnezYOlsgr7w8z1jaH2Y9x6OeNQcTKKJhy9EjXVoZOFqke5UgksErcnIcN
         hf/A==
X-Gm-Message-State: APjAAAVXGtx9VNw81Zosz192uI/AyIMLzYJiWoKuiBT4RzCThLCxNusP
        Jd+1I0qxdwYimDGO6aXiTetX46ToFFOoF1g3kdI428Mo
X-Google-Smtp-Source: APXvYqxwJxx+XeuV5v+oRC9hpbEx8VXw5MHIpx9nw3/6jB0OPeB7ouqEN/zFxb819lJ0XDwPzVFFojRVOho5lFggm2U=
X-Received: by 2002:ab0:758a:: with SMTP id q10mr1151770uap.76.1567447686728;
 Mon, 02 Sep 2019 11:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=Jw4DAqTi3ROujtE=xBMYErMws6B6vhuXYMQA+5Q1ccow@mail.gmail.com>
 <CAGr--=JkNqcrcenp6F1_CHTun_9wPLVvEWGOFJW=ng=XfO+jHw@mail.gmail.com>
In-Reply-To: <CAGr--=JkNqcrcenp6F1_CHTun_9wPLVvEWGOFJW=ng=XfO+jHw@mail.gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Mon, 2 Sep 2019 20:07:55 +0200
Message-ID: <CAKPyHN3Zvf6gtKAq03s8AsguaOFG=g2huGRCTWmBVWioDBqFWw@mail.gmail.com>
Subject: Re: feature request, git-gui: add hotkey to toggle amend/new
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Birger,

On Mon, Sep 2, 2019 at 6:25 PM Birger Skogeng Pedersen
<birger.sp@gmail.com> wrote:
>
> I just now realized what a terrible suggestion CTRL+Z was.
> I propose CTRL/CMD+E to toggle between amend/new commit.
>
> On Sat, Aug 31, 2019 at 12:51 PM Birger Skogeng Pedersen
> <birger.sp@gmail.com> wrote:
> >
> > In my pursuit to fully utilize git-gui with only using a keyboard, I
> > suggest that there is a hotkey to toggle between selecting "New
> > Commit" and "Amend Last Commit".
> >
> > Not sure which key-combination that fits this purpose best, but my
> > suggestion is CTRL/CMD+Z.

I think with your "focus" patch, this is not needed anymore:

After focusing the commit message widget, you can focus the radio
buttons with Tab/Shift+Tab and press Space.

I think this is short enough, so that wasting a Letter is not justified here.

Best,
Bert

> >
> > Best regards,
> > Birger
