Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6036FC55179
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19C2B2072C
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389195AbgJ1Woh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:44:37 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:32806 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730746AbgJ1Wog (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 18:44:36 -0400
Received: by mail-lf1-f67.google.com with SMTP id l2so907088lfk.0
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T1ahcJPJFHf56K6xFcUaZWXqoJNJHbbSETy7glXiT3U=;
        b=MbOKNat+dW7/tVGey/iWGllVsGsJAGCCOYG5sIdU6fo8sW2S4VMqzK61H7A197B0PA
         D4UxPC+O8I9JbLxQSshA9aiEjqVJKg/V+73vamRIqiJNCucUEa1zUc4d2w7Sv5QpSquC
         9ngERTLbErY7DRil49UP/vkeJT8ETyokx+ZZ+OJpSwELyDmF47JGh5RoKNLhOb6mi7nr
         9piCALMfnHsscKqv//wgI6EeYM9651kWgQo44p+09qaa3nnO0NYr1wO5RyVNLKaumHWk
         R9EZinj6YTDYF/LRHmR2EsgqbMd1PqOc4Fd/mYnbPbbdWLK05MLvVIfAOHZL7ktmfIeK
         mmeA==
X-Gm-Message-State: AOAM532wShUspQnSv9cTtvOp4IFjCbbhwrlrp6+hlTVtOVXjTY0bGnSa
        Z257qNZ1fJs98tFcPOsnjJcN+tAJW8tkYRPVJsH0n/0U
X-Google-Smtp-Source: ABdhPJxRNNqhy2CkAxhDpePUXiKFKeHzw0K/1COfyHCFncDYfoj5RwLalM96F1WrLPejHizhWv29HODf4R6Pgl0PStI=
X-Received: by 2002:aa7:c0d2:: with SMTP id j18mr9309956edp.89.1603905793601;
 Wed, 28 Oct 2020 10:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.774.git.1603889270.gitgitgadget@gmail.com> <7d3fc0a503b160ea15363a4465af4647bce6a30b.1603889270.git.gitgitgadget@gmail.com>
In-Reply-To: <7d3fc0a503b160ea15363a4465af4647bce6a30b.1603889270.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 28 Oct 2020 13:23:02 -0400
Message-ID: <CAPig+cQcjjj3x_iTDX=yBUai6xHrShsGO5J3sdpX-2UhM7_OJQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] doc: line-range: improve formatting
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 28, 2020 at 8:48 AM Philippe Blain via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Improve the formatting of the description of the line-range option '-L'
> for `git log`, `gitk` and `git blame`:
>
> - Use bold for <start>, <end> and <funcname>

My impression is that it is more common in Git documentation for these
placeholders to be formatted with backticks rather than as bold (or,
if not more common currently, at least is trending that way). That's
not to say that my impression is necessarily accurate.
