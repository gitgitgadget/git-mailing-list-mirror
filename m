Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A585DC25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 20:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241681AbiHQUFP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 16:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241700AbiHQUFO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 16:05:14 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715F55A833
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 13:05:10 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6B69C1B3708;
        Wed, 17 Aug 2022 16:05:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=St4PaZkPraTPkr3rTssTLiFbowT3r5Pzsn0BEj
        ZjjnU=; b=sswn+Yqjh4ATK/WQhX26NC0CrHt6yUBkp8hKYyUsV5dcLiARifdECQ
        KxepuIyvJSZNfw49N0ZCFE2mToydTZkv/+dklI5En3FIgw28pCSWdOx/X6AAqDcE
        lMwBoEisHAVeBVv1Sn63/c59v1UkbthiS4PlI/UuNBk66cEY39spE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 658FF1B3707;
        Wed, 17 Aug 2022 16:05:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8344F1B3702;
        Wed, 17 Aug 2022 16:05:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: js/bisect-in-c, was Re: What's cooking in git.git (Aug 2022,
 #05; Mon, 15)
References: <xmqq5yityzcu.fsf@gitster.g>
        <p053rrpq-17q7-pnrs-3794-o04ro1445s5s@tzk.qr>
        <CABPp-BFAERLt_z-D=7gbXWVA9JgsqTP_2iW9BLe5S=YbsQ1V6w@mail.gmail.com>
        <xmqqtu6avgub.fsf@gitster.g>
        <CABPp-BHBOqnU7DSLkYPig=c6+emWGaE1vdzaPk0D90yQdof+6A@mail.gmail.com>
Date:   Wed, 17 Aug 2022 13:05:03 -0700
In-Reply-To: <CABPp-BHBOqnU7DSLkYPig=c6+emWGaE1vdzaPk0D90yQdof+6A@mail.gmail.com>
        (Elijah Newren's message of "Wed, 17 Aug 2022 12:24:57 -0700")
Message-ID: <xmqq35duvdow.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E24D2D42-1E67-11ED-AAF6-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Ah, gotcha.  My impression was that the exit codes did match what the
> previous shell code had done, but didn't match what other builtins
> usually return.  Perhaps I misread those discussion comments.

Or perhaps I did ;-)

The topic has been waiting for the finishing polish for so long that
I do not remember the details of the discussion offhand, certainly
not better than I did when I left the note in the "What's cooking"
report.

