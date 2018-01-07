Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78A6D1F406
	for <e@80x24.org>; Sun,  7 Jan 2018 00:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeAGA32 (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 19:29:28 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:44877 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752622AbeAGA32 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 19:29:28 -0500
Received: by mail-qt0-f177.google.com with SMTP id m59so9927545qte.11
        for <git@vger.kernel.org>; Sat, 06 Jan 2018 16:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=FbY2DJj4Vdg9XVnoHRysfTMKOaouVBuq0qiglk4bRAE=;
        b=buiP9MJipCpd4GHV/v5CxzNREKuSTSFORd0Dyt84JbwLujUFXtWdCPTBT1oCyXvphc
         qLx13rbA3jmgMJs/oRe7BcvePziEFysEnioqWpOhH9Wpfejqa0rbyd6HJFLwWzjKe4yV
         hZU4aH5azZbgpUOhrFoxBjxWxjbD8w85s6GzY06/vYXVPjUw6EcODkeTHN3O3pXmL8QA
         yAKUODZxlNr+atAopzXtOdCGRLZ1azq7CjCjV+HXxqSPxn4mxT0vFw6j3tilawq2c5Le
         6igjqbDezZUd6HQqc7KT+WQVbSqfNQhQBorcC8DwQoReQRbnUTBl3OT/yJF9NN3SvWAh
         mxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=FbY2DJj4Vdg9XVnoHRysfTMKOaouVBuq0qiglk4bRAE=;
        b=tycTpCbSI2vFKAsMNSyOW2vCxmy5JvsrZ668NmOLsR+IMQM4r11a4CJouT0UgvdCOc
         /6O7zFa0xT0L3lDW+ZyGNszhfa1wuiQDIxlD59COzypPXkwR7lvKCv3Y9wiMnOm27VHj
         /CQHwuvMIqS3VnNCludOMflpnbxR24qvCI6BEf/gFn/GkUorsfkaeBT0+LdMo7B1nMmy
         lKPsA0H0lkPCZ6QuuQRWeCDhFzX48d46onge6gAqKjaD5d+jVXPDO3zppppeqyZhdm+/
         ZH4VsM59m+djX1A7Ozqjqqlr1JSZTkCwINTfGtqqKTpuCHI3CYmI9jI7DNXX7u02omIy
         eS0w==
X-Gm-Message-State: AKwxytdyOzCgR7JRgQ3pRFen3NDMe3dkgrt3wrrovh0wWhGWESX/6g3C
        T0wXYpMCKWvtfcst/4JkLRR2eRQ4e/ZUV6dDfNU=
X-Google-Smtp-Source: ACJfBovqRgCoh2004d1S6VxaZyGArf4OHaQpqpBHqYvEbSRwR9E9BBHAzRI+lj0BJpcovmOb/2DV5o0dEC1CFbjdlts=
X-Received: by 10.237.33.75 with SMTP id 69mr10357504qtc.34.1515284967208;
 Sat, 06 Jan 2018 16:29:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.2 with HTTP; Sat, 6 Jan 2018 16:29:26 -0800 (PST)
In-Reply-To: <20180106184614.20115-2-kaartic.sivaraam@gmail.com>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com> <20180106184614.20115-2-kaartic.sivaraam@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 6 Jan 2018 19:29:26 -0500
X-Google-Sender-Auth: KsZ-dDrhy89o3-LzYVcKShCADOM
Message-ID: <CAPig+cQb1G0H5FS9bMmrqv=T45XoRwp2-2vUAEDayd0hV8PwYA@mail.gmail.com>
Subject: Re: [PATCH 1/8] Doc/gitsubmodules: split a sentence for better readability
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 6, 2018 at 1:46 PM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---
> diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
> @@ -36,8 +36,8 @@ The `gitlink` entry contains the object name of the commit that the
>  The section `submodule.foo.*` in the `.gitmodules` file gives additional
> -hints to Gits porcelain layer such as where to obtain the submodule via
> -the `submodule.foo.url` setting.
> +hints to Gits porcelain layer. For example, the `submodule.foo.url`
> +setting specifies where to obtain the submodule.

I don't find the original difficult to read (aside, perhaps, from the
missing comma before "such as"), so I don't feel strongly about this
change.

However, since you're touching this, you could apply the s/Gits/Git's/ fix.
