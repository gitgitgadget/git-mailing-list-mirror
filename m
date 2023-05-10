Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6E1C77B7C
	for <git@archiver.kernel.org>; Wed, 10 May 2023 00:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbjEJAQG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 20:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjEJAQF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 20:16:05 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF6E10D1
        for <git@vger.kernel.org>; Tue,  9 May 2023 17:16:03 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50dba8a52dcso8945a12.0
        for <git@vger.kernel.org>; Tue, 09 May 2023 17:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683677762; x=1686269762;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PGeRnAhPIkql1Jk/Er1csfulWLp0zVSXMVa0Vv42GGc=;
        b=FEbxk4NqM2EUdrIlyy6LNv6inkPQFvrqwo6m+eTJGcXmwqrq1mMeL+4N7Bn8B1rki+
         hrKQYGGVzYMCLD5p1GHGpomC+8xiQOCFUS0UsTmiQGQthpwHELnxel198tmQ5USTgFZ/
         2CH1Cgo6gr2X+gDldhuaEVa/MHxpRVssCU4fAl/KS47II3FMESbivB5TgAp4SgFfI2sP
         27IwApS9nZGLrQS8BqNnMSWo8EBgyiQ/CcHS+a9YHani6F9duhgWO/3S0ZGG9wseASIf
         hA3x4gg4lxuO8MujqNob96ZHwIIDM+LJXS5eS4DENdg6RRhPGavVMli3rsQBFTqHhyNb
         gUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683677762; x=1686269762;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PGeRnAhPIkql1Jk/Er1csfulWLp0zVSXMVa0Vv42GGc=;
        b=K7n2RsTdptP2UIaP2K1Zh3TMHTyaePmy865pxQnGhZfQdFVLCdJwoqwp/GNkxnaVXa
         L4XbxbZ+ux8fo60h+X/BzpoIeMvi2xepZQqP7GA/rkgHd46Cz9BViZUy/TupqfP2oQwd
         yTEJACRGiucEsSNLe0vGoVuzbLroniVc3aOdsI2v+tijWcnzIBrQNM+I5XAnQQV9ymDo
         4U2PapRrkvl7c5H2jiF20MtiFa8QbL3fgzZiepyd1b48X2/wqOufuQ17sD8UTrDVYQ5z
         bwUJEmIQO/lkyS6IWq/eZ7wSwCapwQIf7a1llZLqbl+98QoAr+i0INhNfHMSntNfYTkW
         QP2A==
X-Gm-Message-State: AC+VfDwJR4cP91+WRiuHjSqiU25fbsSIG+KC1zxs7fwJ+hQ7+VqUsyeS
        X2m37BDiySvcXzLTjf6f7DZgWcCINy0Y0XplkXh4J1nHgw4X0lLVW3Pacg==
X-Google-Smtp-Source: ACHHUZ7WnWwgHhJzctuc/zQkBa2bs2qDPjAVDM2t+T/VHXgNs8NuvmSArj9OMy+Q3EwUgymiGQInYK0COcbalOBC5uY=
X-Received: by 2002:a50:931b:0:b0:502:368:66a8 with SMTP id
 m27-20020a50931b000000b00502036866a8mr12483eda.1.1683677761917; Tue, 09 May
 2023 17:16:01 -0700 (PDT)
MIME-Version: 1.0
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 9 May 2023 17:15:47 -0700
Message-ID: <CAFySSZBFxupHp-o8ApF4A1KnmefUYTPcbbRZgk1-FUknbw07_w@mail.gmail.com>
Subject: Join us for Review Club
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

Review Club is happening this Wednesday at 14:00 Pacific time (UTC-8).
You can find more info at [1] and on gitcal [2]. We run a session every
other week, and you can find the full schedule on gitcal.

This week, we'll be discussing Avar's series to fix tag parsing for
mismatched types [3]. Let me know if you're interested and would like
to join (off-list is fine), and I'll send you an invite :)

See you there!

[1] https://lore.kernel.org/git/Yfl1%2FZN%2FtaYwfGD0@google.com/
[2] http://tinyurl.com/gitcal
[3] https://lore.kernel.org/git/cover-v2-0.3-00000000000-20221230T011725Z-avarab@gmail.com/
