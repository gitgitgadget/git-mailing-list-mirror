Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7EDC433EF
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 00:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29B2A60F8F
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 00:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243089AbhIRA2N (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 20:28:13 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58878 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbhIRA2K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 20:28:10 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3E6BD162557;
        Fri, 17 Sep 2021 20:26:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nGDHmJ+ckHOv
        40CjkFMtwfaCKodOqh7v4lfBaTl4xNw=; b=lOCbBTwQdBpVj4tcUXf0NbxHyQKj
        JUFvv3w/F5VBeeULAQKeHmQlDeGGEF77+sNbm0XF7+lftP+CI/796KvMzpnrIFCK
        ETFM7ZeRG6jn1eSBrneGdrZ/O6KOpW9UPPqSlVOvUDxyuW33e70bE/dFGHoC1nrd
        +j8T2uDE+VUnYsY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 357F0162555;
        Fri, 17 Sep 2021 20:26:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 93C5F162522;
        Fri, 17 Sep 2021 20:26:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, dev+git@drbeat.li
Subject: Re: [PATCH] unicode: update the width tables to Unicode 14
References: <20210917191920.55944-1-carenas@gmail.com>
        <xmqqee9ngda5.fsf@gitster.g> <YUUcJ2+S1V2iI4Xs@carlos-mbp.lan>
Date:   Fri, 17 Sep 2021 17:26:43 -0700
In-Reply-To: <YUUcJ2+S1V2iI4Xs@carlos-mbp.lan> ("Carlo Marcelo Arenas
 =?utf-8?Q?Bel=C3=B3n=22's?=
        message of "Fri, 17 Sep 2021 15:52:23 -0700")
Message-ID: <xmqqczp6g24c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1A4CDC22-1817-11EC-9755-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> On Fri, Sep 17, 2021 at 01:25:38PM -0700, Junio C Hamano wrote:
>> Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:
>>=20
>> > Released[0] after a long beta period and including several additiona=
l
>> > zero/double width characters.
>> >
>> > [0] https://home.unicode.org/announcing-the-unicode-standard-version=
-14-0/
>> > ---
>>=20
>> Thanks---missing sign-off is deliberate and waiting for something
>> else to happen?
>
> Apologies, I corrected it locally and then sent the wrong patch :(
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>

Thanks, will queue.
