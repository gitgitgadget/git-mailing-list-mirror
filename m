Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BB8B20259
	for <e@80x24.org>; Wed,  7 Dec 2016 13:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752844AbcLGNY0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 08:24:26 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:33648 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752117AbcLGNYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 08:24:25 -0500
Received: by mail-io0-f193.google.com with SMTP id j92so13666694ioi.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 05:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EExhvazIMRnWSZu4aTfXMT414Rgaj7Y4tWcpvzycTcQ=;
        b=LFN4pqcpeqZUQklpwDAdI8HkgVhm/pX+NK24PHxo/Fz3kvgG+5iOdj/qFKwm6IQJK8
         1AuWs0YdNZFHBSSlDQtdjipqxIiqCDjMlGi8ytAb8NgOCpUsXaJymcNPY+2Cz0djZ9t8
         l3hvsBo+EdW3y3ra09ZdXAE39xJYvQU65YlgFSpnXLYVKYc+OgVC00i7/f9U7mQMa+Ab
         /MtmR/5PQrHfBbfgVHjyy58wHiDQcfrVyGQZW4GSxuhCDez+6GTk93WXl6Rs1OdbmLXp
         iBB4x/KTAlH3w7puiwxvKQtAwmO0BqkLNul2jdV9G4sfl5ALFVJ4wBg9EHzsACNzcSta
         fWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EExhvazIMRnWSZu4aTfXMT414Rgaj7Y4tWcpvzycTcQ=;
        b=Dt40YyDfDovfnY6G5uHY4gW6HqWN3cp6bKSZt463VlwA6llJ4JC7h0lLao5jjcJqRm
         xYSI4d5hesL/9tn2nBdt/zmLNQwi/0LqQM6nhcDQVEv8mCHCynv0sUCrZgyGvgqA8LIL
         wIh9XXE2W+SdRsZRY0Hcmj8ZdA7YrSpuLBsZug3UOo1l9Wak+U9cAbIpqmC+duE4jFl0
         BA+zOGr2GIQxf2H4yiX5iIcibprU3zD0/p5zjizIjYYD/rOt5+BqUbuMbMhqvlvmFM12
         7GNbR0S8JdpZNzZ1WwM4JOQ8329ZV6qaCG0q+5EsVtTs+b2PESAD7M3KYEDFPEkdYuJH
         HAJg==
X-Gm-Message-State: AKaTC01Fvk7KYT551STKEMWF19nCx4Z+/OPJUS2sY5K4Au/KUiU1i75hC2iqtZezafFgLfNf9Jl2omnlTL0h6Q==
X-Received: by 10.36.26.148 with SMTP id 142mr2020543iti.74.1481115923151;
 Wed, 07 Dec 2016 05:05:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Wed, 7 Dec 2016 05:04:52 -0800 (PST)
In-Reply-To: <1481061106-117775-17-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com> <1481061106-117775-17-git-send-email-bmwill@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 7 Dec 2016 20:04:52 +0700
Message-ID: <CACsJy8B6Mj-L1t-CETY5DWRyABHZsYZszwXD3dgUqChfXRB6FA@mail.gmail.com>
Subject: Re: [PATCH 16/17] pathspec: small readability changes
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2016 at 4:51 AM, Brandon Williams <bmwill@google.com> wrote:
> A few small changes to improve readability.  This is done by grouping related
> assignments, adding blank lines, ensuring lines are <80 characters, etc.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  pathspec.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/pathspec.c b/pathspec.c
> index 41aa213..8a07b02 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -334,6 +334,7 @@ static unsigned prefix_pathspec(struct pathspec_item *item,

btw, since this function has stopped being "just prefix pathspec" for
a long time, perhaps rename it to parse_pathspec_item, or something.
-- 
Duy
