Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31D151F404
	for <e@80x24.org>; Sat, 17 Mar 2018 03:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753063AbeCQDbz (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 23:31:55 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46323 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753029AbeCQDby (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 23:31:54 -0400
Received: by mail-pf0-f195.google.com with SMTP id z10so4906485pfh.13
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 20:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gZD3pasq5zxEKM2YFnsp6YMWFaSQsfB88rF7qzPm8+0=;
        b=fjm7m291R1o0Xwiz/XVJIdtEfpmkb4PtXtU31oPryPft4pGNRP8TRw5SwAaCe8Yz+f
         Sqr4csC0Nh9an9zaEUu7x7kSQtZs17EiwWWoxjYXP4w52WV2+VosIaJedqu6rUvvw9lm
         QjpG4bztsf2uzsG8kqVmO3uvXnvcB83DKL9Ivmki04rmzI/m/G/kU1a/emvpm4YVbGtB
         OBpKT5PhJrN8Fvc5eugSGyJMUv4CVyF9XDJfdTAUORVSmWXWkUXYzmiNNSwMRwBIZKs1
         uP/DNGvupnsyrQqEuAashb4385MvWxqERI9oeZ0cgboddLreY51LRaruf5Eqoc2h+qZE
         CXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gZD3pasq5zxEKM2YFnsp6YMWFaSQsfB88rF7qzPm8+0=;
        b=Bdr5Z8w5qjHHvq+oMiHr6k+hkyCUvV7NA6dr3Bpun5pg9SWjHrkeGuRzaQgU0/FsyY
         5tVgX3gzwkrJag53igN0sRINUf1lTVG8Wwg3KvpGV2ld/vz83ePZuXFL+2HhgYzqtk6Q
         cy4tfv2EwNHtZuMi8Q4nymg+UCOsN7PHvAtM5JUaIqdA1KEv0J1RMtrKdU3hO56z2C0R
         XaloXS7je8yKbrR17z/VfQ3dk6Wt1NASs7Uny5MHZ1MsOGM4TJITbqngl1h/Zv2w/xma
         YEu31qKH06cxfPJd4VQ9B59Upiu4vUnQIFzrS5u4rxFyhyxmyTFOoEO2fxmrlIMfPkiB
         288Q==
X-Gm-Message-State: AElRT7HReJVxFqH5Ci5L/3PvBryKQrFjzM93WPbKh7tBlNBoY25re/lC
        2Kf/GsuDoVnoH+K9i1VetA8658cE
X-Google-Smtp-Source: AG47ELtRg5Nisp7wfTP4g/jN12rQ8VhOpn1G49P4fltl0xAxmMRSMlHovcY3dQlvYripSJWFXQWfdw==
X-Received: by 10.99.128.67 with SMTP id j64mr3257110pgd.55.1521257513763;
        Fri, 16 Mar 2018 20:31:53 -0700 (PDT)
Received: from localhost.localdomain (ag026191.dynamic.ppp.asahi-net.or.jp. [157.107.26.191])
        by smtp.gmail.com with ESMTPSA id a80sm15696594pfa.60.2018.03.16.20.31.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Mar 2018 20:31:53 -0700 (PDT)
From:   David Pursehouse <david.pursehouse@gmail.com>
To:     git@vger.kernel.org
Cc:     David Pursehouse <dpursehouse@collab.net>
Subject: [PATCH 1/1] Fix typo in merge-strategies documentation
Date:   Sat, 17 Mar 2018 12:31:42 +0900
Message-Id: <20180317033142.20119-2-david.pursehouse@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180317033142.20119-1-david.pursehouse@gmail.com>
References: <20180317033142.20119-1-david.pursehouse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: David Pursehouse <dpursehouse@collab.net>

Signed-off-by: David Pursehouse <dpursehouse@collab.net>
---
 Documentation/merge-strategies.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index fd5d748d1..4a58aad4b 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -40,7 +40,7 @@ the other tree did, declaring 'our' history contains all that happened in it.
 
 theirs;;
 	This is the opposite of 'ours'; note that, unlike 'ours', there is
-	no 'theirs' merge stragegy to confuse this merge option with.
+	no 'theirs' merge strategy to confuse this merge option with.
 
 patience;;
 	With this option, 'merge-recursive' spends a little extra time
-- 
2.16.2

