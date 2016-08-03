Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 061D61F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 22:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932831AbcHCWIp (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 18:08:45 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:49703 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932378AbcHCWIj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2016 18:08:39 -0400
X-AuditID: 12074413-aa3ff70000000955-d6-57a26991d112
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 57.B0.02389.19962A75; Wed,  3 Aug 2016 18:00:49 -0400 (EDT)
Received: from michael.fritz.box (p57907C5F.dip0.t-ipconnect.de [87.144.124.95])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u73M0fSa023677
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 3 Aug 2016 18:00:48 -0400
From:	Michael Haggerty <mhagger@alum.mit.edu>
To:	git@vger.kernel.org
Cc:	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/8] xdl_change_compact(): rename i to end
Date:	Thu,  4 Aug 2016 00:00:31 +0200
Message-Id: <625e39916051e2ea5e09e1c0d3c4f6c25e61302d.1470259583.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1470259583.git.mhagger@alum.mit.edu>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsUixO6iqDsxc1G4wZTVqhZdV7qZLBp6rzBb
	7F7cz2yx4uocZovbK+YzW/xo6WG22Ly5ncWB3ePv+w9MHjtn3WX3WLCp1ONZ7x5Gj4uXlD0+
	b5ILYIvisklJzcksSy3St0vgyri++gBrwUOdit0n9jM1MM5S6GLk5JAQMJE4v/85YxcjF4eQ
	wFZGidlvV7CBJIQEjjNJnH5hB2KzCehKLOppZgKxRQTEJd4en8kO0sAs0M8k8aOjC6ibg0NY
	wEri5I4oEJNFQFVi0m49kHJegSiJk8eXsULskpO4PP0B2HhOAQuJq5NmM0GsMpd427GLdQIj
	zwJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFuuZ6uZkleqkppZsYISElvINx10m5Q4wCHIxK
	PLwbJBeFC7EmlhVX5h5ilORgUhLlzUkFCvEl5adUZiQWZ8QXleakFh9ilOBgVhLhvZcClONN
	SaysSi3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfBezABqFCxKTU+tSMvMKUFI
	M3FwggznARr+AqSGt7ggMbc4Mx0if4pRUUqc1yIdKCEAksgozYPrhcX8K0ZxoFeEee1A2nmA
	6QKu+xXQYCagwScMFoAMLklESEk1MAYzSWxMXp77k/lV3hau+9+qn5xw+5mgtjtVw/TH0koX
	viM3dzfVfzL6EhAT1cJSJLT0qV9biMIxu61rJgX6LuyxeqSevrto4mtJqajT71tzLlWEeXyI
	uKf9Rj90pa14fKq+k0PaCaa7RffV8ioyDvZ8iJvUs2We0GUTY5vNfV/vLpaL9tWpUmIpzkg0
	1GIuKk4EAI7XTOrUAgAA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Rename i to end, and alternate between using start and end as the
indexing variable as appropriate.

Rename ixref to end_matching_other.

Add some more comments.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 xdiff/xdiffi.c | 70 ++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 39 insertions(+), 31 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index a0a485c..0f235bc 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -414,7 +414,7 @@ static int recs_match(xrecord_t **recs, long ixs, long ix, long flags)
 }
 
 int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
-	long i, io, start, ixref, groupsize, nrec = xdf->nrec;
+	long start, end, io, end_matching_other, groupsize, nrec = xdf->nrec;
 	char *rchg = xdf->rchg, *rchgo = xdfo->rchg;
 	unsigned int blank_lines;
 	xrecord_t **recs = xdf->recs;
@@ -424,7 +424,8 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 	 * change groups for a consistent and pretty diff output. This also
 	 * helps in finding joinable change groups and reduce the diff size.
 	 */
