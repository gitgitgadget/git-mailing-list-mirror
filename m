Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3867202BB
	for <e@80x24.org>; Mon, 25 Mar 2019 21:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbfCYVlp (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 17:41:45 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:41127 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729610AbfCYVlk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 17:41:40 -0400
Received: by mail-ed1-f46.google.com with SMTP id a25so8922644edc.8
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 14:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=da/HSW4+1VPmWwKyllg85/MvzYldCPPFKu7DQay8fw4=;
        b=KYV8Buqbn9HlHtnXcr0csZxQuWsVuA63Me+O6hJdLjJJGielq7bxygP6PVctGuXg5Z
         9ClndLJWNiaPfopg85I8978ZGFqu30yyeY8liob5ej3eGmZP4Z83RNzMnyw1WNStXMe1
         CJX+MgHg5EyG4S2PuAivmK0lQMXlfX8se7f5WBv6SZ4WHFvA6t33ESLZMoKrSqy+kdrI
         +Nkbsy/MoU1o0abDoTLe59fSL/T+1M9XbJM1HrjL3DNcvsXy7zIlvIPlwdeD+2xjihwL
         DJ3ipfjOZR/Yi0Tzj0nZQ6sYe8vFGsw7GFhGyEI8ONOIlm3+C9kN4/y7w9dOR/miHGWf
         RjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=da/HSW4+1VPmWwKyllg85/MvzYldCPPFKu7DQay8fw4=;
        b=hRWh3//m7CNTBispv2idNRFWpGgjO3B80MNEU7P66GE9Z7cpZYyVzGAFqYQPyx63+z
         oA17EoPnXJH0QGGuBw/mjYQehAy+5U2KDg7uOteM8hclXivMWu4R78LnVk14nD+PcsqQ
         v4/FE6p81ksbOvgU9bkankrUUafWaC0S48So+2yEw9BbgQe7dXGRFjyEb2ZiMlXcpSnm
         wUfhQzqnvon0WiDryVJFC9JeiizloaNil6Xgrj7J4gI7U3nUwR1K1Z22x3BqwvF3890M
         tw332qCMaDggrEJBpuiOO6lI2IoD9DfgbBJGfO4sgP4sWsSGpfKm7oIsNCJ0INRRz+x0
         gHvw==
X-Gm-Message-State: APjAAAWHJ3pSXfpOIUW1U7aDAvyPo5qbWxdzyVtCqHcbDiXR6Bqd043i
        dgT8jXIi75c7SXAnqLxHQ2mLNJnC
X-Google-Smtp-Source: APXvYqwb7g9kKjj+4/2l77UZ7I1vJwPUuzyiu9Unfyaoi59BPZE/IbsyVH4AeRCvTprxPxFaxegBZQ==
X-Received: by 2002:a17:906:4d85:: with SMTP id s5mr10699661eju.18.1553550098914;
        Mon, 25 Mar 2019 14:41:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v1sm3739582eja.7.2019.03.25.14.41.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 14:41:38 -0700 (PDT)
Date:   Mon, 25 Mar 2019 14:41:38 -0700 (PDT)
X-Google-Original-Date: Mon, 25 Mar 2019 21:41:33 GMT
Message-Id: <1097be76787a9c73e82000dd7939580c5d980d70.1553550094.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.162.v2.git.gitgitgadget@gmail.com>
References: <pull.162.git.gitgitgadget@gmail.com>
        <pull.162.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 4/5] check-docs: do not expect guide pages to correspond to
 commands
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When we want to see what commands are listed in `command-list.txt` but
not installed, we currently include lines that refer to guides, e.g.
`gitattributes` or `gitcli`.

Let's not include those lines, as they are not referring to commands.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 76904f07fe..c7b884cd38 100644
--- a/Makefile
+++ b/Makefile
@@ -3095,6 +3095,7 @@ check-docs::
 	( \
 		sed -e '1,/^### command list/d' \
 		    -e '/^#/d' \
+		    -e '/guide$$/d' \
 		    -e 's/[ 	].*//' \
 		    -e 's/^/listed /' command-list.txt; \
 		$(MAKE) -C Documentation print-man1 | \
-- 
gitgitgadget

