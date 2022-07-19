Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358B0C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 05:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbiGSFVT convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 19 Jul 2022 01:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiGSFVS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 01:21:18 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC24627CD0
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 22:21:17 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-31cf1adbf92so129337167b3.4
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 22:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DbTZn0ANoxb9k3Rp8Vde20mJ5KeWjMijxJS6k4XVBYw=;
        b=pEPkxGNo9+UJeFMGADcr/iaj3MEDgo8XHAsXFT4sKgyvUwH3SFFLAUSv8kcWcy3Gcx
         fnLb1mesRJyQBTZ7DxW6CHTN8XSFTW+oqn++c7b87vyYoWHs4F51dlOyCAughyXq05RQ
         n5y+R66WU4rWnuvrUWQgpchKTXMQeXpxURGgZasKqY60kpCBIefhBI/h1UIW8WuWoZCn
         KwAGZ9wv/CfJMkqA5zweMchbw92J3JQlgj5tsmajA09dR+n+it6mcNk6gbyI5CfMzBze
         uesdb4miEwq+mopyxF3u1HpGPyA+tvTKYP88+lUTg+N4MlPS9UmfsRMIscO783+hSi8j
         lGSQ==
X-Gm-Message-State: AJIora+WH48z5YGEJKej6TtxX198XfzdGwQe+ZJSbc6S+Bpjc1ZLGrxP
        XT1dYMnOHXqiOlUGcA9AwdlHgzQ9t1PR9kBIjwp9laQenMY=
X-Google-Smtp-Source: AGRyM1sYTOrNEcu1tg/4M8s8VH6q5oo2r7pSU4v19MgUWPwlSMEm5hbBk+KJHXhMm0sthHZW3dSBBjlWitkEUWN/Ewo=
X-Received: by 2002:a81:a50f:0:b0:31c:af85:35f1 with SMTP id
 u15-20020a81a50f000000b0031caf8535f1mr34227278ywg.70.1658208076959; Mon, 18
 Jul 2022 22:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220718154322.2177166-1-martin.agren@gmail.com>
In-Reply-To: <20220718154322.2177166-1-martin.agren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 19 Jul 2022 01:21:06 -0400
Message-ID: <CAPig+cTb30T0Yq2MdrrT3zuq3_YVEAXia79rgReH0wrQpzHuKg@mail.gmail.com>
Subject: Re: [PATCH] t4200: drop irrelevant code
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 18, 2022 at 11:45 AM Martin Ågren <martin.agren@gmail.com> wrote:
> While setting up an unresolved merge for `git rerere`, we run `git
> rev-parse` and `git fmt-merge-msg` to create a variable `$fifth` and a
> commit-message file `msg`, which we then never actually use. This has
> been like that since these tests were added in 672d1b789b ("rerere:
> migrate to parse-options API", 2010-08-05). This does exercise `git
> rev-parse` and `git fmt-merge-msg`, but doesn't contribute to testing
> `git rerere`. Drop these lines.
>
> Reported-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
>  This is quite late fallout from Eric's review [1] of some commits that
>  have already gone in.
>
>  [1] https://lore.kernel.org/git/CAPig+cSjHg2-WYqdkZAS0ye1goj_=5RN3mdjt0-4kSBqNm6WLg@mail.gmail.com/

Thanks for following up on this. The patch looks fine.
