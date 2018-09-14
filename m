Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2051D1F404
	for <e@80x24.org>; Fri, 14 Sep 2018 14:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbeINUAQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 16:00:16 -0400
Received: from smtpbg299.qq.com ([184.105.67.99]:52424 "EHLO smtpbg299.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbeINUAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 16:00:16 -0400
X-QQ-mid: Xesmtp6t1536936321t50xm1hfy
Received: from localhost.localdomain (unknown [101.224.239.201])
        by esmtp4.qq.com (ESMTP) with 
        id ; Fri, 14 Sep 2018 22:45:21 +0800 (CST)
X-QQ-SSF: B1000000000000F0F5100000000000Z
X-QQ-FEAT: 7lMulsC2UXJoHsVIDzbjzPORYUlD9fsJ6hpUSiaO+V+jlsqnKqzPXK+ayRO38
        bEYksGdN/y/z8TaXn+ft09tBwXtRldGkyJ+SQohpJtDRqEIpxiqz6sHeJmWLwVKOa4XyYi9
        ColCtJGhyv42gCcIjn/2IA9hXu1YTYu1EYn7b7S0xzAKIChTDKZ2LrEzjWPRDgvSqeNFoKN
        dXFujSiukf+pszzW2Zwu7P4c8g84GBGgvhnjK2OzbRoEIbbj7JsjnkZ3DgnqFko4fVZkREH
        6Slg+U3q54TPgj
X-QQ-GoodBg: 0
From:   Tao Qingyun <taoqy@ls-a.me>
To:     git@vger.kernel.org
Cc:     Tao Qingyun <taoqy@ls-a.me>
Subject: [PATCH] refs: docstirng typo
Date:   Fri, 14 Sep 2018 22:45:12 +0800
Message-Id: <20180914144512.1267-1-taoqy@ls-a.me>
X-Mailer: git-send-email 2.18.0
X-QQ-SENDSIZE: 520
X-QQ-FName: 535A858F356B4B9E94DBF624D92E0435
X-QQ-LocalIP: 10.198.131.167
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 refs/refs-internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 04425d6d1e..1fe5a7a22f 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -282,7 +282,7 @@ int refs_rename_ref_available(struct ref_store *refs,
  *
  *             // Access information about the current reference:
  *             if (!(iter->flags & REF_ISSYMREF))
- *                     printf("%s is %s\n", iter->refname, oid_to_hex(&iter->oid));
+ *                     printf("%s is %s\n", iter->refname, oid_to_hex(iter->oid));
  *
  *             // If you need to peel the reference:
  *             ref_iterator_peel(iter, &oid);
-- 
2.18.0

