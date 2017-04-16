Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D66B20A04
	for <e@80x24.org>; Sun, 16 Apr 2017 06:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755461AbdDPGnB (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 02:43:01 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:42496 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755313AbdDPGm6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Apr 2017 02:42:58 -0400
X-AuditID: 1207440c-aa5ff70000002e8f-fa-58f3126fddd2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id D7.A0.11919.F6213F85; Sun, 16 Apr 2017 02:42:55 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B1058DF.dip0.t-ipconnect.de [91.16.88.223])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3G6gGNG025813
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 16 Apr 2017 02:42:53 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 15/20] get_loose_ref_dir(): function renamed from get_loose_refs()
Date:   Sun, 16 Apr 2017 08:41:37 +0200
Message-Id: <6e96eca71e235064c4dcfb68fa8943a3379cbef1.1492323985.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1492323985.git.mhagger@alum.mit.edu>
References: <cover.1492323985.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsUixO6iqJsv9DnC4P5teYu1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfGlFOT2QvWclX8X/6crYHxCkcXIyeHhICJ
        xMLlm9lBbCGBHUwS/zYldTFyAdknmCRunjrIBJJgE9CVWNTTDGaLCKhJTGw7xAJSxCzwmEni
        77JuFpCEsECoxPetK8FsFgFViWenNrGC2LwCURIznmxnhtgmL7Gr7SJYnFPAQmLK3Q0sEJvN
        JbYfv8o8gZFnASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdQ73czBK91JTSTYyQUOPZwfht
        ncwhRgEORiUeXgv/TxFCrIllxZW5hxglOZiURHll/gOF+JLyUyozEosz4otKc1KLDzFKcDAr
        ifAms3yOEOJNSaysSi3Kh0lJc7AoifOqLlH3ExJITyxJzU5NLUgtgsnKcHAoSfBGCwI1Chal
        pqdWpGXmlCCkmTg4QYbzAA1PB6nhLS5IzC3OTIfIn2JUlBLn/SEAlBAASWSU5sH1wlLBK0Zx
        oFeEebeCtPMA0whc9yugwUxAgxkmfwAZXJKIkJJqYFwm3t+4jWF11Z3rK861sWgJ3jn++YKK
        3jYLUY7XXBwLVua1XwzZ0huV6L3DR57X+N+bQyx2T7UXL1iy1EXfbfn/+DpvvsUL2Hza+F5+
        Un29WMeoiTm3btqsbo9r8RLZM4/kn1pseF66+HGn+W6NYuXwL3XpQccWCu3PW8FslWyuuI3r
        xv4wdSWW4oxEQy3mouJEADg1iH3gAgAA
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
index c0550ad9d6..3beab0b752 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -524,7 +524,7 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 	}
 }
 
-static struct ref_dir *get_loose_refs(struct files_ref_store *refs)
+static struct ref_dir *get_loose_ref_dir(struct files_ref_store *refs)
 {
 	if (!refs->loose) {
 		/*
@@ -1110,7 +1110,7 @@ static struct ref_iterator *files_ref_iterator_begin(
 	 * date with what is on disk, and re-reads it if not.
 	 */
 
-	loose_dir = get_loose_refs(refs);
+	loose_dir = get_loose_ref_dir(refs);
 
 	if (prefix && *prefix)
 		loose_dir = find_containing_dir(loose_dir, prefix, 0);
@@ -1581,7 +1581,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	lock_packed_refs(refs, LOCK_DIE_ON_ERROR);
 	cbdata.packed_refs = get_packed_refs(refs);
 
-	do_for_each_entry_in_dir(get_loose_refs(refs),
+	do_for_each_entry_in_dir(get_loose_ref_dir(refs),
 				 pack_if_possible_fn, &cbdata);
 
 	if (commit_packed_refs(refs))
-- 
2.11.0

