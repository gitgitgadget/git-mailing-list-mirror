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
	by dcvr.yhbt.net (Postfix) with ESMTP id D67701F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 15:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389735AbfJDPJg (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 11:09:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40664 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389387AbfJDPJd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 11:09:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id b24so6231389wmj.5
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 08:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RVE9a0xIxOv1m/oHcTcIhY+O/HERoXxmdzKfXgJwF88=;
        b=c5tG1eUc2zoU50G0fFxpRyADv8PtgLGtPdMH8VvBdWltYYwep19KbyfHw8Oxj+RduK
         /zg0thIW6yNpA+a6dd7I03hh86hCBpxqJZocJ2XLz4chouAn2CfqYbKX1cjw/80qBKZA
         rYWaCTBnU5PSqwrPlA0lhBihezdtcYJSScb1muNzVsWF1+isONBdymbpwoUVEQw1AhPI
         7R94uNp0qvC3u2yiqLOriEZV4KFJbZqr/yg96ajXpri8lpNWIWwscH0bSJduQX/Rtzko
         gj0rS6GR22+iAxLCvsVcm6DLq67OcJq1gFgFse7A72+8dfUvoJGm7a8qMYNeq/ImrBW8
         y7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RVE9a0xIxOv1m/oHcTcIhY+O/HERoXxmdzKfXgJwF88=;
        b=jkjGjyrzw/hCGLnHKQcUJpXp0WmiU0fVJ360X3CvOt7d6xJIcEq5SrNqy4gIhj6UI4
         TCOQYBQ+VRnkO/jYsr1mwzVrPj1QypOlAFC9NoDA3daP1BthJEfkEEQCJ/uIW6z9YPwj
         O8uaK86JXKkryLOqS1uuVnpqJrJGtwIsTdIXI0A9b9+LNwF+qOeYN8nLyX6pRjS7jV/6
         3A0i5DEb4ysIhPCglJfKDn8JT/iICddDMRKFhK4wHsnoqreSCUwcKESAnTbZfG7V+cnv
         7kh4TUHvJ/ZtykHG03iLV8ChQw5meTq8jDQzjxkn1lnwI8ekYXlg8dozpa9tj/aCn65I
         1KPQ==
X-Gm-Message-State: APjAAAVqBp7XEBJjpc5HvY5AHZzYNXSrinxb876KbMrtMbLINAUA9wuR
        +RWM2Ui13MuCdwCiPJYgGxXmp+ff
X-Google-Smtp-Source: APXvYqyAzFB9jKke9iB990zD7EK+C2lVuGA37g1wn/j9NqgIreQ6tkc8+Ee7y6ubddIfycRfq1VDhQ==
X-Received: by 2002:a1c:2d85:: with SMTP id t127mr11962453wmt.81.1570201771523;
        Fri, 04 Oct 2019 08:09:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o70sm4004884wme.29.2019.10.04.08.09.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 08:09:30 -0700 (PDT)
Date:   Fri, 04 Oct 2019 08:09:30 -0700 (PDT)
X-Google-Original-Date: Fri, 04 Oct 2019 15:09:16 GMT
Message-Id: <91b09cfdd8738f27009c86760d1e6a24a46017eb.1570201763.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.v3.git.gitgitgadget@gmail.com>
References: <pull.288.v2.git.gitgitgadget@gmail.com>
        <pull.288.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 07/13] msvc: work around a bug in GetEnvironmentVariable()
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

