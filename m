Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3585BC433F5
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 04:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378907AbiD3ESF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 00:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240874AbiD3ERu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 00:17:50 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ECF3B029
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:28 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id n10so1290289ejk.5
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y/4CGgdxWMbvnxtbbUHxyXriwUJYnjm/PkB2an081is=;
        b=locJmYI9no+6cxqeOG+7yeIUn8kAbQlqlOFFN2lMiRNzTrMO0PKO5XIKqQ3sVvHJbn
         kPUkdDt7SYQl4bqGXls8i1sKfVHSgMAWZhs5SLZkCbbiHPv3ndNRd5pOEnr5Geba55+N
         RxwIhpz2E1IaiDvj6YSBljc7wKA+EjXdYOQMIWR61CEwmHSM2tV2DVG8lFp1oXYx9GBo
         KGdioztBVfDN4yYx3zCLVc+yTjQqg9HBV8USEh+c/rrqC5Jibtd6UAfZ1dl6/jKpm0wC
         NwCII7aoVNCFUv9W8sCxYojO9CKwgZ6ATYIfMZjJ5Hl2Bcj36GlFAhBfZuDWh8H84k1Y
         45vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y/4CGgdxWMbvnxtbbUHxyXriwUJYnjm/PkB2an081is=;
        b=tqaTdr4vIGfOuZnNA6kMencVHSReFXufRIYVQ0PK3H5b02yJWpLcLbE1dq2Dyxi4r+
         KfjezYUdpJ7LCYzKWWqfPm/LAuQiVyRg6qm/cgzvLe4bNndcqQWHp5LdaeD+Mw7k5nme
         HVSawbTfJ8EEnMEPYwxMmvTDllNATjGOJXbrxjfV51oxU4C/ZKEC+eeRwcxL43kP+Cpk
         kzGjZkrQniJGBs9jp7PCbtE4FeGY8PX/b3XVWIaEbBdsNdND2g3YhboA0uwrr2eCxqo6
         TQvzwg7U66lftVzYcSyE2IzlBHDIDxkbeO5I5N5CdM3OKVMtMgwxkxQRESvbFhzLdgzK
         p2jQ==
X-Gm-Message-State: AOAM5306yT78lXTkWy1wjlyKREMPvVJ8iGxlnCZBWdXcAeVREaB5BXM9
        jEZtqf4iVUt00XGHK2Q72Ujd4P17nfg=
X-Google-Smtp-Source: ABdhPJxeDNNTAbxNEDw75PPtsk3F25HXI/6r2psCEptoXiCbL1XBrbWUSQvKldWehclHavKDhUHWgg==
X-Received: by 2002:a17:907:1c8a:b0:6e9:2a0d:d7b7 with SMTP id nb10-20020a1709071c8a00b006e92a0dd7b7mr2274831ejc.572.1651292066919;
        Fri, 29 Apr 2022 21:14:26 -0700 (PDT)
Received: from fedora35.example.com ([151.27.248.133])
        by smtp.gmail.com with ESMTPSA id og47-20020a1709071def00b006f3ef214e79sm1243586ejc.223.2022.04.29.21.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 21:14:26 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 06/23] builtin/bisect--helper.c: Fix coding style
Date:   Sat, 30 Apr 2022 04:13:49 +0000
Message-Id: <20220430041406.164719-7-gitter.spiros@gmail.com>
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
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 8b2b259ff0..e432e1b0ef 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -433,7 +433,7 @@ static int bisect_terms(struct bisect_terms *terms, const char *option)
 	if (get_terms(terms))
 		return error(_("no terms defined"));
 
-	if (option == NULL) {
+	if (!option) {
 		printf(_("Your current terms are %s for the old state\n"
 			 "and %s for the new state.\n"),
 		       terms->term_good, terms->term_bad);
-- 
2.35.1

