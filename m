Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4075220193
	for <e@80x24.org>; Sat, 13 Aug 2016 09:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243AbcHMJBj (ORCPT <rfc822;e@80x24.org>);
	Sat, 13 Aug 2016 05:01:39 -0400
Received: from mout.web.de ([212.227.15.4]:60433 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751953AbcHMJBi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2016 05:01:38 -0400
Received: from [192.168.178.36] ([79.213.114.86]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0Lwq0e-1bA58t1VAO-016LJt; Sat, 13 Aug 2016 11:01:23
 +0200
X-Mozilla-News-Host: news://news.gmane.org:119
To:	Git List <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] correct FLEXPTR_* example in comment
Message-ID: <57AEE1E1.3080901@web.de>
Date:	Sat, 13 Aug 2016 11:01:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:f+YcoLisG76STts2VGIwzG/Wb50Bx4AzRlLenA384QTxdv1rY1d
 vqfeBI3osrUPH5bYGD3FmQ6+oKbefO+RpRT/ykjTbCpGUILr3/ri7BYEHaPtilIpgDOzJOm
 /mBUoo4HraAq7iMf0tlhNVb60PuTSDg7o31lMMLvGhq7EV9ggdMgI/C0pvNe1dk7MEWyqe8
 MbgkgWW5obt9yHCAq2W+w==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:wUYq7MG/mTA=:bzY6Fv+gj71XhWjxSwQMj6
 6xcbPzIcDlN/6MzQYm4XEeOb+g9s3QfshnB1lChv0KU5TKW1+5NbuLzG94ailxw3AbSs8gAum
 Mq3hkVnGfod2HmboU5oC8lAKuGZpO0tXSzpzVN2sQmysMBZf2xZfRYHAuK/CHHqb3Pb22VttO
 X9MLvqQckDsnGiyWpmW30VjwO47NNb2zbhqSKbYUMbFsM0WAqXElRUePaO2iYIBHFyD7X5JyT
 nO/wG73WF5aBdVcKUXumItmQ81Uwc9UUcFn29rOl8PN6UeXZngLIfGA1LmsOYrbw81BzM2sxQ
 0Ik1pDn/aj0tWSpTV9YkIragQFXjVSnenFSPtZJSZ0MfiA/2FMIYn8iV0K9y1c6I9IO2++YdG
 jBefKe+E/iF0ktEQ0sm+LZuQ5fqT1HTUUo7Ki4mlzr2wK1CX/YYqxzSQ8Vi+yhZ9XbozRBSth
 hjJBfdKzd0Sywsl1twu3NA762YAdoxX7qVhjUykqfWCD+7XBBu+JPtBGHY7lRg5HhPR/DlOf4
 bHbhWq2v/3fIhylweForwOjm+De9LTB13OfHxrpgJk+O9XULwb+KDxXipFGWkqKCwwdSr0NfA
 2ZapHf202xg4zeclGkYL+vWpuBqKEcTOn56xaHTUX5dXr7JoQ0PHBQKp5yjsjwRyfHK2qJTgJ
 UAV7bRXdKXQ0io8xk8OYMJ3jAy5WcfDa9gmkGBUo3/6fQ4wEQH1KHxwPqB/Gp1Db7mqTMKQ5F
 ju3QbrST56pm0O7j/HA4hyrvWStWTscV9QoPrGh+sM5fgvQF4opm6HZj1/o06cT2Zl+Qkksco
 RxyswHG
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This section is about "The FLEXPTR_* variants", so use FLEXPTR_ALLOC_STR
in the example.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 git-compat-util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 590bfdd..f52e00b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -815,7 +815,7 @@ extern FILE *fopen_for_writing(const char *path);
  * you can do:
  *
  *   struct foo *f;
- *   FLEX_ALLOC_STR(f, name, src);
+ *   FLEXPTR_ALLOC_STR(f, name, src);
  *
  * and "name" will point to a block of memory after the struct, which will be
  * freed along with the struct (but the pointer can be repointed anywhere).
-- 
2.9.3

