Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A8F2215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 21:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755126AbeD3VEv (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 17:04:51 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38200 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752023AbeD3VEt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 17:04:49 -0400
Received: by mail-wm0-f67.google.com with SMTP id i3so16312195wmf.3
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 14:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ljqcMmcxCWKiXVIFCsjcRk38c7jpvG04kKUv3PM2vxo=;
        b=GUc82ClMkycs5xYU63NfD5MNtlqDnlHOe5uBSMe2mPYEkqzO8vc82GG3iA4qPhCY/h
         17RrdBcNYlIUuOR9v/olZvZhkwYxLtM6LjfnPFXlMMVFbYSdnBJ8qlNUm9bFRJDglVVP
         VnNxPZmv8hC2LnzeF6YDrzzirFIPG0NBM81uUhLyC/xwt1O6g+TbeNbom5gMfGwxqyqy
         6DAKYPt7gkbASW9TpQaTuRFYBAAq1d+6TjjwtOQD1hFstQHzQBS5nD7gGBKj4TpOTE+2
         iZdPEh8/TCVvbdYZ6uQDSWClR3doDuvBhzWEUJvOQ2mKtKjLiSCqMzjuxvWWLGUlDPog
         cevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ljqcMmcxCWKiXVIFCsjcRk38c7jpvG04kKUv3PM2vxo=;
        b=iaW1T8pmQ8MxofhdEwpd1E3QZEkUuXQrvpAP84F5WmKe2/QK9xpUJ1p+oyPwv/EYDV
         wAc3nH9h6g1lHeyD6fDao22jC1zov1mKJfnFrSFoErhq+gd9Wf5dI4Oq8L2rH1auyoj3
         B9BBeF7nH/T/4aoVvArhjHO91Qz6F9VARYwSCneWu9/IIDHa4PfRkATOgoGhcHLwg5ko
         t9YqHsueX0eNsR7LPYCu6AqQszE1kx76k3z1rBwiBTLS6NFPCZ9PFzh/Q0fErYSCTEU1
         mwo5rhUX7W77UxMErwBPicmUlAiJ/2GMu8aehi5pmAb3ASO5GSBL5N4iScGOaWpZlrpZ
         5xkw==
X-Gm-Message-State: ALQs6tDgMTmONZ7FiVFoJFL1VyyGMoCc12UDbG/3XjC7tVZccRTv0PR5
        /5NEre10xqJiee12ykJbXUTGisMY
X-Google-Smtp-Source: AB8JxZrN0NRhWnZRTtPeQy7KVz2O1Riyy577V1dTBkn2Gk2rqHhWtEoQto4VtlEVXIXvU5Pk3Eqr7g==
X-Received: by 10.28.113.81 with SMTP id m78mr8481036wmc.150.1525122288285;
        Mon, 30 Apr 2018 14:04:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id h124sm18321465wma.35.2018.04.30.14.04.46
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Apr 2018 14:04:47 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] revisions.txt: expand tabs to spaces in diagram
Date:   Mon, 30 Apr 2018 23:04:30 +0200
Message-Id: <20180430210430.14611-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The diagram renders fine in AsciiDoc before and after this patch.
Asciidoctor, on the other hand, ignores the tabs entirely, which results
in different indentation for different lines. The graph illustration
earlier in the document already uses spaces instead of a tab.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
Can be seen at the end of https://git-scm.com/docs/gitrevisions

 Documentation/revisions.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index dfcc49c72c..011746b74f 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -355,15 +355,15 @@ spelt out:
    B..C   = ^B C                C
    B...C  = B ^F C              G H D E B C
    B^-    = B^..B
-	  = ^B^1 B              E I J F B
+          = ^B^1 B              E I J F B
    C^@    = C^1
-	  = F                   I J F
+          = F                   I J F
    B^@    = B^1 B^2 B^3
-	  = D E F               D G H E F I J
+          = D E F               D G H E F I J
    C^!    = C ^C^@
-	  = C ^C^1
-	  = C ^F                C
+          = C ^C^1
+          = C ^F                C
    B^!    = B ^B^@
-	  = B ^B^1 ^B^2 ^B^3
-	  = B ^D ^E ^F          B
+          = B ^B^1 ^B^2 ^B^3
+          = B ^D ^E ^F          B
    F^! D  = F ^I ^J D           G H D F
-- 
2.17.0

