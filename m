Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895C6C433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 11:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A15920721
	for <git@archiver.kernel.org>; Thu, 21 May 2020 11:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="GXFgC4IQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgEULQE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 07:16:04 -0400
Received: from mout.web.de ([212.227.15.4]:50113 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728442AbgEULQE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 07:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590059752;
        bh=tx2o8J9xQ8aIqaoCAGjVZLc5iqA9x2HHwbiPY3gYd9M=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=GXFgC4IQrdwuGQdiEqVj6FRKgM5emUnwNKO2vvemZT4bPI9Mq4NO5m9pefNK8gdZ5
         R1+vAL2BoQbHHnEcmEzJOs4uGzLVQnb+/KcAM+KxD5CFAV2luQVy45vyUfPuarVI9h
         /Fp+FAakxh5WagaVO29aPJuBA2Ie3N7MVhMnOaIc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.188]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M2MuC-1iju4S3Bye-00s2v9; Thu, 21
 May 2020 13:15:52 +0200
Subject: Re: [PATCH 1/4] fsck: fix a typo in a comment
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bwilliamseng@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Denton Liu <liu.denton@gmail.com>
References: <CALN-EhTpiLERuB16-WPZaLub6GdaRHJW8xDeaOEqSFtKe0kCYw@mail.gmail.com>
 <d963242a-72f3-7f42-7c95-ea5148f74804@web.de>
 <xmqqpnbduiec.fsf@gitster.c.googlers.com>
 <938f0818-7e57-b883-009f-01db88ef8f65@web.de>
 <xmqqh7wovoop.fsf@gitster.c.googlers.com>
 <aab9512b-a70a-0f5b-5cdc-5d40acd343d0@web.de>
 <2937d635-52a9-5e69-b3d2-fbde415b7315@web.de>
 <xmqq4ksmsaks.fsf@gitster.c.googlers.com>
 <0e34ddca-1e29-17ed-278c-4f94ed6436b3@web.de>
Message-ID: <acd2c0f1-af5d-f234-ad71-b55c0c505e0e@web.de>
Date:   Thu, 21 May 2020 13:15:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0e34ddca-1e29-17ed-278c-4f94ed6436b3@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XqGGAaEQ03byQcX4HqzL7flJYS0Os2MZUaskh56s364GhPRWi/p
 0WjHWcWEXM8KxBLB0XjbIvbHmdhLHiYwsS8xEnjzPeeaRlOgR6CNw+LL1dVpd0P06XiMYld
 PCBqhgSoZHVy8Kww/l4dISwT9pwG8TcB94IhLxNKRdPNAhl8cesK6WmY6CmNVwRvZLGFudA
 6N/epE6lTOQynHnFc+0tQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A3bp6gLNb6s=:ILOosl0kwltaCofVf/sX6M
 Mrrz0Nh/R2IWMOzyu3ZyYTut0HF/O7KY9dMQC/TM+FODXpmrIR1A/jpnQeu99/EuSHz6HoQxv
 BmQ/XeIjUOX6E/LYIf4mBffJahRhe5DK7YUiVihm0wv+QBEGYRi6FgfZnI3L8RySXc1r70s+A
 KkfzvESsesfIw9bHIgF4e7hMpaUB1xUzEo+Ve8Z3PcUdJRBFMYPnpuHErQV1JqBS+VY2qRWJV
 YzYsjZHUOsiUHO1C2Z8/vNzMu5RAcW839/V2p2c4PVoWff2n8c6b2q0/tMCQf1KJNqHtFIwyi
 vUPSAQUql0LsgbRnrnfFPFG4tq7D7SqL4zVr9c6L09AoWGPGq9rIf9intNRX6hpRIL6IhElBZ
 LlFAQP3cH24bVjhJyupW1dNzCL7iBV81spcDCuWNAGfnIOHR9xv1ksKJWlwOr2Yw+g92GaoEl
 9XhOJ7j+2NyUikqCnFiA4+7jbGP9enIkPCb1FKzqKq1s4Sd80WF8Ncpof6eYXuQI9Db2Hv/j3
 KNSYwJkUV/10zfI64WvF0l1+w+KxvgfG4vMrV+fGYcDjvoopVSQge4VKPu2Gqu1Gse3IIwYRc
 WjRJeGEd0vpJ1UY5HDzAyLGXxx8RqCCzroAjbMQfqtGGZWEbUW7QVsKTx1kZItszVTsKGKTBW
 mDqFp/0IzVXwQEuKeVDWAwpbv2o/6s0axe+N+niF0towGtmbb1ZUWmRIhgWuDGl6hARs6sXzg
 8mv+tDtO+19Sf/W4CtW8N+JbDUP+6dwM8fSZWDUNLnw+UC35BhtVclnUNiIAaSbAyQLeWGOQ2
 4eaeVE8eKl/6eQxDUvJnCiO7XKgNJEJ12aWF7EuokhVwLvbL3nEIOHf/e1DGcMeLq0EaUgD6W
 MZHO0MPwqT+f5q+5lS1KkoRRdGD1iOpkI77BEDm7kfqWDN/Hc05OZHojpkElLPbrZ3la54Fwh
 5v6Bbb8c6EWjI0yrRE++EbwVaEbFeqJgHyL2QPUxhdLhgiGGqa9qWM3A+7sBp9n64t3kb74FS
 txZUFL39OyHgk8wqo6jmcdAxlixHUqU6z3wc1iOoT42n4XNEx+QGx4nUb+9IBNivf2nhHdKNq
 TGsW/hbYmQULjkS8M8aqhQSfpa46fI3bBQ+kBH/XCPvGSXiW1GTL3b/nS88tbAUuicSjj5VkK
 Ma5rNhfhM1Vr9zMC85+NULbajbTNsLq34KgDliQO9lGiFt5FUIj+UKQYaJO+gzeObJNVvCzxC
 QbXV3MJjkwvzYGeLC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.05.20 um 11:52 schrieb Ren=C3=A9 Scharfe:
> Reported-by: Junio C Hamano <gitster@pobox.com>

Forgot to add:

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>

Thanks for noticing, Denton!

> ---
>  fsck.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fsck.c b/fsck.c
> index 8bb3ecf282..b48426262c 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -598,7 +598,7 @@ static int verify_ordered(unsigned mode1, const char=
 *name1,
>
>  	/*
>  	 * There can be non-consecutive duplicates due to the implicitly
> -	 * add slash, e.g.:
> +	 * added slash, e.g.:
>  	 *
>  	 *   foo
>  	 *   foo.bar
> --
> 2.26.2
>
