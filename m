Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEE0B1F97E
	for <e@80x24.org>; Sat,  6 Oct 2018 04:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbeJFLcc (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Oct 2018 07:32:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55160 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbeJFLcc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Oct 2018 07:32:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so3487179wma.4
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 21:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:date:from:to:cc:message-id;
        bh=nHzw4wto/bg/zRhNUTGZrhvmrmq6/uO2KiqoREHH8VM=;
        b=caBeeGjOs2tGkdrCHDEY/DB53jrWv1dP0v6S9QMBPCEFQ6ZpJr3ZwbryQf8Hg+Mqly
         0G2fHBuuVZ96E+IHvboECu10leQEmReVx4H+SxGY41hUHa8iLzePJYF68mwe6e9/Qhzf
         8QFoEnePZMyDrA0ouVFp9Xv6WK0hHqerGvhuO/ufQHykViTetFZWndZ3Is9sBm7tbclG
         oAiqLqwyFwCy0kslCcjGGN5mf9pWRnvDk8EHs8ubfPlRz/LgaOWJK82J/RA2c8IAq9Lb
         TGedTDUSdyKJgl8kwcEnxRnvgilULp3Ns7LSrNVSBAOX61qDp7pplhbSag15v60cMxLM
         H9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:from:to:cc:message-id;
        bh=nHzw4wto/bg/zRhNUTGZrhvmrmq6/uO2KiqoREHH8VM=;
        b=ga2DjJ2rqFZ5WWtZhpFdaYyupXNXqV4Hg/AxGz3j0MTzpHw9J7aoFyzhKee8WUw6np
         UjGc4LrB7Ao1yO/aqJilJ4nvCCf1C9sdB9dCCwoiUkgmIO/NwK6detm9Au/O3O6KuSLY
         MXnqR4htPcOpyEnoawwmD4CIZ8j4EOYuejb+oZeV2JXD94v/zJSHvyHh5JRtYT08ybKG
         bMvtBiFb+lafKGnXvXajSAfHELSoOs96iimEvqA2HSM+wVdE1g9xZEpbaL9lxj1/EFe0
         K+AedVs9ZUm8jjkhPmkuzgK5bf9ZGKnNRqlVQfDnBZMwD5gqsMJtMLsIPG3sxoDvf2FI
         Navw==
X-Gm-Message-State: ABuFfoivpHGxqfyEUArE8fLgRZHWp/RLoH7igvDaea0YskI7IrZwkAK6
        TlQpx38FLhCR2zg5p86omcvlW53Le1E=
X-Google-Smtp-Source: ACcGV61Hyc/vB+xJunSLHA3o+zDByjFlXsVamI8P7742mqR74jB8+oAYshxxpDxIixcAJ1aEPiFi+w==
X-Received: by 2002:a1c:b604:: with SMTP id g4-v6mr463960wmf.111.1538800242293;
        Fri, 05 Oct 2018 21:30:42 -0700 (PDT)
Received: from gmail.com (ip114.ip-142-44-232.net. [142.44.232.114])
        by smtp.gmail.com with ESMTPSA id x186-v6sm5338494wmx.24.2018.10.05.21.30.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 21:30:41 -0700 (PDT)
Subject: [PATCH] docs: typo: s/isimilar/similar/
Date:   Sat, 06 Oct 2018 04:20:22 -0000
From:   Michael Witten <mfwitten@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Message-ID: <a31311c7d5ba4dd18e0d0d70e9975e4f-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-rebase.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 1fbc6ebcde..432baabe33 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -954,7 +954,7 @@ command fails, it is rescheduled immediately, with a helpful message how
 to proceed.
 
 The `reset` command resets the HEAD, index and worktree to the specified
-revision. It is isimilar to an `exec git reset --hard <label>`, but
+revision. It is similar to an `exec git reset --hard <label>`, but
 refuses to overwrite untracked files. If the `reset` command fails, it is
 rescheduled immediately, with a helpful message how to edit the todo list
 (this typically happens when a `reset` command was inserted into the todo
-- 
2.18.0

