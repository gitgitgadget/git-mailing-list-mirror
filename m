Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 836B61F424
	for <e@80x24.org>; Fri, 27 Apr 2018 17:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757430AbeD0Rd4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 13:33:56 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43233 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751727AbeD0Rdz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 13:33:55 -0400
Received: by mail-qt0-f194.google.com with SMTP id l11-v6so3268908qtj.10
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 10:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=O6fxRrXEYZwu9foEOF2+EMqlLrM7Te6MWzQz6TSMzbA=;
        b=DfD2XbmI4wuP7lE00sD+UAg3i9/KnQw0+OqEKFn0y25rNLZq8k4cxLvmxxYVwLSaFL
         cLEGJAxVuJwmpuUFkSzHqqCpdPXhWqHKSb21NQXkHp5cRZRnT08i8j11ejVhTTzp4yCx
         MrJDwrMx8TNS81dcOVRTEwCiz5yVFGvTQgxe+yPQlznjHYBOIXLW3f5d6JvMP6HVU8z9
         s6dGmn81muaN+VeLpk8TFtbnxkhjrYO85DfGgAmU/5cZwEWxwRBIjb7CptYpXfAMZF8P
         ShrySdzZT0tNN3uftXANxdrjOVjScV4hIhHh3iGOYXTtmhoVazTK7PH8t4SNBI5elYio
         VvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=O6fxRrXEYZwu9foEOF2+EMqlLrM7Te6MWzQz6TSMzbA=;
        b=tfhc6H0VbSZXVF7Z7iTVQ55NKVaVTe4UwZZAtxQ28DqpsqwrmfGESxgRXn2PdpxOFh
         NiqNyyUoWbmfPygT81/u9K2NkCvl6TWC5x4BmU8Nh1hFq4pSgw+Lr2ImfDtItfAYoks/
         zVGddf7fKg/0T12wDeSggMpk81n3km5f46hZfCnGoOzijR+s8PkJ7UOF3vfnzRvxIWPC
         AFpIKgmLJp+yX9jT48pv3D79kr2sbup28kQzZyEb4vRzbCbY+eUcDQZc+GkyYgQRkuEN
         9U/8NWjtWXVLl0yK1IAcSIlBV1jYD8ttji9w0jz0SLcnEYevilKK7/tW5oOPL9FqGtfO
         IINg==
X-Gm-Message-State: ALQs6tC2od1j804ZEo5pyn0Ps9IZz06j6Od65ZdViAI1eVIVbBlOFHZu
        tWRNzJixmCsPpxvgevlSDAbSu/9ovhvc/FMbbrs=
X-Google-Smtp-Source: AB8JxZrVuZqxeDBQv/61RXYqfqfbFB6YBM6IZUo9gqxiqPX42ci5uuGrApqMUNKJHw9FeOG+OCbsXJ+jvQGru/MBXOA=
X-Received: by 2002:ac8:3267:: with SMTP id y36-v6mr2974520qta.25.1524850434962;
 Fri, 27 Apr 2018 10:33:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Fri, 27 Apr 2018 10:33:54 -0700 (PDT)
In-Reply-To: <20180427170440.30418-3-asheiduk@gmail.com>
References: <20180410183224.10780-1-asheiduk@gmail.com> <20180427170440.30418-1-asheiduk@gmail.com>
 <20180427170440.30418-3-asheiduk@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 27 Apr 2018 13:33:54 -0400
X-Google-Sender-Auth: R0tE70VdF_xS9eWgy9CXsljT3fM
Message-ID: <CAPig+cTM1J35hvwYwj9BOkFxw0tGQJFZjPL_WnCa=wDxzYzj0g@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] doc: align 'diff --no-index' in text with synopsis
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 27, 2018 at 1:04 PM, Andreas Heiduk <asheiduk@gmail.com> wrote:
> The two '<path>' parameters are not optional but the option
> '--no-index' is. Also move the `--options` part to the same
> place where the other variants show them.
>
> All three items are already correct in the synopsis.
>
> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
> ---
> diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
> @@ -13,7 +13,7 @@ SYNOPSIS
> -'git diff' [options] [--no-index] [--] <path> <path>
> +'git diff' [options] --no-index [--] <path> <path>
> @@ -29,7 +29,7 @@ two blob objects, or changes between two files on disk.
> -'git diff' --no-index [--options] [--] [<path>...]::
> +'git diff' [--options] --no-index [--] <path> <path>::

Not a problem introduced by this patch, but shouldn't this say
"[options]" rather than "[--options]"? Since the aim of this patch
series is to clean up botches and normalize documentation, perhaps it
could also fix this oddness(?).
