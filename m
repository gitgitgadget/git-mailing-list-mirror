Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96DC31FAA8
	for <e@80x24.org>; Mon, 15 May 2017 09:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760429AbdEOJml (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 05:42:41 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:35348 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760081AbdEOJmk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 05:42:40 -0400
Received: by mail-qk0-f177.google.com with SMTP id a72so88819638qkj.2
        for <git@vger.kernel.org>; Mon, 15 May 2017 02:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0JEIsFmPT//IqwReh3vVq+Ai+OxWXFK7Ez2wrMfEm6E=;
        b=ElOCsjT3e4G1Q3uIw2e+1BDa98kOgv9seZanNe1H9WdTaobiab/mTo3ohRuz///rQP
         8+rh+Ae6krfvUjwSedNH+gMdpX+5Dk7+cJFt6tq+9AcEJGqVpg/LSmmf1NjebVnT1mtA
         qqrisjTu8TIlEhoCRCIEMA1SnAJjAujo+kEOZM2X/t8RpnGwDh9d3mByWfuPlp4uTG2n
         Wb4ZfXo4sd4HOsqzanQdDpCjKIGa22eyWrCjKtBHpKu2PvxD2RBvL4uKyoBwRbBwCZbz
         I21PYJpIwM1ZStspd3TYn+yZhEk+DvXUZKO3YDMmntcBsMA11mU3HhF4b7/TZRLlueD7
         LeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0JEIsFmPT//IqwReh3vVq+Ai+OxWXFK7Ez2wrMfEm6E=;
        b=EHdFhEZdN/tQRrJpqj/RrmvMePqu+V5ch9K1kmgLI7wsplAZJ8R83A5pEZIicpx2tm
         5eQWkGbvS/r7N8xsCEAs1GmKyt5+dpR32Mh1iFaQRORuU4RSdXDz39s0ohiBeUlEN4n4
         HAnvu4YWmLPZGzdSit7V9BPl+KYd2pk/mMaALas2UgRTuK9jiF7sXFzQmKycKnfuUDlA
         +qujmO1JFrjUxNUPw3HJeVk5OTGWozwxLadua3TxM78TMFvIOlFAVKxae4P9zKjNXs/u
         bo2o/dbvc1t7YrL14PfhZAZlPEghSfatPCKHD/qu9AdPhBmIUscP1Qcf6vBPZGHSbWDm
         cjoA==
X-Gm-Message-State: AODbwcDa4OiCg7PI+pt3e3ueeKbfHDcKIfu5QXDVWbQeOsDPXrdWSJ09
        bx/SzfXshDSEpjLlL4Ldu/wa9WS19g==
X-Received: by 10.55.108.196 with SMTP id h187mr4237262qkc.40.1494841359985;
 Mon, 15 May 2017 02:42:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.78.212 with HTTP; Mon, 15 May 2017 02:42:39 -0700 (PDT)
In-Reply-To: <CAP8UFD1T77NkP014uebWO2_3ozbEk0Oivwfb_5hoP+AVff1LzQ@mail.gmail.com>
References: <CAP8UFD1T77NkP014uebWO2_3ozbEk0Oivwfb_5hoP+AVff1LzQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 15 May 2017 11:42:39 +0200
Message-ID: <CAP8UFD1UQ2YvyXy2NwpxVOM=bm9unMtrht2n1zqJdCPK8cdBBg@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 27
To:     git <git@vger.kernel.org>
Cc:     Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Carlos Pita <carlosjosepita@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 11:34 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> Hi,
>
> A draft of a new Git Rev News edition is available here:
>
>   https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-27.md
>
> Everyone is welcome to contribute in any section either by editing the
> above page on GitHub and sending a pull request, or by commenting on
> this GitHub issue:
>
>   https://github.com/git/git.github.io/issues/240
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
> Thomas, Jakub, Markus and myself plan to publish this edition on
> Wednesday April 19th.

It's Wednesday May 17th.

Sorry for the mistake,
Christian.
