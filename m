Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C71DF1F45F
	for <e@80x24.org>; Fri, 10 May 2019 19:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfEJTo2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 15:44:28 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45861 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbfEJTo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 15:44:28 -0400
Received: by mail-ed1-f66.google.com with SMTP id g57so6557337edc.12
        for <git@vger.kernel.org>; Fri, 10 May 2019 12:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=Mys42i6mZ4z5yd64zI5WIaeuh33J2uZ47C/NFqroR9A=;
        b=B26pJBMkDhxpXgjs2kwgOIwNaMVJ89zCy+IwvGGJ2kupo4pSxXy4HZvUeXH3gqBVM/
         QiMJy/QX+WqnmWRJXpD3/I9waZGOk5C7P0ufuGM5M/cQCUF3DUhCgb2q/p1OffflOvk0
         PMFtM6qweFOjY0aYLLaVbUilklUdDoO5GjsR2XK/4m52zSeEZGkXVwDGY1hBQQXYBUNq
         OWFy7Ts+hqljbtC3cK4aIRgDgBfond/JEo5+uVncQ+kNTn+7awkj6atabJrV6UABOXmI
         8hf22QPt2jOwNckqStBdgo0yZ4ADXVlH4U38tQbg/Idzu+LGe5FfzlQmnounV9GAUB/q
         ZnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:to:cc;
        bh=Mys42i6mZ4z5yd64zI5WIaeuh33J2uZ47C/NFqroR9A=;
        b=uJuncZyaWNpJaGhz2tPc15LwDnPBhiA6/Z1D+Ux8alxUx/01yY8hnd0Phkf6/cr1gV
         15AMoCUrBh9hWCH+bjfRtDWheIQvxx72JXZdb2vDU19rulEEJvnnP7iauuhnLw5/XARj
         9V0gbm1T5bM9502UrHdWpmNLXzXmRNiKnqmJs3nMUqO8HifVWp0ZWH2bc4r0I1/JmvWp
         Cg7Vy6AmkqnbBCyfc5hmMw2NeBBIcWS4qtdN7udJ3xNCWfBpHQ2QxsEqBiZpJMxjXxQr
         v9xlpUTFNdTkq6D9KjjfaoC3x3C2/FCX2sAhwzwRIFngnbZLzROlL2uxIlJcj2PV6NCx
         9/Lw==
X-Gm-Message-State: APjAAAX23X+meWSw36FEOB6C0p9+4XMWMXtXd2edaqVt4GjIG3wM7SeZ
        uRD7EniLnoVNyHkVl35u6oy4ih/X
X-Google-Smtp-Source: APXvYqyUwqnpw3A47ldyF85z8mpI9OMVCkerPqN7XwUvplWRKBT77RGmk5CC06T5qfUb0K3qKt55uw==
X-Received: by 2002:a50:b557:: with SMTP id z23mr13450789edd.154.1557517466557;
        Fri, 10 May 2019 12:44:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b42sm1677236edd.83.2019.05.10.12.44.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 12:44:26 -0700 (PDT)
Date:   Fri, 10 May 2019 12:44:26 -0700 (PDT)
X-Google-Original-Date: Fri, 10 May 2019 19:44:24 GMT
Message-Id: <768bdf1c210fd34776f667b080a23eb6f9e17125.1557517464.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.189.git.gitgitgadget@gmail.com>
References: <pull.189.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] trace2: Add variable description to git.txt
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, git@jeffhostetler.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Documentation/technical/api-trace2.txt contains the full details
of the trace2 API and the GIT_TR2* environment variables. However,
most environment variables are included in Documentation/git.txt,
including the GIT_TRACE* variables.

Add a brief description of the GIT_TR2* variables with links to
the full technical details. The biggest difference from the
original variables is that we can specify a Unix Domain Socket.
Mention this difference, but leave the details to the technical
documents.

Reported-by: Szeder Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 00156d64aa..e802886999 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -661,6 +661,27 @@ of clones and fetches.
 	When a curl trace is enabled (see `GIT_TRACE_CURL` above), do not dump
 	data (that is, only dump info lines and headers).
 
+`GIT_TR2`::
+	Enables more detailed trace messages from the "trace2" library.
+	Output from `GIT_TR2` is a simple text-based format for human
+	readability.
++
+The `GIT_TR2` variables can take many values. Any value available to
+the `GIT_TRACE` variables is also available to `GIT_TR2`. The `GIT_TR2`
+variables can also specify a Unix Domain Socket. See
+link:technical/api-trace2.html[Trace2 documentation] for full details.
+
+`GIT_TR2_EVENT`::
+	This setting writes a JSON-based format that is suited for machine
+	interpretation. See link:technical/api-trace2.html[Trace2 documentation]
+	for full details.
+
+`GIT_TR2_PERF`::
+	In addition to the text-based messages available in `GIT_TR2`, this
+	setting writes a column-based format for understanding nesting
+	regions. See link:technical/api-trace2.html[Trace2 documentation]
+	for full details.
+
 `GIT_REDACT_COOKIES`::
 	This can be set to a comma-separated list of strings. When a curl trace
 	is enabled (see `GIT_TRACE_CURL` above), whenever a "Cookies:" header
-- 
gitgitgadget
