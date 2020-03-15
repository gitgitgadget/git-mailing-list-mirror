Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725A3C10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 18:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E42A206B1
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 18:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbgCOSih (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 14:38:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34927 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbgCOSih (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 14:38:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id m3so15630884wmi.0
        for <git@vger.kernel.org>; Sun, 15 Mar 2020 11:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2r7Gq7pHZQ07Pu3RGPtvE6dkd8ukxn0XB4qGDj3Zh58=;
        b=f/Y3dp/xd9xUbyQacZbuyP2KGigv0PpTAArGdQZJA95PMEz8cScqfgNLNwZrskITDN
         Y5LgIoJPEwJXCRYzSVUAjjz8X77mO0gJcu7X+d3Cc4+bkBVh7uQMkbNbr3hmhB4y0Vdp
         4Y8thwFAP/rKGwucpti7ZoWdImYRxg4lJZfBUyRtssifeUcwDB0Jgc4jxZWckCfJLnsj
         enqSg6xCT4urzZmuIdeI/CD5tB/6BfhHjJLIs2cc9hNaY6iTt3p6hl2Faom1OSe+Av3C
         5xmkGBlgSbLL7oY8oTgzmVn3fz/3Q/Vm8ia0L/xCeQgYV0RfAUVpbrWqZpJp4hA7CFbZ
         HLdg==
X-Gm-Message-State: ANhLgQ1E5teHbmEGq508HNs11QhRcQLxZShhYFILC9eUbI4StuwCp3dF
        TbhuWrCHOHxs2QIClmii6RZ0g7ePuDc1Y4n1c8Kv8w==
X-Google-Smtp-Source: ADFU+vu0IxkKvf497rPwg7n79e3yDKpxF2l4iehpMr/jl0g7lG+iug9gXoMGV1qK5DiqmXMrKa9mCMooY8Nw21hUlrU=
X-Received: by 2002:a1c:6a08:: with SMTP id f8mr17889666wmc.53.1584297515749;
 Sun, 15 Mar 2020 11:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200315180902.13750-1-rybak.a.v@gmail.com> <CAPig+cTGqEdr+rjRCfKmcm=ab3vKnUokd6KyrsoBiy=AO9nnOQ@mail.gmail.com>
 <0ad0600c-d1fc-0f44-dae1-7bd0fc22b3e8@gmail.com>
In-Reply-To: <0ad0600c-d1fc-0f44-dae1-7bd0fc22b3e8@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 15 Mar 2020 14:38:24 -0400
Message-ID: <CAPig+cSE-c8ax8MyPg3QsDhgvRWt1HGRkV3x6WXJWEUbJQ_yJA@mail.gmail.com>
Subject: Re: [PATCH] t: fix whitespace around &&
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 15, 2020 at 2:35 PM Andrei Rybak <rybak.a.v@gmail.com> wrote:
> On 2020-03-15 19:20, Eric Sunshine wrote:
> > On Sun, Mar 15, 2020 at 2:09 PM Andrei Rybak <rybak.a.v@gmail.com> wrote:
> >> -        echo "To be changed and have mode changed" > 07-change-mode-change     &&
> >> +        echo "To be changed and have mode changed" > 07-change-mode-change &&
> >
> > The commit message talks about dropping whitespace after the '>'
> > redirection operator (and some of the changes in this patch do so),
> > however, this change neglects that cleanup.
>
> Good catch. t9500-gitweb-standalone-no-errors.sh has 35 of these vs 19
> redirects with correct formatting, so it might be better to fix those redirects
> in a separate patch. What do you think?

Yes, fixing it in a separate patch makes sense.
