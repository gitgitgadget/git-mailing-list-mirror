Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26E9120248
	for <e@80x24.org>; Tue,  5 Mar 2019 00:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfCEAJP (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 19:09:15 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55717 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCEAJM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 19:09:12 -0500
Received: by mail-wm1-f66.google.com with SMTP id q187so846718wme.5
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 16:09:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2aYAT+srjx1fQc0SioAT0DpKAVPWVANEfWc1HGjfeyc=;
        b=N+5PpBMc1xbY0XiX+BBluwp5AqIRtbC9iXQh2UQXlF1Nd5ehBwkQOeo0Za+MrThLVa
         BWiNRJkYnAT3WvjsUTs9LtInpxUwnTQ8kWFk3WrqBrKRCyWcdWIcEea4Ix5roMx5imm7
         8dRqrQbJqmJLSLt5zSeshKrDAzVbkGkBvTyE2+TwVWSwI4+7d3WxUiDgPJ7MvdUVQ7zI
         Hx7gspV+IeHb8Y1y5tnZY9dHyBRuqBih1YWBeiSJO8Ub/GuT62utEHjkAL3YtOfU4akr
         5veo+VESiZxnGHYndw2cWIhahRsABdzBRFKw0iv4WP8bjslPJggbneewqGYF6KKDp/vp
         CQxw==
X-Gm-Message-State: APjAAAVME/M8Yd4EoYusCH9cd8ReEeKTZTwIXtrhCm5SErHIEMt75zap
        3xi2TyqeyaB6YcKocmMpj2t1qlwyNjvfcJVKo0s=
X-Google-Smtp-Source: APXvYqxctlDPQOo8W4Xj9E43bCff1ZZXVZn6uR3hGZ2uTOkjqrQU3iLEx5UhSKzD3C2Gnaal1gfSQWd87SFUuq/W2FM=
X-Received: by 2002:a7b:ce8e:: with SMTP id q14mr867950wmj.71.1551744550945;
 Mon, 04 Mar 2019 16:09:10 -0800 (PST)
MIME-Version: 1.0
References: <20190303122842.30380-1-rohit.ashiwal265@gmail.com> <20190304120801.28763-1-rohit.ashiwal265@gmail.com>
In-Reply-To: <20190304120801.28763-1-rohit.ashiwal265@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 4 Mar 2019 19:09:00 -0500
Message-ID: <CAPig+cSsAufCnHPJfjQd8A778UNAsXEst1m+ekQ7T83=2mMUnw@mail.gmail.com>
Subject: Re: [GSoC][PATCH v3 0/3] Use helper functions in test script
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 4, 2019 at 7:08 AM Rohit Ashiwal <rohit.ashiwal265@gmail.com> wrote:
> This patch ultimately aims to replace `test -(d|f|e|s)` calls in t3600-rm.sh
> Previously we were using these to verify the presence of diretory/file, but
> we already have helper functions, viz, `test_path_is_dir`, `test_path_is_file`,
> `test_path_is_missing` and `test_file_not_empty` with better functionality
>
> Helper functions are better as they provide better error messages and
> improve readability. They are friendly to someone new to code.

As an aid to reviewers, please use the cover-letter to explain what
changed since the previous version of the patch series. Also, to
further help reviewers, consider using the --range-diff or --interdiff
options with "git format-patch" to visually show the changes since the
previous attempt (in addition to your prose explanation).

Finally, it is a good idea to provide a link, like this[1], to the
previous round in order to jog the memory of existing reviewers and to
provide context for people new to the review of the series.

[1]: https://public-inbox.org/git/20190303233750.6500-1-rohit.ashiwal265@gmail.com/
