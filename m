Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B90C71F403
	for <e@80x24.org>; Sun,  3 Jun 2018 16:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751377AbeFCQfB (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 12:35:01 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43012 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751361AbeFCQe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 12:34:58 -0400
Received: by mail-lf0-f66.google.com with SMTP id n15-v6so4268561lfn.10
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 09:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8xYAAqOEiOMcwQpMHDw5QFymDmbBnlUQn/nONWS0XlY=;
        b=uJRSzNldJi1c/gD+T8e8ctePKACZf6CrkwwNmJJjxPYjxNcyYX+17ZmcYkUF9eaVHQ
         B8SNHrCl0hdl+JdeM2smgPuaV82KCvw3OMJv1dIkfAys6jMw8v2jkvcPDbYjZmIl6Nwi
         uhs+7reZzVoQ1QFz0Xht4O2eNIwdVunDF9AhITM1z8BbHa61GUcS76aM1vujDC88cdY+
         MZQD0hNm7JbMq8J0SOooTMT03Is+HtdOueCCtmBIBEpbGL9GHcVQeQOlj1Y3DEcscXPe
         3hTYuZ425rFf+gqB1jc5UF9e2N3rmtDG39m2CgRXT7NEYprIfpmbakmrgeqUHSicZcwT
         r0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8xYAAqOEiOMcwQpMHDw5QFymDmbBnlUQn/nONWS0XlY=;
        b=ekPId/9ef13jmc+5AsvW1M/4i3IMXp2mgb2DiRsdGmi7rIFaoX7RASqemcu3qnYTBS
         ZrJdjyWIi4ZMwMztLV0j2s7RrLPEJ/IzOMQsvN4xRf09V7QdwBM81cvHBwXxOzBsVwTs
         G7xsHPLFgPXyVUOrgjq5VbZG/Nnbts+vX/maqEalKUNzd+IxXtdDyidsYWOtq5nW6JiI
         u8SYG2AKqBg7YaA4Ix3G6q+v4N7h/TTfhBP9sSSZWsGJP8PZoCooWfja2gRhnv2JJw1l
         ws+MnyGPJcPLFmk9aSJIge8SQJKg0L84oMXofNYZYIGqX2OzoZbMsswllQaWS7wVNBy0
         ttBw==
X-Gm-Message-State: APt69E3kImoPqZ/MMLIYfy3DJPgs9XaHOx36Xj/0gFkQwBnHnp+bj/sI
        a5mKVvZLeX9sK5ZTDTlK+t0=
X-Google-Smtp-Source: ADUXVKL4Wor5CHmBR0DBh72mhhREiDbNPDYd7GrZ1sb5Afgo7eDxHxzdtTNaGw74Q/ytKWM/cY7KYw==
X-Received: by 2002:a2e:870d:: with SMTP id m13-v6mr1308429lji.139.1528043696983;
        Sun, 03 Jun 2018 09:34:56 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v79-v6sm4726895lfd.32.2018.06.03.09.34.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jun 2018 09:34:56 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 14/23] exec-cmd.c: mark more strings for translation
Date:   Sun,  3 Jun 2018 18:34:11 +0200
Message-Id: <20180603163420.13702-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180603163420.13702-1-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com>
 <20180603163420.13702-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 exec-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/exec-cmd.c b/exec-cmd.c
index 02d31ee897..4f81f44310 100644
--- a/exec-cmd.c
+++ b/exec-cmd.c
@@ -358,7 +358,7 @@ int execl_git_cmd(const char *cmd, ...)
 	}
 	va_end(param);
 	if (MAX_ARGS <= argc)
-		return error("too many args to run %s", cmd);
+		return error(_("too many args to run %s"), cmd);
 
 	argv[argc] = NULL;
 	return execv_git_cmd(argv);
-- 
2.18.0.rc0.333.g22e6ee6cdf

