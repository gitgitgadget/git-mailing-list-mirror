Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10B2B1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 20:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeJQEMK (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 00:12:10 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:41552 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725960AbeJQEMK (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 Oct 2018 00:12:10 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9GKIsG3028402;
        Tue, 16 Oct 2018 13:20:02 -0700
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2n3ejh54j1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 16 Oct 2018 13:20:02 -0700
Received: from sj-prod-exch-02.YOJOE.local (10.160.10.15) by
 sj-prod-exch-02.YOJOE.local (10.160.10.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 16 Oct 2018 13:20:00 -0700
Received: from EX02-WEST.YOJOE.local (10.160.10.131) by
 sj-prod-exch-02.YOJOE.local (10.160.10.15) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Tue, 16 Oct 2018 13:20:00 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 EX02-WEST.YOJOE.local (10.160.10.131) with Microsoft SMTP Server id
 14.3.319.2; Tue, 16 Oct 2018 13:19:59 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech
 [10.100.71.66])        by smtp-transport.yojoe.local (Postfix) with ESMTPS id
 9601221F89E0;  Tue, 16 Oct 2018 13:19:59 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <gitster@pobox.com>
CC:     <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 0/2] More merge cleanups
Date:   Tue, 16 Oct 2018 13:19:46 -0700
Message-ID: <20181016201948.16025-1-newren@gmail.com>
X-Mailer: git-send-email 2.19.1.280.g0c175526bf
In-Reply-To: <20181012212551.7689-1-newren@gmail.com>
References: <20181012212551.7689-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-16_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=446 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810160169
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds a few more cleanups on top of en/merge-cleanup.
Changes since v1:
  - Removed two patches that will instead be included in a follow-on
    series, as suggested by Junio.
  - Incorporated commit message cleanups (capitalization and indents)
    made by Junio to the previous round.

Elijah Newren (2):
  merge-recursive: improve auto-merging messages with path collisions
  merge-recursive: avoid showing conflicts with merge branch before HEAD

 merge-recursive.c                 | 37 ++++++++++++++++++++++++++++---
 t/t6036-recursive-corner-cases.sh |  8 +++----
 2 files changed, 38 insertions(+), 7 deletions(-)

-- 
2.19.1.280.g0c175526bf

