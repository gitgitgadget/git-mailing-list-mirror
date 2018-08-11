Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 748991F428
	for <e@80x24.org>; Sat, 11 Aug 2018 04:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbeHKHFJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 03:05:09 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:37930 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727197AbeHKHFJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 11 Aug 2018 03:05:09 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7B4NZoS005378;
        Fri, 10 Aug 2018 21:32:21 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2kr1kwmmuu-1;
        Fri, 10 Aug 2018 21:32:21 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 10ACA22506C3;
        Fri, 10 Aug 2018 21:32:21 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 07F222CDE5F;
        Fri, 10 Aug 2018 21:32:21 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 9/9] Add missing includes and forward declares
Date:   Fri, 10 Aug 2018 21:32:18 -0700
Message-Id: <20180811043218.31456-10-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.549.gd4454f3f9b
In-Reply-To: <20180811043218.31456-1-newren@gmail.com>
References: <20180811043218.31456-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-11_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=855 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808110048
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 bisect.h       | 2 ++
 pack-objects.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/bisect.h b/bisect.h
index a5d9248a47..34df209351 100644
--- a/bisect.h
+++ b/bisect.h
@@ -1,6 +1,8 @@
 #ifndef BISECT_H
 #define BISECT_H
=20
+struct commit_list;
+
 /*
  * Find bisection. If something is found, `reaches` will be the number o=
f
  * commits that the best commit reaches. `all` will be the count of
diff --git a/pack-objects.h b/pack-objects.h
index edf74dabdd..919cdc211e 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -2,6 +2,7 @@
 #define PACK_OBJECTS_H
=20
 #include "object-store.h"
+#include "pack.h" /* for pack_idx_entry */
=20
 #define DEFAULT_DELTA_CACHE_SIZE (256 * 1024 * 1024)
=20
--=20
2.18.0.549.gd4454f3f9b

