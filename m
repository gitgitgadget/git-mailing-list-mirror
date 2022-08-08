Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D66BC00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 14:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242421AbiHHOcl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 10:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiHHOck (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 10:32:40 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB4465C2
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 07:32:39 -0700 (PDT)
Received: from host-92-1-139-136.as13285.net ([92.1.139.136] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oL3o5-000B8P-Ei;
        Mon, 08 Aug 2022 15:32:37 +0100
Message-ID: <e454bf85-046d-6205-57e7-4c00b9faa589@iee.email>
Date:   Mon, 8 Aug 2022 15:32:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 4/4] doc add: renormalize is not idempotent for CRCRLF
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
 <d3b8ed97a105ea1d7e656c964b7eee378e11ede6.1657385781.git.gitgitgadget@gmail.com>
 <20220710074848.ku2zobuck6vyim5d@tb-raspi4>
 <1b90edd0-3d9d-a741-8865-3968826da315@iee.email> <xmqq5yj6z5rx.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqq5yj6z5rx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've unfortunately had some family issue which prevented me doing any work.

If I haven't managed anything by the end of the week. I'd be happy if
others took it forward.

On 05/08/2022 23:26, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>>> How about this:
>>>
>>> This option implies `-u`. Lone CR characters are untouched. CRCRLF cleans to CRLF.
>> That is probably sufficient. It drops the awkward 'idempotent'. And
>> indicates this edge case, though doesn't highlight that the resultant
>> CRLF still leaves the file only partially renormalised.
>>
>> I'll reword.
> It's been a few weeks since the last activity on this topic.
> Anything you guys need unblocked to move forward?
>
> Thanks.
>

