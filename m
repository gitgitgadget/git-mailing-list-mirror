Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CA011F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 14:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390133AbfJYONl (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 10:13:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51897 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfJYONj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 10:13:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id q70so2324399wme.1
        for <git@vger.kernel.org>; Fri, 25 Oct 2019 07:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yHzDynbjsCiXFV/kKp1mWEXKmYwehPsSAdfvuYZ+duM=;
        b=SDJ2sl/foBwqkyQZ/XzpL5SpVKnYBd9TKSgbbaqz2bFIxTeZJUcOJOztZOV8EhTofq
         GUk3ViGr+PbHGTCS3HpFcLhMhiO3k3tpsp/bJXJVP/1aojlmz6TRGljffrvhKNeXLBqP
         fI6hmt45KNjTi95ssyMgvGy0vGsh4kbW+2ibamOM3IbLydxLd+I7dHHzvmuc9sqx/mhg
         qVggCKcTlcYe1eKTNH2XwrykaAQHtuAYgMgVW7HpFbfa/elMbIqMRaTjDED5sOt+VsEm
         H9N1LJ5xSJSidZRLjca2oULXNjZ4vfGnQSzpzKottkTPLkMkiUrlHsPgEL3WGt7RrEC8
         xrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yHzDynbjsCiXFV/kKp1mWEXKmYwehPsSAdfvuYZ+duM=;
        b=YIaLq5x21SQLDe2ZtHA07tjUi8Z6TRTZk/vsjOljNP94OnSTwza1TJ2a0T+H8R/K6e
         6M8c2q9aUmtcq9uYV6IuDXEYYhKtKedAZE3gKkHwWYxKRCri9/1B28ZxpmGSrB2pgYhA
         Rt+HwkxYAaTEyoWvlMjCra89pg8QY/4FXcajiMrBrsycxXS/ZD1CLjwrBJzGlgzsJcTP
         WDIcB7mc7ljSM7rtNSog8HOH4DU4jMaY6UsiGr0UEftAnT6d9wCV8G7XEYwLl40cSzcm
         FWCQuoXMLIbzN1NOUXn2Fxl9tBfRkN59rlmwWUvo6rUxT/Jq0w94o6KX/a8bK6UToYYO
         Df+g==
X-Gm-Message-State: APjAAAXKvX5XEnkjG3zOPFkeMJFJ2CY0q3hO8/wB3+wKgt56+Tqgy/Ll
        H+Xg+rFxVmjAw968v/oXXpSG7CWk
X-Google-Smtp-Source: APXvYqwxFDtgZjLoUjUzDXXVdHXJe9MZiUxPoAl0eXI0hNsQphp+8y/s2MLpJxY3y0ZNag5rznakqQ==
X-Received: by 2002:a7b:c846:: with SMTP id c6mr3936063wml.68.1572012817982;
        Fri, 25 Oct 2019 07:13:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o1sm1877682wmc.38.2019.10.25.07.13.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 07:13:37 -0700 (PDT)
Message-Id: <aaf7bfc54572c6a3cd00eb2034c07a7bf57835fe.1572012816.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.427.git.1572012816.gitgitgadget@gmail.com>
References: <pull.427.git.1572012816.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Oct 2019 14:13:36 +0000
Subject: [PATCH 1/1] mingw: avoid a buffer overrun in `needs_hiding()`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When this function is passed a path with a trailing slash, it runs right
over the end of that path.

Let's fix this.

Co-authored-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 6b765d936c..fe609239dd 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -363,6 +363,8 @@ static inline int needs_hiding(const char *path)
 			/* ignore trailing slashes */
 			if (*path)
 				basename = path;
+			else
+				break;
 		}
 
 	if (hide_dotfiles == HIDE_DOTFILES_TRUE)
-- 
gitgitgadget
