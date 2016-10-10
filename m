Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6120C20989
	for <e@80x24.org>; Mon, 10 Oct 2016 19:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751749AbcJJTTw (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 15:19:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54777 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751710AbcJJTTv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 15:19:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 69B1245BA5;
        Mon, 10 Oct 2016 15:14:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v8D5S7aScCiLFcoDI8WHFCJ+v4Q=; b=qxIxaI
        clwQRQxnGRKuSugVKHyIZeUXiI1vJ2p7LYs26u+4Mmwhs4Lp9RCopN7ZWvJpRdP9
        OMuS6kMqoGCXkbDcXkmYzIKaVTI5pnICvu262ADNZGmtMLK4VgrBOnUm+A1oigA9
        rJxttKHeCxLyY+bHLFJ1C2xjvOcXxw+mDKlqI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O42+kg/tudPfhrKqcuxvV4GePZGHtlFX
        MM7OP0KTZjsI5DMGKCcsOCJgXFsDCSowHyMdcKZtT79UeiQNVSFDX22wQ5ebmTjR
        Gu7d0rh3EhyZi/gvbpK+4YmInbXmw/RZgBzv/FO8/k3IIv5sXmAf9BdftxFHa2tz
        6YQL74WnwU4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 61FEC45BA4;
        Mon, 10 Oct 2016 15:14:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D25BD45BA3;
        Mon, 10 Oct 2016 15:14:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
Subject: Re: [PATCH] clean up confusing suggestion for commit references
References: <20161007095638.GA55445@book.hvoigt.net>
        <20161007143200.qw77pdsymbdmjhbw@sigill.intra.peff.net>
        <xmqqh98kf4fy.fsf@gitster.mtv.corp.google.com>
        <20161010182623.hsczlsfc6oaa2byj@sigill.intra.peff.net>
Date:   Mon, 10 Oct 2016 12:14:14 -0700
In-Reply-To: <20161010182623.hsczlsfc6oaa2byj@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 10 Oct 2016 14:26:23 -0400")
Message-ID: <xmqqoa2sdnjt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BCFB1C6E-8F1D-11E6-AD7A-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Oct 10, 2016 at 11:24:01AM -0700, Junio C Hamano wrote:
>
>> I no longer have preference either way myself, even though I was in
>> favor of no-quotes simply because I had an alias to produce that
>> format and was used to it.
>
> I'll admit that I don't care _that_ much and am happy to leave it up to
> individual authors, as long as nobody quotes SubmittingPatches at me as
> some kind of gospel when I use the no-quotes form.

;-).  

I just do not want to hear "gitk (or was it git-gui) produces quoted
form, why are you recommending no-quoted form in SubmittingPatches?"

I'd say "use common sense; sometimes it is less confusing to read
without quotes and it is perfectly OK to do so if that is the case".

