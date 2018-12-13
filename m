Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAFCA20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 18:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbeLMSSQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 13:18:16 -0500
Received: from mail-io1-f52.google.com ([209.85.166.52]:43010 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbeLMSSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 13:18:16 -0500
Received: by mail-io1-f52.google.com with SMTP id l3so2337041ioc.10
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 10:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hqb4EOB+S9toQ+R8aLwKA7ke+yqGVPuS39WBtJq/1q8=;
        b=qUUgU7EneuZXq2VYtZqDgcwQiDJQcrlp7ra5xC2XycPhV+rDIBo30RMAIDZ4Yk30Ae
         s2P2WkJzVPSIzHYfKQ5Q93f3DSwRhFSWthcPdfTKFB8WAgxzXAb4bC2ua91kkApqHp3T
         NfkQaJkgSyC4F5a/9H6/5lLhptmDEBsGfEqbQRwWyUejgLrtfrm7rVXjQ02UYBhqOq0l
         nl8YUjJhayI6lbnHiTHs8bzUMz5Cr5TIKGTB6LqIrgv054GXf4xSW0ig5XaoUMq5N4eH
         8ZM2F6bZUka19bZ3wKfyl9cFueeXCT55qiP25UPup+fSnWKwiVpji+4PbBG8RUyruGkW
         RSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hqb4EOB+S9toQ+R8aLwKA7ke+yqGVPuS39WBtJq/1q8=;
        b=nHe+VcymyuCNRiCuP4PQxE25FE9KIPnQCe7jJpBbeAIB1W2Trbj5Z1LXntfcBsRBfa
         8eCW7uStvoAiG7hodFs8qj/5/imxyjYFM1FjmYya65Vv8xAiu5429T+LOzf/zN4MldsM
         LilakwnKbpJJKb4RMwOudtUa2lT9niKkt0o+irCD3IyCPNM/Usj3Lh5YWylnmCVgA7xf
         /Dku+FJJk+XBXpc7L/qfhlV8Bc5ZiVrFimxkHk2H2PP22JzXm5tjL0puyRn4gHxqsQf0
         XIj9cEn7mIB9cXU/7wFEP4QKQWVmll1Ftsuj+T9wQiFc8KbnR4P8b+KZIIx8IHcowjVn
         VRuA==
X-Gm-Message-State: AA+aEWbV2D+89j4Yab54zUw2DMMlpZwmgcU9adzAlT0DV3vjB7Xyaq4r
        uaP0coODr652Nk2fAf62axiiuXQsWM0RX9ghrnc=
X-Google-Smtp-Source: AFSGD/Wgy1Ke1tR61yiEs2OvTvkHONuE8ks85ym12ZbchGaKTaa1JTrm3PWaIbkgm0QRIvJYF09GFV500ZcHcwB4zt8=
X-Received: by 2002:a6b:7b42:: with SMTP id m2mr6978795iop.236.1544725095813;
 Thu, 13 Dec 2018 10:18:15 -0800 (PST)
MIME-Version: 1.0
References: <xmqq4lbiey7s.fsf@gitster-ct.c.googlers.com> <87r2el1q0g.fsf@evledraar.gmail.com>
 <CACsJy8AB0gQAvAWh3vtiSFnZWXtdvQdi4czBoR2B8TkECMrQtQ@mail.gmail.com>
In-Reply-To: <CACsJy8AB0gQAvAWh3vtiSFnZWXtdvQdi4czBoR2B8TkECMrQtQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 13 Dec 2018 19:17:49 +0100
Message-ID: <CACsJy8CexGXtyBa1oNP0jVx-+8JPTcfTd5wf1ZyfJWf8HDtLVQ@mail.gmail.com>
Subject: Re: Preparing for 2.20.1 brown-paper-bag maintenance release
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 13, 2018 at 7:08 PM Duy Nguyen <pclouds@gmail.com> wrote:
> There's also a bug in my patch (-2 is already being used by
> parse_opt_unknown_cb and my patch will change behavior of git-blame at
> least in theory).

Ah no. Too many magic numbers in parse-options.c code. It's working
fine but I'll need to give these some names to avoid confusion in the
future.
-- 
Duy
