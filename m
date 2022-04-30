Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44604C433F5
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 04:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240941AbiD3ESD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 00:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240812AbiD3ERu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 00:17:50 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8BB3ED0D
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:29 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id y3so18664984ejo.12
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ik0vBSPiXSQAVyMhMuS8PJGmWtqvcnSXOMSfoVUt09c=;
        b=RTZcEYbwqyNisPhxpS22a9yR6WBZU1IQOTBaCGfTnV/y3X+CdcGMJFMZaaNGyhondo
         P4ZI77hFAYPq3ulOckmEolAwD3Ue5WhSozxbVeJis3VaX7t5K07mMEegEpzM1XewopFd
         3T2rydZMkXywlMYL9hhsv4G5Nl4zq9+OIg6DqiCRDo7XdI9nwsenarse7AaPAUrF4Grv
         uYmuGs/04n2I0aNUw6D4aBR+wlLCJV5fEISkF0KPTI5/mei9zYOIhTtXGMJVHIsEBjjq
         B7HlW3f2mhRHrPS3i0MAhW+/kCZR/YESRIytz2oZLoUlM28X9VTL91CkVNXexYTA84qA
         nF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ik0vBSPiXSQAVyMhMuS8PJGmWtqvcnSXOMSfoVUt09c=;
        b=SgqCjgvKTN2vmv5E4TzXVlquY07lmJfiQ2eamYMp303ksqS2wWome2OMrMRfSfjrdB
         evve/V2QYyhuiJkzcZr9QO/c2FO1UHaI6SZUvu+RSnkGCnJShV+l7XUECZLezQYB+mCR
         TnwMpJ19ae101uTVBGKFosI1hJrt8CIX6Ns5GDYzATvwHolLPp1fcbhsSUXLXIONm8M8
         ohv/a6x4wdTHfC2sW5Gh/gC6OItXVV13Ut9BIMwZgcT7EcSTygeXkDellC/c/INT/w9n
         oZSjtIf7CaI1KFVo56JzLpd5p4kJq5BAk0drA7cFFN+colTClPC0UEptObtZfoXhRr6F
         yilQ==
X-Gm-Message-State: AOAM5335CFfMIFhCeXMHLEBdGu7T6WTrHERODwQj7w32hbaS1FefuIFE
        oSK5Gdqz9CB9Fy71WJBZ7G7t/eRvmYg=
X-Google-Smtp-Source: ABdhPJxpNlz2C1cIIoXHM8wwUt49oNFJxI68RVAXW1BYxu3zLwBVLtKWFlrcH/m26kEovNCi6i5evQ==
X-Received: by 2002:a17:906:1b1b:b0:6f3:9044:5fb4 with SMTP id o27-20020a1709061b1b00b006f390445fb4mr2244226ejg.763.1651292068076;
        Fri, 29 Apr 2022 21:14:28 -0700 (PDT)
Received: from fedora35.example.com ([151.27.248.133])
        by smtp.gmail.com with ESMTPSA id og47-20020a1709071def00b006f3ef214e79sm1243586ejc.223.2022.04.29.21.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 21:14:27 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 07/23] builtin/checkout.c: Fix coding style
Date:   Sat, 30 Apr 2022 04:13:50 +0000
Message-Id: <20220430041406.164719-8-gitter.spiros@gmail.com>
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
 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 797681481d..f988936ddf 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -834,7 +834,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			if (ret)
 				return ret;
 			o.ancestor = old_branch_info->name;
-			if (old_branch_info->name == NULL) {
+			if (!old_branch_info->name) {
 				strbuf_add_unique_abbrev(&old_commit_shortname,
 							 &old_branch_info->commit->object.oid,
 							 DEFAULT_ABBREV);
-- 
2.35.1

