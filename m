Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF2AC433EF
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 04:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349317AbiD3ETA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 00:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382210AbiD3ESU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 00:18:20 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CACB85673
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:46 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id p4so11136420edx.0
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JMORXA0PiM1EfpkM/8J/uEyI1VL/jP5Ia5A1V9ZHftc=;
        b=cVxwkJ56VkvlUNdr5NgwG3u7dJyU7iiZ5yn6VBa+nQcjX0wZzGeWfwwKUKt1AQYJlk
         Etsu8hFePE/auZa/xlQDYStQZNclNAqNIVolDrx+jgHTvL6+OCFZuvg8ctlRhcMM2a5P
         8DYgLBNwMmQKEdxjwH0Hp2lRPPoxUD8UOY11yNgcOQNYms3T5cz0G1gciHIoEITI/yun
         pu9tJDXC2s/IHRvKUXMAX9zb8nn4NBqW/HrwHDq1bl3lF5KkioaEmoAZY2dNYVYYyO6x
         Ti8F9SxtAkoHuY/WACLoFuVZX9gWs0c9oLnsowJ3eU0IC5Ojz7Szo/PIMQxp3b+GxIYM
         +96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JMORXA0PiM1EfpkM/8J/uEyI1VL/jP5Ia5A1V9ZHftc=;
        b=pgQRKYDpZFVkQ+Y2zl4vaz2ClkfroJwgvx09CP5GbxfwBhwZ0egCOIKxClImZQb6jA
         A8dkir/Lf3VnOKi1mERES5UAX/f1KjbCbGcP6XlbNRyI+3JvW85iyFYR8MGc12Ztsj9k
         EvJXiwC5wylup03P93PEVTq0ELq3ZOSgufA07qgH4bU28LTae1F6aW/KiQVQewmQ4g2a
         Lc9wxITB80PSy66/v4GlLn4zUccQ6s3RPXk1l6vlb/IZvq/eW5Jn5cbW/CWRZmHbXsDi
         vJt0UD9zW+/O+p9mL6bvPPENur0cmcRTphY8i21LlM44lx3t8Pd5pOSSTuJ+ojPdKl1R
         WXyg==
X-Gm-Message-State: AOAM533Hwe2TwC0X6ixDXIhIbGEuDOnJCWbxAFc3sG40m6+ALt80RRzS
        5LEw2sOmQHeSIq1MFrsG8r7x6lRO9VU=
X-Google-Smtp-Source: ABdhPJycgEChH2JRcyIy2xgEuS2nzPoC08BujZWNKnk6ZbmxK32ZpI5TWQm9BurDwTvfWQ3w0Ytk2Q==
X-Received: by 2002:a05:6402:1941:b0:413:2b5f:9074 with SMTP id f1-20020a056402194100b004132b5f9074mr2616247edz.414.1651292084878;
        Fri, 29 Apr 2022 21:14:44 -0700 (PDT)
Received: from fedora35.example.com ([151.27.248.133])
        by smtp.gmail.com with ESMTPSA id og47-20020a1709071def00b006f3ef214e79sm1243586ejc.223.2022.04.29.21.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 21:14:44 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 23/23] commit-graph.c: Fix coding style
Date:   Sat, 30 Apr 2022 04:14:06 +0000
Message-Id: <20220430041406.164719-24-gitter.spiros@gmail.com>
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
 commit-graph.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 441b36016b..fcd351ee00 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2567,7 +2567,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 		odb_parents = odb_commit->parents;
 
 		while (graph_parents) {
-			if (odb_parents == NULL) {
+			if (!odb_parents) {
 				graph_report(_("commit-graph parent list for commit %s is too long"),
 					     oid_to_hex(&cur_oid));
 				break;
@@ -2590,7 +2590,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 			odb_parents = odb_parents->next;
 		}
 
-		if (odb_parents != NULL)
+		if (odb_parents)
 			graph_report(_("commit-graph parent list for commit %s terminates early"),
 				     oid_to_hex(&cur_oid));
 
-- 
2.35.1

