Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDD43208DB
	for <e@80x24.org>; Sun, 27 Aug 2017 11:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751156AbdH0LuE (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Aug 2017 07:50:04 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:37740 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751124AbdH0LuD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Aug 2017 07:50:03 -0400
Received: by mail-it0-f47.google.com with SMTP id 77so15559825itj.0
        for <git@vger.kernel.org>; Sun, 27 Aug 2017 04:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RceyBD0lUHFaycXJbefUb7aEtUF2xpeLYpjOAELaOxw=;
        b=hsJYgn65D1sJMY/KJfM9JXEwZznN22LC6lN49uwqA2MzkiXG3haAL/g+q/xp/7BXHo
         TfUGjweXS20eESZBphmNFJcSkIQ9lxzVhwK852SSr7Fqu79B1s1Ss2rD9R0GjHo9emML
         cYrydvZBd9Xx2vmEbLgkCkyFUHVuJULGsae0lcSSV/Y/cjojEe3HeYRl3QpYuf5t0qJQ
         WTGD6IzjIRBG4x/qoegX1z04gurgcke/N7bS/BrZGI4aO637agRXks630z1hl+toIqUB
         WjB4vE8ZijiSfkRyXRHh0+SO4Ghg4gIjk/sHk6glKGmzxWH66wUzb1H3gTKvM+k1htYl
         zqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RceyBD0lUHFaycXJbefUb7aEtUF2xpeLYpjOAELaOxw=;
        b=ip/W/8OrFXZQsRa7CyjaSXgOjo43Wu+oUZBNogTG6FP5XfcTegerkkzByGYSlYmwGC
         Bm0SsvPy2CTqi2XodvhEXe4M3LtJiS9n8KjjfZcRv7iwTowPJQyip0zwwFJf8dkzhclJ
         7zrq9wOT+DIL7cwIMujsyStMxRJ8vr/MGGnqEThdFPCLXsomO4s0LBRBmwtmc33uVKNg
         0lBPQ/YDMOcrNxpicKRdoUs2IjCie0yFjX+pF9rEphi0MhXoJd9oDUJ1ss5VJMsx94dT
         gPoNfoha4bQHOwwd4GhPtYWkRmUnZrBtCmIyXbwBElhBN5Mlxjpe7mXALSEo9FjVd3Oo
         bTTA==
X-Gm-Message-State: AHYfb5jwjQiH6831l2xuthXlCYzX8/aZt01nC56wpqMJETmcYI0KSYNf
        rQfyF5h+ILtFApoGybNjFgdtvMr15g==
X-Received: by 10.36.130.71 with SMTP id t68mr3170140itd.100.1503834602427;
 Sun, 27 Aug 2017 04:50:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.149.134 with HTTP; Sun, 27 Aug 2017 04:50:01 -0700 (PDT)
In-Reply-To: <xmqqlgm7scpm.fsf@gitster.mtv.corp.google.com>
References: <xmqq7exuysc7.fsf@gitster.mtv.corp.google.com> <20170824195051.30900-1-pc44800@gmail.com>
 <xmqqlgm7scpm.fsf@gitster.mtv.corp.google.com>
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Sun, 27 Aug 2017 17:20:01 +0530
Message-ID: <CAME+mvVUtt5DU0wgL4nDTvuXsFrxnQ-8Obnf6VrDGdxsikfXEQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH v3 0/4] Incremental rewrite of git-submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 26, 2017 at 12:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Thanks.  I'll try to queue these before I'll go offline.
>
> Mentors may want to help the student further in adjusting the patch
> series to the more recent codebase; unfortunately the area the GSoC
> project touches is a bit fluid these days.  I resolved the conflicts
> with nd/pune-in-worktree and bw/submodule-config-cleanup topics so
> that the result would compile, but I am not sure if the resolution
> is correct (e.g. there may be a new leak I introduced while doing
> so).
>

Thanks.
I'll see the dirty merges and will resend the whole series after reviewing
the dirty merge and sending a new one with/without changes as required.

Thanks,
Prathamesh Chavan
