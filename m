Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E81D20401
	for <e@80x24.org>; Wed, 14 Jun 2017 09:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751971AbdFNJnx (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 05:43:53 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34034 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751608AbdFNJnv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 05:43:51 -0400
Received: by mail-wr0-f194.google.com with SMTP id u101so38038564wrc.1
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 02:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pzTQ0zaIPPEqZDguWwQhcPjQqOEwjbpBeYrNsBy0N4w=;
        b=cHlTIuBThAp5ETKoix4lRzIJ2EKGATE3dHC65KMM7Og6V0leqw3DnlQZ+VB13ts1NO
         wOVR0rHFpFCNBFo1H05kyYBUNT+x33FFjpX61FqxMpf1lb4lLaAVYgijpODF77yJfF1c
         tODqP51f2ZEYcSR8EZaLGeMgFcsOWJrR5ALJg8lQqEDeHsLJmxcT+CcBprzCY0oyMpuu
         zAor2ZXGpsQiHFUteKpcb5jGYKS5q5NxAlSzjkRmppw7IrgqdmIgK2SRhMRbblPs0Clj
         QNgBqFv83hnIehmbIiPBcY7PfVthtjY4ikmxPru3NKStICA8G+ylgeTn5PFWwNhjWZqw
         iLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pzTQ0zaIPPEqZDguWwQhcPjQqOEwjbpBeYrNsBy0N4w=;
        b=FdCN0NsL4LV8gPDLc8u/L/vvyenF9tr8LMRkLu5Py4aN2fy8KE41yLky5hGpTD8yfo
         bKFAokaTeCxsDW87RsdvSdSUUqzG6YYo6zNhw9MPktJrMuiYSNKU5Edaksx+EyKAjZ1y
         boGGotN0TwkP6ul0OXo1uyNn5tQK6Uo6Mr+Xk9azqPoLdW3RtlkrnzMzpnJpQIniVTYS
         wDm9xd4W2hinsdYTRihXjaJu0w5CRJJSw5DyNn8KGl6Zn6wXhVANLTUCe8Em6HCO6l4L
         L7GDsP5xV+ATWij8eEP0OboTOFwEIvnnRHA9K7FwsZrh+h+/tSIyOxcMcrUyaYG+Zvy4
         1LAg==
X-Gm-Message-State: AKS2vOy1Aa2fiXj1RmmTUSTyJbb8vk9O6bX1vtYQctr+3kBs7KPm7wrC
        IiO3P+oRUtVk5Q==
X-Received: by 10.223.132.130 with SMTP id 2mr6565938wrg.157.1497433430357;
        Wed, 14 Jun 2017 02:43:50 -0700 (PDT)
Received: from localhost ([185.112.167.114])
        by smtp.gmail.com with ESMTPSA id l16sm461563wre.25.2017.06.14.02.43.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Jun 2017 02:43:49 -0700 (PDT)
From:   =?UTF-8?q?=C5=A0t=C4=9Bp=C3=A1n=20N=C4=9Bmec?= <stepnem@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH] doc: git-reset: fix a trivial typo
Date:   Wed, 14 Jun 2017 11:36:58 +0200
Message-Id: <1497433018-28837-1-git-send-email-stepnem@gmail.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Štěpán Němec <stepnem@gmail.com>
---
 Documentation/git-reset.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 8a21198..70f3753 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -115,7 +115,7 @@ $ git pull git://info.example.com/ nitfol  <4>
 in these files are in good order.  You do not want to see them
 when you run "git diff", because you plan to work on other files
 and changes with these files are distracting.
-<2> Somebody asks you to pull, and the changes sounds worthy of merging.
+<2> Somebody asks you to pull, and the changes sound worthy of merging.
 <3> However, you already dirtied the index (i.e. your index does
 not match the HEAD commit).  But you know the pull you are going
 to make does not affect frotz.c or filfre.c, so you revert the
-- 
2.1.4

