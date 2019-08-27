Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD14D1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 19:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbfH0Tqc (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 15:46:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60336 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730035AbfH0Tqb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 15:46:31 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9924015AE0F;
        Tue, 27 Aug 2019 15:46:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fyriC3oaAm+oqdMuAJ9BFIR2opY=; b=LZ9oXn
        71egh4bxbDRVB+LYJ4vWm9QX4XVIA8dFceWegnVXQJXHeaazUYXxoYJ3UkpSqTTN
        B7fns6rUExgH4zNZ6BPFHdWv/gz8+2T4759OghE1FLW49DNpvlPcm+6Pg3SstgVh
        WbbnKsxZbjLCQh3oMISsOA9KZsoGFU2pHeOc8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iB1A8Vw3PrMZAJUsDrDHHl2Md3Fl/jX9
        wUI9fze6H4YW3PRvJpthEO4xhuH6svkyujloZwIm/HZSylB6TYka+N7idcPokmkA
        tvdva4fnkeVXGtabnDkjc8md32fJXMvvSy0jNpfWHqAVzwU+PQuKflr8u8Gi9Sqx
        wqykGEcsLpE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9253615AE0E;
        Tue, 27 Aug 2019 15:46:29 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 07CFF15AE0D;
        Tue, 27 Aug 2019 15:46:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, Andrey Portnoy <aportnoy@ucsd.edu>,
        Andrey Portnoy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/1] banned.h: fix vsprintf warning
References: <pull.322.git.gitgitgadget@gmail.com>
        <xmqqwoezj3o5.fsf@gitster-ct.c.googlers.com>
        <20190826183317.GB23399@sigill.intra.peff.net>
        <20190826184022.GA30349@syl.lan>
Date:   Tue, 27 Aug 2019 12:46:27 -0700
In-Reply-To: <20190826184022.GA30349@syl.lan> (Taylor Blau's message of "Mon,
        26 Aug 2019 14:40:22 -0400")
Message-ID: <xmqqv9ui2xyk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5CCC687A-C903-11E9-A278-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> ... My patch has a few
> more details such as blame information (and how the typo was only made
> in the explicit version, not the variadic form), so it may be worthwhile
> to take that instead of this, but I don't mind either way.

Yup, that was exactly why I took that version (after tentatively
queuing the other one, but discarded before pushing the integration
result out).

Thanks, all.

>> I don't know if we want to try to spread credit around via trailers.
>> "Racily-implemented-by:" ? :)

Please don't X-<.
