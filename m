Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F28C1F463
	for <e@80x24.org>; Tue, 24 Sep 2019 06:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438657AbfIXGVP (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 02:21:15 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:20085 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393474AbfIXGVO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 02:21:14 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 46crfw21d9z5tlD;
        Tue, 24 Sep 2019 08:21:12 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 4E1FD117;
        Tue, 24 Sep 2019 08:21:11 +0200 (CEST)
Subject: Re: [PATCH v2 2/2] t0028: add more tests
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Cc:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.347.git.gitgitgadget@gmail.com>
 <pull.347.v2.git.gitgitgadget@gmail.com>
 <40e54cf5ce74d1404187e31c94644df29134b4ff.1569233057.git.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <163fcc3c-e827-ad15-5987-a2ae93a0bec2@kdbg.org>
Date:   Tue, 24 Sep 2019 08:21:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <40e54cf5ce74d1404187e31c94644df29134b4ff.1569233057.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.09.19 um 12:04 schrieb Alexandr Miloslavskiy via GitGitGadget:
> From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
> 
> After I discovered that UTF-16-LE-BOM test was bugged and still
> succeeded, I decided that better tests are required. Possibly the best
> option here is to compare git results against hardcoded ground truth.
> 
> The new tests also cover more interesting chars where (ANSI != UTF-8).

What are we testing here? Is there some back-and-forth conversion going
on, and are we testing that the conversion happens at all, or that the
correct conversion/encoding is picked, or that the conversion that is
finally chosen is correct? Why does it help to test more interesting
chars (and would you not also regard codepoints outside the BMP the most
interesting because they require surrogate codepoints in UTF-16)?

-- Hannes
