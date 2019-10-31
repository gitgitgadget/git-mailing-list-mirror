Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CC941F454
	for <e@80x24.org>; Thu, 31 Oct 2019 21:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbfJaVD4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 17:03:56 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:55776 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbfJaVD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 17:03:56 -0400
Received: by mail-pf1-f201.google.com with SMTP id u21so5526816pfm.22
        for <git@vger.kernel.org>; Thu, 31 Oct 2019 14:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=oVOa94P/1mNeKWm/wc/HtHZrQd+swHxgaWNpAgmlxFA=;
        b=q2s+YqO4bon1z2FpClXTJGwb3Cb11Djg0jjmVkM+5p0lJDPzxa2P6HNl0sxsKHsotW
         eZDcCLfkzqjUDanqd/3RO7sMfG2wiYQ2CUpUv6IVVmmyLSVjRZsbGD2Ajf5z4nEQodLr
         z1aqnnpvdgaOnsA9f7LbXF0MwHVgy4cuSo+kO0uF6W+ir82ihpfcMb6yKHBCwPT1DPcN
         mEVUO9llxVJpKihcYiDLZn/x/Okw7jgCBJDn/ktUJZ7f/GTuDm+jQXIUsatscXMn4WKz
         1Iy1z6lLo63pOoubaqEYgHt9hneboJRN3q2WAJ0IgpAN+C1/tJXkuHHNGjByhW4etpGr
         yXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=oVOa94P/1mNeKWm/wc/HtHZrQd+swHxgaWNpAgmlxFA=;
        b=Q2jnNpGNI+5vNdL2Fu5nL52nU3jVK0Ag3yKhLtZ35XHjkWe2q4IKOBUCQOqPJDo7gH
         BfstdbfaGgFD7PKB63jlk+TXbioDrXY8gWaSMgT2Aflog9XLGWh4Q1sI55VjMnrg8uKq
         WZml+blNVZZHXOmiw8509MQkT70pg76HaXdnk+9Nkc8Zc0VYmgCRYmSM5/DPPalAiQN4
         uICPSANjqdBLyimv+QbE0OjDmMGLzxbthLoH5VI+wfOmouxKX28GmkVrZzhmwFYIqf54
         y+zm/yW004HNWIdte0G1W5d2U4Gj9NnXfpOO71ZCF0XBtEdyhSZnChKB8O9EatTc+Ah9
         Ssyg==
X-Gm-Message-State: APjAAAV7R1VycDMf3SEG/rbJddvHtLm46AgsDWqM7dgfBz4CS2OB8oh2
        rSbUbqPGUuYr3s7KHGRza4EOH6JcsaQXbqcMH3BHAYcSv0yRh1NJM0tcBk0iwDKyISRcjvTWNER
        0fTGedvsQijBjKRItZbmzAcYCmwAChQXGEjpAB7QROJMyD6o3AguukM+QvpUGRJKZwxy5LSCnRA
        ==
X-Google-Smtp-Source: APXvYqz6CsFjsWYsnrX758yOucplVoRnzLHA/ijZ97hfoadLFwTWWehygogYGxKe2BhurvSPrQWuKzWP6p2DeHABg7Q=
X-Received: by 2002:a65:57ce:: with SMTP id q14mr9148909pgr.218.1572555835202;
 Thu, 31 Oct 2019 14:03:55 -0700 (PDT)
Date:   Thu, 31 Oct 2019 14:03:35 -0700
In-Reply-To: <20191026005159.98405-1-emilyshaffer@google.com>
Message-Id: <20191031210338.152529-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v2 0/3] some clarifications to MyFirstContribution
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?SZEDER=20G=C3=A1bor?=" <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With adjustments to install step based on email comments, plus
Reported-by in command-list and install step patches.

 - Emily

Emily Shaffer (3):
  myfirstcontrib: add 'psuh' to command-list.txt
  myfirstcontrib: add dependency installation step
  myfirstcontrib: hint to find gitgitgadget allower

 Documentation/MyFirstContribution.txt | 53 +++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 3 deletions(-)

-- 
2.24.0.rc0.303.g954a862665-goog

