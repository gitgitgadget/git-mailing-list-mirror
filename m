Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3779C433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 09:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0F8A60FF2
	for <git@archiver.kernel.org>; Fri, 14 May 2021 09:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhENJsc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 05:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbhENJsb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 05:48:31 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907EFC061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 02:47:19 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x2so42276335lff.10
        for <git@vger.kernel.org>; Fri, 14 May 2021 02:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=aE88qg07ptsmnW6PUeh3uFSMeW7ys1cEfE3afgF2i/Y=;
        b=RnIZutzuXZNyindeDIdGG2fDNn7Y077c44haUppMd3PRVa4GUXos9wd+SGlVW2zlU7
         hlQoNf44i68sA8IaJ97kDHbdf5HxN8/SKd4xXHTHrj4xu2Qsvae051rpX8VaupICYT7I
         /Pml1b06pd8F5/5VfFrfTgMOrZBbj2/a7UV7LicXccG3YTIpGTOcXLQQUlE22UsoF/p3
         RbJDQMMB3I8NBUg2ReWDx2u+hjV0F617iGrlW+FsHfC1vyWrpGyJIkDpTtd7rNOng1cc
         FmjUPg5Y8aecJhj63xideDQfGA0q04KkHNDwg0vxccGvQ8A1+XEqhUDvPW3W4TatqMOa
         fMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=aE88qg07ptsmnW6PUeh3uFSMeW7ys1cEfE3afgF2i/Y=;
        b=ee6NdNQml9Gyl4sw5LXmIsFxnA5V6eavfKO+SdGIuYwb/z79tHGrnwnK0l3Gx/NSm4
         tcVsQz1QMhVeCDT7RwoOJOXtIXnp816lxt9L1f/Gj9EfQvJ08NkEFkBk/nUZlP43zdn7
         kqzusctoSvGLXa6TEnXUD+SML+vwN8A+tZ7UvJNzOG6e6fpoR4DfpBPY8eBWVcRVCry9
         OKDSiGAvAExa2dbSw6CRVbRWME5cda0pdD060XKBjwlOM5lwf8V1ChXhSeZayBW8APgG
         6kageKOLcOQPu8wv//VMKHV3i1MPn+5nYSZ6M6jRLf+lCx0+x3Y8wFkYWgQxvR6YR6xF
         mOlw==
X-Gm-Message-State: AOAM530/DtYmSWPNJWAbyYUhUwYekMGDnbvX7MRTrjsV2ovJeBCF+qKb
        /O2nIkEH1yycDrKmHyZytOgRuu0RknQBw6We+7Z7UhpMm+r4QQ==
X-Google-Smtp-Source: ABdhPJxvczJidRWkAqAJeCrwDyk7UQmQf/YeeUy+vBpvEOR6IXX++J6K6zOGxvWkwj9N3GkafK3EuBjdgkdlG/nmc2s=
X-Received: by 2002:a19:6b0a:: with SMTP id d10mr32993296lfa.310.1620985637854;
 Fri, 14 May 2021 02:47:17 -0700 (PDT)
MIME-Version: 1.0
From:   Allan Ford <allan.ford17@gmail.com>
Date:   Fri, 14 May 2021 19:17:05 +0930
Message-ID: <CAL-6oQo3KDrrw+DiQsJJR_2tMjrLY3xu5ARJz0SJJ-naQqo8Rw@mail.gmail.com>
Subject: Git Gui - Searching for in Google
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git Community,

Just a thought and suggestion ..

Git Gui comes with Git download .. (remember this now ..)

https://git-scm.com/downloads states this in text.
https://git-scm.com/downloads/guis states this in text.


However .. If a person is using Google and searching for Git Gui
download am thinking a picture of what Git Gui interface looks like
would help flag to the searcher that they are in the right place ! ?

I.e. https://git-scm.com/downloads/guis has pictures of all the other
GUI Clients .. but not git gui !

Git Gui has the recognizable vertical Git in large Grey Red and Green letters ..

What do you think ?
Can we add a picture of Git Gui interface to either
https://git-scm.com/downloads or https://git-scm.com/downloads/guis ?

kind regards, cheers, Allan Ford.
