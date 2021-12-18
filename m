Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA04C433F5
	for <git@archiver.kernel.org>; Sat, 18 Dec 2021 00:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhLRAYh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 19:24:37 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51297 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbhLRAYg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 19:24:36 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF761F9108;
        Fri, 17 Dec 2021 19:24:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8w1mHbA1Me5A
        yrweB90RK5dsFXu5n8vQKBmE5pH8R7o=; b=sIbqtHhpSGeZoGSQsbV3JJSTWGGT
        xTz6+XHwGPWZj4NbRXDxm3X+1G6x03fFG4l336mpF0qx98QHSXsHWNRZlplAWMiN
        k3Eplc6u7zdwYG7pr8u+8Cnde9fHb4rbKlUXpXFRy4dzNYZ+La73QXGc3BRd5ota
        JkmQnSu7LztC4M0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A7007F9107;
        Fri, 17 Dec 2021 19:24:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0D9C6F9105;
        Fri, 17 Dec 2021 19:24:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jo=C3=A3o?= Victor Bonfim 
        <JoaoVictorBonfim@protonmail.com>
Cc:     Martin Fick <mfick@codeaurora.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Fw: Curiosity
References: <Wlh_w2gSCDQ2ieJnIY7TStWrzxbwP98SNRIFMTYpva7SRFipqk63HEYFVF7wFn1oSHOkQNsjWGOa5L49vyRlvSLbuZqpmvOaDOHmFkdt2zw=@protonmail.com>
        <wVwq9WVLpVt7MNLmIYOWCFKVSf8l532MD_vu4yTA8hl1fCARnW8nOUJjxYmKSzFw1SnPp5iYRD-aW4gAT2HnyQbC5aLBOvyT6npn88lxwNQ=@protonmail.com>
        <xmqq8rwl91yf.fsf@gitster.g>
        <YbqiQ1B9ezF/RPOn@camp.crustytoothpaste.net>
        <xndBIO9EtrXaA932eF-0YkvHCAOL1GOKQQlIigssmcwhtZWqGxhc6I_A-lXt7vMK-j1oDrQMHUIuExlpqFS4v88nWci32qx3W5Xi1_hPpUM=@protonmail.com>
        <54fe7ba20109f974b61a7e6c24ba8264@codeaurora.org>
        <1X3gQ48NK5aBDHcpYMlxESRjqubcCBKJUQu2K0dBOnTyvsXCXXoGDBg2Ff4KarK6WsZnzN3HgqHGOlCKKdF-wtZQ5tHsoAcfit2CTXMWqh4=@protonmail.com>
Date:   Fri, 17 Dec 2021 16:24:33 -0800
In-Reply-To: <1X3gQ48NK5aBDHcpYMlxESRjqubcCBKJUQu2K0dBOnTyvsXCXXoGDBg2Ff4KarK6WsZnzN3HgqHGOlCKKdF-wtZQ5tHsoAcfit2CTXMWqh4=@protonmail.com>
        (=?utf-8?Q?=22Jo=C3=A3o?= Victor Bonfim"'s message of "Sat, 18 Dec 2021
 00:15:59 +0000")
Message-ID: <xmqq1r2a220u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E0AC61C6-5F98-11EC-A8F8-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jo=C3=A3o Victor Bonfim  <JoaoVictorBonfim@protonmail.com> writes:

>> I suspect that for most algorithms and their implementations, this wou=
ld
>>
>> not result in repeatable "recompressed" results. Thus the checked-out
>>
>> files might be different every time you checked them out. :(
>
> How or why?
>
> Sincere question.

Two immediate things that come to my mind are lossy compression
algorithms (jpeg pictures?) and compressors that do not necessarily
produce bit-for-bit identical results (e.g. gzip by default embeds
timestamp unless explicitly told not to from a command line option).
