Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16F2C20986
	for <e@80x24.org>; Tue, 27 Sep 2016 19:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934225AbcI0TBh (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 15:01:37 -0400
Received: from mout.web.de ([217.72.192.78]:63677 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934172AbcI0TBd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 15:01:33 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MHY1o-1bnsEh1QFA-003M0a; Tue, 27 Sep 2016 21:01:23
 +0200
X-Mozilla-News-Host: news://news.gmane.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] gitignore: ignore output files of coccicheck make target
Message-ID: <93adb7c5-aac7-7241-e383-3ff7997faf7e@web.de>
Date:   Tue, 27 Sep 2016 21:01:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:aDf6z38UAdNmp42dLFeM/vuQ+GLEqyN0u9f0TK6xpUu0sz1L36N
 jVAUtR0Tc5pZBAot54ZEi0FjK+0QaGPOVXbxTwlAIoi8y86YUstqpYN15E87A5OUBIKw+YG
 k9G5ukmum3wnXz/97JrfldSWS99qimrDb0pT82mZjA4cKE94Ahsua0ehhOqAmzE4rQJJJJe
 JY3cAvULRfA9TZA0B1EjA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+FokhNJOPtw=:hbcfnLCeGcx+cy65hwAXw2
 R77/wpQuULciDqbkz45VejjMiGkyKdaLv27n6NeRAWYxG2zEyJYMoANyZgfRD29ldVzq+zOjg
 +t9kc/Plx7SBNUTOnLKadFJdQRUwC9+MIkqIakgNtuJ0+wYwmtBurlAAVqufaefKJwZEeJFVD
 L9MYAi/v5jwkh/6Oh39/upUoikNuUklMi1ozCEiqL+Acog8O0+3o1UoHHX8egGY4XHArkRmoK
 J0M3bxG5TjGYLK4nRDvjwUta1Wr0xe/SOfL844zLIBibu+wPcmdYAioWlP/+GybvlHGWO4BUm
 RAjsbuLwGoGRNVkWJmMFD1xdYIizIN7YWgOL5tlzS+1ywXwnsd3Z/cNzSxSOCxr+aN3zm66PQ
 YNcLQPZ1RtaoVICVWdploKc8q4vS4Uz5dfs7ytMJJcZ4zmuVxPTrapzUtrRAwIrfzpIP1cQsd
 tXyyHAc+VGkhAaUHBb4koHxgxtxf8WCFoLSBQ131IsAiSJaJQU6p7i4VzCY4HrOmjQ54Ckrjh
 xQGPPJkIpkpUy+CedTkzRb3wMnw4yRPrFNdOGO/MBiSLwp7q3s5Az9/kYnI0DtvkNsDOFo5XR
 CCXHzd6JBIAvtYc0bThuwtauW7/Goef/DFU+eT5wkSlPVCI05pVlvTMXOl75zAyGAKqZqoC86
 BUo8WSBTbyJ1htNdeQt/wP/EPM4LyFLGCmEEJ1NCFOy10oBqiAY8FARcTu5GRsvxTUuztVIoB
 9fVPRKAF5xS8HtCG6c12yQNfgrZaTpc0zs1yCSMmPwRDnW2Qy72FKsJ2mfYTN3VY0IY4WBCI4
 7CaTCQ8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
  .gitignore | 1 +
  1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 05cb58a..f370ba0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -207,6 +207,7 @@
  /tags
  /TAGS
  /cscope*
+/contrib/coccinelle/*.patch*
  *.obj
  *.lib
  *.res
-- 
2.10.0

