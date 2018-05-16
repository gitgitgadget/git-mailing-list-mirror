Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 762AD1F406
	for <e@80x24.org>; Wed, 16 May 2018 21:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751290AbeEPVfl (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 17:35:41 -0400
Received: from avasout04.plus.net ([212.159.14.19]:49523 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbeEPVfk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 17:35:40 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id J45BfVDi7I9T1J45CfFh9f; Wed, 16 May 2018 22:35:39 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Z6vC4kZA c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=NNnY6BDbALiM67mSEwsA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] refspec.h: reinstate 'extern' to fix sparse warning
Message-ID: <29f60a43-9c95-512a-ef85-558906a08ed0@ramsayjones.plus.com>
Date:   Wed, 16 May 2018 22:35:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGf0roPTg6vozyBmtR1f8NxfSZGA2CSsOBfzWQ7cECJpCT/s8+ZwYU28gXIT4XO8LIwslXiENQO3N3VyLEimV8tSImsUfz3O48h5yEPY6pStOC7RQaQE
 i3oxdTwc9CSxKVLqc1WkOoXYAKf3Cqyp8IDRruyJSwA5CPCLaHT/7+CogwtbbH058IubZAyOaznyPQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Brandon,

If you need to re-roll your 'bw/refspec-api' branch, could you please
squash this, or the equivalent change before the 'struct refname' to
'struct refname_item' name change, into the relevant patch. (which
would be patch #1, commit 8999381ed).

This patch was built on top of 'pu', but as I said above, patch #1
is where the original 'extern' keyword was dropped. (see first hunk
of the diff to 'remote.h').

Thanks!

ATB,
Ramsay Jones

 refspec.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refspec.h b/refspec.h
index 374f8ea63..7e1ff94ac 100644
--- a/refspec.h
+++ b/refspec.h
@@ -2,7 +2,7 @@
 #define REFSPEC_H
 
 #define TAG_REFSPEC "refs/tags/*:refs/tags/*"
-const struct refspec_item *tag_refspec;
+extern const struct refspec_item *tag_refspec;
 
 struct refspec_item {
 	unsigned force : 1;
-- 
2.17.0
