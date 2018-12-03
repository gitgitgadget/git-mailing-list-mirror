Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B859211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 23:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbeLCXhr (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 18:37:47 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:46675 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbeLCXhq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 18:37:46 -0500
Received: by mail-pf1-f202.google.com with SMTP id h11so12481396pfj.13
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 15:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ur43xZWRloyiHiNXEcPnNN1YCs187IqiL32Jn2gt420=;
        b=HlZMIA0fc7WONlbQIk2Y81mHHrD12MMvVCQbvf4uBxjTfzgNbsmFIMnR2tiVAyoos6
         P4nnml6IEC0YB6/9eiAjHqnbp4kkyABNrFhJV8InvhS5u1n5uolN0JHSd5134Ky0wmvH
         8XxLpfqEy5ibfbOSlLM/1GN+fNI0/yyAJB4abmJDX6BjPUnij9MVUlXjDRebFQaVfYCi
         b+ObwN6z8mOhxmZo5okF1AvbU9W11H/w+EVK+loyQK9+za8hthAxg9vsXp0yovHcgMNS
         Xf/HMu7Hw4Vgit7Gv8FZnPEBJjHNVdp2bgHv4Qq5+SJMkwYkIeHNLuhnezqbSdwvDRh/
         gSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ur43xZWRloyiHiNXEcPnNN1YCs187IqiL32Jn2gt420=;
        b=FpHVx+gwHEqUeSvi71keH7kuMgUhsZ0n/qSkPJZ59DOfnJ/p26YbeXbSRWU6xJ0Y4e
         vDCWorA+4BZnv/CvCnBBJtd/+u3+IxuXcfqn3CBtKUkDcK4RWUhaGFheD5bCJ4RKkhnB
         r+1s73AxL5mW1cjAPhBvlxNZFVJisbOntlr0359D/ltqXUxNR2FGglH8/P2088qq5eTW
         5HqDHrleqTpXRBZl6iLSSAaFx8qIkSWX7BPe0PIx+mLgZ11ZEWLcoEtvyGHILAP0SN0n
         /L/n536OKTZnk3ziTx4ux5tD+MAfa334ziUw1vL5qhi1cL3UwgoszLqkWs3Wurj9SSQD
         bYog==
X-Gm-Message-State: AA+aEWYrk7n1WXAknBxTQFhps3hapKypPkWnX5GKdx48pSBXm1PIflmQ
        dY/1PJGumM2B9YyIiooi1iWhtb7ghA+Z9izIWH2QpwePrRDd5JHR1OXs+H/wjPmIWnlGkNSswTE
        FHF13I3Ri1uAF8kRQYttK2WZT186uQJ9hJ9PjkuUMSgcnVKb4Fm5NBpOj4xyMoLJMx9ji6epqFl
        s+
X-Google-Smtp-Source: AFSGD/XjjuTRTmC76J4KU3JSQTgieRJ0IibQqXl5UqffvMLzO11a323f3hRKzmcySFNc+bQxKXZuij6l5w4jyzVXzcrg
X-Received: by 2002:a63:6dc4:: with SMTP id i187mr8119221pgc.105.1543880265782;
 Mon, 03 Dec 2018 15:37:45 -0800 (PST)
Date:   Mon,  3 Dec 2018 15:37:34 -0800
In-Reply-To: <cover.1543879256.git.jonathantanmy@google.com>
Message-Id: <061dacf51763bd2f72b95c382e08f44655e247a7.1543879256.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1543879256.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [WIP RFC 1/5] Documentation: order protocol v2 sections
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git command line expects Git servers to follow a specific order of
sections when transmitting protocol v2 responses, but this is not
explicit in the documentation. Make the order explicit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/technical/protocol-v2.txt | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 09e4e0273f..345c00e08c 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -309,11 +309,11 @@ the 'wanted-refs' section in the server's response as explained below.
 
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
@@ -335,9 +335,10 @@ header.
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
 
@@ -388,9 +389,6 @@ header.
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

