Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D95D202AA
	for <e@80x24.org>; Sat, 23 Feb 2019 23:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfBWXjP (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 18:39:15 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:38674 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfBWXjP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 18:39:15 -0500
Received: by mail-qt1-f202.google.com with SMTP id 35so5864923qtq.5
        for <git@vger.kernel.org>; Sat, 23 Feb 2019 15:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Z2zGuw9aQZisw8t6yp0DQLtiO1vIHYJFhFDRGKycjUU=;
        b=r9DyZxXzMbs5A14tAhmxMmUu1/LY/Xy5Qi71HnpcLWnOOa8AfBSUN1JcNRZxNghihr
         eO6YDZGujopCi7wlDGlpuJKDXr7yivktE3stDTxyXNFNys+y3vNnPa2LaVaQr0O19tzl
         1ALmjtoSyKcL7LrrOQKp1dJs8SOzaKJjMidU30a5l2My7dU3b9kiR9YvjS5GJEKtRSaj
         6IQ31w9mN5c0PglfeerdhuwX1U+RzCk5f8dp4ioPNHHB9pYA4a+vhP9IgywybAVyJKF5
         BEJAqirTRWzsyVNVOvGhX9NLmrRKFCovV5DBbKKKostNbqmLzeQMVc3cy8xUggPGCI3W
         apqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z2zGuw9aQZisw8t6yp0DQLtiO1vIHYJFhFDRGKycjUU=;
        b=qmnfB/RK4yCykbDYlNPXC3JA8hkSjEbNWNi+5fNtjxgyuugmdwimv9jwKGajdMsPIE
         K56TkyxkhAQA6r06EPaHAQruVRdRXNIw6C6K0hq+B2QZc3n4jomUhSQV8TbEEzghHKl0
         6fL7MyczCTSqZhUrG2vxi0DdHqNDHUUct+IG+MZStrnomKZ2l68HxqlqvCRKH6lnGRHu
         8FCPRzEP/X9xAmRTz5LO7msNoG3ab7CU1kxmGbahytF+Rw16viVBwklOQm6u/Jb1MuRt
         psx9tlpFTNVcmRS4+4PX8q2GjcB5y9s5yN+oDVPJzltvmmE9N+VhbM+YNjpsDaaHF3HY
         3Byg==
X-Gm-Message-State: AHQUAuZcc9C048ZyzTnJKb6bzdud98OBfr8PeauxQTN0rxrgyObJZYSV
        pv+zd3ZsX0Za0xxZiYq5BWKmltdBGxl8I9C77dlDrmGABsfbkJhjLIYb7k3hMRb823srCWwZBR3
        OFBzfrKdnPs94zsScZXgeQxFumWk/q1OCoa9xnfmMMvQ7lVIVheqm/7FX/9z2zjUJqNMb0am7cZ
        PQ
X-Google-Smtp-Source: AHgI3IZYxPoIZztF42b0QZ4ZGooS8J1+eYaz1v595zD2x2wEcpJEJ9RcwrEzuLBmH4xs8nIhDdLzuQvcG/pBmMTTmusY
X-Received: by 2002:a37:9a4c:: with SMTP id c73mr6788795qke.50.1550965154046;
 Sat, 23 Feb 2019 15:39:14 -0800 (PST)
Date:   Sat, 23 Feb 2019 15:38:58 -0800
In-Reply-To: <cover.1550963965.git.jonathantanmy@google.com>
Message-Id: <bcef27b18abd7c3632df7f1efb25255ada492fa2.1550963965.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1550963965.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [WIP 4/7] Documentation: order protocol v2 sections
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net, christian.couder@gmail.com, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current C Git implementation expects Git servers to follow a
specific order of sections when transmitting protocol v2 responses, but
this is not explicit in the documentation. Make the order explicit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
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

