Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D04FC433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 21:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352916AbhLAVjS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 16:39:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54880 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241688AbhLAVjR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 16:39:17 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B4EFFA55B;
        Wed,  1 Dec 2021 16:35:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lQdkvFwi76hpyb6cILhsOASSv7r79ncNSrS53F
        9if6g=; b=fGgxtd4TRkVj2uGsGYr+cID9y9ysLsp6Rlv54MUxVpBhapaHIRSRwM
        VM/GnmgOFHUlQfySsUJLtSTvJUWYh4sm0l1QwfuytKzzjH9lb3QCbWMxSi5wAJrP
        qSZBz5G9NOFXBM5hYiFuSAK+wJs2fPxtwzfUb4WJ784W0G/CWcEGg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 40F01FA55A;
        Wed,  1 Dec 2021 16:35:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AC3ABFA559;
        Wed,  1 Dec 2021 16:35:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Fabian Stelzer <fs@gigacodes.de>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Baruch Burstein <bmburstein@gmail.com>
Subject: Re: [PATCH] CodingGuidelines: document which output goes to stdout
 vs. stderr
References: <20211201053214.2902-1-sunshine@sunshineco.com>
        <20211201083301.ozrhi2brjk4zx5ll@fs>
        <CAPig+cRFqO5wcZTPrpTuiBP72+6enJs+---mjT2AFAQq5ztt_w@mail.gmail.com>
Date:   Wed, 01 Dec 2021 13:35:53 -0800
In-Reply-To: <CAPig+cRFqO5wcZTPrpTuiBP72+6enJs+---mjT2AFAQq5ztt_w@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 1 Dec 2021 08:50:47 -0500")
Message-ID: <xmqqtufsypmu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9DE2FFA-52EE-11EC-8CCD-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> However, I can certainly change these to say "Git command" if you
> think it would make the intent clearer, and can update the final point
> to say:
>
>     Error messages from Git commands should always
>     be sent to the stderr stream.

In an earlier round, I think there was a version without "should" in
there, but I am sure we have bugs that do not follow the guideline.
The proposed phrasing sounds good to me.

Thanks.
