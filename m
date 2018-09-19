Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9D9D1F453
	for <e@80x24.org>; Wed, 19 Sep 2018 00:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbeISFti (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 01:49:38 -0400
Received: from avasout06.plus.net ([212.159.14.18]:56470 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbeISFti (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 01:49:38 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id 2Q8VgDzIWWLW22Q8WgvGOi; Wed, 19 Sep 2018 01:14:32 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=v5maN5yxRTRKxl9sqdkA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 8/9] delta-islands.h: add missing forward declarations
 (hdr-check)
Message-ID: <4c05efc2-a8ca-e6e7-b843-47918dbd77e9@ramsayjones.plus.com>
Date:   Wed, 19 Sep 2018 01:14:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCH0LYypRQv5jlGNj5NjA/yq6GYRX1IcEXOt5YIARJsHMkSblbFbbGfGA2eaQ82fsOJdddoJO6RfbpO3ccf8o2HRXOBTUqIO0oOfKyIp3en21QjhA5t+
 nymHsy3vwxGvYO4T418ahXlkUO0+jqO1aeZyakmYERv4ZBapMCFmzadIL9lWkJQjt+WwYhFj8wb80g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 delta-islands.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/delta-islands.h b/delta-islands.h
index f9725730f4..b635cd07d8 100644
--- a/delta-islands.h
+++ b/delta-islands.h
@@ -1,6 +1,10 @@
 #ifndef DELTA_ISLANDS_H
 #define DELTA_ISLANDS_H
 
+struct object_id;
+struct packing_data;
+struct commit;
+
 int island_delta_cmp(const struct object_id *a, const struct object_id *b);
 int in_same_island(const struct object_id *, const struct object_id *);
 void resolve_tree_islands(int progress, struct packing_data *to_pack);
-- 
2.19.0
