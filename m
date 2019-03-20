Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0711F20248
	for <e@80x24.org>; Wed, 20 Mar 2019 22:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfCTW4n (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 18:56:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50180 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbfCTW4m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 18:56:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id z11so902856wmi.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 15:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fKmuYOCtZzr/e9kok2H37/XVK3Vj3EGZkNCEQO0ltrQ=;
        b=O0jpSeS6YAV+UlLssgQLFm3pA0JZD8beZEvmHD6sy6PeIfQj8KVpgQqO4D81Z+3r8C
         FQNDMYK408s83sOxqgeNUqXf9fMLaAve9gqNNFSTRWjz4nzqYSptyyuDOEX8H+pextlc
         H8wmRvzsjFFsE94tbo/nwjFFxpKqkF6XMq1cGoS5u80VhMCxvH20b608kmn3pCpt1UWz
         rgM/aXa/Fg/hiJOOg4en0PfZPRceDLMWGBwOJoHWyiR/lvFoUJ7y+1qbMwDRMJwUJWss
         Hjmlff7iRWYuqCiu3YZKqlaufqcD9z5qJvV+7vnd4NzQzzL1BTa1KeAv27gOHYCA3TV8
         grzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fKmuYOCtZzr/e9kok2H37/XVK3Vj3EGZkNCEQO0ltrQ=;
        b=H97lDOrafXRfxZ1XujEV00gX0GRVUihUs8VGF0rzkqT3tKdAAsE+UFTLbH+D1Iepog
         kCrJYqqptVghnSPz3k1CG+LuFZ+bPIFm/LdMKuZGAqYgMUU0XYFRaWWJduJJxxSzZ4Vn
         puZj8Yj3dp6D5I7LPmPmwiIYCUgKNL8TaAtrgHNLD38y2euG0jnzt9r/1A2Q+krJaQBC
         vO4ivoW12iGWHdeHZIFYg4i1s48ExIFh7pW6vX7L070wYnVFr+17YC1xzPsoJ7hfPGn1
         EICe1013O1Rcen4+FyrRPg46FYBaI8abyOR8vPPfPYBnn6QA8D7sucBXL5jUj4jvv64e
         CnxA==
X-Gm-Message-State: APjAAAVFv4wSDB4I7hqfaAJEW65nGuPQ9iYHhxYHv5XeIllD9K7P+iOQ
        PMn16aHaJKYpgQc8J1/BG/DGyAnu
X-Google-Smtp-Source: APXvYqzivN2v6aBgsKyghxqtw7am3nsywhB+mLLoVvaGmkAuR7aqMYG3l659ri886XWdcYlsczB2fw==
X-Received: by 2002:a1c:9ad1:: with SMTP id c200mr445076wme.140.1553122601069;
        Wed, 20 Mar 2019 15:56:41 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id 84sm522612wme.43.2019.03.20.15.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 15:56:39 -0700 (PDT)
Date:   Wed, 20 Mar 2019 22:56:38 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, sunshine@sunshineco.com
Subject: Re: What's cooking in git.git (Mar 2019, #04; Wed, 20)
Message-ID: <20190320225638.GF32487@hank.intra.tgummerer.com>
References: <xmqqa7hqw844.fsf@gitster-ct.c.googlers.com>
 <20190320220509.7180-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320220509.7180-1-rohit.ashiwal265@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/21, Rohit Ashiwal wrote:
> Hey Junio!
> 
> On Wed, 20 Mar 2019 12:13:47 +0900 Junio C Hamano <gitster@pobox.com> wrote:
> > * ra/t3600-test-path-funcs (2019-03-08) 3 commits
> >  - t3600: use helpers to replace test -d/f/e/s <path>
> >  - t3600: modernize style
> >  - test functions: add function `test_file_not_empty`
> >
> >  A GSoC micro.
> >
> >  Will merge to 'next'.
> >  cf. <20190304120801.28763-1-rohit.ashiwal265@gmail.com> (v3)
> 
> If we are going to merge these in next revision, I say there are some
> minor changes that Eric suggested, basically there were some extra spaces
> in commit messages and a small change in commit message of [PATCH v3 3/3].
> There will *not* be any change in code. Should I attend to them or we are
> merging anyway?

Junio sometimes applies these fixes himself, if he deems it easier to
apply them directly than to wait for another iteration, and if he has
time to do so.  If you have a look at the ra/t3600-test-path-funcs
branch in gitster/git, e.g. on GitHub [*1*], you can see that Eric's
suggestions for the commit message in 3/3 have already been applied,
so there's nothing more you need to do here at this point.

*1*: https://github.com/gitster/git/tree/ra/t3600-test-path-funcs
