Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3722A1F453
	for <e@80x24.org>; Thu, 14 Feb 2019 20:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394945AbfBNUZs (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 15:25:48 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:43190 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387975AbfBNUZs (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 14 Feb 2019 15:25:48 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EKDqMN003983;
        Thu, 14 Feb 2019 12:25:46 -0800
Received: from mail.palantir.com ([198.97.14.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2qmv9usgnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 14 Feb 2019 12:25:46 -0800
Received: from dc-prod-exch-01.YOJOE.local (10.193.18.14) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Thu, 14 Feb 2019 15:25:43 -0500
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Thu, 14 Feb 2019 15:25:43 -0500
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 92658221A360;
        Thu, 14 Feb 2019 12:25:43 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <gitster@pobox.com>
CC:     <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
Subject: [PATCH] git-rebase.txt: update to reflect merge now implemented on sequencer
Date:   Thu, 14 Feb 2019 12:25:41 -0800
Message-ID: <20190214202541.21371-1-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a28
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_10:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since commit 8fe9c3f21dff (Merge branch 'en/rebase-merge-on-sequencer',
2019-02-06), --merge now uses the interactive backend (and matches its
behavior) so there is no separate merge backend anymore.  Fix an
oversight in the docs that should have been updated with the previous
change.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index daa16403ec..619303adbc 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -554,8 +554,6 @@ commit started empty (had no changes relative to its parent to
 start with) or ended empty (all changes were already applied
 upstream in other commits).
 
-The merge backend does the same.
-
 The interactive backend drops commits by default that
 started empty and halts if it hits a commit that ended up empty.
 The `--keep-empty` option exists for the interactive backend to allow
-- 
2.21.0.rc0.269.g1a574e7a28

