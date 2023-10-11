Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5998CCD98F6
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 07:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344329AbjJKHN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 03:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345428AbjJKGSt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 02:18:49 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F0A1A7
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 23:17:14 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1697005031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r43eH3McujMdmrn6It2Ev4JK8IsWGbtzC0LakDZ1MXk=;
        b=f7fi50f+pG4wr/nQtZZZuTSKtpu0fu7WFpasyYp/Z4gA3NWJZgJTi3GQsdxdBd3MC76oFg
        ZlIfB1fvJxDBIk8YJwUMArVZUrlON3KTKR6FA/cVDn96JPqRjSZPZSaeUW4P2l62v9nWQ4
        fdPbZogFeYJvZ2PQ9KyV0M2UkvAmHm+q7P4MRwdzXyX1OvXh1kXFQYckg9LMClOUDfKvWN
        0YRjw07MdHS81tELil97JmVnnudDIVCG9vXlWnbBq0kVvPUGYXLYwoZTgifACzVwXl07u5
        2GKGzr/1xV3GwTgTK1mVyMWlWHuHZk8QhzgcJ4wnI7/hV0yZwEkOEHHaijncbg==
Date:   Wed, 11 Oct 2023 08:17:10 +0200
From:   Dragan Simic <dsimic@manjaro.org>
To:     Naomi Ibe <naomi.ibeh69@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] [OUTREACHY] Fixed add.c file to conform to guidelines
 when using die() listed in issue #635
In-Reply-To: <CACS=G2wXkz9OyR5e0ADzWVy3ejibF-Js=sdJYJDRMh8qskO-9A@mail.gmail.com>
References: <20231009011546.509-1-naomi.ibeh69@gmail.com>
 <xmqqlecbzl5e.fsf@gitster.g>
 <CACS=G2yUGGJwD05KOFZK+AV3TSNDvDEfC=pFRsLwKX_-dgt+gA@mail.gmail.com>
 <xmqq34yiqfoh.fsf@gitster.g>
 <CACS=G2wXkz9OyR5e0ADzWVy3ejibF-Js=sdJYJDRMh8qskO-9A@mail.gmail.com>
Message-ID: <89c51050c7570439f763f8fc8195aada@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-10-11 07:50, Naomi Ibe wrote:
> Okay then, I'll work with these guidelines in mind. Thank you very much

If I may notice, avoiding top posting has already been suggested twice, 
IIRC.

I think that various webmails have made top posting popular, and 
actually forced people a bit to do that through the way their user 
interfaces were laid out, which made inline replies kind of a dying art, 
which is really sad to see.  It is so much more useful when replies are 
posted inline, i.e. right below the contents they refer to.


> On Tue, Oct 10, 2023 at 11:24 PM Junio C Hamano <gitster@pobox.com> 
> wrote:
>> 
>> Naomi Ibe <naomi.ibeh69@gmail.com> writes:
>> 
>> > Thank you very much! I'd definitely make those changes on my next patch.
>> 
>> [administrivia] do not top post.
>> 
>> > Should I begin work on version 2 or should I still wait for additional
>> > input on the version 1?
>> 
>> There is no "rule", but based on observations on how people behave,
>> e.g.
>> 
>>  * for a small patch like this that can be given a good review in 10
>>    minutes or so, those who do not do so within the first 3 days
>>    will probably not do so.
>> 
>>  * once a reasonably thorough review is given, those who haven't
>>    responded to the patch and do not have much else to say are
>>    unlikely to respond.
>> 
>>  * on the other hand, after such a review is given, those who do not
>>    agree with the review tend to respond rather quickly, to get
>>    their voice in before it becomes too late.
>> 
>> I would say it would be good to start working on it right away and
>> use a couple of days reviewing it yourself before posting it.
