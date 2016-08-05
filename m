Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F03CF2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 20:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423464AbcHEU5V (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 16:57:21 -0400
Received: from avasout07.plus.net ([84.93.230.235]:44848 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2998742AbcHEU5T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 16:57:19 -0400
Received: from [10.0.2.15] ([209.93.82.95])
	by avasout07 with smtp
	id TYxF1t00723PrXV01YxGRt; Fri, 05 Aug 2016 21:57:16 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=UYYTc+aN c=1 sm=1 tr=0
 a=MrGUH+yfTxdMEvUZuMmDjA==:117 a=MrGUH+yfTxdMEvUZuMmDjA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=bozjXHrZ7EsA1SsZHrEA:9
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH:	ramsayjones@:2500
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
From:	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] xdiffi.c: mark some file-local symbols as static
Message-ID: <29c40cdd-363a-df09-f9e2-fe9070bb8a9c@ramsayjones.plus.com>
Date:	Fri, 5 Aug 2016 21:57:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Michael,

If you need to re-roll your 'mh/diff-indent-heuristic' branch, could
you please squash this into the relevant patch (e199b6e2, "diff: improve
positioning of add/delete blocks in diffs", 04-08-2016).

Thanks!

ATB,
Ramsay Jones

 xdiff/xdiffi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 80307f5..90226f8 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -499,7 +499,7 @@ struct split_measurement {
 /*
  * Fill m with information about a hypothetical split of xdf above line split.
  */
-void measure_split(const xdfile_t *xdf, long split, struct split_measurement *m)
+static void measure_split(const xdfile_t *xdf, long split, struct split_measurement *m)
 {
 	long i;
 
@@ -557,7 +557,7 @@ void measure_split(const xdfile_t *xdf, long split, struct split_measurement *m)
  * Also see that project if you want to improve the weights based on, for example,
  * a larger or more diverse corpus.
  */
-int score_split(const struct split_measurement *m)
+static int score_split(const struct split_measurement *m)
 {
 	/*
 	 * A place to accumulate bonus factors (positive makes this index more
-- 
2.9.0
