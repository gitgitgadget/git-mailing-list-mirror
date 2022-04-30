Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5B7C433EF
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 04:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382212AbiD3ESm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 00:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382190AbiD3EST (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 00:18:19 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB889517D4
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:41 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l18so18689993ejc.7
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o6yT7ru7zsGXCmvUKcJvI+KABZIlTkfCaJyaKa3rzuk=;
        b=e98uzlzbbTOxOwEa8HCETN6KSbGIXJ02i0Je67fxyiCUk1kbR17qeQmlx95a1FVvcE
         bOpH3zvl+cZgB5z5L5YOKEdFKrkJh8XdxDalT6Hcpq1D5Pdupyk38EqD8dABql69A8t4
         XbfwP/clg04eJy0kRZMT9k5iSBUyLsqiTPmP5aC6dM3FgfdL55pKK+m20F6FIK/xfOUg
         AqPm5bhsuRIIejB54o4T4pb0nnuwJzQmLZehwyrR9j8aoZaNrusy/8CWbELGYXcxBoJX
         a6NkxmTNSQojhg8sBqY0ag61Od12GZlcH2KF2eConkIeM+22DK+SGUV8VEt6dPBdNGb3
         MrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o6yT7ru7zsGXCmvUKcJvI+KABZIlTkfCaJyaKa3rzuk=;
        b=KlHp14TINxSgxZGHCn3n/Dbd6NbsI1XzmYKkf1nrh1WJgZpEx25h4GblDxtFmsF9kR
         XCIw/zduwqQzcMIx3UUcEw2OzvNNo1NW+UP6nebNtWFQHPOoWmVsQyJPKukXlvmtfQlL
         ugSu4QGsooTjJvw+HXQ1PKf0tQb8+/iyhk/IIvQwOpfevAvxzNBeN/t2Vs3G5u2r2q6S
         lgdW4QmDPiI1D5DoijeMg+cWP6I5iZybv7J+SBxgyCDh7xwT0y6yVQWt0rQMw7RFIiQz
         PJjcp6GaRUb0vT+WCF8shdjvwb7AXnu33lsorIz9X8iSZXY/UVLvS/rnD2uPue4/9kCM
         zfaA==
X-Gm-Message-State: AOAM5335GmjXB7RTWdIe5Wqke3MV7t1h6zFnWvDUh12j2aDm+FCy+Nl/
        gAxGphMQR8lyJQ0C69Y5IEOSmdTGs30=
X-Google-Smtp-Source: ABdhPJyKvoKu1MGRlyvFNKAeg2f1o+3NYBEDJaFqhFNz2mnbUzW3qItTDEPH5SkTfUAp9HdXl/jYsQ==
X-Received: by 2002:a17:907:7745:b0:6f3:674a:339 with SMTP id kx5-20020a170907774500b006f3674a0339mr2300891ejc.207.1651292080084;
        Fri, 29 Apr 2022 21:14:40 -0700 (PDT)
Received: from fedora35.example.com ([151.27.248.133])
        by smtp.gmail.com with ESMTPSA id og47-20020a1709071def00b006f3ef214e79sm1243586ejc.223.2022.04.29.21.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 21:14:39 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 18/23] builtin/replace.c: Fix coding style
Date:   Sat, 30 Apr 2022 04:14:01 +0000
Message-Id: <20220430041406.164719-19-gitter.spiros@gmail.com>
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
 builtin/replace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 5068f4f0b2..583702a098 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -72,7 +72,7 @@ static int list_replace_refs(const char *pattern, const char *format)
 {
 	struct show_data data;
 
-	if (pattern == NULL)
+	if (!pattern)
 		pattern = "*";
 	data.pattern = pattern;
 
-- 
2.35.1