-	for (i = io = 0;;) {
+	end = io = 0;
+	while (1) {
 		/*
 		 * Find the first changed line in the to-be-compacted file.
 		 * We need to keep track of both indexes, so if we find a
@@ -434,7 +435,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 		 * not need index bounding since the array is prepared with
 		 * a zero at position -1 and N.
 		 */
-		for (; i < nrec && !rchg[i]; i++) {
+		for (start = end; start < nrec && !rchg[start]; start++) {
 			/* skip over any changed lines in the other file... */
 			while (rchgo[io])
 				io++;
@@ -442,24 +443,29 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			/* ...plus one non-changed line. */
 			io++;
 		}
-		if (i == nrec)
+		if (start == nrec)
 			break;
 
 		/*
-		 * Record the start of a changed-group in the to-be-compacted file
-		 * and find the end of it, on both to-be-compacted and other file
-		 * indexes (i and io).
+		 * That's the start of a changed-group in the to-be-compacted
+		 * file. Now find its end.
 		 */
-		start = i++;
-
-		while (rchg[i])
-			i++;
+		end = start + 1;
+		while (rchg[end])
+			end++;
 
 		while (rchgo[io])
 		       io++;
 
+		/*
+		 * Now shift the change up and then down as far as possible in
+		 * each direction. If it bumps into any other changes, merge them.
+		 * If there are any changes in the other file that this change
+		 * could line up with, set end_matching_other to the end position
+		 * of this change that would leave them aligned.
+		 */
 		do {
-			groupsize = i - start;
+			groupsize = end - start;
 
 			/*
 			 * Are there any blank lines that could appear as the last
@@ -472,9 +478,9 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 * to the last line of the current change group, shift the
 			 * group backward.
 			 */
-			while (start > 0 && recs_match(recs, start - 1, i - 1, flags)) {
+			while (start > 0 && recs_match(recs, start - 1, end - 1, flags)) {
 				rchg[--start] = 1;
-				rchg[--i] = 0;
+				rchg[--end] = 0;
 
 				/*
 				 * This change might have joined two change groups.
@@ -501,13 +507,13 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 				 * the other file. Record the end-of-group
 				 * position:
 				 */
-				ixref = i;
+				end_matching_other = end;
 			} else {
 				/*
 				 * Otherwise, set a value to signify that there
 				 * are no matched changes in the other file:
 				 */
-				ixref = nrec;
+				end_matching_other = -1;
 			}
 
 			/*
@@ -515,11 +521,11 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 * of the current change group is equal to the line after
 			 * the current change group.
 			 */
-			while (i < nrec && recs_match(recs, start, i, flags)) {
-				blank_lines += is_blank_line(recs, i, flags);
+			while (end < nrec && recs_match(recs, start, end, flags)) {
+				blank_lines += is_blank_line(recs, end, flags);
 
 				rchg[start++] = 0;
-				rchg[i++] = 1;
+				rchg[end++] = 1;
 
 				/*
 				 * This change might have joined two change
@@ -529,29 +535,31 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 				 * are shifting together with a corresponding
 				 * group of changes in the other file.
 				 */
-				while (rchg[i])
-					i++;
+				while (rchg[end])
+					end++;
 
 				io++;
 				if (rchgo[io]) {
-					ixref = i;
+					end_matching_other = end;
 					while (rchgo[io])
 						io++;
 				}
 			}
-		} while (groupsize != i - start);
+		} while (groupsize != end - start);
 
 		/*
 		 * Try to move back the possibly merged group of changes, to match
 		 * the recorded position in the other file.
 		 */
-		while (ixref < i) {
-			rchg[--start] = 1;
-			rchg[--i] = 0;
+		if (end_matching_other != -1) {
+			while (end_matching_other < end) {
+				rchg[--start] = 1;
+				rchg[--end] = 0;
 
-			io--;
-			while (rchgo[io])
 				io--;
+				while (rchgo[io])
+					io--;
+			}
 		}
 
 		/*
@@ -564,10 +572,10 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 		 */
 		if ((flags & XDF_COMPACTION_HEURISTIC) && blank_lines) {
 			while (start > 0 &&
-			       !is_blank_line(recs, i - 1, flags) &&
-			       recs_match(recs, start - 1, i - 1, flags)) {
+			       !is_blank_line(recs, end - 1, flags) &&
+			       recs_match(recs, start - 1, end - 1, flags)) {
 				rchg[--start] = 1;
-				rchg[--i] = 0;
+				rchg[--end] = 0;
 			}
 		}
 	}
-- 
2.8.1

