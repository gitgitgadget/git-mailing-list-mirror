Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84561C433EF
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 07:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346850AbhLWHi1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 02:38:27 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:13034 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229965AbhLWHi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 02:38:26 -0500
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4JKMW30sDGz5tl9;
        Thu, 23 Dec 2021 08:38:22 +0100 (CET)
Subject: Re: [PATCH 3/9] trace2: defer free of TLS CTX until program exit.
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
 <e0c41e1fc7895ba67d7536115cd8c1598439ded1.1640012469.git.gitgitgadget@gmail.com>
 <xmqqlf0equs3.fsf@gitster.g>
 <a6f2a38b-926a-4b47-fd3f-b1327a7c3fcb@jeffhostetler.com>
 <xmqqwnjwdz9j.fsf@gitster.g>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <84bce2d2-b6ff-547d-2d1f-a79200eb79a3@kdbg.org>
Date:   Thu, 23 Dec 2021 08:38:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqwnjwdz9j.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.12.21 um 23:56 schrieb Junio C Hamano:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>> I hadn't really thought about the term "TLS" in the context
>> of crypto -- I had "thread local storage" on the brain.  I guess
>> I've spent too much of my youth using Win32 thread APIs. :-)
>>
>> Let me take a look at removing those terms.
> 
> Nah, it may be just me.  As long as what TLS stands for is clear in
> the context, it is fine.

No, really, my first reaction was, too: what the hack has crypto to do
with trace2? Are we now sending around trace output by email?

Please use "TLS" next to "CTX" only when it means "Transport Layer
Security".

-- Hannes
