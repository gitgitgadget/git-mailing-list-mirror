Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8872C433F5
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 17:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244267AbiBTRJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 12:09:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiBTRJs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 12:09:48 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7574551C
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 09:09:26 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a8so27267378ejc.8
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 09:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=TwAMoo3jHt7Uj41gunJIRPFV6ttZ9acB5WAFt9r5SnI=;
        b=nHGpgu+PoCkT/CgjSCHCqxeTy0j7jsAFSQ0uw++j/7VpXhnOOHa6CA9vXNhAqJu3J0
         iwTUhmLBsx4QjDknt1gmP+xWPswJc0/fHxhnLPw9sQZbDXqkORHBviZ8n6UYjCDiN77h
         /+5LpA53wuLOE882slUZa/6FwNJX/PNIWwBxU76Z1c2i9zXEddPcxdvVTltVz9Euqci9
         j3TfHs0jimQe09rpHJDaFHMLiUKMLrqhhGpuQLzDhRSoBt0frE9VPZ4uxk0cISD7V5Ja
         AqsfTz0Lg8rYVBPvD2CX3QAzuL7LVQOdnCH01/WTm9Aks1KisVwRGMbSYZgV6ZcquMIb
         DBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=TwAMoo3jHt7Uj41gunJIRPFV6ttZ9acB5WAFt9r5SnI=;
        b=5koNXzXe/7dbkjqkUYNtNmCTxuKBWeR/4hwLO/9fFWaQ+9DuqQ+x18anPAHMtsTLah
         AKr3lWV3XgtTBSjyoOsLL5KxXXiXPiFxLb/SmqryQhN1XtOsHnUV6jHN0tzDH7FzDch/
         KVwvgKcf2WvlIQ4XJSmOzCClbGIFeoiXhYdXzJvyHInl9vTOVNK/JiEKXx/DCeHRoNxq
         bJgAJ0E+0jjKJqK92ANe+skOiYPs4kLcvu3ew0TGPUCYHkMu1dcWT0K1A0/6hQ2HGgt+
         6Vxwsl64Hazzr6zH5fxSnYRCoT5dJwyahriPVD5E4kMUOaYDssc2UIAVASDYqzNxQHHa
         b9Sg==
X-Gm-Message-State: AOAM531byzITH9p4fkjM1dKDU8Nl9PRxvUfJPUwr3S6cnBFdZvARlpuS
        5uFRDEvqIE4tg5Qfe29xnByEtWNMTxs2efH/S/2gIpt5YyRVRQ==
X-Google-Smtp-Source: ABdhPJzdV4ZedG2XcmIOp4lNl6RsP/Tdqbb0QcVZbs7D3TWWM1Uapxax90uiVbF7N92Er8rf/LgeQdmO8vKGM78VD+E=
X-Received: by 2002:a17:907:334c:b0:6cd:76b7:3948 with SMTP id
 yr12-20020a170907334c00b006cd76b73948mr14132391ejb.55.1645376964972; Sun, 20
 Feb 2022 09:09:24 -0800 (PST)
MIME-Version: 1.0
From:   Shubham Mishra <shivam828787@gmail.com>
Date:   Sun, 20 Feb 2022 22:39:13 +0530
Message-ID: <CAC316V7M8bziK207tuFbctAqDdz+GC8OGaxM+B0earJtqDvBSg@mail.gmail.com>
Subject: [GSOC] Student Introduction - Reachability bitmap Improvements
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
I am Interested in Project - "Reachability bitmap Improvements".

I am Shubham from India, I am a 2021 graduate from Delhi University
and currently working as a Software Engineer at Microsoft. I am Open
source enthusiastic, I have been contributing to the Open Source
projects since a while. I was GSoC 2020 and SoK 2020 Student with KDE,
I was Linux Foundation mentee where I contributed to one of Anuket's
projects.

I always find myself fascinated by the softwares like linux kernel,
git, or simple commands like ping. Which impacts the life of almost
every software developer around the globe.

I am going through the blog [1] and I love the technique we are using
to fasten the queries. I have still not decided which one idea to pick
out of many mentioned under "Reachability bitmap Improvements" but I
think I will figure that out soon.
Can someone please tell me if a micro-project - "avoid pipes in git
related commands in test scripts" mentioned [2] is still available to
take? I have also gone through - MyFirstContribution.txt and
CodingGuidelines.txt docs and am looking forward to start sending
patches :). If any of you think I need to know something more, I will
be glad to get your suggestions.


[1] https://github.blog/2015-09-22-counting-objects
[2] https://git.github.io/SoC-2022-Microprojects/

(Sorry, if you received this mail multiple times, my previous attempts
failed due to html in gmail as default)
Thanks,
Shubham
