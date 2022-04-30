Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B398C433EF
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 04:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382153AbiD3ESN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 00:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380990AbiD3ER4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 00:17:56 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714B252E66
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:34 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id i27so18704713ejd.9
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gL4FhZkbLEwitYYenxLJnMBWMMXE9F6mq5SZAha8J9g=;
        b=aMz0/rE/VCE7QkcI6jD+L5ugsy17zTAVe8kTqsob2GCOndPSTqJgCHi36i9unTaJac
         AIH2RUKTlzChC+fcU2O10Nj1oRm5I6FFR6Q5BQrHGrOTMeLEMWZhfRUjf0mvdzQeZF6x
         TRhlboIz6VbpvgbsFuRAQraM3ltqJxyBKnVySUbTijYzB+KGmTMz/1d+alzfqS0TfKih
         oVk5op2VQHyGlO7bA6cmxmmsViZ7niMpEFOGv7TPSF/jPJoKA30iaUr//+kC7gmZJP+f
         +MeiSDoX/F9L//YLaS/x2kVDEOkSmODbon6WJpYYg3xwfJlW8LZPmIx9nngJOSnU/kcH
         QD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gL4FhZkbLEwitYYenxLJnMBWMMXE9F6mq5SZAha8J9g=;
        b=hKqyN1QGStOyxdr0cKAzb8t4SoJVxr0FQBXQ3i9f55aaVadR95T57CnU4oeTI+Kd35
         U3W/MU17I4iBDWvjfpoP5Y9S+vkQnnVvcTw/6wZuIpNUa9logL4Kg27qE1XvnExO42JJ
         F1pbeYE0b+DwqEJlLYTA1KQInEF2znGbYkt+Vs68g8p+WbPzZ684psLoJhp0UXoBQjKy
         Br8nfVPMtH1Curdw2cgyU7CsWllWNfM4oCtHeZEAXOxDzZ6IJUwD7QOwiY+A2QrKBcPm
         pM+oVsMM4c7u+woYFF0ay2TuCQ6FundwSuLuUrpiA1sat8mLEG91O124AlGlf8gGoRT8
         ml/Q==
X-Gm-Message-State: AOAM5326hk7JEnj7jc6ivcZEUHza6LRztzYrIQa9EHj71S6pVEiXWMi3
        Ic/byWWaBLOHIQ7gXHYguFlsdIEeAfI=
X-Google-Smtp-Source: ABdhPJyEoI5NZuXUsNLkhX4VAI2A+ZHNlz4Dq4WYbDNtby0mG8hK/boRd1NTtGJDLwNHlKnpbP8o2g==
X-Received: by 2002:a17:906:314e:b0:6f0:659:963 with SMTP id e14-20020a170906314e00b006f006590963mr2373940eje.358.1651292072795;
        Fri, 29 Apr 2022 21:14:32 -0700 (PDT)
Received: from fedora35.example.com ([151.27.248.133])
        by smtp.gmail.com with ESMTPSA id og47-20020a1709071def00b006f3ef214e79sm1243586ejc.223.2022.04.29.21.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 21:14:32 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 11/23] builtin/gc.c: Fix coding style
Date:   Sat, 30 Apr 2022 04:13:54 +0000
Message-Id: <20220430041406.164719-12-gitter.spiros@gmail.com>
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
 builtin/gc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index b335cffa33..daa4535f1c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -446,7 +446,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 			fscanf(fp, scan_fmt, &pid, locking_host) == 2 &&
 			/* be gentle to concurrent "gc" on remote hosts */
 			(strcmp(locking_host, my_host) || !kill(pid, 0) || errno == EPERM);
-		if (fp != NULL)
+		if (fp)
 			fclose(fp);
 		if (should_exit) {
 			if (fd >= 0)
@@ -2238,7 +2238,7 @@ static int systemd_timer_write_unit_templates(const char *exec_path)
 		goto error;
 	}
 	file = fopen_or_warn(filename, "w");
-	if (file == NULL)
+	if (!file)
 		goto error;
 
 	unit = "# This file was created and is maintained by Git.\n"
@@ -2267,7 +2267,7 @@ static int systemd_timer_write_unit_templates(const char *exec_path)
 
 	filename = xdg_config_home_systemd("git-maintenance@.service");
 	file = fopen_or_warn(filename, "w");
-	if (file == NULL)
+	if (!file)
 		goto error;
 
 	unit = "# This file was created and is maintained by Git.\n"
-- 
2.35.1

