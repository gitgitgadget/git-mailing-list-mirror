Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC9691F405
	for <e@80x24.org>; Wed, 19 Dec 2018 18:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbeLSSlA (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 13:41:00 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44324 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeLSSlA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 13:41:00 -0500
Received: by mail-qk1-f195.google.com with SMTP id n12so12247394qkh.11
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 10:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3dvTg2nxzHlPvAvAYKyVWSTH6u8tOwLCgI3SZUiRwH0=;
        b=dAVcTpbTYxQ3PV1fFIkr3DxUoVZ87Q64h8MdaRCjXS7ElKwBARIvY/sqJf77gG9jSZ
         KcdIYCvB4ZhE2WPvwcsAD/g8FnVTH72X83g31KaSEUnS/r4Cu2TIkMuWCMkEYXWJcqNf
         lVNiiMMKyjlkX56v8l/ZHQ4CA1/0BcosRt2+dyFml1dXAI7WZrbaGdenMVpihCMwuwJp
         POHZlP2G8RTUEjNrQGeK+6OWLBtJ34KnR2XkBrc+Q/KzjQ9qQ57ls/p+8KkPopfi6ZOW
         GZxxSnTF6yv+QWnHmBDqxL6S0hNyyiCIz+2rem8Lw8WtsDgRVs2DMoHwLtJIgfOfCNkp
         /PsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=3dvTg2nxzHlPvAvAYKyVWSTH6u8tOwLCgI3SZUiRwH0=;
        b=bICuop1WNa/1MEoxozmU9FrtaqatMzdUCkWQAFY/yWQP1WblSJBsLXlU9s+z1XQ7ZA
         t8Ijz/XsOveT5h0srBaU+KNTL6mRGNOOtEdoEwoz3cJC/NTdxKFI8GeXCOKd82Ysorxj
         /nqO4D03FgI6hMhN394UtF5mKrRP2In5NN7RyR5vd2AMQ6HyTVPCgUb7CcM+ai74vCCa
         QwKOZ2yVBi5CRBNDYmDxM2XXHMefh/uvVECtq/pIIx/5a24FQoXesVUGswgcHSJYXyQH
         E8RMnmVhL46M3YvOW8k5eFGApOneXImgWMsg6c87W/vo6TxQlVYi4jQQm3E9vXhsY+eX
         RGQg==
X-Gm-Message-State: AA+aEWbaDeXLlH57sWlQiMTOncMY5hWlzviwuBZk1C1L1x9+EwSaxzj7
        rE7QVYB8535OlgQ/NCCsmV6UIvov
X-Google-Smtp-Source: AFSGD/W4SsBkzDyQLrLO/RWcpAOw+gAK8YqNXrl+ET3hDaqmrpAL2NzydRrTzfs7GsmREerHd0ceuw==
X-Received: by 2002:a37:b46:: with SMTP id 67mr22144239qkl.256.1545244859085;
        Wed, 19 Dec 2018 10:40:59 -0800 (PST)
Received: from whubbs1.gaikai.biz ([100.42.103.5])
        by smtp.gmail.com with ESMTPSA id n71sm3089851qkh.59.2018.12.19.10.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 10:40:58 -0800 (PST)
Received: (nullmailer pid 16410 invoked by uid 1000);
        Wed, 19 Dec 2018 18:40:56 -0000
From:   William Hubbs <williamh@gentoo.org>
To:     git@vger.kernel.org
Cc:     williamh@gentoo.org, chutzpah@gentoo.org
Subject: [PATCH 0/1] add author and committer configuration settings
Date:   Wed, 19 Dec 2018 12:39:38 -0600
Message-Id: <20181219183939.16358-1-williamh@gentoo.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

this is my first patch for git, so please be gentle. ;-)

I am in a situation where I need to use different authorship information
for some repositories I commit to.

Git already supports setting different authorship and committer
information with environment variables, but this setting is global so if
you want to change it per repository you need to use a separate tool.

This patch adds support to git config for author.email, author.name,
committer.email and committer.name  settings so this information
can be set per repository. It applies to current master.

Thanks much for your reviews, and I would like to publically thank dscho
from #git-devel for assisting me in preparing this patch.

Also, since I use a screen reader, it would be very helpful if you put
your comments in your replies as close to the affected code as possible,
preferably directly below it.

William Hubbs (1):
  Add author and committer configuration settings

 Documentation/config/user.txt | 20 +++++++++++
 builtin/commit.c              |  2 +-
 cache.h                       |  5 ++-
 config.c                      |  6 ++++
 ident.c                       | 68 ++++++++++++++++++++++++++++++++---
 log-tree.c                    |  3 +-
 sequencer.c                   |  3 +-
 7 files changed, 97 insertions(+), 10 deletions(-)

-- 
2.19.2

