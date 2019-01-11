Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2851211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 22:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfAKWSt (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 17:18:49 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:59892 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfAKWSt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 17:18:49 -0500
Received: by mail-it1-f202.google.com with SMTP id t143so3434071itc.9
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 14:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AzD2Oa7ggtjnDkmZ1k8bM8FTJ9o6vAOnxmwmhxXUOx0=;
        b=WqaeiZ8WXyy+4XzgV0jS78CzQsmnQk+PWrCFyQPnHbmLDzh2y8fxOW5915QxQ4vcap
         QX/QrXKZcDtq8GpI0yq4YjZFkbO5g2TDfiSAsD47IvUZxdbpq5oq4b6VimuJQKtXrbFw
         mU6psWVbvJ/ulITwCQ79C5soAPe2nSdlGXHMambeyqUBJLY5M4NrMj7K5ev4/3cn9zVm
         Q+pEBEf9vuBTO5imvcuHAPngkdLAClJGKf/RcUgPKN6LfLa0BUmygFyjiVwfRDSh+HAP
         akFdLsfjrJ3nnJ4C2r57N3998VQGR+fRvJHKpPB2RMHpFGYOuWPjbmJQZSdJKdzLe1bC
         2yrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AzD2Oa7ggtjnDkmZ1k8bM8FTJ9o6vAOnxmwmhxXUOx0=;
        b=Dq9b0DyZsthdT9Mt1MIWeLqiUnDSChILkTQ6JgOy0Xs2Xne6+Q52jr/D/diTybjCbn
         dnBfwHwhmByg12EBgUNrZAFwstHdl+v3RMUxJcoeFdR7KhHo2cWLiIDENZ1kIi/iJoIe
         UIo89HHWwneyh+gA7CF+ncvs2fO2p4hHCjSUUaR+aAnfeiBsUn2l8ruElrc1wRRBjjv3
         TmAh2vHbx7kX+ELO4+pdn4DY1Wf0CIl96crHFdZUjMiSSRnMwYcYOqH1c8BCVEG8sYXQ
         IWmvHUuatlNxg7WMPb2ifxfaoNuDVgbrGRHbWe7grmwcHUw7kR50hu6MrWfZtw9khqYh
         yuiA==
X-Gm-Message-State: AJcUukfgB8Rj5ZyHuY4deQ4eZRsBsc/L3uFo3QJrRcTIE17jZcUAO/kD
        EyaIfbfJIuQ/z2xT8qUKA8R59jPGtAujMyGILv8PNkOI4WPUXer0dB1NRT1JgjwTx6cnW/B4Qx+
        fyogi6kcJ25e6c1pm9AmPFZI7m7Gml1J+JBcSs0UspsMRHKSFAS0Z8nCtFK/G2WHMVFuTSV4igX
        NU
X-Google-Smtp-Source: ALg8bN4npS9PCgGSDYHJINjr2a37U8Ka7VQ9oM7Ve6wXYgTKacTesMe8C+EyNja62YsyrhPsfw8zaQKVyKXMLR9UTTyQ
X-Received: by 2002:a24:5411:: with SMTP id t17mr1471404ita.10.1547245128345;
 Fri, 11 Jan 2019 14:18:48 -0800 (PST)
Date:   Fri, 11 Jan 2019 14:18:18 -0800
In-Reply-To: <cover.1547244620.git.jonathantanmy@google.com>
Message-Id: <7e5d8a6ba3ae4211e18973f1549986c2e7640c82.1547244620.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1547244620.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [WIP 5/4] Documentation: order protocol v2 sections
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
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
index 1b0633f59f..c76f2311c2 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -319,11 +319,11 @@ included in the client's request:
 
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
@@ -345,9 +345,10 @@ header.
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
 
@@ -398,9 +399,6 @@ header.
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

