Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4416C1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 12:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbeG3OIZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 10:08:25 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:47414 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbeG3OIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 10:08:25 -0400
Received: by mail-ua0-f201.google.com with SMTP id g19-v6so3846794uan.14
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 05:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3wSRRO57jFB1AsDR3Z/ljCEGLBSneMwOrMM+TX5aT3Y=;
        b=npdcK90Xfiq44qW++zbNu5vCOL7CrbKVcynCUSK/H+J9tkuzpMUXqPh0p1q3NSBwto
         qica6KOPH3KNoKwJfbht+MQwc5Jkir8pw9FiforKYhqkWbJzyuzgCUQTETVjj+8Au96y
         6nxUjsz1w2zjLQYexQdtV0h6x6cHoU4KSOKJGHkjoybmhTIaqWqdO0fHZVBle7uLSG/o
         ZytXA5e97wRKxqNZOqCZmjFnnro5Pn4ilKdB5VQjC9s/LVNdgcLYHRHYiWTX7KKkHRO3
         sNs22rXSGLNZoCq8Bwx2W8Z2/gXU3RNAn2oxHINpe/ZxQ0RttNooknMuLVYIJWnt+wjE
         9WWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3wSRRO57jFB1AsDR3Z/ljCEGLBSneMwOrMM+TX5aT3Y=;
        b=YWsHpKHnt5xKwVDZ09OGtAuAbxgmRGnWM1zAJOMFYHF5rT6nl+7ut0eajGRGNV0gwI
         ytgINVNe3pkFOQ8gjNBdLPKcVZIedZhWkIWgiC9va+DtwIVV4NSRegeBYzJHgBtin3kD
         V2w8ABO/SszCBtg39tldBH30LqFWSo5yS/wb4gOGZptokVqs9JbCMvN6hJ22/Kfeeqag
         onfWU6wt6+nZs4HBKGQ61B6SYb7qdvgXp63meXE5mnlDV1A4nGE4HfD7awaHDpOgmwh4
         cYMINApOnBnv+0IjenzwjYAfu5ap/cRHwKZgxeiHD0bqVE/P9g+O1BBe+VLCsYiVyUcI
         Ebog==
X-Gm-Message-State: AOUpUlFlnyTVHtfqUB5adtKQPbMnZb0naGt789tucEZJ+1SqjK4upq+i
        nZ7Gxg0Y0SpaNV+29++XjnzWH5249zD2W5JM8g4+hlxE3GpeG/8E2Si0dbM82Z4MlaTpB2nY8Ub
        6R45M0/qejW+bqAIhpPqxahAkJ7AQfi8LRxcuTL/wtDtTSy3E+VZjzUuJ9Q==
X-Google-Smtp-Source: AAOMgpdS/OjO/zadFdDSkTbnFB+8vV+3ow20mWjJPrvd2/4+R37ZA1bThIQ6MSP+H3wOmbouVi7V3Sxj+y0=
X-Received: by 2002:a1f:b42:: with SMTP id 63-v6mr8498468vkl.24.1532954018928;
 Mon, 30 Jul 2018 05:33:38 -0700 (PDT)
Date:   Mon, 30 Jul 2018 14:33:33 +0200
Message-Id: <20180730123334.65186-1-hanwen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH 0/1] Highlight keywords in remote sideband output.
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Made tests compile and pass (oops). Remove Change-Id footer.

Han-Wen Nienhuys (1):
  Highlight keywords in remote sideband output.

 sideband.c                          | 78 +++++++++++++++++++++++++----
 t/t5409-colorize-remote-messages.sh | 34 +++++++++++++
 2 files changed, 103 insertions(+), 9 deletions(-)
 create mode 100644 t/t5409-colorize-remote-messages.sh

--
2.18.0.345.g5c9ce644c3-goog
