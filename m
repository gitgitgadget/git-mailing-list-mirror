Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 852411F43C
	for <e@80x24.org>; Wed,  8 Nov 2017 13:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752513AbdKHNRJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 08:17:09 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:48914 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752376AbdKHNRI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 08:17:08 -0500
Received: by mail-wr0-f196.google.com with SMTP id 15so2384770wrb.5
        for <git@vger.kernel.org>; Wed, 08 Nov 2017 05:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FHoQZmAOBOnnb3FOyhRLKz8HmwjJbm66Y23GHmJmq/I=;
        b=XA2ZFnUmq4sBrAgPx+7O+zfQOIGX3DI0p5l1k5lUg+KPr25jqRO2X91UIbc9xXNWlD
         WC9T1hhnoja4lusVHMq2SN49OeRFxc4wS1NSH75WjtykhBwpPiYNRFAVdDiN8QebPpeO
         ZTkhfgZEaXQBj7sa6kfQSLJ+1BFZXVWcwtssc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FHoQZmAOBOnnb3FOyhRLKz8HmwjJbm66Y23GHmJmq/I=;
        b=rfN87FG0A0GDRXYBpgElKT+6GGpj/X0GGk/Y4VLB8NHrq0om+uE60jeHbAo/g5+siG
         t3/n0N3LQ7GoZguJAugvfGdCq05E/j918WWx/e5zGfLwZsYAGtESZq5cClt5e9OykLWH
         P9pMNg3WWCOSYScoWsjdW7okJmnrGR0OLaodss/qb5sdnDSGtGpwQJYDP69OnVQUYiZe
         i3i+U7Zt2LdX/bwPUR9CV83vXpdk7AxxVgpOpIjpo8+pf8+EsycKg1gMC5i08GQr1Hxk
         2c/xcUt9mTCAqhp4sbUOzWIti5XNPVgifpTMtLOirRmkfA+UUVOrB1OaNCj3hKJSbHqe
         GfWA==
X-Gm-Message-State: AJaThX7I660/9pQmt++vAlVgNIdf5SJ2gclBp6Ox6WwsiyJ6HqKp/cAa
        yustILtzNrGgJMB8zUWRLBUqqNdSOqU=
X-Google-Smtp-Source: ABhQp+R9+LFaMoZ1Ws9qnDZXkqa5Qd2rCFCh7BeABVEkhxa/u3tKcifKP1bJ7FXdAmKLWwPvBpeNjQ==
X-Received: by 10.223.153.202 with SMTP id y68mr468718wrb.216.1510147026513;
        Wed, 08 Nov 2017 05:17:06 -0800 (PST)
Received: from PC5175.ad.datcon.co.uk ([2620:104:4001:73:a407:552d:75e4:4516])
        by smtp.gmail.com with ESMTPSA id v5sm5074275wme.26.2017.11.08.05.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Nov 2017 05:17:05 -0800 (PST)
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] doc/SubmittingPatches: correct subject guidance
Date:   Wed,  8 Nov 2017 13:16:01 +0000
Message-Id: <20171108131601.280992-1-adam@dinwoodie.org>
X-Mailer: git-send-email 2.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The examples and common practice for adding markers such as "RFC" or
"v2" to the subject of patch emails is to have them within the same
brackets as the "PATCH" text.  Update the description to match this
behaviour, rather than asserting such markers should be after the
closing bracket.

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
---
 Documentation/SubmittingPatches | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 558d465b6..e91ce8269 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -184,7 +184,7 @@ lose tabs that way if you are not careful.
 
 It is a common convention to prefix your subject line with
 [PATCH].  This lets people easily distinguish patches from other
-e-mail discussions.  Use of additional markers after PATCH and
+e-mail discussions.  Use of additional markers between PATCH and
 the closing bracket to mark the nature of the patch is also
 encouraged.  E.g. [PATCH/RFC] is often used when the patch is
 not ready to be applied but it is for discussion, [PATCH v2],
-- 
2.14.3

