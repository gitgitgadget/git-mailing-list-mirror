Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A27C433EF
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 04:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241724AbiD3ER4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 00:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240830AbiD3ERr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 00:17:47 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2DD3B029
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:27 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id a21so11075039edb.1
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5piAnsUWzQE1K3AhbFvjSOycNDq1Abcd0E92dt75pw0=;
        b=Ks7gv1LjWKK0WLGDzmqIFmbojOSa5UifnuhkMIHVxi9nHmJ3PUNFAFvJzkd40v9lj8
         RMojj+v4h1MKJr+98lfIRq0rhMjSTIQe9seoUvfM0LYQd9TB+q5EvK9WKUs7jnxoVvev
         Pp+5mBY/y8AbAz2ufMBrMFlxPt4oOJ1vUjAsvv5hlifs2joMNKNpsMmfv1NMz9RgLsUf
         xTQTcp+wP3d8wNjb1BI/BE3CTFai7hxfB8bPzy8bIal3JYRpPLkYu4Wty/ZoMbZfrkIh
         vI3Epi1XIYUBGN0m/uOUgodh2VIhKKmSd6uxkDDl1Y7V47TC1UHs/FMC3FsTGRrmxK5p
         9n/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5piAnsUWzQE1K3AhbFvjSOycNDq1Abcd0E92dt75pw0=;
        b=VCFBVawY/277c4WbCzBziwkshu6jw7sIjxzJHT5lFC//1dtcIpapMSm4U89G4aARe/
         ea2bs1bvzRAsrIXOldLT8LEOmnw93SNZ0zHsoB/bP7lZ72PVHXKWXLoasdb+5Cemjf6h
         Rco5V9m1Q5FiY7dNL74kcNJ0HIpY4y80MEjjSzf9DqjtnNqQ2bndhrQuudA3QBs9jV/q
         cvcjOVp7Cz3AKuV36v1wfBI/DFtVWjf6Cu2LOwVKPqGCO8i7nA/ruvHPuaRRGNfMma/V
         DDHi2bc7/pPuWz7Vcso6COmH8aLO9gA+D+zg4plWyXSxqzmXHH2tpWt0i9SCCWju3111
         R9cQ==
X-Gm-Message-State: AOAM530Uuj8K4OrbtIukRDJHP5E1R1h6ftc+xzgjQ8+U8ZoS3AkcV683
        7Io4ikiSSHbcvfhROjyUrUHuzaME1ho=
X-Google-Smtp-Source: ABdhPJyS/YkO03zy5yj3u5aegwB6TYjTprVoL8D4PeCINp2AFnfoYzjYOKMi+dJCJCItedY6qaBhBQ==
X-Received: by 2002:a05:6402:2932:b0:425:d7b3:e0d1 with SMTP id ee50-20020a056402293200b00425d7b3e0d1mr2647693edb.141.1651292065784;
        Fri, 29 Apr 2022 21:14:25 -0700 (PDT)
Received: from fedora35.example.com ([151.27.248.133])
        by smtp.gmail.com with ESMTPSA id og47-20020a1709071def00b006f3ef214e79sm1243586ejc.223.2022.04.29.21.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 21:14:24 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 05/23] branch.c: Fix coding style
Date:   Sat, 30 Apr 2022 04:13:48 +0000
Message-Id: <20220430041406.164719-6-gitter.spiros@gmail.com>
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
 branch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/branch.c b/branch.c
index 01ecb816d5..bde705b092 100644
--- a/branch.c
+++ b/branch.c
@@ -466,7 +466,7 @@ static void dwim_branch_start(struct repository *r, const char *start_name,
 		break;
 	}
 
-	if ((commit = lookup_commit_reference(r, &oid)) == NULL)
+	if (!(commit = lookup_commit_reference(r, &oid)))
 		die(_("not a valid branch point: '%s'"), start_name);
 	if (out_real_ref) {
 		*out_real_ref = real_ref;
@@ -653,7 +653,7 @@ void create_branches_recursively(struct repository *r, const char *name,
 	 * be created in every submodule.
 	 */
 	for (i = 0; i < submodule_entry_list.entry_nr; i++) {
-		if (submodule_entry_list.entries[i].repo == NULL) {
+		if (!submodule_entry_list.entries[i].repo) {
 			int code = die_message(
 				_("submodule '%s': unable to find submodule"),
 				submodule_entry_list.entries[i].submodule->name);
-- 
2.35.1

