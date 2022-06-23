Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC04C43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 02:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377342AbiFWCB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 22:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiFWCB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 22:01:57 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41966109C
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 19:01:57 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-101cdfddfacso16670978fac.7
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 19:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QeR+ehmUcosGVVkDy/1BkXtGouHbhHk5vXlildNzwME=;
        b=TZ02vOce++g6qayASASQLTrxoZhoFaDB51ci0Vyi0Q94bVcBGPqJw/B7cnG9qypQGA
         QapNMc0IJYfsOTPm7T9RoKM4NY83+HFyJnFQR+d9BS8CTcn1PZyn+RGXR4h/UgOrlQ76
         22d948DjMvAr6KPNB256PZc7RC9dJuAMcU6Hiw2eGQbFeqwxHAq2aywoJlOua4KpuBC7
         FA9lI8xoGL5WBaGWkZUS07m5AfDJjem7eMiDp+PTVpP68KTOk4Bt5LZ5krzAsr4SHKzf
         yTbKKvSd81/nwv9spT7hyqoWvC62Wn7+LWeVcnT/oS+cKNKBpLTh4b5GgfiuKAiskKkx
         Gbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QeR+ehmUcosGVVkDy/1BkXtGouHbhHk5vXlildNzwME=;
        b=aHvjSkSrTq/ubNiF4G4VKC7ijfm3g7DAReV2R6sUX22FdXyBjN1BuD5XQAeNoZG3Ty
         0P+loYYBIMHgM/r56nbjBcFWTh2nI2loQAAosn0W6dHF5708drOdQEAPx6pEvOldKl/r
         TiMWwTHcBvJVJyHO2zRsIIdAKo0w+BlNTQAHq3SeALre8UuDvZB2vY6MNpD4pPnqzzFJ
         JdTA1ifppH4aUBi7KAZm/zjWkqgwqhhy6Qtk4iCH/5d8QgjdefAPZ6iGJOz6TGYq3cEz
         9Sdd3NmaHlTVpQYc0crS1wLddghKUs8tC784atRGU5Wc/uObbmIEGQY1lz+S7w8q5Y63
         b44A==
X-Gm-Message-State: AJIora/LnGD6hMFbIWpMdJgtd8qFo1kAik3ZNhmg+3VuToB6IbKIEaeV
        SB2E32FUBNCN7Bhcxl8FVK0AoNb3PSP1z/jh6U0=
X-Google-Smtp-Source: AGRyM1ufKCR1mn2/7K6CzAEjeyAODUQZk1iP4P+uDf4gGJnmzF2HbAfQAZkXEbVwM05O48LcdHCqp+TDS/n2g5zCLiw=
X-Received: by 2002:a05:6870:a2d1:b0:101:ce47:e1e6 with SMTP id
 w17-20020a056870a2d100b00101ce47e1e6mr941216oak.80.1655949716645; Wed, 22 Jun
 2022 19:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1280.git.git.1655927444821.gitgitgadget@gmail.com> <xmqqpmj03183.fsf@gitster.g>
In-Reply-To: <xmqqpmj03183.fsf@gitster.g>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 23 Jun 2022 10:01:45 +0800
Message-ID: <CANYiYbGgS8hYUpAHJBmw0URcwTm+jpXHWK4DA0=jPHYpS53W1A@mail.gmail.com>
Subject: Re: [PATCH] po typo: l10
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Arthur Milchior via GitGitGadget <gitgitgadget@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Git List <git@vger.kernel.org>,
        Arthur Milchior <arthur@milchior.fr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 23, 2022 at 4:26 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Arthur Milchior via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Arthur Milchior <arthur@milchior.fr>
> >
> > It should be l10n
>
> It should be, indeed.
>
> Thanks for patching a 10-year old bug, introduced at 75b182ae
> (Update l10n guide: change the repository URL, etc, 2012-03-02).
>
> Jiang, I can take it directly to my tree, or I can pull it as part
> of the localization update before the release.  Let's make sure we
> do not drop it, each expecting that the other party will pick it up
> X-<.

The typo was from my fingers, oops. Thanks Arthur for reporting.

Junio, I will apply this patch to my tree as the l10n update for this
release, and will send you a pull request before next Monday.

--
Jiang Xin
