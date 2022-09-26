Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C8CC32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 22:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiIZWhS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 18:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiIZWhR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 18:37:17 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC9A9DB53
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 15:37:16 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id g66-20020a636b45000000b0043a256d3639so4681551pgc.12
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 15:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=ii/WAjDkSo12ZNZ8SKOY1LZiuMxwoB6IDTJO/i654vo=;
        b=WhrTm8/Q9PjvrSLsbWcb70ScJjFYx9AgcJv3XFZBdtqkF1RFwepyVL4hIuO37yBgUV
         Ryi9neKxEe0ZSGdqWOvXBYXyrAYOG+U600wKIrKD7YQ4fn/ph4srgLl0XyGmkZipMs+K
         CcpKs24NNaHMJ43eHDM/i23WYuHSqjwvBJ389LdeiBdXUNa7lFnyrWPC5K6H7prLqNjP
         DOqIp16sayrJMLGOSrk1uY7iute/7sFPZ9s/1XPpkzJ4CovSjNpR0y0yFLbMgch2C210
         V8S4B6vpEOiCj7JDLn1jw0hvh0/6eMlYJU6m5M/JOOJSyHXK2SbGD8v4NHuPySyRBEut
         G2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=ii/WAjDkSo12ZNZ8SKOY1LZiuMxwoB6IDTJO/i654vo=;
        b=sM+7/uLJ0SbhnwHWHXwvrcByvn9d3PHGTtDJSlJqPqQHCnGVu3mUVGTslmpi/UQwZx
         KeILhidI2HAgdqvo4irINViQVqnM6kMAX/XKkR0s5W7td59MBWbZ64Xhmda9YHvJd250
         vMu6S/Z/oqQUyQ5i/CPAcOkWbwWqQ2ek2oM3XM4APmV3+GmPYYqskA6A4kKR/jfCLQRS
         GvPfPcFcWmLzreXex1IyrwE6M7mvSWKYSsxcBA9G0ZwLCxsTGqbiJtN6rrM767tczqAO
         TEKnU1YT8/v4UoS3MMR3G7l0MPp8zQO0Gtcg10cRPHcrI0GI9M8IfZldf3xrx5Ukay9a
         HLNg==
X-Gm-Message-State: ACrzQf2m7hVJBkL34wufiSiemexPpCmyds3XnUct+UPS/fR0nH1xTO6y
        UT6X/kNGpvGG8np0Icf2NVGTyajibLN//AAIxj54K1y7WsnwN885GNoOrVQbfJITlXuq/HTrQ4A
        dAhSN9ba+4dbUoeG7HaagYg1FBLKYMz3/DoSlerBVQJrBSjwPEDwrl6NcPee0HjE=
X-Google-Smtp-Source: AMsMyM7JG61FSK3ASvD8oGel7aTKzw7DdYbgsJ33jHm0jSZtiKhQYZWimyACkMQFYO7VbC1rflv0zF/XRpGr2A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:10a:b0:200:2849:235f with SMTP id
 p10-20020a17090b010a00b002002849235fmr59191pjz.1.1664231835105; Mon, 26 Sep
 2022 15:37:15 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:37:05 -0700
Mime-Version: 1.0
Message-ID: <kl6lfsgdn4oe.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Join us for Review Club!
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Christophe Poucet <christophe.poucet@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi all!

The Google-run Review Club is happening again this Wednesday at 14:00
Pacific time (UTC-7). You can find more info at [1] and on gitcal [2].
We run a session every other week, and you can find the full schedule on
gitcal.

This week, we'll be discussing Christophe Poucet's `git change` series,
aka "A better workflow for stacked changes" [3]. Let me know if you're
interested and would like to join (off-list is fine), and I'll send you
an invite :)

You might notice that Josh typically runs Review Club, but we're going
to be taking turns going forward. Additionally, if others would like to
run their own Review Club sessions (especially in timezones friendlier
to non-US folks), feel free to reach out!

See you there!

[1] https://lore.kernel.org/git/Yfl1%2FZN%2FtaYwfGD0@google.com/
[2] http://tinyurl.com/gitcal 
  Note that the gitcal event is a little out of date; it should say
  say "Please contact Josh Steadmon <steadmon@google.com> _and_ Glen
  Choo <chooglen@google.com>...".
[3] https://lore.kernel.org/all/pull.1356.git.1663959324.gitgitgadget@gmail.com/
