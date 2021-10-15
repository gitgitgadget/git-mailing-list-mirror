Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBA3C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 15:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5FCD61181
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 15:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241079AbhJOQA4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 12:00:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55986 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbhJOQA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 12:00:56 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 24EEDFEB2B;
        Fri, 15 Oct 2021 11:58:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1EoiwNOXskfHj+bhkEgJyLnpQ5S2XgwU3EMHOa
        FKM2g=; b=v3ANQHtCVLPFLyDC23cOldOdBdLQOGAjtv/VUI67NkPha0SlqVbkZ2
        BRuv38QqQcJaXewNGKzTBSlKJV91kTDj2BnRQIMSnRo+FrhsTPdAPn2VrYqlvux9
        wbELo5+e7reMU6jbCtnqAkZEME1GXSbIbi9MChycNSWytA/ABXLxE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D66CFEB2A;
        Fri, 15 Oct 2021 11:58:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 818A0FEB29;
        Fri, 15 Oct 2021 11:58:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rob Browning <rlb@defaultvalue.org>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] signature-format.txt: explain and illustrate multi-line
 headers
References: <20211009163338.2175170-1-rlb@defaultvalue.org>
        <YWRpPw4eTwTmgVvC@coredump.intra.peff.net>
        <xmqq4k9ncopr.fsf@gitster.g>
        <YWTuAOjqK6fy9ZRT@coredump.intra.peff.net>
        <xmqqzgre5glb.fsf@gitster.g> <xmqqtuhlisqe.fsf_-_@gitster.g>
        <87zgrcgpez.fsf@trouble.defaultvalue.org> <xmqq5ytzcyr6.fsf@gitster.g>
        <87v91zgjr9.fsf@trouble.defaultvalue.org>
Date:   Fri, 15 Oct 2021 08:58:47 -0700
In-Reply-To: <87v91zgjr9.fsf@trouble.defaultvalue.org> (Rob Browning's message
        of "Thu, 14 Oct 2021 20:27:22 -0500")
Message-ID: <xmqqa6ja9t54.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8B64F36-2DD0-11EC-A161-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rob Browning <rlb@defaultvalue.org> writes:

> Agreed.  I'd just lazily guessed it might be 822 (was also thinking of
> ...
> Ahh, right, of course.
> ...
> Indeed.
>
> Thanks

So, back to the original discussion; would the replacement
documentation update be satisfactory?

