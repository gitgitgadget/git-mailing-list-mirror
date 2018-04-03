Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E967F1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 16:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbeDCQ2u (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 12:28:50 -0400
Received: from mout.gmx.net ([212.227.15.19]:54951 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752431AbeDCQ2s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 12:28:48 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0M6RmV-1eIJUC13SF-00yTyW; Tue, 03 Apr 2018 18:28:39 +0200
Date:   Tue, 3 Apr 2018 18:28:38 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 10/15] config_set_store: rename some fields for
 consistency
In-Reply-To: <cover.1522772789.git.johannes.schindelin@gmx.de>
Message-ID: <d58727931e42cd7c09a4643ca48046582088731d.1522772789.git.johannes.schindelin@gmx.de>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <cover.1522772789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:IbnTrtd9aZSbZivjnCqLaZkxPmyFm+AvXFsmrxxtyyP7aXwyJjV
 UAP8HUkgmOtWAwQSb0he+OULWx4N1pmQR1gk8WLtXIFBgdC48pL/DEV+RR+gOYLCMUzK+VF
 Nod8AlJkYfCdx2PSG+K+hLy8BSxyPcX+32Nl5Y7k2qjsSTlYuM9EzxZI7gy4RYwEJhBjcPN
 GGpJu9FbOpL/Y70Zf9H5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ie4PKTSrj+M=:Sp+pCj/yGl1My7PkGyQ0Bo
 di0ZSkorbUMxZP6Xy1pMZt1mb9ugzhKLtqOc/U2rv52khMl9hSQ/jmB46jsQyisRcc7c70Lwp
 XPg7IWcoG7nnh2LNvIIxm4iTsnY05RpW0qoIUC5sL0z1Z25scf7n1XajcIu7VhNmGmj+MPZr/
 IuvwBvfI2s6In+7k58SGNvL7JkJXHtdkW9DXY/fyIqyjK9GTNsiJDab7pfh2/cVjI8BIgNJC6
 nk7ukCVNG/mMvcfTcHCSnCFUEpnUUnfoFyyMvzgOz9WphmzpJDxrgflPRhrPkZp3p6UnKsVc1
 cvsGa9Wh4sjk+/Q7DelI+tpKTvPrtOz7Iv+RZnAxPvVhexD7iVlrTn0IOO+L5v5DUnQhlZ6CU
 upG5q/nGTW6M3aWvQvJYnwXUhvcHdA8/lDdytOqFxzWZCc59jDEEFu8J8iK8S8WyiIzsayZkh
 rXxmdXb0lqTXqCQVtx8zLaVKLIAUoqUUMr9nuGMkZ2cQxrsmZa6xcbMrOMKP0urL2o4IOJKbQ
 fWPnEOqP3Jc89ufgfkrOaBnLjIxlyBBrmmAj/nISRtjUqlm9w0vseNVrc1NHZUTi3vN7Vu/og
 uDMfa/9arUGU93IBXeM04PuVhtEyw9L9FfamBkAn/D6ZF/JsM1LLuPC6ZUhJI2mbh7gDuqNJd
 xvQELxTB3tiXz+Ce5TAWJD+W3+HpEWNLRcqnriI2009bJVHpIzTrKyLdimpO6YYQLmAp8wATj
 +CN4ZTQUOYbuqGnCOlETxJ3ScPi65MMFcm5hE2x5RKkSdh/5DMQenT8OXQZzyd4gbe7OVlXmW
 IWgNj5pgQXqVecS9wy/iiI9R3CwyIiACGiqRQqKmSlftV6OEsYCMt4II63uf+dNC8zIb9IO
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
 config.c | 63 +++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/config.c b/config.c
index 90ae71cb905..b73b48b5650 100644
--- a/config.c
+++ b/config.c
@@ -2303,10 +2303,9 @@ struct config_set_store {
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
@@ -2332,15 +2331,15 @@ static int store_aux(const char *key, const char *value, void *cb)
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
@@ -2366,26 +2365,26 @@ static int store_aux(const char *key, const char *value, void *cb)
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
@@ -2645,10 +2644,10 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
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
@@ -2676,8 +2675,8 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		}
 
 		/* if nothing to unset, or too many matches, error out */
-		if ((store.seen == 0 && value == NULL) ||
-				(store.seen > 1 && multi_replace == 0)) {
+		if ((store.seen_nr == 0 && value == NULL) ||
+		    (store.seen_nr > 1 && multi_replace == 0)) {
 			ret = CONFIG_NOTHING_SET;
 			goto out_free;
 		}
@@ -2708,19 +2707,19 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
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
@@ -2734,7 +2733,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 				    write_str_in_full(fd, "\n") < 0)
 					goto write_err_out;
 			}
-			copy_begin = store.offset[i];
+			copy_begin = store.seen[i];
 		}
 
 		/* write the pair (value == NULL means unset) */
-- 
2.16.2.windows.1.26.g2cc3565eb4b


