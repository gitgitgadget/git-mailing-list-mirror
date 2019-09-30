Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99B7D1F463
	for <e@80x24.org>; Mon, 30 Sep 2019 09:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbfI3Jzm (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 05:55:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34190 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730602AbfI3Jzh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 05:55:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id a11so10524580wrx.1
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 02:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RVE9a0xIxOv1m/oHcTcIhY+O/HERoXxmdzKfXgJwF88=;
        b=NUNWPlqkZO3ejxrAtYs/hcwKeYVK5K9d/u8A/qT7AEpvUqELcHVsds6jh/2dWDlrVD
         Qyn6QASzikyGFoHkWN1dyd/SnuKZGlGjfSAjr1tFcX0pP6sEMAQMyBKiMHf8jy70Ciup
         +CCwgHHVQbJGK5xUHONPlt1aQunmTkBPVTlqGCdz6KGpOrGEXNKioXzdYZyCPtY8lpHm
         usg0jqow6JOdcEvAOVpGexUPNmiaM+TKqsAx8m70pUU3dmWtK33TfmQTmriEznJBsdlL
         EIXON0Ahigi/KIeZML6L1oZA40Zl7+suuO+6YdslWUGE0guyibK+b89nx6SDwdRWqW8O
         ck8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RVE9a0xIxOv1m/oHcTcIhY+O/HERoXxmdzKfXgJwF88=;
        b=M0IGQS78ENcHPlJErfuX0Z/kD1oS5hBT1AK4KfFtbbGAAfjoDqYWljqFGjPdCtKy3U
         ARCFXugFrOu6jv/+4UvEHla2+FygOrT98PgvZs3lhOpJuGckFf3ZOWY5uA8rH/kWwK/E
         eTcajbiQX++7nGzYg6PBwiDectPxxgaMPYQx5ey7QEbdPEh3b7+8ofCg9zccAskY31lP
         NG61wtMajIYh1n/hFw5a/X3wtWNG9STjr/q9CpaF/y3rf/J/F50SpQKhxcmALj4bItp0
         2GOt7Hh49cy7qet6cv8etPg5M1eyqzBkK5eu8N7Q3mTbF7RKqhGaTAfdbyml88awhNLr
         LrdA==
X-Gm-Message-State: APjAAAX9BqRDQtAJdGSMMz22HVuqZbophxwY0JbBLkAhrNBuwMN5z451
        dTVRXIDvgTc6Rdy15n2sYbbL1Cna
X-Google-Smtp-Source: APXvYqx6HvQOmnq+2+3Azg5RNCFrBwPdE9KmXyXg0c5OpzjqRwxCFR9VG15Tvt6aW2UroZdVivq95Q==
X-Received: by 2002:adf:ea12:: with SMTP id q18mr13105508wrm.378.1569837335816;
        Mon, 30 Sep 2019 02:55:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u4sm22459525wmg.41.2019.09.30.02.55.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 02:55:35 -0700 (PDT)
Date:   Mon, 30 Sep 2019 02:55:35 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Sep 2019 09:55:23 GMT
Message-Id: <1f2245a228e1e1a9b6f0bb70f8f6987af2140182.1569837329.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.v2.git.gitgitgadget@gmail.com>
References: <pull.288.git.gitgitgadget@gmail.com>
        <pull.288.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 07/13] msvc: work around a bug in GetEnvironmentVariable()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The return value of that function is 0 both for variables that are
unset, as well as for variables whose values are empty. To discern those
two cases, one has to call `GetLastError()`, whose return value is
`ERROR_ENVVAR_NOT_FOUND` and `ERROR_SUCCESS`, respectively.

Except that it is not actually set to `ERROR_SUCCESS` in the latter
case, apparently, but the last error value seems to be simply unchanged.

To work around this, let's just re-set the last error value just before
inspecting the environment variable.

This fixes a problem that triggers failures in t3301-notes.sh (where we
try to override config settings by passing empty values for certain
environment variables).

This problem is hidden in the MINGW build by the fact that older
MSVC runtimes (such as the one used by MINGW builds) have a `calloc()`
that re-sets the last error value in case of success, while newer
runtimes set the error value only if `NULL` is returned by that
function.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 4891789771..7d8cb814ba 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1661,6 +1661,8 @@ char *mingw_getenv(const char *name)
 	if (!w_key)
 		die("Out of memory, (tried to allocate %u wchar_t's)", len_key);
 	xutftowcs(w_key, name, len_key);
+	/* GetEnvironmentVariableW() only sets the last error upon failure */
+	SetLastError(ERROR_SUCCESS);
 	len_value = GetEnvironmentVariableW(w_key, w_value, ARRAY_SIZE(w_value));
 	if (!len_value && GetLastError() == ERROR_ENVVAR_NOT_FOUND) {
 		free(w_key);
-- 
gitgitgadget

