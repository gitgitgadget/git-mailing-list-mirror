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
	by dcvr.yhbt.net (Postfix) with ESMTP id AE1871F463
	for <e@80x24.org>; Thu, 26 Sep 2019 08:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfIZIaQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 04:30:16 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38393 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbfIZIaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 04:30:16 -0400
Received: by mail-lj1-f196.google.com with SMTP id b20so1232442ljj.5
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 01:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PwAFlDQ5FlWkf4x5wuYtwAm/soXttcp6NKf0ywJLbFQ=;
        b=lNEFpOsMiV4i2QOP2eCUsE5bqtpDB98teMW1lAH2ebJXhmJiSVTntzofuHF2tuK2ls
         TvNBt8kX6sIGXHPaEf1YqkyEWznLHbiL5HCnPmkZXa8Mt36AiWlr08VRrn02X7K+xESa
         QG4MIEzlOkr7uWzahnTSQ6TeQ1nbK0y2OQh8uLrnu878YyfBRAZnLFDlklh52/VeUIvd
         +YYiayO74XxfwXmlwYIMNdK+njidqjQ0mXLjR+zDC7Z51dxXcxqkZpeCsETVauca2pAk
         wBySIJsUsqC6oAGdn4ylNJwYtJUZVtCvxkvUzHmmIcB+Gr+vYhl4ABCvduL775lQkbeG
         DBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PwAFlDQ5FlWkf4x5wuYtwAm/soXttcp6NKf0ywJLbFQ=;
        b=aB2bOrbI3JtXgI+DaOXiS88ggZXbZUkffdCzuWrlP36MKR/RDIujopJ32pvts1efaT
         9rbmV/nJktQPd6XnthvMniWAQKfeldfzHbG+NLv/P5UBSvja0oa2jMLg42JrSC20UTQO
         bQ/0KksvkL6gWVlKl90Gz+WkoP/QntUYkvt1a96SzJfbwGxu8CS2wdXX4TunTRM8IU5f
         kDUOITEqM87JVQumcM5Hkzc7VHST10OrBDxZiYijG2Y7LsRYWmKMmOia7mKiTqQ15sLT
         h/qkTnl0L8f2Hzw/TyLJ6A72igpcqFGqyGvcTPtWyIOZn7eqeFqIr4WOhM0tlRIS3lQP
         59hQ==
X-Gm-Message-State: APjAAAWhrRRLCnGGvxKJ6JXrfb0/DynTWgAZkcDUD9Qm04LDdQne8ZU2
        w0CCOPyXn6Q6QN4wPhZXWDZWNTSO
X-Google-Smtp-Source: APXvYqy10PE5eU3QitC7CojplyYJRDFKU6nE4USLbzabSp+Uq8L5+2Rweq3JGJL23uEvUMoDVr3zGA==
X-Received: by 2002:a2e:80d3:: with SMTP id r19mr1701655ljg.41.1569486613657;
        Thu, 26 Sep 2019 01:30:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q24sm411836ljj.6.2019.09.26.01.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 01:30:13 -0700 (PDT)
Date:   Thu, 26 Sep 2019 01:30:13 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Sep 2019 08:29:57 GMT
Message-Id: <6417d6f68953f0d7530e6c61bdd09348adade088.1569486607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.git.gitgitgadget@gmail.com>
References: <pull.288.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 04/13] compat/win32/path-utils.h: add #include guards
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

This adds the common guards that allow headers to be #include'd multiple
times.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/win32/path-utils.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/compat/win32/path-utils.h b/compat/win32/path-utils.h
index 0f70d43920..8ed062a6b7 100644
--- a/compat/win32/path-utils.h
+++ b/compat/win32/path-utils.h
@@ -1,3 +1,6 @@
+#ifndef WIN32_PATH_UTILS_H
+#define WIN32_PATH_UTILS_H
+
 #define has_dos_drive_prefix(path) \
 	(isalpha(*(path)) && (path)[1] == ':' ? 2 : 0)
 int win32_skip_dos_drive_prefix(char **path);
@@ -18,3 +21,5 @@ static inline char *win32_find_last_dir_sep(const char *path)
 #define find_last_dir_sep win32_find_last_dir_sep
 int win32_offset_1st_component(const char *path);
 #define offset_1st_component win32_offset_1st_component
+
+#endif
-- 
gitgitgadget

