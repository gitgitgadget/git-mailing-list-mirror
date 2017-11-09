Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C286A1F442
	for <e@80x24.org>; Thu,  9 Nov 2017 13:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754676AbdKINJF (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 08:09:05 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44142 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754600AbdKINJC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 08:09:02 -0500
Received: by mail-wr0-f193.google.com with SMTP id u97so5569309wrc.1
        for <git@vger.kernel.org>; Thu, 09 Nov 2017 05:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oYtheyn6W3T3U2HrNLQEBFPvcx4tOjFWN3MVHDG5ka0=;
        b=n6z2dOl3FIpbBtPv9Fvzj7ZJZRHNRnCr5S/c1LwaQrlx0jrZB4XmxBB+kWx83vssCB
         hxCk98SuRNP0Q13iSJu/XbOyUfh9hqYpJr8FNvy8BOuDFA/Z1gSTVu0Wue+THYlx+vpX
         EAGXBNNewqTH8v4FKWOi5shJRQhlP6lLUbSJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oYtheyn6W3T3U2HrNLQEBFPvcx4tOjFWN3MVHDG5ka0=;
        b=IaELI8yN3Oc5ZjlMP9G4plvRCMpxQioJhELmIEX6tOCACp0972g1dEQ++6Ae1uPu6+
         5bMgpLJ5Io/QuAVV0ReC+dICWHROBfyLkikrKZHrL9nXXJPJK/Ztbwd8PCbvZNFzjdVK
         RUdL5df18Yeswf3qXkZHhWeYfaLnqZQ9l5YRpzXs6LaeqkAW8oJMVdZRTnW8H+1xkgaV
         vggsBY+z3yWh8Gz1bnTf4N/MqQz5MedULp6uh/7fPo0Z/R9Gj6Vb2eES5RlCOl5/atZt
         DkZbyo9it0Rln2EMtq4iDPsA7ySUxoKvcut+TwFN5wjD0AqGtW37Cxttcm7RQ52ooIHZ
         R0Ng==
X-Gm-Message-State: AJaThX7ZNuqdNwDoiAFDyQLSm0K6r7C5+Vnu/e4yA3WJgCI0SKozQxA3
        ZbQdM6mumy/1cEtPjvxTFLe+VQwfDJg=
X-Google-Smtp-Source: ABhQp+SBqO/PvIiAko4M0SIqsa7uPwGmEVwdCUgUMnHb64M6hO0b282AHbZI3JvLikuusWrYhEGRYQ==
X-Received: by 10.223.157.11 with SMTP id k11mr404620wre.281.1510232940629;
        Thu, 09 Nov 2017 05:09:00 -0800 (PST)
Received: from PC5175.ad.datcon.co.uk ([2620:104:4001:73:993:9a1f:de68:e37a])
        by smtp.gmail.com with ESMTPSA id j125sm13056947wmf.24.2017.11.09.05.08.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Nov 2017 05:08:59 -0800 (PST)
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH v3] doc/SubmittingPatches: correct subject guidance
Date:   Thu,  9 Nov 2017 13:08:26 +0000
Message-Id: <20171109130826.52132-1-adam@dinwoodie.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171109124714.GH20681@dinwoodie.org>
References: <20171109124714.GH20681@dinwoodie.org>
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

Update the SubmittingPatches article to match, and to reference the
`format-patch` helper arguments.

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/SubmittingPatches | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 558d465b6..ae59fd9d0 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -184,21 +184,25 @@ lose tabs that way if you are not careful.
 
 It is a common convention to prefix your subject line with
 [PATCH].  This lets people easily distinguish patches from other
-e-mail discussions.  Use of additional markers after PATCH and
-the closing bracket to mark the nature of the patch is also
-encouraged.  E.g. [PATCH/RFC] is often used when the patch is
+e-mail discussions.  Use of markers in addition to PATCH within
+the brackets to describe the nature of the patch is also
+encouraged.  E.g. [RFC PATCH] is often used when the patch is
 not ready to be applied but it is for discussion, [PATCH v2],
 [PATCH v3] etc. are often seen when you are sending an update to
 what you have previously sent.
 
-"git format-patch" command follows the best current practice to
+The "git format-patch" command follows the best current practice to
 format the body of an e-mail message.  At the beginning of the
 patch should come your commit message, ending with the
 Signed-off-by: lines, and a line that consists of three dashes,
 followed by the diffstat information and the patch itself.  If
 you are forwarding a patch from somebody else, optionally, at
 the beginning of the e-mail message just before the commit
 message starts, you can put a "From: " line to name that person.
+To change the bracketed text at the start of the subject, use
+`git format-patch --subject-prefix=<text>`.  As a shortcut, you
+can use `--rfc` instead of `--subject-prefix="RFC PATCH"`, or
+`-v <n>` instead of `--subject-prefix="PATCH v<n>"`.
 
 You often want to add additional explanation about the patch,
 other than the commit message itself.  Place such "cover letter"
-- 
2.14.3

