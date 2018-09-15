Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD6621F404
	for <e@80x24.org>; Sat, 15 Sep 2018 02:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbeIOHdT (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 03:33:19 -0400
Received: from smtpbg65.qq.com ([103.7.28.233]:59685 "EHLO smtpbg65.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725744AbeIOHdT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 03:33:19 -0400
X-QQ-mid: Xesmtp2t1536977759t8ko5imp9
Received: from localhost.localdomain (unknown [101.224.239.201])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sat, 15 Sep 2018 10:15:58 +0800 (CST)
X-QQ-SSF: B1000000000000F0F5100000000000Z
X-QQ-FEAT: yE1moX/8tMZ0fB4KfFmljoRbjxwrkKcGMvV3h6qRDsaQYE9t/e/DwICkof0EQ
        47xGQIg40MPiwULLXPcIkSuuzbbwzLVRcNEqijqvOeTs5gF1mPIy0Cr/fNXUYwFSkR+QjR0
        //GLgqdSYOVEoritASx9O8hKLhRhe0GVN9JM+zIJffb3mU2m1wWpkLieQJKrlZODk7dk68S
        /RNYflHaleIeR0GuCSEq2t2UhWE4Wci+MdiSeUaGV47LpsUeJA7v8c8WipCSOgKZwaofGL9
        aqg5af3YwAFmz8R3pWIKysWf0=
X-QQ-GoodBg: 0
From:   Tao Qingyun <taoqy@ls-a.me>
To:     sunshine@sunshineco.com
Cc:     git@vger.kernel.org, Tao Qingyun <taoqy@ls-a.me>
Subject: [PATCH v2] refs: docstring typo
Date:   Sat, 15 Sep 2018 10:15:46 +0800
Message-Id: <20180915021546.2098-1-taoqy@ls-a.me>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <CAPig+cRNwdU6QJpbZiiwWcL5e8zqO3V72ex+_p_SxjF77YX3iw@mail.gmail.com>
References: <CAPig+cRNwdU6QJpbZiiwWcL5e8zqO3V72ex+_p_SxjF77YX3iw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: Xesmtp:ls-a.me:bgforeign:bgforeign2
X-QQ-Bgrelay: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Tao Qingyun <taoqy@ls-a.me>
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
2.19.0



