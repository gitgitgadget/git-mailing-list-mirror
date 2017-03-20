Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2FEF20958
	for <e@80x24.org>; Mon, 20 Mar 2017 16:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932069AbdCTQeV (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 12:34:21 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:42244 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753311AbdCTQeN (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 12:34:13 -0400
X-AuditID: 1207440f-141ff70000003517-ef-58d0047888b8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 4A.8B.13591.87400D85; Mon, 20 Mar 2017 12:34:01 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906F9B.dip0.t-ipconnect.de [87.144.111.155])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2KGXV9P010511
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 20 Mar 2017 12:33:59 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 15/20] get_loose_ref_dir(): function renamed from get_loose_refs()
Date:   Mon, 20 Mar 2017 17:33:20 +0100
Message-Id: <d3395566e28fee9c8d1a64314f8e46c42b0babf0.1490026594.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490026594.git.mhagger@alum.mit.edu>
References: <cover.1490026594.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsUixO6iqFvJciHC4PNPfouuK91MFg29V5gt
        bq+Yz2yx5OFrZovuKW8ZLX609DA7sHn8ff+ByWPnrLvsHl3tR9g8nvXuYfS4eEnZ4/MmuQC2
        KC6blNSczLLUIn27BK6Muy83MRas5ap4vOUVWwPjFY4uRk4OCQETib9LtrJ1MXJxCAnsYJI4
        dmctO4Rzikli6p/TrCBVbAK6Eot6mplAbBEBNYmJbYdYQIqYBR4xSlydf5cdJCEsECTx8ugh
        ZhCbRUBV4tCJX2wgNq9AlMTBNZNZIdbJS+xquwhmcwpYSHy538gCYgsJmEt0Luhln8DIs4CR
        YRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrolebmaJXmpK6SZGSEDx72DsWi9ziFGAg1GJh5fh
        +vkIIdbEsuLK3EOMkhxMSqK8T28DhfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwVr0EyvGmJFZW
        pRblw6SkOViUxHnVl6j7CQmkJ5akZqemFqQWwWRlODiUJHjZgZEjJFiUmp5akZaZU4KQZuLg
        BBnOAzT8GTNQDW9xQWJucWY6RP4Uo6KUOO85JqCEAEgiozQPrhcW8a8YxYFeEeb9ClLFA0wW
        cN2vgAYzAQ1eduMMyOCSRISUVANj0VXff3e7NFX+Hg1Y/jxYYNkn782JOg/ZElk9Vf/r7wvh
        jehtk5T8tae+JEhuTmeqyIeo4un90ycfTzX9mLS+3S2q7ppwy9WTvzNffy/OkP7BY7VKaFL2
        hEuNInMWPG481JPLHHV7ibWdXTdDz1mjGauuy4umOd8Li4nvPxk8/cqlPetyGmSUWIozEg21
        mIuKEwF7O0R90wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new name is more analogous to `get_packed_ref_dir()`.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0ff5df6b46..0a16f6196c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -525,7 +525,7 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 	}
 }
 
-static struct ref_dir *get_loose_refs(struct files_ref_store *refs)
+static struct ref_dir *get_loose_ref_dir(struct files_ref_store *refs)
 {
 	if (!refs->loose) {
 		/*
@@ -1113,7 +1113,7 @@ static struct ref_iterator *files_ref_iterator_begin(
 	 * date with what is on disk, and re-reads it if not.
 	 */
 
-	loose_dir = get_loose_refs(refs);
+	loose_dir = get_loose_ref_dir(refs);
 
 	if (prefix && *prefix)
 		loose_dir = find_containing_dir(loose_dir, prefix, 0);
@@ -1584,7 +1584,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	lock_packed_refs(refs, LOCK_DIE_ON_ERROR);
 	cbdata.packed_refs = get_packed_refs(refs);
 
-	do_for_each_entry_in_dir(get_loose_refs(refs),
+	do_for_each_entry_in_dir(get_loose_ref_dir(refs),
 				 pack_if_possible_fn, &cbdata);
 
 	if (commit_packed_refs(refs))
-- 
2.11.0

