Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1C512018A
	for <e@80x24.org>; Sat,  2 Jul 2016 05:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbcGBFMn (ORCPT <rfc822;e@80x24.org>);
	Sat, 2 Jul 2016 01:12:43 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:34627 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbcGBFMm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2016 01:12:42 -0400
Received: by mail-io0-f180.google.com with SMTP id g13so115257426ioj.1
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 22:12:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LRLhsa155+F+r6ikcg7CLK3+Zie4bnLRake0NaBQ3ho=;
        b=JxTCWdmckqrkp3IaKyo9jSNRDdDeekZdiALzK0RAtF6wP6qQ07OVamtHG7SkYE8vnA
         nGMV9JKJ2zM0EFsFOdijyhGTXHlsalpjQxN1abjSIAZZyyHhaBOa7WMUmSHIEnCKXT/8
         zwTLguqEGi9l1a7+e4r9sICtDFf5Eybp2n02OEdY2Me77hiEREt0woM4jqGO/7L6moIK
         dDHsCECxizyYQfPkrCWCDOGyYzjNnyEFp/OL1vRe29tcgeQvHjtWzwopkj4ujtlKwYlg
         m6RRXWIk1xNT77Mf7BetYgNcKnmgYgxGbd1xkYwDw3sMX3QIhetQ+K11CoBYEiSy/eqg
         Pm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LRLhsa155+F+r6ikcg7CLK3+Zie4bnLRake0NaBQ3ho=;
        b=DElhT0BXd52CE31ZjZP6DQWVtYgp5bCjp3uNVzgUYs3mOHZ1gmRBKZ/u+IJKKjK5LJ
         20euz/bUP2GBE7T5axlOaJpiqcJ84aoVGMgNw8Obi6zaiAPCe6CwRi9R+naYyUkvDKwI
         gIzHKnBZIZOQpG/Z2AXhzA1rEttSkTUa9E03TO7GCRpzUOp0g6jbrKf7z8FUzAPariDx
         LfRYq94CUbg9O82ks+nz3JK7nMhRfMEheK0lPyQZ6k5vv8UbLIXpyeYyjX3gfwcgmmXl
         ZC2KizlVrb5IAnMFN9mrYtCAjO51I56GWwKPUmMDZEvdJqNaYrAd6QooYKHEAMpnj0JO
         2X7A==
X-Gm-Message-State: ALyK8tJwy3iwxv7g6AQ+gdP3K3P1b4q9I4XURLL+ECB+uYRlP7QBOuI0qlW8kB9PKSrklao+BTeRLot9LRYW2Q==
X-Received: by 10.107.159.16 with SMTP id i16mr1300805ioe.29.1467436329685;
 Fri, 01 Jul 2016 22:12:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Fri, 1 Jul 2016 22:11:40 -0700 (PDT)
In-Reply-To: <8615dc276828a3f99a27ff2eda9909548a7d435e.1467199553.git.johannes.schindelin@gmx.de>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <8615dc276828a3f99a27ff2eda9909548a7d435e.1467199553.git.johannes.schindelin@gmx.de>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 2 Jul 2016 07:11:40 +0200
Message-ID: <CACsJy8A1ZU8VgBYmQAVC6LmXMVgt5CgvC_w0Y7Y6oX88RFO3dw@mail.gmail.com>
Subject: Re: [PATCH 1/9] Report bugs consistently
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 29, 2016 at 1:36 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> @@ -955,9 +955,8 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
>
>                         if (!sha_eq(a->sha1, b->sha1))
>                                 result.clean = 0;
> -               } else {
> -                       die(_("unsupported object type in the tree"));
> -               }
> +               } else
> +                       die(_("BUG: unsupported object type in the tree"));

As a message targeting developers, we do not need to mark this for
translation. There are a couple other _() in this patch that should be
removed as well.
-- 
Duy
