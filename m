Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9DEC433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 17:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbiA0Ruj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 12:50:39 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62944 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiA0Rui (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 12:50:38 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 463371743F6;
        Thu, 27 Jan 2022 12:50:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=c0d0qNvnyGtv90ciZCb8WUhgY7gqMJraSPg84c
        l9FR4=; b=tcO3+2xe5zObGwB9i8dIk/MBOtB06FKhem/bFcmBrImeojYu6GI1O5
        Y9gDn8C76s3kcQryJWeGtGOxD3ehksYUa5YKTNnRLrJNDIs86dln6YVYSbj81xPU
        JlcWFBcurt+wCkzIOLsbOWrulg24uNBGqCwNkTcpduXKq+MgmRVDA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3F6B31743F5;
        Thu, 27 Jan 2022 12:50:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AE7701743F4;
        Thu, 27 Jan 2022 12:50:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Greg Hurrell" <greg@hurrell.net>
Cc:     "Git Mailing List" <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 1/2] Documentation/config/pgp.txt: replace stray
 <TAB> character with <SPC>
References: <220125.861r0vhh8r.gmgdl@evledraar.gmail.com>
        <20220126121426.53799-1-greg@hurrell.net>
        <20220126121426.53799-2-greg@hurrell.net> <xmqq5yq56hbu.fsf@gitster.g>
        <4216fdca-cf73-4bf6-b911-90c6c7ba0e2d@beta.fastmail.com>
Date:   Thu, 27 Jan 2022 09:50:34 -0800
In-Reply-To: <4216fdca-cf73-4bf6-b911-90c6c7ba0e2d@beta.fastmail.com> (Greg
        Hurrell's message of "Thu, 27 Jan 2022 09:20:40 +0100")
Message-ID: <xmqqee4t3w5x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A176AE46-7F99-11EC-B95B-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Greg Hurrell" <greg@hurrell.net> writes:

> On Thu, Jan 27, 2022, at 3:30 AM, Junio C Hamano wrote:
>> Greg Hurrell <greg@hurrell.net> writes:
>> 
>> > Specifically, replace the tab between "the" and "first" with a space.
>> 
>> Good eyes.  Does it have ANY practical downside to leave it unfixed?
>> 
>> In other words, how did you spot it (e.g. "asciidoctor passes tab as-is
>> and screwed up an alignment of the text, which was how I noticed it")?
>
> The nearby fix (the apostrophe) in the other commit was what had me
> looking at this file in the first place. But my editor (Neovim)
> made the mid-line tab visually obvious, so I figured may as well clean

Ah, yes, highlighting editors and pagers.  I forgot about them.

In any case, thanks for the fixes.  Queued.
