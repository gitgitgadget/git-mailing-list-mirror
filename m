Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6840E1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 15:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbeGLQH4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 12:07:56 -0400
Received: from avasout07.plus.net ([84.93.230.235]:41521 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbeGLQH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 12:07:56 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id ddyTfSNYqjlDzddyUfTEA2; Thu, 12 Jul 2018 16:57:46 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=GrdsBH9C c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=-TED-dq2Ik3sVR-PxOcA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] ref-filter: mark some file-local symbols as static
Message-ID: <bbd5f6f5-8587-606e-01be-4c5e37609037@ramsayjones.plus.com>
Date:   Thu, 12 Jul 2018 16:57:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFdnDXrzeDk2XWqQaYFw6ln3QSkUh3ZK6Hh7ekxr7N/xxrBAEoCIIc1EAbOvqQQWFx5DGUVk/uhg3uepKHH6Fqua/RTapuIZjYjWjTqU7Q0eIj+dRgsb
 b55wlnfjGA2usLhwUQH72DmFLBSVX0h8npFSXVxNLKV2q5zPAkJHzoab3RrWyRzFMXcIFLnJxOmYmQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Olga,

If you need to re-roll your 'ot/ref-filter-object-info' branch,
could you please squash this into the relevant patch (commit c5d9a471d6,
"ref-filter: use oid_object_info() to get object", 2018-07-09).

[Both sparse and my static-check.pl script are complaining about
the 'oi' and 'oi_deref' symbols.]

Thanks!

ATB,
Ramsay Jones

 ref-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 9aedf29e0..70fb15619 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -63,7 +63,7 @@ struct refname_atom {
 	int lstrip, rstrip;
 };
 
-struct expand_data {
+static struct expand_data {
 	struct object_id oid;
 	enum object_type type;
 	unsigned long size;
-- 
2.18.0
