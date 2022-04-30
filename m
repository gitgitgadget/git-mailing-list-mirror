Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B947EC433EF
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 04:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382189AbiD3EST (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 00:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240830AbiD3ER5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 00:17:57 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5425DA4B
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:35 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bv19so18724357ejb.6
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lgxYINpx37WCvVSr4DRTBNpzWc4D8M8+z0jHnpK3IWQ=;
        b=RDEJPDYoZytUxLqpprA+JXoycOPC99vt13jjCpYU3nk2JMbuQl2YB06Cu23ziUOaNp
         7rL47qZ7/N0TVTE42Vj3hKSj0njOze7mmbSW3b3nAlmjy7yxLCKbAILHTQKgaqxnWCWs
         CHSwsnhWUhkFi+tJOPIfO9375JMfbY0IIJspMeuJOzv0G2FPux8S6nJGs4yn5e3yBNxw
         2GvGYya530nxr9xLqZi4NU9MV54GXMYtLVG4LirELNdq4kjFamxA7cFhaIiNHWooIFD2
         slisilOc1/PmZDfjI2UW8Q0pqHmAZCa2r7XYzXWBQ+k07cb7YTgK2+9MQMFOkJ1c2y3Y
         Z19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lgxYINpx37WCvVSr4DRTBNpzWc4D8M8+z0jHnpK3IWQ=;
        b=hVC2st8p9cuiijFafnbMuexJehX8fu+zSXbVRjNL5ujRZhe2k6/x2pYvaXFzZ0ZNSV
         +DzyjqdvqMz0lsOetapJycKPOC5Cam1QRRwLgwolG6s1gR97eJypTvj74H72NfyNAN1T
         8woxD4IbEE4psnIMgP/WWwI5Ly8QvBkkD7SeXr4qNavZwLIdWyOQ8LPyLSP/wnp6nTgu
         k5z8GIYcTw/OIxtTnMG4Ngs9inhcZGRwq0pBBI3AldB6k+GgY4l0g7pN/Iw1y2dFXyoz
         KP3xKU0AGuaogpGZpmfvJ/oGVUetJ9LI/j/esNhO/sI8Xx4PciRlNR0r8/694xISjv7U
         zhtg==
X-Gm-Message-State: AOAM532eIgCaualYsTbA29hi4qNIbWSlVpUHS9lSIPcWNCcDDMmi91S2
        /RVJrBi2is6qMh3xquaiO5QiJpZh2T4=
X-Google-Smtp-Source: ABdhPJwPjEmMnio3tZyBiStDF1g3eJUxdGlDokQ5bshbMYajFCYxRZAttmKpXiOA89CWMNka+VutBg==
X-Received: by 2002:a17:907:9488:b0:6f3:e746:6fa9 with SMTP id dm8-20020a170907948800b006f3e7466fa9mr2299212ejc.12.1651292073658;
        Fri, 29 Apr 2022 21:14:33 -0700 (PDT)
Received: from fedora35.example.com ([151.27.248.133])
        by smtp.gmail.com with ESMTPSA id og47-20020a1709071def00b006f3ef214e79sm1243586ejc.223.2022.04.29.21.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 21:14:33 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 12/23] builtin/index-pack.c: Fix coding style
Date:   Sat, 30 Apr 2022 04:13:55 +0000
Message-Id: <20220430041406.164719-13-gitter.spiros@gmail.com>
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
 builtin/index-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 680b66b063..3e385b4800 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1942,11 +1942,11 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	free(objects);
 	strbuf_release(&index_name_buf);
 	strbuf_release(&rev_index_name_buf);
-	if (pack_name == NULL)
+	if (!pack_name)
 		free((void *) curr_pack);
-	if (index_name == NULL)
+	if (!index_name)
 		free((void *) curr_index);
-	if (rev_index_name == NULL)
+	if (!rev_index_name)
 		free((void *) curr_rev_index);
 
 	/*
-- 
2.35.1

