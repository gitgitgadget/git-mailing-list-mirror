Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6CDC04E69
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 16:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjGaQBX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 12:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjGaQBT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 12:01:19 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DAC171F
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 09:01:15 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 545EC19AA8;
        Mon, 31 Jul 2023 12:01:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zN1/GqdnjhMFIEKRdpF+QDrmO8IGWknBLUvjaz
        L0XAk=; b=U7dVPvt094mL85lUs/rFYNf+DRH/OmdA7CVoIDAE8HblwNegAFoR0s
        jpD62f/frd8zFMbAXP1gRCbLh3VqwqoTmiQXMdwUG4WtFh4bBuPU+ey740GuGH4G
        WnPvaykXl+bn+iYZjXGwr8SMtxA3aYyCc1GtNN8SKcYy5wFjfj3Yw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4D85F19AA7;
        Mon, 31 Jul 2023 12:01:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B49BC19AA3;
        Mon, 31 Jul 2023 12:01:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Majer <adamm@zombino.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: sha256 is no longer experimental
References: <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>
        <ZLlNtbAbVcYH7eFb@adams> <xmqqr0p230rj.fsf@gitster.g>
        <d8ba032f-51bc-0bab-fd24-25dea0d56966@zombino.com>
        <ZMe6KmzZGVubYpvO@adams>
Date:   Mon, 31 Jul 2023 09:01:10 -0700
In-Reply-To: <ZMe6KmzZGVubYpvO@adams> (Adam Majer's message of "Mon, 31 Jul
        2023 15:42:02 +0200")
Message-ID: <xmqqr0ooyss9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 783B0CCE-2FBB-11EE-BA24-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Majer <adamm@zombino.com> writes:

> +Note: At present, there is no interoperability between SHA-256
> +repositories and SHA-1 repositories.
> +
> +Historically, we warned that SHA-256 repositories may later need
> +backward incompatible changes when we introduce such interoperability
> +features. Today, we only expect compatible changes. Furthermore, if such
> +changes prove to be necessary, it can expected that SHA-256 repositories

"can BE expected" (will tweak locally while queueing; no need to resend).

> +created with today's Git will be usable by future versions of Git
> +without data loss.

Will queue.  Thanks!
