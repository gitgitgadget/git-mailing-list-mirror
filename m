Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F75B202AF
	for <e@80x24.org>; Fri, 17 Nov 2017 21:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762159AbdKQVLr (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 16:11:47 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:39853 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762155AbdKQVLo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 16:11:44 -0500
Received: by mail-pg0-f46.google.com with SMTP id 70so2808081pgf.6
        for <git@vger.kernel.org>; Fri, 17 Nov 2017 13:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1GkaRxGsb2WgIAxdPryziA1LrLyXfT8aCtygHdjfSmg=;
        b=YHJXmJFHtxOSk1pCBvgNn7aj/x1WATZ3JHNiEi+44WtfD0o2M9hqblQL6pzsFQr/TC
         uQ8+9/3n2QXI+XoEUNKqUkmXDjh1pgivjWLLhE8Jvz34CJnR6KJE36xy32aA2UsbssCJ
         bIu+On64fpm7vj/BDxgtR6/Dv0bDqYlmWOZRI+EY78g6cy9pBk5M/YYyH9w7VDMWrA+R
         ZBEfcM5HGCcc9gRZiOrXqjL7qkHax+TtK/AqKqecRkMmgFg0db8sJLVNJk3Z1bHpI48s
         GPqmlU5cbu9w5ImCi0tJjX3Oy1Ie/vDRlkGn1LNfLoWKofkKhpmm+BhMTcdQvbsxigZL
         1H5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1GkaRxGsb2WgIAxdPryziA1LrLyXfT8aCtygHdjfSmg=;
        b=kkPBmHrj6W1lj1wn9zT3WkK4qxa9kXH69XT3a8jXuBWAucLw2tzfDIn89/PkwyZJbi
         RHfOHjpLvzU/e3Dl0BvNs38hxEyvr+jZdw9FFV6fbWK6kT0UYZVMZT9PlPqywv0Rxggy
         5CfbXNw+LOYczRio4f/uQ7rq/wNIcsYbWrRRJywUNVvB3d06rQc5/zNOGaXOYmAaOG+h
         XhpSkK2sC+i2h3sVtj8ioHBGsPsdqWm5vuh0BDK/oq3q2P5JWdzJsr3FucwqDalqd1kX
         HGNf/47U3gitv6DEt8663YP7hlVHN2X3QQlBHwPJ0blnjHbNpujokSZ0ps1sQX9ieegK
         NXRA==
X-Gm-Message-State: AJaThX5cVU+h9inuvFyDIRDlhjwN6MH15n766nFW+u0rlx4no7UXfWKY
        wkp3IfChueDkIveS+s0AXr7E7n0tlRaNkUHl+pYpxYvH
X-Google-Smtp-Source: AGs4zMaDOdh1fLNEJGr0M09TzlXeHj6d9nN04jpE4sLxLovZhmuPwchO88vL8nKAM9tUTbl4I18KQ3+/UMLvvJOtoAc=
X-Received: by 10.98.219.198 with SMTP id f189mr3438369pfg.44.1510953103740;
 Fri, 17 Nov 2017 13:11:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.167.42 with HTTP; Fri, 17 Nov 2017 13:11:43 -0800 (PST)
In-Reply-To: <20171117160759.6397-1-daniel.bensoussan--bohm@etu.univ-lyon1.fr>
References: <20171117160759.6397-1-daniel.bensoussan--bohm@etu.univ-lyon1.fr>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 17 Nov 2017 22:11:43 +0100
Message-ID: <CAN0heSoLbnkfJLqStvR2nfy4LAAc3KEkRH-_kE-QAQoM-4iqGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation about triangular workflow
To:     Daniel Bensoussan <danielbensoussanbohm@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        ALBERTIN TIMOTHEE 11514771 
        <timothee.albertin@etu.univ-lyon1.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17 November 2017 at 17:07, Daniel Bensoussan
<danielbensoussanbohm@gmail.com> wrote:
> +- If the maintainer accepts the changes, he merges them into the
> +  **UPSTREAM** repository.

Personally, I would prefer "they" and "their" over "he" and "his". I'm
not sure how universal this preference is, but see also 715a51bcaf (am:
counteract gender bias, 2016-07-08). I realize that "he" is already used
in this document...

> + ... The contributor
> +was forced to create a mail which shows the difference between the
> +new and the old code, and then send it to a maintainer to commit
> +and push it.  This isn't convenient at all, neither for the
> +contributor, neither for the maintainer.

"neither ... nor". That said, I find the tone of this paragraph a bit
value-loaded ("forced ... isn't convenient at all"). It does sort of
contradict or at least compare interestingly with how git.git itself is
maintained. ;-) Maybe this could be framed in a more neutral way?

> +The goal of the triangular workflow is also that the rest of the
> +community or the company can review the code before it's in production.
> +Everyone can read on **PUBLISH** so everyone can review code
> +before the maintainer(s) merge it to **UPSTREAM**.  It also means

I think you can drop the "(s)". Your example workflow could have a
single maintainer. In a multi-maintainer workflow, the workflow would
still be the same. So no need to cover all bases by sprinkling "(s)" on
the text. (IMHO.)

I'll follow up with some comments on patch 2/2...

Martin
