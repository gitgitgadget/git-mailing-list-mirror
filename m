Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC58A2089D
	for <e@80x24.org>; Sun, 30 Jul 2017 11:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754039AbdG3LJE (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jul 2017 07:09:04 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35017 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752120AbdG3LJC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jul 2017 07:09:02 -0400
Received: by mail-pg0-f65.google.com with SMTP id d193so27846645pgc.2
        for <git@vger.kernel.org>; Sun, 30 Jul 2017 04:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vJqQ2VhYc+Cm29LO4PXfYHoX33ObaXckkqhxGbxaoP0=;
        b=qngN1nbKgieTwKZZpGqEB/h6qPu/HbDBPHRmHG+v4b5/gFEhn0L0QNtMCYN5Ks5oWT
         xsHe5ZsQjKnyi5U/t517MHfvOBn4Y0YVNxS2ZJqAUUT5obyN3tIfxpX8fFH+MUMOw7so
         wAYWAw2AEMHO90mnX49vSYNZgNEFrrkCFy2Bnhuqw/7DJ8m8nj63F9CocHZeMpxy2Kvs
         mD0Hqpfr2qN4moLdID9+ifB38vG4u99rUUigldIcKfvK5wu36WeduZZXEVUO9a4aiQz5
         LhFu82RfOjJ167WlvMRQD+h9crJUTKaWk8cDQ3AoApCiHQPNI/5Znpfr9BP1VkKYCVR/
         CjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vJqQ2VhYc+Cm29LO4PXfYHoX33ObaXckkqhxGbxaoP0=;
        b=qvOoJXdQItw5Fxl2bYc9zMTOn+LN6Gpy6g1KPDjVajBDkoRKw/4Y7xC+0J5DB3WqXO
         PtvWklpOdN8+VWTtheNeDFBJFcxjjtOGwJSv6AqDfsoF30+J+PrSENjDAI10sDu90Mgo
         4Cq6oNcOP/JiJePAeSwqhYHkR96dkqPbaT/AB4PLpVaNJwssuArKRB35qIq9QW2QpuE/
         qVJXOcT+WIDzgD5pxTGZP4RVxse/HqRz4i8mI3m9ZbpmGJezR8jMX+tN4jvxAWO29ilr
         7c0Y9mAAv3nBO/SltXkU0mR6SKS+hjuqrCf2ne6gOgY2C5Nhvrv24jE9rohmoCMxucmN
         FfJg==
X-Gm-Message-State: AIVw111yJxSgEhwekGMJzvHUZ7PJSNO4vD5fX1AhBHBXXt3LnB2Sqe9u
        1aWjdLzUKZGnBA==
X-Received: by 10.101.70.70 with SMTP id k6mr12494143pgr.39.1501412942055;
        Sun, 30 Jul 2017 04:09:02 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:72c2:f76:6d01:c56f:1310:5568])
        by smtp.gmail.com with ESMTPSA id q199sm45824704pfq.135.2017.07.30.04.08.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jul 2017 04:09:01 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH 2/2] doc: add another way to identify if a patch has been merged
Date:   Sun, 30 Jul 2017 16:39:21 +0530
Message-Id: <20170730110921.11805-2-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.0.rc1.434.g6eded367a
In-Reply-To: <20170730110921.11805-1-kaarticsivaraam91196@gmail.com>
References: <20170730110921.11805-1-kaarticsivaraam91196@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 I'm not sure if the first one (pull --rebase) is still
 required and hence leaving it as such. Let me know if it
 could be removed.

 Documentation/SubmittingPatches | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 9d0dab08d..a800e54a7 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -386,6 +386,10 @@ Know the status of your patch after submission
   tell you if your patch is merged in pu if you rebase on top of
   master).
 
+* If you made your change in a separate branch (<branch>) you can use
+  'git cherry master <branch>' to see if the change has been merged
+  into master.
+
 * Read the Git mailing list, the maintainer regularly posts messages
   entitled "What's cooking in git.git" and "What's in git.git" giving
   the status of various proposed changes.
-- 
2.14.0.rc1.434.g6eded367a

