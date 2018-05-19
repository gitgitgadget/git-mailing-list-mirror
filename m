Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A04BB1F51C
	for <e@80x24.org>; Sat, 19 May 2018 02:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752285AbeESCHO (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 22:07:14 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:57638 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752215AbeESCHG (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 18 May 2018 22:07:06 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4J26KDm031517;
        Fri, 18 May 2018 19:07:03 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2hwx4kv2nc-1;
        Fri, 18 May 2018 19:07:03 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id E6839229B0E8;
        Fri, 18 May 2018 19:07:02 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id D52DF2CDE79;
        Fri, 18 May 2018 19:07:02 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/5] merge-recursive code cleanups
Date:   Fri, 18 May 2018 19:06:55 -0700
Message-Id: <20180519020700.2241-1-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.847.g20b8963732
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-18_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=822 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1805190021
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series contains several small code cleanups for merge-recursive.
I have removed a couple small cleanup chunks in order to avoid conflicts
with any other in-flight topics in pu (namely, nd/commit-util-to-slab and
sb/submodule-merge-in-merge-recursive).  I may resend those later
separately.

The series was made on top of next (specifically commit c95db04db ("Merge
branch 'sb/object-store-replace' into next")); it will not apply to
master.

Elijah Newren (5):
  merge-recursive: fix miscellaneous grammar error in comment
  merge-recursive: fix numerous argument alignment issues
  merge-recursive: clarify the rename_dir/RENAME_DIR meaning
  merge-recursive: rename conflict_rename_*() family of functions
  merge-recursive: simplify handle_change_delete

 merge-recursive.c | 173 ++++++++++++++++++++++------------------------
 1 file changed, 83 insertions(+), 90 deletions(-)

-- 
2.17.0.847.g20b8963732

