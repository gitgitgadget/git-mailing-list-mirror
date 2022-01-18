Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395A9C433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 08:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344645AbiARIkQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 03:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240048AbiARIkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 03:40:16 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BEAC061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 00:40:16 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id z22so53068768ybi.11
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 00:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aWPhqt7XpXeaZeYHsd+AU8G+5GDgxcj3SnVRKIAbF2w=;
        b=THjRWmTZTQQRgSGzhp9hDlWA61breScDe5CLcrE+L6wbuRw9OYB25byGoG4OoRtIDy
         nciGmPywI3O6SzJATiSBCfY2F2joCKoJeebWu0nSlOOnhVbETIwJRbW4J6cF8GpnTMMx
         wBPa7VyMZgzlM7+N+SN0FxVPjzys+CI4llJBvs29EjffsEoqW8xoRC4rPG/5W+XXui4G
         LfFfvcwCdd1IvK8kRJf56hti1g4Jaalcow6MOhxbf21fNW/anWM10F/yHYRcChWBZSHM
         iXACvyFtJRdYBg5geBm5VvHE90d/9sHlXafng2qeqebp3RKka5j4g2HYulsNWzd6pYGh
         3XiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aWPhqt7XpXeaZeYHsd+AU8G+5GDgxcj3SnVRKIAbF2w=;
        b=7D1iGbhA8rCIwNURMpyN7yklRq5S7+0addgLDUQ9aQLBiAEe64jgaBH/szQwOhLdHo
         JRtV3eBc3hA3wtEWGu5oxopVeO6+LOX/IW+2d1CIO9QECR4nHKMeWt2ntAOd7koYfYeo
         gcs3gYRfAL0OC9eo3JlCzQzoDvNtk2MHKw7W6PdR1z/Ejre3ZSMyo6EKi/a+BQl314Bi
         SawJJtiwaFO6GBQW0GAUXr9YqRg1r/iXEyzCgqO+cCz3NR9H2hzddkavXZ8ICxuUqLD4
         1kEWS5zm3WiUNqCR8VXMtSBP14sEFBKujKDeKpjTuipr6Z1JDgGyHjD/bI52MJ9U+t13
         3CDg==
X-Gm-Message-State: AOAM533k3NH8Q8IZWguXANszTZf5STQ8V+7FBMV6NAA4XS0ptEoZzyVd
        u6okEGlGFlP8nDvFaIiRvP22S009HQMX5X2mO01uHm9NH1A=
X-Google-Smtp-Source: ABdhPJwxQQxkD/4e8shd7xYh0jmlC6m/W1xlYoum4YoNEDErOEtMzaTadh3L9Lr7v00YkXm8Dsm2xRSvs2o+Vqr4xCg=
X-Received: by 2002:a25:d4d2:: with SMTP id m201mr4580665ybf.649.1642495215223;
 Tue, 18 Jan 2022 00:40:15 -0800 (PST)
MIME-Version: 1.0
References: <e176d1b3-482b-899b-af24-ac03c65d103d@gmail.com>
In-Reply-To: <e176d1b3-482b-899b-af24-ac03c65d103d@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 18 Jan 2022 09:40:04 +0100
Message-ID: <CAP8UFD2BCX4es3ph5rudkfy5WZN+Q-Y-SPbB_KGiNy3xtQ-JYA@mail.gmail.com>
Subject: Re: [Newcomer] Suggestions for microprojects
To:     Jaydeep Das <jaydeepjd.8914@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 17, 2022 at 5:10 PM Jaydeep Das <jaydeepjd.8914@gmail.com> wrote:
>
> I want to starting contributing to the git project but can't decide
> where to start.
>
> I have read the coding-style and contributing guidelines stuff from the
> website and am eager to start writing code. Is there any small patches
> that I can make in the codebase that could help me get started with it?

Our https://git.github.io/General-Microproject-Information/ has a "How
to find other ideas for microprojects" section that might help a bit.

You can also take look at
https://git.github.io/Outreachy-23-Microprojects/ and the
micro-projects we previously suggested on
https://git.github.io/Historical-SoC-Outreachy/

Best,
Christian.


>
> Thanks,
>
> Jaydeep.
>
