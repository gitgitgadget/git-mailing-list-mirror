Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A4DC433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 06:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A09D160F45
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 06:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhKAGtt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 02:49:49 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51321 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhKAGts (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 02:49:48 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2589C15D044;
        Mon,  1 Nov 2021 02:47:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=a15rhiseqyOv
        Su7oEPge0qaQW5w5SInUh0b/rhsfbE4=; b=YIpvj3zFylH47/TLBNCFaNvImZsl
        Ws17QuSiq9p6XWmvpEIpHasw1jc+pqVVzxroErTj5uc4yzBWXA4xLacWD+bID6oV
        DltPwmzTS9ZQ2x8D2AWETgLhcMhvFmgXc25iTfNVjzqoyHiCraCf0DBvuyXjlvPU
        xhYv0Z3sfGMcZ/I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1D24D15D043;
        Mon,  1 Nov 2021 02:47:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C9E7A15D042;
        Mon,  1 Nov 2021 02:47:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Eli Schwartz <eschwartz@archlinux.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/9] doc: use only hyphens as word separators in
 placeholders
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
        <984b6d687a2e779c775de6ea80536afe6ecc0aaf.1635438124.git.gitgitgadget@gmail.com>
        <ee376004-a4dd-539d-28b3-3fc5baa6fe00@archlinux.org>
        <2803948.JoDkH9avOM@cayenne>
Date:   Sun, 31 Oct 2021 23:47:11 -0700
In-Reply-To: <2803948.JoDkH9avOM@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
        "Sun, 31 Oct 2021 21:23:11 +0100")
Message-ID: <xmqqmtmocqz4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8B2845EA-3ADF-11EC-BA77-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

> The choices here may be awkward; no problem to propose even more descri=
ptive=20
> names.
>
>>=20
>>   Similarly "the 'format:<format-string>' format" feels highly
>>   redundant, I expect the reader knows that <string> contains a format
>>   inside it as it's mentioned immediately before *and* after.
>>=20
>
> The fact that it is a string doesn't tell you much about what you can d=
o with=20
> it. For me, this isn't a problem that the explanation is redundant.

I agree that --format:<string> is quite poor, as type alone does not
give readers any information on what it means and how it is supposed
to look like.  Calling it <format-string> does make quite a lot of
sense.

It is a bit less obvious how much value we get out of <bool-value>,
though.  In --opt=3D<arg> scheme of things, what comes after '=3D' are
all <value>s, so <bool-value> does not clarify over <bool> like the
way <format-string> clarifies over <string>.

