Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC05320282
	for <e@80x24.org>; Sat, 17 Jun 2017 21:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751674AbdFQVlE (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Jun 2017 17:41:04 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33419 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbdFQVlE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2017 17:41:04 -0400
Received: by mail-pf0-f194.google.com with SMTP id w12so11512326pfk.0
        for <git@vger.kernel.org>; Sat, 17 Jun 2017 14:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=K2WBdL8cfJ/huMWHLSngQ9C6Z5hIwDM0u/cNUHvyu6A=;
        b=RHFF2yIjRYGNq/9ilPDNLV6AsOD3cPkA2qvjbl07XR88azgOzE68MEgWCDvpazEEnv
         ZY4RzYWnHnPBPag1rIYXQNbPKb1Nl1o6n1hqurCOhN9HwnLpOllHT8JRixVffOGTxh6S
         exXnHfYpSfKfzQXNriiglrgFGB/rs436KSgeqFciAxUOq5B6kxuhUD7gKwDcYsbIgljL
         flvkXmvw6WMwUySGJ50lX+ZFg6asCZncAF79ZXYkRexvs3TLNGipPxgwhPGp3TKIN8I4
         YpO//wEEdfhN9wiL/dz1ldDiOZGY9cMan43TIJ8c0uJjMk81UaUXGHpviIeVkumkKTMm
         yYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=K2WBdL8cfJ/huMWHLSngQ9C6Z5hIwDM0u/cNUHvyu6A=;
        b=mi4nX3ZN6yC6ZQXfY/xIyJB1eJC9rVFibCgu2KyJsaW1OO0QUbBGMexn0GLDWN5rQb
         huAZdi+2pge0Mie33VnR081HeilBXtDT9Vfxh0X2tcBZzPDPIJjs5S/VYphdBotMq+QQ
         NVQw/auQ6fPGvxdrmbbg96L5yKG2gP5WUoJk3ggZrlQoBgmAdsXQAd2eFIE6rxc4NfWV
         Ayr/gYhbRwsUEqtOpFsG+TKt1nWpPHWBcCdeRqE55BpkBmfIYxNATpFJpd1osbOO2b82
         VmU574DYCQGZ0PlO0HHjK4yO6b/JiD1+7KDWhitD1Gys+qb+L5aIwXHzYpNcV+Ja4zo/
         jaBw==
X-Gm-Message-State: AKS2vOwOivKmm+p/pUqBNoPvhYNZTZJmxzau9M4iozYA7hO09nncoojY
        0otFcWN41sK9XY+6UYtX5p7B2QAOvw==
X-Received: by 10.98.32.207 with SMTP id m76mr18154649pfj.111.1497735663352;
 Sat, 17 Jun 2017 14:41:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.182.236 with HTTP; Sat, 17 Jun 2017 14:40:42 -0700 (PDT)
In-Reply-To: <7d11fa4e-232b-8741-504f-ab4e3e788130@ramsayjones.plus.com>
References: <7d11fa4e-232b-8741-504f-ab4e3e788130@ramsayjones.plus.com>
From:   Sahil Dua <sahildua2305@gmail.com>
Date:   Sat, 17 Jun 2017 23:40:42 +0200
Message-ID: <CALiud+nZj4f1=puzXC6grfStg-tQLMGpr-dAdtNwphyvts5KmA@mail.gmail.com>
Subject: Re: Subject: [PATCH] config: mark a file-local symbol as static
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay,

Thanks for noticing. I will squash this into the relevant patch.

Also, git_config_copy_section_in_file() and refs_copy_existing_ref()
don't need to be available in public API.
Regards
Sahil Dua
Graduate Software Developer
Booking.com
Connect on LinkedIn
www.sahildua.com


On Thu, Jun 15, 2017 at 3:20 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Sahil,
>
> If you need to re-roll your 'sd/branch-copy' branch, could you please
> squash this into the relevant patch (commit 37af9c71b6, "config: create
> a function to format section headers", 13-06-2017).
>
> Also, I note that another patch in that branch (commit fd44da469c,
> "branch: add a --copy (-c) option to go with --move (-m)", 13-06-2017),
> adds a couple of external symbols which, currently, don't need to be
> externally visible. Is it intended that git_config_copy_section_in_file()
> and refs_copy_existing_ref() be part of the public API?
>
> Thanks!
>
> ATB,
> Ramsay Jones
>
>  config.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/config.c b/config.c
> index 2996e6d56..fbba17483 100644
> --- a/config.c
> +++ b/config.c
> @@ -2173,7 +2173,7 @@ static int write_error(const char *filename)
>         return 4;
>  }
>
> -struct strbuf store_create_section(const char *key)
> +static struct strbuf store_create_section(const char *key)
>  {
>         const char *dot;
>         int i;
> --
> 2.13.0
