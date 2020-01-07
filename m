Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F163C33C99
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 11:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFE62087F
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 11:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgAGLfh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 06:35:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33229 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbgAGLfg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 06:35:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so53605964wrq.0
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 03:35:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=603puPalrSy4psZk6vsNl2tFTbJCEDSy/VQF9b9+oV4=;
        b=kuq1eN/MncPA6bx7MXfe3mSLdQ2Y5wWBMby1UNDzm6WOmLHRhn1FIMEUEJ3iSyB+a5
         o093PiZDQSUCKSlKY6cLpEHoNI+u4r0ZanPmh8VsB1BCTCL7X2wpbqSH8ewhonYUWiJD
         Jg0X/p1gRIcJ2vrh4Jg8dvZrf2mMU+iCFGJk1bDCSDktl3LsxSJ02FslGLspKF6AGPZN
         qi0azPH394ZWwQf6/iJaQRlnHKAKQYI1JVo17EAtZMiskGZFAEWfC9Ng1rIXQ6RsMUop
         ASjE7E2pNUIwEHP37i/wWShMjvBV7lFpiKqL1+EA+GpFLLgR/RB8rVj6P3CLTLKcDQ24
         O1tA==
X-Gm-Message-State: APjAAAWJ4gCC4T5K0tW3bs46xHsLTtNaFa+qK9WrCcfw2kyoI0EbjE53
        UWFFgQZD7e7Vx4EO2ex2t5g0Q1ua8CJpRM6nVWI=
X-Google-Smtp-Source: APXvYqxKvsc6MWjPvxnBAJxUGQEooJbL6XAPRJiWIHyNaVMJN11cKngbUHIJMLGMtnye5qHA66Wg52CEXy1Qi830qSk=
X-Received: by 2002:adf:f382:: with SMTP id m2mr108968533wro.163.1578396934579;
 Tue, 07 Jan 2020 03:35:34 -0800 (PST)
MIME-Version: 1.0
References: <pull.515.git.1578391553.gitgitgadget@gmail.com> <ee8636e0ed40888b2a132cff2dacc97754550ba1.1578391553.git.gitgitgadget@gmail.com>
In-Reply-To: <ee8636e0ed40888b2a132cff2dacc97754550ba1.1578391553.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 7 Jan 2020 06:35:23 -0500
Message-ID: <CAPig+cTv5SOxEjjVQ7QvqJ1WbZGbcXegcCP4d5CK+nSdJvkNdQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] doc: fix a typo in gitcore-tutorial.txt
To:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 7, 2020 at 5:06 AM Heba Waly via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> doc: fix a typo in gitcore-tutorial.txt
>
> Signed-off-by: Heba Waly <heba.waly@gmail.com>
> ---
> diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
> @@ -751,7 +751,7 @@ to it.
>  ================================================
>  If you make the decision to start your new branch at some
>  other point in the history than the current `HEAD`, you can do so by
> -just telling 'git checkout' what the base of the checkout would be.
> +just telling 'git switch' what the base of the checkout would be.

Calling this change a "typo fix" confuses reviewers since it's clearly
not a mere typographical error. It looks instead as if you are
recommending git-switch over git-checkout, so a reader would expect
the commit message to justify that change rather than merely calling
it a "typo fix". However, digging deeper, one finds that this is
actually fixing an oversight from an earlier change which already
updated this file to prefer git-switch over git-checkout.

To save reviewers the time and effort of having to figure all this
out, use the commit message to explain the situation. For example, you
might say:

    doc/gitcore-tutorial: fix prose to match example command

    In 328c6cb853 (doc: promote "git switch", 2019-03-29), an example
    was changed to use "git switch" rather than "git checkout" but an
    instance of "git checkout" in the explanatory text preceding the
    example was overlooked. Fix this oversight.
