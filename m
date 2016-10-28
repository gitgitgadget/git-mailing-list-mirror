Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76A482035F
	for <e@80x24.org>; Fri, 28 Oct 2016 18:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966220AbcJ1Szc (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:55:32 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34312 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966188AbcJ1Sz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:55:28 -0400
Received: by mail-pf0-f178.google.com with SMTP id n85so41587059pfi.1
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jzc9fBH6KGHVda8bRVdZvUcrNI8iM/UkdUfSiIGkbIE=;
        b=cb2Faag/FhJTPoxCY1csLiEtz2G0vO/g2LBubFPFRD0MStzlYp10KatbDX6IIWWmMT
         x5ujE0BMfnk73DgCiFmN9TC01g/xmhTVtgsg4cDtp+6xPOoe2chgZGyHeaaOk6rD0MZh
         5e7g4KJ7dTFz1bpbnPNu3FgTAYPA0FNdxNZoB0xG8Q1KUjp8HOh8bqlHjfacjLg7fean
         WqNOrkey25XighoNMLx9WGbiUwPfqOLiAUccVu6IZHe99lX88xpK2vNZ1d3SLiHz+CRM
         G1EUY0QZ9h7ykn9Ci9t0ZYfw8sv0cU4lIKpuaOOV2guaddcSuOkhrttiFQ86QRYFHla7
         XgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jzc9fBH6KGHVda8bRVdZvUcrNI8iM/UkdUfSiIGkbIE=;
        b=NU1E7k/ncWInWFp8z240WmLFmzqlFP7fk3/GaajEZaKuAKpcjeKJgHnRc9xVzXV8vs
         yggdWQUMKm9JM3lKGLThz+IcDTkIYVHcHsbq8njF8HVChkVRzJmTGO8v67SRiVMBcUc5
         UJkiUZHKIkCDVJxE28WmS8BBoVz8f3DUcMgBmoV709XZ5VmqpCjEOIUIlf8oq0arTZtM
         kXB+QMz0q6hlqaFl2Ix1jF9zlhmkkaTQdLkLwVft/ehdjncRAvTMyeme3pzm0bol/n5e
         ovFihAnwxH9R+YXRZ3Y2Tx0Zt6o9nqnnfXXxWdClZh4aXx2dZRUOBImWmJNwYCDqvgen
         EnZg==
X-Gm-Message-State: ABUngvfUqX6DswM5F3SI6Qr0VMWR7a/P9b7OuTknQs41pfmNjNT1FAsTeIkCBpcLgwxlJC5F
X-Received: by 10.98.80.130 with SMTP id g2mr27118876pfj.179.1477680927895;
        Fri, 28 Oct 2016 11:55:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id u1sm20533485pfb.96.2016.10.28.11.55.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:55:27 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 05/36] attr.c: complete a sentence in a comment
Date:   Fri, 28 Oct 2016 11:54:31 -0700
Message-Id: <20161028185502.8789-6-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.714.ge3da0db
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index 6b55a57ef7..9bdf87a6fe 100644
--- a/attr.c
+++ b/attr.c
@@ -300,7 +300,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
  * directory (again, reading the file from top to bottom) down to the
  * current directory, and then scan the list backwards to find the first match.
  * This is exactly the same as what is_excluded() does in dir.c to deal with
- * .gitignore
+ * .gitignore file and info/excludes file as a fallback.
  */
 
 static struct attr_stack {
-- 
2.10.1.714.ge3da0db

