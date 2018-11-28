Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AB681F609
	for <e@80x24.org>; Wed, 28 Nov 2018 21:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbeK2Iq1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 03:46:27 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:22696 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbeK2Iq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 03:46:27 -0500
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:d1:f360:33e:2802:50eb:d77d])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 09A952003DA;
        Wed, 28 Nov 2018 22:43:22 +0100 (CET)
From:   =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH] i18n: fix small typos
Date:   Wed, 28 Nov 2018 22:43:09 +0100
Message-Id: <20181128214309.23523-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Translating the new strings introduced for v2.20 showed some typos.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 http.c | 2 +-
 midx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 3dc8c560d6..eacc2a75ef 100644
--- a/http.c
+++ b/http.c
@@ -834,7 +834,7 @@ static CURL *get_curl_handle(void)
 #if LIBCURL_VERSION_NUM >= 0x072c00
 		curl_easy_setopt(result, CURLOPT_SSL_OPTIONS, CURLSSLOPT_NO_REVOKE);
 #else
-		warning(_("CURLSSLOPT_NO_REVOKE not suported with cURL < 7.44.0"));
+		warning(_("CURLSSLOPT_NO_REVOKE not supported with cURL < 7.44.0"));
 #endif
 	}
 
diff --git a/midx.c b/midx.c
index 730ff84dff..2a6a24fcd7 100644
--- a/midx.c
+++ b/midx.c
@@ -202,7 +202,7 @@ int prepare_midx_pack(struct multi_pack_index *m, uint32_t pack_int_id)
 	struct strbuf pack_name = STRBUF_INIT;
 
 	if (pack_int_id >= m->num_packs)
-		die(_("bad pack-int-id: %u (%u total packs"),
+		die(_("bad pack-int-id: %u (%u total packs)"),
 		    pack_int_id, m->num_packs);
 
 	if (m->packs[pack_int_id])
-- 
2.18.0

