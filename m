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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E5F11F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 08:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389387AbeKPSLd (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 13:11:33 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:52928 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727451AbeKPSLb (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 16 Nov 2018 13:11:31 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAG7wIJK032736;
        Fri, 16 Nov 2018 00:00:00 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2ns2ddsqtn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 16 Nov 2018 00:00:00 -0800
Received: from sj-prod-exch-02.YOJOE.local (10.129.18.29) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Thu, 15 Nov 2018 23:59:57 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Thu, 15 Nov 2018 23:59:57 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 319FB2212285;
        Thu, 15 Nov 2018 23:59:58 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <gitster@pobox.com>
CC:     <git@vger.kernel.org>, <larsxschneider@gmail.com>,
        <sandals@crustytoothpaste.net>, <peff@peff.net>, <me@ttaylorr.com>,
        <jrnieder@gmail.com>, <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 02/11] git-fast-import.txt: fix documentation for --quiet option
Date:   Thu, 15 Nov 2018 23:59:47 -0800
Message-ID: <20181116075956.27047-3-newren@gmail.com>
X-Mailer: git-send-email 2.19.1.1063.g1796373474.dirty
In-Reply-To: <20181116075956.27047-1-newren@gmail.com>
References: <20181114002600.29233-1-newren@gmail.com>
 <20181116075956.27047-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=648 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811160073
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-fast-import.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index e81117d27f..7ab97745a6 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -40,9 +40,10 @@ OPTIONS
 	not contain the old commit).
 
 --quiet::
-	Disable all non-fatal output, making fast-import silent when it
-	is successful.  This option disables the output shown by
-	--stats.
+	Disable the output shown by --stats, making fast-import usually
+	be silent when it is successful.  However, if the import stream
+	has directives intended to show user output (e.g. `progress`
+	directives), the corresponding messages will still be shown.
 
 --stats::
 	Display some basic statistics about the objects fast-import has
-- 
2.19.1.1063.g1796373474.dirty

