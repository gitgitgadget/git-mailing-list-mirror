Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5833AC433EF
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 04:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382175AbiD3ESI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 00:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240997AbiD3ER4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 00:17:56 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58124A92E
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:31 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n10so1290452ejk.5
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K41Re6xEqzz+OQgoWypHT6sjfORYxoUQDCVAmvJvlIw=;
        b=j9ndINR++1W3aK1qBjTZxWb9f78JWXUJZ78wQXgak4d3cAzl/nTjbZbwPiiPZEg+fL
         XSlcJmus8IXh3j9qUwR8TMZY6bkthYFj3rUqgwKPbOW7t5bQSQEO2gNCWoX/L9Qv1LEm
         nId49zQp5ve73HsSmIlniKq1Uq1q+thRpZ3OHE9KwXrCEhiU2+4utmiikmDCIlYlJvNB
         eWXZAz62jkaJaBmyxfQvYNKqsFDHSjPRChLiO7rtl2qSWwcwdWCZ8CFHi91xoTCK5wDb
         DM79ge7+8B6GSmmL6uXI4HJfkRWYjUaCpJHxIGVqLCVczpOtp6OrHLFCe8usQ0qjUSCA
         j7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K41Re6xEqzz+OQgoWypHT6sjfORYxoUQDCVAmvJvlIw=;
        b=TsVEAk1I3LAueYU7eUK7RhcLhv3Zrg5aEMXk2U7nba2jmV0BsmeXY9pYms7dOcdF6n
         2U2zb29+edViW/xVRKrwE4fkjzQgKpJFldHp4Qs9R1c6zKHPcAQd0YrVXn5DlmheFNAS
         VREGl88mz71IASZKbb+NWLXCbqGucqLrFMBZ+VKlGEDx2lG/lWAThFEUad1pAKjw2kOH
         uWWOUKEFboQihqjNxV7N1QYGjKgYww98+rhaNSIzwfANbQS+EYF4GGSYz3uVplxcA3fy
         ZXlVjyAOucYIFKTHhai83KsIS5PGgdFaDZcv8okA0ki5M1BlluRU6a+u9rW6KEGZ5Xt4
         lqkw==
X-Gm-Message-State: AOAM533+PMy1cxtLx11kzSNWAiuKSzDcsqugXAg1+nH7k06TO4giO2yi
        SyKeNQAH6lq+qca/xoNui+3qAP2W0UE=
X-Google-Smtp-Source: ABdhPJxYVuEVWOdViRhqP9GhKxTV8KB7QaT/q3vpV8h4nkRTFzJ9jSTRl3DPwRuO5NX8hlfQ9aJG3g==
X-Received: by 2002:a17:906:9b8f:b0:6e0:6bcb:fc59 with SMTP id dd15-20020a1709069b8f00b006e06bcbfc59mr2360693ejc.624.1651292070268;
        Fri, 29 Apr 2022 21:14:30 -0700 (PDT)
Received: from fedora35.example.com ([151.27.248.133])
        by smtp.gmail.com with ESMTPSA id og47-20020a1709071def00b006f3ef214e79sm1243586ejc.223.2022.04.29.21.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 21:14:29 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 09/23] builtin/commit.c: Fix coding style
Date:   Sat, 30 Apr 2022 04:13:52 +0000
Message-Id: <20220430041406.164719-10-gitter.spiros@gmail.com>
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
 builtin/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 009a1de0a3..7316fbba1d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -861,7 +861,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	}
 
 	s->fp = fopen_for_writing(git_path_commit_editmsg());
-	if (s->fp == NULL)
+	if (!s->fp)
 		die_errno(_("could not open '%s'"), git_path_commit_editmsg());
 
 	/* Ignore status.displayCommentPrefix: we do need comments in COMMIT_EDITMSG. */
-- 
2.35.1

