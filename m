Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4231C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 12:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237679AbiBDMan (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 07:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358691AbiBDMak (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 07:30:40 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99830C061714
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 04:30:39 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id s13so19016416ejy.3
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 04:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=511o/7csseknJypTMdDQxbtsWeQSlRSnn5AmOjdaDoI=;
        b=GmX11idCARZ+WnoPWnOWFBQOyhkae95+g49XpePxbqsflW32GIdECeTEN1/Ldi2nf2
         dmZmdNx8mgi5KhnVvcbsUOXWWFX99t/QWM8qSiKrYnpUssqVDZpyc3cKb69l9S3bBe23
         Pjr1lkHaH3j7lbAbownFI4X3PVyl3Gt+leWdnWN59hdA4boZgkg0S7uWtt8oRFVlGU8V
         BNikZ/hEge083bDdy2lmMfcpIyL9MGyA7OsxLXfyYszdC9Pf3NCQwE1PCeyflTQRA+el
         bbr1wbur5yjGS/gC72ClDgxLW5EqW3rzgiVyBh2J+/LTdgj69pG091E+QFYDAH4xhi+g
         brhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=511o/7csseknJypTMdDQxbtsWeQSlRSnn5AmOjdaDoI=;
        b=KJTqRipHmlDYnOMRL1IDJY3Wp4lo08XQaG2DURZdxYB0gB8sOSDoMA1rt0FXWrja8I
         uhuMfOF/7m0RUPU3pmKbzTAOcuz9xVbCbcQGchs8UZ91fJH1N42RJmZN13vCdytgYva/
         WhUJLXLNv5nxZaGfzKKIuq28TnFdt+0FihkVHY4nAiQMqObJECtULDWULGUS61KjW0wY
         9nl+R/krW1fhC/a0ZL0Jtkc3JGMavTChN8T/S7DGyOkkOtFJMjLHTGXH2Mb0Q1VZR6Fy
         rz2av3xkvxzWd0YMwWQPfjprINgPKFKHS6liD5nsV3qCWmm3Ey7AZVyULZj0bg0As4wU
         RLOw==
X-Gm-Message-State: AOAM53144ExEfULgkj3u+IrzEkhhkMjBkSzwRv9EVLjqSOdi55/p06zd
        EectZUKIbGr3D5EZxZLEbDc=
X-Google-Smtp-Source: ABdhPJz6ZzUQP+R7C0QkfEzeO9OAgO4h63sXPfzY5HDGexwp6ZHMvFN7PxnG8wy2jefUygBvtnlu5Q==
X-Received: by 2002:a17:907:724c:: with SMTP id ds12mr2297816ejc.203.1643977838058;
        Fri, 04 Feb 2022 04:30:38 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id by4sm758302edb.107.2022.02.04.04.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 04:30:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFxjZ-0064MA-3F;
        Fri, 04 Feb 2022 13:30:37 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Subject: ja/i18n-common-messages (was: What's cooking in git.git (Feb 2022,
 #01; Thu, 3))
Date:   Fri, 04 Feb 2022 13:29:11 +0100
References: <xmqqr18jnr2t.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqr18jnr2t.fsf@gitster.g>
Message-ID: <220204.86iltu3jbm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 03 2022, Junio C Hamano wrote:

> * ja/i18n-common-messages (2022-01-31) 5 commits
>  - i18n: fix some misformated placeholders in command synopsis
>  - i18n: remove from i18n strings that do not hold translatable parts
>  - i18n: factorize "invalid value" messages
>  - SQUASH???
>  - i18n: factorize more 'incompatible options' messages
>
>  Unify more messages to help l10n.
>
>  Will merge to 'next' after squashing the fix-up in.
>  source: <pull.1123.v4.git.1643666870.gitgitgadget@gmail.com>

I had a comment on the API direction in parse-options.c, which I think
should be done differently, but I also think it would be fine to just
change it up later:

https://lore.kernel.org/git/220201.86a6fa9tmr.gmgdl@evledraar.gmail.com/

I replied to v2 instead of v4 due to some (now fixed) mail delays at the
time, but that comment still applies to the latest version.
