Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B409C54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 16:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7207B20663
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 16:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="fkisrUGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgD0Qf0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:35:26 -0400
Received: from avasout07.plus.net ([84.93.230.235]:38475 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgD0Qf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 12:35:26 -0400
Received: from [10.0.2.15] ([217.32.115.138])
        by smtp with ESMTPA
        id T6j0jVy1XsCJiT6j1jykx1; Mon, 27 Apr 2020 17:35:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1588005324; bh=mvXR5AmFzojtt1hKCTsxB+6F2OMA0SGlHrLEvFzP71o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fkisrUGITqIUZRBqLeeN1lN7pybemXIcLtGDI/6QouOhriCDXbqfnRC7SYCBNpGdp
         IWHQd+ex1iexoQdZ5fVWURaJLaGQbGdN66pAkjg2xvXZAl9Yo/RHk5WZVKWGniPVRf
         RK6VWf5fZgABp8+AoX4CbTxlz6gq9d64QgdDtFHNJMvyMRWVzMA4G56BRAAVUlu7Iu
         2v/vcX5qmWZKZ9vki+rU7+741/nKY9F4hMCq2tClVZ8nx2Y92WuIHruq/vOdWqdVoG
         2ctgJW6CuHP9z4EMkifEwPMyxqVjA/O2TtGVjca6a11ul2kPGW013E4bHiyOXuMDNd
         mtoaODdXkuhig==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=BPIoUGYG c=1 sm=1 tr=0
 a=T9WNts+jH3PhiGdS1gtV5Q==:117 a=T9WNts+jH3PhiGdS1gtV5Q==:17
 a=IkcTkHD0fZMA:10 a=p0Vbu1KTBGNiiCjSEvcA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v3 0/4] Partial fix `make sparse`
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <cover.1587648870.git.congdanhqx@gmail.com>
 <cover.1587996765.git.congdanhqx@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <2c62be65-7350-aa52-dead-46ddea7baca6@ramsayjones.plus.com>
Date:   Mon, 27 Apr 2020 17:35:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <cover.1587996765.git.congdanhqx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfNSFXrU30E4wPmySGEeH5xxpsWQhgday8rOrP8Ryhpegbdn8Jr9pVFRUBoq+GkN03+E4KP+8+/N1ju5XKKQwZzAX2+tDH3bsXZaztWQqSwT6xXOVOU8R
 0WNPtU/9rHHmxRSsI/4mpsHVddzys9VfLNGtiyXmX3YqPjD2GY38/YN81FnwwFDnkphPg2OYo9N0Tg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 27/04/2020 15:22, Đoàn Trần Công Danh wrote:
> Change in v3 from v2:
> * rewrite [2/4] based on Ramsay's suggestion

Yep, these all look good to me. Thanks!

ATB,
Ramsay Jones

> 
> Change in v2 from v1:
> * = { 0 } is an idiom to zero the structure, it shouldn't be changed
> * change in [4/4] for prototype
> * ignore diffent function prototype
> 
> 
> Đoàn Trần Công Danh (4):
>   test-parse-pathspec-file.c: s/0/NULL/ for pointer type
>   compat/regex: move stdlib.h up in inclusion chain
>   graph.c: limit linkage of internal variable
>   progress.c: silence cgcc suggestion about internal linkage
> 
>  compat/regex/regex.c                | 1 +
>  compat/regex/regex_internal.h       | 1 -
>  graph.c                             | 2 +-
>  progress.c                          | 2 +-
>  progress.h                          | 8 ++++++++
>  t/helper/test-parse-pathspec-file.c | 6 +++---
>  t/helper/test-progress.c            | 9 +--------
>  7 files changed, 15 insertions(+), 14 deletions(-)
> 
> Range-diff against v2:
> 1:  c9a1812abf = 1:  c9a1812abf test-parse-pathspec-file.c: s/0/NULL/ for pointer type
> 2:  290ba923b5 < -:  ---------- compat/regex: include alloca.h before undef it
> -:  ---------- > 2:  8d18c53bc8 compat/regex: move stdlib.h up in inclusion chain
> 3:  39f8d85c2f = 3:  4e7580e1d1 graph.c: limit linkage of internal variable
> 4:  41eecf18ed = 4:  d66d9aa677 progress.c: silence cgcc suggestion about internal linkage
> 
