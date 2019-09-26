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
	by dcvr.yhbt.net (Postfix) with ESMTP id B7F261F463
	for <e@80x24.org>; Thu, 26 Sep 2019 08:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfIZIaV (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 04:30:21 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45118 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbfIZIaT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 04:30:19 -0400
Received: by mail-lj1-f195.google.com with SMTP id q64so1203424ljb.12
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 01:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RVE9a0xIxOv1m/oHcTcIhY+O/HERoXxmdzKfXgJwF88=;
        b=EYp/snAp4QcGcUQM6qkIOnI5eqMV6O/yDL5YpU8BePg1HSQgnY6wo3C03iTa8Be8JY
         yJNlhbY957Ogfv4Vm8wNRvSUQgiG8WtpIfzIUy4kN8Bb6h4Yfr80Pc4i+eE8Zu4f6W8k
         ruytie/lPrQj3FuT6dc6/goeEzwKzf+PfqQn7ccVo2zo3W674jB5VJZzG7U8B6pFKu0V
         PvcPReEDT0Rm/7qgJ12X7biFqrp4dGtH3ppZbzRpQDO+tT7KpATw3fMf7iee+jUCPGCZ
         njR7CyQyvrnQu+0LlS4EvutdSGvpmwfSmmYwaXtenbbXWh6Ov/zAvHjAQrVJA0mfEfxx
         AgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RVE9a0xIxOv1m/oHcTcIhY+O/HERoXxmdzKfXgJwF88=;
        b=GKEjkezZph1qx/663WfcsoMmpQItVwf1AiC1PsZ/9iKXzUro+yPeo+H2If9gamaGrL
         ojWtBUQ1kpspLhsZ4Vr26F2unGOe4P0Rf3roJ5tUNZIVK9ImPUTHF1tujPqHJ3Cb5BnJ
         4U9jrG5UD5G8XnIm2axg5p44ylA8supa0jRHZ8LLIhxRzpsS6m7iVq0BkdSatmCZlcjJ
         880MrRgX+KDguXnavZk/qXNlvoq5RKSYsnIPyVbYCNymBzrEzIFhAjlr/QJ7pdDFtpLT
         eXgUL/cWQLVj6DQzl1jlI/Ht/tOnuk6QNbaL2AM9SoeHKRDk6ssoSgnwycH0elKU0fKf
         WDFw==
X-Gm-Message-State: APjAAAWe8zfYK+84lhkKkSk4UWpxBERNKhSn9xbhFc5bQ7SJ8+/YZ2RE
        gCTLGhxKv40M69Jpjy1XI20gWpmv
X-Google-Smtp-Source: APXvYqzu4lC6yoOWfXVEQrA7Xq+V2g78TCG1kYHFXNS5r+HeGxsFn2lpHpCIoHoLgXymRNAXe1vDbQ==
X-Received: by 2002:a2e:3e09:: with SMTP id l9mr1701329lja.215.1569486617467;
        Thu, 26 Sep 2019 01:30:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 196sm340572ljj.76.2019.09.26.01.30.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 01:30:17 -0700 (PDT)
Date:   Thu, 26 Sep 2019 01:30:17 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Sep 2019 08:30:00 GMT
Message-Id: <0590514e43a32a96de87f144439936b66d0723e6.1569486607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.git.gitgitgadget@gmail.com>
References: <pull.288.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 07/13] msvc: work around a bug in GetEnvironmentVariable()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
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

