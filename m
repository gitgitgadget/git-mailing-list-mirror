Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE40C207F8
	for <e@80x24.org>; Fri,  5 May 2017 07:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753252AbdEEHIE (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 03:08:04 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34001 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbdEEHID (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 03:08:03 -0400
Received: by mail-io0-f194.google.com with SMTP id 12so2605805iol.1
        for <git@vger.kernel.org>; Fri, 05 May 2017 00:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6g5sydc/PURXIaEx2nLeA0LV+5p58Hw/3dgZZxE/dn0=;
        b=PhDc/t062NKvHbcQluI2RxUIN/bt+cF6tOXtTRhfWhCpHpZCcr+fheIf5/xYUdv+m/
         2fNWmCR16hWsYnZWRMNX7pCA2OceRKgkgncAlJwkuvyyL4STS49wT/19jDBIbdf8+wyi
         PHkkVgP0rURa+HXijOyDO09aGdnuywLP/TGaNkgqPxa6O9xfqEKKOCAePqCPE++9OAQc
         rh/KtSN1aOLutTe+UmOHB8JSJKdUepkYm3Gk0UQ9O0s9mLIKOGgk+31YakzQRzAGYkKR
         w3WaRBy8wJVT3DEHNfwdo0o6NP8xVH2wnFk9mI7iH6qbZuj92jCmTrMwfOPAGp9YB95t
         ndDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6g5sydc/PURXIaEx2nLeA0LV+5p58Hw/3dgZZxE/dn0=;
        b=GT9YKFRBPyxTUJjnX6bofcMylsXd2LJikffXMYt6OWznn/Sw5heUXLi6krUX2FrGVF
         6Qcga6GxjkBxOjopgsumvEw401hF48wyl3kZ7GsVfo5Ti7/CZcvjGYT36OpXn8THjGot
         Pq6XVuKtYyjJUzkxm7+H2Lkoc2dl9m1/p4qg01ZxtyTeSh4FmoiYRoDiB8REFXW5p0hB
         jm9UXETJKYeqaFCcxV7gLYyU16a2ePlcVScRNbp1g19OvlG8YnAWTCpRjU0lLycryzvG
         r7NXgOsKOubKo0isL2DPYQUc0Ba3u6/g7TW0TTFv7vIr/1zfn/63jMQXZTI5RbTIgZLl
         WVSw==
X-Gm-Message-State: AN3rC/6RWt2g0bht1EMtI2FboV9J9ek5jJMX164rmmzZ0YBnCc6wL9aN
        xp9sMkQq7Uc/ZyNeqNUdF7nDb73N8g==
X-Received: by 10.107.178.129 with SMTP id b123mr41733821iof.50.1493968082134;
 Fri, 05 May 2017 00:08:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Fri, 5 May 2017 00:07:41 -0700 (PDT)
In-Reply-To: <20170505052729.7576-2-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com> <20170505052729.7576-2-whydoubt@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 5 May 2017 09:07:41 +0200
Message-ID: <CACBZZX6EuS86Kp5H+zPf9a_4PrOQqnxPwKdpEdYCXWPspYYp5A@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] Remove unneeded dependency on blob.h from blame
To:     Jeff Smith <whydoubt@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For commit message: This was originally added in commit acca687fa9
("git-pickaxe: retire pickaxe", 2006-11-08), but has never been
needed.

On Fri, May 5, 2017 at 7:27 AM, Jeff Smith <whydoubt@gmail.com> wrote:
> Signed-off-by: Jeff Smith <whydoubt@gmail.com>
> ---
>  builtin/blame.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 07506a3..42c56eb 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -8,7 +8,6 @@
>  #include "cache.h"
>  #include "refs.h"
>  #include "builtin.h"
> -#include "blob.h"
>  #include "commit.h"
>  #include "tag.h"
>  #include "tree-walk.h"
> --
> 2.9.3
>
