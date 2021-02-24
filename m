Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F2FC433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 23:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EE3E64F08
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 23:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbhBXXXw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 18:23:52 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:46614 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236275AbhBXXXs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 18:23:48 -0500
Received: by mail-ed1-f46.google.com with SMTP id v22so4593792edx.13
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 15:23:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=obrowNyOnQZ88cIWVP/a1IWhXQ38TnT88liKxMmIeC4=;
        b=k5Pbk5hsHJ9ZRpO25mk/8arPSFEwlPFSwghunX9CHt5OYYoeJXGCobLTCOs1hPaEQS
         j/QuKRBLPahWiy0T9Ldyc9IVwRciWW46Fu+rLa3fYCEuSeIU9auj2kG1gt4yRLLi8Sr7
         KyWpZM742/V3M9Ht3MejoCaC3dW1M77ZX89jefGyg7/YUYWjM3G5HSil28Po49f/X+j1
         w1u4P96gCmXIjpnloq9trWPmZ3ZoQTcKzcVDSI+XLikVKBLk/vfZP0W0o85Nsy3HJlN0
         pt1cADi/l1NzNrnmXbZNfrnOwfSRtFIvfj90U4e7jqDOTTNOlRRixPQmMJZtUjqLJq9g
         OGpA==
X-Gm-Message-State: AOAM533LMPXnQrQzLCaixPQ5m9Mlr8VuGbxRHAoIueUYBJxLR6b8HYAu
        gVSrvUxsR19Y/bCTKAQE/G2C66VuraSHK/1r9h/APg4w
X-Google-Smtp-Source: ABdhPJxKbxw3J9OHnyjsBcqo+AkX8j29OjHDxhTP4MJ3Kxdl0SMbsB0Yt15T12wP2adp2NcOuAcjLo27xHVl1zBgx2U=
X-Received: by 2002:aa7:cb0d:: with SMTP id s13mr185733edt.221.1614208987364;
 Wed, 24 Feb 2021 15:23:07 -0800 (PST)
MIME-Version: 1.0
References: <AM0PR02MB4081D3C17C53DB5CD9021C5E9C9F9@AM0PR02MB4081.eurprd02.prod.outlook.com>
 <YDYteUnxQZuPIAML@camp.crustytoothpaste.net> <CABPp-BEKJrRkhb2W0SWpjCawG4ZVs8oVuhQ5SJ+7zT331ybhSA@mail.gmail.com>
In-Reply-To: <CABPp-BEKJrRkhb2W0SWpjCawG4ZVs8oVuhQ5SJ+7zT331ybhSA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 24 Feb 2021 18:22:56 -0500
Message-ID: <CAPig+cQO6q_caD_KGc4ahSRKDBst+Y30haTbReK3GSwsUfMt6A@mail.gmail.com>
Subject: Re: Ort-merge: What does "ort" mean?
To:     Elijah Newren <newren@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 24, 2021 at 2:23 PM Elijah Newren <newren@gmail.com> wrote:
> It actually has meaning beyond being a joke, though:
>
>  * Note: git's parser allows the space between '-s' and its argument to be
>  * missing.  (Should I have backronymed "ham", "alsa", "kip", "nap, "alvo",
>  * "cale", "peedy", or "ins" instead of "ort"?)
>  */
>
> However, I learned my lesson -- Eric is way better at coming up with
> names than me[1] so if I need more names in the future, I'll ping him.
> :-)

"Extended LInear Jump AHead" is still my favorite because it sounds
cool. However, I wouldn't sneeze at "UNiversally Systematic Heuristic
Iterative Newtonian Elliptic", which is probably a more apt
description of what you implemented, but I digress.
