Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFE0C1F424
	for <e@80x24.org>; Mon,  9 Apr 2018 08:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752076AbeDIIcX (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 04:32:23 -0400
Received: from mout.gmx.net ([212.227.17.22]:59513 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751998AbeDIIcW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 04:32:22 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MV1wf-1ezjcH391p-00YUJO; Mon, 09
 Apr 2018 10:32:12 +0200
Date:   Mon, 9 Apr 2018 10:32:13 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v3 11/15] config_set_store: rename some fields for
 consistency
In-Reply-To: <cover.1523262449.git.johannes.schindelin@gmx.de>
Message-ID: <6f7ed0721749001fa73dadfd271bac255ea8651d.1523262449.git.johannes.schindelin@gmx.de>
References: <cover.1522772789.git.johannes.schindelin@gmx.de> <cover.1523262449.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Sl0KDYF1TSfmFEfLJL01zxJ7hDPG98Tsu0k4UEYNucwSl3+gryP
 cnx2mq4Tmqw4Zpz+isamAcyV5AcHsfbNeyPPEgGn3lV3Xv5T20JaUaJYGJq0GD/K5zW66+5
 mo+00GPSCSUpspwi1Cqy3pZcaCWYF9gj+8E106TB/mSttcbrKpTpySlKSY7x5WEjA9kdgqs
 y7+BViF1OPm5TTkZQaHXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZpxGJaYAA4M=:2Buk9kmGhaggbvm2iSDzXC
 1ZoOxHhf1vLINQNAGWxOTXSbUGRaxpdl5gKpUOBcXpIY+4yAXS42tDEid8348xEJjjlDG4sd9
 jpPumhk3uSw89wqG0MQBydaLk0OSriibdB26SHMMXM1YP2/dTCR63e4DUi37EsQKFQc54BBLP
 /k/lsf6gDeCUy3Oh0YtHIoK0+rWKuEZuEU0RjhbYYk2nqN3uOGprCMgHreZFpG0zdXDTEj5P4
 fJnvltMYK0861Wj7IxyLkgWp+xOcmbz8qpzXpjZwHv/2CLIaxcOfgPImlQ+AiuG0HbC/D8aPA
 KxkHBYp/Yjwad0CurtfBuQ7NOFrOiyTJ2tDu78q68N8uU4Vxz6qo9IcpPMEDeRClr+IqQ+fu8
 swXbEjAfQL2uMvzcik8AHQMPuop8yLybjzlhTbJWFGD7JocdDujnLYGd1jyhvGj06t2WxG13m
 ng/LVDLwkKom8LjcT1LWp0Lq0VVF0Z/0XfKq+tLmIVk9yZQk1YsvHcM5cyJrAjs2V3kKq4YLI
 Tb48DNws6IU9oj4QmNG7Ad92gdnplOTBQQpPHo1Qc66JHrWUS/Xy4cLYzfhJIone4nt/pVzrh
 MNYsKPGTA34Jhx1t8s3vzHFzrAbKIYqDa1QpnXzHS0CK/uJENiIU8LVjxmrkr07cAWUowcJBq
 dkvBo7qhOXE0607O9+g4VSq68U5DHvO2cc0iipie9fFLAcqrJyzDDWtaj8QgtjO1ZOtGUGpj1
 mewWz58zCHBlCF6ykDjJuJqFk1G7V9gfWKSVBHgpwtZfXv0AdCzZeo0ugJuXEUUWeKKo8wJoj
 5i78fZnDMDD5XieMe+0r+wir2mQbFHirL6ksmkBNQJTvPEIo5s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `seen` field is the actual length of the `offset` array, and the
`offset_alloc` field records what was allocated (to avoid resizing
wherever `seen` has to be incremented).

Elsewhere, we use the convention `name` for the array, where `name` is
descriptive enough to guess its purpose, `name_nr` for the actual length
and `name_alloc` to record the maximum length without needing to resize.

Let's make the names of the fields in question consistent with that
convention.

This will also help with the next steps where we will let the
git_config_set() machinery use the config event stream that we just
introduced.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c | 63 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/config.c b/config.c
index 0c0a965267d..2341620c11a 100644
--- a/config.c
+++ b/config.c
@@ -2302,10 +2302,9 @@ struct config_store_data {
 	int do_not_match;
 	regex_t *value_regex;
 	int multi_replace;
-	size_t *offset;
-	unsigned int offset_alloc;
+	size_t *seen;
+	unsigned int seen_nr, seen_alloc;
 	enum { START, SECTION_SEEN, SECTION_END_SEEN, KEY_SEEN } state;
-	unsigned int seen;
 };
 
 static int matches(const char *key, const char *value,
@@ -2331,15 +2330,15 @@ static int store_aux(const char *key, const char *value, void *cb)
 	switch (store->state) {
 	case KEY_SEEN:
 		if (matches(key, value, store)) {
-			if (store->seen == 1 && store->multi_replace == 0) {
+			if (store->seen_nr == 1 && store->multi_replace == 0) {
 				warning(_("%s has multiple values"), key);
 			}
 
-			ALLOC_GROW(store->offset, store->seen + 1,
-				   store->offset_alloc);
+			ALLOC_GROW(store->seen, store->seen_nr + 1,
+				   store->seen_alloc);
 
-			store->offset[store->seen] = cf->do_ftell(cf);
-			store->seen++;
+			store->seen[store->seen_nr] = cf->do_ftell(cf);
+			store->seen_nr++;
 		}
 		break;
 	case SECTION_SEEN:
@@ -2365,26 +2364,26 @@ static int store_aux(const char *key, const char *value, void *cb)
 		 * Do not increment matches: this is no match, but we
 		 * just made sure we are in the desired section.
 		 */
-		ALLOC_GROW(store->offset, store->seen + 1,
-			   store->offset_alloc);
-		store->offset[store->seen] = cf->do_ftell(cf);
+		ALLOC_GROW(store->seen, store->seen_nr + 1,
+			   store->seen_alloc);
+		store->seen[store->seen_nr] = cf->do_ftell(cf);
 		/* fallthru */
 	case SECTION_END_SEEN:
 	case START:
 		if (matches(key, value, store)) {
-			ALLOC_GROW(store->offset, store->seen + 1,
-				   store->offset_alloc);
-			store->offset[store->seen] = cf->do_ftell(cf);
+			ALLOC_GROW(store->seen, store->seen_nr + 1,
+				   store->seen_alloc);
+			store->seen[store->seen_nr] = cf->do_ftell(cf);
 			store->state = KEY_SEEN;
-			store->seen++;
+			store->seen_nr++;
 		} else {
 			if (strrchr(key, '.') - key == store->baselen &&
 			      !strncmp(key, store->key, store->baselen)) {
 					store->state = SECTION_SEEN;
-					ALLOC_GROW(store->offset,
-						   store->seen + 1,
-						   store->offset_alloc);
-					store->offset[store->seen] =
+					ALLOC_GROW(store->seen,
+						   store->seen_nr + 1,
+						   store->seen_alloc);
+					store->seen[store->seen_nr] =
 						cf->do_ftell(cf);
 			}
 		}
@@ -2644,10 +2643,10 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 			}
 		}
 
-		ALLOC_GROW(store.offset, 1, store.offset_alloc);
-		store.offset[0] = 0;
+		ALLOC_GROW(store.seen, 1, store.seen_alloc);
+		store.seen[0] = 0;
 		store.state = START;
-		store.seen = 0;
+		store.seen_nr = 0;
 
 		/*
 		 * After this, store.offset will contain the *end* offset
@@ -2675,8 +2674,8 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		}
 
 		/* if nothing to unset, or too many matches, error out */
-		if ((store.seen == 0 && value == NULL) ||
-				(store.seen > 1 && multi_replace == 0)) {
+		if ((store.seen_nr == 0 && value == NULL) ||
+		    (store.seen_nr > 1 && multi_replace == 0)) {
 			ret = CONFIG_NOTHING_SET;
 			goto out_free;
 		}
@@ -2707,19 +2706,19 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 			goto out_free;
 		}
 
-		if (store.seen == 0)
-			store.seen = 1;
+		if (store.seen_nr == 0)
+			store.seen_nr = 1;
 
-		for (i = 0, copy_begin = 0; i < store.seen; i++) {
+		for (i = 0, copy_begin = 0; i < store.seen_nr; i++) {
 			new_line = 0;
-			if (store.offset[i] == 0) {
-				store.offset[i] = copy_end = contents_sz;
+			if (store.seen[i] == 0) {
+				store.seen[i] = copy_end = contents_sz;
 			} else if (store.state != KEY_SEEN) {
-				copy_end = store.offset[i];
+				copy_end = store.seen[i];
 			} else
 				copy_end = find_beginning_of_line(
 					contents, contents_sz,
-					store.offset[i], &new_line);
+					store.seen[i], &new_line);
 
 			if (copy_end > 0 && contents[copy_end-1] != '\n')
 				new_line = 1;
@@ -2733,7 +2732,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 				    write_str_in_full(fd, "\n") < 0)
 					goto write_err_out;
 			}
-			copy_begin = store.offset[i];
+			copy_begin = store.seen[i];
 		}
 
 		/* write the pair (value == NULL means unset) */
-- 
2.17.0.windows.1.4.g7e4058d72e3


