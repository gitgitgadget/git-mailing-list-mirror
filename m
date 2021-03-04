Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB5CC433DB
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 05:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A76F64EF4
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 05:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbhCDFPE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 00:15:04 -0500
Received: from mail-ej1-f50.google.com ([209.85.218.50]:43130 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbhCDFO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 00:14:58 -0500
Received: by mail-ej1-f50.google.com with SMTP id p8so20583416ejb.10;
        Wed, 03 Mar 2021 21:14:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSIypw1gJds7lAPyMLE7FS5X4k+fvlO0M2Uln3WKofI=;
        b=IEDe16jnhyW+cWqA0dPLFBKF0U04iVnQ2rVMKb6ki7lizaC1D14HSTsk5WEv+qVgLj
         N8CpO2jbLttKSdOyjgmc/YImkgnnUpY7osTSZR2orrBj4t5g5LSspEniKd33lJri+zrO
         a/WkvA7mgyOUnPK/B4m9CLmNFYJF5SqPoRflb0SiF5nDLEKetbcSCalSA7iyanlLfEpW
         LJ92Hso3mPOfKlMyR9CeKLpy0dxGCOL+ZUo3810eK0MIojtGgyka5TMwFS7hi2CQE89Z
         87oLBEUVuPrwNNNXUdWlYtr57MdxJ8bJd0MbfGAlDlS9fYHEj266Kij/G0eZ9H11zsET
         TxLQ==
X-Gm-Message-State: AOAM5311vNSbvzaNtznyQfq/rcFFY5e9He+vJBueJKk2c/YX1Bm63oy3
        y4yAF5aehQmyzTWzdV0S6wpNFyBtrSrPKshJalY=
X-Google-Smtp-Source: ABdhPJzRlgTmF5hN4QBDxejbDzbAXOew/il/TLHwchMUXKBA6NZGM+g9jAoz+gnvE3T1HudvDor7ZtiuQA8jvNEbubc=
X-Received: by 2002:a17:906:3105:: with SMTP id 5mr2361861ejx.168.1614834856800;
 Wed, 03 Mar 2021 21:14:16 -0800 (PST)
MIME-Version: 1.0
References: <xmqqr1kwk0h9.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1kwk0h9.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 4 Mar 2021 00:14:06 -0500
Message-ID: <CAPig+cSC8uNfoAjDKdBNheod9_0-pCD-K_2kwt+J8USnoyQ7Aw@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.31.0-rc1
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 3, 2021 at 7:23 PM Junio C Hamano <gitster@pobox.com> wrote:
> Pratyush Yadav (1):
>       git-gui: remove lines starting with the comment character

Is there some way that this can be removed from v2.31.0 before final
release? It badly breaks git-gui on macOS[1,2] to the point of making
it unusable (Tcl throws errors at launch time and when trying to
commit, and committing is 100% broken).

[1]: https://lore.kernel.org/git/CAPig+cT-sfgMDi9-6AEKF85NtOiXeqddJjk-pYuhDtTVAE-UEw@mail.gmail.com/
[2]: https://lore.kernel.org/git/20210228231110.24076-1-sunshine@sunshineco.com/
