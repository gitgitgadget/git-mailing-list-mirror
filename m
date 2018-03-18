Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9D731F404
	for <e@80x24.org>; Sun, 18 Mar 2018 22:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754557AbeCRWl2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 18:41:28 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:40229 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754258AbeCRWl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 18:41:27 -0400
Received: by mail-wm0-f42.google.com with SMTP id t6so12207533wmt.5
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 15:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iwulKe7igf1yUAeZLoUV7JJVPlP4wVe8hfgNMKuqOuE=;
        b=L0AkVQALO9+tgJKx+WFOYc7KONc+F6mYtxitQEO16fYnEN/h0hi2PPiItHadsTklh3
         HOkTCoU3+CfOubiJa7lpmfPp4jeIn8Xv6+r6mXqEyk1ttBd8IFn96qw+Udo1PA0moaQ5
         OKo6C2cepGfKwmeYUZFb2K5LgJMLDWxgEAQES3A286iiy02XygaxWww+6T7AStt87ZL7
         JOGEOmewG6zmV9FTjHNNdtHsDsVXDkx3AhtTMk2ltvzt8iekHTAlvC/iMaBuuBxHvcHA
         ahGpjoHka+cnsiLSAfWgB3SrNGcpZLkd2PJH+duhBfwMK5Y0J5maz1JnnY++al8/NBX/
         vptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iwulKe7igf1yUAeZLoUV7JJVPlP4wVe8hfgNMKuqOuE=;
        b=mihuaAZbGhPCx7iHXtJu30Gg4l+4PASBzESt2H3NXxxLp6g7LtBifdUbtqKMih6uuN
         eL1VDVpQiEOIwPUMPvYwAlcJ9RIk/2+ndilpmo2Kb/FJlHkbKBUbqrxpcZV5QQgS30BN
         pdpRcdZt6eUsvPiIXGrkz6BVEhEUdBr4sTgAyLXde+PA5a3x4sncgoXnPhi+9W6aFmsm
         MnlIms9y6EKV/qYWP2AEzEkAJ9L1g+LQa4fsRPJcLgMthycYCPencYL1gsoXDgxL/Q9o
         zgRbRu4KxsRxb3DmhMDszBhybDoB68C5oDEJgxGyPSIqUErpR/l2R2VE5Gv1CZ6KVJR3
         MRcQ==
X-Gm-Message-State: AElRT7F/QX+P1ddm9c8w6xDo7e5CVrWbWNuT3HNS/BVvtcmqxR9yjXCm
        myG/0cIP4UB2zovXRLItLWI4yzfSnzgfjpxcfuk=
X-Google-Smtp-Source: AG47ELtOw65f3rCnJn0praFzPOwmsZGHEEuCxGPjJEvtB8fcBKyIlfpuS78WMYKzFr2poLBH4oAu9nWo0U6IieDEEyw=
X-Received: by 10.80.176.162 with SMTP id j31mr11053273edd.265.1521412885861;
 Sun, 18 Mar 2018 15:41:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.158.77 with HTTP; Sun, 18 Mar 2018 15:41:05 -0700 (PDT)
In-Reply-To: <CAP8UFD35QP0jwQ22jfUaNgo92o3vG8bV5n=iYnmn1ichxndphg@mail.gmail.com>
References: <CAP8UFD35QP0jwQ22jfUaNgo92o3vG8bV5n=iYnmn1ichxndphg@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 18 Mar 2018 15:41:05 -0700
Message-ID: <CA+P7+xoL6TRP0NZJR7gQrVeLoQwK_1D_iDmG18Y=_i=U4uttgg@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 37
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Hilco Wijbenga <hilco.wijbenga@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        William Chia <wchia@gitlab.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 18, 2018 at 11:21 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> Hi,
>
> A draft of a new Git Rev News edition is available here:
>
>   https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-37.md
>
> Everyone is welcome to contribute in any section either by editing the
> above page on GitHub and sending a pull request, or by commenting on
> this GitHub issue:
>
>   https://github.com/git/git.github.io/issues/279
>
> You can also reply to this email.
>
> In general all kinds of contribution, for example proofreading,
> suggestions for articles or links, help on the issues in GitHub, and
> so on, are very much appreciated.
>
> I tried to cc everyone who appears in this edition, but maybe I missed
> some people, sorry about that.
>
> Jakub, Markus, Gabriel and me plan to publish this edition on
> Wednesday March 21st.
>
> Thanks,
> Christian.

I don't have a good summary yet, but I think a section about the
discussion regarding the new recreate-merges and rebasing merges
that's been on going might be useful? a lot of that discussion
occurred prior to git-merge (tho it's been ongoing since then?).

Thanks,
Jake
