Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D5CC5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 19:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbjAIT6Z convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 9 Jan 2023 14:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237248AbjAIT6V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 14:58:21 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D400411C36
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 11:58:20 -0800 (PST)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 309JwEVx041408
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 9 Jan 2023 14:58:14 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Eric Sunshine'" <sunshine@sunshineco.com>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Yutaro Ohno via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>, "'Yutaro Ohno'" <yutaro.ono.418@gmail.com>
References: <pull.1422.git.git.1673166241185.gitgitgadget@gmail.com> <xmqqbkn8wcqo.fsf@gitster.g> <018501d9241b$fe4b1270$fae13750$@nexbridge.com> <CAPig+cQ1PMYhWiwRiq2eOWzHYmqcCC6QfkHCuVTxaeA7fz0ddw@mail.gmail.com>
In-Reply-To: <CAPig+cQ1PMYhWiwRiq2eOWzHYmqcCC6QfkHCuVTxaeA7fz0ddw@mail.gmail.com>
Subject: RE: [PATCH] doc: use "git switch -c" rather than "git checkout -b" consistently
Date:   Mon, 9 Jan 2023 14:58:14 -0500
Organization: Nexbridge Inc.
Message-ID: <01ad01d92464$b62492c0$226db840$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQG+uH7vqNUb9eP923D9hpkMAPjYLQKyPbLAAcOsMxIBEpGt7K6fFFcQ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 9, 2023 2:17 PM, Eric Sunshine wrote:
>On Mon, Jan 9, 2023 at 6:20 AM <rsbecker@nexbridge.com> wrote:
>> On January 8, 2023 11:31 PM, Junio C Hamano wrote:
>> >"Yutaro Ohno via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> >> Subject: Re: [PATCH] doc: use "git switch -c" rather than "git
>> >> checkout -b" consistently
>> >
>> >Hmph.  When two things work equally well, is it a good idea to
>> >describe
>> only one
>> >"consistently", or mention both that can be used pretty much
>> interchangeably in
>> >different places?  I am not 100% sure "consistently" is a good thing here.
>> >
>> >Thoughts from others?
>>
>> git switch is still marked as EXPERIMENTAL in the online help. I don't
>> think moving broadly to switch from checkout in the documentation
>> should happen until the EXPERIMENTAL designation is dropped. After that, then
>"switch -c"
>> should be used everywhere instead of checkout (except for in the
>> checkout documentation).
>
>Such a point probably should have been raised when 328c6cb853 (doc:
>promote "git switch", 2019-03-29) was submitted, but since 328c6cb853 was
>merged nearly four years ago and has been pointing people at git-switch all this
>time, it's probably too late to use it as an argument now.

I agree. Perhaps it is time to drop the "EXPERIMENTAL" notices from 'git switch', in that case.

