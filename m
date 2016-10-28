Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0BD7203BD
	for <e@80x24.org>; Fri, 28 Oct 2016 18:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034374AbcJ1S4e (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:56:34 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36026 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034327AbcJ1S4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:56:24 -0400
Received: by mail-pf0-f174.google.com with SMTP id e6so41422433pfk.3
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c02QePgXTUk9q0wUa8murcA8A5uix1Ndl7qBxJWd5Dk=;
        b=VsbybQEpDQjOopwv2rvSotYyEZm2KyCizSIEkkizyFcl5qeNy+8sVbHHBt+BpqM0gf
         Od1U5sw6YJlhNlEMUPBaX8MB9ZmROrmy5FbhDxijCEKcC0ln3zAuLLG5GA23txkhBLLK
         27N4a2eb0bwAZn6rgrbNQXZjQBGj+Zvg8WnSKNDPoEZqui25ctPi2SiQkyCzs8HYz0d1
         Ys/x6nbnW3ObTW4E33Ukt3tazkwBYzSnjdnrjdE7McHlAgLp4QxYWRKIGOD1FUnjrbep
         nVH4IW+y6lOfyepte2eWYYr/sLMMzK77n1Z4EkPdPGpcV3iLXOAHWYi8BgsnFo+bZlbe
         Hy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c02QePgXTUk9q0wUa8murcA8A5uix1Ndl7qBxJWd5Dk=;
        b=gPQSbVCUvEHLhYXrUdfvi37HORkCvEbipHGjK72vrLBzC39SnyB/RD8sG55hO7g4ng
         FcO3LBFo0oQ2ffK8hOZb0hJdy1OJXXAlYjj1egsw0pFRCqKNyEsSGAI5jaEP0SXYH9ul
         ZF8pxajgp4UJ8y4LyPF/cfkiaNetpcJCE3HLkF2J6hItxN6h/lrfC8f4vq0TVhiLGmQt
         FvlPJgtjVGTSzKDqWWMcHuh+9vt2pAyYwmhU5EPfTZB7JLCJgBceJYsaDT+WUN3q4RuQ
         wXoFc91/hWjhL337m62LPx/hm7aG9JwShclB0YWNjX5PnQiCJ5VN1SVS8gPquchuuuWr
         P4LQ==
X-Gm-Message-State: ABUngvdY7/sRfX+wQILOHFINXPl6T+5kZdTRLo2H67SMakjkYGeDa2FOLL+iT4QQG9sC81Py
X-Received: by 10.98.134.78 with SMTP id x75mr27392438pfd.6.1477680978775;
        Fri, 28 Oct 2016 11:56:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id xn11sm20586250pac.38.2016.10.28.11.56.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:56:18 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 29/36] Documentation: fix a typo
Date:   Fri, 28 Oct 2016 11:54:55 -0700
Message-Id: <20161028185502.8789-30-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.714.ge3da0db
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitattributes.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 8a061af0cc..5b317971c0 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -88,7 +88,7 @@ is either not set or empty, $HOME/.config/git/attributes is used instead.
 Attributes for all users on a system should be placed in the
 `$(prefix)/etc/gitattributes` file.
 
-Sometimes you would need to override an setting of an attribute
+Sometimes you would need to override a setting of an attribute
 for a path to `Unspecified` state.  This can be done by listing
 the name of the attribute prefixed with an exclamation point `!`.
 
-- 
2.10.1.714.ge3da0db

