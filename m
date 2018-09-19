Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFD5D1F453
	for <e@80x24.org>; Wed, 19 Sep 2018 00:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbeISFso (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 01:48:44 -0400
Received: from avasout06.plus.net ([212.159.14.18]:56470 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbeISFso (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 01:48:44 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id 2Q7dgDzF6WLW22Q7egvGOA; Wed, 19 Sep 2018 01:13:39 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=dURpZ_cy0RKw1ESKhLsA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 7/9] midx.h: add missing forward declarations (hdr-check)
Message-ID: <7b45f9df-5d46-7d75-02d0-457a8ccabf37@ramsayjones.plus.com>
Date:   Wed, 19 Sep 2018 01:13:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGGRNYqZ7ygj73cv38Xnap8iwqpgnKnhZGOGHYr7OXf/+Amvm62Yslu8vk8jUbQZZSKoBGFWa+CW+kYUiM3LT6cKmi/UTSjcZeUj/VBfcg0/1TcQDF0p
 f651FdUb+wRGwuafbZSGjhVGJ7linqFEMy29RCfES55KNyL5oj0Auol+MioHc18e/iqhVC98Ks74AA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 midx.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/midx.h b/midx.h
index a210f1af2a..622ddac472 100644
--- a/midx.h
+++ b/midx.h
@@ -3,6 +3,9 @@
 
 #include "repository.h"
 
+struct object_id;
+struct pack_entry;
+
 struct multi_pack_index {
 	struct multi_pack_index *next;
 
-- 
2.19.0
