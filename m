Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B89FC432BE
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 13:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DED760295
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 13:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241853AbhHJNwd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 09:52:33 -0400
Received: from siwi.pair.com ([209.68.5.199]:54380 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233318AbhHJNwd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 09:52:33 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D3A5D3F40D9;
        Tue, 10 Aug 2021 09:52:10 -0400 (EDT)
Received: from DC-2021.bjwce.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id AA5C33F40FA;
        Tue, 10 Aug 2021 09:52:10 -0400 (EDT)
Subject: Re: [PATCH 0/2] fsmonitor: fixup to avoid warnings from pedantic
To:     Carlo Arenas <carenas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com
References: <20210809063004.73736-1-carenas@gmail.com>
 <42dce285-9599-4c7c-d351-44c1e338337e@jeffhostetler.com>
 <xmqqpmumftry.fsf@gitster.g>
 <CAPUEspioazo0js5pZj7TzR2=j-+Aeh+XHr8Nbsszs6cq+WJqmw@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <f2d42d19-9378-5d10-cab4-1541027ad6aa@jeffhostetler.com>
Date:   Tue, 10 Aug 2021 09:52:09 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAPUEspioazo0js5pZj7TzR2=j-+Aeh+XHr8Nbsszs6cq+WJqmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/10/21 1:49 AM, Carlo Arenas wrote:
> On Mon, Aug 9, 2021 at 9:49 AM Junio C Hamano <gitster@pobox.com> wrote:
>> Jeff, I understand that this is planned to be rerolled post release,
>> so I'll not touch these fixups and let you worry about them ;-)
> 
> Jeff,
> 
> As I mentioned in the cover letter[1] there is an extra patch[2] not
> in the series and that also applies to maint, but is not critical and
> might be better if included with your reroll IMHO, thanks.
> 
> Carlo
> 
> [1] https://lore.kernel.org/git/20210809063004.73736-1-carenas@gmail.com/
> [2] https://lore.kernel.org/git/20210809072551.94391-1-carenas@gmail.com/
> 

You're talking about the commit with "%lf" vs "%f".

I saw that, but I was unsure what it had to do with my FSMonitor
series.  It seemed like it could just be a standalone patch by itself.

(I'm not opposed to including it in mine, but it'd be easier and
quicker to just treat it in isolation, IMHO.)

Thoughts??

Jeff
