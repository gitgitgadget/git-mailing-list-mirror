Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6713720248
	for <e@80x24.org>; Mon, 18 Mar 2019 18:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfCRSAL (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 14:00:11 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:37257 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfCRSAK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 14:00:10 -0400
Received: by mail-ua1-f66.google.com with SMTP id x1so5584631uaj.4
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 11:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1EwP6s6ORVNrWGb2RVXIFeeAPA1PSDldwsEDzVFPtWI=;
        b=KdY0Akdq8G0qVh4Ue1VouqANUVji1e3yMSiyDyEsJCBE0nrCxCSd1f08HJjM1VNgMo
         YSAXQgGOLjc0UeE91I9NNSQP6ju/AKi5pNSiSDURrAvDkbso88ANy6tG5FF9pEh5GS4C
         dRc2fjzTt/8n4R2xZcAkiu01axjEN9OLHyVZuoXMyE2NSDFJ9+nJfkyANZem8AUNviqi
         Ffv/7vQ6VgWh8/m01FR+WAnPacnAFuGhHdAl1DCUxI6TM05jzHrHERwIhDut1uLvntwO
         g0u8WLBXRcx9b4/X9PboNOfeTrKtEMO23JfOiy1ksruTAMDSkjpNMMhTUXAfK5qfRUJK
         C/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1EwP6s6ORVNrWGb2RVXIFeeAPA1PSDldwsEDzVFPtWI=;
        b=MsRcmoTML0Szu3Le/+yA28PhlT/IPwalIPxb4v9xTmOeQD4K03sa1ZnCo2Put9axlO
         I6TPkSbEozCcgQtYV5ynZEChQLKJyAwHGc6RswNYRh+0e+RvEaUEVDPaKEsPi90Q5ReV
         QVcSwoAVvfg/JYCeaS5I3bDJitV1fbH1xGWytYc4qa2EA/ZbDdWffWPLQZyMc5VFuNuM
         eLN9/GAvUeZ49JvIUjylP9wEaQG7QQgl82ahqK/Xrs+Nys3eN26tssux7JUN6w6epk2L
         z/UU1SzovWYM7QCp6nFmXb1/WDGhG+1IXqHkEMAYiwaOBOdN9fC1ycyQyffKLA57wlmk
         KOeA==
X-Gm-Message-State: APjAAAW5YbPUA/2BqUWcakOPJnY+wOdA3MehGYMUD9K7wz/y2SFkiPZi
        F2s0SuJxvHiEiVUaLwTgrIGpgK5mPicYzTm3sic=
X-Google-Smtp-Source: APXvYqxG0NnTp1hzuGm5C7da/qiVoAwBUq2y+8i22zzn7Svtob4mKMjdxNZCcbPC4SiM3Qp9D0HLY1hdHhR+4BfvNY4=
X-Received: by 2002:ab0:7817:: with SMTP id x23mr3156703uaq.35.1552932009096;
 Mon, 18 Mar 2019 11:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <bc7c3f9d769b2d5a108ff4cdc3c7277e112fdb56.1552820745.git.liu.denton@gmail.com>
In-Reply-To: <bc7c3f9d769b2d5a108ff4cdc3c7277e112fdb56.1552820745.git.liu.denton@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 18 Mar 2019 10:59:56 -0700
Message-ID: <CABPp-BEy9nN=aV8Y+ueYqv299umHoF2E=8D7heJARM4Qa7P5JQ@mail.gmail.com>
Subject: Re: [PATCH] git-diff.txt: prefer not using <commit>..<commit>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

Thanks for working on this.  Some thoughts...

On Sun, Mar 17, 2019 at 4:09 AM Denton Liu <liu.denton@gmail.com> wrote:
>
> The documentation used to consider
>
>         git diff <commit> <commit>
>
> and
>
>         git diff <commit>..<commit>
>
> to be equal counterparts. However, rev-list-ish commands also use the
> <commit>..<commit> notation, but in a logically conflicting manner which
> was confusing for some users (including me!).
>
> Deprecating the notation entirely is not really an option because it
> would be an arduous process without much end-value. In addition, there
> are some valid use-cases that we don't want to break.

Yes, there were multiple people who commented that they liked to
copy-paste the "A..B" output from fetch/pull in combination with diff
and log (even though one suggested that this gave the wrong output and
what they really wanted was "diff A...B").

However, "removal of functionality" isn't the only form of
deprecation/warning.  Updating the manpage is another one which you
implemented, but I'd like to suggest yet another: Prefix the diff with
a warning message, e.g.

"WARNING: You ran 'git diff A..B' (which means the same thing as 'git
diff A B').  Many users confuse 'git diff A..B' and 'git diff A...B'.
Please see 'git diff --help' for more details."

Having extra text (e.g. commit message or warning) at the beginning of
the diff does not prevent tools like patch(1) or git-apply(1) from
successfully applying it, it still makes sense to humans (and who as
an added bonus happen to be really good at filtering out common
messages if they do encounter them more than a few times), and gives
us a chance in the future to figure out how to potentially extend the
message to make it a deprecation warning and/or provide details about
how to change the behavior of '..' to either be an error or behave
like triple dots or just not warn.


Elijah
