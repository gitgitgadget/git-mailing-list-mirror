Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B9BC1F461
	for <e@80x24.org>; Sun, 19 May 2019 18:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfESS6Y (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 May 2019 14:58:24 -0400
Received: from mail-it1-f177.google.com ([209.85.166.177]:37755 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfESS6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 May 2019 14:58:24 -0400
Received: by mail-it1-f177.google.com with SMTP id m140so19762214itg.2
        for <git@vger.kernel.org>; Sun, 19 May 2019 11:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sWU+qIWO73ALzeI2HlrJGY2stf0sx+3M3pRLb9NtYys=;
        b=GRIX2+3JlznOE+VyN5nng+EsPjt1NyrVIC9Fpd54T/vN7JP4p1VvLVlHSGmNf/tipd
         BPL0d7bmj/a06Btm7j6+V6SlTTWqR6PCPNnLhnsNxWTYqksbfcgJMyASO4EWVVz40AnY
         sz6vfJnJl6Drzk4bzDlwPbz2toNqLLkt1Nrr+8tepIBMbQXOlR6XvbkviZgfKzN8iylj
         vZLO1rAx+prirhLgs/8k5LInpbuxGGMgmahpn58pwH6GuYxTxCOe9ulc+Hrft1q16Zg2
         dSVMYWjA1GF6CEamOOrODftWrC9uKNQob/1E0XxfViKbNfvT1OFLDbwhCZ2n/C3uyWl1
         XzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sWU+qIWO73ALzeI2HlrJGY2stf0sx+3M3pRLb9NtYys=;
        b=l+ZASraf98c4+XSg00gZeYPznlKk3dtMa0ncSqF6o0u5oF1OJCtBflmytTkeJbc+nr
         ZFFObvzCGUPfJM5VOSwLFoQJsrrATXPRI5c1wrToPc3tt8Lw9kCkJaCpNXeN8p6ti2ak
         FmhWienjMrD1jDpOGiwytLTRrcX8fgLkEDw1C/JebPvgCwYEFUzfS0JaJoRE2ukn08sA
         OJfhM1n8rWa+t02lk1tzsZJbDnQeSKeyoR1kbcLtKXgRWzsWmp0NmzPyhFRTwAdvg27P
         9Vq4xbVul1TFjha6FTniOaEytraLl/4Ung59XeJmjrFsRT6FywXeCsaKTBGYYNX+yGO2
         V3TQ==
X-Gm-Message-State: APjAAAXgZcjF+jGFH/c8TXjx6WngtHiJbkp4G+IaCaFFgJcEmOkPu4xr
        6MKZhOkrHf0EnspIrOZVftZZ+ofeCKTA2JGrBtwmzQ==
X-Google-Smtp-Source: APXvYqw6VqsaNLT9WUureWu8es7q7xeaF/4l4y43vvDCDRy9f6hY7B+Y+FCoEMWRtAtvZNUiHyx8oPCyFGqhU5/mI38=
X-Received: by 2002:a24:194c:: with SMTP id b73mr23211775itb.157.1558235178282;
 Sat, 18 May 2019 20:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <dcdff07d-77c7-8cb8-fa06-82acda5fe9ec@iee.org> <87lfz3vcbt.fsf@evledraar.gmail.com>
In-Reply-To: <87lfz3vcbt.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 19 May 2019 10:05:52 +0700
Message-ID: <CACsJy8B_3ZytR+5HvOax=ngw7ECse8_5ajkOvUEcOj3MuNxQvQ@mail.gmail.com>
Subject: Re: Command to list <pattern> Branches on a specific Remote (i.e.
 select from rtb's)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 19, 2019 at 1:41 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> That's:
>
>     git for-each-ref 'refs/remotes/<remote>/<pattern>'
>     git branch -a -l '<remote>/<pattern>'
>
> The latter will conflate <remote> with any local branches you happen to
> have prefixed with <remote>.

That problem should be gone if you use -r instead of -a.
--=20
Duy
