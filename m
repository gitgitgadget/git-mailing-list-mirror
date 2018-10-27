Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D7041F453
	for <e@80x24.org>; Sat, 27 Oct 2018 01:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeJ0K3Y (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 06:29:24 -0400
Received: from avasout03.plus.net ([84.93.230.244]:55876 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbeJ0K3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 06:29:24 -0400
Received: from [10.0.2.15] ([80.189.70.193])
        by smtp with ESMTPA
        id GDjngYeN0fmQQGDjogjEKc; Sat, 27 Oct 2018 02:50:04 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Acuf4UfG c=1 sm=1 tr=0
 a=wSR+GDtF+fsrIzE5OYgxVg==:117 a=wSR+GDtF+fsrIzE5OYgxVg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=wp1E5GN8qXYykpndVyEA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 1/3] fetch-object.h: add missing declaration (hdr-check)
Message-ID: <04b4fde9-fbad-9282-726e-0160995b0b28@ramsayjones.plus.com>
Date:   Sat, 27 Oct 2018 02:50:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOGOcRDJizD5viv89AC7QbdVS4Bgh4FuGNXwpOVk1qDDLcGaP+5rjjBoBchZPNuI/1HrBEd1WObCWmzq/Ce7Or3lY5E13wbUsYvTUvkLhAxzUhWW7nd+
 QyIXtplgs10TDV+CCMx1GwE+E4H9SI9vF56m5JivttUULGeak0RMvXzoUpHHK7gp9edS8MUCkmMduw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 fetch-object.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fetch-object.h b/fetch-object.h
index d2f996d4e8..d6444caa5a 100644
--- a/fetch-object.h
+++ b/fetch-object.h
@@ -1,6 +1,8 @@
 #ifndef FETCH_OBJECT_H
 #define FETCH_OBJECT_H
 
+struct object_id;
+
 void fetch_objects(const char *remote_name, const struct object_id *oids,
 		   int oid_nr);
 
-- 
2.19.0
