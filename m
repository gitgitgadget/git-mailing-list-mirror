Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B48C20248
	for <e@80x24.org>; Tue, 26 Feb 2019 18:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfBZSax (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 13:30:53 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43534 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbfBZSax (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 13:30:53 -0500
Received: by mail-lf1-f66.google.com with SMTP id j1so10384819lfb.10
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 10:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W6b8fTc8ahL2SmciNJ7/EH+Ahgb1mpgfx8bsl5Zx18M=;
        b=pUYnVUtRQE2FXo0Pffuf2gNCJM2BpyqqarLe36ndVmMjkwDhZVmjCVyvBKXS1LkX7K
         tjeMvoECjilmZX7kO36rQooGWphcm407aAhB7nh/VL/8uVhIyCYVL8I3JSFvbumtpR8w
         0FvuXlgfwYCSRGaXDLwV2FTLks+xLRV2PCAZjB29CQP8WG1uRy2CjmBoEjRrUmFmRVM6
         StQuN+BaAet5dx2bo5o91EC/cNlnqave+NjfrZW2ayR+ho+kJ6mSQUX/+8rXzMlnok9V
         5Hz+ZWk3b4T9QL7nQbghcIzbBMy262vsqyUPpyFidi19aWHQWdnvtmOWmtN+NKLru+pH
         gAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W6b8fTc8ahL2SmciNJ7/EH+Ahgb1mpgfx8bsl5Zx18M=;
        b=ijs/0hUqEkYrDLFJpoeU3ZCrKTI+7cNsFj5oi3vwVzFwwYXYH+lyno4CEw+u//AfZK
         C0FYj8542CZ/VwqAp4WP0x0qPdYSecblljWyiXC5+eLXGlGe9LUIP/QWgcL1kpP+6hM9
         ed6+ew871yino0LgOs+JWlTC6zsH+WSjXwqhZDLIegDjVMyDMOBqfl8VoACSp713eWKQ
         x2V6WpisoRqDodELemiwG/mgUIoX0P/UzskMDLb/OM6I1dv9YAt1Pgc4bzfUhRWx6Bqj
         z10yhZSEYx/FXAVVTQQz2ax6s1SxFAgudro12Rf6uYze4nypb7KQAvFSXOxXRuuyefm6
         oIww==
X-Gm-Message-State: AHQUAuaGYE1Ued/Rrlu2M7Z9G1gmumtesrknCweXVaPgVb3n0S3ACPVx
        VZO5WY/9O8kDyI5VUWQLDIA/6hYmI7caQGjjapNr/46tE28=
X-Google-Smtp-Source: AHgI3IarkUpRblLexiBJF5AZrN09sUUm9sXEeW3GB7MphCAvNZsxuLrw9s88Qoss4k6v9VYRcltE7scbMv1Nnfu32Ek=
X-Received: by 2002:a19:9112:: with SMTP id t18mr10005867lfd.19.1551205850685;
 Tue, 26 Feb 2019 10:30:50 -0800 (PST)
MIME-Version: 1.0
References: <pull.152.git.gitgitgadget@gmail.com> <bf5eb045795579dd5d996e787e246996688cf4bf.1551188524.git.gitgitgadget@gmail.com>
 <CAN0heSqSp-a0zUKT5EaGLBYnRtESTnu9GKWtGARz2kaOAhc1HQ@mail.gmail.com>
In-Reply-To: <CAN0heSqSp-a0zUKT5EaGLBYnRtESTnu9GKWtGARz2kaOAhc1HQ@mail.gmail.com>
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Date:   Tue, 26 Feb 2019 23:59:51 +0530
Message-ID: <CAL7ArXoau1ZfBsV9JaUDprwjSijyo6K5d9JyC1mdfc=KEvgJxw@mail.gmail.com>
Subject: Re: [PATCH 1/1] tests: replace `test -(d|f)` with test_path_is_(dir|file)
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin

On Tue, Feb 26, 2019 at 10:01 PM Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
>
> > -       ! test -d submod &&
> > +       ! test_path_is_dir submod &&
>
> Now, here I wonder. This (and other changes like this) means that every
> time the test passes, we see "Directory submod doesn't exist.", which is
> perhaps not too irritating. But more importantly, when the test fails,
> we don't get any hint. So a failure is just as silent and "non-helpful"
> as before. I can think of a few approaches:

>
>  1 Teach `test_path_is_dir` and friends to handle "!" in a clever way, an=
d
>    write these as `test_path_is_dir ! foo`. (We already have helpers
>    that do this, see, e.g., `test_i18ngrep`.)
>

Yes, I also think that it should be corrected and I think this(1)
approach is good as it resonates well with the existing code. I'll
start working on it and submit the patch as soon as possible.

Thanks
Rohit
