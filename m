Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F134CC433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 21:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbiD0VTp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 17:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237692AbiD0VS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 17:18:57 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9A05710A
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 14:15:38 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id q8so2661879plx.3
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 14:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sDh/s7+P8/xTzKEk5IFTgloU3PipHK3ytf9swGHjLUQ=;
        b=uKeYbMTIZBtZA6h3GJZDP9Cc7gE1Mu0iUy/N/zUw/oOMS9WgRMr/jgB9w8weyVxw2y
         go9g2BkN7tR81McGahkXTkMeRBFEBSBcVqh226NVs63kJvrFw6Xl0Lc+pr11JMT+DkdH
         z/JTF5llh47KckZw/GdjCIGXFG3v17j9aSjB386RjzfdMnaLNGbGCo5eOb3v3yBHDJqL
         BkgmidXHg31YpEvcSfj/Jn+IaGRxJ2ukzbKGbTdizhP4xAZGI69OoV9tfyyLo0BCC2zF
         lKWsjgrSNdTN6vGm++N9REz2sO1863j2HnRWZuT288P//sGXgqgMSUElT8yhPSHp1z/r
         lcYw==
X-Gm-Message-State: AOAM531fqeznA200DgohiG0oHZ5KOos2ntgxRfvAWwUSVaKSmkAWAkhY
        RTLENXdhzJZbI/ztuv6bpSCr4nlNyobrsS1MMiM=
X-Google-Smtp-Source: ABdhPJwCkHN5jmyU0qy9V2AF+W6aGGt7iED61bUlxOfvQdevs/InvWchwMbibad0WOYlfBd+aisX+6BYcCkqwh6LeWA=
X-Received: by 2002:a17:90b:3ec8:b0:1d9:6cbb:8222 with SMTP id
 rm8-20020a17090b3ec800b001d96cbb8222mr20704035pjb.104.1651094137692; Wed, 27
 Apr 2022 14:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1226.git.1651086288.gitgitgadget@gmail.com> <7e84d5b286de9dddf28ef1c8f38c7d7c28e266f0.1651086288.git.gitgitgadget@gmail.com>
In-Reply-To: <7e84d5b286de9dddf28ef1c8f38c7d7c28e266f0.1651086288.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 27 Apr 2022 17:15:26 -0400
Message-ID: <CAPig+cRgD8LjQxnoJQre+sb2NcO2yHz19fPfAQsdYdSYUgyjLA@mail.gmail.com>
Subject: Re: [PATCH 1/3] MyFirstContribution: move cover letter description to
 a separate file
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 27, 2022 at 3:18 PM Philippe Blain via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> In a subsequent commit we want to reuse the explanation of the purpose of
> The cover letter form the "Sending Patches with git send-email" section

s/The/the
s/form/from/

> in the "Sending Patches via GitGitGadget" section.
>
> To avoid text duplication, move this explanation to a separate file and
> include it in MyFirstContribution.txt.
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
