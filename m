Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D9021F461
	for <e@80x24.org>; Wed, 26 Jun 2019 22:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfFZWMn (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 18:12:43 -0400
Received: from avasout04.plus.net ([212.159.14.19]:47505 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfFZWMn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 18:12:43 -0400
Received: from [10.0.2.15] ([87.115.253.20])
        by smtp with ESMTPA
        id gG9fhW9OKaslVgG9ghoPWO; Wed, 26 Jun 2019 23:12:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1561587161; bh=S1g74HMBzB7vNi3QQp2qfge7Sgyddeh29JgMi3OoXVY=;
        h=To:Cc:From:Subject:Date;
        b=gwS6kXJpGzvkGS/FZdsFaQuWp69RHvc0ljrN9M1dYJjFf5K2ZU/J0kTB4go46z3pk
         Dqp6rLXwaxYk2E7eSqAKQq9GW4nHQ51uVtX4gP42V2/WPJyiI9zaIWIJJB/gJ7/R+d
         FiImP6PSeLZ62HRPSYF0O45htASHsik9ivd4UsQaHlKGlsqQ0K5ttP5lAEODTkuVxR
         jbq2NgPWirzahi1LM/y/1xxJ8LSUsgYKsTYLS65Aj54XiaR/gxHbra5xAs16uil1Ro
         cSoSiMZPqahJrRcEo/mWi0QPFrg4LyAgArcV9ex0q7UDXUBdEk2QZblBE3Q9yAxOFP
         7xKKr7CmU7z+w==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=bfsVr9HB c=1 sm=1 tr=0
 a=ceBz2RPxfYaxgFK6o8vNfQ==:117 a=ceBz2RPxfYaxgFK6o8vNfQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=xTUlSCmrI7Bp332FzJkA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] env--helper: mark a file-local symbol as static
Message-ID: <f576dfa8-4beb-6430-67b3-6c05f520b040@ramsayjones.plus.com>
Date:   Wed, 26 Jun 2019 23:12:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfGCAzq55KCtsmDWJyWMiAk7V696yALbkaJ4FwcwIFif66VsfBJs3Y2LAsOLGZxpobJNOyK8LTgwdgFixPvBtMAPCXUeWbiw4U4DNAprHNjeTfdvD1P8O
 iPbN1gnO1pRoCrISG7sEoVGldISa1W+xJMhuhcR0RBgamLgUX0LOIgsdzLUdzYGpBdr56G763XuJ/g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Ævar,

If you need to re-roll your 'ab/test-env' branch, could you please
squash this into the relevant patch (commit b4f207f339, "env--helper:
new undocumented builtin wrapping git_env_*()", 2019-06-21).

Thanks!

ATB,
Ramsay Jones

 builtin/env--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/env--helper.c b/builtin/env--helper.c
index 1083c0f707..23c214fff6 100644
--- a/builtin/env--helper.c
+++ b/builtin/env--helper.c
@@ -7,7 +7,7 @@ static char const * const env__helper_usage[] = {
 	NULL
 };
 
-enum {
+static enum {
 	ENV_HELPER_TYPE_BOOL = 1,
 	ENV_HELPER_TYPE_ULONG
 } cmdmode = 0;
-- 
2.22.0
