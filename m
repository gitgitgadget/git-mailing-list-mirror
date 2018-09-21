Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A89231F453
	for <e@80x24.org>; Fri, 21 Sep 2018 18:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391216AbeIVAMs (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 20:12:48 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:37806 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390076AbeIVAMs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 20:12:48 -0400
Received: by mail-io1-f74.google.com with SMTP id r18-v6so11713534ioj.4
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 11:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Wv3R8VhWdYYhBuCCbGQQAqZ1HNgRw6vMJxM0XK37+ZI=;
        b=cC6aeod70jLC/ZxqNuIMcocMXDcsSyowphJLw3mIvh3PL4QIAdb9RSxNo32bzhacGV
         h24vqZztFt5BcG0aCwCF/2GRDwiUR2lFOdivdJvaw9Ws5cqYly26JhrD3s0ABe2FMsIl
         pjOEG6EMdcRe/5MJQDK+gdldPNDXiy80EAgMzSSZrVQnUpChLvyRzg5//ppUwmFm1sBi
         dlje7wB4sgamaZ7K0rm8Ac6Vm9vR6iJBcRb72mwMdaVKqAOMOgbtlm055QHFRUbtL1lJ
         noyM+kvZQklVDT7YBlzUeNENpXxREZ2SX1Dotl/xpNnD5hXjdYgamb7MQK/683Zosfku
         PFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Wv3R8VhWdYYhBuCCbGQQAqZ1HNgRw6vMJxM0XK37+ZI=;
        b=Em0czcyyG4zOG2yOzbCMLDFmF5e0Qc2tMqQQyRn4fU3L5kGYTxKHq/BKVnq3VXTDo6
         qIG9jXVfgv6xrbAuGgf7bWRobb4VQQcc3Y68754xR9WslFk3SW+BefQynkzqgcLiPxtp
         w/dRIHfL2Bp7CAdVqt7CfeCDJLhoFLDW7wqQoO9cC7CuH7QLv+vt3SmoiNTxfqOmczLD
         V32z2LFvTADz4cTyBcVxPmM+DHnt76QLYrfEtrJ5oWiJ7H4pBc02z5RJ7QVr9G+X3KTu
         PTAwscYCLVFejOuclUfQtBAzzm8YR4CAaGgg72vasvnUZwn5EFyL735aHxBhoVwOf2Uq
         uIXQ==
X-Gm-Message-State: ABuFfojIqb446Z/zJjUt/DDAO3WTkFvmPY3o4Pru/IU7XKvbrvr+GBhz
        86xVyMmexPKJr9DZxK7rIxXkB0+CeNe9OWFhA3rJXUka9xa3yzybAihDUZL5ruz0QzUnCeiMDCQ
        rCXMIYdYbTPHZeNJaSXO8uoi7X2XiUyEe8Pv7YEcCm3uSmU/5FJxnwFDQeHYcHW7uVDUyE3NWzk
        Sx
X-Google-Smtp-Source: ACcGV61z9VWUY0tnIjESb7jsJWVhs8NXFQNBxEu0kkdpWp/HazN/lGmXsM6D6XbnQ+eJ/UH30oSjMXppKBCq7TjDfqPy
X-Received: by 2002:a6b:b44a:: with SMTP id d71-v6mr4012637iof.57.1537554163178;
 Fri, 21 Sep 2018 11:22:43 -0700 (PDT)
Date:   Fri, 21 Sep 2018 11:22:37 -0700
In-Reply-To: <cover.1537553700.git.jonathantanmy@google.com>
Message-Id: <14153be920095f5fc8c11da33d5d27469e3a0f39.1537553700.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20180920184843.20898-1-jonathantanmy@google.com> <cover.1537553700.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH v2 1/2] connected: document connectivity in partial clones
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In acb0c57260 ("fetch: support filters", 2017-12-08), check_connected()
was extended to allow objects to either be promised to be available (if
the repository is a partial clone) or to be present; previously, this
function required the latter. However, this change was not reflected in
the documentation of that function. Update the documentation
accordingly.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 connected.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/connected.h b/connected.h
index e4c961817..8d5a6b3ad 100644
--- a/connected.h
+++ b/connected.h
@@ -51,9 +51,9 @@ struct check_connected_options {
 #define CHECK_CONNECTED_INIT { 0 }
 
 /*
- * Make sure that our object store has all the commits necessary to
- * connect the ancestry chain to some of our existing refs, and all
- * the trees and blobs that these commits use.
+ * Make sure that all given objects and all objects reachable from them
+ * either exist in our object store or (if the repository is a partial
+ * clone) are promised to be available.
  *
  * Return 0 if Ok, non zero otherwise (i.e. some missing objects)
  *
-- 
2.19.0.444.g18242da7ef-goog

