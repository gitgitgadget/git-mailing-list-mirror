Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3587720248
	for <e@80x24.org>; Thu,  4 Apr 2019 18:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbfDDS5T (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 14:57:19 -0400
Received: from avasout02.plus.net ([212.159.14.17]:47725 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfDDS5S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 14:57:18 -0400
Received: from [10.0.2.15] ([80.189.70.228])
        by smtp with ESMTPA
        id C7Y3hVvhN2SW5C7Y5hTDbA; Thu, 04 Apr 2019 19:57:17 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=NtavjPVJ c=1 sm=1 tr=0
 a=5/rI1lTgw+ttA0Fwm4j1LQ==:117 a=5/rI1lTgw+ttA0Fwm4j1LQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=NW3ty6QyO9nVolbXftwA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] promisor-remote.h: fix an 'hdr-check' warning
Message-ID: <0830dd3a-551e-8d74-18cf-288ef05ec287@ramsayjones.plus.com>
Date:   Thu, 4 Apr 2019 19:57:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNdX45sMcjtxKO08j+cIkjU6/tsgTc0jjqHqJOCGfX4dxVkZ6gbJeTH9K8y4zVD8+b7q+ETArKVlFPeZ0KHB6n2UHSyVxp6aHJt9aRRvUdYQfzwztvlP
 1aqGgF+JkXOLwpaJPh/GQbuRJPv0tTZwn7Hwrzt7NV83mIUJQxS+sDdL6Z0cyZkfnNFs1ii6rPTk2Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Christian,

If you need to re-roll your 'cc/multi-promisor' branch, could you
please squash this into the relevant patch (commit e52d417b57
("promisor-remote: implement promisor_remote_get_direct()", 2019-04-01)).

[I had a deja-vu moment writing this - it seems I sent a very
similar mail about 3 weeks ago. ;-) ]

Thanks!

ATB,
Ramsay Jones

 promisor-remote.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/promisor-remote.h b/promisor-remote.h
index e29cf507ab..562c7ad8a4 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -1,6 +1,8 @@
 #ifndef PROMISOR_REMOTE_H
 #define PROMISOR_REMOTE_H
 
+struct object_id;
+
 /*
  * Promisor remote linked list
  *
-- 
2.21.0
