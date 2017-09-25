Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDE03202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 15:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935447AbdIYP7k (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 11:59:40 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:48224 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933355AbdIYP7j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 11:59:39 -0400
Received: by mail-qt0-f178.google.com with SMTP id q8so7364389qtb.5
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 08:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Im5CPUex1ja6YY3DXehbM3soIxrO17T6LgkAOK6JXjI=;
        b=LdoshLzHeg+OwpaYVUW9yA+zsTcMWmcsGEqb/DIdgzMp/3UijDu3QNAzE65IxZEDIp
         /8PIxr714IruWo1TD8xq3PwqnvAi835tBRd+jhwJgUxbkZ68BSzTi6uG3578+siFy/Zn
         C2QO+y5iRtn1fFst0EhtAqWuJSFzzgIml6kBGUe54siUlyhZlVau8uuIy329bvxx0xJf
         KkVmCpFsY/UgB/S1mx9dcLSYsoIpycor8UjZItwREdDZ6wfu0y1LC5NoMIm6bbtpUoj1
         WhNO3GkJ//UWbjTEktFQojAjjVnsBgd9MRreaQB2fgB44WH25ZY5kfQxw4gkSOEJ4+ET
         VuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Im5CPUex1ja6YY3DXehbM3soIxrO17T6LgkAOK6JXjI=;
        b=hHyLHNKdFihCq4hq2M0JkB2VLOAraO9FG0Vv+JEAiTKjW4ryWqXQDVnvbBSXSubjQS
         4M3GV9CFEiHji4eWATcPdyUaMWUQoBFM1KpOaGqyFpMg6mdqKMyYshBYXZhD+YIu9Nv8
         SqVcdx6Dt9sCGdSJcfirm6TNdV589oTzdipbN++9Cl4i1FRgSmBE0/l49cYxdDCsnb0d
         fBhMrMpSaL6ysatcwcClyOesCtgg9anNDxhDSDJ/t6lw+hY4plnTi4BMtbyFfyHVlcAZ
         5YdMpTikPo9fxuUC18PIqFbH3ZAKbeqCBqoYaL4jn0kgjFP9dgw50qRaSsx+Kpvi02Mx
         71jw==
X-Gm-Message-State: AHPjjUjJ0G9VzIu0E3v3kkOIKXO8zztjlJt1+7bthhg1g//55jEZ9d15
        QRcRirylz5SEjPO2M1+imO3BQDOlJos=
X-Google-Smtp-Source: AOwi7QCjqx90ZCPR2BQWpsiiyDEeU3EBtMkfm/QRx7px3bcyOz2hO5H7iHHv0hQCXibqlKydfoZV6g==
X-Received: by 10.200.57.83 with SMTP id t19mr12103846qtb.150.1506355178202;
        Mon, 25 Sep 2017 08:59:38 -0700 (PDT)
Received: from hanwen.roam.corp.google.com ([104.132.61.99])
        by smtp.gmail.com with ESMTPSA id h19sm1439510qta.26.2017.09.25.08.59.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 08:59:37 -0700 (PDT)
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, bmwill@google.com,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 1/4] Fix typo in submodule.h
Date:   Mon, 25 Sep 2017 17:59:24 +0200
Message-Id: <20170925155927.32328-2-hanwen@google.com>
X-Mailer: git-send-email 2.14.1.821.g8fa685d3b7-goog
In-Reply-To: <20170925155927.32328-1-hanwen@google.com>
References: <20170925155927.32328-1-hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 submodule.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/submodule.h b/submodule.h
index 6b52133c8..f0da0277a 100644
--- a/submodule.h
+++ b/submodule.h
@@ -120,7 +120,7 @@ extern int submodule_move_head(const char *path,
 
 /*
  * Prepare the "env_array" parameter of a "struct child_process" for executing
- * a submodule by clearing any repo-specific envirionment variables, but
+ * a submodule by clearing any repo-specific environment variables, but
  * retaining any config in the environment.
  */
 extern void prepare_submodule_repo_env(struct argv_array *out);
-- 
2.14.1.821.g8fa685d3b7-goog

