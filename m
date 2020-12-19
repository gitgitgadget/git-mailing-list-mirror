Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEF4C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 06:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D122343B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 06:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgLSGpK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 01:45:10 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:41407 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgLSGpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 01:45:09 -0500
Received: by mail-ed1-f50.google.com with SMTP id i24so4597472edj.8
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 22:44:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xXHOM9uPhQ24JxDDrestuhYTDUFKQpM+DZx4YGYVANw=;
        b=fQsBwq+cRAt96SGa6V252+86mdeYjCIi8hKMVfvRgd3aNfGhFl68TSw2T/CT7UEiqh
         MnSBrp2Ij+uvq48BzZeY4zWpDv50fUfUN0Nur8yZRQiv+Jht4t+9/jKLZhKOQLGnBcjD
         TZXK6l3DdSsrEZ306b1ZpUO047hGuHJkG05/xXWxryIGuV3uqxiCMJV3Vy4f2O1kAJiY
         avOeqs9RuCgkruEDW9iOj+YF9KJqxPVmRtx6x2OOrgElPH18WhTo4PcBnEom/FAsaFfz
         23S8gB3/T4xAGoOLqtTtrkcrBoekC58Y7vUCnwOfIMS7aM+/EmXk5w5ylZx98d5+E/ej
         NtXw==
X-Gm-Message-State: AOAM533erUTeRHmqvZuDv1c9ewBuoDxewVU7UTQSSpT09AuWwbsVtGz+
        ntNLSpu84/efFz1wGlonSLLm2AvIqAU3sNu5MMeAqPBD2vw=
X-Google-Smtp-Source: ABdhPJypHxOHj6yBhHc08pvKAn/XwxwVtJQgB77G2d+hf8H8ZNeZBhQQ3o5pym9o371Cx6W3WbTcNXntMjrKsZ/hJ0U=
X-Received: by 2002:a50:ab51:: with SMTP id t17mr7873198edc.89.1608360268092;
 Fri, 18 Dec 2020 22:44:28 -0800 (PST)
MIME-Version: 1.0
References: <xmqq7dpeqrz4.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7dpeqrz4.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 19 Dec 2020 01:44:17 -0500
Message-ID: <CAPig+cRycw=JnYOxCspJiLWbX10FK_QJhHx3A98oJBSG_MBaoQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2020, #03; Fri, 18)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 19, 2020 at 12:36 AM Junio C Hamano <gitster@pobox.com> wrote:
> * ds/maintenance-part-4 (2020-12-09) 6 commits
>  - t7900: make macOS-specific test work on Windows
>  - t7900: fix test failures when invoked individually via --run
>  - maintenance: use Windows scheduled tasks
>  - maintenance: use launchctl on macOS
>  - maintenance: include 'cron' details in docs
>  - maintenance: extract platform-specific scheduling
>
>  Follow-up on the "maintenance part-3" which introduced scheduled
>  maintenance tasks to support platforms whose native scheduling
>  methods are not 'cron'.

I've read this series in its entirety at each re-roll, and am
satisfied that the comments from my reviews have been addressed.
(There may be one or two remaining subjective nits but nothing worth
holding up the series.)
