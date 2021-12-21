Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD61C433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 17:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240785AbhLUR5c (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 12:57:32 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:50308 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233053AbhLUR5b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 12:57:31 -0500
Received: from host-92-7-140-211.as13285.net ([92.7.140.211] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mzjOD-0003Kn-Dw; Tue, 21 Dec 2021 17:57:30 +0000
Message-ID: <fcdef044-8bec-35b4-431f-40a79ed3c47b@iee.email>
Date:   Tue, 21 Dec 2021 17:57:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Why does "merge --continue" expect no arguments?
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>,
        Daniel Vicarel <shundra8820@gmail.com>
Cc:     git@vger.kernel.org
References: <CALRdAfcyfesNqfLhhe2GW_5V9s2hf++i6mZS1Lw5hqQYTca85w@mail.gmail.com>
 <xmqqlf0dq3t3.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqlf0dq3t3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/12/2021 17:13, Junio C Hamano wrote:
> Or we could throw in another
>
>  * document more clearly that "merge --continue" is a mere synonym
>    for, and hint that there is no reason to favor it over, "git
>    commit".
>
> which happens to be my favourite so far after thinking the above
> through.
>
> Thanks.
I'm all for including the "document more clearly" approach...

With or without the code change.

--
Philip
