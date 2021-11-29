Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80384C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 17:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348684AbhK2RXy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 12:23:54 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64864 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238841AbhK2RVx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 12:21:53 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 343B1EEBA5;
        Mon, 29 Nov 2021 12:18:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rvRiW3BDnh+jHJbcguqZFpnMC/yNo38hZFZRxu
        H4KOc=; b=ZSJ6Lwylm/ZUs/LyNhPtpGtWJFXStctVauhxJNy+OY9ri6ukWdrtk5
        T/1nqanUKw0vZ7rd3vp0QZaXdth+/LzG4+y1rtllFviTvI7qUCsJDQ+2vI+tG+qX
        mSIA6KKJcCQR8Wwn/yCRRCr2acSzHb16D+26hbDQJObYF/NQ1UN7M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2ACCEEEBA4;
        Mon, 29 Nov 2021 12:18:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8ED22EEBA3;
        Mon, 29 Nov 2021 12:18:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Eric Wong <e@80x24.org>, Thorsten Leemhuis <linux@leemhuis.info>,
        workflows@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, git@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH v1 1/1] docs: add the new commit-msg tags
 'Reported:' and 'Reviewed:'
References: <cover.1637566224.git.linux@leemhuis.info>
        <6b760115ecdd3687d4b82680b284f55a04f3ad90.1637566224.git.linux@leemhuis.info>
        <20211123185237.M476855@dcvr>
        <12cefa81-495b-3083-5f19-b319c704ebf7@leemhuis.info>
        <20211126171141.GA21826@dcvr>
        <42ff6b8d-0b7c-12e0-4648-a9232b0f577c@leemhuis.info>
        <20211127195231.GA4636@dcvr> <xmqqtufx5p19.fsf@gitster.g>
        <87mtlnjhj6.fsf@intel.com>
Date:   Mon, 29 Nov 2021 09:18:32 -0800
In-Reply-To: <87mtlnjhj6.fsf@intel.com> (Jani Nikula's message of "Mon, 29 Nov
        2021 14:03:09 +0200")
Message-ID: <xmqq5ysa5193.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6203B8F6-5138-11EC-BAC5-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jani Nikula <jani.nikula@intel.com> writes:

> From the RFC nitpicking department, ...
>
> Message-ID: (comment) 
>   <message-id@example.com>

Thanks for a fun piece; the (comment) is quite interesting.

I wasn't having fun with RFC nitpicking, though.  I was reacting to
this part of the message I was responding to ...

>>> Fwiw, every mail and HTTP/1.x header parser I've looked at works
>>> case-insensitively.  Also, I'm not sure if `g' is needed, actually...

... to say that "works case-insensitively" may not just be
empirically correct, but RFC backs him up, to Eric.
