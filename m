Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83C25201C8
	for <e@80x24.org>; Fri, 10 Nov 2017 15:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752852AbdKJPDf (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 10:03:35 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:54917 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750978AbdKJPDe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 10:03:34 -0500
Received: by mail-wr0-f196.google.com with SMTP id l22so8832423wrc.11
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 07:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0LhCGhed7NUNoSPppyYA50qp/qdPrA1u47G3dm5xTy0=;
        b=u8X0Hefzv4P5K23VQArDBmzrIeR+SbkGiTvPUGNc/fqx1OY7/cA5qfZcUwYoR176op
         8KW55qs6CNX0dpbRyF2tdj41IZhb+JwMlNQuOfaGIEbXw2gJrUq+Wwk/pa9MYY9SkYm5
         fQmE7hKffmLhee0mCUjZSI4mzCvBgOSn5I/0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0LhCGhed7NUNoSPppyYA50qp/qdPrA1u47G3dm5xTy0=;
        b=RlsEFW/bcUPedRu8NwbU+L8VWhHcli50HDk+wBPVR3WxvpSgCYGj4taDr4Aw+otOns
         SWIiBxdWlpji/lNSN/DLpkOSrxTUyHbcvHnURgt7zPiu/Eu1BaRwivCy1djkP2Jndwz4
         ETNMQRNGwAugkwHJGKqVqlJPriuRSpvCkPhE4S1AD1R7JT9bQp1H9cEMlC5ZPqTw329/
         gE+BJ0QpBnXFcCBSCleAxPCrHxmjMO/Ah55ZmBD5sELJLrVk1kFkHhrVBNK9XhAI5Ij2
         zGRIY12HGJoLxeW93thXCTGrwLngMnIJQtRqFlAI2Het15mPkj7URqtM0ZOa5oz4Arzg
         NYEA==
X-Gm-Message-State: AJaThX47ZEAM19MzctY9DFCRTTRSnCEjdlspHb/fjwkMM6vx5kTufEeX
        UtDA0THke/pLKGRuCR6CSQB1HU5ErbQ=
X-Google-Smtp-Source: AGs4zMYzMV/F8Or4wLBZLVmzEJWejhnUsytQl2eMXVJA6/jAuqKsJkZSLq4i9gF60UbEMIduKP8i5g==
X-Received: by 10.223.133.214 with SMTP id 22mr563721wru.23.1510326212653;
        Fri, 10 Nov 2017 07:03:32 -0800 (PST)
Received: from PC5175.ad.datcon.co.uk ([2620:104:4001:73:95fd:45eb:d55f:fbf8])
        by smtp.gmail.com with ESMTPSA id q124sm2688537wmg.18.2017.11.10.07.03.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Nov 2017 07:03:31 -0800 (PST)
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH v4] doc/SubmittingPatches: correct subject guidance
Date:   Fri, 10 Nov 2017 15:02:50 +0000
Message-Id: <20171110150250.8896-1-adam@dinwoodie.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <CAPig+cRADknKB7KxqcZVinwP9vmGh1tmUrySUND3hMTi7a+bag@mail.gmail.com>
References: <CAPig+cRADknKB7KxqcZVinwP9vmGh1tmUrySUND3hMTi7a+bag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The examples and common practice for adding markers such as "RFC" or
"v2" to the subject of patch emails is to have them within the same
brackets as the "PATCH" text, not after the closing bracket.  Further,
the practice of `git format-patch` and the like, as well as what appears
to be the more common pratice on the mailing list, is to use "[RFC
PATCH]", not "[PATCH/RFC]".

Update the SubmittingPatches article to match and to reference the
`format-patch` helper arguments, and also make some minor text
clarifications in the area.

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
---

Notes:
    Changes since v3:
    - Clarified meaning of "RFC" per Eric's suggestion
    - Made the impact of --subject-prefix and friends clearer per Eric's
      suggestion
    
    Thank you for your nitpicking, Eric, it's useful and very much
    appreciated :)

 Documentation/SubmittingPatches | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 558d465b6..89f239071 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -184,21 +184,26 @@ lose tabs that way if you are not careful.
 
 It is a common convention to prefix your subject line with
 [PATCH].  This lets people easily distinguish patches from other
-e-mail discussions.  Use of additional markers after PATCH and
-the closing bracket to mark the nature of the patch is also
-encouraged.  E.g. [PATCH/RFC] is often used when the patch is
-not ready to be applied but it is for discussion, [PATCH v2],
-[PATCH v3] etc. are often seen when you are sending an update to
-what you have previously sent.
+e-mail discussions.  Use of markers in addition to PATCH within
+the brackets to describe the nature of the patch is also
+encouraged.  E.g. [RFC PATCH] (where RFC stands for "request for
+comments") is often used to indicate a patch needs further
+discussion before being accepted, [PATCH v2], [PATCH v3] etc.
+are often seen when you are sending an update to what you have
+previously sent.
 
-"git format-patch" command follows the best current practice to
+The "git format-patch" command follows the best current practice to
 format the body of an e-mail message.  At the beginning of the
 patch should come your commit message, ending with the
 Signed-off-by: lines, and a line that consists of three dashes,
 followed by the diffstat information and the patch itself.  If
 you are forwarding a patch from somebody else, optionally, at
 the beginning of the e-mail message just before the commit
 message starts, you can put a "From: " line to name that person.
+To change the default "[PATCH]" in the subject to "[<text>]", use
+`git format-patch --subject-prefix=<text>`.  As a shortcut, you
+can use `--rfc` instead of `--subject-prefix="RFC PATCH"`, or
+`-v <n>` instead of `--subject-prefix="PATCH v<n>"`.
 
 You often want to add additional explanation about the patch,
 other than the commit message itself.  Place such "cover letter"
-- 
2.14.3

