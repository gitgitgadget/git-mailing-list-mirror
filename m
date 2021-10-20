Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27179C433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 19:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04A3A61212
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 19:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhJTTYN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 15:24:13 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56181 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhJTTYN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 15:24:13 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5BF2615F302;
        Wed, 20 Oct 2021 15:21:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3TEuA5OSr50I9mqxTVu7A5aK8fqOzPNrcQWt9d
        18l58=; b=bF3qggCF+ZIyDviNnxtMxpLOUjrA/TmhUTXL+4LYtCLIliSMN1wtSN
        ajDCoPORN20KbMhxPRbrVE8uZGg2cliGKYTnKRLzWm8tXjWQYaqtGxNXmURnEArA
        2IuGSvQamdQ33NgdXWLJRJK0VQf9u4RRF7ekFVCtiMbdNqFrEdVis=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 556BA15F301;
        Wed, 20 Oct 2021 15:21:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BA35615F2FA;
        Wed, 20 Oct 2021 15:21:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PoC] mailmap and trailers
References: <YW8A5FznqLYs7MqH@coredump.intra.peff.net>
Date:   Wed, 20 Oct 2021 12:21:54 -0700
In-Reply-To: <YW8A5FznqLYs7MqH@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 19 Oct 2021 13:31:16 -0400")
Message-ID: <xmqq4k9bpkml.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FCEE8F9E-31DA-11EC-8B7E-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> What's here should work reliably, I think, but is pretty incomplete:
>
>   - it only works for %(trailers). We'd probably want a
>     "--mailmap-trailers" options to affect --pretty=medium, etc. That
>     code would probably go in pretty.c:pp_remainder()

Yup, that would make it much more useful.

> Anyway, here it is. I'm not sure if I'll push it forward more, but
> certainly anybody interested is welcome to pick it up and run with it. I
> mostly wanted to show how much and where such code would be, and see how
> it performed.

Nice.

Thanks.
