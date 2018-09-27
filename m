Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 537BF1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 19:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbeI1Bc2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 21:32:28 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43134 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbeI1Bc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 21:32:27 -0400
Received: by mail-lf1-f66.google.com with SMTP id x24-v6so3047720lfe.10
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 12:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AUrE/mMMyuFxYmZFu42KeQqVpzwkfCag2MqlTiQzdnw=;
        b=YNOcobRi4ZNND4Y+yEEpbDpbIV8SrWKACiDgaMn1tS4xuRU/kP0ORYfgDsGxMn3DrX
         cojk5VrYS4opMwaRGV25y3vi1nUEdtVwi7mf43pYWItoCmUbcLfCWz90N5roHimWzNKM
         geZf7d8PZvO4M5PMTwNOxp5rST8sQojo3Wjwf43fCQ2nthhXTnSdkl6UU1nc8KuLq21D
         HWZAuJC1N8/dVBPEmJWy/taRb0BrqMkP4U1GQV8WTNglwVvqzGj6C7nytVcOspxf1TQj
         t2pVoKL/yEQWUbzOgBHthAZo2qMUbzJ1D5Nk2oGsqrIk0vlk7cg0l8wtojgkXuuq5wol
         V9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AUrE/mMMyuFxYmZFu42KeQqVpzwkfCag2MqlTiQzdnw=;
        b=HeUGVTYiQI7AMMaPmElzEMaZYCIIWBGbrPJh3xu3/dCvovPNojiCc+8wDK9H4+FaaU
         BgyIgAoBK1hGTF6ksYCIk5DEZh+VXDVP9pnAPAlEkzvROHIvS99eD7nRi2VO34E85KDD
         0GMQrSggO1Xk5sVwZsXh+8Dl9CrEG9Izrquq5vgJiKOMVbl+6SG2FyvQSMa6rbCv0z7N
         HYlzEdXSRJJDvw05Dq4053rjsEICwd7ea8R9oavdcFpVJb5TfQ46gzOf3kUZCQd54byL
         10Rh3Nz1bbrKl5Xc55+Dk1W6Tc466QFhMYYHeUW9BnYG7AUK2ilxCiQhkCgdRotZyGyH
         J24Q==
X-Gm-Message-State: ABuFfog8958I+MCThBZhLKUgUYGk5zuHvsNj4vgRxitD1BVLqxmEsy79
        d4xCcj2Cs1UENc2fqT23Qhiphm46
X-Google-Smtp-Source: ACcGV617aXUm1UrqvbOBh8VJDMh5O6XdHn98YvLrqJ99lem+uJqIlWbFsorEWwmbsubSOz9b3rW1wA==
X-Received: by 2002:a19:2288:: with SMTP id i130-v6mr5178095lfi.50.1538075560394;
        Thu, 27 Sep 2018 12:12:40 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id r79-v6sm561673ljb.84.2018.09.27.12.12.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 12:12:39 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2 1/4] git-commit-graph.txt: fix bullet lists
Date:   Thu, 27 Sep 2018 21:12:19 +0200
Message-Id: <837ef2f231b078cbb0eff3b33917fcc38626d788.1538075326.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.19.0.216.g2d3b1c576c
In-Reply-To: <cover.1538075326.git.martin.agren@gmail.com>
References: <6b1cb43e-a1a8-921f-cd66-3697609854e0@gmail.com> <cover.1538075326.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a couple of bullet items which span multiple lines, and where we
have prefixed each line with a `*`. (This might be the result of a text
editor trying to help.) This results in each line being typeset as a
separate bullet item. Drop the extra `*`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-commit-graph.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index dececb79d7..f42f2a1481 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -73,7 +73,7 @@ $ git commit-graph write
 ------------------------------------------------
 
 * Write a graph file, extending the current graph file using commits
-* in <pack-index>.
+  in <pack-index>.
 +
 ------------------------------------------------
 $ echo <pack-index> | git commit-graph write --stdin-packs
@@ -86,7 +86,7 @@ $ git show-ref -s | git commit-graph write --stdin-commits
 ------------------------------------------------
 
 * Write a graph file containing all commits in the current
-* commit-graph file along with those reachable from HEAD.
+  commit-graph file along with those reachable from HEAD.
 +
 ------------------------------------------------
 $ git rev-parse HEAD | git commit-graph write --stdin-commits --append
-- 
2.19.0.216.g2d3b1c576c

