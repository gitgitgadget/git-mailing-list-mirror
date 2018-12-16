Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B741E1F405
	for <e@80x24.org>; Sun, 16 Dec 2018 14:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbeLPO3Z (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 09:29:25 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33579 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730181AbeLPO3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 09:29:25 -0500
Received: by mail-lf1-f67.google.com with SMTP id i26so7588094lfc.0
        for <git@vger.kernel.org>; Sun, 16 Dec 2018 06:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fdDJBj1CZtWY5lGyjQGrYnUE5q36bo0XfoqNOL5iwxo=;
        b=eEsOPCymO1nmC+jxm1TH9Qa+TTQ8I5K9rqqx1krKnmukF9TgI5JwecJcLPCjpuV5yb
         aQUKLzSH9LFzF4YdTKAWcCL1FsVxYI50hJb2pRBtWeOVfWcuT+xov4mOeHQUixnCQWme
         mckw0aqsYyC0qminX8q6f6m78lgUr6Z2NK2vh1+CSseP9YT1vzeN19j6ZJK3TarT5n94
         VLaZvWbBnUqRf9+UYABqkp7Y3Lh+NZrm+GNcyHQnlhAcSznpTdVGkc3fet1IwJWe17i3
         V9c2Bjt/GV0YQMFOyd7s/kiiqLq3hS8YPy8Q99/tWOpKnqneAGFlSteYhk4wrASFmkRW
         v9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fdDJBj1CZtWY5lGyjQGrYnUE5q36bo0XfoqNOL5iwxo=;
        b=iZnDbAqX4uYGxjgn0ApkMZnU1+Isa6JzugzrkIQez/hZ1ZF93lASVaO9u7hFrxgXxG
         IW0YZ6LJaqeN53fYMIHPeUXMnnwN81PtHpr3cipRnhp8ZMXZ9oe1HLhnmH+51T9xRAfK
         gjEmEGZPs1q6qBKIv0XdGbs7k9ENr2WEAA9iXb+TMOIvJV7EiS2PY3m9r8XIcA7Ed8Tl
         8k508/15jdvNHIxGsF5liLo0b8SJmILxZFY2ptm380gALJfHuND8d87VfTwDZ1EPH6yU
         yIkXlHi73FEszgwulsFM65yxTxbrQo82pe0rRw018AlfKoxi7rZpaXdG84tR12t0MjhY
         bU4w==
X-Gm-Message-State: AA+aEWb47vzd1LgqJ8M5O3IHP4mvZ0oJ85sqASFZzI/5sj3gYYz/IjfX
        icGMio75eAx2N8nEbzSfIrx7w/u0
X-Google-Smtp-Source: AFSGD/Wln6ad45AejdDd7q8LnzxvnjdpjYbAhq+iiiH+qjo2KTok4U5ZF4kYMT+Y2Ybr+2TgjxRlgA==
X-Received: by 2002:a19:4ed9:: with SMTP id u86mr5190675lfk.78.1544970562962;
        Sun, 16 Dec 2018 06:29:22 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id k63sm2083296lfe.13.2018.12.16.06.29.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 06:29:22 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 1/3] git-column.txt: fix section header
Date:   Sun, 16 Dec 2018 15:28:57 +0100
Message-Id: <0177869f73d2c69b33862f60febc3988c22b1fa8.1544969984.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1544969984.git.martin.agren@gmail.com>
References: <20181216105944.GG13704@sigill.intra.peff.net> <cover.1544969984.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have too few dashes under "Examples", which causes Asciidoctor to not
pick it up as a section header. Instead, it thinks we are starting a
code listing block, which ends up containing the remainder of the
document. The result is quite ugly.

Make sure we have as many dashes as we have characters in "Examples".
Asciidoc renders identically before and after this patch, both man-page
and html.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-column.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-column.txt b/Documentation/git-column.txt
index 763afabb6d..f58e9c43e6 100644
--- a/Documentation/git-column.txt
+++ b/Documentation/git-column.txt
@@ -47,7 +47,7 @@ OPTIONS
 	The number of spaces between columns. One space by default.
 
 EXAMPLES
-------
+--------
 
 Format data by columns:
 ------------
-- 
2.20.1

