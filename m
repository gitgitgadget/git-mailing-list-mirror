Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B53C001B0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 16:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjHJQE3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 12:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjHJQD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 12:03:57 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A91C2D4F
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 09:03:56 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 541D719A290;
        Thu, 10 Aug 2023 12:03:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mM5ldpctVltxnF7OvR0mfQxk9J1dFlbEi7kG5F
        tWAIs=; b=OtRFp8KD/avMGY4RFUPRNpqD93Dl9zr6OB3BMDNhxgiWps0gX5ph0e
        uZ3w/EkAFEB/LcitTukZjbTNxqiyQffkmlB74EBpY8Jjz4p7RXsajXRdXPc8QZ7v
        4ZD68/6J1HSzCEixGE2gIgjXYzgibHSYJkBdeS23spE/UL9O6hwSA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 40C5119A28F;
        Thu, 10 Aug 2023 12:03:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 988B519A28E;
        Thu, 10 Aug 2023 12:03:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3] rebase: clarify conditionals in todo_list_to_strbuf()
References: <20230428125601.1719750-1-oswald.buddenhagen@gmx.de>
        <20230807170935.2336745-1-oswald.buddenhagen@gmx.de>
        <xmqqv8dqd2bh.fsf@gitster.g> <ZNO7IVphPf8KOC3Q@ugly>
        <xmqqbkfgm2di.fsf@gitster.g> <ZNTTTAtNE2/DY9vT@ugly>
Date:   Thu, 10 Aug 2023 09:03:54 -0700
In-Reply-To: <ZNTTTAtNE2/DY9vT@ugly> (Oswald Buddenhagen's message of "Thu, 10
        Aug 2023 14:08:44 +0200")
Message-ID: <xmqqleeihok5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 820A668A-3797-11EE-A626-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> On Wed, Aug 09, 2023 at 12:39:37PM -0700, Junio C Hamano wrote:
>>Thanks.  Then this patch is still a strict "Meh" to me.
>>
> i can't really think of a reason why you reject such a no-brainer
> other than that you consider it churn. in that case i need to tell you
> that you have unreasonable standards, which actively contribute to the
> code remaining a mess.

An ad-hominem remark is a signal that it is good time to disengage.

There are certain style differences that may be acceptable if it
were written from the get-go, but it is not worth the patch churn to
switch once it is in the tree.  This one squarely falls into that
category.

Bye.

