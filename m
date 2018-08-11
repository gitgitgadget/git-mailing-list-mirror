Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC3221F404
	for <e@80x24.org>; Sat, 11 Aug 2018 20:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeHKXZy (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 19:25:54 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:36348 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727411AbeHKXZx (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 11 Aug 2018 19:25:53 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7BKnOjU008672;
        Sat, 11 Aug 2018 13:50:27 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2kswngrew5-1;
        Sat, 11 Aug 2018 13:50:27 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 8E5F82230FD5;
        Sat, 11 Aug 2018 13:50:27 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 7923C2CDE5F;
        Sat, 11 Aug 2018 13:50:27 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 4/6] urlmatch.h: fix include guard
Date:   Sat, 11 Aug 2018 13:50:22 -0700
Message-Id: <20180811205024.11291-5-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.549.gd4454f3f9b
In-Reply-To: <20180811205024.11291-1-newren@gmail.com>
References: <20180811043218.31456-1-newren@gmail.com>
 <20180811205024.11291-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-11_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=782 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808110232
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 urlmatch.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/urlmatch.h b/urlmatch.h
index 37ee5da85e..e482148248 100644
--- a/urlmatch.h
+++ b/urlmatch.h
@@ -1,4 +1,6 @@
 #ifndef URL_MATCH_H
+#define URL_MATCH_H
+
 #include "string-list.h"
=20
 struct url_info {
--=20
2.18.0.549.gd4454f3f9b

