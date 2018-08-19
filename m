Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 110EF1F954
	for <e@80x24.org>; Sun, 19 Aug 2018 17:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbeHSUq5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 16:46:57 -0400
Received: from mout.web.de ([212.227.15.3]:33747 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbeHSUq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 16:46:57 -0400
Received: from [192.168.178.36] ([79.237.244.101]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MC6ZE-1fibtO2iZ6-008sak; Sun, 19
 Aug 2018 19:34:38 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] checkout-index: improve argument help for --stage
Message-ID: <34a13c2b-05a4-8788-de2a-d794bde1420d@web.de>
Date:   Sun, 19 Aug 2018 19:34:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:/YeQVYi2fWS70zkj+yAqAg70zeguhWOgBI66/Qt6N0lIUS/BvrQ
 2mlNe1DuIX1X8dcJL+Yt8M9GiFrl13JHOWH0bgGDnFnHoKwiFBSjM5MKwwerMqPFax4NsPb
 5/TR3exwfmigPCIgqUQ9lM6Wm1tc3jKmJ0424oCXCccCGkbemyujIwcnffVkAxcDs/TB6k3
 sUL4ehnY2Ffr+t0vq1pqQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4ggWKCqFD/g=:fBY7gkCSx5lWfOjxbFUmF/
 A3nQ+fClWERRGtb5XYFBWT5fQwabPgefGg9DylQQ1WW7gTn62GnopzxEXSQ7wAz2T3+70NF3L
 elJLEia+Cd6Tb4HThlpOnZHyDPtma8iB0DwOmR+auXrBmUpuCDhL4G8/vwndPKSp5egxLrHow
 BNttxOsF3EYkcYt6ORIUrt3NabODsGZui7p82Y2q7u1WuPZ0aUCcPsoJtvN3OtzgNXK3Qbotb
 wv4FwyKrg0apxwMk5weq46Jfl7dtIoGJelqi7CkIN81+CfBFtfkfYJZdimjQA1J5MVXPUgonN
 5/R3dhzNF1/y6/laImNs3EzRul4SjAF7l1oCqxqlyiKbup87Kc7yPjBHCWC6pVOU8eTk6cyVF
 e5XMkk/2DOFK46ojp4ZFD3mFrplGinyhUBDNmW4ZuMUXKUI1zSC2jWzEgtOjEswlUwprCYntD
 5GvTV+JJJQzNTlSaEFRmp7riP2N1/5QM7Ns0EttNoAvr5QgH7I2iNI3gk8kuh8XZ62nTR3HNQ
 GInO1BJEP4qTb9TATo9bxgJlc3epzjWDh45+iNZQeG+Y8fiVdNR0BVbW2YYhqmELL35ziWBTO
 eIytl1CY1eWJwCxkckQEiXYbVcA0ZyZVT86TKFbyW3iKDMK22B9Jnxrrpkzfw73HPzH83xMeW
 cUi2LyDkIPUybNq0RBm6S2tnkgpb8yWAIVNDuI966TBCInn2bITwlffV/Sj9tZ57quc+uOzJ1
 El1u6zY+Hc4LfV1LjM7891hFr200RMaBwlpXHZp4p/fr2viq3KkYWMe8xGSMELNZXuyGcPioH
 sMxHMDk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Spell out all alternatives and avoid using a numerical range operator,
as it is not mentioned in CodingGuidelines and the resulting string is
still concise.  Wrap them in parentheses to document clearly that the
"--stage=" part is common among them.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/checkout-index.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index a730f6a1aa..92e9d0d69f 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -172,7 +172,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 			N_("write the content to temporary files")),
 		OPT_STRING(0, "prefix", &state.base_dir, N_("string"),
 			N_("when creating files, prepend <string>")),
-		{ OPTION_CALLBACK, 0, "stage", NULL, "1-3|all",
+		{ OPTION_CALLBACK, 0, "stage", NULL, "(1|2|3|all)",
 			N_("copy out the files from named stage"),
 			PARSE_OPT_NONEG, option_parse_stage },
 		OPT_END()
-- 
2.18.0

