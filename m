Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B039B20986
	for <e@80x24.org>; Tue, 27 Sep 2016 20:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934832AbcI0UMu (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 16:12:50 -0400
Received: from mout.web.de ([212.227.17.12]:61010 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934791AbcI0UMs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 16:12:48 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LZvgf-1b64CT3vzR-00lpCr; Tue, 27 Sep 2016 22:12:41
 +0200
Subject: Re: [PATCH] gitignore: ignore output files of coccicheck make target
To:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Git List <git@vger.kernel.org>
References: <93adb7c5-aac7-7241-e383-3ff7997faf7e@web.de>
 <745b0eed-4c03-9e72-4903-ab1dbbc3622d@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <4ff9d5f4-afee-d7a8-7a50-4b3d3f80ab89@web.de>
Date:   Tue, 27 Sep 2016 22:12:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <745b0eed-4c03-9e72-4903-ab1dbbc3622d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Y3gz2ddPxSmyveKndLB+hiW4g2tPzaPKDc8SEoQabSuDcE8Rnwn
 g6hvk2D3neqpF1sLDh4B22hajcHLeIhZd2zOAclF5cF2SpjrHwO0Czjau3edM1IllbPwNPU
 BhKDa9aS5Rj5qqjcg96hWiIxPIwVBN9Ol/mthHblSg0TuggQAonRIyw4BAoV6yxmj/fLdge
 FQHnkUK0kh8ApfrsTXCYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1HHbP8oztRk=:aPE345HoNq9FBI2nlqicxj
 gVxdpisiP0Oom+YTZHFyilkEtMlXj6PzZRiY1SfA/x/KDFRftx/BUoo2zL4pdzOnBWiCxRV8J
 BMqUoDCwAikxwi5t8Z92EFi6TgtHG8D/oa1UXd29mPO4+psALNtn78m2E3vHQcY/8b2dCbNJj
 L4F28zXLm7L8oxsFyAXDkgdBVkrImU4NyGoGiWzdO7hQSw2Y/kK2ay7XJ80SbYzrKSTQhL/z0
 SgyAysWjxbkPm8yaiIAxHE6kYfE5RR2LR5Bq4RamQrAf/HVvbRwiSIFJbYDUGjGbSCVB7icdC
 MOIk5bZ9sy8vuEjHo9Jy7ilfVn9sM6liSYmoeZEntkSeCYf7em+CACjoK4TJlLuBLIbDxTuQS
 V435tb8v9lxuiE0tA5kE61SWr6ETyBwj0wI67mxu1FFWvcAErReYPCjRxCY2Gy1/kq/sTh2G0
 il7loboVtxuaFvCFB+yXamaeFcMuh1VaQsZGLgnyyaLPLqwalk//kpuXfd1XeDv9c+tVfaQh9
 aRDIwTptqxESEPRkZwfpq2hnLC4cOzZWD7EvO1JQx+1kHm4/zdJgZz7aWpeOu/0E5wqVAQ5eb
 PWVvba8FKLBZ7ZxsWz4kpYhsvgRViW09KaAsxeXTgeChzRfFTOSzYJSk7mr+SjRuqk/L7XcuX
 IwrtFu5VpdaJ8Rv/Gmfupf2mFO7pAcpAXvF6Emiv4npa1v1kJ1jkNmHuDeE7DcTmHO1+wATTo
 WDsLjEGMBrOtRxkDKqaHGnNnhIOECApUW1uCsYnwAJdsevJ4JZ7z8btz4e4soGR8WV3CIKk1x
 c/DyRMl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.09.2016 um 21:52 schrieb Jakub Narębski:
> W dniu 27.09.2016 o 21:01, René Scharfe pisze:
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>>  .gitignore | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/.gitignore b/.gitignore
>> index 05cb58a..f370ba0 100644
>> --- a/.gitignore
>> +++ b/.gitignore
> 
> Wouldn't it be better to have this in contrib/coccinelle/.gitignore?

True.

-- >8 --
Subject: [PATCH v2] gitignore: ignore output files of coccicheck make target

Helped-by: Jakub Narębski <jnareb@gmail.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 contrib/coccinelle/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 contrib/coccinelle/.gitignore

diff --git a/contrib/coccinelle/.gitignore b/contrib/coccinelle/.gitignore
new file mode 100644
index 0000000..d3f2964
--- /dev/null
+++ b/contrib/coccinelle/.gitignore
@@ -0,0 +1 @@
+*.patch*
-- 
2.10.0

