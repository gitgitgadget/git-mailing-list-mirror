Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2CAB1F406
	for <e@80x24.org>; Mon, 15 Jan 2018 12:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933547AbeAOMRz (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 07:17:55 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:50800 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932252AbeAOMRy (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Jan 2018 07:17:54 -0500
X-AuditID: 1207440c-e35ff70000000ab3-6b-5a5c9bee40ca
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 88.9E.02739.EEB9C5A5; Mon, 15 Jan 2018 07:17:51 -0500 (EST)
Received: from bagpipes.fritz.box (p54AAEF2D.dip0.t-ipconnect.de [84.170.239.45])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w0FCHiEq010101
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 15 Jan 2018 07:17:48 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Kim Gybels <kgybels@infogroep.be>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/3] SQUASH? Mention that `snapshot::buf` can be NULL for empty files
Date:   Mon, 15 Jan 2018 13:17:33 +0100
Message-Id: <131281e13bd6c25246e0e0ab263fc9a2f364d6e0.1516017331.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180114191416.2368-1-kgybels@infogroep.be>
References: <20180114191416.2368-1-kgybels@infogroep.be>
In-Reply-To: <cover.1516017331.git.mhagger@alum.mit.edu>
References: <cover.1516017331.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsUixO6iqPt+dkyUwc4J2hZdV7qZLBp6rzBb
        9C/vYrM42DmT1eL2ivnMDqwef99/YPL48DHOo+/IGkaPi5eUPT5vkgtgjeKySUnNySxLLdK3
        S+DK2DdlNnPBRI6K7/OvsDcw7mTrYuTkkBAwkVi/eStzFyMXh5DADiaJH3fOsEA4F5kkDuxa
        xgJSxSagK7Gop5kJxBYRUJU4OH8KI0gRs8AKRom1TT1gCWGBUInT99+CjWUBKtr9ZCpYM69A
        lMTsq3eYINbJS7xfcJ8RxOYUsJQ4+m4bWL2QgIXEp0OfgM7gAIpbSKy7kAwRNpc4+b2TfQIj
        3wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFuoZ6uZkleqkppZsYIYHGs4Px2zqZQ4wCHIxK
        PLwRy6KjhFgTy4orcw8xSnIwKYnyqvfGRAnxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4W0MBsrx
        piRWVqUW5cOkpDlYlMR5VZeo+wkJpCeWpGanphakFsFkZTg4lCR4fYERJSRYlJqeWpGWmVOC
        kGbi4AQZzgM0PBakhre4IDG3ODMdIn+KUZfjxovXbcxCLHn5ealS4rxds4CKBECKMkrz4ObA
        EsQrRnGgt4R5b4FU8QCTC9ykV0BLmICW1C+JBFlSkoiQkmpgDOfaYPN+/vqwhZNX7JA7e/dO
        izP/3JC4g/pBpQ0tDIJ653pzYlZtL0ljeXZ+Wq23zMM5872/FEoqK+VOjv1ZbyDbVa9zS7NW
        +p1mLJe7TPVX2S99yw30J6zy73RfdeqOkIUU/8cWwbvTFtjuuHHe4dW+734ncqbNmHnioPCl
        vS+0NXbnNzxersRSnJFoqMVcVJwIAPrhCxDrAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 01a13cb817..f20f05b4df 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -69,11 +69,11 @@ struct snapshot {
 
 	/*
 	 * The contents of the `packed-refs` file. If the file was
-	 * already sorted, this points at the mmapped contents of the
-	 * file. If not, this points at heap-allocated memory
-	 * containing the contents, sorted. If there were no contents
-	 * (e.g., because the file didn't exist), `buf` and `eof` are
-	 * both NULL.
+	 * already sorted and if mmapping is allowed, this points at
+	 * the mmapped contents of the file. If not, this points at
+	 * heap-allocated memory containing the contents, sorted. If
+	 * there were no contents (e.g., because the file didn't exist
+	 * or was empty), `buf` and `eof` are both NULL.
 	 */
 	char *buf, *eof;
 
-- 
2.14.2

