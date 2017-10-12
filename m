Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A79E1FF32
	for <e@80x24.org>; Thu, 12 Oct 2017 02:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbdJLClw (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 22:41:52 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:47167 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752123AbdJLClu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 22:41:50 -0400
Received: by mail-io0-f174.google.com with SMTP id h70so3940601ioi.4
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 19:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nAanuCUP7VJl+n4x9jRg5JeuhHLI7N+fGPM0dP4UhRw=;
        b=QGldlXccFrOtZcOaKCpC92S5ThFlDzeIDYe6NwBUqXPnble4Yox98Y/ltqOAtZiH5I
         n1AzXp0L4jQk1m+rolFv+vpl7E2h1tNEfLdIoxRLR01bVXyPmid4/F6MVHzlqL73/GyV
         /wcpYEeDWcsvI0aRG1Jdf+7Mz/Bec3+OGLDULEH1TwHMPiE/6DuKNo81JNEVvGvL+Cpg
         SPqr9SMC9ArxDxcUQDe734AlA5GnbrOxjj2dB9pzsZy+axJIL6VeyWR4KrE29DtT52Mv
         r6TA+QCnKpzPI7jRmHH/WknIxusoMA35TmUpOyo3LhapFMBoE3EUE1TnWvNiSmCvGR/c
         lv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nAanuCUP7VJl+n4x9jRg5JeuhHLI7N+fGPM0dP4UhRw=;
        b=MCIIXpJMLZbE1U64rgkrTTOr9QTOA1W1wGHT9OhPS4nKSSzSFsREPOdruZ0ORQGL3r
         iHoH5oq+DwMoMXPQsQM1JOKlbsgeIa9pW7BLPZdjZoi03yoH1GVF/qeawZGUwEb5ntZs
         GBQL5MFYdZ2JkJw+d44VuszOxQwefzUQNC/RA9VMT/SIE2NwtgY6x3VyDlENLIzyPw8o
         49OgILzp4J57lIZvu1zmRw+eJGQH27FPIs0InM3+IuzdX4St73a2dvRsULdShgtuYYYS
         xj5sravbaqXvxn8Y8Ls8BVhHWOTy6iFrrKyAeFSyj8gXIRh3vYJPA1+W79vnSPRdePTz
         ZDjA==
X-Gm-Message-State: AMCzsaVC0I1YLPGVF78ifyjJfy3bCOPSW70JN3WC9hDIdujVpySaLkQ9
        sNpFU6WPOJw8RvOxwhmPG0q0STy3l/hyQ50LF9A=
X-Google-Smtp-Source: AOwi7QDfqQX9+MBqXHWfoYrrhcGx0OY3WO77o60e/hjSRM4r2/hX5V8qTbPkMSFk32akZ/XeRQM4U9SWimSAoTR44TU=
X-Received: by 10.107.70.22 with SMTP id t22mr1352067ioa.69.1507776110238;
 Wed, 11 Oct 2017 19:41:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.7.10 with HTTP; Wed, 11 Oct 2017 19:41:49 -0700 (PDT)
In-Reply-To: <xmqqa80x2mb4.fsf@gitster.mtv.corp.google.com>
References: <CAK7vU=3whGsx4L4KACSC+XDWQEbUWuZZZqTsW2R=CbF8d7rkuQ@mail.gmail.com>
 <20171011202505.10113-1-thais.dinizbraz@gmail.com> <20171011202505.10113-2-thais.dinizbraz@gmail.com>
 <xmqqa80x2mb4.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 12 Oct 2017 04:41:49 +0200
Message-ID: <CAP8UFD3VnVod7SPTM11XG=vHBYD4EwA+xZB563iwpL1Ue4pPnA@mail.gmail.com>
Subject: Re: [PATCH][Outreachy] New git config variable to specify string that
 will be automatically passed as --push-option
To:     Junio C Hamano <gitster@pobox.com>,
        "Thais D. Braz" <thais.dinizbraz@gmail.com>
Cc:     marius.paliga@gmail.com, git <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 12, 2017 at 3:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Thais D. Braz" <thais.dinizbraz@gmail.com> writes:
>
>> ---
>>  Documentation/git-push.txt | 3 +++
>>  builtin/push.c             | 9 ++++++++-
>>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> Can somebody explain what is going on?
>
> I am guessing that Thais and marius are different people (judging by
> the fact that one CC's a message to the other).  Are you two
> collaborating on this change, or something?

I guess that Thais decided to work on this, because we ask Outreachy
applicants to search for #leftoverbits mentions in the mailing list
archive to find small tasks they could work on.

In this case it looks like Marius sent a patch a few hours before
Thais also sent one.

Thais, I am sorry, but as Marius sent a patch first, I think it is
better if you search for another different small task to work on.
Also please keep Peff and me in cc.

Thanks.
