Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3213D209FD
	for <e@80x24.org>; Mon,  5 Jun 2017 08:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbdFEIvO (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 04:51:14 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34650 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751569AbdFEIvN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 04:51:13 -0400
Received: by mail-wr0-f196.google.com with SMTP id u101so4299683wrc.1
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 01:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=mBdvEMXO7xbetowhYl5NOGvrCdyMpyZTArhqHuackd0=;
        b=cYmNP41ZNguGb5y4cbk86ZSgVS8n8+5XFoO9He5YprAFR7QbxnCgUyQG9QXQdrNu+i
         ZF/fw1B/rt/Wh7hwYIl13+TkCe8ljnLa/gFiy8Zv/FN0c90plF1AtJVfxaybZkdk3jQB
         umitxNAvP9sSEyM/hBOC3wn3ubmf07Iz2UAfJsg1orQQeKC+xTdt80atmr50gLWKCj3f
         MOHc3YLQu+ucZiiYlrS2jGVyT7TakeV6GdwQCMcvAim6jMmQI43MbqzOvuBVVHtYA6o8
         FurBNBUb7iAT2Bh2Cuy3/pcz14F/UuT+S1j2sqZUOIDad+o5M53fRmGwrOg+D4cx5m4S
         Z/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mBdvEMXO7xbetowhYl5NOGvrCdyMpyZTArhqHuackd0=;
        b=H4cZ9kW2+AeASK1JCd4CTuIRBHuPFsJ9tD+W83osA58vbWQu6D/LDrwS1rBCzY2Q/8
         Ms4OI5cv8UXu2T0KuHXpLRNCjN4SZuegaIgHdc3xM/RBbmB8H7+xQ8Ae9GaWUCjEsft1
         9CVM2NiJlOiTWwWwPaRiZaxfr20v+dz/HJxAc5EQnaI4Khn8tB1MHzCDmMnz4NBum3/f
         YNN1pbuBLy9sK6dNdcXseSpw5DalsciQiPvyVYfJP3X9vG65W/suvflLEnxsXojosIjI
         9vIyR0NQeqIoFee59RHy1S2rgKl9xcEZtJ7c7+hdt62mRCr0jwnEAwVTAYYfk/XV9JE7
         Cbsw==
X-Gm-Message-State: AODbwcBgI3Punp+Kb4HTMc9/k3pGSyvJygI2O/Pz6lzo5cQoZg+D0dlh
        bkgHAHikwd0dNdES
X-Received: by 10.223.160.70 with SMTP id l6mr15393700wrl.0.1496652671550;
        Mon, 05 Jun 2017 01:51:11 -0700 (PDT)
Received: from ?IPv6:2001:a61:342b:3c00:9427:9ed6:df92:ed2b? ([2001:a61:342b:3c00:9427:9ed6:df92:ed2b])
        by smtp.googlemail.com with ESMTPSA id f70sm11339460wmd.25.2017.06.05.01.51.10
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jun 2017 01:51:10 -0700 (PDT)
Subject: Re: [PATCH 2/2] add [--] to usage of filter-branch
To:     git@vger.kernel.org
References: <20170603101755.13619-1-asheiduk@gmail.com>
 <20170603101755.13619-2-asheiduk@gmail.com>
From:   Andreas Heiduk <asheiduk@gmail.com>
Message-ID: <ef30e8f5-8206-7b42-e229-6cd4b0492e76@gmail.com>
Date:   Mon, 5 Jun 2017 10:51:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170603101755.13619-2-asheiduk@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-BE
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.06.2017 um 12:17 schrieb Andreas Heiduk:
> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
> ---
>  Documentation/git-filter-branch.txt | 3 ++-
>  git-filter-branch.sh                | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
> index 45c849d8c..1efdda804 100644
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -86,7 +86,8 @@ OPTIONS
>  	This is not a real filter executed for each commit but a one
>  	time setup just before the loop. Therefore no commit-specific
>  	variables are defined yet.  Functions or variables defined here
> -	can be used or modified in the following filter steps.
> +	can be used or modified in the following filter steps except
> +	the commit filter, for technical reasons.

I'll move that into the previous commit.
