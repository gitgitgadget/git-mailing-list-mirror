Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5C141F461
	for <e@80x24.org>; Fri, 30 Aug 2019 04:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfH3EDV (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 00:03:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43590 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfH3EDV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 00:03:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id v12so3672029pfn.10
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 21:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GC2z2n7XsxxNB5Fx+nZ7hEo/gFYUUTgkHkFQ9cE/e8w=;
        b=YdixUcvFMyT3Y5rSisYWsM/n5uiygMZIaFKubZjuM0zsRPjeHvd+0W28ysPFxtevH4
         Kmt0bmVqbjP6heafCmYgdGhabaV0nP4ai0JA2ejWbnY9TXvlyFdQy7BAEV7/4hF6bpc5
         OWg0V7Ok+JoQPf8vFBUa0tTVJbUA9WkzRDjg2PJtb4l0dkULkwsG89cRWEuDHdt7Itck
         9QbrVs6zQDU1/i+loJ2DPPOavSmTXjZh55T0BL+yO8K89ahDiNJ7yRH46UFOldvH2D/1
         z/iboCUwXTUPbGfSPk4qRKa39fTd9RuFBAoLzQsQJSmT96Joxy3/CjmKgA767HFNfFXD
         xgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GC2z2n7XsxxNB5Fx+nZ7hEo/gFYUUTgkHkFQ9cE/e8w=;
        b=io0IlweOsEUUZSVGayrEkgAgV/5yJo2dQm1vU6GHJaLfJhanoUyBYK+aE8nb/JL7if
         0yjVSHdD/LDyrJlceCNVDoX7zPVWQ69RNfO21baTMSeacQp/dD8Q5UAlXF7VI7O8sFQL
         eEnp5wmNXFwQx14mRgu0YSq+WuxTyBE5E2xIOOKeOkC3jAgfw+g6S9eKyz8Z/CkDI4+2
         A1Ri89CY52rs6iXyOLuv4cuiKjUWb3TGz7VpC93nGfUbOsuDfHamdXijwLuiGW3ehssc
         FLcLyp0JXkGOgQkEDUEQHWoeBbwqS4pvsUwHaTG+agE1K5ITM5fLVmCAIHcSURrXfoiT
         mXcg==
X-Gm-Message-State: APjAAAXl1nOBRQz7EIVWe1CZovGG0aP/juDUNC83OE3K4twvq2Igx8CS
        DRxC1u3gS1RK5aZxW95BWTMzXwiz/o03EvPTBb/pWyI2
X-Google-Smtp-Source: APXvYqzcQi1QsgpcRWrHmGdqbD5vBrg8iuTW0v/9gQ5+R4r2LB3iKzY60SyRRuTqMR8iYIvaYZD9ufMZgCADdBy6s7U=
X-Received: by 2002:a65:4841:: with SMTP id i1mr11344563pgs.316.1567137800823;
 Thu, 29 Aug 2019 21:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190829210301.18467-1-dturner@twosigma.com>
In-Reply-To: <20190829210301.18467-1-dturner@twosigma.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 30 Aug 2019 06:03:08 +0200
Message-ID: <CAN0heSosCnn5msMX18YPwrKJzWkSWptWSFRunQdLE7T7Lc4-OA@mail.gmail.com>
Subject: Re: [PATCH] clarify documentation for remote helpers
To:     David Turner <dturner@twosigma.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 29 Aug 2019 at 23:06, David Turner <dturner@twosigma.com> wrote:

> -Optionally may output a 'lock <file>' line indicating a file under
> -GIT_DIR/objects/pack which is keeping a pack until refs can be
> -suitably updated.
> +Optionally may output a 'lock <file>' line indicating the full path of
> +a file under under GIT_DIR/objects/pack which is keeping a pack until
> +refs can be suitably updated.  The path must end with ".keep".

"under under".

Also -- and I realize this is nothing new in your patch -- "GIT_DIR"
should be prefixed with a '$' and that whole path wrapped in backticks
so it gets monospaced. In total, my suggestion would be

-+a file under under GIT_DIR/objects/pack which is keeping a pack until
++a file under `$GIT_DIR/objects/pack` which is keeping a pack until

Whether what you're saying is actually *true*, sorry, no idea. I just
have those nits above to offer.

Martin
