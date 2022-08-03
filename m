Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E694C19F2B
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 22:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238692AbiHCWci (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 18:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiHCWcg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 18:32:36 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BCA229
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 15:32:36 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 879911B8808;
        Wed,  3 Aug 2022 18:32:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s0Om1irOLqW4qp1zXs2XqNSthVZqNfrz8jRL/P
        AncM4=; b=d+RIsm7m/kVf+MixGqzue4SEDykzsMEc9GWZnmkn0mC4P2g5YA5eBp
        fgCB2/vNqgQTTP9uTUuwAW029RHaqlTPwtz7xsAQOZP5Ht1XpEmae1bz5Q3bnGIR
        nz5bmvUHNvojgDC9IqCEC3FIleSygNVePZFiuNTjdCHt6KtSPkwHg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 805511B8807;
        Wed,  3 Aug 2022 18:32:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2EDB51B8806;
        Wed,  3 Aug 2022 18:32:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     git@vger.kernel.org, Johan Herland <johan@herland.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Christian Hesse <mail@eworm.de>
Subject: Re: [RFC PATCH 1/2] notes: support fetching notes from an external
 repo
References: <20220802075401.2393-1-vegard.nossum@oracle.com>
        <xmqqczdiirh8.fsf@gitster.g>
        <69fd9dcf-7769-6c5c-ca0e-ea61e6d616d9@oracle.com>
Date:   Wed, 03 Aug 2022 15:32:30 -0700
In-Reply-To: <69fd9dcf-7769-6c5c-ca0e-ea61e6d616d9@oracle.com> (Vegard
        Nossum's message of "Wed, 3 Aug 2022 10:09:03 +0200")
Message-ID: <xmqq35ed7ybl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A218A56-137C-11ED-8323-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vegard Nossum <vegard.nossum@oracle.com> writes:

>> My gut reaction is that I am not interested at all in the above
>> approach, even though the problem you are trying to solve is
>> interesting.  Mostly because notes are not the only decorations your
>> users may want.  What if you want to "log --decorate" their
>> repository contents with your own tags that annotate their commits?
>> A notes-only approach to mix repositories is way too narrow.
> ...
> To be clear, are you saying there is no way you would ever take my
> patches in their current form,

Correct.

> Just to provide a bit more background: These two patches are just the
> first two in a bigger project to make extensive use of git notes to
> provide added value to the whole Linux kernel community ...

I already said that the problem being solved is interesting.  The
fact that a solution aims to address a problem worth solving does
not diminish the need for the solution to be sensibly designed,
and I again already said that an approach to special case notes ref
specially is unwanted.

Thanks.


