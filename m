Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2BF11F97E
	for <e@80x24.org>; Sat, 13 Oct 2018 05:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbeJMMlu (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 08:41:50 -0400
Received: from mout.web.de ([217.72.192.78]:53343 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbeJMMlu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 08:41:50 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M5fwS-1fR2Xq0ub2-00xYQD; Sat, 13
 Oct 2018 07:00:58 +0200
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M5fwS-1fR2Xq0ub2-00xYQD; Sat, 13
 Oct 2018 07:00:58 +0200
Date:   Sat, 13 Oct 2018 07:00:57 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Martin Koegler <martin.koegler@chello.at>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/1] zlib.c: use size_t for size
Message-ID: <20181013050057.GA6805@tor.lan>
References: <xmqqsh1bbq36.fsf@gitster-ct.c.googlers.com>
 <20181012204229.11890-1-tboegi@web.de>
 <20181012222234.GF19800@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012222234.GF19800@szeder.dev>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:ZpdpAVm+SOirUQgyQZh1+wvk3OQ3RrH8uhJIekjcuxaFi6VKz2m
 AlYXHgqCbOg59Tl/9pgOkzrSHBMhy123SS9LtlWkixLfNcmUNjxSOCQF85Tqyqk3A65jNeR
 8GRw7uR1dHeAYo99/ILY72rQRN0A7t9jMisMZhk8qwO+GKGktqVGMtcrSKqMvamggJnrOuR
 o81Qkcj1p0HY3WCG0iuyQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PUzZZL6HyTM=:B9adEw48T1HT0MzTOzNc+w
 HEYaBKuoze5313WO8JYd7dUIEmaYfA8QUe3loB11kXpn6yzGR+YgYQQj+PJR6Da+5L9TT24YA
 +bMRyzPKoLxM1qNKboXbDt9QoAaw3mXKjQ6npTu35+QffLBcfU+reP+gzlxLc4ABTG0JxvIX1
 ux5UOWaxbxbuN18tktZcgb23FMyemu7EZTpD3nDWDeqsMOyUa96+aKwTbiRjXawaD+oMyP8/4
 LCGiY8npLZJpaIXToiW3iwgZADgsOc963vLZ/P+vVhNid2OXRB8y0v1Tz3/cp3iljLRmo8Fzc
 QPWFl6b4cIaLetu9X1amrdzgna6Ax/z9KqPsGm4BvT0L4081xXBHkt3X8wMeQEue0OV8RmKgj
 MQHDNOZc9s3cBk3kVM2BCHkSIsVORui49U+QkNOc6Yjacn66idHDE+E7QdAWkpVGt1QR7rjiY
 y7zK7O0PZA9eyXTlEnkWFZO++xBLtx9++fD0uVFPqZKcrulZUc1tKAuf88Kd8bM9iqaAzFjdu
 VUWqsIrsQyzQGyGUwTPJM41JN3x1a5kMqgGA50Gxzh+pfvAm+RZGCEQGHb4l30AUjidtAElVx
 jvnOxUbHXcCKQ39ru+thqLLyOY+3wNKYqSav/wr4uCqr5uyTAH9+Tq3p7N+p0xZpzMRS3i9Bd
 MqxpWp33N7Pw9TkxBsBg5S8WcyjBv2oSjLkeknY39L9SSCZG+E3neIULCNclYSUJ+6//cJ5qx
 zg/xBSxxpaLLE7V9aavRfnrVn7I2IBtahuwTkrq1nj/aq9mFSYZhr2J6qt8UR2wrfGm674H59
 XgXLQG1hZ4vOH93b/vPobCnFhgtwg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[]
> Neither v1 nor v2 of this patch compiles on 32 bit Linux; see
> 
>   https://travis-ci.org/git/git/jobs/440514375#L628
> 
> The fixup patch below makes it compile on 32 bit and the test suite
> passes as well, but I didn't thoroughly review the changes; I only
> wanted to get 'pu' build again.
> 

Oh, yes, I didn't test under Linux 32 bit (and neither Windows)
I will try to compose a proper v3 the next days.

[snip the good stuff]
