Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 499541F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 21:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfHMVIO (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 17:08:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50196 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfHMVIO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 17:08:14 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 04DA515C420;
        Tue, 13 Aug 2019 17:08:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vWluxzPD0Mqgb+LJn8FxIXzYEu8=; b=Zl5ePX
        VdBDzzUhX9srBbNuzzSOWYUfgF2PAS/6IACDmycqpVYczZ4OsbEq5Y6j8R+hKRsc
        /Cgb0JC1pAGKD4eDvNZxG++rWggXnKqD4H5HIqESMC9yZnskN8G0PImnPtk+OO/B
        aK7Kq6sRz9P7T4hfe0K0szkAUKgTbaw0OQur0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AiyQbCY7ZQ89cunM5V3PW+s43d4n4Fjs
        R45ejOnXQ5jYIHFowd4gOlDcZyG8ljc4IGsVjKYEdjsWdjr3HJr10em0PLkJLVJO
        9kBbdfgCdlMvOEJLt3gZ4eXtiOScWHbWBItSKdrroaZ6QMREU5UXrJ6vf0DeuzxX
        rFFw0suV6fQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EFC4315C41E;
        Tue, 13 Aug 2019 17:08:11 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6383215C41D;
        Tue, 13 Aug 2019 17:08:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        jnareb@gmail.com, pclouds@gmail.com, carenas@gmail.com,
        avarab@gmail.com
Subject: Re: [PATCH v4 0/6] Create 'feature.*' config area and some centralized config parsing
References: <pull.292.v3.git.gitgitgadget@gmail.com>
        <pull.292.v4.git.gitgitgadget@gmail.com>
        <xmqqmugc7p6e.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 13 Aug 2019 14:08:10 -0700
In-Reply-To: <xmqqmugc7p6e.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 13 Aug 2019 14:04:09 -0700")
Message-ID: <xmqqimr07ozp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 750EEEDA-BE0E-11E9-BF88-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>>  * Update docs and 0 constant in feature.experimental around
>>    merge.directoryRenames.
>
> I somehow thought that the concensus was that *.experimental is for
> things that should become the future default, and this one is not
> something we would want to make the default.

Ah, I see merge.directoryRenames is gone.  Sorry for a confusion.



