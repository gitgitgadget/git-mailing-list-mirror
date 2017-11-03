Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8E6A20450
	for <e@80x24.org>; Fri,  3 Nov 2017 20:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751770AbdKCU0W (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 16:26:22 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:55544 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbdKCU0W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 16:26:22 -0400
Received: by mail-wm0-f45.google.com with SMTP id y83so3813321wmc.4
        for <git@vger.kernel.org>; Fri, 03 Nov 2017 13:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0tLcmaNjsJJmEZgLCWAUEJbJcF3eGVThEN3vwrMIdiQ=;
        b=bgmk/poDduWPKTBTF/Fr0V3crWXCfGxTwsf6n3ujLq0uDw6YusJAu+V8gEPx5ncSgV
         XudGxK/aPZxE0xoeyuMzoc+V43Yi6SfzDzH4q7cxtrVm/gUDUukQDIj05b3apau3h0Jq
         gppIaFmbg/BAl8pCsL77SYqobnYimUwsjGGdZKfhC47osLvNRGzhCWT4nsUuInzKe0Mg
         wHyMQl74fQ2BoeH2cBOb5La8tYVR64aT78+DwbxGwUh1Ia0i9byow2lEJV5RMYYOXzV0
         Y6tQjZf51T/uk4//OqQiKgbcRoGSv0Ao4Kg/ff4680xqL521+QNsF9/neAsksEK1y9Fk
         HXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0tLcmaNjsJJmEZgLCWAUEJbJcF3eGVThEN3vwrMIdiQ=;
        b=tbIGmr/W1IBr2NuB/+ndXfGttLQcB2orKA7oyC3noFMoxnV9TLRur1PpngGDKpZAAA
         EVlFaF7RtFbRBxmYAymCrW7c3681MpslREHw8TPESAructKqXkorZZZ8IloKYunEGc5h
         pSPxqHeqxvZ0kA7ZMvIOpfmWGFwvRakz9wzz3nT5bJpz9j03KLlfXfBGU4Xj5y215eYd
         om3HFdEEqGmXmEPMWca5PrftHXTTA43yL7gc5AkoKm88P5/Lz4lGuk7ZajAUeef31tPu
         TAiD7yJ4LRZ5OuDRE44xuzpZISsk231KaQc3Lqi272BBACEI+HjHes0tmz90d/rEo4vc
         PyCg==
X-Gm-Message-State: AMCzsaXriR5l69Y5tXVJmg2arbI0lGQ1e8xMAIsgVwzRLyQ4BZxESRPi
        W4LTLfpi4grHRXvUTPo6VnvOp5zsIetYHqqHa+0=
X-Google-Smtp-Source: ABhQp+TclQjBS9JfA0zjfkOSl2jyZ/PAzP8KjBnhzbHMaPiVSLTBM7KLhmiIPi7zCHbpcnoZt53JiQJ328dMUUlogHE=
X-Received: by 10.80.181.90 with SMTP id z26mr10682439edd.76.1509740780641;
 Fri, 03 Nov 2017 13:26:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.213.80 with HTTP; Fri, 3 Nov 2017 13:26:00 -0700 (PDT)
In-Reply-To: <CACYWVif=zSiXpqVL0td+Mgu-Wz=AzDL50kREcXJY2Dtf_4_y_g@mail.gmail.com>
References: <CACYWVif=zSiXpqVL0td+Mgu-Wz=AzDL50kREcXJY2Dtf_4_y_g@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 3 Nov 2017 13:26:00 -0700
Message-ID: <CA+P7+xpzmu2AtcFnD5tC-mW18EhNXmk6TXZFzJG_=wYUoUfxgw@mail.gmail.com>
Subject: Re: submodule using revision
To:     gregory grey <ror6ax@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 3, 2017 at 6:42 AM, gregory grey <ror6ax@gmail.com> wrote:
> Hi guys.
>
> Currently git submodule only works with branch of the submodule in
> question. Adding a functionality to work with a revision would be
> great from my point of view.
>
> Proposed syntax is as follows:
> git submodule add -r commit_sha git://some_repository.git
>
>
> Thanks!
>
>
> --
>
> http://ror6ax.github.io/

You can get similar behavior by doing:

git submodule add -r <branch> <url>
cd <subdir>
git checkout <commit object id>
cd ..
git ad <subdir>
git commit

Thanks,
Jake
