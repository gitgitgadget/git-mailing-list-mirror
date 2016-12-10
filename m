Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 197511FF7F
	for <e@80x24.org>; Sat, 10 Dec 2016 21:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752184AbcLJVrD (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 16:47:03 -0500
Received: from avasout06.plus.net ([212.159.14.18]:33290 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752034AbcLJVrD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 16:47:03 -0500
Received: from [10.0.2.15] ([143.159.212.40])
        by avasout06 with smtp
        id JMn01u0020srQBz01Mn1No; Sat, 10 Dec 2016 21:47:01 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Xom4AhN9 c=1 sm=1 tr=0
 a=8Z0saNXTz8GoXi/9Q5ysMA==:117 a=8Z0saNXTz8GoXi/9Q5ysMA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=oxl3eEVWfhasoAaCSAIA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] branch: mark a file-local symbol with static
Message-ID: <16326b3f-45c8-df4e-d52f-5dac62610b21@ramsayjones.plus.com>
Date:   Sat, 10 Dec 2016 21:46:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Karthik,

If you need to re-roll your 'kn/ref-filter-branch-list' branch, could
you please squash this into the relevant patch (commit 715a4826ab,
"branch: use ref-filter printing APIs", 07-12-2016).

Thanks!

ATB,
Ramsay Jones

 builtin/branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 2c9aa2b29..4386273ce 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -306,7 +306,7 @@ static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
 	return max;
 }
 
-const char *quote_literal_for_format(const char *s)
+static const char *quote_literal_for_format(const char *s)
 {
 	struct strbuf buf = STRBUF_INIT;
 
-- 
2.11.0
