Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1A4920193
	for <e@80x24.org>; Thu,  4 Aug 2016 16:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758810AbcHDQHM (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 12:07:12 -0400
Received: from mout.gmx.net ([212.227.15.15]:55359 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758699AbcHDQHL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 12:07:11 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MLvGW-1bd3LR0O7A-007mqK; Thu, 04 Aug 2016 18:07:05
 +0200
Date:	Thu, 4 Aug 2016 18:07:03 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] nedmalloc: fix misleading indentation
In-Reply-To: <cover.1470326812.git.johannes.schindelin@gmx.de>
Message-ID: <0e17a706c29932e2280a1bc1730f5064bbcfec57.1470326812.git.johannes.schindelin@gmx.de>
References: <cover.1470326812.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3dLf5hRuhKCwv/KAVsej8leGAByENhidSZ2mHfvwTH2RCZD//f0
 +lom1rxNJJOl7CtvsdiWE7Ii4vquKmu7Knucl6AMIf+ZS0xmvSZ/1+UslT1IcbrvTns2Wdw
 u+lQpftW0SmMm2hLFxqq6haoRFo8o967FKtVEm3wngT/8/iDvOPNNyKE7L7bepw9pvcBVce
 Fq4X8gDAfy1eLI2jVXmfg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:iyu2E137o8s=:yo1ZQ7lag+OkoyWPbMY8Kv
 MVWHYKi7m2kkIOFsUKgBe+QQrWTiLBsKTplPVcNSSoldRcgpzwY9yBhYR1iahK/OxHAzha8Pu
 RqeOnutbfhqH4mfS6MJgUXFz6rB62T2u03IHh6Kaij55AF+FUEMiWFr0Yc8ZaKcl1+wvYCPzP
 pssM8qc3xhI8JcHWwr6nb4x3zdkLatqEbHSgnq5Ca+tnOYpBxhJ1iaC0s7jNX6pnycNg+qHEB
 D4mlp66TjufZB0REk1vdZxFnaaxgivAMgZDcorV8iFnOQYe2uhjjAzRT6KQFof+66SLUMEuxL
 802drwzg/egI74fHq9lBPn+abKI4fNXWnCQQ915mahDQSsP9dJxfdSJK4qqumBWm9PKGAsPiH
 LuzxMmpICNlCx8q41qaYwLJcKIhl7FqY/iSoVWnFgg8SIv9XZNwHL537IjEsuEpUGran9yOVk
 2JiQyGUk5FQbXJwaXFM+IhHpGt6PRqvliCd86XRJ5/pM7k+LTSbVnBftwZDRmuQ+MeRKhDP5t
 93qs54rZPX28SaTAibK4h4pdQWiExsyN9SNk0kb8VgrCK3i/q2a3ofHqief7hhDcC8uiMPWB1
 0+nBJgE0YaBZol+qDSLu3/2BDqUHbNwH/e7V1tWXKFgx2+XCz+ybAkK8Cca10iHCNnOEZJwmG
 zEaXht/UkWIEIfVJVOg1Ma03A1Wz1ry8TBjlt2sPblG1yKoU2WQoiFK6gcxJd+CAdQaHL/2SZ
 S3dB1jev4GE5ITjgG9yijvGlsTk6rcZ/DbCl/8E0V8S2ftSWZ1jOZM/OajELsH8XDH+7THc5I
 vihdaHx
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Some code in nedmalloc is indented in a funny way that could be
misinterpreted as if a line after a for loop was included in the loop
body, when it is not.

GCC 6 complains about this in DEVELOPER=YepSure mode.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/nedmalloc/nedmalloc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc.c
index a0a16eb..677d1b2 100644
--- a/compat/nedmalloc/nedmalloc.c
+++ b/compat/nedmalloc/nedmalloc.c
@@ -938,10 +938,10 @@ void **nedpindependent_comalloc(nedpool *p, size_t elems, size_t *sizes, void **
 	void **ret;
 	threadcache *tc;
 	int mymspace;
-    size_t i, *adjustedsizes=(size_t *) alloca(elems*sizeof(size_t));
-    if(!adjustedsizes) return 0;
-    for(i=0; i<elems; i++)
-	adjustedsizes[i]=sizes[i]<sizeof(threadcacheblk) ? sizeof(threadcacheblk) : sizes[i];
+	size_t i, *adjustedsizes=(size_t *) alloca(elems*sizeof(size_t));
+	if(!adjustedsizes) return 0;
+	for(i=0; i<elems; i++)
+		adjustedsizes[i]=sizes[i]<sizeof(threadcacheblk) ? sizeof(threadcacheblk) : sizes[i];
 	GetThreadCache(&p, &tc, &mymspace, 0);
 	GETMSPACE(m, p, tc, mymspace, 0,
 	      ret=mspace_independent_comalloc(m, elems, adjustedsizes, chunks));
-- 
2.9.0.281.g286a8d9


