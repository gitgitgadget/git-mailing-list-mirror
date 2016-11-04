Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 469DE2022D
	for <e@80x24.org>; Fri,  4 Nov 2016 21:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933575AbcKDVon (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 17:44:43 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33947 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933373AbcKDVon (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 17:44:43 -0400
Received: by mail-lf0-f68.google.com with SMTP id o141so4023239lff.1
        for <git@vger.kernel.org>; Fri, 04 Nov 2016 14:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Mb7CHdNa3CDOGrpWW4ehk5A+NhpHcA1jGUvlCretbLM=;
        b=QpXjFdd8D1KE7UctDgALF+JExwV5wp4A2qe/xppEpFmdB7vB5rb2Zh7wYOwN/YgHF3
         b4XNMxlmb88N1IZbTZ/+WSEuejsVFu6+y7pNHkaA6YhuWRuKEd0EWYplDgGxKE0AVSw9
         5VRxdwZ7sJqybf/rOWNgY1nRblTBX6V8t2DMQQ21vs/wHuWNcCoIyIAIWPglkXaBioGa
         7kksmLWY0cMOUxQliv/lkJ+B22fptDi2FbHGBTYqAb6K8qgAGpLunN8Lpugi7WapLzI0
         k5enHRlFRHIU0J7GbDBHZvHuNtHTi/Gc7R2swkPgg2r2svijNy3XAsihPl5txE/2SFST
         W8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Mb7CHdNa3CDOGrpWW4ehk5A+NhpHcA1jGUvlCretbLM=;
        b=ON9Q0kco70VzvLJDlBhp7VX+xvGvrbc47SHgk8wuECM3YUbhR+2OUTCqvRIbeUXpqv
         RM57LfUTci3oHmOwDtI9TPB1p6hSimnxSWzuWqsK6Z+Zei3n/6/K1GJlFw7UIp9HZ878
         djgtlUs5DnFfLyv+qlS5Akct/rxei3bol2jyP+MMyLK1SuaW7fWuyNv2okTRhCp1IZjv
         H8dkIqGjq5KOZBhklEl0qA9DdoWMYM2zxLvP5k72qEBhV4nDptqD1AWVqktknWE5UCUv
         F8nm5lcTCDeHsgxu003fiZnNmMtqURye2ycanA3hD6bsJAlkpZdUZ8oWY3tPvPzbfWyL
         dM+w==
X-Gm-Message-State: ABUngvcJBepfz5Ti5MbGD+ztd+a6FKTN4R1VXZpV++n0cwAGdiDkm3GmtfoxTby3U2CdcQ==
X-Received: by 10.25.24.208 with SMTP id 77mr11008991lfy.101.1478295881212;
        Fri, 04 Nov 2016 14:44:41 -0700 (PDT)
Received: from kristoffer-SZ68R2.privnett.uib.no (uib-guest.uib.no. [129.177.138.114])
        by smtp.gmail.com with ESMTPSA id x16sm2693351lff.15.2016.11.04.14.44.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Nov 2016 14:44:40 -0700 (PDT)
From:   Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
Subject: [PATCH] doc: fill in omitted word
Date:   Fri,  4 Nov 2016 22:43:57 +0100
Message-Id: <20161104214357.32477-1-kristoffer.haugsbakk@gmail.com>
X-Mailer: git-send-email 2.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
---
 Documentation/gitcore-tutorial.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 4546fa0..9860517 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -25,7 +25,7 @@ you want to understand Git's internals.
 The core Git is often called "plumbing", with the prettier user
 interfaces on top of it called "porcelain". You may not want to use the
 plumbing directly very often, but it can be good to know what the
-plumbing does for when the porcelain isn't flushing.
+plumbing does for you when the porcelain isn't flushing.
 
 Back when this document was originally written, many porcelain
 commands were shell scripts. For simplicity, it still uses them as
-- 
2.10.2

