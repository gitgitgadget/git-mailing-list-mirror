Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 967D01F453
	for <e@80x24.org>; Wed, 19 Sep 2018 00:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeISFxs (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 01:53:48 -0400
Received: from avasout06.plus.net ([212.159.14.18]:56986 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeISFxr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 01:53:47 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id 2QCWgDzZ5WLW22QCXgvGS7; Wed, 19 Sep 2018 01:18:41 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=wp1E5GN8qXYykpndVyEA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] fetch-object.h: add missing declaration (hdr-check)
Message-ID: <12cd9928-d04d-d208-a1b4-ceecbdf79432@ramsayjones.plus.com>
Date:   Wed, 19 Sep 2018 01:18:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGOq4uTsXRGkaFsKjws0ZWW8kt0Nxu8ANo22ZB01uuCfFMsuJfkM/AM/xM7M62dSalz/n1Wmwk+NOwIRTtXDKiWUxPZ/4H/S6GfG6YMLK3Z0SeUmN+8p
 MbXkzwOIKaQupo4V+VhIs3NQWVeD+CXnOr9ujby/eKtTotyiOVfs1x9YIZzvyvWfI3SJYggVWZRQ/w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

This is the patch I needed for the current 'next' branch to get
a clean 'hdr-check'

ATB,
Ramsay Jones

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
