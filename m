Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E25A1F404
	for <e@80x24.org>; Thu, 14 Dec 2017 21:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753751AbdLNVgt (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 16:36:49 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:41460 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753683AbdLNVgr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 16:36:47 -0500
Received: by mail-it0-f46.google.com with SMTP id x28so14899633ita.0
        for <git@vger.kernel.org>; Thu, 14 Dec 2017 13:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=In6ANs7IdFG8rO43cXX2irfxALXjY5qbNXx90JIfeCQ=;
        b=Cnjicmi4OgSYQ+WpeeBGFfrY220Wz6tpLz76LDwaBPPuqa3W3Zs1m1Cm+JmMDKgjCB
         GWT79zd6nXsU59W7+uYug99JWVrUik4W72Gc3vBDhExFiptwJ7lTxvXnjnhrsyS2Itqm
         KLa08hY3r7Tb8ihBQa+Az8wqIzq6RPDN2lUoISX+38NyJPE9wR4mG7zAWG06us2vbgFw
         je7pFh1Xk9eI6uL7xbdKkkSCKV5suBks74n2ic+CfX8sqVCzaQfDSPBg/OHyVRBV3jOA
         ui7PNdfQ1ICkkzKqsZ1iXqWSpXCWzpU15XJSaKaqwRDM+BWmJhlUoYl8P4TCkNZZalQs
         mxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=In6ANs7IdFG8rO43cXX2irfxALXjY5qbNXx90JIfeCQ=;
        b=UOecolZ2XyrwqLcGdKO3FnSY/N/HXp0QiNKXZlwQfrJcV40TdgNJbvGNNOspQUVpz1
         vQdjWc2l2xCpSzs5DYqKmsINoDgIi/JZQZFafsjEOHSbrafyoyBgMg6E2nZaCqa5BLy2
         7WtLg5mMMQT6FZWCai4d5bSrzc2F3t9iD8wEngnuHFCDAvYs4jvbtslTiT7pw7s8DcSx
         ru28SVEokDLsG5+LDdsjEFey5/QnflKg95NPR2tYeQBZj+SgdC8TRGcrGLk4hxDmPyuI
         WNQk7FJV3XTzfX6ds2d4sKcmuICg+FIa/pTjgi9K4Zl6/HLHQJ4++aCJpgoO8A5iz94M
         ig2Q==
X-Gm-Message-State: AKGB3mLgvH4jjho2MYnhcGH68bqFUMdbuNztliNR4qvSAieaDwkBwNHK
        8ai9EOw5nqiA5JnNnX9Yzbv9hkSc40a6pc+xslw=
X-Google-Smtp-Source: ACJfBot046ocwgsxdAYw1XMjqqVYmMUGy4MudamUGHcTdn+ckCbfhNoiseSoGmoWOhMVqtEGFjEcNJHqVgQGufJuWAw=
X-Received: by 10.36.192.2 with SMTP id u2mr5049186itf.119.1513287406327; Thu,
 14 Dec 2017 13:36:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Thu, 14 Dec 2017 13:36:45 -0800 (PST)
In-Reply-To: <20171214211909.55868-2-git@jeffhostetler.com>
References: <20171214211909.55868-1-git@jeffhostetler.com> <20171214211909.55868-2-git@jeffhostetler.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 14 Dec 2017 22:36:45 +0100
Message-ID: <CAP8UFD0gE95Oc=BH8KsLTyB6sx_dTZ-Np-i5CbyfGUtm5OzMww@mail.gmail.com>
Subject: Re: [PATCH v7] fixup: rev-list-options text
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 14, 2017 at 10:19 PM, Jeff Hostetler <git@jeffhostetler.com> wrote:

> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -714,9 +714,9 @@ ifdef::git-rev-list[]
>  +
>  The form '--filter=blob:none' omits all blobs.
>  +
> -The form '--filter=blob:limit=<n>[kmg]' omits blobs larger than n bytes
> -or units.  n may be zero.  The suffixes k, m, and g can be used to name
> -units in KiB, MiB, or GiB.  For example, 'blob:limit=1k' is the same
> +The form '--filter=blob:limit=<n>[kmg]' omits blobs larger than n bytes or

While at it maybe: s/than n bytes/than '<n>[kmg]' bytes/

> +units.  '<n>' may be zero.  The suffixes 'k', 'm', and 'g' can be used to
> +name units in KiB, MiB, or GiB.  For example, 'blob:limit=1k' is the same
>  as 'blob:limit=1024'.
