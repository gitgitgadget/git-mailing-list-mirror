Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B02BB1F45F
	for <e@80x24.org>; Sun,  5 May 2019 05:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfEEFNh (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 May 2019 01:13:37 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53982 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfEEFNh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 May 2019 01:13:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2D61A6D8D9;
        Sun,  5 May 2019 01:13:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VFoJ6mtn3nk4Jp7i7ckDMyEJjR8=; b=M347C9
        VxAgMEr0n3975y65LEt4lPHP10WaVk1GDgxrJQQVc6ziIJGQIE5XwQkmXF2j/j06
        BVs6gBHLasZO8vl5hrxYWOQjwVdvrVe0MSyaQ8kYHIcC0Ro8pia24hW2GVDym2Yb
        /v4dNcVOSb77VHTk+WDE7iGfiaYgjIQyby03g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LiXvRC2ZyBCaINqYS2rqCIHgAWWk50lb
        3hqr1RTBvZnk3R0bDYBoJXP5RA3leMslSDZM/1PUh6WSLOQ+gNCt44dd3OIFigib
        rao5gFgTINL7d4g1XAiL9ggfTKXqY3KHjYoIkjuFC7fyGRFK1/yMkipnnQt1JYpZ
        IpvUF7k0fqQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2501C6D8D8;
        Sun,  5 May 2019 01:13:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3EF7C6D8D7;
        Sun,  5 May 2019 01:13:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: js/macos-gettext-build, was Re: What's cooking in git.git (Apr 2019, #05; Thu, 25)
References: <xmqqsgu6wfv9.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1904291818530.45@tvgsbejvaqbjf.bet>
Date:   Sun, 05 May 2019 14:13:28 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1904291818530.45@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 29 Apr 2019 18:20:13 -0400 (DST)")
Message-ID: <xmqqzho1scuf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8585A3D0-6EF4-11E9-980E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Thu, 25 Apr 2019, Junio C Hamano wrote:
>
>> * js/macos-gettext-build (2019-04-15) 1 commit
>>   (merged to 'next' on 2019-04-22 at de4cbb1431)
>>  + macOS: make sure that gettext is found
>>
>>  Build with gettext breaks on recent macOS w/ Homebrew when
>>  /usr/local/bin is not on PATH, which has been corrected.
>
> This description is almost correct: the problem fixed in this patch is
> that `/usr/local/include` seems not to be in the header search path of
> Homebrew's `gcc` on Mojave.

Ack.  Thanks.  Will update the draft release notes.

