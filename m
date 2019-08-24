Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D51EF1F461
	for <e@80x24.org>; Sat, 24 Aug 2019 00:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfHXAIh (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 20:08:37 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46773 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfHXAIh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 20:08:37 -0400
Received: by mail-ua1-f65.google.com with SMTP id y19so3828801ual.13
        for <git@vger.kernel.org>; Fri, 23 Aug 2019 17:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Xlpvd/bmOYwFtZXItOiUOfkm0NxBSsXL0yaCbFNyn8=;
        b=mOCCjkjaarv4aakVPx+ve1+ArkI4GPZfBw6dEugzIEhuRUuqcJ09ypvVejR6TbhNpP
         gHLcc6f8qycRa41QK1fiOaPBBxVRPUGxGkvsIjxdg625zm3RNT2+p0eCITT3bBvtOiBU
         EwDcgb8+1kvSTllL3QtDCasVu85xIJBqwHXKzflNewT53pg3htx+B4+BFZRaWFgo6Yym
         s7Zs9pNBFkok7YX3erarqKnKxljpmWGNtV/JLdnnKQh0PdmzUO9t8/o2fmFiyH4LUt+1
         ZP4Ww0EgR3K+W8TttUkElTSPwDpPAZZg2KTqDy3bDLDHjhumXfFCxKjqsSGfqcPV1D8r
         dUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Xlpvd/bmOYwFtZXItOiUOfkm0NxBSsXL0yaCbFNyn8=;
        b=dw5zG464pjOdHoRs+Lbemr8IB0h43fLGIgmfDMDMeKqCAokA2qJHb+5IUxpEQYNANz
         7Zg65/7uQBH5oq5rNu5UDHGLze7iL4l3dOEsyrWdfu28bq7unUS46K3Zjqoii3lfyNj/
         i1tkC93oorwdWdVJgcQ6WOUF/Dv8mjw4BuCSFA7GEjWkdKskwh4IfTzv7I0RYPEdTJsB
         DL6cL971DFyACDhmL/p1CtWVC+iEhJBjAv8sd62c5+Dt6qZCqqtBJ4gJaK1bULEbxds2
         m7LbDrfA/foAFftyi3w4dfSPuADHzRsZIUXK82rCakyjkIjLlCcg5RGPngTuX2fki3EX
         tmMQ==
X-Gm-Message-State: APjAAAU1IEdOLj8Gqaz0gokow2+AIGYTqpcg1rQQI+qHagY/fp0IPCUU
        rssRvAiRtPUYefMyvRKdTWmkXkuDeZMeuA+Zypw=
X-Google-Smtp-Source: APXvYqxxSm5Blov6EjNWvehpvQ9GW+pgeNGgDp/0Qa3RK5Yg5zBiZXe8Ak/z8NGLzJQV08wWQsSKXCxYx9Yxmf4lyGA=
X-Received: by 2002:ab0:2b13:: with SMTP id e19mr3824131uar.81.1566605316510;
 Fri, 23 Aug 2019 17:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.git.gitgitgadget@gmail.com> <86f12dc77dd94c1b2c6294842d29d8712f79e3d7.1566313865.git.gitgitgadget@gmail.com>
In-Reply-To: <86f12dc77dd94c1b2c6294842d29d8712f79e3d7.1566313865.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 23 Aug 2019 17:08:24 -0700
Message-ID: <CABPp-BGJv1QJ0zeDx33My9X+GDQC1F-s8W=L1Qt-__YPj=ObCg@mail.gmail.com>
Subject: Re: [PATCH 6/9] trace2:experiment: clear_ce_flags_1
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 20, 2019 at 8:12 AM Jeff Hostetler via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Jeff Hostetler <jeffhost@microsoft.com>

Can the commit summary be turned into English?

> The clear_ce_flags_1 method is used by many types of calls to
> unpack_trees(). Add trace2 regions around the method, including
> some flag information, so we can get granular performance data
> during experiments.

It might be nice to have some words in the cover letter about why this
patch is included in this series instead of being a separate
submission.  I'm not familiar with the trace2 stuff yet; this looks
probably useful, but the commit message makes it sound like something
general rather than specific to this series.

> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
<snip>
