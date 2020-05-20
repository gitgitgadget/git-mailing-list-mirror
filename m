Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF12C433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 21:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15E1620823
	for <git@archiver.kernel.org>; Wed, 20 May 2020 21:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgETVu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 17:50:27 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:55564 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgETVu1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 17:50:27 -0400
Received: from [89.243.191.101] (helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jbWbZ-000AE0-G5; Wed, 20 May 2020 22:50:26 +0100
Subject: Re: How do Git on Linux users launch/read the user-manual?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <8142f64b-9b5e-3637-21a2-3671dd65a42e@iee.email>
 <xmqqtv0athz5.fsf@gitster.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <6dd15666-1e3e-e9b2-d98b-396d58f241cd@iee.email>
Date:   Wed, 20 May 2020 22:50:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqtv0athz5.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 20/05/2020 22:27, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>> I can then browse that directory to find user-manual.html and open it
>> from there (because I know it is there!).
>>
>> How do Git on Linux users launch/read the user-manual?
> Start from the same starting point
>
> $ git help -w git
>
> and then navigate to the link to "Git User Manual"?
>
And then what? Is it always some .html viewer, or viewing the raw .txt
file, or something else? (it isn't the man view..)
--
Philip
