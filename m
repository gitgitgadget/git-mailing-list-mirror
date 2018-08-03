Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 245E81F597
	for <e@80x24.org>; Fri,  3 Aug 2018 23:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbeHDBHr (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 21:07:47 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:56858 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731741AbeHDBHr (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 Aug 2018 21:07:47 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w73N9Pqs009359;
        Fri, 3 Aug 2018 16:09:26 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2km9ya22uc-1;
        Fri, 03 Aug 2018 16:09:26 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id ECD2F22E03C0;
        Fri,  3 Aug 2018 16:09:25 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id E41222CDF0E;
        Fri,  3 Aug 2018 16:09:25 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH] t3031: update test description to mention desired behavior
Date:   Fri,  3 Aug 2018 16:09:23 -0700
Message-Id: <20180803230923.25577-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.548.gcd835b18f7
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-03_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=974 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808030250
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test description looks like it was written with the originally
observed behavior ("causes segfault") rather than the desired and now
current behavior ("does not cause segfault").  Fix it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3031-merge-criscross.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3031-merge-criscross.sh b/t/t3031-merge-criscross.sh
index e59b0a32d6..3824756a02 100755
--- a/t/t3031-merge-criscross.sh
+++ b/t/t3031-merge-criscross.sh
@@ -88,7 +88,7 @@ test_expect_success 'setup repo with criss-cross histor=
y' '
 	git branch G
 '
=20
-test_expect_success 'recursive merge between F and G, causes segfault' '
+test_expect_success 'recursive merge between F and G does not cause segf=
ault' '
 	git merge F
 '
=20
--=20
2.18.0.548.gcd835b18f7

