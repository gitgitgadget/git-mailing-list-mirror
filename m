Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95EC42035F
	for <e@80x24.org>; Fri, 28 Oct 2016 18:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966228AbcJ1Sze (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:55:34 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34319 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966192AbcJ1Sza (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:55:30 -0400
Received: by mail-pf0-f174.google.com with SMTP id n85so41587410pfi.1
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YHIKpluFAVLDAIzO6snl0k1pxh5UYLD9XDyH//flibM=;
        b=hfYo9uP6qwG332Eosh6xbo6A0tWbqlWcfrkjxK2jXrxKc2+gRUbyexHwipmO3qvbpp
         5Q/INUOdQ/bCi0BW1NQUrKYSpbzMpYBKZf6obWux5O8w/e4cGaPuLRDhSJyMb/e5Mi68
         ZhIRCj99NDTrEhv305WnIxtrf5nM/nZlrRExbI8qX2XkivpCiMhL/MJeN44KdnxzqBdK
         Ec32E/M4hLXoSGzwD4jEaaMALBxahMxe+PZ85mH/d3jaRFtSMSIHdERF3Eh9bGms1Mnp
         sP/L8KE/zTsXrLyuQD7sZl7SdmEx73ikZ5s9pvIBSMapt50E1W5MZY/TinvLPegq41lG
         HT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YHIKpluFAVLDAIzO6snl0k1pxh5UYLD9XDyH//flibM=;
        b=ITi9Md0v5aedPn+p39nvYfodLcW+YyfNI6hmnclvsHG0hVGXTIveKUg956QajHMjsY
         0b+pcuSHnt/yKKEbbbaJltppNZgDw+LTK9DSI2fiQX9jAkkWXf02wedSnBMJqhvKAlQB
         25Eda42SIvXvwg6/DqdgxaFQH7T/zT1TOZUqIcu8kuqZFhpEpEkXBap/4o4C7jaNsoU7
         5HX3gVHK5mwOm+0T0/Gig2M2mQE2o5EKfV28w2axyAYlaYA9CPp2iBk/MnhQOLGpFWrS
         zX6BETCxusdnrRaxkFDvbFH2LRlDu955PO8KlPgF+JarVgJG+riLld6z74cJIaT/+g7X
         hGdg==
X-Gm-Message-State: ABUngvdcQQ9DC51p7QOTGOr+sij/aMlvIAJ1gO8iJSCdnkzffAnPleW++Ib9BduFAfezm8CR
X-Received: by 10.98.69.79 with SMTP id s76mr27362126pfa.178.1477680929709;
        Fri, 28 Oct 2016 11:55:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id f62sm10658539pfg.18.2016.10.28.11.55.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:55:29 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 06/36] attr.c: mark where #if DEBUG ends more clearly
Date:   Fri, 28 Oct 2016 11:54:32 -0700
Message-Id: <20161028185502.8789-7-sbeller@google.com>
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
index 9bdf87a6fe..17297fffee 100644
--- a/attr.c
+++ b/attr.c
@@ -469,7 +469,7 @@ static void debug_set(const char *what, const char *match, struct git_attr *attr
 #define debug_push(a) do { ; } while (0)
 #define debug_pop(a) do { ; } while (0)
 #define debug_set(a,b,c,d) do { ; } while (0)
-#endif
+#endif /* DEBUG_ATTR */
 
 static void drop_attr_stack(void)
 {
-- 
2.10.1.714.ge3da0db

