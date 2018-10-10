Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7BE61F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 09:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbeJJQfP (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 12:35:15 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:39479 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbeJJQfO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 12:35:14 -0400
Received: by mail-it1-f194.google.com with SMTP id w200-v6so6921848itc.4
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 02:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d5rjPAT0SWEQOQp/x71JcDzVn3MKFBapBET2cKBHGRE=;
        b=Hjtjw+3bLHfy4UyXZFzybRR3K3Pi4nxf+xiVNaEZEZR5dKeIXngZPtwu+ICWBjvwij
         p2sgtOndVpEGWRvwyT6Zd8zD+A33oxjzcAOgj1uihtuso/iMWIJBddrepqAqPEYzPeQM
         8mSQvyffSu3Jjf3KUIeAsfM/mRFniJZS/MwoBKb2btG5c9zi6nOSKmTvebJgnfhV8oGs
         f5dR5AyUYgXpAuZBlUK8+XX2qxSRylFSB0V0+A+2VJQVLK6xmadNOUwDtAEUorpYHBmX
         mNprsVyxzA8ashALrMStC8HAy6WdxpXWzM7Fhz6esDhUrmRIqGpTu8npjD1E30Hy6DQ+
         9Oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d5rjPAT0SWEQOQp/x71JcDzVn3MKFBapBET2cKBHGRE=;
        b=cMtOfcUhKjvD8DxalJpqwO3op2bnmsrdcs+VBr2dO+oPk3cHYMhRMT2IiZZ7i8OhvO
         2Yt5tDi7fCLN6v+Sslw6N5wawKcUte7NwO6V7nr0GjOPl1vbZSHdK2Gc1uAhbT77nC3Z
         rdQRJTGtVBRIjxMIwsxO2HY+uOiWIQQH1qASICu9nRJAQpiOz6fCf1rSGcg/I7fy/iTW
         HOe02v0YGaQ1ml4Av1RHxF3wdhxInnwHq3AbzUiZkzX/ksJHsx/0EeYc7UD0O855WupH
         8ieUB7JLgDlpvpPxul5C7iZYkhUqO+2bt46BMdmFnUN8nhC78nZYA9U5trzyn4Zfd2ct
         H0lw==
X-Gm-Message-State: ABuFfojHJYfeUA2RVXn9c8xev0Nqpgbsah+nCJ/PPOdznMayKQ46hQcj
        HWz4u7wJSEpAHc6ag0oBIuB8xa/hhBZhHqeBSU4=
X-Google-Smtp-Source: ACcGV62w7ucQ/AoTh6wAD7NfMCmR68qDraeG7E6QaF+DgTKqvrjyilleuJMgmFBIp/1iJ4IMAUMPJvMXrdERb9w6u4k=
X-Received: by 2002:a24:cac6:: with SMTP id k189-v6mr72532itg.168.1539162839018;
 Wed, 10 Oct 2018 02:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181008170505.GA13134@manohar-ssh> <b1824db3-1c0d-6851-2f5a-800cc88ee50f@gmail.com>
 <xmqqd0sjpgw1.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1810100856570.2034@tvgsbejvaqbjf.bet>
 <xmqq4ldumbo1.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4ldumbo1.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 10 Oct 2018 11:13:46 +0200
Message-ID: <CAP8UFD1_CH-OGytqcLya0GdFAM3=TLpgwiXQCO__9GSR6SXe_Q@mail.gmail.com>
Subject: Re: [PATCH][Outreachy] remove all the inclusions of git-compat-util.h
 in header files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>, ananyakittu1997@gmail.com,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 10:46 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Personally, I find the "whoever is picking it up should do the thinking=
"
> > much too harsh for a first-time contributor who specifically came throu=
gh
> > the Outreachy program, i.e. expected to have a gentle introduction into
> > the project, and into the ways we work.
>
> Oh, absolutely I agree.
>
> Any random discussion participant can say "left over bits" in any
> random message with an idea that is left on the table.  Looking for
> it may narrow the set messages to be examined, but the query result
> will inevitably be still full of chaff.  It is not a very good match
> for "gentle introduction" material for GSoC/Outreachy microprojects.
>
> List of reasonable low-hanging fruits is hard to maintain, as the
> cost of building and maintaining such a list would easily outweigh
> the cost (and fun) of picking these low-hanging fruits yourself X-<.
>
> I do not think of a good solution to help newcomers offhand.

In the "How to find other ideas for microprojects" on
https://git.github.io/SoC-2018-Microprojects/ there is already the
following:

"When you find something you are interested to work on, please ask
first on the mailing list if it=E2=80=99s worth doing and if it=E2=80=99s a=
ppropriate
for a microproject before starting to work on what you find. Even if
it looks straightforward, there could be hidden reasons why it is too
difficult or just inappropriate."

So I think one solution to this problem is already proposed on our web site=
.
