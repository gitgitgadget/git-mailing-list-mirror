Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4B2B20A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 00:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbeLLA2F (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 19:28:05 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:41349 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLLA2F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 19:28:05 -0500
Received: by mail-vs1-f74.google.com with SMTP id h10so8620710vsd.8
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 16:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tfg3dgIkltTeNypjn7q1HupZT6MAYabqWWT1tYWkSvk=;
        b=lYGXbBAfu+onNGKTqAtqtlRaBHvjb7T4zYi6fJjRLuDdrvJ53dCE2RRv5HX+e1VjE9
         5hLwYimrYhFD/yD8k92kpJyk6OBkDEnOxEO2PRHxqNekoTDJX4SEBegqIm+dizLJ8880
         NwS9P38VuVsUNIrjYzs1m/g2zMiAywguxj4xxblvtA/4wuK5QQecRmxzSbr7GQ9F+2Gv
         iQgnxVl7K4ida68ur614msyNTE7cYDLq8UNJxOCk8QNROfRdGg143zuTOh+5ttVEzobO
         DUo/+Fn5MYJFyoZeLIt0BX61o6iu6io92quh+C8T32jM9nVXqwC0ZOJYlj698i3xzP9u
         nGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tfg3dgIkltTeNypjn7q1HupZT6MAYabqWWT1tYWkSvk=;
        b=I03R2av5BQ33A9pS5dP/O+sc4m7/U85Zyk13KV+5KlNpn15AwtO+mDM32R/94RmTDl
         W8Sx47kueQ4tjDdUAltLBdbBjEjSJVB6uJkZ3P39GP58IIcznfs3ExDZTdpbynuOatGM
         DXtEs3UT8LIWDgfyChpbcHT5wm4m5ObTUsBPIirJa7el55OjpAh2HUNGLOvZoIUGfsjY
         hfoEdVYwsV+Q+U3tjgycZ5kBB8kgrs9eDsgJSi5xpZY2CuMkt5U4E7xl9wKFx8MiAGFF
         UNEY4BblJS2RW3xhvp/HriMsBhXSrogpwQ3SC2fV9i51wpxJ3l8iunZKEueIJPM6LDWn
         D8RQ==
X-Gm-Message-State: AA+aEWakG+phwOa99Eane8xFnEg051foQR7s71+7T0U19x4gaB2VWM3E
        nelNXf4MyjOW90LxpV3ig777e6EaNOJQghDm4M3mbQq3lBjhk0sM1SyVClV373+AJYa+Mp9fHJ1
        tex1Cy5i9r5KkBpbtmv+WJUe/c5PrTEFnaLdRb6P2TKThSns/5Ge0+0e9PcYbCTS6QmK/0BcG63
        bw
X-Google-Smtp-Source: AFSGD/WPU1xdNFeuC3ecyYKF7tnVzLHOy8/XkUaqH+kSc/taTuJim23yvabXh5d3ZwtCHdSZZH377/3yx4qRujT8GlUr
X-Received: by 2002:a67:419a:: with SMTP id x26mr16719252vsf.22.1544574484697;
 Tue, 11 Dec 2018 16:28:04 -0800 (PST)
Date:   Tue, 11 Dec 2018 16:27:55 -0800
In-Reply-To: <20181211212135.21126-2-avarab@gmail.com>
Message-Id: <cover.1544573604.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181211212135.21126-2-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 0/3] Some fixes and improvements
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Aevar for looking into this. I haven't looked into detail, but:

 - s/where/var/ in your patch 1
 - I think that variables should be unset with env --unset instead of
   sane_unset, because (as far as I can tell) the effects of sane_unset
   "leak" from test block to test block.
 - On my computer, some tests still fail. I have included a patch (patch
   1) that makes these tests succeed.
 - I noticed that some of the tests fail because fetch-pack doesn't
   support protocol v2. It turns out that adding support for protocol v2
   in fetch-pack wasn't too difficult, so I have done it. This is patch
   2.
 - With that support added, some of the other tests no longer need the
   unsetting of the environment variable. This is patch 3.

If you agree with the general direction I'm going in, when you send out
another version, I would add patch 2 somewhere near the beginning of the
set, and then squash both patch 1 and patch 3 in the G_T_P_V=2 patch. 

Jonathan Tan (3):
  squash this into your patch
  builtin/fetch-pack: support protocol version 2
  also squash this into your patch

 builtin/fetch-pack.c          |  9 ++++++---
 t/t5500-fetch-pack.sh         | 13 +++++++------
 t/t5539-fetch-http-shallow.sh | 12 ++++++++----
 t/t5541-http-push-smart.sh    | 10 ++++++++--
 t/t5551-http-fetch-smart.sh   | 23 +++++++++++++++--------
 t/t5570-git-daemon.sh         |  2 +-
 t/t5616-partial-clone.sh      |  3 +--
 7 files changed, 46 insertions(+), 26 deletions(-)

-- 
2.19.0.271.gfe8321ec05.dirty

