Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588CEEB64DA
	for <git@archiver.kernel.org>; Tue,  4 Jul 2023 21:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjGDV5D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jul 2023 17:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjGDV5C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2023 17:57:02 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D55DE75
        for <git@vger.kernel.org>; Tue,  4 Jul 2023 14:57:01 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 032B119B81B;
        Tue,  4 Jul 2023 17:56:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fCLDXRIxcinxYNRTsXdYdaoCPH7Ww32k3avLx6
        ANAn4=; b=v8w1H0UQWheP7r8oefYqjCXWPXumLu1crYiCcWO10HTumfU9pc/Oel
        ZIx/byvyIMK0rpJTjl6m/kr5faSsaB2ML570Qyjbr99l9/i/Mu0E6qREhT6ie2oe
        pzow099pYm3UPBRAIGDnetpIXsrVY31c41F3BQAlchCL0ki9dwRNk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED23A19B81A;
        Tue,  4 Jul 2023 17:56:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5625C19B819;
        Tue,  4 Jul 2023 17:56:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2023, #08; Fri, 30)
References: <xmqq5y747l16.fsf@gitster.g>
        <CAP8UFD1CfUm+9PTXO0wBBdBs0U=YVte+EiPbDyUyg7T152aw2g@mail.gmail.com>
Date:   Tue, 04 Jul 2023 14:56:57 -0700
In-Reply-To: <CAP8UFD1CfUm+9PTXO0wBBdBs0U=YVte+EiPbDyUyg7T152aw2g@mail.gmail.com>
        (Christian Couder's message of "Tue, 4 Jul 2023 11:34:02 +0200")
Message-ID: <xmqqmt0b49xy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B2A66D2E-1AB5-11EE-9EC8-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> * ks/ref-filter-signature (2023-06-06) 2 commits
>>  - ref-filter: add new "signature" atom
>>  - t/lib-gpg: introduce new prereq GPG2
>>
>>  The "git for-each-ref" family of commands learned placeholders
>>  related to GPG signature verification.
>>
>>  Needs review.
>>  source: <20230604185815.15761-1-five231003@gmail.com>
>
> I took another look at the v3 at:
>
> https://lore.kernel.org/git/20230604185815.15761-1-five231003@gmail.com/
>
> which properly addresses the comments made by Eric and Oswald on the
> v2 and looks great to me.

Thanks.  I'll take it as an Ack then.
