Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 940761F453
	for <e@80x24.org>; Wed, 19 Sep 2018 00:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbeISFry (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 01:47:54 -0400
Received: from avasout06.plus.net ([212.159.14.18]:56470 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbeISFry (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 01:47:54 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id 2Q6qgDzBaWLW22Q6rgvGNX; Wed, 19 Sep 2018 01:12:49 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=0IaG67MbaXr29tzIzc0A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 6/9] refs/refs-internal.h: add missing declarations
 (hdr-check)
Message-ID: <2190f17a-0bd0-f4f9-fdd1-62152b09c7ad@ramsayjones.plus.com>
Date:   Wed, 19 Sep 2018 01:12:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHkyo7WIfrR0Q16mSW3tGKuuP7bQHj8GbyCGxTMiIolXDpqT61oNK1PHsHVAKKyoLt58HfpvfAjCVQ/qgppltJAdhMDgxlltYYGjZRIXXpI1bDMs+MEQ
 9ywaICvsAcJ3QgSyIUDQLsz7LahqmMZx7lbPVKEsFA+qlM0yFw5ou9A3N4Z4w8r7ZGagv6VlcrynvQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 refs/refs-internal.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 04425d6d1e..44d53672c7 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -1,8 +1,12 @@
 #ifndef REFS_REFS_INTERNAL_H
 #define REFS_REFS_INTERNAL_H
 
+#include "cache.h"
+#include "refs.h"
 #include "iterator.h"
 
+struct ref_transaction;
+
 /*
  * Data structures and functions for the internal use of the refs
  * module. Code outside of the refs module should use only the public
-- 
2.19.0
