Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8DEA1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 22:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfILWXy (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 18:23:54 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:28793 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbfILWXx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 18:23:53 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1i8XVH-0005wX-Ck; Thu, 12 Sep 2019 23:23:52 +0100
Subject: Re: [PATCH 2/2] git-gui: add hotkey to toggle "Amend Last Commit"
 check button/menu
To:     Marc Branchaud <marcnarc@xiplink.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Git List <git@vger.kernel.org>
References: <ab1f68cc8552e405c9d04622be1e728ab81bda17.1567713659.git.bert.wesarg@googlemail.com>
 <b82a00441ff1a6a9cea3fd235c1c33729ec31b71.1567713659.git.bert.wesarg@googlemail.com>
 <20190911205539.vb6asqcc22nzgdqa@yadavpratyush.com>
 <CAGr--=Jz9xN6NMmiXjHeq9wZsYUx4eqfQrWjjVMkj3J1YCG_8g@mail.gmail.com>
 <20190912162924.phb5o2ppovnxa7nn@yadavpratyush.com>
 <db01db41-eff0-fb56-161a-ba26d1b18f55@xiplink.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <56a6fbf8-4486-6bad-f847-793bb6b4e070@iee.email>
Date:   Thu, 12 Sep 2019 23:23:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <db01db41-eff0-fb56-161a-ba26d1b18f55@xiplink.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/09/2019 22:34, Marc Branchaud wrote:
>>> I just tested what happens when you press Ctrl+e while Caps Lock is
>>> enabled; the Ctrl+e binding is not invoked. That's probably why other
>>> key bindings have the same function bound for both lower- and
>>> upper-case letters, to have the same behaviour with/without Caps Lock
>>> enabled. With that in mind, we should probably bind Ctrl+E aswell.
>>
>> Nice catch! Makes sense to have the same behaviour for both caps lock
>> enabled and disabled.
>
> (I've been a git-gui user for many years...)
>
> I disagree!  Who expects anything to work properly when capslock is on?
>
>         M.
>
I'd tend to agree. In other areas the use of shift is often used as the 
complement of the unshifted action, so it does feel 'odd'. Thus it could 
be used directly as the bool for amend or direct commit.

This all assumes that Caps Lock is equivalent to having the shift on, 
rather than being a special extra key.

Philip
