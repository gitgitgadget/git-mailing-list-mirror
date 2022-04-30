Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578E3C433F5
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 04:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382214AbiD3ESU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 00:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382171AbiD3ER5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 00:17:57 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739C72E6AC
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:36 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id i27so18704790ejd.9
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4J743f5mV8DgBE4QswkoCcKmeChbj5GsHeZaSLF1rVA=;
        b=RzahgrtkP66YmXzcMcg9BmcA4z1E7YFzpLy1m/tXiUMWwXJotybY3Rehxane39O0vv
         G6ygroEZLaXy9++fMMhbVOo2Iw2z++k4TawHnYSOM2Sx6N4v9dELBh8xfrB3yQxhQhzr
         P6Flz2MIfrl5pBxyF8crHeizB2vSHLvhs/hQ2UxhbE4FGYAwSC6uC5SYl6LpxRVQHzBx
         eMcArnza3Iop788vuai3ZEswoaL9Ayn8Flw5sjPn/gC9JKind7G3KcXspo0pnuFgIbnD
         8Uu1sY2pNdfU+vo4f3RVZQqk1JY8MhtQ707uT1Pyg96BmofxKO2v1EzQKU0Z/9d+vEor
         vL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4J743f5mV8DgBE4QswkoCcKmeChbj5GsHeZaSLF1rVA=;
        b=11TG0Cih8QjdVZj03/MCHOiXROQERPb8NqADrGN0hh5AYyyi5ICaZuleprMDD+DRcK
         j4l4FoS0pJSCMunhg4CupdP08gXOwVqDP9rNhrJ8HQ1GU5/1Tg0kW7YTGkLZmBlvtz9x
         4jgB8r0BSQvXsqnCIfrk7elPIzFBbM01XQasNrp/LC3FBFbCVMHnp6+qNStYXaQ1Q4kY
         ShcGiAkd3d3e58WDMvBMShfuBLVIrapFpyxOJBAjXR49wh+1npUhDju+fM9lkXlN076S
         AFDnqdffCcfm/IPU4u8vx9YlQhDn3m3vJ3PwON+tg5IdVnrJr6VgiSRgP1lKSfXvmQwV
         kq3g==
X-Gm-Message-State: AOAM532MYPCQsvgdOvtHkbmAMJ40cRUg4Jr6ybecV4Highfee1cP4PIo
        uKIfPSPZWx8GRQ6zB9dwK+5FDF9jl6o=
X-Google-Smtp-Source: ABdhPJxdKOvqaSScWal6Zu/o3GKVPhp4rg6v2XDbeHeKFAYGDb28nKbRPJn/2rAVE2NVqGrvLsKBWw==
X-Received: by 2002:a17:906:f85:b0:6d6:e97b:d276 with SMTP id q5-20020a1709060f8500b006d6e97bd276mr2232997ejj.431.1651292074784;
        Fri, 29 Apr 2022 21:14:34 -0700 (PDT)
Received: from fedora35.example.com ([151.27.248.133])
        by smtp.gmail.com with ESMTPSA id og47-20020a1709071def00b006f3ef214e79sm1243586ejc.223.2022.04.29.21.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 21:14:34 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 13/23] builtin/log.c: Fix coding style
Date:   Sat, 30 Apr 2022 04:13:56 +0000
Message-Id: <20220430041406.164719-14-gitter.spiros@gmail.com>
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
 builtin/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index c211d66d1d..d35419e489 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1012,7 +1012,7 @@ static int open_next_file(struct commit *commit, const char *subject,
 	if (!quiet)
 		printf("%s\n", filename.buf + outdir_offset);
 
-	if ((rev->diffopt.file = fopen(filename.buf, "w")) == NULL) {
+	if (!(rev->diffopt.file = fopen(filename.buf, "w"))) {
 		error_errno(_("cannot open patch file %s"), filename.buf);
 		strbuf_release(&filename);
 		return -1;
-- 
2.35.1

