Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 448461FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 16:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967498AbdAFQXr (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 11:23:47 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:46920 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967464AbdAFQXe (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Jan 2017 11:23:34 -0500
X-AuditID: 1207440c-e53ff700000009a1-1f-586fc47eac2e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id EE.00.02465.E74CF685; Fri,  6 Jan 2017 11:23:26 -0500 (EST)
Received: from bagpipes.fritz.box (p57906F4E.dip0.t-ipconnect.de [87.144.111.78])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v06GMmXA023262
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 6 Jan 2017 11:23:25 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 20/23] try_remove_empty_parents(): rename parameter "name" -> "refname"
Date:   Fri,  6 Jan 2017 17:22:40 +0100
Message-Id: <7a8a396e2539adc8cdcc24b1067cc968c158a19c.1483719289.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483719289.git.mhagger@alum.mit.edu>
References: <cover.1483719289.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsUixO6iqFt3JD/CYFmPtUXXlW4mi4beK8wW
        uxf3M1vcXjGf2WLJw9fMFj9aepgtOqfKOrB7/H3/gclj56y77B7Ll65j9OhqP8Lm8ax3D6PH
        xUvKHp83yQWwR3HZpKTmZJalFunbJXBlHHnRw1wwg6Pi87ZnTA2Mu9m6GDk5JARMJC5Mn8fY
        xcjFISRwmVFi5Y0+FgjnBJPE+vXdYFVsAroSi3qamUBsEQE1iYlth8CKmAU+MEr86pzFDpIQ
        FoiSONKwn7mLkYODRUBV4vA0sHpeoPC2jjYmiG1yEpe2fWEGsTkFLCQad31jBLGFBMwlPk08
        zDyBkWcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1DvdzMEr3UlNJNjJAA49nB+G2dzCFG
        AQ5GJR7eCK+8CCHWxLLiytxDjJIcTEqivGGO+RFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHjb
        9wLleFMSK6tSi/JhUtIcLErivKpL1P2EBNITS1KzU1MLUotgsjIcHEoSvPcPAjUKFqWmp1ak
        ZeaUIKSZODhBhvMADV8FUsNbXJCYW5yZDpE/xagoJc5rD5IQAElklObB9cISwCtGcaBXhHkf
        g1TxAJMHXPcroMFMQIMFPcEGlyQipKQaGFM556+TO8tnIdvNdaF8OUtg/bF7EUwZfJqTvHIP
        LfxXKu7XxFWmMjdIrLjg76r9br5JtZ1qJxXa81YseSq14pLrlgTO3SmVbDwMVwoW1ldaC3et
        DL7I/pXplPiuApaMyM/emupPr7Bf3HU6ZeIbQYEYn5scSj9+z1gpq2axwZfLof5eqWu2Ektx
        RqKhFnNRcSIAYYFbgNsCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the standard nomenclature.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9abd7c3..92a9d99 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2282,13 +2282,13 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 
 /*
  * Remove empty parents, but spare refs/ and immediate subdirs.
- * Note: munges *name.
+ * Note: munges *refname.
  */
-static void try_remove_empty_parents(char *name)
+static void try_remove_empty_parents(char *refname)
 {
 	char *p, *q;
 	int i;
-	p = name;
+	p = refname;
 	for (i = 0; i < 2; i++) { /* refs/{heads,tags,...}/ */
 		while (*p && *p != '/')
 			p++;
@@ -2306,7 +2306,7 @@ static void try_remove_empty_parents(char *name)
 		if (q == p)
 			break;
 		*q = '\0';
-		if (rmdir(git_path("%s", name)))
+		if (rmdir(git_path("%s", refname)))
 			break;
 	}
 }
-- 
2.9.3

