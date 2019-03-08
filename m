Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 206E920248
	for <e@80x24.org>; Fri,  8 Mar 2019 21:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfCHVzr (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 16:55:47 -0500
Received: from mail-ot1-f74.google.com ([209.85.210.74]:43278 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfCHVzq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 16:55:46 -0500
Received: by mail-ot1-f74.google.com with SMTP id r13so9567922otn.10
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 13:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UWi58aZRxQ8bSE3rNvDWEMF7TWiZqIKsWnzqCy604Sc=;
        b=GckAaajtJIkvCfHx5+rBHDHIiMxM+w1nrq5/JizEXYlOpYea95G13yLgguLm+2kDU1
         oBOwFNWR/x9GO92QKF64TeNFZDleONorzAj2CkikyYPALrkVjeQ5jRy/KpSa5UlvAREN
         9s9GqTjxVmZCZdUYepwJwdiEdmjc1xe+Sd8XZwAkDDR+WwBAWn8JeWnfRJjvchv4l3dM
         xrEe8eHSwG7PVkhVy2wdju5ufViZEcH1iKMJDdDDRe+CPjBzvbeQQZyiGRo1D5DrMoi8
         gPiwj85MBN5fWsaFrMTtErKJehc9mvwcNunYKULVir6PydeFDfjJ1JYrurYLGp71XSYH
         NrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UWi58aZRxQ8bSE3rNvDWEMF7TWiZqIKsWnzqCy604Sc=;
        b=tQ6KieCvW0SWzVigs/QXdT9So/WSzJoBNj7g4lKu3p3nI2uPervV3YEav7U8pasfNM
         FlYt5JYXg0rdOIwblkYdxx008ipU+oRXI9uxvUUmiNmuQvUxzilhWAbUhh7FriIshxPC
         8E9AXQTjZt/NJ/aOJsMNwG+rTlpvFM3FzgEzSJZYK2ifAGBPREcv4Q37js0/dwOtEHx1
         ddQaQutNo5+jx/H4PGdpSW2VcnAcTHhGu9jMIwLQp2poTAxmmO3rbmt/05rH+FrXY2A2
         4qpuuMmD7CElcG41wRDTGcsYrYlGCYFX9eyQpEbsLEJkYOhVQ7eYKX6MMcQdqGXp6RH3
         Nf0g==
X-Gm-Message-State: APjAAAWbBrCcFnejq8k456UwuQOoCA6PBqNMaqBc5O1i5Fcgz0bY6t/y
        Wf3FLCC02I8hOjIxivKv7YfSfPr0rtQhm0oCGwrn
X-Google-Smtp-Source: APXvYqzga5saOtyCl2/3HAk7BBsNAB5Qsbl21iw0w1j+ShdWNjzKab1tGSGhkJGVG9LLRyHriW2cg1gXWKysnSJKP2F4
X-Received: by 2002:a9d:635a:: with SMTP id y26mr11509933otk.53.1552082145410;
 Fri, 08 Mar 2019 13:55:45 -0800 (PST)
Date:   Fri,  8 Mar 2019 13:55:16 -0800
In-Reply-To: <cover.1552073690.git.jonathantanmy@google.com>
Message-Id: <2e0f2daba00f02500921dc3e3f15a301ee831858.1552073690.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1550963965.git.jonathantanmy@google.com> <cover.1552073690.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH v2 4/8] Documentation: order protocol v2 sections
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current C Git implementation expects Git servers to follow a
specific order of sections when transmitting protocol v2 responses, but
this is not explicit in the documentation. Make the order explicit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/protocol-v2.txt | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index ead85ce35c..36239ec7e9 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -325,11 +325,11 @@ included in the client's request:
 
 The response of `fetch` is broken into a number of sections separated by
 delimiter packets (0001), with each section beginning with its section
-header.
+header. Most sections are sent only when the packfile is sent.
 
-    output = *section
-    section = (acknowledgments | shallow-info | wanted-refs | packfile)
-	      (flush-pkt | delim-pkt)
+    output = acknowledgements flush-pkt |
+	     [acknowledgments delim-pkt] [shallow-info delim-pkt]
+	     [wanted-refs delim-pkt] packfile flush-pkt
 
     acknowledgments = PKT-LINE("acknowledgments" LF)
 		      (nak | *ack)
@@ -351,9 +351,10 @@ header.
 	       *PKT-LINE(%x01-03 *%x00-ff)
 
     acknowledgments section
-	* If the client determines that it is finished with negotiations
-	  by sending a "done" line, the acknowledgments sections MUST be
-	  omitted from the server's response.
+	* If the client determines that it is finished with negotiations by
+	  sending a "done" line (thus requiring the server to send a packfile),
+	  the acknowledgments sections MUST be omitted from the server's
+	  response.
 
 	* Always begins with the section header "acknowledgments"
 
@@ -404,9 +405,6 @@ header.
 	  which the client has not indicated was shallow as a part of
 	  its request.
 
-	* This section is only included if a packfile section is also
-	  included in the response.
-
     wanted-refs section
 	* This section is only included if the client has requested a
 	  ref using a 'want-ref' line and if a packfile section is also
-- 
2.19.0.271.gfe8321ec05.dirty

