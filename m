Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CA9C43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 14:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350911AbiFUO1x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 10:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiFUO1v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 10:27:51 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D003819286
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 07:27:50 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id v143so17261824oie.13
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 07:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Upf6s6HU47fbztlr63XHLj/iSRvcVkM0NUSlMftPXFQ=;
        b=FHnljjBNf/bRTw/C3a4GMTTs4NB36Z9Ou8Izt/jfbSo8v2TRYYQ5JoHWX6MKH0ELQL
         c//+HvKBPzQpYkGiqMSFpPnjCxJ+edVxQtVEj921eRIqxDyLsYovl/8V38Pz5iYsx462
         Njy+W5mRNPhP5W/iL+5odmnyYJhLmuLCZ0UE+DA9Vz551IBSKwc8rAEz6u/DX9YiVMdY
         YPZ2EDIZCSCvUcRJyakCUB6G4fZTrkopxppeFtReyuu7rl6oDcurhY0X4X+aLhg9Givp
         83hDUDNHMF2bti27GB6f90XHL+Jza05UgWpHCcKAoZdiqR+yBsQCPGb72EnP+JvwmnqY
         WiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Upf6s6HU47fbztlr63XHLj/iSRvcVkM0NUSlMftPXFQ=;
        b=XlTRNqVqqLwfoszZG2NGdopoI+ZBSGe6fjoUFLex+CI9Ki7muQ0KTEIMyZ+u7cgjU8
         lyX5AzZHdFEbvnr3YMtRJA8a+MoX/bjIoBd17sx/+/XX2WOgbcgP89+7QIWBVhZSw/hM
         ZmYLhYWfwm+URANzqby/8ei4s0nqxTYLWNna0lreuITBePGkwoLumdRgkZgslOLhnlnu
         3ja5E4+W/UHkQjvfbx7B/sL7ez6IbON2YMJ6k1iwMIh0ytG0tgQNXU8juZFQRab9WqR4
         Re6kAecepmT7T4FVMYDO2/R1X8g2KEIYRjw5en6tY7sQMNYGyN6zoLB5DVDlB86+SmLi
         cHpQ==
X-Gm-Message-State: AJIora+GeBEgLkidwn48nIi9rjk2Zy3NWTf0961jw7uPo4UaMdqHRTWC
        mUCHkHme0KTWxK5XDvHIvXJJY0nArRJvaFP0ISw=
X-Google-Smtp-Source: AGRyM1v/Ie3W6lIeq8vpooq0AHtvuqfEP/1gPrtLiUp2BFOhxaRLmkjtJdTAHj65+Bzmsox2Z5QCcbX9dR2Kk5qeQYI=
X-Received: by 2002:a05:6808:15a5:b0:32f:30cf:848e with SMTP id
 t37-20020a05680815a500b0032f30cf848emr14499229oiw.80.1655821670094; Tue, 21
 Jun 2022 07:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1279.git.git.1655819439775.gitgitgadget@gmail.com>
In-Reply-To: <pull.1279.git.git.1655819439775.gitgitgadget@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 21 Jun 2022 22:27:38 +0800
Message-ID: <CANYiYbFju5PBZdx4EpZzG8uNw120hXwG2iCsuCd4hrub28-8oQ@mail.gmail.com>
Subject: Re: [PATCH] l10n: mark message helpers prefix for translation.
To:     Dimitriy Ryazantcev via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Junio C Hamano <gitster@pobox.com>,
        Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 21, 2022 at 10:13 PM Dimitriy Ryazantcev via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
>
> Some messages prefixed like 'usage:'/'fatal:'/'warning:'/'error:'
> were not translated.
>
> Signed-off-by: Dimiytriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
> ---
>     l10n: mark message helpers prefix for translation.

1. The prefix of the subject should be "i18n", because your are
marking strings for translation.
2. The subject line should not end with a period.

>     Some messages prefixes like 'usage:'/'fatal:'/'warning:'/'error:' were
>     not translated.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1279%2FDJm00n%2Fl10n-fixes-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1279/DJm00n/l10n-fixes-v1
> Pull-Request: https://github.com/git/git/pull/1279
