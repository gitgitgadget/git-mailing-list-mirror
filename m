Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BD2B20229
	for <e@80x24.org>; Thu, 10 Nov 2016 20:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965699AbcKJUfS (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:35:18 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33145 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965625AbcKJUfN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:35:13 -0500
Received: by mail-pf0-f171.google.com with SMTP id d2so152093636pfd.0
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MD2J5eANjXlAmeNac10mK8Qheu4sMtejkM1LvxfuVyI=;
        b=C2EeosFiUPAIfDf8yr4XEvUfGwxveICAaipxdWaInXemby7QA1j8lrR4P0dPH4yUPK
         rYS0OIkvzhz7rKm5Fb+a+sYTcdIVu+HCVU9xihN2qHZGj1dARZyoXe3afUKiok5C1rhg
         l7DTDrgJTENCZPUzuO3knbrGU7xaviSNS/smHBy5AKHxShlIdc33X1m4N6U4UlucMIQ3
         UttilXKfVY+5tRTDDH0VXOCxO5EDLMjCJMAsIcnQg3/Jo22Yv2Ohgx/PPYmqgZOf/p0w
         a02j9JjQPsntf+Xf6fw93YKWGfVp9gcy1kkF9Gh7kYKdewiwM1UCJ+cTkFJRyV0kfLu+
         rvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MD2J5eANjXlAmeNac10mK8Qheu4sMtejkM1LvxfuVyI=;
        b=DEUMT32eu7XwQhtkR1o8cq31Vgzy/AVyV7bR2VtWYmijRjcgS/xahy7O7CNCQp0gkY
         0yr/vw20/dzSeVo0yuchbln99QnUKcC3Z/9hYWeDVIYG5uZdf6baboJGjn4PjTWhRMfo
         VjZkdc325sX44fcRmolUcEEBHpHh2wAWxmbJUT9U+e0F85jDIeHcPGuksU7eB8TxNceB
         5/ZL9WTLH1QBxOmPJmqQkG+RAAwGBr6Q9L56ElG/F9sKufrT6l/fzXyfuAZqxsZep1Qn
         yZCfCulYvvYghCWDmmrB0RSeI1vx42Ss+XGH0UqpzvmxGoLS9a4aZEv8lGCbYx/+nj2k
         ZnYA==
X-Gm-Message-State: ABUngvf8CMGPtjSpfWnUeQJTVvAfb8UxqGAnG6XDySBcl4/rSzws9p4SCZgWoctl35kqTeJo
X-Received: by 10.99.170.79 with SMTP id x15mr38511692pgo.105.1478810112998;
        Thu, 10 Nov 2016 12:35:12 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id c15sm9320794pfd.36.2016.11.10.12.35.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:35:12 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 28/35] Documentation: fix a typo
Date:   Thu, 10 Nov 2016 12:34:21 -0800
Message-Id: <20161110203428.30512-29-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161110203428.30512-1-sbeller@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
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
index 8a061af..5b31797 100644
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
2.10.1.469.g00a8914

