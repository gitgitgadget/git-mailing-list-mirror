Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E30C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 21:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8E4B613B6
	for <git@archiver.kernel.org>; Thu, 13 May 2021 21:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbhEMVFI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 17:05:08 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:46658 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233247AbhEMVFH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 17:05:07 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4Fh3zv2ptPz5tlD;
        Thu, 13 May 2021 23:03:55 +0200 (CEST)
Subject: Re: Git pathspecs difference in behavior between linux (wsl) and
 windows
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alexandre Remy <alexandre.remy.contact@gmail.com>,
        git@vger.kernel.org
References: <CAKToE5BnzXd_2pjhJY13E=e6b1ZgOV=NmXr_WfpCQd+LxXsO3A@mail.gmail.com>
 <81d06db6-fd91-7ec5-6aa5-84f69a227204@kdbg.org>
 <CAKToE5DgtW1Kuw4AE5+Am_=9gATN-S=xk1kYXMZUWvtdtNy_PQ@mail.gmail.com>
 <CAKToE5DEL1ZFwUbvcC-M3y-3mSVsVgMXDig4G=jcKbc-nJ_GnQ@mail.gmail.com>
 <68a4ebd3-3c80-8983-9a26-f205debc4b5b@kdbg.org> <xmqqeeeabdml.fsf@gitster.g>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <dbf1e10c-c43c-3293-61b7-eff5fceecb84@kdbg.org>
Date:   Thu, 13 May 2021 23:03:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <xmqqeeeabdml.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.05.21 um 22:08 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> Am 13.05.21 um 11:31 schrieb Alexandre Remy:
>>> I have an additional question, does double-quotes be safely used in
>>> both windows (that's ok) and linux shell  for pathspecs (git status --
>>> "src/test.js") in case of spaces in the path?
>>
>> They can be used in both POSIX shell and Windows CMD and, I would
>> assume, also in the PowerShell. Note though, that there are subtle
>> differences when other special characters occur between double-quotes,
>> notably the backslash. Please use your favorite search engine to learn more.
> 
> And a dollar sign, in addition to the backslash?

Granted, there's not a subtle, but a big difference how the dollar sign
is treated ;) but I don't want to write a tutorial here. Hence, my hint
towards a search engine.

-- Hannes
