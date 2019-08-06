Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E95841F731
	for <e@80x24.org>; Tue,  6 Aug 2019 01:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731119AbfHFBtm (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 21:49:42 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:33252 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729921AbfHFBtl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 21:49:41 -0400
Received: by mail-pf1-f170.google.com with SMTP id g2so40576407pfq.0
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 18:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FGQubuERHSyW/8agm4GcZYoT9AUxtj+NZJzAQYGPxp0=;
        b=I230W/OnlAE6sWMjExphNVZiPQKJkFvuiL19aKXsEcdiSTsfwmTnFOWsTQ8Bbjb42G
         +FD69spvB/9BAYk6VSYtDmZTdcugnWmm4oGDEXdLLsYthOfKcJV1AoOXJRu9KGVr8aNy
         q/jHeqQ+R7JfBR3PSKBCNvSBZhHaGpxno5fRgu/FdPbJk8UQkd1Ese1pukWugcf5Dci9
         NiqnXv8ak5IBo6ylrK8WmYhEH2smfJukXHN+sy690OoHN76kLqKGt+l6oPWnmGituTyy
         zeoveyqcSGm3w3z4b5u4p61Rvc4WP1WbFinvUnLtLgXK2d1foJiP5jLs5iZdeGg++9sp
         eEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FGQubuERHSyW/8agm4GcZYoT9AUxtj+NZJzAQYGPxp0=;
        b=RXXWUUOC+8C0R6jZwzn60lWjMbE9tUbByPxz6604f9UO8M+6BwcmhA8+76JjwfegnG
         z8RoopqpXSQdX9KFX+twXnYodWBdCJVNoqJT+eFcJ0vmKh2jkETHEcZJ/Oj6ZVjfoTnI
         ufkdKZdTPR9MyqJXTqnp6ryBSBb/Ql0XKDxcZ0VAaHMgamJoOQwinyK068xb3SaGAP5d
         /trRmLvGXkcsdUoybDMsDz0hfqHdTqWg9GAa6WCUG6wyyv6mW2j6jdQ8xhbuOQMURWgT
         dM3sDuG5oPbLQJe2PxvATowYdjrj+6NvCshtK/iDFb5vnYouPTaUzYKVEtlCCzrevj6y
         EKRQ==
X-Gm-Message-State: APjAAAW99JwFFv5/Ylk2LPUlu65nTk1larbP73xEmSZmhABoN1XakmOc
        UlSt92UnBr2lwiBiXK2/rD4gLDrHS8f/pQ==
X-Google-Smtp-Source: APXvYqz90gUM4bQKCQA8rG+/QRqTHz4+xHXdOcriKdIpfZZrSOyyCjfNF3hrjM2uLtIYGv0SUbncyQ==
X-Received: by 2002:a17:90a:2008:: with SMTP id n8mr633710pjc.4.1565056180247;
        Mon, 05 Aug 2019 18:49:40 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id j12sm76950338pff.4.2019.08.05.18.49.39
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 18:49:39 -0700 (PDT)
Date:   Mon, 5 Aug 2019 18:49:35 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Subject: RFC - Git Developer Blog
Message-ID: <20190806014935.GA26909@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

In backchannels recently there has been some discussion about the idea
of a Git-project-blessed blog written by Git contributors, generally
covering usability tips or overviews of the internals of Git which the
general public tend to find confusing.

Ideally, we could use a channel like this to make Git better understood
in the rest of the world, in a less formal setting than the man pages or
gittutorial. I think it would be valuable to have resources which have
been reviewed and endorsed by the Git contributor community, in addition
to individual company blogs. (It might even make sense for contributors
who would normally post this kind of thing to their company blog to
cross-post the content in both places.)

Are folks interested in writing and reviewing this kind of content? Any
ideas for where we may be able to host (maybe git-scm)? It could make
sense to review contributions like this on the mailing list, so that we
get the attention of those who wrote the features that are being covered
in the blog posts - are we okay with the additional traffic?

Some example topics, from the top of my head:

 - Using `git worktree` Effectively
 - Overview of the Git Object Store
 - Finding Regressions with `git bisect`
 - Life of a Git Remote Request

The idea is that we could cover high level topics stringing together
multiple components or giving power user advice, which we can't really
do with the manpages.

Thoughts?

 - Emily
