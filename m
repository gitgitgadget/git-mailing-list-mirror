Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6711CC433EF
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 04:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382216AbiD3ESr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 00:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382192AbiD3EST (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 00:18:19 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D4F6B089
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:42 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gh6so18805413ejb.0
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qdtzDpvMAc4af8eOrDuS/mS/xnubDC+wY5LD5COs7H0=;
        b=Rvabm4N0+DLr7tE+329IAYRNWouKn7PT41tVsqvDDuikgvcDW99e+6eqR0yjn/ByvL
         JEm3xPcsNhfe0ZET36/ZU0fFLAFZ1po9YMiWzaM3/rdsiiBdkO8cSqXLl7xY0SofH9fh
         7kBpxw7N2BVq2y2GdUguZc0e7bkiYcbqWKGvTuqDOsi1csOGpTR4lxAT20rnmk9SAm/j
         LCwlj796pkIHstvg91tyQXqXy/I3fV3yPkutySdea9Gk9zmNZz3MxsEcMlctNfdAzJ7x
         TEdbSWN2xwkVasaMjoe065eFt4wfBRnUSrzgCdTcWhnCu32PQRwLm7ArrSkAUQRCmNZ9
         PbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qdtzDpvMAc4af8eOrDuS/mS/xnubDC+wY5LD5COs7H0=;
        b=IZarFtO5HBENqt5iJqwmV7XRVte0+quq82uhz/kEjBRAOhLreOrXxzIaYKBRKuUUe8
         iY7+PVAZua2iroeBecz8hcSBTEExTycxbaB2youWXszmbGVdmsrxqzVh6MxQXmUFPtot
         xZtDmn207P1Xj7StL3rx/bgctwlImDkzEaP8wAJIwMYat3e05QuM42p9ptcAWJIsmS+9
         CvIPyK7RRpwJrsyBn+1ySxhlyCZaeYpjonn7c9O3HpQhF941CyhV89t6ZHzYA+1RYw7B
         lYeeAogHig3fxdMB5iY+5Ou0DFdcIu5F2AM8l6GxDCnlVrifyhJkMfH6m26fy2TZyutY
         6WWw==
X-Gm-Message-State: AOAM5301flKZ6/kHmLiUVptvia1XGW7DRGY4OWuN0cliu5vwpVgANdIv
        vcQvIET+KSZ7OQv55AARAvWnMVjyzN8=
X-Google-Smtp-Source: ABdhPJwKPMt6Y2cDqru0BxDeo+jlpA0TXHpJgGkVc9lFX3Qtgbkfyav9E+6P2pRLFY9ZTqhR+kjNOA==
X-Received: by 2002:a17:906:fccc:b0:6f3:7569:77fd with SMTP id qx12-20020a170906fccc00b006f3756977fdmr2331024ejb.266.1651292081101;
        Fri, 29 Apr 2022 21:14:41 -0700 (PDT)
Received: from fedora35.example.com ([151.27.248.133])
        by smtp.gmail.com with ESMTPSA id og47-20020a1709071def00b006f3ef214e79sm1243586ejc.223.2022.04.29.21.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 21:14:40 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 19/23] builtin/rev-parse.c: Fix coding style
Date:   Sat, 30 Apr 2022 04:14:02 +0000
Message-Id: <20220430041406.164719-20-gitter.spiros@gmail.com>
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
 builtin/rev-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 8480a59f57..660a6a749b 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -476,7 +476,7 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 
 		/* name(s) */
 		s = strpbrk(sb.buf, flag_chars);
-		if (s == NULL)
+		if (!s)
 			s = help;
 
 		if (s - sb.buf == 1) /* short option only */
-- 
2.35.1

