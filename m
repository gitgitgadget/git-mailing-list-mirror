Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 337B71F453
	for <e@80x24.org>; Tue, 12 Feb 2019 05:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfBLFVs (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 00:21:48 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:35443 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfBLFVs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 00:21:48 -0500
Received: by mail-pf1-f175.google.com with SMTP id z9so733133pfi.2
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 21:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=zXsuy0fAhlK3USwk5vPjG8lALjsxWL4YQSze1LhL9gI=;
        b=D0ApM0Wvz3Q1flhNh8dMI2KLaiDRiJAgQZ2zKR0xoEzU1PtkvGKRAlNdeD5unQ3qgo
         clNuL8qyX5zlAXohBhsmhWFULQEYPowVY2PmgDhLsxl2fYHD9T+tt7Go/4/tq2oPLxiK
         WWFKp6C+76prCD7ZG0eJwqErbkjMLXqpe3yozn6nPqw8N0NlrXJFmX+dNDoWtEsaTEKT
         AN2+jxD8CQlpIyPqgGIUxKKj3bDHBgXJ8K8bQofttXEVHuHyvuOJQ7+1La/LNae6/IIW
         ti97vT85psadean3BdR2ka+J80DM+bXW3IPDfwENcUar1NKg4shDrxjSuc5eJUETYe9u
         RV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zXsuy0fAhlK3USwk5vPjG8lALjsxWL4YQSze1LhL9gI=;
        b=mKzo+51EbqM2STt0VBHEJH2Yezb6nFtFNnA31mU/ny88KH5rzy4Flbf3OhtSS3LQ1E
         1A7DvHv7oSP42ilXahPkUYwybWKu+/d6l9U6p4nNy/PY8knLpuRlcg9nm7G0NsS9dTcW
         UO5POW1cevixuTglvroigvbms/rv5r6JfG3RiiEyGoos8fdaVKeDcfvwrxtDHqSX4Fs4
         /W2UCBLcOCrIaLMbD3N+VEcezjJT+xC9wiIawqB6hMHSE0gjcWN7Zqr5PioDB6KMw0Zo
         +2hafQsiSc1iQOWZsKAGJmWjhcFZGgaFj+8sgGoz7HWc7TmdOzAHtxWJF+IXcp3lTYIC
         IH9g==
X-Gm-Message-State: AHQUAuahva4N+lZOk7W/lBsohuhD71XiB3/pOEYFBfD82k+2xPTCj6O8
        Voi1OWh0cI757qKxQr0k+ROgU8IOLBh4y4xcVBVEvR9p
X-Google-Smtp-Source: AHgI3IYXAIpt4dngAAQAwYZ9IV5Kb+foJYgwgrjafuQdIIJJomoXsutYprbjxq46wW0KXX1WbrJEKaXNLXOQFiQJh8U=
X-Received: by 2002:a63:4c54:: with SMTP id m20mr1841592pgl.231.1549948907085;
 Mon, 11 Feb 2019 21:21:47 -0800 (PST)
MIME-Version: 1.0
From:   Roman Gelfand <rgelfand2@gmail.com>
Date:   Tue, 12 Feb 2019 00:21:37 -0500
Message-ID: <CAJbW+rkn7wbRhDvRTtdp1aF5wd5PWHu9DqvPFm-BdVkR02Wgvg@mail.gmail.com>
Subject: Hotfix Branching Strategy
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 At any one time, up to 3 developers could be developing hotfixes
addressing issues.    Whether it is one or multiple people working on
hotfixes, we always want to produce one hotfix.  Each hotfix is a
cumulative update since beginning of release.  Just about every hotfix
requires database upgrade.  Being that it is cumulative each developer
is dependent on the other.  Considering the requirements, what should
be a strategy to deal with this problem.?



Thanks in advance
