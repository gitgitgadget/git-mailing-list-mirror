Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519FBC433EF
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 19:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D43961175
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 19:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbhJSTfs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 15:35:48 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:50358 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230481AbhJSTfr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 15:35:47 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4HYkSB2Rv2z5tl9;
        Tue, 19 Oct 2021 21:33:29 +0200 (CEST)
Subject: Re: What's cooking in git.git (Oct 2021, #05; Mon, 18)
To:     Junio C Hamano <gitster@pobox.com>
References: <xmqq1r4hv7bv.fsf@gitster.g>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <55716d3f-a0e6-a047-49f1-bf2be8ba2b72@kdbg.org>
Date:   Tue, 19 Oct 2021 21:33:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqq1r4hv7bv.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.10.21 um 08:48 schrieb Junio C Hamano:
> * js/userdiff-cpp (2021-10-10) 6 commits
>   (merged to 'next' on 2021-10-18 at fea77f6c4e)
>  + userdiff-cpp: learn the C++ spaceship operator
>  + userdiff-cpp: permit the digit-separating single-quote in numbers
>  + userdiff-cpp: prepare test cases with yet unsupported features
>  + userdiff-cpp: tighten word regex
>  + t4034: add tests showing problematic cpp tokenizations
>  + t4034/cpp: actually test that operator tokens are not split
> 
>  Userdiff patterns for the C++ language has been updated.
> 
>  Will merge to 'master'.

Please don't, yet. There is a regression that, e.g., 2' as in '2' is
regarded as a token.

Will submit a fix (the plan is to undo the digit separator thing), but
it'll take a week or two as I am currently knocked out.

-- Hannes
