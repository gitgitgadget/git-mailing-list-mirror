Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2820FC433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 16:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239144AbiC2QFh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 12:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiC2QFf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 12:05:35 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E8926ACC
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 09:03:52 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 91E45108F38;
        Tue, 29 Mar 2022 12:03:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MhaLCaHwRuAFm9+7X64t/mRyXuW7TOw98upGm3
        DrI5A=; b=xAGdXv/6gwg2hG+J8s6PjlG56LMUNbjxWx+JyynS4Z26CJYS26gKAW
        P1Duk6buXDfZ8MVJLcI687qBUzs7hHd+OrFoi003HXnZjCOae/MEKMqCDIR7E9Up
        IELbx4qJa+96a6zsV5XkOkKQfy9XZO8RZd4qOpdJISoF6H7VI4qa0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 89B19108F37;
        Tue, 29 Mar 2022 12:03:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E00E2108F35;
        Tue, 29 Mar 2022 12:03:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org, Fernando Ramos <greenfoo@u92.eu>,
        davvid@gmail.com, sunshine@sunshineco.com, seth@eseth.com,
        rogi@skylittlesystem.org
Subject: Re: [PATCH] fixup! vimdiff: add tool documentation
References: <xmqqy20ty3k6.fsf@gitster.g>
        <20220329125400.63337-1-levraiphilippeblain@gmail.com>
Date:   Tue, 29 Mar 2022 09:03:49 -0700
In-Reply-To: <20220329125400.63337-1-levraiphilippeblain@gmail.com> (Philippe
        Blain's message of "Tue, 29 Mar 2022 08:54:00 -0400")
Message-ID: <xmqqtubgwxsq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D31CAECC-AF79-11EC-B0FC-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>
> Hi Junio, Fernando,
>
> I think the canonical Asciidoc way would be to use a listing block
> (start and end the block with '----', and not indenting the lines
> at all, as is done in a few places in the docs), but in this case
> the parser gets confused about the several dashes in the content of
> the block. So we can use a "literal block" instead [1].
>
> [1] https://docs.asciidoctor.org/asciidoc/latest/verbatim/literal-blocks/

Thanks, will queue on top (without squashing) for now, expecting
that Fernando may want to send in another round of updates (and if
it turns out that this is the only fix-up we need, then we can just
squash it in later before merging the topic to 'next').

