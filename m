Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B5FECAAD8
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 16:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiIPQ7f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 12:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiIPQ7c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 12:59:32 -0400
Received: from outbound7.mail.transip.nl (outbound7.mail.transip.nl [IPv6:2a01:7c8:7c9:ca11:136:144:136:7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F329B1C7
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 09:59:27 -0700 (PDT)
Received: from submission10.mail.transip.nl (unknown [10.103.8.161])
        by outbound7.mail.transip.nl (Postfix) with ESMTP id 4MTgK85rdrzQvvND;
        Fri, 16 Sep 2022 18:59:24 +0200 (CEST)
Received: from [131.180.45.14] (x045014.tudelft.net [131.180.45.14])
        by submission10.mail.transip.nl (Postfix) with ESMTPA id 4MTgK80Dtjz1gx2j;
        Fri, 16 Sep 2022 18:59:24 +0200 (CEST)
Message-ID: <045e7914-ab16-4d5e-ea9d-8e3c7c758fff@fwdekker.com>
Date:   Fri, 16 Sep 2022 18:59:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-GB
To:     demerphq <demerphq@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     Git <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <2e846a72-a4c6-2a5a-255a-15eee037f574@fwdekker.com>
 <854127f2-55aa-5636-813d-d91b8a4cdcbc@web.de>
 <CANgJU+Wt_yjv1phwiSUtLLZ=JKA9LvS=0UcBYNu+nxdJ_7d_Ew@mail.gmail.com>
From:   "Florine W. Dekker" <florine@fwdekker.com>
Subject: Re: Wildcards in mailmap to hide transgender people's deadnames
In-Reply-To: <CANgJU+Wt_yjv1phwiSUtLLZ=JKA9LvS=0UcBYNu+nxdJ_7d_Ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: ClueGetter at submission10.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=fwdekker.com; t=1663347564; h=from:subject:to:cc:
 references:in-reply-to:date:mime-version:content-type;
 bh=CPFlP258RhtIRUKB6YXcdecJs6rd4wJOWGoQ3OCIHP8=;
 b=LhwvPcJI/8qPAoHXlvRNGi30J3il93xSumvGmHoNyCgjlEeHz7tjUHBqgw9oEIK1fA+nqU
 +mWxmf0y1s0NkNFgCffB3iYfAOBoGOXIxmrZNiqLI3rRqeVdR34S2HpVZA+in+KfzO/6Qn
 fm1XV19reqUjfhQ+fpafEAZCgkIp+xuMTjupRwy63Q1ncuHf+csuStDT05Ox0LnNRyNkrk
 doJyp/Ir/IN2p9cGdKA5LBHRQCft8Ncb3o4GuHcv74DjO7QPux9BoFyq0fGYfyiv9cLBNO
 F9g6tpfGXBkrqn1pKcSD8plHBvxoATglfl6sogd+QKqb3wplCOlarPOB8yHxPA==
X-Report-Abuse-To: abuse@transip.nl
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/09/2022 11:58, demerphq wrote:
> Yes. The way that git models identity is flawed as it makes the 
> mistake in assuming names are constant attributes of a person. Of 
> course this is not true at all, people change names for all kinds of 
> reasons and in some countries close to half the population will change 
> their name over the course of their lifetime at least once, when they 
> marry. So this is not some woke issue, it's a long standing issue in 
> how men traditionally model identity in software systems. I'm a man 
> and I've made that mistake myself, it's a common blindspot.
>
> Git really should use some level of non cleartext indirection on 
> identity, and store that data outside of the change log. Then history 
> wouldn't need to be written to update someone's particulars and many 
> identity concerns would just go away.
>
> Arguably .mailmap is just a workaround for the mismatch between model 
> and reality and doesnt really solve the problems of names changing and 
> actually makes it worse. Really this should be fixed at a deeper 
> level. The trick I guess is how would one do that in a back compatible 
> way.
>
> Yves

I understand what you mean, and agree that mailmap is just a workaround 
for this issue, having been designed to unify a user's multiple 
identifiers, rather than helping move on from a now-invalid identifier. 
Being completely new to this mailing list, however, I feel that solving 
the issues you raise might be a might much for me to take on.

Instead, for now, I'm interested to see what we can do with mailmap as a 
workaround. I like the idea of using URL encoding, and would like to 
hear others' opinions on doing so. I think it provides a social signal 
on its obfuscated state, it prevents people from accidentally finding 
out, and is easy and efficient to execute.

- Florine


