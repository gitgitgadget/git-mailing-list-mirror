Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 337F91F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 20:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933078AbeGIUox (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 16:44:53 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:40651 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932827AbeGIUov (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 16:44:51 -0400
Received: by mail-ua0-f202.google.com with SMTP id r6-v6so5551374uan.7
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 13:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=te7LUYvw7+50KM5TZIIUOf7XXYX45LgePEdxLm9D0kg=;
        b=d033Udkttgqc4GekeayHOBr4hcwXg6SCTEUhJQucERt5SGG9+QvUfa00Mb381p+C+m
         a4hailBIFR4DWEEnFwNdeQIbgkF3TsXwQfV6KDnij5kB2lW29vlj1pgMJy0QjtyxiZHY
         +0YS7Yj8VzRlRrcqB74df2nl4KIlEGDvR+7KDJWzHy8j1gwzpSWEJvdMXTn6K2je6GuD
         NuFgg5u8Kvya5DhQ3wDks+xmhBE9bdDsqq4zvabmjz31U/qvgPRErFCnvThQsjhZ1hxx
         3ZgQgTKwA4bqrpqfNbi6JL9dUOf4wDi5RnEL7F6L/bbmj8g55Ze5HSQaD+jpHoIF0MxT
         WfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=te7LUYvw7+50KM5TZIIUOf7XXYX45LgePEdxLm9D0kg=;
        b=U/vMGZal7V4dFYrB273+3yVl9wHubY6yYMmGApJaLFfRZpmWKKjg/SSOG6vFbuJWsg
         fX8l8GoiEk//rPVZMx8oR2Yyh33Z1r0BrX4SJBhiX0JCksdGNgdIo/6yFH7GB70cR371
         24D+g4dCnJfAgWrO19VK1bMraZKqUJJSYs2ZgFeZHQkFqABgBQFD2e03Uf+7TUqCVT6t
         4b59+AqN6Em+QT4B0qW4SH6E9XENJyp107O5vlAfpYI9eS1CHRKeuwKbClH7svteFlf8
         VPUmrQBfrMAQZp1ALpsJp+RHD8F7iZAw1F2kmZ6KVEXb/RnRAUfr4TnE44B257PUxC/W
         uXDg==
X-Gm-Message-State: APt69E316GK1FRIia8Betn4j3dX8C3KdPR4hvSjnldAWO7t5FFctbdmI
        l/yIkQgOh9aKva522Q53cBdcFiU19azaMFWu+KPRfYhtaqCAY109C+yVKx0Ta3lqFaxgPybTjjG
        oxM2ByKFpAV1t0FlIxEM4Cd31dpfIbNeGa/jJM7SQfpOFWj8dJgZkNhNhgtySfgnnsBPMRQf8nT
        bG
X-Google-Smtp-Source: AAOMgpeX/EpcJV+ayzwRQiYquhthmjWw1AolbqqJQISYkxFnY8ngxh6lHKwKZG56+VQSDCPFZXuhpngBEwmi4Sxm8w9R
MIME-Version: 1.0
X-Received: by 2002:ab0:6446:: with SMTP id j6-v6mr10479603uap.68.1531169090283;
 Mon, 09 Jul 2018 13:44:50 -0700 (PDT)
Date:   Mon,  9 Jul 2018 13:44:36 -0700
In-Reply-To: <cover.1531168854.git.jonathantanmy@google.com>
Message-Id: <b0077ef5d43184bc1d2df24ba6e4415e8e0878ea.1531168854.git.jonathantanmy@google.com>
References: <cover.1529616356.git.jonathantanmy@google.com> <cover.1531168854.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH v2 2/6] object-store: add missing include
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 object-store.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/object-store.h b/object-store.h
index d683112fd7..f0b77146e4 100644
--- a/object-store.h
+++ b/object-store.h
@@ -2,6 +2,9 @@
 #define OBJECT_STORE_H
 
 #include "oidmap.h"
+#include "list.h"
+#include "sha1-array.h"
+#include "strbuf.h"
 
 struct alternate_object_database {
 	struct alternate_object_database *next;
-- 
2.18.0.203.gfac676dfb9-goog

