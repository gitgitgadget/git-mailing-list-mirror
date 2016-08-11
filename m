Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AA2420193
	for <e@80x24.org>; Thu, 11 Aug 2016 19:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbcHKT6D (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 15:58:03 -0400
Received: from avasout07.plus.net ([84.93.230.235]:38658 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbcHKT6C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 15:58:02 -0400
Received: from [10.0.2.15] ([209.93.82.95])
	by avasout07 with smtp
	id Vvxy1t00323PrXV01vxzKn; Thu, 11 Aug 2016 20:57:59 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=UYYTc+aN c=1 sm=1 tr=0
 a=MrGUH+yfTxdMEvUZuMmDjA==:117 a=MrGUH+yfTxdMEvUZuMmDjA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=OF09KEZyudElgfBYXCwA:9
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH:	ramsayjones@:2500
To:	Stefan Beller <sbeller@google.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
From:	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] submodule: mark a file-local symbol as static
Message-ID: <322d7d47-423c-f631-3057-1feb03d50591@ramsayjones.plus.com>
Date:	Thu, 11 Aug 2016 20:57:58 +0100
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

Hi Stefan,

If you need to re-roll your 'sb/submodule-clone-rr' branch, could
you please squash this into the relevant patch (commit 336c21d,
"submodule: try alternates when superproject has an alternate",
08-08-2016).

Thanks!

ATB,
Ramsay Jones

 builtin/submodule--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4c765e1..4c7d03c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -641,7 +641,7 @@ struct submodule_alternate_setup {
 	struct strbuf *out;
 };
 
-int add_possible_reference(struct alternate_object_database *alt, void *sas_cb)
+static int add_possible_reference(struct alternate_object_database *alt, void *sas_cb)
 {
 	struct submodule_alternate_setup *sas = sas_cb;
 
-- 
2.9.0
