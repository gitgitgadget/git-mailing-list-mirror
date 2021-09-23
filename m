Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBCEC433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 00:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 638D960F4C
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 00:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238625AbhIWALw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 20:11:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54534 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbhIWALs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 20:11:48 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C940A15BEFC;
        Wed, 22 Sep 2021 20:10:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FmHHtMUqP63cJuLVd3Dcz31ITiLMXkGv0jDUBv
        Q5QfU=; b=hrirhuH0q0MkEMYilsoy9M0RSXW/hxZVbcyLWi/Zr5HjrSZIOQmbf/
        JSQSL1769lFP/J8ikbCx5fNE1lJjeIJzPSVizE0Qqb/oBb57AzyRRJn4kYC11/Ov
        s7kifItH/x6Q/NftJ95zN2DtfsgteArOJlckxb6f81nTTGrHo20GA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C160515BEFA;
        Wed, 22 Sep 2021 20:10:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2F9FB15BEF9;
        Wed, 22 Sep 2021 20:10:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] difftool: fix word spacing in the usage strings
References: <20210921111712.894245-1-bagasdotme@gmail.com>
Date:   Wed, 22 Sep 2021 17:10:14 -0700
In-Reply-To: <20210921111712.894245-1-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Tue, 21 Sep 2021 18:17:13 +0700")
Message-ID: <xmqqk0j840ex.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A0A200CE-1C02-11EC-B288-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Remove spaces in `non - zero` and add a space between the diff
> format/mode and option parentheses in difftool's usage strings.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>
> Changes since v1 [1]:
>   - Touch up commit message to imperative tone (suggested by David
>     Aguilar)
>
> Range-diff against v1 [1]:
> 1:  d27159f7c9 ! 1:  18d5034c80 difftool: word spacing fix
>     @@ Metadata
>      Author: Bagas Sanjaya <bagasdotme@gmail.com>
>      
>       ## Commit message ##
>     -    difftool: word spacing fix
>     +    difftool: fix word spacing in the usage strings
>      
>     -    Two grammar fixes related to word spacing:
>     -
>     -      - delete space in `non - zero`
>     -      - add space between diff formats/mode and option parentheses
>     +    Remove spaces in `non - zero` and add a space between the diff
>     +    format/mode and option parentheses in difftool's usage strings.

OK.

Will queue; thanks.
