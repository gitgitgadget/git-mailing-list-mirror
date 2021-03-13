Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12D8C433E6
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 16:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBCD364F23
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 16:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbhCMQSA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 11:18:00 -0500
Received: from mout.web.de ([212.227.15.14]:36795 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234007AbhCMQRm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 11:17:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1615652257;
        bh=q4QPXj4ontWsdTjUNKmEw+bk5PzTG0Ec/MteBOsGN3Y=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=BDB06OLnaINxTTLbgXLVm1aYe8LhoBNEO84y2Wlf1ue/h67+JhIvZgNCkzeDAetUM
         YL5u0Z71P8q+iOyh5IuBHSxdawy82+Bv8lwz04h1unjgEZg5SE0Jq3/QO9OFqwu6QS
         Kx5/WMHIZlL7hCsX4zKuPI/1Ue+uvh96c6hQeikQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.24.70]) by smtp.web.de
 (mrweb001 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MfHQo-1l6DoB2y66-00OnWM; Sat, 13 Mar 2021 17:17:37 +0100
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jameson Miller <jamill@microsoft.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
Subject: [PATCH] mem-pool: drop trailing semicolon from macro definition
Message-ID: <87289f1a-3f64-713b-6c29-210faf87bf98@web.de>
Date:   Sat, 13 Mar 2021 17:17:37 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d6+WR1y6dq8/FKtLX7/pNCI/c9+vj8RWhDHxqKc+XHe6uVOQTK5
 oWhPbwqoEKJCBMUFhsVp0TCseFB5cqWUI43uaxNN4IEwtTqQ5Y7pQi2MeNoGdPhh/5HkBJO
 oD7Ht+/WJ8d75oRZ7PrLc/8Ky6Pm00xBZDZ3XYU4mDhy2CXxZyTIO1KG478bzZXe9Moaphr
 /+eTydLAFQYnY4g4I3M9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1nv/64sQF/k=:/GfAF95gDAr/TGsz7qkkyP
 TpaqqMZ9GNzTM69B70Zrz3iJ+sZBbIWJuv90JTydQRaxX6S8SiA62S/M5i96tz8qwn/X3Xvbk
 FlcBfaZKIeGzgu/Ey4bcIXNJhCtFG93qtBqPSYYACpwgHLr9h1qgqImQchyS5eJTC/GR+PvPF
 LcDoX8FSRgP0cfSJQ+LUBtlkfTEIQJRDDvIUbTrJVrhWm2GDqfy0O5NHeHe1ZV7L2SdAQKgJ+
 qE6z80RS8WYhwBGyIxbIb5x0161CPkqOvnXtg23zwsjOLpYTA+Em2DHFa9nLavuJo9cbtY8OF
 YNtRa3BjSi7wpHxSxO/rcsBXvY7D+xjd9mJ8ani7E231Jddi8DkQ3kjp01LwYs3dVc0mCawU9
 xrgoj/uxmXg7hEGAklkOX5KDJiJWeqdb+hN3vPw+1gqqc8cIvv0ZLKCAeK7VCz5L+Q2xn0Ehs
 BgLg6UT/nxlzVt8aNu4cD0eljEX+7QXN0vbvaAsGGurv20RQENXZ4NrUIc8/CQ52kqLlUJfrs
 rEVAamrCe9ZjWjZocYH5yQUvZFOWStLUYMdsojzUc3vWl6dIue6xq7vwRgn5xHV6G4QXVWojB
 OFsL8niq6XNPd5vcCFOPu1dp71t1vzmmZygIpTzuxZ6kdqOlJ56mRngAF7QIIMuAfusYOmUM8
 27tozJbNnQq/wgCDCbGbIRb4tL7uprFl4wnH9qfpv9lANpJgRPCieax0uorP/XG0wU7X52fYA
 ViKUNQ81mUWvrQRPlpv6y3IeRQNXxiqwreS7UuSOkP75164DIdYhSZCTpiOg3c8iB92E1Fn+w
 Jr/0eOnf1z6XWfQ/vNvPhWdq6JplWpDsVSlMa2OYMUJukZGDGb6XgKmOhlyuNBy9T46vOOUMG
 d7Y+enY6uv7cwDdr0yfA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow BLOCK_GROWTH_SIZE to be used like an integer literal by removing
the trailing semicolon from its definition.  Also wrap the expression in
parentheses, to allow it to be used with operators without leading to
unexpected results.  It doesn't matter for the current use site, but
make it follow standard macro rules anyway to avoid future surprises.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 mem-pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mem-pool.c b/mem-pool.c
index 8401761dda..ccdcad2e3d 100644
=2D-- a/mem-pool.c
+++ b/mem-pool.c
@@ -5,7 +5,7 @@
 #include "cache.h"
 #include "mem-pool.h"

-#define BLOCK_GROWTH_SIZE 1024*1024 - sizeof(struct mp_block);
+#define BLOCK_GROWTH_SIZE (1024 * 1024 - sizeof(struct mp_block))

 /*
  * Allocate a new mp_block and insert it after the block specified in
=2D-
2.30.2
