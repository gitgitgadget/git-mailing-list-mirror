Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4ABC2BA19
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 00:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C66F206ED
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 00:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="afXZL3M/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgDXA64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 20:58:56 -0400
Received: from avasout07.plus.net ([84.93.230.235]:35019 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgDXA6z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 20:58:55 -0400
Received: from [10.0.2.15] ([217.32.115.138])
        by smtp with ESMTPA
        id Rmg8jRvr3sCJiRmgAjx4kK; Fri, 24 Apr 2020 01:58:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1587689934; bh=6JHo32ZeEylx3Gkm1m76ObwH0JpND8S9Ubwa9AwNG4I=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=afXZL3M/0N/VlYmybfSsLqU4kSfU5DV/rbkO/T9jyeUDUfyXtGyWUR/CTT3HWTPOE
         aTiBtQaSYDmSOikEJrZmrpEvw0OYj5VOua9frz1cpZw8BybFaL7Su1q1tc5Km/zwik
         Mh1w7gi8LUnpa7ABFxcXb01/u8pWNg0zp9gTSVTb8ynOYpFuFafDF+jLI+xjzO3GPu
         uAaGhmm0gdwGXgHoBnjDPqKs4nVxjV9ecjhMsJ2xvzOHVdhXVfcoof90fS5E4pYsy5
         qjoaIxbl7hSrulETp5XvnXRWA3D4GrDSh8FGIs37rhDNk6HGaLlPgG9v9KEIauzzSn
         /bN2DPyER9nPA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=BPIoUGYG c=1 sm=1 tr=0
 a=T9WNts+jH3PhiGdS1gtV5Q==:117 a=T9WNts+jH3PhiGdS1gtV5Q==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=knonjEixnh5wqxD-4ycA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 4/4] progress.c: silence cgcc suggestion about internal
 linkage
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
References: <cover.1587648870.git.congdanhqx@gmail.com>
 <dddf2d402702a616e04e7e446e31e0c6697d8c49.1587648870.git.congdanhqx@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <cbe8fcac-d7d5-8db2-cf69-6f04136337c9@ramsayjones.plus.com>
Date:   Fri, 24 Apr 2020 01:58:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <dddf2d402702a616e04e7e446e31e0c6697d8c49.1587648870.git.congdanhqx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfBywOlBfSiDyjNDQVe9b1by/u3UN03J57Q3cxCc9JKrIhQdeWYMXYQJtZLMOxZtgKCKWPvqzlaWs2927fTANj8++uCvK6bUqcAWSdEmVl6uPYqydab/D
 Fq6Z4c99K91745KBjVnuyAUzOyeuHSesGXDT/2HDOPSOTYVIhxlgbtGPKPpXc4inyL4nZNrUNNZfLQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 23/04/2020 14:47, Đoàn Trần Công Danh wrote:
> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> ---
>  progress.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/progress.c b/progress.c
> index 19805ac646..fb53a2ec0c 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -50,7 +50,9 @@ static volatile sig_atomic_t progress_update;
>   * These are only intended for testing the progress output, i.e. exclusively
>   * for 'test-tool progress'.
>   */
> +extern int progress_testing; /* to silence sparse: internal linkage */
>  int progress_testing;
> +extern uint64_t progress_test_ns; /* to silence sparse: internal linkage */
>  uint64_t progress_test_ns = 0;
>  void progress_test_force_update(void); /* To silence -Wmissing-prototypes */
>  void progress_test_force_update(void)

My preference would be to add these extern declarations to the
progress.h header file, with a note that they are only used by
the 't/helper/test-progress.c' test helper. (Also, remove the
extern declarations from test-progress.c, of course).

But this works as well. :D

ATB,
Ramsay Jones

