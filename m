Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F2021F405
	for <e@80x24.org>; Sun, 16 Dec 2018 14:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbeLPO3P (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 09:29:15 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36466 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730181AbeLPO3P (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 09:29:15 -0500
Received: by mail-lf1-f66.google.com with SMTP id a16so7583150lfg.3
        for <git@vger.kernel.org>; Sun, 16 Dec 2018 06:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HqvDu3YI6c4nFKfXLqRPQxMW7xhpb1siU7AlG/YpeBw=;
        b=mwhrOptFq0P+ErR8GIvFNLTEu6bDPLeMgV01tv9zgzwGv2PVQXAFaclk3j1MvRU87q
         9QG7yYRxvLQYXfXnIEEmTUmKdtZkhF9E5ekw6R9VaIMz7Fvkd0gSz5wAy71XRigPZcSl
         1ykcpoon5SUF4fzZ7v8AEvYuCOdokDZ6y+RVZp4L2hUoExUEl52eCPO1P3euDl99Lute
         MAeXYUIt6EBDqasHezsxftNdwg0KXKPuN1hMKe4e3gKqQA+1+NjzMesNwzAabwk4xvhx
         ITp34FMFB6hNN90ctf/UdTPPeBYS0Y5KXxNVttogRVR9I8xmO0CAGAf/IkeOmSKtpDta
         n4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HqvDu3YI6c4nFKfXLqRPQxMW7xhpb1siU7AlG/YpeBw=;
        b=N+dEw4Up9KvLYJCU9LnHh9S57ZbBbfENA7cfUWuFu2GJFeNcZY4YFEF4aJxWkPvywP
         qdIZHuueYb+v4ZxiTvNw2r6VCQJWq4HNpy/pLilNt9WUH6MR8ruUjWky2BPxQ3qE3S9b
         RTgxM9wrw4COEphsvipRIUwaj/lcmR1OLphVNXbUPBEL6AhNIu9dkER1PAXK8DYkoHM0
         HT1H1lEWdKVZVscs0TkZv+1KDK22Ajt1MKY1RrCbO1ROjVZZWYYVoCGpPvvIUid+sWoy
         OLb+j0kFgbVLloJB8gDEgA3NfNdV2bKAz9xcnAx9thYybhlPF+2V9VQF6F3ZKicY1MaE
         0A/A==
X-Gm-Message-State: AA+aEWazZbeoMBO3hKp8yoMB2Yr0WelixRuApGkwZOd2AbHnf8M1hbyH
        SpbThEpbf7/KtWTFGtWEJucmVEAd
X-Google-Smtp-Source: AFSGD/W/HL4VFBVGVFPOU0xX0M7+UJ1PeUiBFyqs1bygqycQTAIPDYX5mkUN00G7QZQBed6ki785Cw==
X-Received: by 2002:a19:8c1b:: with SMTP id o27mr5235347lfd.90.1544970552887;
        Sun, 16 Dec 2018 06:29:12 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id k63sm2083296lfe.13.2018.12.16.06.29.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 06:29:11 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 0/3] A few Asciidoctor-fixes
Date:   Sun, 16 Dec 2018 15:28:56 +0100
Message-Id: <cover.1544969984.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181216105944.GG13704@sigill.intra.peff.net>
References: <20181216105944.GG13704@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series addresses a few instances where our documentation renders
badly in Asciidoctor, compared to Asciidoc. The changes made are exactly
the same as in v1 [1], but the first commit message is corrected, and
the two patches 2/4 and 3/4 are now just a single patch 2/3.

Thanks Peff for your comments on v1.

[1] https://public-inbox.org/git/20181215112742.1475882-1-martin.agren@gmail.com/

Martin Ågren (3):
  git-column.txt: fix section header
  Documentation: do not nest open blocks
  git-status.txt: render tables correctly under Asciidoctor

 Documentation/git-column.txt       |   2 +-
 Documentation/git-init.txt         |   4 -
 Documentation/git-status.txt       | 162 +++++++++++++++--------------
 Documentation/rev-list-options.txt |   4 -
 4 files changed, 86 insertions(+), 86 deletions(-)

-- 
2.20.1

