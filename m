Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B805DC433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 18:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241732AbiBASDt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 13:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbiBASDs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 13:03:48 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8836AC061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 10:03:48 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id g15-20020a17090a67cf00b001b7d5b6bedaso3333025pjm.4
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 10:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=xOo/c3zD163ZOvT9caGlz8RpVyS7pYjaHNSTwQv4Iqs=;
        b=lZReE4YkApk4yJ+7QKRz8sFwSjG3KpZjLvKNawxPuHFgawKX36LY5n8TE9IJvTKVcZ
         Tne9jtMl9Hb9pM+8lbjGu5Q4r5XUigIanhamLlZsweqFT7fKr4+/ABnhjcvgnQlY2AYG
         v5WEmW77Hg+58DZgfyN6I6kmOnClC0depjEwjgn09zHR+vPZrFlF046/rOXN3HQhYMHt
         m250o3k5ckXUuw+YdA1wq24GC3LJetK1eVV1V9Iu/eBOJbkEESpP1hJx6cHmbLvMNjhx
         Cm0HKanvIS+iKmsuDIymVtF0Yl7RZ+uBULYlwF3hLlUdnv/JFEbKu2aR42fSm6gqbirT
         072w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition;
        bh=xOo/c3zD163ZOvT9caGlz8RpVyS7pYjaHNSTwQv4Iqs=;
        b=GgjVGbOL8NcF+0ebj9X1cANztImrVS8C7oh38QCesnpAsD760Xo9gGWxyCyPaVwDch
         DmPwRwjdXuHvH28wMDlqb0d6WtxATa2/LmRRwAACaJ0VAfmwZkosuOrq/sxKLZDuHeN9
         bqEPbcrxBPwKBaS+fkdP+nOK9apsTjB/eyqC2nDL7wk037QrTJQiwTd10CkOVHSoGJWx
         uWxp+Emh20kR+bFhGmviF4rzlczpPjtzb45YKyaeD9wdXHyYVAbrYjMxR0wk5O23SqmB
         di0fzOJ/RI5ramrYZBsHnuVEsw/u8z52vaKBJTld+tioQewr4pCa4zcOCAo+8mXoxxi2
         EkWA==
X-Gm-Message-State: AOAM533CwafDA2x8JgSmthvBqq8TOIHFdKBqHpgMKTsKyEvDzHqyaa11
        2hItXEIw1UMKkue57oBa3Lic/8iJFcuhyw==
X-Google-Smtp-Source: ABdhPJxpN1qArYrLbA6n6O0+KHkYO/hh5VUK8lwHH4Rl7zgAnFXO/2aLr3kcegNhS0eFZe/bmqa6ag==
X-Received: by 2002:a17:902:dac4:: with SMTP id q4mr28378689plx.22.1643738627688;
        Tue, 01 Feb 2022 10:03:47 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:b721:7974:9ebe:afb2])
        by smtp.gmail.com with ESMTPSA id a13sm23934098pfv.97.2022.02.01.10.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 10:03:47 -0800 (PST)
Date:   Tue, 1 Feb 2022 10:03:41 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, newren@gmail.com
Subject: Join us for Review Club!
Message-ID: <Yfl1/ZN/taYwfGD0@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        newren@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I've been organizing a Review Club meeting at Google for a while now.
We've been intending to open this up to a wider group, so this is the
official invitation for anyone who's interested to join us! We meet
every other Wednesday (tomorrow) at 14:00 Pacific time (UTC-8) via
Google Meet.

For tomorrow, we'll be discussing Elijah's "In-core git merge-tree"
series [1].

The goal of the meeting is to help reviewers learn from each other, and
to get better quality feedback up to the list afterwards. Having a
deadline is also a nice way to motivate reviewers :).

Please email me (off-list is fine) if you have questions or if you want
to join us.

Thanks!


[1]: https://lore.kernel.org/git/pull.1122.v2.git.1643479633.gitgitgadget@gmail.com/
