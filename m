Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 066E520954
	for <e@80x24.org>; Fri,  8 Dec 2017 00:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751043AbdLHAZI (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 19:25:08 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:34932 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750973AbdLHAZH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 19:25:07 -0500
Received: by mail-it0-f68.google.com with SMTP id f143so1292638itb.0
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 16:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7Cr0IHY6IXgjvGoZFFvoPIuBR0I0xX21rp50lzIbgIs=;
        b=iHJaGmzBFhIT2NpCV5+aXY2zgo8vt9bvCeljiZf1XNUi23bH8lCb6fPGxMYp7b51ud
         yN52KWVHyMuw30PHeH39hILFAJ2zSsWzxUxUWI+A4uuC3Rt/PTz1ecGGkuhjfVXX/9Oa
         Degz7/mJEp0P6qqqKEVVjzDV4OSa/UC+jh1EJvWu2DQb+6S2OhOeDBUzdb9tsqvrhE0g
         owAtyU2XWTY2o7b80BsE1UtuB67rLQ5ceDT4a07Yaa8aBKp4JPNW5mNmPOW/5SBQR2N9
         kDmuAT0VaMQuMA304smB5508fvqeHHCrHL9tuMs814EBI5NfWwRhOqh4wwOvOdiof6aL
         UF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7Cr0IHY6IXgjvGoZFFvoPIuBR0I0xX21rp50lzIbgIs=;
        b=R32nfMWH4SHGk1qqcJy8LN2NYC9DTAB/ISaY/3K0U1XHrsx006IYsQefskoyQ3cSXs
         wxfvCUcF1h0S+lC+WFFnF6HMz1XnbrenVBPXIzykhiKDtNvFjlu5yNWDm3mSvfw9ECVG
         5eJ9UcyfPPEvN7xkTXMhmv6+KhDI/+q+p/vE41L9LBlnO+88e/2mEAl6J+9sEdWGzDsQ
         A6oYMO2dHDnOcr+QuXN/gjZcHvbv9qpKxb8qMepmpbFwzkJDr3rNq/Oacbe9sOe+udNO
         V4dX0V9qGAzGMOo+aFTKfVN8JzazNM9pCV8egOjQSopIk3Zw/eedwb9jfDSkPF1iCwM3
         cpTA==
X-Gm-Message-State: AKGB3mKM96DIWG0CttN27nF6GlMOQR4cHn19yl+DGEVcc79fNLm5C6Q3
        TN1gTDqfBdRrhSY4Ed4K4inRhSqeEmE=
X-Google-Smtp-Source: AGs4zMb5jYL0OfFQVDb3QacHewLXmxUmH/zoZOJkRePzGtKTRD7zLxOQKdB2QF85YPu8SMBi6pwqcw==
X-Received: by 10.36.14.86 with SMTP id 83mr3336739ite.8.1512692702180;
        Thu, 07 Dec 2017 16:25:02 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id 191sm200280itx.16.2017.12.07.16.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Dec 2017 16:25:01 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/1] diffcore-blobfind
Date:   Thu,  7 Dec 2017 16:24:46 -0800
Message-Id: <20171208002447.20261-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This includes the suggestions by Junio,

Thanks,
Stefan

interdiff to currently queued below.

Stefan Beller (1):
  diffcore: add a filter to find a specific blob

 Documentation/diff-options.txt |  5 +++++
 Makefile                       |  1 +
 builtin/log.c                  |  2 +-
 diff.c                         | 20 +++++++++++++++++++-
 diff.h                         |  3 +++
 diffcore-blobfind.c            | 41 +++++++++++++++++++++++++++++++++++++++++
 diffcore.h                     |  1 +
 revision.c                     |  5 ++++-
 t/t4064-diff-blobfind.sh       | 35 +++++++++++++++++++++++++++++++++++
 9 files changed, 110 insertions(+), 3 deletions(-)
 create mode 100644 diffcore-blobfind.c
 create mode 100755 t/t4064-diff-blobfind.sh

-- 
2.15.1.424.g9478a66081-goog

diff --git c/Documentation/diff-options.txt w/Documentation/diff-options.txt
index 252a21cc19..34d53b95f1 100644
--- c/Documentation/diff-options.txt
+++ w/Documentation/diff-options.txt
@@ -500,6 +500,7 @@ information.
 --pickaxe-regex::
 	Treat the <string> given to `-S` as an extended POSIX regular
 	expression to match.
+
 --blobfind=<blob-id>::
 	Restrict the output such that one side of the diff
 	matches the given blob-id.
diff --git c/diffcore-blobfind.c w/diffcore-blobfind.c
index 5d222fc336..e65c7cad6e 100644
--- c/diffcore-blobfind.c
+++ w/diffcore-blobfind.c
@@ -8,40 +8,30 @@
 static void diffcore_filter_blobs(struct diff_queue_struct *q,
 				  struct diff_options *options)
 {
-	int i, j = 0, c = q->nr;
+	int src, dst;
 
 	if (!options->blobfind)
 		BUG("blobfind oidset not initialized???");
 
-	for (i = 0; i < q->nr; i++) {
-		struct diff_filepair *p = q->queue[i];
+	for (src = dst = 0; src < q->nr; src++) {
+		struct diff_filepair *p = q->queue[src];
 
-		if (DIFF_PAIR_UNMERGED(p) ||
-		    (DIFF_FILE_VALID(p->one) &&
+		if ((DIFF_FILE_VALID(p->one) &&
 		     oidset_contains(options->blobfind, &p->one->oid)) ||
 		    (DIFF_FILE_VALID(p->two) &&
-		     oidset_contains(options->blobfind, &p->two->oid)))
-			continue;
-
-		diff_free_filepair(p);
-		q->queue[i] = NULL;
-		c--;
-	}
-
-	/* Keep it sorted. */
-	i = 0; j = 0;
-	while (i < c) {
-		while (!q->queue[j])
-			j++;
-		q->queue[i] = q->queue[j];
-		i++; j++;
+		     oidset_contains(options->blobfind, &p->two->oid))) {
+			q->queue[dst] = p;
+			dst++;
+		} else {
+			diff_free_filepair(p);
+		}
 	}
 
-	q->nr = c;
-
-	if (!c) {
+	if (!dst) {
 		free(q->queue);
 		DIFF_QUEUE_CLEAR(q);
+	} else {
+		q->nr = dst;
 	}
 }
 
diff --git c/revision.c w/revision.c
index 6449619c0a..8e1a89f832 100644
--- c/revision.c
+++ w/revision.c
@@ -2884,6 +2884,8 @@ int prepare_revision_walk(struct rev_info *revs)
 		simplify_merges(revs);
 	if (revs->children.name)
 		set_children(revs);
+	if (revs->diffopt.blobfind)
+		revs->simplify_history = 0;
 	return 0;
 }
 
