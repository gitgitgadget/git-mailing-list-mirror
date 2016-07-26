Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3371203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 14:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756764AbcGZOA2 (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 10:00:28 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35187 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756652AbcGZOAY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 10:00:24 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so1826502wmg.2
        for <git@vger.kernel.org>; Tue, 26 Jul 2016 07:00:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=28cBnmSrJ015zv8Akn83fwXcCkbpM0aJPr8Wclosurk=;
        b=I8JQbjGOUPIUdiswhWRfQc8azlCVWfVPomDD+Z0oNeDdHp2WXIOnYaIqhUg76lH8iX
         /xm0pNT+tjPUZ4d3ARDy16Lm3z/7M8qO8rvuC4YGpD4yW7d1ZMI9QYvHba502xYW5mht
         vyPKlJKK5g2AtWFN/bYSRdXybm9RyvDbTldzo6MiXJn+bdgKvxzCp9+sI556o7d/P/ox
         TfR6xgWj0YOB0/+AzLpAPIXfbjE2N1JqplV6LR88p3reKY7oet0U/wZdV2xEyHsSz9CD
         iHoMfF7yOWEjoYvXwLkeTK2/E4nStB29S1ETJSsM7PRaVfV1O/Tw5V+wKKJS/162cID1
         Hr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=28cBnmSrJ015zv8Akn83fwXcCkbpM0aJPr8Wclosurk=;
        b=fpMmhIINRLJW1Fa6msZsBlDFZ8wAGU38wpGKuc6iTwnEQXGWh+T3L0J6E6qSgTwDYx
         roIyx9lWGa9+wlJQBp/Qt3QXsUl6YVJYbz+YZWdimiGIrkfW+ZgJ9xrBOe/CqSrA8b0L
         gmskmMpZ9K4dBD2F13Glh1up4AfzshqGI7sESfANWfq+P1+wr18EPjB5aKAKZQPaHyMA
         esHbNuufXQZ1VgJitssNciX+flR/t3KPBmW87I7v3prM9S75ADUoX8zJfOcVNyqRuK/0
         VTIvzJfBsnP4b4MqEfndY+w43cdzDGKxG6cDnohQXPu4uwr0DtKgm76LtnO4P/NJB8CO
         zcpQ==
X-Gm-Message-State: AEkoouuoCB/3qXMhUrJwrIyngBdk/DCkc54xk4xugyJOmP+ecu2kERSb6ERokjUgbcoDTQ==
X-Received: by 10.194.187.7 with SMTP id fo7mr21200454wjc.162.1469541622052;
        Tue, 26 Jul 2016 07:00:22 -0700 (PDT)
Received: from localhost.localdomain ([95.86.71.62])
        by smtp.gmail.com with ESMTPSA id i80sm1884310wmf.11.2016.07.26.07.00.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jul 2016 07:00:20 -0700 (PDT)
From:	orgads@gmail.com
To:	git@vger.kernel.org
Cc:	Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH v2] commit: Fix description of no-verify
Date:	Tue, 26 Jul 2016 17:00:15 +0300
Message-Id: <1469541615-21726-1-git-send-email-orgads@gmail.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <alpine.DEB.2.20.1607261541170.14111>
References: <alpine.DEB.2.20.1607261541170.14111>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

include also commit-msg hook.

This brings the short help in line with the documentation.

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
 builtin/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 163dbca..2725712 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1616,7 +1616,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "interactive", &interactive, N_("interactively add files")),
 		OPT_BOOL('p', "patch", &patch_interactive, N_("interactively add changes")),
 		OPT_BOOL('o', "only", &only, N_("commit only specified files")),
-		OPT_BOOL('n', "no-verify", &no_verify, N_("bypass pre-commit hook")),
+		OPT_BOOL('n', "no-verify", &no_verify, N_("bypass pre-commit and commit-msg hooks")),
 		OPT_BOOL(0, "dry-run", &dry_run, N_("show what would be committed")),
 		OPT_SET_INT(0, "short", &status_format, N_("show status concisely"),
 			    STATUS_FORMAT_SHORT),
-- 
2.8.1

