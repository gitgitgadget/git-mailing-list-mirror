Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E958F2070D
	for <e@80x24.org>; Sat, 31 Dec 2016 03:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754574AbcLaDNO (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Dec 2016 22:13:14 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:53299 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754540AbcLaDNN (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Dec 2016 22:13:13 -0500
X-AuditID: 12074411-fbbff700000009b7-4e-58672246efaa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id D3.63.02487.64227685; Fri, 30 Dec 2016 22:13:11 -0500 (EST)
Received: from bagpipes.fritz.box (p5B104C0E.dip0.t-ipconnect.de [91.16.76.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBV3D6tt010692
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 30 Dec 2016 22:13:09 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 01/23] files_rename_ref(): tidy up whitespace
Date:   Sat, 31 Dec 2016 04:12:41 +0100
Message-Id: <129f09835a10512ad532ff9521a1b279994324ff.1483153436.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483153436.git.mhagger@alum.mit.edu>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsUixO6iqOuulB5hMHGymUXXlW4mi4beK8wW
        t1fMZ7ZY8vA1s8WPlh5mB1aPv+8/MHl0tR9h83jWu4fR4+IlZY/Pm+QCWKO4bFJSczLLUov0
        7RK4Mk7NXMtU0MZaMfHKD+YGxj6WLkZODgkBE4nd/zaydjFycQgJXGaUeH1wB5RznEni1IIm
        VpAqNgFdiUU9zUwgtoiAmsTEtkMsIEXMAhMZJaZtuQSWEBZwkNjRfIsNxGYRUJU4vGc1mM0r
        ECVxuHcKI8Q6OYlL274wg9icAhYSiz/1gfUKCZhLrNt5iXkCI88CRoZVjHKJOaW5urmJmTnF
        qcm6xcmJeXmpRbqmermZJXqpKaWbGCHBI7iDccZJuUOMAhyMSjy8D26kRQixJpYVV+YeYpTk
        YFIS5bW0TI0Q4kvKT6nMSCzOiC8qzUktPsQowcGsJMK7UC49Qog3JbGyKrUoHyYlzcGiJM7L
        t0TdT0ggPbEkNTs1tSC1CCYrw8GhJMGroAjUKFiUmp5akZaZU4KQZuLgBBnOAzTcH6SGt7gg
        Mbc4Mx0if4pRl+PA+xVPmYRY8vLzUqXEedcqABUJgBRllObBzYFF/StGcaC3hHlZQUbxABMG
        3KRXQEuYgJao5SSDLClJREhJNTBWz3x92+eYxRM+JuOsBSFM/kFsBn/F5C7n+fslvZl0Xy5s
        +cnjz1do3vnJvbvh6jEu77yYF6tFkudPsNRI1JxRW+Ca8uPkIqkD/x54l09Z1/hHaxbnkqWT
        w6POXgld5Py76bflG9uIeV9ubX1fXLRkj1rBxqcdP72dZvNN8T1QNqPsu7n6pB97lViKMxIN
        tZiLihMB/XvRVtUCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index f902393..be4ffdc 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2631,7 +2631,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 	if (!read_ref_full(newrefname, RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
 			   sha1, NULL) &&
 	    delete_ref(newrefname, NULL, REF_NODEREF)) {
-		if (errno==EISDIR) {
+		if (errno == EISDIR) {
 			struct strbuf path = STRBUF_INIT;
 			int result;
 
-- 
2.9.3

