Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D46F1F954
	for <e@80x24.org>; Sun, 19 Aug 2018 17:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbeHSUrF (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 16:47:05 -0400
Received: from mout.web.de ([212.227.15.4]:53171 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbeHSUrF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 16:47:05 -0400
Received: from [192.168.178.36] ([79.237.244.101]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MUEsc-1fRd0W1nyU-00R2EN; Sun, 19
 Aug 2018 19:34:46 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] remote: improve argument help for add --mirror
Message-ID: <03cafb74-1671-727a-b53d-519381b18e32@web.de>
Date:   Sun, 19 Aug 2018 19:34:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:jUgQ6fLMWHuEWhDM1UHjJUfdSh6LRSHV02tSH7BburPBilVvO7b
 /VbHGYx06clsz/U+VkYfaYQQtgWtcXK6WDE9KmkrvECBzSiUekLT2ZO83+5zmsVV99WSi8f
 /NGZVU9T5yj4x/cLeFa+1WD2IBok12MHEaI7fSpmugKvOcx6/Wvk6kPmpy65n9KdSTcNOXE
 fxKqOsKiDk+UsfbrrFZ5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JwX6m0+vY5E=:xpDGHpW6JoOoeHIsTRKGbc
 I0yb7P6Hriy2WE65FpJh+8xa0Zr9MKlbgiWTHReasYsQAPNmD9RnxPDgTeV4InhsXbVfRLRxl
 nMlEeqn1plWoqogweAqLuvAAEASMCj8DDUUl9fscjnS0WX+nGPMqCawut+KaPktEtKno431kB
 q3Q3yO+uJWsKDZ7ryfJ2UezMxcw/TE8pgeyCnIe/shm7K/pFsBjScpIRvf9aMe0XQW1Uxv2Og
 VIWuYaeCdpgSj7OW5FvMGNaWgfpW+EWzftzp1cr4cDIGOEf54fZcD3KYM6pr2gijYNr5lmWS3
 2MkkeqKGy62gAII2FdvYhRYgEIjEzYYl7vF57D7aoDhPwGbvI2Ok3HDhJofgpna8Cqls+ABft
 MkG3uaXYtLM5HOdy/anGdQVhaAAZuaNvnwH301QB0P1H2nFQ5BPyDJcIkvA8+Z1USL+gMQzfh
 rSWn3L0vyTc1Dyg7zqEfZB4v2Qe5O8JBxQl/yG4jLng1qZFCzjpdY8O8xkduOE33YTiBd096d
 /wT37CJtW4BNNDcsqWLcmsbpLNg6IMjFfdg3mv5qiR7DGO7PVEiPFRfE5Czvg+Yc3OvO0SKGH
 po1URct9NGaNsEUY7AvTSuMIpEJH6NDAw02jHxYD0Qp2+775emDm+fNeZOdBqOZoe9kxVpab9
 vCyghSnab+SDcYjVjZ0aGa3cAUOuMrVXFgudGEpiKsqJTrSlbZqoVPH5QttwcUGN1Mh17eP/m
 wmuPMZgbEc8/BS/o8llDdCIGrMb/ghLAaPxFUQurev5ngJWqGfJ+L1E3jY9rfW4tU0VDHXLg0
 LzitJ6Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Group the possible values using a pair of parentheses and don't mark
them for translation, as they are literal strings that have to be used
as-is in any locale.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 07bd51f8eb..7876db1c20 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -168,7 +168,7 @@ static int add(int argc, const char **argv)
 		OPT_STRING_LIST('t', "track", &track, N_("branch"),
 				N_("branch(es) to track")),
 		OPT_STRING('m', "master", &master, N_("branch"), N_("master branch")),
-		{ OPTION_CALLBACK, 0, "mirror", &mirror, N_("push|fetch"),
+		{ OPTION_CALLBACK, 0, "mirror", &mirror, "(push|fetch)",
 			N_("set up remote as a mirror to push to or fetch from"),
 			PARSE_OPT_OPTARG | PARSE_OPT_COMP_ARG, parse_mirror_opt },
 		OPT_END()
-- 
2.18.0
