Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510A8CCA479
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 16:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbiGMQbg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 12:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiGMQbf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 12:31:35 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449D422BCE
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 09:31:35 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CC4471AE7E4;
        Wed, 13 Jul 2022 12:31:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OPqUxDwPsqyQgBgG3T3WvvziQsU4fK9ygUodbq
        wR5Zs=; b=CD1iFr8hSSY6m1ikYtNgGZXvMFVkDOg4VEZDB1toUMFGoQmm1MU4yI
        YIgB8iU5bd+ijJeLCITRnTcLYPD/M5355aImLuiwEVwBIotIT0wu2GceixPJ7/Yd
        zh8OFPKRP5WzS99qSt8pc9TgdJUa4y3RC5AkWbqjA68R/FY5a+9sw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C56801AE7E3;
        Wed, 13 Jul 2022 12:31:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 722D71AE7E2;
        Wed, 13 Jul 2022 12:31:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2022, #03; Mon, 11)
References: <xmqqo7xufee7.fsf@gitster.g>
        <dfe0c1ab-33f8-f13e-71ce-1829bb0d2d7f@iee.email>
Date:   Wed, 13 Jul 2022 09:31:30 -0700
In-Reply-To: <dfe0c1ab-33f8-f13e-71ce-1829bb0d2d7f@iee.email> (Philip Oakley's
        message of "Tue, 12 Jul 2022 23:29:21 +0100")
Message-ID: <xmqq4jzldlel.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40A84F76-02C9-11ED-9E2C-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> I'm expecting to do a re-roll for both these, though I'm just recovering
> from an infection.
> If you could hold off for a few days that would be great.

Be well soon and take care of yourself.

Thanks, will relabel them to "Expecting a reroll".
