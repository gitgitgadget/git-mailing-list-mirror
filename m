Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ADBC433FE
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 04:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382219AbiD3ESu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 00:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382181AbiD3ESK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 00:18:10 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04C462A0F
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:40 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g20so11051779edw.6
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xlyKKTyaRb2sp2l82Gj4l7mCchkDYqxr2hGfoFBJ4ZM=;
        b=FCQ4HyYxpBlLFh7f/0ZDEgtxWU7uvpJ2rT5rv3MvhBEDsuC8TTnN+fELojUDFjeKmq
         ehaet/vdqaou3TmIar5Am41EWwCS2aww6reJkW9FVJTNTCpjhp4AKMM2rdKWlpnNKZod
         fy9ZPsJz12YhLOPwy9gXO2ivyRa66TVvs1Qk8Bn26JQadKV1dyjY2e++mQfg7JR+Guyz
         UdGIy+IsqxfxVhtKiWNYjlSUif0MkRgLHEldDQ+Ckl/4XmcjQeKzusJYDuzaPe4tduzF
         5b01H37htC8CVyd3mYC8LcBkqQjUvLLFvYTfrRwTEb1HZFiVqT7aTfnEAGVit0OS+tzI
         QmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xlyKKTyaRb2sp2l82Gj4l7mCchkDYqxr2hGfoFBJ4ZM=;
        b=j4T/Pk/G/jsf4Y0NKfM0uKREmhJ8RZRqj42Io3vPyuVejkAdx3ys02G3DG2mAFSq7Q
         r/8xNXkaeqS1Nnza7vnqcUF1OAm+HNVNYTJh0k2fQfspUFg/zfTrdekx0q0eEHB9Ku2y
         LJgB8XR8NGrDNGb8S40617YgHAbqBty1v7saaR6cdjO2oRjWiDe+TxTc3dMwQ7shJr66
         GhDbmWXHIFPbBpxIAaIKUhQv0xIhF3AoVIs9Z3FsUJ+EMt7BUf9GMwtdiU95VFY3A6V4
         FJh1WEwzQ0m03lphtveHmBy/6moo0sw8YMRv19IS65Kn2Sf84nb0so+gkLyb0C5OKabi
         BZnA==
X-Gm-Message-State: AOAM530QRQcYKSgbL0ESYijUgvAtxXmkGPSeUQHpLOgfPD1HhwzvIVZl
        UV7bVv1IaLK/a+SkNTUxKt68IvhsnMs=
X-Google-Smtp-Source: ABdhPJy6M+sMGk5xXrAGCibDOGvGKKftQqO6yZ5pPCYavFlOhYQagJ8Tu8I4Xz88UQ4jwrACdTNV+Q==
X-Received: by 2002:a05:6402:42cb:b0:425:d34f:e8ca with SMTP id i11-20020a05640242cb00b00425d34fe8camr2646751edc.126.1651292079121;
        Fri, 29 Apr 2022 21:14:39 -0700 (PDT)
Received: from fedora35.example.com ([151.27.248.133])
        by smtp.gmail.com with ESMTPSA id og47-20020a1709071def00b006f3ef214e79sm1243586ejc.223.2022.04.29.21.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 21:14:38 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 17/23] builtin/receive-pack.c: Fix coding style
Date:   Sat, 30 Apr 2022 04:14:00 +0000
Message-Id: <20220430041406.164719-18-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220430041406.164719-1-gitter.spiros@gmail.com>
References: <20220430041406.164719-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adhere to the git coding style which requires "Do not explicitly compute an
integral value with constant 0 or '\ 0', or a pointer value with constant NULL."

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/receive-pack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9aabffa1af..ad20b41e3c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1664,7 +1664,7 @@ static void check_aliased_update_internal(struct command *cmd,
 	}
 	dst_name = strip_namespace(dst_name);
 
-	if ((item = string_list_lookup(list, dst_name)) == NULL)
+	if (!(item = string_list_lookup(list, dst_name)))
 		return;
 
 	cmd->skip_update = 1;
@@ -2538,7 +2538,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_DIE_ON_ERR_PACKET);
 
-	if ((commands = read_head_info(&reader, &shallow)) != NULL) {
+	if ((commands = read_head_info(&reader, &shallow))) {
 		const char *unpack_status = NULL;
 		struct string_list push_options = STRING_LIST_INIT_DUP;
 
-- 
2.35.1

